{
  config.programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      format = ''
        $cmd_duration$directory $git_branch
        $character
      '';
      character = {
        success_symbol = "[->](bold fg:rosewater) ";
        error_symbol = "[->](bold fg:red) ";
      };
      git_commit = {
        commit_hash_length = 4;
        tag_symbol = " ";
      };
      git_state = {
        format = "[\($state( $progress_current of $progress_total)\)]($style) ";
        cherry_pick = "[🍒 PICKING](bold red)";
      };
      git_status = {
        conflicted = " 🏳 ";
        ahead = " 🏎💨 ";
        behind = " 😰 ";
        diverged = " 😵 ";
        untracked = " 🤷 ";
        stashed = " 📦 ";
        modified = " 📝 ";
        staged = "[++\($count\)](green)";
        renamed = " ✍️ ";
        deleted = " 🗑 ";
      };
      hostname = {
        ssh_only = false;
        format = "[•$hostname](bg:cyan bold fg:black)[](bold fg:cyan )";
        trim_at = ".companyname.com";
        disabled = false;
      };
      line_break.disabled = false;
      directory = {
        home_symbol = " ";
        read_only = "  ";
        style = "fg:mauve";
        truncation_length = 6;
        truncation_symbol = "~/";
        format = "(bold fg:mauve)[$path ]($style)(bold fg:mauve)";
      };
      directory.substitutions = {
        "desktop" = "  ";
        "documents" = "  ";
        "downloads" = "  ";
        "music" = " 󰎈 ";
        "images" = "  ";
        "videos" = "  ";
      };
      cmd_duration = {
        min_time = 0;
        format = "[](bold fg:pink)[ $duration](bold bg:pink fg:black)[](bold fg:pink) ";
      };
    };
  };
}
