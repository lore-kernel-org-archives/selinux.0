Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7NLdOrT021645
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 17:39:24 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7NLdMwb013629
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 21:39:22 GMT
Received: from localhost (localhost [127.0.0.1])
	by open.hands.com (Postfix) with ESMTP id 607F0BF8A
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 22:39:23 +0100 (BST)
Received: from open.hands.com ([127.0.0.1])
	by localhost (open [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 28579-06-2 for <selinux@tycho.nsa.gov>;
	Mon, 23 Aug 2004 22:39:21 +0100 (BST)
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id E8CCABF88
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 22:39:20 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BzMi9-0003aC-2v
	for selinux@tycho.nsa.gov; Mon, 23 Aug 2004 22:50:41 +0100
Date: Mon, 23 Aug 2004 22:50:41 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: patch for fsadm
Message-ID: <20040823215041.GC13677@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="R+My9LyyhiUvIEro"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

usb-mount uses sg_map and disktype.

both these programs require some extra stuff.

basically the usb-mount script uses sg_map, disktype and fdisk
to determine info about the usb scsi drive now within its evil
grasp: e.g. the volume name, volume id, and whether the disk
has a partition table on it or whether it _is_ a partition.

so, anyway, these additions were required to not have usb-mount
poo up.

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=fsadm

diff -Naur 
--- default.1.14/domains/program/fsadm.te	2004-08-02 08:28:37.000000000 +0100
+++ current/domains/program/fsadm.te	2004-08-22 17:58:20.000000000 +0100
@@ -117,3 +116,15 @@
 # Access to /initrd devices
 allow fsadm_t { file_t unlabeled_t }:dir rw_dir_perms;
 allow fsadm_t { file_t unlabeled_t }:blk_file rw_file_perms;
+
+# this is for sg_map and disktype
+allow fsadm_t scsi_generic_device_t:chr_file { ioctl read };
+allow fsadm_t tape_device_t:chr_file { read };
+allow fsadm_t removable_device_t:lnk_file { read };
+#allow fsadm_t device_t:chr_file { read ioctl };
+#allow fsadm_t device_t:blk_file { read ioctl getattr };
+
+# /bin/mountpoint to read /dev/shm
+allow fsadm_t devpts_t:dir { search };
+allow fsadm_t tmpfs_t:dir { getattr search };
+
diff -Naur 
--- default.1.14/file_contexts/program/fsadm.fc	2004-08-02 08:28:37.000000000 +0100
+++ current/file_contexts/program/fsadm.fc	2004-08-06 19:03:43.000000000 +0100
@@ -30,5 +30,7 @@
 /sbin/install-mbr	--	system_u:object_r:fsadm_exec_t
 /usr/bin/scsi_unique_id	--	system_u:object_r:fsadm_exec_t
 /usr/bin/raw		--	system_u:object_r:fsadm_exec_t
+/usr/bin/sg_map		--	system_u:object_r:fsadm_exec_t
+/usr/bin/disktype	--	system_u:object_r:fsadm_exec_t
 /sbin/partx		--	system_u:object_r:fsadm_exec_t
 /usr/bin/partition_uuid	--	system_u:object_r:fsadm_exec_t

--R+My9LyyhiUvIEro--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
