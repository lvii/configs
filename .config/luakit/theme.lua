--------------------------
-- Default luakit theme --
--------------------------

local theme = {}

-- Default settings
theme.font = "termsyn 8"
theme.fg   = "#999999"
theme.bg   = "#020202"

-- Genaral colours
theme.success_fg = "#0f0"
theme.loaded_fg  = "#3995BF"
theme.error_fg = "#B3354C"
theme.error_bg = "#020202"

-- Warning colours
theme.warning_fg = "#BF9F5F"
theme.warning_bg = "#020202"

-- Notification colours
theme.notif_fg = "#6C98A6"
theme.notif_bg = "#020202"

-- Menu colours
theme.menu_fg                   = "#999999"
theme.menu_bg                   = "#1A1A1A"
theme.menu_selected_fg          = "#B3B3B3"
theme.menu_selected_bg          = "#4C4C4C"
theme.menu_title_bg             = "#1A1A1A"
theme.menu_primary_title_fg     = "#B3B3B3"
theme.menu_secondary_title_fg   = "#808080"

-- Proxy manager
theme.proxy_active_menu_fg      = '#000'
theme.proxy_active_menu_bg      = '#FFF'
theme.proxy_inactive_menu_fg    = '#888'
theme.proxy_inactive_menu_bg    = '#FFF'

-- Statusbar specific
theme.sbar_fg         = "#999999"
theme.sbar_bg         = "#1A1A1A"

-- Downloadbar specific
theme.dbar_fg         = "#999999"
theme.dbar_bg         = "#020202"
theme.dbar_error_fg   = "#B3354C"

-- Input bar specific
theme.ibar_fg           = "#999999"
theme.ibar_bg           = "#020202"

-- Tab label
theme.tab_fg            = "#808080"
theme.tab_bg            = "#020202"
theme.tab_ntheme        = "#684D80"
theme.selected_fg       = "#B3B3B3"
theme.selected_bg       = "#2E2E2E"
theme.selected_ntheme   = "#B3B3B3"
theme.loading_fg        = "#4C4C4C"
theme.loading_bg        = "#020202"

-- Trusted/untrusted ssl colours
theme.trust_fg          = "#608040"
theme.notrust_fg        = "#B3354C"

return theme
-- vim: et:sw=4:ts=8:sts=4:tw=80
