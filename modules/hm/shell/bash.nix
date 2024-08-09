{ ... }:
{
  programs = {
    fzf.enable = true;

    eza = {
      enable = true;
      enableBashIntegration = true;
    };

    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    bash = {
      enable = true;
      initExtra = ''
        PS1='\[\e[38;5;255;1m\]\u\[\e[0;38;5;241m\]@\[\e[38;5;247m\]\h\[\e[0m\] \[\e[38;5;238m\][\[\e[38;5;99m\]\w\[\e[38;5;238m\]]\[\e[0m\] \[\e[38;5;238m\]|\[\e[0m\] '
      '';

      shellAliases = {
        repl = "nix repl --expr 'import <nixpkgs>{}'";
        dotenv = "export $(cat .env | xargs)";
      };
    };
  };
}
