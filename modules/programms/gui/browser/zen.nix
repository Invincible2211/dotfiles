{inputs, ...}: {
  hm = {
    imports = [inputs.zenix.homeModules.default];
    programs.zenix.enable = true;
  };
}
