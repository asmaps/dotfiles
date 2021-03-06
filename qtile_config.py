# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess
import re
import logging

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook


def spawn_with_env_lazy(command, env):
    def spawn_env():
        subprocess.Popen(command.split(' '), env=env)

    return spawn_env


mod = "mod4"
alt = "mod1"
home = os.path.expanduser('~')

keys = [
    Key(
        [mod, "control"], "1",
        lazy.spawn("sh -c " + home + "/.screenlayout/1screen.sh"),
    ),
    Key(
        [mod, "control"], "2",
        lazy.spawn("sh -c " + home + "/.screenlayout/2screens.sh"),
    ),
    Key(
        [mod, "control", "shift"], "2",
        lazy.spawn("sh -c " + home + "/.screenlayout/2screens_ja.sh"),
    ),
    Key(
        [mod, "control"], "3",
        lazy.spawn("sh -c " + home + "/.screenlayout/3screens.sh"),
    ),
    Key(
        [mod, "control", "shift"], "3",
        lazy.spawn("sh -c " + home + "/.screenlayout/3screens_full.sh"),
    ),

    # Switch between windows in current stack pane
    Key(
        [mod], "k",
        lazy.layout.right()
    ),
    Key(
        [mod], "j",
        lazy.layout.left()
    ),

    # Move windows up or down in current stack
    Key(
        [mod, "control"], "k",
        lazy.layout.shuffle_left()
    ),
    Key(
        [mod, "control"], "j",
        lazy.layout.shuffle_right()
    ),
    Key(
        [mod, "control"], "h",
        lazy.layout.grow_left()
    ),
    Key(
        [mod, "control"], "l",
        lazy.layout.grow_right()
    ),

    Key([alt], "Tab", lazy.layout.next()),
    Key([alt, "shift"], "Tab", lazy.layout.previous()),

    # Switch window focus to other pane(s) of stack
    Key(
        [mod], "space",
        lazy.layout.next()
    ),

    # Swap panes of split stack
    Key(
        [mod, "shift"], "space",
        lazy.layout.rotate()
    ),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"], "Return",
        lazy.layout.toggle_split()
    ),
    Key([mod], "Return", lazy.spawn("terminator")),
    Key(["control", "mod1"], "l", lazy.spawn("xscreensaver-command -lock")),
    Key([], "XF86AudioMute", lazy.spawn("pavucontrol")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight -inc 3")),
    Key(["shift"], "XF86MonBrightnessUp", lazy.spawn("xbacklight -set 100")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 3")),
    Key(["shift"], "XF86MonBrightnessDown", lazy.spawn("xbacklight -set 1")),
    Key([], "XF86LaunchA", lazy.spawn("xinput set-prop 11 \"Device Enabled\" 0")),
    Key(["shift"], "XF86LaunchA", lazy.spawn("xinput set-prop 11 \"Device Enabled\" 1")),
    Key(['mod1', "control"], "p", lazy.spawn('/home/asmaps/pycharm/pycharm.sh')),
    Key(['mod1', "control"], "o", lazy.spawn('/home/asmaps/git/openclonk/openclonk')),
    Key(['mod1', "shift", "control"], "o", lazy.spawn('/home/asmaps/openclonk/openclonk --editor')),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "w", lazy.window.kill()),

    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod], "r", lazy.spawncmd()),
    Key([mod, "control"], "space", lazy.window.toggle_floating()),
    Key([], "Print", lazy.spawn("bash /home/asmaps/.take_screenshot.sh")),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    # mod1 + letter of group = switch to group
    keys.append(
        Key([mod], i.name, lazy.group[i.name].toscreen())
    )

    # mod1 + shift + letter of group = switch to & move focused window to group
    keys.append(
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name))
    )

layouts = [
    layout.columns.Columns(border_width=1),
    layout.Max(),
    layout.floating.Floating(),
]

widget_defaults = dict(
    font='Arial',
    fontsize=12,
    padding=3,
)


def getIp():
    import requests
    try:
        r = requests.get("http://ipv4.nsupdate.info/myip")
        return r.text
    except:
        return 'No IPv4'


def getIpv6():
    import requests
    try:
        r = requests.get("http://ipv6.nsupdate.info/myip")
        return r.text
    except:
        return 'No IPv6'

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(),
                widget.Prompt(),
                widget.TaskList(),
                widget.Systray(),
                widget.Wallpaper(directory=home + '/Pictures/wallpapers/'),
                widget.Clock(format='%a %d.%m. %H:%M'),
            ],
            25,
        ),
        bottom=bar.Bar(
            [
                widget.WindowName(),
                widget.Notify(default_timeout=10),
                widget.GenPollText(func=getIpv6),
                widget.Sep(),
                widget.GenPollText(func=getIp),
                widget.Sep(),
                widget.ThermalSensor(tag_sensor='Core 0'),
                widget.ThermalSensor(tag_sensor='temp1'),
                widget.Sep(),
                widget.Memory(fmt="{MemAvailable}M"),
                widget.DF(),
                widget.Sep(),
                widget.Battery(),
                widget.Battery(battery_name='BAT1'),
                widget.Sep(),
                widget.CurrentLayout(),
            ],
            15,
        ),
    ) for i in range(3)
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating()
auto_fullscreen = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, github issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"


def is_running(process):
    s = subprocess.Popen(["ps", "axuw"], stdout=subprocess.PIPE)
    if isinstance(process, list):
        process = process[0]

    for x in s.stdout:
        if re.search(process.encode(), x):
            return True
    return False


def execute_once(process):
    if not is_running(process):
        logging.getLogger('libqtile').warning('Starting ' + str(process))
        return subprocess.Popen(process)
    else:
        logging.getLogger('libqtile').warning(str(process) + ' already running. Not starting it')


@hook.subscribe.startup
def startup():
    execute_once('nm-applet')
    execute_once('blueman-applet')
    execute_once(['xscreensaver', '-nosplash'])
