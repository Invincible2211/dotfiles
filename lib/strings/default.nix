{lib, ...}: word: let
  inherit (builtins) stringLength substring;

  capitalize = word:
    if stringLength word > 0
    then let
      firstLetter = substring 0 1 word;
      rest = substring 1 (stringLength word - 1) word;
    in
      lib.toUpper firstLetter + rest
    else word;
in
  capitalize word
