"""draw kitty tab"""
# pyright: reportMissingImports=false
# pylint: disable=E0401,C0116,C0103,W0603,R0913

import datetime

from kitty.fast_data_types import Screen, get_options
from kitty.tab_bar import (DrawData, ExtraData, TabBarData, as_rgb,
                           draw_tab_with_powerline)
from kitty.utils import color_as_int

opts = get_options()



CLOCK_FG = as_rgb(color_as_int(opts.color7))
CLOCK_BG = as_rgb(color_as_int(opts.color15))
DATE_FG = as_rgb(color_as_int(opts.color0))
DATE_BG =  as_rgb(color_as_int(opts.color16))


CLOCK_FG = as_rgb(color_as_int(opts.color16))
CLOCK_BG = as_rgb(color_as_int(opts.color15))
DATE_FG = as_rgb(color_as_int(opts.color7))
DATE_BG =  as_rgb(color_as_int(opts.color8))


CLOCK_FG = as_rgb(color_as_int(opts.color16))
CLOCK_BG = as_rgb(color_as_int(opts.color7))
DATE_FG = as_rgb(color_as_int(opts.color15))
DATE_BG =  as_rgb(color_as_int(opts.color8))

CLOCK_FG = as_rgb(color_as_int(opts.inactive_tab_foreground))
CLOCK_BG = as_rgb(color_as_int(opts.inactive_tab_background))
DATE_FG = as_rgb(color_as_int(opts.color0))
DATE_BG =  as_rgb(color_as_int(opts.color8))




def _draw_right_status(screen: Screen) -> int:
    cells = [
        (CLOCK_BG, 0, ""),
        (CLOCK_FG, CLOCK_BG, datetime.datetime.now().strftime(" %H:%M ")),
        (DATE_BG, CLOCK_BG, ""),
        (DATE_FG, DATE_BG, datetime.datetime.now().strftime(" %Y-%m-%d")),
    ]

    right_status_length = 0
    for _, _, cell in cells:
        right_status_length += len(cell)

    draw_spaces = screen.columns - screen.cursor.x - right_status_length
    if draw_spaces > 0:
        screen.draw(" " * draw_spaces)

    for fg, bg, cell in cells:
        screen.cursor.fg = fg
        screen.cursor.bg = bg
        screen.draw(cell)
    screen.cursor.fg = 0
    screen.cursor.bg = 0

    screen.cursor.x = max(screen.cursor.x, screen.columns - right_status_length)
    return screen.cursor.x


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    # Set cursor to where `left_status` ends, instead `right_status`,
    # to enable `open new tab` feature
    end = draw_tab_with_powerline(
        draw_data,
        screen,
        tab,
        before,
        max_title_length,
        index,
        is_last,
        extra_data,
    )
    if is_last:
        _draw_right_status(screen)
    return end
