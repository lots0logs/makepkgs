#!/bin/bash -e

echo "setting up environment" >&2
ln -sv /proc/self/fd /dev/fd
echo 'nobody ALL=(ALL) NOPASSWD: /usr/bin/pacman' >> /etc/sudoers

if [ -f "/repo/local.db" ]; then
  echo "adding local repo" >&2
  echo -e '[local]\nSigLevel = Never\nServer = file:///repo' >> /etc/pacman.conf
fi

echo "preparing build dirs" >&2
mkdir /packages /build
chown -R nobody:nobody /packages /build

echo "unpacking package" >&2
cd /build && su nobody -s /bin/sh -c 'tar x' < /package.tar

echo "syncing repos" >&2
pacman -Sy

echo "building packages" >&2
cd /build && PKGDEST=/packages su nobody -s /bin/sh -c 'makepkg -s --noconfirm'

echo "copying packages to repo" >&2
cp /packages/* /repo

echo "adding packages to repo" >&2
cd /repo && repo-add -n local.db.tar.xz *.pkg.*

echo "chowning repo" >&2
chown -R $user:$group /repo

echo "done" >&2
