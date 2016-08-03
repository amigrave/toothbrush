import logging

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


def debug(text):
    debug_widget.text = "[%s]" % text
debug_widget = widget.TextBox(u"\u2620", name="coucou", **SYMBOL_FONT)


keys = [
    # Switch between windows in current stack pane
    Key([mod], "Tab", lazy.layout.down()),

    # Toggle between different layouts as defined below
    Key([mod], "j", lazy.next_layout()),

    # Swap panes of split stack
    Key([mod, "shift"], "j", lazy.layout.rotate()),

    Key([mod, "control"], "Return", lazy.spawn("urxvt -e ipython")),

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

    # Win+c/v == copy/paste
    # Key([mod], "c", lazy.fake_keypress("XF86Copy")),
    # Key([mod], "v", lazy.fake_keypress("XF86Paste")),
    # Key([mod], "m", lazy.simulate_keypress(["control"], "l")),
    # Key([mod], "m", lazy.simulate_keypress([], "l")),
    # Key([mod], "j", lazy.fake_keypress("d")),
    # Key([mod], "j", lazy.simulate_keypress([], "l")),
    # Key([mod], "j", lazy.fake_keypress("XF86Paste")),
    # Key([win, alt], "Right", lazy.simulate_keypress(["control"], "Tab")),
    # Key([win, alt], "Left", lazy.simulate_keypress(["control", "Shift"], "Tab")),
    # Key([win, alt], "Right", lazy.spawn('xdotool key "Alt_L+Super_L+Right"')),
    # Key([win, alt], "Left", lazy.spawn('xdotool key "Alt_L+Super_L+Left"')),
]


groups = [Group(i) for i in "12345"]

for i in groups:
    # mod1 + letter of group = switch to group
    keys.append(
        Key([mod], i.name, lazy.group[i.name].toscreen())
    )

    # TODO: find better way to move window (eg move to the left or right, that's all)
    # mod1 + shift + letter of group = switch to & move focused window to group
    # keys.append(
    #     Key([mod, "shift"], i.name, lazy.window.togroup(i.name))
    # )

groups.append(Group('term'))
keys.append(
    Key([mod], "Return", lazy.group['term'].toscreen()),
)

groups.append(Group('gvim'))
keys.append(
    Key([mod], "e", lazy.group['gvim'].toscreen()),
)

groups.append(Group('iPython'))
keys.append(
    Key([mod, alt], "Return", lazy.group['iPython'].toscreen()),
)

groups.append(Group('gimp'))
keys.append(
    Key([mod], "g", lazy.group['gimp'].toscreen()),
)

layouts = [
    layout.Max(),
    layout.Stack(num_stacks=2)
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
