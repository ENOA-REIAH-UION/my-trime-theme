#!/usr/bin/env nu

let output_dir = ".."

for ncl_file in (glob "*.trime.ncl") {
    let stem = ($ncl_file | path parse | get stem)
    let yaml_file = $output_dir | path join $"($stem).yaml"

    print $"转换 ($ncl_file) -> ($yaml_file)"
    nickel export -f yaml -o $yaml_file $ncl_file
}
