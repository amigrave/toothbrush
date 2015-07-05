# Supported 16 color values:
#   'h0' (color number 0) through 'h15' (color number 15)
#    or
#   'default' (use the terminal's default foreground),
#   'black', 'dark red', 'dark green', 'brown', 'dark blue',
#   'dark magenta', 'dark cyan', 'light gray', 'dark gray',
#   'light red', 'light green', 'yellow', 'light blue',
#   'light magenta', 'light cyan', 'white'
#
# Supported 256 color values:
#   'h0' (color number 0) through 'h255' (color number 255)
#
# 256 color chart: http://en.wikipedia.org/wiki/File:Xterm_color_chart.png
#
# "setting_name": (foreground_color, background_color),

# See pudb/theme.py
# (https://github.com/inducer/pudb/blob/master/pudb/theme.py) to see what keys
# there are.

# Note, be sure to test your theme in both curses and raw mode (see the bottom
# of the preferences window). Curses mode will be used with screen or tmux.

white_bold = add_setting('white', "bold")  # noqa

dark_red = 'h124'

deep_blue = 'h17'
dark_blue = 'h25'
light_blue = 'h111'

light_yellow = 'h192'
light_yellow_bold = add_setting(light_yellow, "bold")  # noqa

dark_green = 'h22'
light_green = 'h113'

light_orange = 'h223'

dark_cyan = 'h23'

hifg = light_yellow
hifg_bold = add_setting(hifg, "bold")  # noqa
hibg = dark_blue


palette.update({  # noqa
    "header": ("black", "light gray", "standout"),

    # {{{ variables view
    "variables": ("black", "dark gray"),
    "variable separator": ("dark cyan", "light gray"),

    "var label": (light_blue, "dark gray"),
    "var value": ("white", "dark gray"),
    "focused var label": (hifg, hibg),
    "focused var value": (hifg, hibg),

    "highlighted var label": ("light gray", dark_green),
    "highlighted var value": ("white", dark_green),
    "focused highlighted var label": ("light gray", "dark green"),
    "focused highlighted var value": ("white", "dark green"),

    "return label": (light_green, "dark gray"),
    "return value": (light_green, "dark gray"),
    "focused return label": (hifg_bold, hibg),
    "focused return value": (hifg, hibg),
    # }}}

    # {{{ stack view
    "stack": ("black", "dark gray"),

    "frame name": (light_yellow, "dark gray"),
    "focused frame name": (hifg, hibg),
    "frame class": (light_blue, "dark gray"),
    "focused frame class": (hifg, hibg),
    "frame location": ("light gray", "dark gray"),
    "focused frame location": (hifg, hibg),

    "current frame name": ("white", dark_green),
    "focused current frame name": ("white", "dark green"),
    "current frame class": (light_blue, dark_green),
    "focused current frame class": ("white", "dark green"),
    "current frame location": ("light gray", dark_green),
    "focused current frame location": ("white", "dark green"),
    # }}}

    # {{{ breakpoint view
    "breakpoint": ("light cyan", "dark gray"),
    "focused breakpoint": (hifg, hibg),
    "current breakpoint": (white_bold, dark_green),
    "focused current breakpoint": (white_bold, "dark green"),
    # }}}

    # {{{ ui widgets

    # "selectable": ("light gray", "dark gray"),
    # "focused selectable": ("white", "light blue"),

    "button": ("light gray", "dark gray"),
    "focused button": ("white", "h31"),

    "background": ("black", "light gray"),
    # "hotkey": (add_setting("black", "underline"), "light gray", "underline"),
    "focused sidebar": (dark_cyan, "light gray", "standout"),

    "warning": (white_bold, dark_red, "standout"),

    "label": ("black", "light gray"),
    "value": ("white", 'dark gray'),
    "fixed value": ("light gray", deep_blue),

    "search box": ("white", 'dark gray'),
    "search not found": ("white", dark_red),

    "dialog title": (white_bold, deep_blue),

    # }}}

    # {{{ source view
    "breakpoint marker": ("dark red", "black"),

    "breakpoint source": ("light gray", dark_red),
    "breakpoint focused source": (white_bold, dark_red),
    "current breakpoint source": (light_yellow, dark_red),
    "current breakpoint focused source": (hifg_bold, dark_red),
    # }}}

    # {{{ highlighting
    "source": ("white", "black"),
    "focused source": (hifg, hibg),
    "highlighted source": ("light gray", dark_green),
    "current source": ("light gray", dark_cyan),
    "current focused source": (white_bold, dark_cyan),
    "current highlighted source": ("white", dark_green),

    "line number": ("h241", "black"),
    "keyword": (light_blue, "black"),

    "literal": ("h173", "black"),
    "string": (light_green, "black"),
    "doublestring": (light_green, "black"),
    "singlestring": (light_green, "black"),
    "docstring": (light_green, "black"),

    "name": (light_yellow, "black"),
    "punctuation": (light_orange, "black"),
    "comment": ("h246", "black"),

    # }}}

    # {{{ shell
    "command line edit": ("white", "black"),
    "command line prompt": (light_yellow_bold, "black"),

    "command line output": ("light cyan", "black"),
    "command line input": ("white", "black"),
    "command line error": ("light red", "black"),

    "focused command line output": (light_yellow_bold, hibg),
    "focused command line input": ("white", hibg),
    "focused command line error": ("black", hibg),
    # }}}
    })
