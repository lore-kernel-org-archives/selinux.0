Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6RMaErT006226
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 18:36:15 -0400 (EDT)
Received: from mail.gmx.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i6RMaDup021659
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 22:36:13 GMT
Received: from localhost (shorty@debby [127.0.0.1])
	by localhost.localdomain (8.12.11/8.12.11/Debian-5) with ESMTP id i6RMaDNN025079
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 00:36:14 +0200
Subject: SeLinux packages compiled smoothly on ppc (after some help ..)
From: Wolfgang Pfeiffer <roto@gmx.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1090967773.7271.2017.camel@debby>
Mime-Version: 1.0
Date: Wed, 28 Jul 2004 00:36:13 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all

With the patches/packages from (IIRC :)
http://www.coker.com.au/newselinux/
it's possible to build these binaries on ppc (on Debian/unstable and a
Powerbook G4):

cron_3.0pl1-83.se1_powerpc.deb
dpkg-dev_1.10.22_all.deb
dpkg-doc_1.10.22_all.deb
dpkg_1.10.22_powerpc.deb
dselect_1.10.22_powerpc.deb
logrotate_3.7-2.se1_powerpc.deb
libpam-cracklib_0.77-0.se5_powerpc.deb
libpam-doc_0.77-0.se5_all.deb
libpam-modules_0.77-0.se5_powerpc.deb
libpam-runtime_0.77-0.se5_all.deb
libpam0g-dev_0.77-0.se5_powerpc.deb
libpam0g_0.77-0.se5_powerpc.deb
openssh-client-udeb_3.8.1p1-7_powerpc.udeb
openssh-server-udeb_3.8.1p1-7_powerpc.udeb
ssh-askpass-gnome_3.8.1p1-7_powerpc.deb
ssh_3.8.1p1-7_powerpc.deb
initscripts_2.85-22.se2_powerpc.deb
sysv-rc_2.85-22.se2_all.deb
sysvinit_2.85-22.se2_powerpc.deb


FYI:
Not all of them built with the same compiler, provided I didn't make any
other mistake. 
For example:

fakeroot apt-get source --compile dpkg=1.10.22-se1

works not with 2.95, but with 3.4.
The build with 2.95 ended with:
______________________________________
checking for initscr in -lncurses... yes
checking if TIOCNOTTY is defined in sys/ioctl.h... yes
checking for va_copy... no
checking for va_list assignment copy... configure: error: no
make: *** [/home/shorty/testone/dpkg-1.10.22/build/configure-stamp] Error 1
Build command 'cd dpkg-1.10.22 && dpkg-buildpackage -b -uc' failed.
E: Child process failed
______________________________________



And this:
I patched the openssh sources only with the openssh-selinux.patch.gz
and *not* with the 
ssh.diff.gz
that can be found in the same directory on
http://www.coker.com.au/newselinux/

Like that:
---------------------------------
apt-get source openssh
cd openssh-3.8.1p1/
cp ../../openssh-selinux.patch.gz .

$ gzip -cd openssh-selinux.patch.gz | patch -p1
patching file contrib/redhat/sshd.init
patching file configure.ac
Hunk #2 succeeded at 2924 (offset -2 lines).
patching file sshpty.c
patching file config.h.in
patching file Makefile.in
patching file session.c
$

fakeroot debian/rules binary

-----------------------------------------

I hope the latter procedure is OK ....

And please let me know in case someone would like to upload ppc packages
like the ones above. With detailed guidance on how exactly to build them
I'd enjoy to help here, and make them available for others, too ...

Best Regards
And Thanks for your work ..

Wolfgang
-- 
Profile, links: http://profiles.yahoo.com/wolfgangpfeiffer


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
