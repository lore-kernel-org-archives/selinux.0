Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72CYZrT011505
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 08:34:35 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i72CYVKV008637
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 12:34:32 GMT
From: Russell Coker <rcoker@redhat.com>
Reply-To: rcoker@redhat.com
To: SE Linux <selinux@tycho.nsa.gov>
Subject: a trivial patch
Date: Mon, 2 Aug 2004 22:34:23 +1000
Cc: Stephen Smalley <sds@epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PTjDBWgkC1R5PXr"
Message-Id: <200408022234.23408.rcoker@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_PTjDBWgkC1R5PXr
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Steve, please check this in the CVS.

-- 
http://apac.redhat.com/disclaimer
See above URL for disclaimer.

--Boundary-00=_PTjDBWgkC1R5PXr
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru /usr/src/se/policy/domains/program/dmesg.te ./domains/program/dmesg.te
--- /usr/src/se/policy/domains/program/dmesg.te	2004-07-12 23:37:25.000000000 +1000
+++ ./domains/program/dmesg.te	2004-07-27 17:03:42.000000000 +1000
@@ -23,3 +23,6 @@
 allow dmesg_t sysadm_tty_device_t:chr_file { ioctl };
 allow dmesg_t var_log_t:file { getattr write };
 read_locale(dmesg_t)
+
+# for when /usr is not mounted
+dontaudit dmesg_t file_t:dir search;
diff -ru /usr/src/se/policy/domains/program/hostname.te ./domains/program/hostname.te
--- /usr/src/se/policy/domains/program/hostname.te	2004-05-12 05:10:33.000000000 +1000
+++ ./domains/program/hostname.te	2004-07-27 17:05:00.000000000 +1000
@@ -19,3 +19,6 @@
 allow hostname_t self:unix_stream_socket create_stream_socket_perms;
 dontaudit hostname_t var_t:dir search;
 allow hostname_t fs_t:filesystem getattr;
+
+# for when /usr is not mounted
+dontaudit hostname_t file_t:dir search;
diff -ru /usr/src/se/policy/domains/program/unused/amavis.te ./domains/program/unused/amavis.te
--- /usr/src/se/policy/domains/program/unused/amavis.te	2004-03-18 15:36:08.000000000 +1100
+++ ./domains/program/unused/amavis.te	2004-07-21 19:08:13.000000000 +1000
@@ -18,6 +18,7 @@
 
 allow initrc_t amavisd_lib_t:dir { search read write rmdir remove_name unlink };
 allow initrc_t amavisd_lib_t:file unlink;
+allow initrc_t amavisd_var_run_t:dir setattr;
 allow amavisd_t self:capability { chown dac_override setgid setuid };
 
 allow amavisd_t usr_t:{ file lnk_file } { getattr read };

--Boundary-00=_PTjDBWgkC1R5PXr--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
