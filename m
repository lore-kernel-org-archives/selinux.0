Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA03597
	for <selinux@tycho.nsa.gov>; Fri, 26 Oct 2001 17:21:38 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA19387
	for <selinux@tycho.nsa.gov>; Fri, 26 Oct 2001 21:19:40 GMT
Received: from hwembaz0021.cas.honeywell.com (hwembaz0021.cas.honeywell.com [129.239.31.124])
	by jazzswing.ncsc.mil  with ESMTP id VAA19383
	for <selinux@tycho.nsa.gov>; Fri, 26 Oct 2001 21:19:39 GMT
Message-ID: <4B2A46240C7CD311830C0090279C31E301D7807C@az15m09.iac.honeywell.com>
From: "White, Tom (AZ15)" <tom.white@honeywell.com>
To: selinux@tycho.nsa.gov
Subject: RE: Problems with install
Date: Fri, 26 Oct 2001 14:29:01 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I just downloaded the most recent package from the nsa.gov website. I have
lsm-selinux-200110161355. I removed the previous version from the system and
gave it another shot. I went through the build successfully. I also make it
through the install in ../selinux/module. I then edited my
../selinux/policy/users file replacing the example users with two users that
have accounts on the box. Then I try to make and get:

[root@warthog policy]# make
cat types/device.te types/devpts.te types/file.te types/network.te
types/nfs.te types/procfs.te types/security.te > all_
types.te
cat domains/system/apache.te domains/system/apmd.te domains/system/atd.te
domains/system/automount.te domains/system/car
dmgr.te domains/system/crond.te domains/system/ftpd.te domains/system/gdm.te
domains/system/getty.te domains/system/gpm.
te domains/system/hwclock.te domains/system/inetd.te
domains/system/initrc.te domains/system/init.te domains/system/ipse
c.te domains/system/kernel.te domains/system/klogd.te domains/system/kmod.te
domains/system/login.te domains/system/lpd.
te domains/system/mount.te domains/system/named.te domains/system/portmap.te
domains/system/pump.te domains/system/rlogi
nd.te domains/system/rpcd.te domains/system/rshd.te
domains/system/sendmail.te domains/system/sshd.te domains/system/sys
logd.te domains/system/tcpd.te domains/system/xfs.te
domains/system/ypbind.te > system_domains.te
cat domains/program/crontab.te domains/program/fsadm.te
domains/program/gnome-pty-helper.te domains/program/ifconfig.te
domains/program/logrotate.te domains/program/lpr.te domains/program/mail.te
domains/program/modutil.te domains/program/n
etscape.te domains/program/newrole.te domains/program/passwd.te
domains/program/ping.te domains/program/run_init.te doma
ins/program/ssh.te domains/program/su.te domains/program/utempter.te
domains/program/xserver.te > program_domains.te
cat domains/user/user.te > user_domains.te
cat domains/admin/sysadm.te > admin_domains.te
cat domains/every.te system_domains.te program_domains.te user_domains.te
admin_domains.te > all_domains.te
rm -f system_domains.te program_domains.te user_domains.te admin_domains.te
cat macros.te all_types.te all_domains.te assert.te > all.te
rm -f all_types.te all_domains.te
m4 -s /usr/local/selinux/flask/security_classes
/usr/local/selinux/flask/initial_sids /usr/local/selinux/flask/access_ve
ctors all.te rbac users constraints initial_sid_contexts fs_contexts
devfs_contexts net_contexts > policy.conf
/usr/local/selinux/bin/checkpolicy -o policy policy.conf
/usr/local/selinux/bin/checkpolicy:  loading policy configuration from
policy.conf
make: *** [policy] Illegal instruction (core dumped)

I know I must be doing something wrong, but I don't know what. Any ideas?
Thanks for the help.

-----Original Message-----
From: Dave Nielsen [mailto:dave@technogeeks.com]
Sent: Wednesday, October 24, 2001 4:52 PM
Cc: White, Tom (AZ15); selinux@tycho.nsa.gov
Subject: Re: Problems with install




On Wed, 24 Oct 2001, Stephen Smalley wrote:

=>
=>On Wed, 24 Oct 2001, White, Tom (AZ15) wrote:
=>
=>> I am trying to implement the SELinux patch on a Red Hat 7.1 box. I did
the
=>> Kernel build following the documentation on the NSA web site.  I got to
step
=>> 2 in the INSTALLING section and when I do a make install in the module
=>> directory I get the following output:
=>
=>Which release of SELinux are you using, and which download option did you
=>use?
=>
my guess is he is trying one that was before the 2.4.10 release.

=>> [root@warthog module]# make install
=>> rm -f selinux_plug/include/asm selinux_plug/arch/machine
=>> ( cd selinux_plug/include ; ln -sf asm-i386 asm)
=>> ( cd selinux_plug/arch ; ln -sf i386 machine)
=>
=>Based on this output, it looks like you are using an older release.
=>As of the most recent release, the creation of the architecture symbolic
=>links was moved into the selinux_plug Makefiles.  In any event, this
=>should have happened during the kernel build, so something is wrong here.

The out put looks like Pre 2.4.10 package. I Had these issues with both
options on the pre 2.4.10.

I would like to say I have a fix for you besides downloading the 2.4.10 or
better yet the newest one that is out right now. I had the problem and
then the next day 2.4.10 was release.

=>
=>> cd ../../lsm/include/asm; install unistd.h
/usr/local/selinux/include/asm
=>> cd selinux_plug/ss; install checkpolicy /usr/local/selinux/bin
=>> install: cannot stat `checkpolicy': No such file or directory
=>> make: *** [install] Error 1
=>
=>The checkpolicy program should have been compiled during the kernel build.
=>Again, this suggests that your kernel build didn't really succeed.  Did
=>you enable SELinux in the kernel configuration?
=>

Dave

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
