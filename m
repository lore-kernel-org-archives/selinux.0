Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1L5pbPV017372
	for <selinux@tycho.nsa.gov>; Sat, 21 Feb 2009 00:51:37 -0500
Received: from mail.gmx.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id n1L5mCWR022853
	for <selinux@tycho.nsa.gov>; Sat, 21 Feb 2009 05:48:12 GMT
From: Dennis Wronka <linuxweb@gmx.net>
To: Justin Mattock <justinmattock@gmail.com>
Subject: Re: ext3 security labels missing
Date: Sat, 21 Feb 2009 13:51:24 +0800
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
References: <dd18b0c30902192304w76b8c2ebt1f0954d2d5cb903b@mail.gmail.com> <200902202320.16356.linuxweb@gmx.net> <dd18b0c30902201510n105c5c0kc1791b9ba1741aea@mail.gmail.com>
In-Reply-To: <dd18b0c30902201510n105c5c0kc1791b9ba1741aea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2158806.TxGat0x2FW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200902211351.28303.linuxweb@gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--nextPart2158806.TxGat0x2FW
Content-Type: multipart/mixed;
  boundary="Boundary-01=_dZ5nJ67SyyZcQSe"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_dZ5nJ67SyyZcQSe
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

If you don't have the system-auth file and you're still able to login then=
=20
either your system is not really using PAM or login doesn't reference syste=
m-
auth.
But from what I remember system-auth is not installed by default and you ha=
ve=20
to write it yourself.
The default login-PAM-config, from the shadow-package, does reference syste=
m-
auth, so I think login should fail if your system really uses PAM.

When did you compile PAM? It should be compiled before shadow, so that shad=
ow=20
can be compiled with PAM-support.

Also, which getty are you using? You should install mingetty, or you'll run=
=20
into lots of problems that are caused by agetty under SELinux.

As said, check your coreutils, notably id and ls, if they reference the=20
SELinux-libs. If not you'll need to compile them again.

Plugging SELinux into LFS is a bit tricky. In order not to have to compile =
too=20
much twice you got to compile stuff in the right place during the process.

I have attached my stage2-script for your reference. This is the order I=20
compile my system in.
I've got a lot of optional stuff in there, so simply disregard anything you=
=20
don't need.

Also, just out of curiosity: You're doing LFS to learn about the internals =
or=20
do you just want to get an LFS-system with SELinux?
In the latter case maybe I could interest you in my project, which also the=
=20
attached script is taken from, EasyLFS.

Regards,
Dennis

On Saturday 21 February 2009 07:10:37 Justin Mattock wrote:
> On Fri, Feb 20, 2009 at 7:20 AM, Dennis Wronka <linuxweb@gmx.net> wrote:
> > Are the coreutils compiled with SELinux-support?
> > I just gave it a quick check and found that the -Z option is available =
in
> > both id and ls without coreutils having actually been built without
> > SELinux- libraries actually available.
> >
> > Could you check this:
> > ldd $(which ls)
> >
> > This should show up a reference to libselinux.so.1
> > If this reference is missing then I'd suggest recompiling the coreutils.
> >
> > On Friday 20 February 2009 23:03:37 you wrote:
> >> On Fri, Feb 20, 2009 at 6:14 AM, Stephen Smalley <sds@tycho.nsa.gov>=20
wrote:
> >> > On Thu, 2009-02-19 at 23:04 -0800, Justin Mattock wrote:
> >> >> I've a strange issue.
> >> >> with my experimental learning machine(LFS)
> >> >> I'm able to load the policy etc.. but have no labels
> >> >> on my files.(just a question mark);
> >> >>
> >> >>
> >> >> ls -lZ shows
> >> >>
> >> >> drwxr-xr-x   2 root root ?  4096 Feb 18 11:19 bin
> >> >> drwxr-xr-x   3 root root ?  4096 Feb 19 22:36 boot
> >> >> lrwxrwxrwx   1 root  999 ?    11 Feb  9 16:34 cdrom -> media/cdrom
> >> >> drwxr-xr-x  17 root root ?  4120 Feb 19 22:42 dev
> >> >> drwxr-xr-x  28 root root ?  4096 Feb 19 22:47 etc
> >> >> drwxr-xr-x   4 root root ?  4096 Feb 19 22:36 home
> >> >> drwxr-xr-x   4 root root ?  4096 Feb 18 11:19 include
> >> >> drwxr-xr-x  10 root root ?  4096 Feb 19 18:52 lib
> >> >> drwx------   2 root root ? 16384 Feb  9 16:34 lost+found
> >> >> drwxr-xr-x   3 root root ?  4096 Feb 19 22:42 media
> >> >> drwxr-xr-x   3 root root ?  4096 Feb 11 12:09 mnt
> >> >> drwxr-xr-x   2 root root ?  4096 Feb 10 09:54 opt
> >> >> dr-xr-xr-x 113 root root ?     0 Feb 19 22:42 proc
> >> >> drwxr-xr-x   5 root root ?  4096 Feb 18 11:24 root
> >> >> drwxr-xr-x   2 root root ?  4096 Feb 19 21:11 sbin
> >> >> drwxr-xr-x   7 root root ?     0 Feb 19 22:42 selinux
> >> >> drwxr-xr-x   8 root root ?  4096 Feb 18 11:19 share
> >> >> drwxr-xr-x   2 root root ?  4096 Feb 10 09:54 srv
> >> >> drwxr-xr-x  12 root root ?     0 Feb 19 22:42 sys
> >> >> drwxrwxrwt   5 root root ?  4096 Feb 19 22:50 tmp
> >> >> drwxr-xr-x   6 root root ?  4096 Feb 11 12:05 tools
> >> >> drwxr-xr-x  14 root root ?  4096 Feb 14 10:09 usr
> >> >> drwxr-xr-x  10 root root ?  4096 Feb 18 22:31 var
> >> >> lrwxrwxrwx   1 root root ?    24 Feb 10 13:11 vmlinuz ->
> >> >> /boot/vmlinuz-2.6.29-rc4
> >> >>
> >> >> if I do a id -Z I get:
> >> >> id: --context (-Z) works only on an SELinux-enabled kernel
> >> >> (but it is enabled in the kernel)
> >> >
> >> > sestatus shows what?
> >> >
> >> > To be fully "enabled" as far as userspace is concerned, SELinux has =
to
> >> > be:
> >> > - enabled in your kernel build,
> >> > - enabled at boot,
> >> > - policy has to be loaded
> >> >
> >> > grep SELINUX .config
> >> > cat /etc/selinux/config
> >> > dmesg | grep SELinux
> >> >
> >> >> >From looking back, I enabled as much as possible in any app/lib I
> >> >> > was compiling
> >> >>
> >> >> that provided selinux support.(libc,xserver,hal,dbus, etc..);
> >> >> But could be missing an important app/lib that might make the
> >> >> security labels give the proper label. by chance if anybody had
> >> >> experienced this and/or knows what might be going on,(would be real=
ly
> >> >> appreciated).
> >> >>
> >> >> regards;
> >> >
> >> > --
> >> > Stephen Smalley
> >> > National Security Agency
> >>
> >> Thanks for the reply.
> >> here's what /usr/sbin/sestatus -vv (says);
> >>
> >> SELinux status:                 enabled
> >> SELinuxfs mount:                /selinux
> >> Current mode:                   permissive
> >> Mode from config file:          permissive
> >> Policy version:                 22
> >> Policy from config file:        refpolicy
> >>
> >> Process contexts:
> >> Current context:                system_u:system_r:local_login_t
> >> Init context:                   system_u:system_r:init_t
> >>
> >> File contexts:
> >> Controlling term:               system_u:object_r:devpts_t
> >> /etc/passwd                     system_u:object_r:etc_t
> >> /bin/bash                       system_u:object_r:shell_exec_t
> >> /bin/login                      system_u:object_r:login_exec_t
> >> /bin/sh                         system_u:object_r:bin_t ->
> >> system_u:object_r:shell_exec_t
> >> /sbin/agetty                    system_u:object_r:getty_exec_t
> >> /sbin/init                      system_u:object_r:init_exec_t
> >> /lib/libc.so.6                  system_u:object_r:lib_t ->
> >> system_u:object_r:lib_t
> >> /lib/ld-linux.so.2              system_u:object_r:lib_t ->
> >> system_u:object_r:ld_so_t
> >>
> >> I think this is some aterm,xproto,etc.. library/app(that I forgot to
> >> install) that's responsible for displaying the security label info in
> >> the shell.(example) when I use
> >> audit2allow -d, I generate the correct security allow rules.
> >> when running make relabel in the policy source directory, reacts as it
> >> should.
> >>
> >> As for setting any options in the kernel. no
> >> left everything as I've had in the past.
> >> as for enabling everything. yes
> >> - enabled in your kernel build,
> >> - enabled at boot,
> >> - policy has to be loaded
> >>
> >> I'll try adding these rules into the policy irregardless of a
> >> broken proto/low level communications thing.
> >> didn't mean to causing any heat.
> >>
> >> regards;
>
> After looking at the situation, and looking at the
> (LFS)manual at first you setup shadow with a root
> password(to get things going); then later once you're up
> and running you move from using shadow to useing pam.
> well I've managed to do that.
> but  I'm not seeing a /etc/pam.d/system-auth file
> generated by the installer(probably have to manually pick my
> session,password, account modules);
> (positive side)
> under ps aux (Ill have to attach them(before/after) as soon as I get a
> chance); I finally see:   /bin/login --
> So hopefully once I get /etc/pam.d cleaned up(hopefully) I
> should be logged into my SELinux user and have the right context.
> keep in mind "hopefully".
> regards;



--Boundary-01=_dZ5nJ67SyyZcQSe
Content-Type: application/x-shellscript;
  name="lfs_stage2.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lfs_stage2.sh"

#!/tools/bin/sh


. /lfs-install/lfs_config.sh
. /lfs-install/modules/lfs_deps.sh

PATCHPATH=/sources/patches
LFS_USE_SELINUX_PATCHES=y

. /lfs-install/modules/stage2/directories.sh
. /lfs-install/modules/stage2/symlinks.sh
. /lfs-install/modules/stage2/passwd_files.sh
. /lfs-install/modules/stage2/dev.sh
. /lfs-install/modules/stage2/build_directory.sh
. /lfs-install/modules/stage2/kernel_headers.sh
. /lfs-install/modules/stage2/man_pages.sh
. /lfs-install/modules/stage2/glibc.sh
. /lfs-install/modules/stage2/toolchain.sh
. /lfs-install/modules/stage2/ustr.sh
. /lfs-install/modules/stage2/libsepol.sh
. /lfs-install/modules/stage2/libselinux.sh
. /lfs-install/modules/stage2/libsemanage.sh
. /lfs-install/modules/stage2/zlib.sh
. /lfs-install/modules/stage2/binutils.sh
. /lfs-install/modules/stage2/gmp.sh
. /lfs-install/modules/stage2/mpfr.sh
. /lfs-install/modules/stage2/gcc.sh
. /lfs-install/modules/stage2/glibc_selinux.sh
. /lfs-install/modules/stage2/sed.sh
. /lfs-install/modules/stage2/e2fsprogs.sh
. /lfs-install/modules/stage2/attr.sh
. /lfs-install/modules/stage2/acl.sh
. /lfs-install/modules/stage2/coreutils.sh
. /lfs-install/modules/stage2/iana_etc.sh
. /lfs-install/modules/stage2/m4.sh
. /lfs-install/modules/stage2/bison.sh
. /lfs-install/modules/stage2/ncurses.sh
. /lfs-install/modules/stage2/procps.sh
. /lfs-install/modules/stage2/grep.sh
. /lfs-install/modules/stage2/libtool.sh
. /lfs-install/modules/stage2/perl.sh
. /lfs-install/modules/stage2/readline.sh
. /lfs-install/modules/stage2/autoconf.sh
. /lfs-install/modules/stage2/automake.sh
. /lfs-install/modules/stage2/bash.sh
. /lfs-install/modules/stage2/bzip2.sh
. /lfs-install/modules/stage2/diffutils.sh
. /lfs-install/modules/stage2/file.sh
. /lfs-install/modules/stage2/gawk.sh
. /lfs-install/modules/stage2/findutils.sh
. /lfs-install/modules/stage2/flex.sh
. /lfs-install/modules/stage2/gettext.sh
. /lfs-install/modules/stage2/groff.sh
. /lfs-install/modules/stage2/gzip.sh
. /lfs-install/modules/stage2/iputils.sh
. /lfs-install/modules/stage2/iproute2.sh
. /lfs-install/modules/stage2/kbd.sh
. /lfs-install/modules/stage2/less.sh
. /lfs-install/modules/stage2/make.sh
. /lfs-install/modules/stage2/man.sh
. /lfs-install/modules/stage2/moduleinittools.sh
. /lfs-install/modules/stage2/patch.sh
. /lfs-install/modules/stage2/psmisc.sh
. /lfs-install/modules/stage2/pam.sh
. /lfs-install/modules/stage2/shadow.sh
. /lfs-install/modules/stage2/sysklogd.sh
. /lfs-install/modules/stage2/sysvinit.sh
. /lfs-install/modules/stage2/tar.sh
. /lfs-install/modules/stage2/texinfo.sh
. /lfs-install/modules/stage2/udev.sh
. /lfs-install/modules/stage2/util_linux_ng.sh
. /lfs-install/modules/stage2/vim.sh
. /lfs-install/modules/stage2/reiserfs.sh
. /lfs-install/modules/stage2/jfs.sh
. /lfs-install/modules/stage2/xfs.sh
. /lfs-install/modules/stage2/pkg_config.sh
. /lfs-install/modules/stage2/openssl.sh
. /lfs-install/modules/stage2/which.sh
. /lfs-install/modules/stage2/nettools.sh
. /lfs-install/modules/stage2/libcap.sh
. /lfs-install/modules/stage2/traceroute.sh
. /lfs-install/modules/stage2/jwhois.sh
. /lfs-install/modules/stage2/glib.sh
. /lfs-install/modules/stage2/python.sh
. /lfs-install/modules/stage2/popt.sh
. /lfs-install/modules/stage2/libuser.sh
. /lfs-install/modules/stage2/mingetty.sh
. /lfs-install/modules/stage2/netkit.sh
#. /lfs-install/modules/stage2/attr.sh
#. /lfs-install/modules/stage2/acl.sh

. /lfs-install/modules/stage2/devicemapper.sh
. /lfs-install/modules/stage2/module_build.sh
. /lfs-install/modules/stage2/po4a.sh
. /lfs-install/modules/stage2/sysfsutils.sh
. /lfs-install/modules/stage2/libusb.sh
. /lfs-install/modules/stage2/sqlite.sh
. /lfs-install/modules/stage2/beecrypt.sh
. /lfs-install/modules/stage2/libxml2.sh
. /lfs-install/modules/stage2/neon.sh
. /lfs-install/modules/stage2/expat.sh
. /lfs-install/modules/stage2/xml_parser.sh
. /lfs-install/modules/stage2/dbus.sh
. /lfs-install/modules/stage2/dbus_glib.sh
. /lfs-install/modules/stage2/swig.sh
. /lfs-install/modules/stage2/libselinux_python.sh
. /lfs-install/modules/stage2/libsemanage_python.sh
. /lfs-install/modules/stage2/slang.sh
. /lfs-install/modules/stage2/tcl.sh
. /lfs-install/modules/stage2/newt.sh
. /lfs-install/modules/stage2/libsmbios.sh
. /lfs-install/modules/stage2/intltool.sh
. /lfs-install/modules/stage2/policykit.sh
. /lfs-install/modules/stage2/cmake.sh
. /lfs-install/modules/stage2/bin86.sh
. /lfs-install/modules/stage2/nasm.sh
. /lfs-install/modules/stage2/lzo.sh

. /lfs-install/modules/stage2/kernel_build_directory.sh
. /lfs-install/modules/stage2/kernel.sh
. /lfs-install/modules/stage2/build_directory.sh

. /lfs-install/modules/stage2/bind.sh
. /lfs-install/modules/stage2/bluez.sh
. /lfs-install/modules/stage2/bridgeutils.sh
. /lfs-install/modules/stage2/cdrkit.sh
. /lfs-install/modules/stage2/cpufrequtils.sh
. /lfs-install/modules/stage2/cronie.sh
. /lfs-install/modules/stage2/cryptsetup.sh
. /lfs-install/modules/stage2/dhcp.sh
. /lfs-install/modules/stage2/dmidecode.sh
. /lfs-install/modules/stage2/dmraid.sh
. /lfs-install/modules/stage2/dosfstools.sh
. /lfs-install/modules/stage2/dpkg.sh
. /lfs-install/modules/stage2/eject.sh
. /lfs-install/modules/stage2/fuse.sh
. /lfs-install/modules/stage2/gnupg.sh
. /lfs-install/modules/stage2/hdparm.sh
. /lfs-install/modules/stage2/ipsec_tools.sh
. /lfs-install/modules/stage2/iptables.sh
. /lfs-install/modules/stage2/joe.sh
. /lfs-install/modules/stage2/kexectools.sh
. /lfs-install/modules/stage2/lmsensors.sh
. /lfs-install/modules/stage2/lvm.sh
. /lfs-install/modules/stage2/lynx.sh
. /lfs-install/modules/stage2/mc.sh
. /lfs-install/modules/stage2/mdadm.sh
. /lfs-install/modules/stage2/nano.sh
. /lfs-install/modules/stage2/ncftp.sh
. /lfs-install/modules/stage2/ntfsprogs.sh
. /lfs-install/modules/stage2/openssh.sh
. /lfs-install/modules/stage2/parted.sh
. /lfs-install/modules/stage2/partimage.sh
. /lfs-install/modules/stage2/pciutils.sh
. /lfs-install/modules/stage2/pcmciautils.sh
. /lfs-install/modules/stage2/ppp.sh
. /lfs-install/modules/stage2/quota.sh
. /lfs-install/modules/stage2/rp_pppoe.sh
. /lfs-install/modules/stage2/rpm.sh
. /lfs-install/modules/stage2/screen.sh
. /lfs-install/modules/stage2/sdparm.sh
. /lfs-install/modules/stage2/policycoreutils.sh
. /lfs-install/modules/stage2/checkpolicy.sh
. /lfs-install/modules/stage2/sepolgen.sh
. /lfs-install/modules/stage2/selinux_policy.sh
. /lfs-install/modules/stage2/slocate.sh
. /lfs-install/modules/stage2/smartmontools.sh
. /lfs-install/modules/stage2/usbutils.sh
. /lfs-install/modules/stage2/hal.sh
. /lfs-install/modules/stage2/wget.sh
. /lfs-install/modules/stage2/wireless_tools.sh
. /lfs-install/modules/stage2/wpa_supplicant.sh
. /lfs-install/modules/stage2/zip.sh
. /lfs-install/modules/stage2/unzip.sh
. /lfs-install/modules/stage2/grub.sh
. /lfs-install/modules/stage2/lilo.sh
. /lfs-install/modules/stage2/strip.sh

echo "stage 2 finished, the next step is logging out using exit or logout"

--Boundary-01=_dZ5nJ67SyyZcQSe--

--nextPart2158806.TxGat0x2FW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmflmAACgkQ1sXw8/2VziTMTACgsbGhp256xryIv6ibj7HZqpwj
ZHsAn3OQ0rZREHtFxBOTltegCYyx2RBS
=mjHK
-----END PGP SIGNATURE-----

--nextPart2158806.TxGat0x2FW--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
