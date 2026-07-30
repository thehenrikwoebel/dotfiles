{ pkgs, zscroll-src, ... }:

let
  zscroll = pkgs.python3Packages.buildPythonApplication {
    pname = "zscroll";
    version = "2.0.1";
    src = zscroll-src;
    format = "setuptools";
    doCheck = false;
  };
in
{
  environment.systemPackages = [ zscroll ];
}
