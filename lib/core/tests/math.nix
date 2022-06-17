# to run these tests:
# nix-instantiate --eval --strict ./math.nix
# if the resulting list is empty, all tests passed
let
  math = import ../math.nix {};
  runTests = (import <nixpkgs/lib>).runTests;
in
  runTests {
    testPow_1 = {
      expr = math.pow 0 1000;
      expected = 0;
    };

    testPow_2 = {
      expr = math.pow 1000 0;
      expected = 1;
    };

    testPow_3 = {
      expr = math.pow 2 30;
      expected = 1073741824;
    };

    testPow_4 = {
      expr = math.pow (-5) 3;
      expected = -125;
    };
  }
