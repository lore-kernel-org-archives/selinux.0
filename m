Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7DFNxrT024315
	for <selinux@tycho.nsa.gov>; Fri, 13 Aug 2004 11:23:59 -0400 (EDT)
Received: from mail.mvalent.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7DFNvRl014289
	for <selinux@tycho.nsa.gov>; Fri, 13 Aug 2004 15:23:57 GMT
Subject: vsftpd and security labels
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 13 Aug 2004 11:23:58 -0400
Message-ID: <E6E16A6D4277CD459BBDE6713766033CA50D95@exchange.mvalent.local>
From: "James R. Marcus" <jmarcus@mvalent.net>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have been working on a problem with running vsftpd on SELinux for a
while now.  My latest error complains about security labels.
I read the FAQ on these types of errors and it said to make sure
/selinux is mounted. 
I recompiled my Kernel removing gr security in effort to resolve a
similar issue.  
When I recompile the kernel to I need to boot to a liveCD and do the
chroot relabel?


I have run this command successfully in the past.
ftp / # emerge sec-policy/selinux-ftpd
Calculating dependencies ...done!
>>> emerge (1 of 1) sec-policy/selinux-ftpd-20040713 to /
>>> md5 src_uri ;-) selinux-ftpd-20040713.tar.bz2
>>> Unpacking source...
>>> Unpacking selinux-ftpd-20040713.tar.bz2 to
/var/tmp/portage/selinux-ftpd-20040713/work
>>> Source unpacked.
 * Backup of policy source is "200408131113-selinux-ftpd.tar.bz2".

>>> Install selinux-ftpd-20040713 into
/var/tmp/portage/selinux-ftpd-20040713/image/ category sec-policy
man:
prepallstrip:
strip: 
>>> Completed installing into
/var/tmp/portage/selinux-ftpd-20040713/image/

>>> Merging sec-policy/selinux-ftpd-20040713 to /
sfperms
selinux
>>> Setting SELinux security labels
/usr/sbin/setfiles:  read 570 specifications
/usr/sbin/setfiles:  invalid context system_u:object_r:ftpd_exec_t on
line number 596
/usr/sbin/setfiles:  invalid context system_u:object_r:ftpd_exec_t on
line number 597
/usr/sbin/setfiles:  invalid context system_u:object_r:ftpd_exec_t on
line number 598
/usr/sbin/setfiles:  invalid context system_u:object_r:ftpd_exec_t on
line number 599
/usr/sbin/setfiles:  invalid context system_u:object_r:ftpd_exec_t on
line number 600
/usr/sbin/setfiles:  invalid context system_u:object_r:ftpd_exec_t on
line number 601
/usr/sbin/setfiles:  invalid context system_u:object_r:ftpd_etc_t on
line number 602
/usr/sbin/setfiles:  invalid context system_u:object_r:ftpd_var_run_t on
line number 603
/usr/sbin/setfiles:  invalid context system_u:object_r:ftpd_var_run_t on
line number 604
/usr/sbin/setfiles:  invalid context system_u:object_r:xferlog_t on line
number 605
Exiting after 10 errors.

!!! ERROR: sec-policy/selinux-ftpd-20040713 failed.
!!! Function dyn_preinst, Line 906, Exitcode 1
!!! Failed to set SELinux security labels.

!!! FAILED preinst: 1


ftp / # mount
/dev/hda3 on / type xfs (rw,noatime)
none on /dev type devfs (rw)
none on /selinux type selinuxfs (rw)
none on /proc type proc (rw)
none on /sys type sysfs (rw)
none on /dev/pts type devpts (rw)
none on /dev/shm type tmpfs (rw)




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
