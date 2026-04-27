let patch = import "patch.ncl" in
let base = import "hanamaru.trime.ncl" in
let base_keys = base.preset_keyboards.default.keys in

base
& {
  name | priority 1 = "hanamaru30_column",

  style =
    base.style
    & {
      keyboard_height | priority 1 = 280,
      horizontal_gap | priority 1 = 8,
      vertical_gap | priority 1 = 4,
    },

  preset_keyboards.default.keys | priority 1 =
    patch
      base_keys
      [
        { before = 0, click = "0" },
        { before = 0, click = "1" },
        { before = 0, click = "2" },
        { before = 0, click = "3" },
        { before = 0, click = "4" },
        { before = 0, click = "5" },
        { before = 0, click = "6" },
        { before = 0, click = "7" },
        { before = 0, click = "8" },
        { before = 0, click = "9" },
        { index = 10, width = 0 },
        { index = 20, width = 0 },
        { after = 19, click = ";" },
        { index = 21, click = "" },
        { index = 29, click = "" },
        { before = 29, click = "," },
        { before = 29, click = "." },
        { before = 29, click = "/" },
        { index = 30, patch = { composing | priority 1 = "'" } },
        { index = 32, patch = { composing | priority 1 = "/" } },
        { index = 36, patch = { composing | priority 1 = "'" } },
        { index = 31, click = "" },
        { index = 34, click = "" },
        { before = 32 } & (base_keys |> std.array.at 21),
        { index = 36 } & (base_keys |> std.array.at 29),
      ],
}
