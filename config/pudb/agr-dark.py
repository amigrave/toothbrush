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

black = 'h235'
dark_gray = 'h233'
light_gray = 'h252'

white = 'h255'
white_bold = add_setting(white, "bold")  # noqa
light_gray_bold = add_setting(light_gray, "bold")  # noqa

dark_red = 'h124'
light_red = 'h160'

ui_blue = 'h24'
deep_blue = 'h17'
dark_blue = 'h25'
light_blue = 'h111'

light_yellow = 'h192'
light_yellow_bold = add_setting(light_yellow, "bold")  # noqa

deep_green = 'h22'
dark_green = 'h64'
light_green = 'h113'

light_orange = 'h223'

dark_cyan = 'h23'
light_cyan = 'h80'

hifg = light_yellow
hifg_bold = add_setting(hifg, "bold")  # noqa
hibg = ui_blue


palette.update({  # noqa
    "header": (black, light_gray, "standout"),

    # {{{ variables view
    "variables": (black, dark_gray),
    "variable separator": (dark_cyan, light_gray),

    "var label": (light_blue, dark_gray),
    "var value": (white, dark_gray),
    "focused var label": (hifg, hibg),
    "focused var value": (hifg, hibg),

    "highlighted var label": (light_gray, deep_green),
    "highlighted var value": (white, deep_green),
    "focused highlighted var label": (light_gray, dark_green),
    "focused highlighted var value": (white, dark_green),

    "return label": (light_green, dark_gray),
    "return value": (light_green, dark_gray),
    "focused return label": (hifg_bold, hibg),
    "focused return value": (hifg, hibg),
    # }}}

    # {{{ stack view
    "stack": (black, dark_gray),

    "frame name": (light_yellow, dark_gray),
    "focused frame name": (hifg, hibg),
    "frame class": (light_blue, dark_gray),
    "focused frame class": (hifg, hibg),
    "frame location": (light_gray, dark_gray),
    "focused frame location": (hifg, hibg),

    "current frame name": (white, deep_green),
    "focused current frame name": (white, dark_green),
    "current frame class": (light_blue, deep_green),
    "focused current frame class": (white, dark_green),
    "current frame location": (light_gray, deep_green),
    "focused current frame location": (white, dark_green),
    # }}}

    # {{{ breakpoint view
    "breakpoint": (light_cyan, dark_gray),
    "focused breakpoint": (hifg, hibg),
    "current breakpoint": (white_bold, deep_green),
    "focused current breakpoint": (white_bold, dark_green),
    # }}}

    # {{{ ui widgets

    "selectable": (light_gray, black),
    "focused selectable": (white, ui_blue),

    "button": (light_gray, black),
    "focused button": (white, ui_blue),

    "background": (black, light_gray),
    "hotkey": (add_setting(black, "underline"), light_gray, "underline"),  # noqa
    "focused sidebar": (dark_cyan, light_gray, "standout"),

    "warning": (white_bold, dark_red, "standout"),

    "label": (black, light_gray),
    "value": (white, deep_blue),
    "fixed value": (light_gray, deep_blue),
    "group head": (add_setting(dark_blue, "bold"), light_gray),  # noqa

    "search box": (white, black),
    "search not found": (white, dark_red),

    "dialog title": (white_bold, black),

    # }}}

    # {{{ source view
    "breakpoint marker": (light_red, black),

    "breakpoint source": (light_gray, dark_red),
    "breakpoint focused source": (light_yellow, dark_red),
    "current breakpoint source": (light_yellow, dark_red),
    "current breakpoint focused source": (hifg_bold, dark_red),
    # }}}

    # {{{ highlighting
    "source": (white, black),
    "focused source": (hifg, hibg),
    "highlighted source": (light_gray, deep_green),
    "current source": (light_gray_bold, dark_cyan),
    "current focused source": (light_yellow_bold, dark_cyan),
    "current highlighted source": (white, deep_green),

    "line number": ("h241", black),
    "keyword": (light_blue, black),

    "literal": ("h173", black),
    "string": (light_green, black),
    "doublestring": (light_green, black),
    "singlestring": (light_green, black),
    "docstring": (light_green, black),

    "name": (light_yellow, black),
    "punctuation": (light_orange, black),
    "comment": ("h246", black),

    # }}}

    # {{{ shell
    "command line edit": (white, dark_gray),
    "command line prompt": (light_yellow_bold, dark_gray),

    "command line output": (light_cyan, dark_gray),
    "command line input": (white, dark_gray),
    "command line error": (light_red, dark_gray),

    "focused command line output": (light_yellow_bold, hibg),
    "focused command line input": (white, hibg),
    "focused command line error": (black, hibg),

    "command line clear button": (add_setting(white, "bold"), dark_gray),  # noqa
    "command line focused button": (white, ui_blue),
    # }}}
    })
