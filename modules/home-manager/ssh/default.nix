# SSH configuration with Home Manager
{ config, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    
    # Add your common SSH options here
    extraConfig = ''
      # AddKeysToAgent yes
      # IdentityFile ~/.ssh/id_ed25519
      
      # Example host configuration
      # Host github.com
      #   User git
      #   IdentityFile ~/.ssh/github_ed25519
    '';
    
    # Automatically manage common SSH hosts (optional)
     matchBlocks = {
       "github.com" = {
         hostname = "github.com";
         user = "git";
         identityFile = "~/.ssh/github_ed25519";
       };
     };
  };

  # Set up the SSH agent with systemd user service
  services.ssh-agent.enable = true;
  
  # You can also set up GPG agent as SSH agent (alternative approach)
  # services.gpg-agent = {
  #   enable = true;
  #   enableSshSupport = true;
  # };
}
