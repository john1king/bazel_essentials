"""Go related build rules."""

load("@io_bazel_rules_go//go:def.bzl", "go_binary", rules_go_go_repositories = "go_repositories")

def go_repositories():
  native.new_local_repository(
      name = "local_go_linux",
      path = "/usr/lib/go",   # docker go installation path
      build_file_content = "",
  )
  native.new_local_repository(
      name = "local_go_mac",
      path = "/usr/local/bin/go",   # default os x installation path
      build_file_content = "",
  )
  rules_go_go_repositories(
      go_darwin = "@local_go_mac",
      go_linux = "@local_go_linux",
  )

def static_go_binary(name, **args):
  """Produce statically linked go binary which may be put in a minimal docker.

  The typical go binary produced is about 12M, which is put into a minimal
  docker such as alpine to produce deployable images of size less than 20M.

  WARNING: It is unfortunate that the link flags only work with gcc, not clang,
  which in practice means the target will not build on Mac out of box.
  """
  print("WARNING: static_go_binary is deprecated, use go_binary instead!")
  go_binary(name=name, **args)
