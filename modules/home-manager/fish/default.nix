# Fish shell configuration
{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      vim = "nvim";
      ls = "eza -l -g --icons";
      lsa = "ll -a";
    };

    functions = {
      clear_term = {
        body = ''
          clear
          commandline -f repaint
        '';
      };

      fuzzy_find = {
        body = ''
          set dir (find ~ -type d | fzf)
          if test -n "$dir"
            cd $dir
          end
          commandline -f repaint
        '';
      };

      ll = {
        body = ''
          eza -l -g --icons $argv
        '';
      };

      # Add a custom command_not_found handler function
      fish_command_not_found = ''
        echo "Command not found: $argv[1]"
      '';
    };

    interactiveShellInit = ''
      # Enable vim mode
      fish_vi_key_bindings

      # Key bindings for clear and fuzzy find
      # Use the exact key sequence for Alt+c and Alt+f
      bind \ec 'clear_term'
      bind \ef 'fuzzy_find'

      # For insert mode
      bind -M insert \ec 'clear_term'
      bind -M insert \ef 'fuzzy_find'

      # For visual mode
      bind -M visual \ec 'clear_term'
      bind -M visual \ef 'fuzzy_find'

      # Hook direnv into the shell
      direnv hook fish | source
    '';
  };
}
