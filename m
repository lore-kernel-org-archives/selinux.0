Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h98C7dWt018349
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 08:07:39 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h98C7c7d017012
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 12:07:38 GMT
Received: from unicorn.lemuria.org (c152019.adsl.hansenet.de [213.39.152.19])
        by jazzband.ncsc.mil  with ESMTP id h98C7bRn017009 for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 12:07:37 GMT
Date: Wed, 8 Oct 2003 14:02:28 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov, walters@verbum.org
Subject: Policy patch: /dev/input devices
Message-ID: <20031008140226.A12565@lemuria.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Attached is a small patch to the Debian/unstable default policy, that
may be interesting to other distros as well.

Problem: /dev/event* have the generic device_t type. However, they are
required for some devices that are not happy with /dev/input/mouse* (my
notebook touchpad is one example).

Solution: I've defined a new input_device_t for anything in /dev/input
and modified the appropriate policy files to grant access to these.

While this does lump the /dev/input/[mouse*|mice] devices into it as
well, I don't think there is much problem with that. I don't see what's
to gain in, say, seperating mouse and keyboard devices, and besides,
/dev/input/event* munge them as well.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="inputdevices.diff"

diff -ru default/domains/program/gpm.te current/domains/program/gpm.te
--- default/domains/program/gpm.te	2003-07-19 22:51:26.000000000 +0200
+++ current/domains/program/gpm.te	2003-10-08 13:50:50.000000000 +0200
@@ -33,6 +33,8 @@
 # Read and write ttys.
 allow gpm_t tty_device_t:chr_file rw_file_perms;
 
-# Access the mouse.
+# Access the mouse and the generic /dev/input devices.
 allow gpm_t mouse_device_t:chr_file rw_file_perms;
+allow gpm_t input_device_t:chr_file rw_file_perms;
+
 
diff -ru default/domains/program/initrc.te current/domains/program/initrc.te
--- default/domains/program/initrc.te	2003-07-19 22:51:25.000000000 +0200
+++ current/domains/program/initrc.te	2003-10-08 13:50:05.000000000 +0200
@@ -213,8 +213,9 @@
 #
 allow initrc_t fs_type:filesystem { quotamod quotaget };
 
-# Access the mouse (for kudzu).
+# Access the mouse and other input devices (for kudzu).
 allow initrc_t mouse_device_t:chr_file rw_file_perms;
+allow initrc_t input_device_t:chr_file rw_file_perms;
 
 # Allow access to the sysadm TTYs. Note that this will give access to the 
 # TTYs to any process in the initrc_t domain. Therefore, daemons and such
diff -ru default/file_contexts/types.fc current/file_contexts/types.fc
--- default/file_contexts/types.fc	2003-07-19 22:51:27.000000000 +0200
+++ current/file_contexts/types.fc	2003-10-08 13:48:11.000000000 +0200
@@ -137,8 +137,9 @@
 /dev/rtc			system_u:object_r:clock_device_t
 /dev/psaux			system_u:object_r:mouse_device_t
 /dev/.*mouse.*	-c		system_u:object_r:mouse_device_t
-/dev/input/.*mouse.*		system_u:object_r:mouse_device_t
-/dev/input/mice			system_u:object_r:mouse_device_t
+#/dev/input/.*mouse.*		system_u:object_r:mouse_device_t
+#/dev/input/mice		system_u:object_r:mouse_device_t
+/dev/input/.*			system_u:object_r:input_device_t
 /dev/ptmx			system_u:object_r:ptmx_t
 /dev/sequencer			system_u:object_r:misc_device_t
 /dev/fb[0-9]*			system_u:object_r:framebuf_device_t
diff -ru default/macros/program/xserver_macros.te current/macros/program/xserver_macros.te
--- default/macros/program/xserver_macros.te	2003-07-19 22:51:28.000000000 +0200
+++ current/macros/program/xserver_macros.te	2003-10-08 13:49:37.000000000 +0200
@@ -150,8 +150,9 @@
 # Type for tmpfs/shm files.
 tmpfs_domain($1_xserver)
 
-# Use the mouse.
+# Use the mouse and other input devices.
 allow $1_xserver_t mouse_device_t:chr_file rw_file_perms;
+allow $1_xserver_t input_device_t:chr_file rw_file_perms;
 
 ifelse($1, xdm, `
 dontaudit xdm_xserver_t sysadm_home_dir_t:dir { read search };
diff -ru default/macros/user_macros.te current/macros/user_macros.te
--- default/macros/user_macros.te	2003-07-19 22:51:28.000000000 +0200
+++ current/macros/user_macros.te	2003-10-08 13:49:08.000000000 +0200
@@ -181,8 +181,9 @@
 file_type_auto_trans(vmware_user_t, $1_home_dir_t, vmware_user_file_t)
 ')
 
-# Read the mouse.
+# Read the mouse and other input devices.
 allow $1_t mouse_device_t:chr_file r_file_perms;
+allow $1_t input_device_t:chr_file r_file_perms;
 # Access other miscellaneous devices.
 allow $1_t misc_device_t:file_class_set rw_file_perms;
 
diff -ru default/types/device.te current/types/device.te
--- default/types/device.te	2003-07-19 22:51:28.000000000 +0200
+++ current/types/device.te	2003-10-08 13:54:51.000000000 +0200
@@ -90,6 +90,11 @@
 type mouse_device_t, file_type;
 
 #
+# Generic input device type, for /dev/input
+#
+type input_device_t, file_type;
+
+#
 # Not sure what these devices are for, but X wants access to them.
 #
 type agp_device_t, file_type;
 

--pWyiEgJYm5f9v55/--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
