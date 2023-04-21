# to run these tests:
# nix eval .#tests.conversions
# if the resulting list is empty, all tests passed
{ nixpkgs-lib }:
let
  conversions = import ../conversions.nix { inherit nixpkgs-lib; };
  inherit (nixpkgs-lib) runTests;
in
runTests {
  testHexToDec_1 = {
    expr = conversions.hexToDec "12";
    expected = 18;
  };

  testHexToDec_2 = {
    expr = conversions.hexToDec "FF";
    expected = 255;
  };

  testHexToDec_3 = {
    expr = conversions.hexToDec "abcdef";
    expected = 11259375;
  };

  testHexToRGB_1 = {
    expr = conversions.hexToRGB "012345";
    expected = [ 1 35 69 ];
  };

  testHexToRGB_2 = {
    expr = conversions.hexToRGB "abcdef";
    expected = [ 171 205 239 ];
  };

  testHexToRGB_3 = {
    expr = conversions.hexToRGB "000FFF";
    expected = [ 0 15 255 ];
  };

  testHexToRGBString_1 = {
    expr = conversions.hexToRGBString ", " "012345";
    expected = "1, 35, 69";
  };

  testHexToRGBString_2 = {
    expr = conversions.hexToRGBString ":" "abcdef";
    expected = "171:205:239";
  };

  testHexToRGBString_3 = {
    expr = conversions.hexToRGBString "; " "000FFF";
    expected = "0; 15; 255";
  };
}
