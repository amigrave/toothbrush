import logging
import random
import os

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget

logger = logging.getLogger('qtile.config')

mod = "mod4"
alt = "mod1"
win = "mod4"

SCROT_ARGS = " -e 'mv $f ~/Downloads/'"

SYMBOL_FONT = {
    # http://www.iemoji.com/view
    'font': 'Symbola',
    'fontsize': 20,
}


def debug(*args):
    text = ', '.join(['[%s]' % arg for arg in args])
    debug_widget.text = text
debug_widget = widget.TextBox(u"\u2620", name="coucou", **SYMBOL_FONT)


def set_random_wallpaper(*a):
    nimg = random.randrange(1701, 2199)
    set_wallpaper('https://www.gstatic.com/prettyearth/assets/full/%s.jpg' % nimg)


def set_wallpaper(img):
    os.system('feh --bg-fill "%s" --no-fehbg' % img)


def move_window_to_adjacent_group(qtile, offset=1):
    idx = (qtile.groups.index(qtile.currentGroup) + offset) % len(qtile.groups)
    group = qtile.groups[idx]
    qtile.currentWindow.togroup(group.name)
    group.cmd_toscreen()


keys = [
    # Switch between windows in current stack pane
    Key([mod], "Tab", lazy.layout.down()),

    # Toggle between different layouts as defined below
    Key([mod], "j", lazy.next_layout()),

    # Swap panes of split stack
    Key([mod, "shift"], "j", lazy.layout.rotate()),

    Key([mod, alt, "control"], "Return", lazy.spawn("urxvt -e ipython")),

    # Key([mod], "w", lazy.window.kill()),
    Key([mod], "q", lazy.window.kill()),

    # Restart QTile
    Key([mod, "control"], "r", lazy.restart()),

    # Close QTile session
    Key([mod, "control"], "q", lazy.shutdown()),

    # Show launcher
    Key([mod], "space", lazy.spawncmd()),

    # Screenshot stuff
    Key([mod, "shift"], "3", lazy.spawn("scrot" + SCROT_ARGS)),
    Key([mod, "shift"], "4", lazy.spawn("scrot -s" + SCROT_ARGS)),
    Key([mod, "shift", "control"], "4", lazy.spawn("escrotum -sC")),

    # Multimedia keys
    Key([], "XF86AudioMute", lazy.spawn("amixer sset Master toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer sset Master 5%-")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer sset Master 5%+")),
    # Key([], "XF86AudioPlay", lazy.function(audio_play)),

    # Win+c/v == copy/paste
    # Key([mod], "c", lazy.fake_keypress("XF86Copy")),
    # Key([mod], "v", lazy.fake_keypress("XF86Paste")),

    # Key([win, alt], "Right", lazy.function(next_ta)),
    # Key([win, 'shift'], "Right", lazy.spawn("xdotool key Ctrl+Tab")),

    Key([win], "l", lazy.function(set_random_wallpaper)),

    Key([win, alt], "Prior", lazy.function(move_window_to_adjacent_group, -1)),
    Key([win, alt], "Next", lazy.function(move_window_to_adjacent_group)),
]

groups = [
    ('web1', [mod], '1', {}),
    ('web2', [mod], '2', {}),
    ('chat', [mod], '3', {}),
    ('term', [mod], 'Return', {'spawn': 'terminator'}),
    ('gvim', [mod], 'e', {}),
    ('ipy', [mod, alt], 'Return', {}),
    ('gimp', [mod], 'g', {}),
]

for i, group in enumerate(groups):
    groups[i] = Group(group[0], **group[3])
    # if group[0] == 'term':
    #     groups[i].toscreen()
    keys.append(
        Key(group[1], group[2], lazy.group[group[0]].toscreen()),
    )

layouts = [
    layout.Max(),
    layout.Stack(num_stacks=2),
    layout.verticaltile.VerticalTile(),
]

widget_defaults = dict(
    font='Arial',
    fontsize=16,
    padding=3,
)

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),

                debug_widget,

                widget.Sep(),
                widget.Volume(emoji=True, **SYMBOL_FONT),

                # widget.Sep(),
                # widget.Battery(),
                # widget.TextBox(u"\U0001F50B", **SYMBOL_FONT),

                widget.Sep(),
                widget.MemoryGraph(fill_color='009933', graph_color='339966'),
                widget.CPUGraph(),

                widget.Sep(),
                widget.Systray(),

                widget.Clock(format='%Y-%m-%d %A %H:%M'),
            ],
            30,
        ),
    ),
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
wmname = "qtile"

# Set initial wallpaper
set_wallpaper('/usr/share/images/desktop-base/kali-wallpaper_1920x1080.png')
