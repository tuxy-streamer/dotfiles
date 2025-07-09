import os
import subprocess

from libqtile import bar, hook, layout, qtile, widget
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


@hook.subscribe.startup_once
def autostart():
    autostart_script = os.path.expanduser("~/.config/autostart.sh")
    subprocess.call(autostart_script)


gruvbox_dark = {
    "black": "#282828",
    "red": "#cc241d",
    "green": "#98971a",
    "yellow": "#d79921",
    "blue": "#458588",
    "magenta": "#b16286",
    "cyan": "#689d6a",
    "white": "#a89984",
    "pale": "#fbf1c7",
}

COLORSCHEME = gruvbox_dark
FONT = "M+CodeLat50"
MOD = "mod1"
TERMINAL = "alacritty"
EMAIL_CLIENT = "betterbird"

keys = [
    Key([MOD], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([MOD], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([MOD], "j", lazy.layout.down(), desc="Move focus down"),
    Key([MOD], "k", lazy.layout.up(), desc="Move focus up"),
    Key(
        [MOD, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [MOD, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([MOD, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([MOD, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([MOD, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [MOD, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([MOD, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([MOD, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([MOD], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([MOD], "Tab", lazy.layout.next(), desc="Move window focus to other window"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [MOD, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([MOD], "Return", lazy.spawn(TERMINAL), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([MOD], "space", lazy.next_layout(), desc="Toggle between layouts"),
    Key([MOD], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [MOD, "control"],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key(
        [MOD],
        "t",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window",
    ),
    Key([MOD, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([MOD, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    KeyChord(
        [MOD],
        "r",
        [
            Key([], "d", lazy.spawn("rofi -show drun"), desc="Spawn drun launcher"),
            Key([], "r", lazy.spawn("rofi -show run"), desc="Spawn run launcher"),
            Key([], "w", lazy.spawn("rofi -show window"), desc="Spawn window launcher"),
            Key([], "s", lazy.spawn("rofi -show ssh"), desc="Spawn ssh launcher"),
            Key([], "c", lazy.spawn("clipmenu"), desc="Spawn ssh launcher"),
            Key(
                [],
                "f",
                lazy.spawn("rofi -show filebrowser"),
                desc="Spawn file browser launcher",
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
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            Key(
                [MOD],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            Key(
                [MOD, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
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
                "mmpv",
                f"{TERMINAL} --class=zathura -e zathura",
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
        ],
    )
)

keys.extend(
    [
        Key([MOD], "s", lazy.group["scratchpad"].dropdown_toggle("cmus")),
        Key([MOD], "v", lazy.group["scratchpad"].dropdown_toggle("volume")),
        Key([MOD], "b", lazy.group["scratchpad"].dropdown_toggle("btop")),
        Key([MOD], "y", lazy.group["scratchpad"].dropdown_toggle("mmpv")),
        Key([MOD], "m", lazy.group["scratchpad"].dropdown_toggle("email")),
        Key([MOD], "f", lazy.group["scratchpad"].dropdown_toggle("tfm")),
    ]
)

layouts = [
    layout.Columns(
        border_focus=COLORSCHEME["pale"],
        border_normal=COLORSCHEME["black"],
        border_width=2,
    ),
    layout.Max(
        border_focus=COLORSCHEME["pale"],
        border_normal=COLORSCHEME["black"],
    ),
    # Try more layouts by unleashing below layouts.
    layout.Stack(
        border_focus=COLORSCHEME["pale"],
        border_normal=COLORSCHEME["black"],
        num_stacks=2,
    ),
    # layout.Bsp(),
    # layout.Matrix(),
    layout.MonadTall(
        border_focus=COLORSCHEME["pale"],
        border_normal=COLORSCHEME["black"],
    ),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.TextBox("default config", name="default"),
                widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                widget.Systray(),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                widget.QuickExit(),
            ],
            24,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
# Drag floating layouts.
mouse = [
    Drag(
        [MOD],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [MOD], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([MOD], "Button2", lazy.window.bring_to_front()),
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

wmname = "LG3D"
