{
  config.services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "none";
        width = 600;
        height = "(0,200)";
        origin = "top-right";
        offset = "0x30";
        scale = 0;
        notification_limit = 20;
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        progress_bar_corner_radius = 10;
        icon_corner_radius = 0;
        indicate_hidden = "yes";
        transparency = 30;
        separator_height = 2;
        padding = 20;
        horizontal_padding = 24;
        text_icon_padding = 0;
        frame_width = 1;
        gap_size = 0;
        separator_color = "frame";
        sort = "yes";
        font = "Fira Code 16";
        line_height = 1;
        markup = "full";
        format = "<b>%s</b>\n%b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = "no";
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = "yes";
        enable_recursive_icon_lookup = true;
        icon_theme = "Papirus-Dark";
        icon_position = "left";
        min_icon_size = 32;
        max_icon_size = 128;
        sticky_history = "yes";
        history_length = 20;
        # dmenu = /usr/bin/dmenu -p dunst;
        # browser = /usr/bin/xdg-open;
        always_run_script = true;
        title = "Dunst";
        class = "Dunst";
        corner_radius = 10;
        ignore_dbusclose = false;
        force_xwayland = false;
        force_xinerama = false;
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };
      experimental.per_monitor_dpi = false;
      urgency_low = {
        background = "#24273a";
        foreground = "#cad3f5";
        timeout = 6;
      };

      urgency_normal = {
        background = "#24273a";
        foreground = "#cad3f5";
        timeout = 6;
      };
      urgency_critical = {
        background = "#24273a";
        foreground = "#ed8796";
        timeout = 6;
      };
    };
  };
}
