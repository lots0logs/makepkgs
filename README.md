# makepkgs

  Isolated package builder for Arch Linux using Docker.

## makepkgs [PACKAGE]...

  Each package is expected to be a directory containing a PKGBUILD and supporting files.
  They are built in order, and can depend on packages that come before them.
  They are built in a fresh docker container with only base, base-devel and sudo available.
  Built packages are placed in $PKGDEST, which defaults to the current directory.

## Images

  makepkgs expects an Arch base image called `arch`. It will build an image called `arch-devel` based on it, which has `base-devel` and `sudo` installed.
  If you don't have an Arch base image, check out [arch-docker](https://github.com/nathan7/arch-docker).

