let patch = import "patch.ncl" in
let base = import "hanamaru.trime.ncl" in

base
& {
  name | priority 1 = "hanamaru30",

  preset_keyboards.default.keys | priority 1 =
    patch
      base.preset_keyboards.default.keys
      [
        { index = 10, width = 0 },
        { index = 20, width = 0 },
        { after = 19, click = ";" },
        { index = 30, patch = { composing | priority 1 = "'" } },
        { index = 31, patch = { composing | priority 1 = "" } },
        { index = 32, patch = { composing | priority 1 = "/" } },
        { index = 34, patch = { composing | priority 1 = "'" } },
        { index = 35, patch = { composing | priority 1 = "" } },
        { index = 36, patch = { composing | priority 1 = "/" } },
      ],
}
