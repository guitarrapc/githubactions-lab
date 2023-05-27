package main

deny[msg] {
 manifest_dir := input.env.MANIFEST_DIR
 not contains(manifest_dir, "dev")
 msg = "env 'MANIFEST_DIR' must be dev"
}
