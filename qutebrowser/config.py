# pylint: disable=C0114,W0127,E0602,E0601
# type: ignore
# pyright: reportUndefinedVariable=true
# pyright: reportUnknownVariableType=true
# pyright: reportUnknownVariableType=true
# ruff: noqa: F821
from qutebrowser.config.config import ConfigContainer
from qutebrowser.config.configfiles import ConfigAPI

config: ConfigAPI = config
c: ConfigContainer = c

# General
config.load_autoconfig(True)
c.changelog_after_upgrade = "minor"
c.backend = "webengine"
c.auto_save.session = True
c.aliases = {
    "q": "close",
    "w": "session-save",
    "wq": "quit --save",
    "l": "session-load default",
}
c.content.pdfjs = True
c.url.start_pages = ["about:blank"]
c.url.default_page = "about:blank"
c.completion.quick = True
c.completion.web_history.max_items = -1
c.confirm_quit = ["downloads"]
c.content.prefers_reduced_motion = True
c.qt.chromium.process_model = "process-per-site"
c.qt.highdpi = True
c.qt.workarounds.disable_accelerated_2d_canvas = "never"
c.qt.workarounds.disable_hangouts_extension = True
c.scrolling.smooth = True

# Cookies
c.content.cookies.accept = "no-3rdparty"
c.content.cookies.store = True

# Tabs
c.tabs.position = "right"
c.tabs.padding = {"top": 5, "bottom": 5, "left": 9, "right": 9}
c.tabs.show = "switching"
c.tabs.show_switching_delay = 0
c.fonts.tabs.selected = "12pt default_family"
c.fonts.tabs.unselected = "12pt default_family"
c.tabs.indicator.width = 0
c.tabs.width = "7%"

# Darkmode
c.colors.webpage.darkmode.algorithm = "lightness-cielab"
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.policy.images = "never"
c.colors.webpage.preferred_color_scheme = "dark"


# Keymaps
config.bind("h", "history")
config.bind("r", "reload")
config.bind("<Ctrl-r>", "config-source")
config.bind("<Ctrl-e>", "config-cycle tabs.show always never")
config.bind("to", "open -t")

# Search
c.completion.open_categories = [
    "searchengines",
    "quickmarks",
    "bookmarks",
    "history",
    "filesystem",
]
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "!yt": "https://www.youtube.com/results?search_query={}",
    "!aw": "https://wiki.archlinux.org/?search={}",
}

# Statusbar
c.statusbar.position = "bottom"
c.statusbar.show = "in-mode"
c.tabs.width = "14%"

# Ad-blocking
c.content.blocking.enabled = True
c.content.blocking.hosts.block_subdomains = True
c.content.private_browsing = True
c.content.webgl = False
c.content.canvas_reading = False
c.content.geolocation = False
c.content.webrtc_ip_handling_policy = "default-public-interface-only"
c.content.javascript.enabled = False
c.content.blocking.enabled = True
c.content.blocking.method = "both"
c.content.blocking.adblock.lists = [
    # ublockorigin filters
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/legacy.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2021.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2022.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2023.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2024.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badware.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-cookies.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-others.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/quick-fixes.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt",
    # easylist filters
    "https://easylist.to/easylist/easylist.txt",
    "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://secure.fanboy.co.nz/fanboy-annoyance.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    # abp filters
    "https://raw.githubusercontent.com/heradhis/indonesianadblockrules/master/subscriptions/abpindo.txt",
    "https://abpvn.com/filter/abpvn-IPl6HE.txt",
    "https://stanev.org/abp/adblock_bg.txt",
    "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/NorwegianExperimentalList%20alternate%20versions/NordicFiltersABP-Inclusion.txt",
    "https://easylist-downloads.adblockplus.org/easylistchina.txt",
    "https://raw.githubusercontent.com/tomasko126/easylistczechandslovak/master/filters.txt",
    "https://easylist-downloads.adblockplus.org/easylistdutch.txt",
    "https://easylist.to/easylistgermany/easylistgermany.txt",
    "https://raw.githubusercontent.com/easylist/EasyListHebrew/master/EasyListHebrew.txt"
    "https://easylist-downloads.adblockplus.org/easylistitaly.txt"
    "https://raw.githubusercontent.com/EasyList-Lithuania/easylist_lithuania/master/easylistlithuania.txt",
    "https://easylist-downloads.adblockplus.org/easylistpolish.txt",
    "https://easylist-downloads.adblockplus.org/easylistportuguese.txt",
    "https://easylist-downloads.adblockplus.org/easylistspanish.txt",
    "https://easylist-downloads.adblockplus.org/indianlist.txt",
    "https://easylist-downloads.adblockplus.org/koreanlist.txt",
    "https://raw.githubusercontent.com/Latvian-List/adblock-latvian/master/lists/latvian-list.txt",
    "https://easylist-downloads.adblockplus.org/liste_ar.txt",
    "https://easylist-downloads.adblockplus.org/liste_fr.txt",
    "https://zoso.ro/pages/rolist.txt",
    "https://easylist-downloads.adblockplus.org/ruadlist.txt",
    "https://easylist-downloads.adblockplus.org/antiadblockfilters.txt",
]
c.content.blocking.hosts.lists = [
    "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
]
