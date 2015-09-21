Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8L2PN0j029811
 for <selinux@tycho.nsa.gov>; Sun, 20 Sep 2015 22:25:23 -0400
Date: Mon, 21 Sep 2015 12:25:18 +1000
From: Matthew Cengia <mattcen@cyber.com.au>
To: selinux@tycho.nsa.gov
Cc: Matthew Cengia <mattcen@gmail.com>, russell@coker.com.au
Subject: overlayfs+selinux error: OPNOTSUPP
Message-ID: <20150921022517.GH22582@cyber.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E6lVPAHcXg6biC3t"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--E6lVPAHcXg6biC3t
Content-Type: multipart/mixed; boundary="45wMVEkw4XUbiYON"
Content-Disposition: inline


--45wMVEkw4XUbiYON
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

NOTE: I originally sent this to LKML
(https://lkml.org/lkml/2015/9/17/888), but was directed here.

Hi all,

Please CC me directly when responding, as I'm not subscribed to the
mailing list.


Summary
-------
I deploy diskless Debian kiosks in prisons, for use by inmates.
As part of the Debian 7 to 8 upgrade, I want to enable SELinux.
My initrd uses overlayfs to combine a ro squashfs and a rw tmpfs.

When I add SELinux into the mix, I get a lot of EOPNOTSUPP.


Long and boring history
-----------------------
I was happy with Debian 7 / Linux 3.16 / sysvinit / aufs.
Then, new hardware arrived, which needed a newer Xorg.
So I had to switch to Debian 8 / Linux 3.16.
Debian 8 defaults to systemd, so I went with that.

I used to put $XDG_RUNTIME_DIR under a /tmp mounted -onoexec.
Systemd v215 is hard-coded to mount $XDG_RUNTIME_DIR as a dedicated tmpfs,
and provides no way to mount/remount it with -onoexec.

    src/login/logind-user.c:336:user_mkdir_runtime_path()

When I complained about this, regulars on #systemd on Freenode said:

    Just use SELinux, already!
    -o noexec might break something, and it won't stop interpreters.

=2E..which was mostly reasonable.
So adopting SELinux was reprioritized from "some day" to "right now!"

aufs doesn't support SELinux, so I had to switch to overlayfs.
So now my target is Debian 8 / Linux 4.1 / systemd / overlayfs / SELinux.


Current problem
---------------
When I built & booted that combination, hostnames didn't resolve.

The initrd uses klibc ipconfig as a DHCP client,
then tries to create /etc/resolv.conf in the rootfs.
(This happens before switch_root.)

When SELinux is enabled, resolv.conf can't be opened for writing.
The attached strace (output.txt) shows open(2) gets EOPNOTSUPP.


Tests completed
---------------
This problem *ONLY* occurs in the initrd,
which is *BEFORE* the SELinux policy loads.
I'm not sure if this is relevant.

This problem *DOES NOT* occur if the file/directory being written to
already exists in the read/write portion of the overlay mount before the
overlayfs is mounted. I've attached a script to demonstrate this.

Booting the kernel with permissive=3D1 *DOES NOT* prevent the problem.


Test script
-----------
Attached is a script called 'bootstrap'.
When run on a Debian Jessie system with debootstrap, squashfs-tools, and kv=
m installed,
and selinux installed and enabled (even if it's in permissive mode),
'bootstrap' will:

 * Mount a tmpfs without -o nodev at /tmp/bootstrap/live, to build in;
 * Build an SOE in /tmp/bootstrap/live/;
 * Create a squashfs of the built system;
 * Leave the squashfs, kernel, and initrd in /tmp/bootstrap/live/boot/; and
 * Start up a VM using KVM to demonstrate the behaviour.

The script that the initrd runs does several things, all of which are
detailed within the script, and in output.txt; look for lines
containing '-->'.

output.txt contains a full KVM run of the system exhibiting the problem,
in which I've also run an 'strace touch' to demonstrate the failing
syscall.


Help?
-----
How can I set about debugging this problem further?
Has anybody dealt with this before?
How can I solve (or workaround) this problem?

--=20
Regards,
Matthew Cengia

--45wMVEkw4XUbiYON
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=bootstrap

#!/bin/bash
set -eEux
set -o pipefail
trap 'echo >&2 "$0: unknown error"' ERR

export LC_ALL=C DEBIAN_FRONTEND=noninteractive
a=amd64 r=jessie t=live M=http://httpredir.debian.org/debian

# We can't use /tmp as it may (reasonably) be mounted -onodev.
mkdir -p /tmp/bootstrap
grep -q '^tmpfs /tmp/bootstrap tmpfs' /proc/mounts ||
mount tmpfs /tmp/bootstrap -ttmpfs -omode=700,size=80%
cd /tmp/bootstrap
rm -rf $t                                                       # Delete previous build (if any).

debootstrap --variant minbase --arch $a $r $t $M
>$t/etc/debian_chroot                   echo bootstrap
>$t/etc/apt/sources.list                printf 'deb %s %s main\n'       $M $r   $M $r-updates   $M $r-backports   http://security.debian.org $r/updates
>$t/etc/apt/sources.list.d/30selinux.list printf 'deb %s %s selinux\n' http://www.coker.com.au $r
>$t/etc/apt/apt.conf.d/10stable         echo "APT::Default-Release \"$r\";"
>$t/etc/apt/apt.conf.d/10bootstrap      echo 'APT::Get::Assume-Yes "1"; APT::Get::AutomaticRemove "1"; APT::Install-Recommends "0"; Quiet "1";'
>$t/usr/sbin/policy-rc.d                printf '#!/bin/sh\nexit 101'
chmod +x $t/usr/sbin/policy-rc.d
chroot $t apt-key adv --keyserver hkp://pool.sks-keyservers.net --recv-key D141CD30FC4B8F79
chroot $t apt-get update
chroot $t apt-get install -y initramfs-tools
>$t/etc/kernel-img.conf                 echo link_in_boot=yes
sed -i 's/^root:[^:]*:/root::/' $t/etc/shadow                   # root has null password
>$t/etc/initramfs-tools/modules         printf '%s\n' overlay squashfs
>$t/etc/initramfs-tools/scripts/overlaytest cat <<EOF
mountroot()
{
  set -x
  : "--> Mount a tmpfs on /live for use by overlay"
  mkdir /live
  mount -t tmpfs tmpfs /live
  : "--> Make the two subdirs required by overlay"
  mkdir -p /live/overlay/rw /live/overlay/work
  : "--> Make /filesystem to mount the read-only squashfs"
  mkdir /filesystem
  : "--> Create a /etc directory in what will become the writable portion of"
  : "--> the overlay filesystem"
  mkdir -p /live/overlay/rw/etc
  : "--> Mount the squashfs"
  mount -t squashfs /dev/vda /filesystem
  : "--> Union the tmpfs and the squashfs with overlayfs and mount them on"
  : "--> /root"
  mount -t overlay -o noatime,lowerdir=/filesystem/,upperdir=/live/overlay/rw,workdir=/live/overlay/work overlay /root/

  : "--> Demonstrate that creating a file..."
  touch /root/newfile
  : "--> ... creating a directory..."
  mkdir -p /root/newdir
  : "--> ... and creating a file in the new directory all work in the"
  : "--> root of the overlay filesystem..."
  touch /root/newdir/newfile
  : "--> ...before cleaning up those files/dirs"
  rm -r /root/newfile /root/newdir/newfile /root/newdir
  : "--> Demonstrate that touching an existing directory (/etc, which we"
  : "--> created earlier), and a file within it, works"
  touch /root/etc/
  touch /root/etc/newfile
  : "--> Demonstrate that touching a directory or file not already present in"
  : "--> the read-write part of overlay does *NOT* work"
  touch /root/home/
  touch /root/home/newfile

  set +x

  maybe_break

}
EOF
>$t/etc/initramfs-tools/hooks/strace cat <<\EOF
#!/bin/bash

set -e
if [[ prereqs = $1 ]]
then exit 0
fi

. /usr/share/initramfs-tools/hook-functions

copy_exec /usr/bin/strace
EOF
chmod a+x $t/etc/initramfs-tools/hooks/strace
chroot $t apt-get install -y --no-install-recommends linux-image-4.1.0-0.bpo.1-amd64 busybox selinux-basics selinux-policy-default auditd strace

# SELinux relabel
# NOTE: This requres SELinux to be enabled on the build host, even if it
# is set to permissive!
setfiles -r $t/ $t/etc/selinux/default/contexts/files/file_contexts $t/

exclusions=(
    # Since boot/* is needed outside the squashfs, don't duplicate it inside.
    '^boot$/.'
    # Filesystems created at boot time.
    '^(dev|tmp|run)$/.'
    '^var$/^(lock|run|tmp)$/.'
    # Build-time configuration and cache.
    '^etc$/^(debian_chroot|hostname|hosts|motd(\.tail)?|mtab|resolv.conf)$'
    '^etc$/^apt$/^apt.conf.d$/^10bootstrap$'
    '^etc$/^network$/^interfaces$'
    '^usr$/^sbin$/^policy-rc\.d$'
    '^var$/^cache$/^apt$/^(src)?pkgcache\.bin$'
    '^var$/^cache$/^apt$/^archives$/\.deb$'
    '^var$/^cache$/^bootstrap$'
    '^var$/^lib$/^apt$/^lists$/.'
    '^var$/^log$/.'
)

mksquashfs $t $t/boot/filesystem.squashfs -regex -e "${exclusions[@]}"

kvm -m 256 -nographic -kernel $t/boot/vmlinuz -initrd $t/boot/initrd.img -append 'console=ttyS0 root=/dev/vda loglevel=1 security=selinux boot=overlaytest' -drive file=$t/boot/filesystem.squashfs,index=0,media=disk,if=virtio -net nic,model=virtio

--45wMVEkw4XUbiYON
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="output.txt"

+ kvm -m 256 -nographic -kernel live/boot/vmlinuz -initrd live/boot/initrd.img -append 'console=ttyS0 root=/dev/vda loglevel=1 security=selinux boot=overlaytest' -drive file=live/boot/filesystem.squashfs,index=0,media=disk,if=virtio -net nic,model=virtio
Warning: vlan 0 is not connected to host network
Loading, please wait...
Begin: Loading essential drivers ... done.
Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/nfs-top ... done.
Begin: Running /scripts/nfs-premount ... done.
+ : --> Mount a tmpfs on /live for use by overlay
+ mkdir /live
+ mount -t tmpfs tmpfs /live
+ : --> Make the two subdirs required by overlay
+ mkdir -p /live/overlay/rw /live/overlay/work
+ : --> Make /filesystem to mount the read-only squashfs
+ mkdir /filesystem
+ : --> Create a /etc directory in what will become the writable portion of
+ : --> the overlay filesystem
+ mkdir -p /live/overlay/rw/etc
+ : --> Mount the squashfs
+ mount -t squashfs /dev/vda /filesystem
+ : --> Union the tmpfs and the squashfs with overlayfs and mount them on
+ : --> /root
+ mount -t overlay -o noatime,lowerdir=/filesystem/,upperdir=/live/overlay/rw,workdir=/live/overlay/work overlay /root/
+ : --> Demonstrate that creating a file...
+ touch /root/newfile
+ : --> ... creating a directory...
+ mkdir -p /root/newdir
+ : --> ... and creating a file in the new directory all work in the
+ : --> root of the overlay filesystem...
+ touch /root/newdir/newfile
+ : --> ...before cleaning up those files/dirs
+ rm -r /root/newfile /root/newdir/newfile /root/newdir
+ : --> Demonstrate that touching an existing directory (/etc, which we
+ : --> created earlier), and a file within it, works
+ touch /root/etc/
+ touch /root/etc/newfile
+ : --> Demonstrate that touching a directory or file not already present in
+ : --> the read-write part of overlay does *NOT* work
+ touch /root/home/
touch: /root/home/: Operation not supported
+ touch /root/home/newfile
touch: /root/home/newfile: Operation not supported
+ set +x
Spawning shell within the initramfs
modprobe: module ehci-orion not found in modules.dep


BusyBox v1.22.1 (Debian 1:1.22.0-9+deb8u1) built-in shell (ash)
Enter 'help' for a list of built-in commands.

/bin/sh: can't access tty; job control turned off
(initramfs) strace touch /root/home/newfile
execve("/bin/touch", ["touch", "/root/home/newfile"], [/* 32 vars */]) = 0
brk(0)                                  = 0x1db8000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f64fcfce000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=1358, ...}) = 0
mmap(NULL, 1358, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f64fcfcd000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0P\34\2\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1729984, ...}) = 0
mmap(NULL, 3836448, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f64fca07000
mprotect(0x7f64fcba6000, 2097152, PROT_NONE) = 0
mmap(0x7f64fcda6000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x19f000) = 0x7f64fcda6000
mmap(0x7f64fcdac000, 14880, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f64fcdac000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f64fcfcc000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f64fcfcb000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f64fcfca000
arch_prctl(ARCH_SET_FS, 0x7f64fcfcb700) = 0
mprotect(0x7f64fcda6000, 16384, PROT_READ) = 0
mprotect(0x69a000, 4096, PROT_READ)     = 0
mprotect(0x7f64fcfd0000, 4096, PROT_READ) = 0
munmap(0x7f64fcfcd000, 1358)            = 0
getuid()                                = 0
utimes("/root/home/newfile", NULL)      = -1 ENOENT (No such file or directory)
open("/root/home/newfile", O_RDWR|O_CREAT, 0666) = -1 EOPNOTSUPP (Operation not supported)
brk(0)                                  = 0x1db8000
brk(0x1dd9000)                          = 0x1dd9000
write(2, "touch: /root/home/newfile: Opera"..., 51touch: /root/home/newfile: Operation not supported
) = 51
exit_group(1)                           = ?
+++ exited with 1 +++
(initramfs)

--45wMVEkw4XUbiYON--

--E6lVPAHcXg6biC3t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQJ8BAEBCgBmBQJV/2qNXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRDMTlFRDFDRTdERThBODYxMjhGOEQwNEI5
RDBCNTY1NTlCRjZBNTYyAAoJEJ0LVlWb9qVix2MQALWGqqUUhmX8CFCeb1acOaVP
d5xhO12qaT+yFlvrX/hb1A20DoUNxzJ8Mpy2g+86BuWIZhFtN3Vzhctp8rgoZhsS
Xwt/R3524lJzdG11i0cRUpvyYr52dewS3TxM/cyDsHTGbxI3cMr+Q2YhFEUhfO8W
8VCDYywr4iLj92pebWryk9GMD+OkIWSuJB3ZRSaJy9+5Kt/iD+SJh0tZSTVCC/rB
wJ5oh+CI9gvCWY1CkyCL+IEMlZ41A6fkMUHwkW1CVUTfVv+rK9ZlQ/0hr83qJa0b
68siTjj2BeljQZyQKunPkd9Zi0rzlKPqKYWfKWK+wYVmCRUUVZG7TqS41+Qt/HNx
SyuyixLnBejTqq6f2LCxkTdhTNg75Uu7uRJH25oiOxBbDp0meQXfBmA6wQY84B2b
xC5HnrXtGXlwKpoze9AGBfVVPiL/HxgYLgLlhvYMNrIEKSCp2tLVMLngNNdeIhqa
9DHL2u35vNlbYvid/4q44in80LQ6lyocMQyLl8FyZ//lepEk6q48xLVa4y1eYElJ
G8Mtpouz2dFcIOolgBoz0kWD8T6PbkPgUW2kcWierLdUjnzflUETi4WXUV/7NPL1
x8bNuyW/IkC7Tzu0mCsFXtS/NuJEDECTPKTyunBe6Rviqg/XJRfaqw8eARHl8GT0
2rGsSIonp28ZCUg7HBfN
=5pcj
-----END PGP SIGNATURE-----

--E6lVPAHcXg6biC3t--
