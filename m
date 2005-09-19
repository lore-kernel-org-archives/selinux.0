Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8JBJPNs016621
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 07:19:25 -0400 (EDT)
Received: from crisium.vnl.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8JBFS6H006291
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 11:15:28 GMT
Date: Mon, 19 Sep 2005 12:15:31 +0100
From: Dale Amon <amon@vnl.com>
To: Dale Amon <amon@vnl.com>, selinux@tycho.nsa.gov
Subject: Re: State of Debian SELinux
Message-ID: <20050919111531.GA16633@vnl.com>
References: <20050917233111.GA17916@vnl.com> <20050918001512.GR9092@lkcl.net> <20050918095806.GC25649@vnl.com> <20050918104219.GW9092@lkcl.net> <20050918215841.GA7480@vnl.com> <20050918224850.GZ9092@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
In-Reply-To: <20050918224850.GZ9092@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 18, 2005 at 11:48:50PM +0100, Luke Kenneth Casson Leighton wrot=
e:
> On Sun, Sep 18, 2005 at 10:58:41PM +0100, Dale Amon wrote:
>=20
> > >  selinux=3D1 enabled=3D0
> >=20
> > Actually, its enforcing=3D0.=20
>=20
>  it's been a while :)
>=20
> > And unfortuneately that doesn't help.
> > I still get the same error messages as before. =20
>=20
>=20
> > >  it's something to do with failures in the make process which i never
> > >  got to the bottom of - probably some of the libselinux / sepol
> > >  libraries detecting that selinux wasn't enabled, and not allowing
> > >  the build process to proceed properly.
> >=20
> > There is definitely something I am missing with libsepol because
> > there is an error about it which means absolutely nothing to me
> > that causes dselect to give up on installing the default policy.
>=20
>  dselect? ha!  dselect is for wimps.
>=20
>  okay.
>=20
>  describe _exactly_ where you got everything from - what the packages
>  are, etc. how you did the install (you _should_ ideally be messin with
>  the latest linux2.6 nsa source code - kernel, library, etc. but hey if
>  you have found dpkg packages that's cool).
> =20
>  send all info to list.

Okay, you asked for it. First, a fresh install from Debian the 31r0a
sarge i386 net install CD. Take the defaults on pretty much everything
except hostname and partitions. I picked the workstation 3 partition
option. After the reboot, I have tried both doing the immediate=20
update in aptitude for sarge, or bogging out and editing the
sources.list first. The sources.list file is:

	#deb file:///cdrom/ sarge main

	deb http://ftp.ie.debian.org/debian/ sid main
	deb-src http://ftp.ie.debian.org/debian/ sid main
	deb http://www.coker.com.au/newselinux ./

	deb http://security.debian.org/ stable/updates main

Then I either apt-get update and upgrade or do the same
in dselect, depending on mood. Result is the same, the error
I described previously.

The set of packages installed at the moment is:

Desired=3DUnknown/Install/Remove/Purge/Hold
| Status=3DNot/Installed/Config-files/Unpacked/Failed-config/Half-installed
|/ Err?=3D(none)/Hold/Reinst-required/X=3Dboth-problems (Status,Err: upperc=
ase=3Dbad)
||/ Name                               Version               Description
+++-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
ii  adduser                            3.67.0                Add and remove=
 users and groups
ii  amd64-libs                         1.2                   Amd64 shared l=
ibraries for use on i386/x86_6
ii  apt                                0.6.41                Advanced front=
-end for dpkg
ii  apt-utils                          0.6.41                APT utility pr=
ograms
ii  aptitude                           0.2.15.9-6            terminal-based=
 apt frontend
ii  at                                 3.1.9                 Delayed job ex=
ecution and batch processing
ii  base-config                        2.71                  Debian base sy=
stem configurator
ii  base-files                         3.1.7                 Debian base sy=
stem miscellaneous files
ii  base-passwd                        3.5.10                Debian base sy=
stem master password and group
ii  bash                               3.0-16                The GNU Bourne=
 Again SHell
ii  bc                                 1.06-17               The GNU bc arb=
itrary precision calculator la
ii  bin86                              0.16.14-1.2           16-bit x86 ass=
embler and loader
ii  bind9-host                         9.3.1-2               Version of 'ho=
st' bundled with BIND 9.X
ii  binutils                           2.16.1cvs20050902-1   The GNU assemb=
ler, linker and binary utiliti
ii  bison                              2.0-2                 A parser gener=
ator that is compatible with Y
ii  bsdmainutils                       6.1.2                 collection of =
more utilities from FreeBSD
ii  bsdutils                           2.12p-7               Basic utilitie=
s from 4.4BSD-Lite
ii  bwidget                            1.7.0-1               A set of exten=
sion widgets for Tcl/Tk
ii  bzip2                              1.0.2-8.1             high-quality b=
lock-sorting file compressor -
ii  checkpolicy                        1.26-1                SELinux policy=
 compiler
ii  console-common                     0.7.53                Basic infrastr=
ucture for text console config
ii  console-data                       2002.12.04dbs-49      Keymaps, fonts=
, charset maps, fallback table
ii  console-tools                      0.2.3dbs-56           Linux console =
and font utilities
ii  coreutils                          5.2.1-2.1             The GNU core u=
tilities
ii  cpio                               2.6-5                 GNU cpio -- a =
program to manage archives of=20
ii  cpp                                4.0.1-3               The GNU C prep=
rocessor (cpp)
ii  cpp-4.0                            4.0.1-7               The GNU C prep=
rocessor
ii  cramfsprogs                        1.1-6                 Tools for Cram=
Fs (Compressed ROM File System
ii  cron                               3.0pl1-91             management of =
regular background processing
ii  dash                               0.5.2-7               The Debian Alm=
quist Shell
ii  dc                                 1.06-17               The GNU dc arb=
itrary precision reverse-polis
ii  debconf                            1.4.58                Debian configu=
ration management system
ii  debconf-i18n                       1.4.58                full internati=
onalization support for debcon
ii  debconf-utils                      1.4.58                debconf utilit=
ies
ii  debianutils                        2.14.3                Miscellaneous =
utilities specific to Debian
ii  defoma                             0.11.8-0.1            Debian Font Ma=
nager -- automatic font config
ii  dhcp-client                        2.0pl5-19.1           DHCP Client
ii  dictionaries-common                0.50.4                Common utiliti=
es for spelling dictionary too
ii  diff                               2.8.1-11              File compariso=
n utilities
ii  discover1                          1.7.13                hardware ident=
ification system
ii  discover1-data                     1.2005.07.31          hardware lists=
 for libdiscover1
ii  dmidecode                          2.7-2                 Dump Desktop M=
anagement Interface data
ii  dnsutils                           9.3.1-2               Clients provid=
ed with BIND
ii  doc-debian                         3.1.2                 Debian Project=
 documentation, Debian FAQ and
ii  doc-linux-text                     2005.09-1             Linux HOWTOs a=
nd FAQs in ASCII format
ii  dpkg                               1.13.11               package mainte=
nance system for Debian
ii  dpkg-dev                           1.13.11               package buildi=
ng tools for Debian
ii  dselect                            1.13.11               user tool to m=
anage Debian packages
ii  e2fslibs                           1.38-2                ext2 filesyste=
m libraries
ii  e2fsprogs                          1.38-2                ext2 file syst=
em utilities and libraries
ii  ed                                 0.2-20                The classic un=
ix line editor
ii  eject                              2.0.13deb-15          ejects CDs and=
 operates CD-Changers under Li
ii  exim4                              4.52-2                metapackage to=
 ease exim MTA (v4) installati
ii  exim4-base                         4.52-2                support files =
for all exim MTA (v4) packages
ii  exim4-config                       4.52-2                configuration =
for the exim MTA (v4)
ii  exim4-daemon-light                 4.52-2                lightweight ex=
im MTA (v4) daemon
ii  fdutils                            5.5-20050303-1        Linux floppy u=
tilities
ii  file                               4.12-1                Determines fil=
e type using "magic" numbers
ii  findutils                          4.2.25-1              utilities for =
finding files--find, xargs, an
ii  finger                             0.17-8                user informati=
on lookup program
ii  flex                               2.5.31-34             A fast lexical=
 analyzer generator.
ii  fontconfig                         2.3.2-1               generic font c=
onfiguration library
ii  ftp                                0.17-13               The FTP client
ii  g++                                4.0.1-3               The GNU C++ co=
mpiler
ii  g++-4.0                            4.0.1-7               The GNU C++ co=
mpiler
ii  gcc                                4.0.1-3               The GNU C comp=
iler
ii  gcc-3.3-base                       3.3.6-10              The GNU Compil=
er Collection (base package)
ii  gcc-4.0                            4.0.1-7               The GNU C comp=
iler
ii  gcc-4.0-base                       4.0.1-7               The GNU Compil=
er Collection (base package)
ii  gdb                                6.3-6                 The GNU Debugg=
er
ii  gettext-base                       0.14.5-2              GNU Internatio=
nalization utilities for the b
ii  gnu-efi                            3.0a-4                Library for de=
veloping EFI applications
ii  gnupg                              1.4.1-1               GNU privacy gu=
ard - a free PGP replacement
ii  grep                               2.5.1.ds1-6           GNU grep, egre=
p and fgrep
ii  groff-base                         1.18.1.1-10           GNU troff text=
-formatting system (base syste
ii  grub                               0.95+cvs20040624-17   GRand Unified =
Bootloader
ii  gzip                               1.3.5-12              The GNU compre=
ssion utility
ii  hicolor-icon-theme                 0.8-3                 default fallba=
ck theme for FreeDesktop.org i
ii  hostname                           2.91                  utility to set=
/show the host name or domain=20
ii  hotplug                            0.0.20040329-25       Linux Hotplug =
Scripts
ii  iamerican                          3.1.20.0-4            An American En=
glish dictionary for ispell
ii  ibritish                           3.1.20.0-4            A British Engl=
ish dictionary for ispell
ii  ifupdown                           0.6.7                 high level too=
ls to configure network interf
ii  info                               4.7-2.2               Standalone GNU=
 Info documentation browser
ii  initrd-tools                       0.1.82                tools to creat=
e initrd image for prepackaged
ii  initscripts                        2.86.ds1-2            Standard scrip=
ts needed for booting and shut
ii  ipchains                           1.3.10-16             Network firewa=
lling for Linux 2.2.x
ii  iptables                           1.3.3-2               Linux kernel 2=
=2E4+ iptables administration to
ii  iputils-ping                       20020927-2            Tools to test =
the reachability of network ho
ii  ispell                             3.1.20.0-4            International =
Ispell (an interactive spellin
ii  kernel-doc-2.6.8                   2.6.8-16              Linux kernel s=
pecific documentation for vers
ii  kernel-image-2.4.27-2-386          2.4.27-11             Linux kernel i=
mage for version 2.4.27 on 386
ii  kernel-pcmcia-modules-2.4.27-2-386 2.4.27-11             Mainstream PCM=
CIA modules 2.4.27 on 386
ii  kernel-source-2.6.8                2.6.8-16              Linux kernel s=
ource for version 2.6.8 with D
ii  klogd                              1.4.1-17              Kernel Logging=
 Daemon
ii  laptop-detect                      0.12.1                attempt to det=
ect a laptop
ii  less                               382-2                 Pager program =
similar to more
ii  lib64gcc1                          4.0.1-7               GCC support li=
brary (64bit)
ii  lib64stdc++6                       4.0.1-7               The GNU Standa=
rd C++ Library v3 (64bit)
ii  libacl1                            2.2.29-1.0.1          Access control=
 list shared library
ii  libatk1.0-0                        1.10.3-1              The ATK access=
ibility toolkit
ii  libatk1.0-data                     1.10.3-1              Common files f=
or the ATK accessibility toolk
ii  libattr1                           2.4.21-1.0.1          Extended attri=
bute shared library
ii  libbind9-0                         9.3.1-2               BIND9 Shared L=
ibrary used by BIND
ii  libblkid1                          1.38-2                block device i=
d library
ii  libbz2-1.0                         1.0.2-8.1             high-quality b=
lock-sorting file compressor l
ii  libc6                              2.3.5-6               GNU C Library:=
 Shared libraries and Timezone
ii  libc6-dev                          2.3.5-6               GNU C Library:=
 Development Libraries and Hea
ii  libcap1                            1.10-14               support for ge=
tting/setting POSIX.1e capabil
ii  libcomerr2                         1.38-2                common error d=
escription library
ii  libconsole                         0.2.3dbs-56           Shared librari=
es for Linux console and font=20
ii  libdb1-compat                      2.1.3-8               The Berkeley d=
atabase routines [glibc 2.0/2.
ii  libdb3                             3.2.9-22              Berkeley v3 Da=
tabase Libraries [runtime]
ii  libdb4.2                           4.2.52-19             Berkeley v4.2 =
Database Libraries [runtime]
ii  libdb4.3                           4.3.28-3              Berkeley v4.3 =
Database Libraries [runtime]
ii  libdiscover1                       1.7.13                hardware ident=
ification library
ii  libdns20                           9.3.1-2               DNS Shared Lib=
rary used by BIND
ii  libedit2                           2.9.cvs.20050518-2.2  BSD editline a=
nd history libraries
ii  libevent1                          1.1a-1                An asynchronou=
s event notification library
ii  libexpat1                          1.95.8-3              XML parsing C =
library - runtime library
ii  libfontconfig1                     2.3.2-1               generic font c=
onfiguration library (shared l
ii  libfreetype6                       2.1.10-1              FreeType 2 fon=
t engine, shared library files
ii  libfs6                             6.8.2.dfsg.1-7        X Font Server =
library
ii  libft-perl                         1.2-15                Perl module fo=
r the FreeType library
ii  libgc1c2                           6.5-1                 conservative g=
arbage collector for C and C++
ii  libgcc1                            4.0.1-7               GCC support li=
brary
ii  libgcrypt11                        1.2.1-4               LGPL Crypto li=
brary - runtime library
ii  libgdbm3                           1.8.3-2               GNU dbm databa=
se routines (runtime version)
ii  libglade2-0                        2.5.1-2               library to loa=
d .glade files at runtime
ii  libglib2.0-0                       2.8.0-1               The GLib libra=
ry of C routines
ii  libglib2.0-data                    2.8.0-1               Common files f=
or GLib library
ii  libgnutls11                        1.0.16-13.1           GNU TLS librar=
y - runtime library
ii  libgnutls12                        1.2.6-1               the GNU TLS li=
brary - runtime library
ii  libgpg-error0                      1.1-4                 library for co=
mmon error values and messages
ii  libgpmg1                           1.19.6-21             General Purpos=
e Mouse - shared library
ii  libgtk2.0-0                        2.6.10-1              The GTK+ graph=
ical user interface library
ii  libgtk2.0-bin                      2.6.10-1              The programs f=
or the GTK+ graphical user int
ii  libgtk2.0-common                   2.6.10-1              Common files f=
or the GTK+ graphical user int
ii  libice6                            6.8.2.dfsg.1-7        Inter-Client E=
xchange library
ii  libident                           0.22-3                simple RFC1413=
 client library - runtime
ii  libidn11                           0.5.18-1              GNU libidn lib=
rary, implementation of IETF I
ii  libisc9                            9.3.1-2               ISC Shared Lib=
rary used by BIND
ii  libisccc0                          9.3.1-2               Command Channe=
l Library used by BIND
ii  libisccfg1                         9.3.1-2               Config File Ha=
ndling Library used by BIND
ii  libjpeg62                          6b-10                 The Independen=
t JPEG Group's JPEG runtime li
ii  libkrb53                           1.3.6-5               MIT Kerberos r=
untime libraries
ii  libldap-2.2-7                      2.2.26-4              OpenLDAP libra=
ries
ii  libldap2                           2.1.30-11             OpenLDAP libra=
ries
ii  liblocale-gettext-perl             1.05-1                Using libc fun=
ctions for internationalizatio
ii  liblockfile1                       1.06                  NFS-safe locki=
ng library, includes dotlockfi
ii  liblwres1                          9.3.1-2               Lightweight Re=
solver Library used by BIND
ii  liblzo1                            1.08-2                data compressi=
on library
ii  libmagic1                          4.12-1                File type dete=
rmination library using "magic
ii  libncurses5                        5.4-9                 Shared librari=
es for terminal handling
ii  libncurses5-dev                    5.4-9                 Developer's li=
braries and docs for ncurses
ii  libncursesw5                       5.4-9                 Shared librari=
es for terminal handling (wide
ii  libnewt0.51                        0.51.6-31             Not Erik's Win=
dowing Toolkit - text mode win
ii  libnfsidmap1                       0.8-1                 An nfs idmappi=
ng library
ii  libnss-db                          2.2.3pre1-1           NSS module for=
 using Berkeley Databases as a
ii  libopencdk8                        0.5.7-2               Open Crypto De=
velopment Kit (OpenCDK) (runti
ii  libpam-modules                     0.77-0.se5            Pluggable Auth=
entication Modules for PAM
ii  libpam-runtime                     0.77-0.se5            Runtime suppor=
t for the PAM library
ii  libpam0g                           0.77-0.se5            Pluggable Auth=
entication Modules library
ii  libpango1.0-0                      1.8.2-2               Layout and ren=
dering of internationalized te
ii  libpango1.0-common                 1.8.2-2               Modules and co=
nfiguration files for the Pang
ii  libpcap0.7                         0.7.2-7               System interfa=
ce for user-level packet captu
ii  libpcre3                           6.3-1                 Perl 5 Compati=
ble Regular Expression Library
ii  libpng12-0                         1.2.8rel-1            PNG library - =
runtime
ii  libpopt0                           1.7-5                 lib for parsin=
g cmdline parameters
ii  libreadline4                       4.3-16                GNU readline a=
nd history libraries, run-time
ii  libreadline5                       5.0-11                GNU readline a=
nd history libraries, run-time
ii  libsasl2                           2.1.19-1.6            Authentication=
 abstraction library
ii  libselinux1                        1.26-1                SELinux shared=
 libraries
ii  libselinux1-dev                    1.26-1                SELinux develo=
pment headers
ii  libsepol1                          1.8-1                 Security Enhan=
ced Linux policy library for c
ii  libsepol1-dev                      1.8-1                 Security Enhan=
ced Linux policy library and d
rc  libsigc++-1.2-5c102                1.2.5-4               type-safe Sign=
al Framework for C++ - runtime
ii  libsigc++-1.2-5c2                  1.2.5-5               type-safe Sign=
al Framework for C++ - runtime
ii  libslang2                          2.0.4-5               The S-Lang pro=
gramming library - runtime ver
ii  libsm6                             6.8.2.dfsg.1-7        X Window Syste=
m Session Management library
ii  libss2                             1.38-2                command-line i=
nterface parsing library
ii  libssl0.9.7                        0.9.7g-2              SSL shared lib=
raries
ii  libstdc++5                         3.3.6-10              The GNU Standa=
rd C++ Library v3
ii  libstdc++6                         4.0.1-7               The GNU Standa=
rd C++ Library v3
ii  libstdc++6-4.0-dev                 4.0.1-7               The GNU Standa=
rd C++ Library v3 (development
ii  libtasn1-2                         0.2.13-1              Manage ASN.1 s=
tructures (runtime)
ii  libtext-charwidth-perl             0.04-2                get display wi=
dths of characters on the term
ii  libtext-iconv-perl                 1.4-1                 converts betwe=
en character sets in Perl
ii  libtext-wrapi18n-perl              0.06-2                internationali=
zed substitute of Text::Wrap
ii  libtextwrap1                       0.1-3                 text-wrapping =
library with i18n - runtime
ii  libtiff4                           3.7.3-1               Tag Image File=
 Format (TIFF) library
ii  libttf2                            1.4pre.20030402-1.1   FreeType 1, Th=
e FREE TrueType Font Engine, s
ii  libusb-0.1-4                       0.1.10a-21            userspace USB =
programming library
ii  libuuid1                           1.38-2                universally un=
ique id library
ii  libwrap0                           7.6.dbs-8             Wietse Venema'=
s TCP wrappers library
ii  libx11-6                           6.8.2.dfsg.1-7        X Window Syste=
m protocol client library
ii  libxaw8                            6.8.2.dfsg.1-7        X Athena widge=
t set library
ii  libxcursor1                        1.1.3-1               X cursor manag=
ement library
ii  libxext6                           6.8.2.dfsg.1-7        X Window Syste=
m miscellaneous extension libr
ii  libxft2                            2.1.7-1               FreeType-based=
 font drawing library for X
ii  libxi6                             6.8.2.dfsg.1-7        X Window Syste=
m Input extension library
ii  libxinerama1                       6.8.2.dfsg.1-7        X Window Syste=
m multi-head display library
ii  libxml2                            2.6.22-1              GNOME XML libr=
ary
ii  libxmu6                            6.8.2.dfsg.1-7        X Window Syste=
m miscellaneous utility librar
ii  libxp6                             6.8.2.dfsg.1-7        X Window Syste=
m printing extension library
ii  libxpm4                            6.8.2.dfsg.1-7        X pixmap libra=
ry
ii  libxrandr2                         6.8.2.dfsg.1-7        X Window Syste=
m Resize, Rotate and Reflectio
ii  libxrender1                        0.9.0-2               X Rendering Ex=
tension client library
ii  libxt6                             6.8.2.dfsg.1-7        X Toolkit Intr=
insics
ii  linux-doc-2.6.12                   2.6.12-6              Linux kernel s=
pecific documentation for vers
ii  linux-image-2.6-686                2.6.12-6              Linux kernel 2=
=2E6 image on PPro/Celeron/PII/P
ii  linux-image-2.6.12-1-686           2.6.12-6              Linux kernel 2=
=2E6.12 image on PPro/Celeron/PI
ii  linux-image-686                    2.6.12-6              Linux kernel i=
mage on PPro/Celeron/PII/PIII/
ii  linux-kernel-headers               2.6.13+0rc3-1.1       Linux Kernel H=
eaders for development
ii  linux-source-2.6.12                2.6.12-6              Linux kernel s=
ource for version 2.6.12 with=20
ii  locales                            2.3.5-6               GNU C Library:=
 National Language (locale) da
ii  login                              4.0.3-39              system login t=
ools
ii  logrotate                          3.7.1-2               Log rotation u=
tility
ii  lpr                                2005.05.01            BSD lpr/lpd li=
ne printer spooling system
ii  lsb-base                           3.0-6                 Linux Standard=
 Base 3.0 init script function
ii  lsof                               4.76.dfsg.1-1         List open file=
s.
ii  m4                                 1.4.3-2               a macro proces=
sing language
ii  mailx                              8.1.2-0.20050715cvs-1 A simple mail =
user agent
ii  make                               3.80-11               The GNU versio=
n of the "make" utility.
ii  makedev                            2.3.1-78              creates device=
 files in /dev
ii  man-db                             2.4.3-2               The on-line ma=
nual pager
ii  manpages                           2.02-2                Manual pages a=
bout using a GNU/Linux system
ii  manpages-dev                       2.02-2                Manual pages a=
bout using GNU/Linux for devel
ii  mawk                               1.3.3-11              a pattern scan=
ning and text processing langu
ii  mime-support                       3.35-1                MIME files 'mi=
me.types' & 'mailcap', and sup
ii  module-init-tools                  3.2-pre8-1            tools for mana=
ging Linux kernel modules
ii  modutils                           2.4.27.0-3            Linux module u=
tilities
ii  mount                              2.12p-7               Tools for moun=
ting and manipulating filesyst
ii  mpack                              1.6-1.1               tools for enco=
ding/decoding MIME messages
ii  mtools                             3.9.9-2.1             Tools for mani=
pulating MSDOS files
ii  mtr-tiny                           0.69-2                Full screen nc=
urses traceroute tool
ii  mutt                               1.5.10-1              Text-based mai=
lreader supporting MIME, GPG,=20
ii  nano                               1.3.8-2               free Pico clon=
e with some new features
ii  ncurses-base                       5.4-9                 Descriptions o=
f common terminal types
ii  ncurses-bin                        5.4-9                 Terminal-relat=
ed programs and man pages
ii  ncurses-term                       5.4-9                 Additional ter=
minal type definitions
ii  net-tools                          1.60-15               The NET-3 netw=
orking toolkit
ii  netbase                            4.21                  Basic TCP/IP n=
etworking system
ii  netcat                             1.10-27               TCP/IP swiss a=
rmy knife
ii  netkit-inetd                       0.10-10.2             The Internet S=
uperserver
ii  nfs-common                         1.0.7-3               NFS support fi=
les common to client and serve
ii  nvi                                1.79-22               4.4BSD re-impl=
ementation of vi
ii  openssh-client                     4.2p1-4               Secure shell c=
lient, an rlogin/rsh/rcp repla
ii  passwd                             4.0.3-39              change and adm=
inister password and group dat
ii  patch                              2.5.9-2               Apply a diff f=
ile to an original
ii  pciutils                           2.1.11-15.1           Linux PCI Util=
ities
ii  pcmcia-cs                          3.2.8-5               PCMCIA Card Se=
rvices for Linux
ii  perl                               5.8.7-5               Larry Wall's P=
ractical Extraction and Report
ii  perl-base                          5.8.7-5               The Pathologic=
ally Eclectic Rubbish Lister
ii  perl-modules                       5.8.7-5               Core Perl modu=
les
ii  pidentd                            3.0.18-3              TCP/IP IDENT p=
rotocol server with DES suppor
ii  policycoreutils                    1.26-1                SELinux core p=
olicy utilities
ii  portmap                            5-15                  The RPC portma=
pper
ii  ppp                                2.4.3-20050321+2      Point-to-Point=
 Protocol (PPP) daemon
ii  pppconfig                          2.3.11                A text menu ba=
sed utility for configuring pp
ii  pppoe                              3.5-4                 PPP over Ether=
net driver
ii  pppoeconf                          1.7                   configures PPP=
oE/ADSL connections
ii  procmail                           3.22-11               Versatile e-ma=
il processor
ii  procps                             3.2.5-1               /proc file sys=
tem utilities
ii  psmisc                             21.6-1                Utilities that=
 use the proc filesystem
ii  python                             2.3.5-3               An interactive=
 high-level object-oriented la
ii  python-newt                        0.51.6-31             A NEWT module =
for Python
ii  python2.3                          2.3.5-8               An interactive=
 high-level object-oriented la
ii  readline-common                    5.0-11                GNU readline a=
nd history libraries, common f
ii  reportbug                          3.17                  reports bugs i=
n the Debian distribution
ii  sed                                4.1.4-4               The GNU sed st=
ream editor
ii  selinux-doc                        1.22-1                documentation =
for Security-Enhanced Linux
iF  selinux-policy-default             1.18-1                Policy config =
files and management for NSA S
ii  selinux-utils                      1.26-1                SELinux utilit=
y programs
ii  setools                            2.1.2-1               Tresys tools f=
or managing SE Linux
ii  sgml-base                          1.26                  SGML infrastru=
cture and SGML catalog file su
ii  sharutils                          4.2.1-15              shar, unshar, =
uuencode, uudecode
ii  slang1a-utf8                       1.4.9dbs-8            The S-Lang pro=
gramming library with utf8 sup
ii  strace                             4.5.12-1              A system call =
tracer
ii  sysklogd                           1.4.1-17              System Logging=
 Daemon
ii  sysv-rc                            2.86.ds1-2            Standard boot =
mechanism using symlinks in /e
ii  sysvinit                           2.86.ds1-2            System-V like =
init
ii  tar                                1.15.1-2              GNU tar
ii  tasksel                            2.31                  Tool for selec=
ting tasks for installation on
ii  tcl8.4                             8.4.11-1              Tcl (the Tool =
Command Language) v8.4 - run-t
ii  tcpd                               7.6.dbs-8             Wietse Venema'=
s TCP wrapper utilities
ii  tcsh                               6.14.00-1             TENEX C Shell,=
 an enhanced version of Berkel
ii  telnet                             0.17-30               The telnet cli=
ent
ii  texinfo                            4.7-2.2               Documentation =
system for on-line information
ii  time                               1.7-21                The GNU time p=
rogram for measuring cpu resou
ii  tk8.4                              8.4.11-1              Tk toolkit for=
 Tcl and X11, v8.4 - run-time=20
ii  traceroute                         1.4a12-20             traces the rou=
te taken by packets over a TCP
ii  ttf-bitstream-vera                 1.10-3                The Bitstream =
Vera family of free TrueType f
ii  ucf                                2.001                 Update Configu=
ration File: preserves user ch
ii  usbutils                           0.71-5                USB console ut=
ilities
ii  util-linux                         2.12p-7               Miscellaneous =
system utilities
ii  w3m                                0.5.1-4               WWW browsable =
pager with excellent tables/fr
ii  wamerican                          5-4                   American Engli=
sh dictionary words for /usr/s
ii  wget                               1.10.1-1              retrieves file=
s from the web
ii  whiptail                           0.51.6-31             Displays user-=
friendly dialog boxes from she
ii  whois                              4.7.8                 the GNU whois =
client
ii  x-ttcidfont-conf                   18                    Configure True=
Type and CID fonts for X
ii  x11-common                         6.8.2.dfsg.1-7        X Window Syste=
m (X.Org) infrastructure
ii  xlibs-data                         6.8.2.dfsg.1-7        X Window Syste=
m client data
ii  xml-core                           0.09                  XML infrastruc=
ture and XML catalog file supp
ii  xterm                              6.8.2.dfsg.1-7        X terminal emu=
lator
ii  xutils                             6.8.2.dfsg.1-7        X Window Syste=
m utility programs
ii  zile                               2.2.2-1               very small ema=
cs-like editor
ii  zlib1g                             1.2.3-4               compression li=
brary - runtime


--=20
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDLp3TZHES7UL0zXERAjffAJ9XnbrcFoqLka1WhrHTgTL4u8d15gCeOra5
zY1N8eJfUmmg1iQ7w9Ky2Is=
=rXfK
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
