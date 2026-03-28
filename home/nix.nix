{ config, pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.packages = pkgs.neovim;

  programs.stow = {
    enable = true;
    directory = "${builtins.toPath (toString ./.)}/config";
  };

  home.activation = {
    stow = ''
      cd ${builtins.toPath (toString ./.)}
      stow --adopt -t "$HOME/.config" config
      stow --adopt -t "$HOME" home
    '';
  };
}