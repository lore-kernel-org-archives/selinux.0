Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7A5dOrT000659
	for <selinux@tycho.nsa.gov>; Tue, 10 Aug 2004 01:39:25 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7A5dLlU020982
	for <selinux@tycho.nsa.gov>; Tue, 10 Aug 2004 05:39:22 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id F0BD061BCC
	for <selinux@tycho.nsa.gov>; Tue, 10 Aug 2004 15:39:17 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 19306-09 for <selinux@tycho.nsa.gov>;
	Tue, 10 Aug 2004 15:39:17 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 42BB661BB4
	for <selinux@tycho.nsa.gov>; Tue, 10 Aug 2004 15:39:17 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 6B32BB59AA
	for <selinux@tycho.nsa.gov>; Tue, 10 Aug 2004 15:39:15 +1000 (EST)
From: Russell Coker <rcoker@redhat.com>
Reply-To: rcoker@redhat.com
To: SE Linux <selinux@tycho.nsa.gov>
Subject: device types
Date: Tue, 10 Aug 2004 15:39:14 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_C+FGBM3kdcMLPRv"
Message-Id: <200408101539.14895.rcoker@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_C+FGBM3kdcMLPRv
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

/u?dev/irlpt[0-9]+     -c      system_u:object_r:tty_device_t

Wouldn't it be more appropriate to have irlpt be printer_device_t?

/u?dev/md.*            -c      system_u:object_r:fixed_disk_device_t

In what situation will a /dev/md* device node be a character device?  The 
block devices are already labelled.  The only device nodes of class chr_file 
labelled with fixed_disk_device_t are for raw devices and a flash device, 
probably neither of which will work properly due to lack of policy.


I have attached a patch which fixes these problems and a couple of other minor 
issues (including making the /dev/*nrft* entries only take one line) and 
adding an entry for /dev/dm-* (which LVM on Fedora seems to create).

Finally I've added a solution to the BSD pty issue.  I've labelled all the 
device nodes as bsdpty_device_t and made domains that don't use such nodes 
have dontaudit rules for them.  This stops programs like sshd from trying all 
of the BSD pty's first and filling the audit logs for no good cause.

I've also filed a bugzilla requesting that the BSD pty nodes be moved to a 
separate package so that SE Linux users can easily remove them.

-- 
http://apac.redhat.com/disclaimer
See above URL for disclaimer.

--Boundary-00=_C+FGBM3kdcMLPRv
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru /usr/src/se/policy/file_contexts/types.fc ./file_contexts/types.fc
--- /usr/src/se/policy/file_contexts/types.fc	2004-08-06 19:08:13.000000000 +1000
+++ ./file_contexts/types.fc	2004-08-10 15:24:51.000000000 +1000
@@ -127,16 +127,17 @@
 /u?dev/urandom		-c	system_u:object_r:urandom_device_t
 /u?dev/capi.*		-c	system_u:object_r:tty_device_t
 /u?dev/dcbri[0-9]+	-c	system_u:object_r:tty_device_t
-/u?dev/irlpt[0-9]+	-c	system_u:object_r:tty_device_t
+/u?dev/irlpt[0-9]+	-c	system_u:object_r:printer_device_t
 /u?dev/ircomm[0-9]+	-c	system_u:object_r:tty_device_t
 /u?dev/isdn.*		-c	system_u:object_r:tty_device_t
 /u?dev/.*tty[^/]*	-c	system_u:object_r:tty_device_t
+/u?dev/[pt]ty[abcdepqrstuvwxyz][0-9a-f]	-c system_u:object_r:bsdpty_device_t
 /u?dev/cu.*		-c	system_u:object_r:tty_device_t
 /u?dev/vcs[^/]*		-c	system_u:object_r:tty_device_t
 /u?dev/ip2[^/]*		-c	system_u:object_r:tty_device_t
-/u?dev/pty.*		-c	system_u:object_r:tty_device_t
 /u?dev/tty		-c	system_u:object_r:devtty_t
 /u?dev/[shmx]d[^/]*	-b	system_u:object_r:fixed_disk_device_t
+/u?dev/dm-[0-9]+	-b	system_u:object_r:fixed_disk_device_t
 /u?dev/sg[0-9]+		-c	system_u:object_r:scsi_generic_device_t
 /u?dev/rd.*		-b	system_u:object_r:fixed_disk_device_t
 /u?dev/i2o/hd[^/]*	-b	system_u:object_r:fixed_disk_device_t
@@ -145,7 +146,6 @@
 /u?dev/ida/[^/]*	-b	system_u:object_r:fixed_disk_device_t
 /u?dev/dasd[^/]*	-b	system_u:object_r:fixed_disk_device_t
 /u?dev/flash[^/]*	-b	system_u:object_r:fixed_disk_device_t
-/u?dev/md.*		-c	system_u:object_r:fixed_disk_device_t
 /u?dev/nb[^/]+		-b	system_u:object_r:fixed_disk_device_t
 /u?dev/ataraid/.*	-b	system_u:object_r:fixed_disk_device_t
 /u?dev/loop.*		-b	system_u:object_r:fixed_disk_device_t
@@ -212,17 +212,13 @@
 /u?dev/amidi.*		-c	system_u:object_r:sound_device_t
 /u?dev/amixer.*		-c	system_u:object_r:sound_device_t
 /u?dev/snd/.*		-c	system_u:object_r:sound_device_t
-/u?dev/rawrft[0-9]	-c	system_u:object_r:tape_device_t
-/u?dev/rft[0-9]		-c	system_u:object_r:tape_device_t
-/u?dev/rmt[0-9].*	-c	system_u:object_r:tape_device_t
 /u?dev/n?[hs]t[0-9].*	-c	system_u:object_r:tape_device_t
-/u?dev/(n?raw)?qft[0-3]	-c	system_u:object_r:tape_device_t
+/u?dev/(n?raw)?[qr]ft[0-3] -c	system_u:object_r:tape_device_t
 /u?dev/n?z?qft[0-3]	-c	system_u:object_r:tape_device_t
 /u?dev/n?tpqic[12].*	-c	system_u:object_r:tape_device_t
 /u?dev/ht[0-1]		-b	system_u:object_r:tape_device_t
 /u?dev/n?osst[0-3].*	-c	system_u:object_r:tape_device_t
 /u?dev/n?pt[0-9]+	-c	system_u:object_r:tape_device_t
-/u?dev/nrft[0-9]+	-c	system_u:object_r:tape_device_t
 /u?dev/tape.*		-c	system_u:object_r:tape_device_t
 /u?dev/usb/scanner.*	-c	system_u:object_r:scanner_device_t
 /u?dev/usb/dc2xx.*	-c	system_u:object_r:scanner_device_t
@@ -230,7 +226,7 @@
 /u?dev/usb/tty.*	-c	system_u:object_r:usbtty_device_t
 /u?dev/mmetfgrab	-c	system_u:object_r:scanner_device_t
 /u?dev/nvidia.*		-c	system_u:object_r:xserver_misc_device_t
-/u?dev/dri(/.*)?	-c	system_u:object_r:dri_device_t
+/u?dev/dri/.+		-c	system_u:object_r:dri_device_t
 /u?dev/radeon		-c	system_u:object_r:dri_device_t
 /u?dev/agpgart		-c	system_u:object_r:agp_device_t
 
@@ -254,7 +250,7 @@
 /etc/group\.lock	--	system_u:object_r:shadow_t
 /etc/shadow.*		--	system_u:object_r:shadow_t
 /etc/gshadow.*		--	system_u:object_r:shadow_t
-/etc/blkid.tab		--	system_u:object_r:etc_runtime_t
+/etc/blkid\.tab		--	system_u:object_r:etc_runtime_t
 /etc/fstab\.REVOKE	--	system_u:object_r:etc_runtime_t
 /etc/HOSTNAME		--	system_u:object_r:etc_runtime_t
 /etc/ioctl\.save	--	system_u:object_r:etc_runtime_t
@@ -318,6 +314,7 @@
 /usr/share/man(/.*)?		system_u:object_r:man_t
 /usr/share/mc/extfs/.*	--	system_u:object_r:bin_t
 /usr/share/texmf/teTeX/bin(/.*)?	system_u:object_r:bin_t
+/usr/share/selinux(/.*)?	system_u:object_r:policy_src_t
 
 #
 # /usr/bin
@@ -495,4 +492,4 @@
 #  The krb5.conf file is always being tested for writability, so
 #  we defined a type to dontautit
 #
-/etc/krb5.conf		--	system_u:object_r:krb5_conf_t
+/etc/krb5\.conf		--	system_u:object_r:krb5_conf_t
diff -ru /usr/src/se/policy/macros/core_macros.te ./macros/core_macros.te
--- /usr/src/se/policy/macros/core_macros.te	2004-07-13 09:08:07.000000000 +1000
+++ ./macros/core_macros.te	2004-08-10 13:37:44.000000000 +1000
@@ -556,6 +556,9 @@
 
 # allow searching /dev/pts
 allow $1_t devpts_t:dir { getattr read search };
+
+# ignore old BSD pty devices
+dontaudit $1_t bsdpty_device_t:chr_file { getattr read write };
 ')
 
 
diff -ru /usr/src/se/policy/types/device.te ./types/device.te
--- /usr/src/se/policy/types/device.te	2004-07-12 23:37:30.000000000 +1000
+++ ./types/device.te	2004-08-10 13:35:56.000000000 +1000
@@ -51,6 +51,10 @@
 type tty_device_t, serial_device, device_type;
 
 #
+# bsdpty_device_t is the type of /dev/[tp]ty[abcdepqrstuvwxyz][0-9a-f]
+type bsdpty_device_t, device_type;
+
+#
 # usbtty_device_t is the type of /dev/usr/tty*
 #
 type usbtty_device_t, serial_device, device_type;

--Boundary-00=_C+FGBM3kdcMLPRv--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
