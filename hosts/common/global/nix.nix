{
  specialArgs,
  ...
}: let
  darwin = specialArgs.darwin or false;
in {
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    optimise.automatic = true;
    gc = {
      automatic = true;
      ${if !darwin then "dates" else null} = "weekly";
      options = "--delete-older-than 2w";
    };
  };
}
