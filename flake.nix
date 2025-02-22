{
  description = "My config";
  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-stable = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    nur.url = "github:nix-community/NUR";

    sops-nix.url = "github:Mic92/sops-nix";

    # FIXME: The LICENSE file conflicts. Maybe can't use writeShellApllication.
    nixrun.url = "github:han-san/nixrun";
    dithercbz.url = "github:han-san/dithercbz";
  };

  outputs = { self, nixpkgs, ... } @ inputs: {
    nixosConfigurations = {
      hermes = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          inputs.sops-nix.nixosModules.sops
          inputs.nur.modules.nixos.default
          ./hosts/hermes/configuration.nix
        ];
      };
      wsl = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          inputs.sops-nix.nixosModules.sops
          ./hosts/wsl/configuration.nix
        ];
      };
      federer = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          inputs.sops-nix.nixosModules.sops
          ./hosts/federer/configuration.nix
        ];
      };
    };
  };

}
