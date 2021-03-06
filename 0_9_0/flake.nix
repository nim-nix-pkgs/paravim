{
  description = ''A parasitic editor'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-paravim-0_9_0.flake = false;
  inputs.src-paravim-0_9_0.ref   = "refs/tags/0.9.0";
  inputs.src-paravim-0_9_0.owner = "paranim";
  inputs.src-paravim-0_9_0.repo  = "paravim";
  inputs.src-paravim-0_9_0.type  = "github";
  
  inputs."paranim".owner = "nim-nix-pkgs";
  inputs."paranim".ref   = "master";
  inputs."paranim".repo  = "paranim";
  inputs."paranim".dir   = "0_12_0";
  inputs."paranim".type  = "github";
  inputs."paranim".inputs.nixpkgs.follows = "nixpkgs";
  inputs."paranim".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."pararules".owner = "nim-nix-pkgs";
  inputs."pararules".ref   = "master";
  inputs."pararules".repo  = "pararules";
  inputs."pararules".dir   = "1_1_0";
  inputs."pararules".type  = "github";
  inputs."pararules".inputs.nixpkgs.follows = "nixpkgs";
  inputs."pararules".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."paratext".owner = "nim-nix-pkgs";
  inputs."paratext".ref   = "master";
  inputs."paratext".repo  = "paratext";
  inputs."paratext".dir   = "0_13_0";
  inputs."paratext".type  = "github";
  inputs."paratext".inputs.nixpkgs.follows = "nixpkgs";
  inputs."paratext".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-paravim-0_9_0"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-paravim-0_9_0";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}