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
        { index = 30, composing = "'" },
        { index = 31, composing = "" },
        { index = 32, composing = "/" },
        { index = 34, composing = "'" },
        { index = 35, composing = "" },
        { index = 36, composing = "/" },
      ],
}
