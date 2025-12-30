import subprocess
from os.path import expanduser

from libqtile import (
    bar,
    hook,
    layout,
    qtile,  # pyright: ignore[reportUnknownVariableType]
    widget,
)
from libqtile.config import (
    Click,
    Drag,
    DropDown,
    Group,
    Key,
    KeyChord,
    Match,
    ScratchPad,
    Screen,
)
from libqtile.lazy import lazy

from colorscheme import alabaster  # pyright: ignore[reportImplicitRelativeImport]


@hook.subscribe.startup_once  # pyright: ignore[reportUnknownMemberType]
def autostart() -> None:
    """Run autostart.sh script at the startup."""
    autostart_script = expanduser("~/.config/autostart.sh")
    _ = subprocess.call(autostart_script)


COLORSCHEME = alabaster
FONT = "Terminess Nerd Font Mono"
MOD = "mod1"
TERMINAL = "kitty"
EMAIL_CLIENT = "betterbird"
BROWSER = "zen-twilight"
SHELL = "zsh"
SHELLRC = ".zshrc"


keys = [
    Key([MOD], "h", lazy.layout.left(), desc="Move focus to left"),  # pyright: ignore[reportAny]
    Key([MOD], "l", lazy.layout.right(), desc="Move focus to right"),  # pyright: ignore[reportAny]
    Key([MOD], "j", lazy.layout.down(), desc="Move focus down"),  # pyright: ignore[reportAny]
    Key([MOD], "k", lazy.layout.up(), desc="Move focus up"),  # pyright: ignore[reportAny]
    Key(
        [MOD, "shift"],
        "h",
        lazy.layout.shuffle_left(),  # pyright: ignore[reportAny]
        desc="Move window to the left",
    ),
    Key(
        [MOD, "shift"],
        "l",
        lazy.layout.shuffle_right(),  # pyright: ignore[reportAny]
        desc="Move window to the right",
    ),
    Key([MOD, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),  # pyright: ignore[reportAny]
    Key([MOD, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),  # pyright: ignore[reportAny]
    Key([MOD, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),  # pyright: ignore[reportAny]
    Key(
        [MOD, "control"],
        "l",
        lazy.layout.grow_right(),  # pyright: ignore[reportAny]
        desc="Grow window to the right",
    ),
    Key([MOD, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),  # pyright: ignore[reportAny]
    Key([MOD, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),  # pyright: ignore[reportAny]
    Key([MOD], "n", lazy.layout.normalize(), desc="Reset all window sizes"),  # pyright: ignore[reportAny]
    Key([MOD], "Tab", lazy.layout.next(), desc="Move window focus to other window"),  # pyright: ignore[reportAny]
    # Split = all windows displayed
    # multiple stack panes
    Key(
        [MOD, "shift"],
        "Return",
        lazy.layout.toggle_split(),  # pyright: ignore[reportAny]
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([MOD], "Return", lazy.spawn(TERMINAL), desc="Launch terminal"),  # pyright: ignore[reportAny]
    Key([MOD], "space", lazy.next_layout(), desc="Toggle between layouts"),  # pyright: ignore[reportAny]
    Key([MOD], "q", lazy.window.kill(), desc="Kill focused window"),  # pyright: ignore[reportAny]
    Key(
        [MOD, "control"],
        "f",
        lazy.window.toggle_fullscreen(),  # pyright: ignore[reportAny]
        desc="Toggle fullscreen on the focused window",
    ),
    Key(
        [MOD],
        "t",
        lazy.window.toggle_floating(),  # pyright: ignore[reportAny]
        desc="Toggle floating on the focused window",
    ),
    Key([MOD, "control"], "r", lazy.reload_config(), desc="Reload the config"),  # pyright: ignore[reportAny]
    Key([MOD, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),  # pyright: ignore[reportAny]
    KeyChord(
        [MOD],
        "r",
        [
            Key([], "d", lazy.spawn("rofi -show drun"), desc="Spawn drun launcher"),  # pyright: ignore[reportAny]
            Key([], "r", lazy.spawn("rofi -show run"), desc="Spawn run launcher"),  # pyright: ignore[reportAny]
            Key(
                [],
                "t",
                lazy.spawn(
                    f"{SHELL} -c 'source {expanduser(f'~/{SHELLRC}')} && time_main'"
                ),
                desc="Spawn time launcher",
            ),
            Key(
                [],
                "b",
                lazy.spawn(
                    f"{SHELL} -c 'source {expanduser(f'~/{SHELLRC}')} && open_book'"
                ),
                desc="Spawn book launcher",
            ),
            Key(
                [],
                "s",
                lazy.spawn(
                    f"{SHELL} -c 'source {expanduser(f'~/{SHELLRC}')} && sesh_connect'"
                ),
                desc="Spawn sesh launcher",
            ),
            Key([], "w", lazy.spawn("rofi -show window"), desc="Spawn window launcher"),
            Key(
                [],
                "c",
                lazy.spawn("clipmenu"),
                desc="Spawn ssh launcher",
            ),
        ],
        mode=False,
        name="Launcher",
    ),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),  # pyright: ignore[reportAny, reportUnknownMemberType, reportUnknownLambdaType]
            desc=f"Switch to VT{vt}",
        )
    )


groups = [
    Group(
        "1",
        label="note",
        matches=[
            Match(wm_class="com.github.xournalpp.xournalpp"),
            Match(wm_class="rnote"),
            Match(wm_class="logseq"),
            Match(wm_class="obsidian"),
            Match(wm_class="notes"),
        ],
        layout="max",
    ),
    Group(
        "2",
        label="web",
        matches=[
            Match(wm_class=BROWSER),
        ],
        layout="max",
    ),
    Group("3", label="dev", matches=[Match(wm_class="code")], layout="max"),
    Group("4", label="game", matches=[Match(wm_class="mgba-qt")], layout="max"),
    Group("5", label="passive", matches=[Match(wm_class="easyeffects")]),
    Group("6", label="virt", matches=[Match(wm_class="virt-manager")]),
]

for i in groups:
    keys.extend(
        [
            Key(
                [MOD],
                i.name,
                lazy.group[i.name].toscreen(),  # pyright: ignore[reportAny]
                desc=f"Switch to group {i.name}",
            ),
            Key(
                [MOD, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),  # pyright: ignore[reportAny]
                desc=f"Switch to & move focused window to group {i.name}",
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod + shift + group number = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

groups.append(
    ScratchPad(
        "scratchpad",
        [
            DropDown(
                "volume", "pavucontrol", width=0.8, height=0.8, x=0.1, y=0.1, opacity=1
            ),
            DropDown(
                "email",
                f"{EMAIL_CLIENT}",
                width=0.8,
                height=0.8,
                x=0.1,
                y=0.1,
                opacity=1,
            ),
            DropDown(
                "btop",
                f"{TERMINAL} --class=btop -e btop",
                width=0.8,
                height=0.8,
                x=0.1,
                y=0.1,
                opacity=0.9,
            ),
            DropDown(
                "cmus",
                f"{TERMINAL} --class=cmus -e cmus",
                width=0.8,
                height=0.8,
                x=0.1,
                y=0.1,
                opacity=0.9,
            ),
            DropDown(
                "tfm",
                f"{TERMINAL} --class=yazi -e yazi",
                width=0.8,
                height=0.8,
                x=0.1,
                y=0.1,
                opacity=0.9,
            ),
            DropDown(
                "nm",
                f"{TERMINAL} --class=nmtui -e nmtui",
                width=0.8,
                height=0.8,
                x=0.1,
                y=0.1,
                opacity=0.9,
            ),
        ],
    )
)

keys.extend(
    [
        Key([MOD], "s", lazy.group["scratchpad"].dropdown_toggle("cmus")),  # pyright: ignore[reportAny]
        Key([MOD], "v", lazy.group["scratchpad"].dropdown_toggle("volume")),  # pyright: ignore[reportAny]
        Key([MOD], "b", lazy.group["scratchpad"].dropdown_toggle("btop")),  # pyright: ignore[reportAny]
        Key([MOD], "m", lazy.group["scratchpad"].dropdown_toggle("email")),  # pyright: ignore[reportAny]
        Key([MOD], "f", lazy.group["scratchpad"].dropdown_toggle("tfm")),  # pyright: ignore[reportAny]
        Key([MOD], "w", lazy.group["scratchpad"].dropdown_toggle("nm")),  # pyright: ignore[reportAny]
    ]
)
widget_defaults = {
    "font": FONT,
    "fontsize": 16,
    "rounded": False,
    "background": COLORSCHEME["background"],
    "foreground": COLORSCHEME["foreground"],
    "active": COLORSCHEME["foreground"],
    "inactive": COLORSCHEME["white"],
    "highlight_method": "line",
    "highlight_color": COLORSCHEME["background"],
    "this_current_screen_border": COLORSCHEME["foreground"],
}
extension_defaults = widget_defaults.copy()

widgets = [  # pyright: ignore[reportUnknownVariableType]
    widget.GroupBox(  # pyright: ignore[reportUnknownMemberType]
        disable_drag=True,
        use_mouse_wheel=False,
        hide_unused=True,
    ),
    widget.Spacer(),  # pyright: ignore[reportUnknownMemberType]
    widget.Cmus(  # pyright: ignore[reportUnknownMemberType]
        format="{status_text}  {artist} - {title}",
        play_icon="",
        playing_text="",
        playing_color=COLORSCHEME["foreground"],
        pause_icon="",
        paused_text="",
        paused_color=COLORSCHEME["foreground"],
    ),
    widget.Mpris2(
        objname="org.mpris.MediaPlayer2.<zen>",
        format="{xesam:title} - {xesam:artist}",
    ),
    widget.Spacer(),  # pyright: ignore[reportUnknownMemberType]
    widget.Battery(  # pyright: ignore[reportUnknownMemberType]
        format="{char} {percent:2.0%} {hour:d}:{min:02d} {watt:.2f} W",
        charging_char="󰂄",
        discharging_char="v",
        full_char="󰁹",
        full_short_text="󰁹",
        low_percentage=0.2,
        low_foreground=COLORSCHEME["red"],
        empty_char="󰂎",
        empty_short_text="󰂎",
        unknown_char="󰂃",
        update_interval=10,
    ),
    widget.Clock(),  # pyright: ignore[reportUnknownMemberType]
    widget.Systray(icon_size=20),  # pyright: ignore[reportUnknownMemberType]
]

screens = [
    Screen(
        top=bar.Bar(
            widgets,  # pyright: ignore[reportUnknownArgumentType]
            40,
            background=COLORSCHEME["background"],
            margin=0,
            border_width=0,
            opacity=1.0,
        )
    )
]

layouts = [
    layout.Columns(
        border_focus=COLORSCHEME["foreground"],
        border_normal=COLORSCHEME["background"],
        border_width=2,
    ),
    layout.Max(
        border_focus=COLORSCHEME["foreground"],
        border_normal=COLORSCHEME["background"],
    ),
    # Try more layouts by unleashing below layouts.
    layout.Stack(
        border_focus=COLORSCHEME["foreground"],
        border_normal=COLORSCHEME["background"],
        num_stacks=2,
    ),
    # layout.Bsp(),
    # layout.Matrix(),
    layout.MonadTall(
        border_focus=COLORSCHEME["foreground"],
        border_normal=COLORSCHEME["background"],
    ),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

# Drag floating layouts.
mouse = [
    Drag(
        [MOD],
        "Button1",
        lazy.window.set_position_floating(),  # pyright: ignore[reportAny]
        start=lazy.window.get_position(),  # pyright: ignore[reportAny]
    ),
    Drag(
        [MOD],
        "Button3",
        lazy.window.set_size_floating(),  # pyright: ignore[reportAny]
        start=lazy.window.get_size(),  # pyright: ignore[reportAny]
    ),
    Click([MOD], "Button2", lazy.window.bring_to_front()),  # pyright: ignore[reportAny]
]

dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="ssh-askpass"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
# wl_input_rules = {
#     "type:keyboard": InputConfig(
#         kb_options="caps:escape",
#         kb_repeat_rate=50,
#         kb_repeat_delay=250,
#     ),
#     "type:touchpad": InputConfig(drag=True, tap=True, dwt=False, pointer_accel=0.3),
# }
wmname = "LG3D"
