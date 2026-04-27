## patch
# 对数组元素应用补丁，支持按索引替换和插入操作。
#
# ### 参数
# - `base`: 原始数组
# - `patches`: 补丁数组，每项可以是:
#   - `{ index = N, ... }`: 直接覆盖索引 N 处的元素
#   - `{ index = N, patch = {...} }`: 将补丁与原元素合并
#   - `{ before = N, ... }`: 在索引 N 之前插入新元素
#   - `{ after = N, ... }`: 在索引 N 之后插入新元素
#
# 索引基于原始数组，不受之前插入影响。
let patch = fun base patches =>
  let has_field = fun f r => std.record.has_field f r in
  let meta_fields = ["index", "before", "after", "patch"] in

  # 提取补丁的非元字段
  let get_data = fun p =>
    std.array.fold_right
      (fun k acc =>
        if std.array.elem k meta_fields then
          acc
        else
          acc & { "%{k}" = p."%{k}" }
      )
      {}
      (std.record.fields p)
  in

  # 分离补丁类型
  let index_ps = std.array.filter (has_field "index") patches in
  let before_ps = std.array.filter (has_field "before") patches in
  let after_ps = std.array.filter (has_field "after") patches in

  let base_len = std.array.length base in

  # 遍历构建结果
  let rec build = fun i result =>
    if i >= base_len then
      # 末尾的 after 插入
      let end_after = std.array.filter (fun p => p.after >= base_len - 1) after_ps in
      result @ (std.array.map get_data end_after)
    else
      let before_list = std.array.filter (fun p => p.before == i) before_ps in
      let after_list = std.array.filter (fun p => p.after == i) after_ps in
      let index_patch = std.array.filter (fun p => p.index == i) index_ps in

      let replacement =
        if index_patch == [] then
          std.array.at i base
        else
          let p = std.array.at 0 index_patch in
          if has_field "patch" p then
            let base_elem = std.array.at i base in
            base_elem & p.patch
          else
            get_data p
      in

      result
      @ (std.array.map get_data before_list)
      @ [replacement]
      @ (std.array.map get_data after_list)
      |> build (i + 1)
  in

  build 0 []
in

patch
