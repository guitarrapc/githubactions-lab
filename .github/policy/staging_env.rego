package main

deny[msg] {
 manifest_dir := input.env.MANIFEST_DIR
 not contains(manifest_dir, "staging")
 msg = "env 'MANIFEST_DIR' must be staging"
}
