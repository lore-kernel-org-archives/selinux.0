Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA8HXlIi017490
	for <selinux@tycho.nsa.gov>; Mon, 8 Nov 2004 12:33:47 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA8HWLC8019867
	for <selinux@tycho.nsa.gov>; Mon, 8 Nov 2004 17:32:24 GMT
Message-ID: <418FADF1.70009@redhat.com>
Date: Mon, 08 Nov 2004 12:33:37 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: jwcart2@epoch.ncsc.mil, Russell Coker <russell@coker.com.au>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Small patch to allow pam_console handle /dev/pmu
References: <41741A2C.8040408@redhat.com>	 <200410260138.19426.russell@coker.com.au>	 <20041025213122.GA2535@jmh.mhn.de>	 <200410270036.14935.russell@coker.com.au> <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil> <418C5FEF.8060102@redhat.com>
In-Reply-To: <418C5FEF.8060102@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------090606090905010305020205"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090606090905010305020205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------090606090905010305020205
Content-Type: text/x-patch;
 name="policy-1.18.2-pmu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-1.18.2-pmu.patch"

diff -u -r policy-1.18.2/domains/program/unused/pamconsole.te policy-1.18.2.new/domains/program/unused/pamconsole.te
--- policy-1.18.2/domains/program/unused/pamconsole.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.new/domains/program/unused/pamconsole.te	2004-11-08 12:27:01.200075563 -0500
@@ -24,7 +24,7 @@
 allow pam_console_t device_t:dir { getattr read };
 allow pam_console_t device_t:lnk_file { getattr read };
 # mouse_device_t is for joy sticks
-allow pam_console_t { framebuf_device_t v4l_device_t apm_bios_t sound_device_t misc_device_t tty_device_t scanner_device_t mouse_device_t removable_device_t scsi_generic_device_t }:chr_file { getattr setattr };
+allow pam_console_t { framebuf_device_t v4l_device_t apm_bios_t sound_device_t misc_device_t tty_device_t scanner_device_t mouse_device_t power_device_t removable_device_t scsi_generic_device_t }:chr_file { getattr setattr };
 allow pam_console_t { removable_device_t fixed_disk_device_t }:blk_file { getattr setattr };
 
 allow pam_console_t mnt_t:dir r_dir_perms;
diff -u -r policy-1.18.2/file_contexts/types.fc policy-1.18.2.new/file_contexts/types.fc
--- policy-1.18.2/file_contexts/types.fc	2004-11-08 12:30:07.495998998 -0500
+++ policy-1.18.2.new/file_contexts/types.fc	2004-11-08 12:28:21.830953399 -0500
@@ -202,6 +202,7 @@
 /u?dev/fb[0-9]*		-c	system_u:object_r:framebuf_device_t
 /u?dev/apm_bios		-c	system_u:object_r:apm_bios_t
 /u?dev/cpu/mtrr		-c	system_u:object_r:mtrr_device_t
+/u?dev/pmu		-c	system_u:object_r:power_device_t
 /u?dev/(radio|video|vbi|vtx).* -c	system_u:object_r:v4l_device_t
 /u?dev/winradio.	-c	system_u:object_r:v4l_device_t
 /u?dev/vttuner		-c	system_u:object_r:v4l_device_t
diff -u -r policy-1.18.2/types/device.te policy-1.18.2.new/types/device.te
--- policy-1.18.2/types/device.te	2004-11-05 23:39:10.000000000 -0500
+++ policy-1.18.2.new/types/device.te	2004-11-08 12:27:25.530322964 -0500
@@ -130,6 +130,8 @@
 # Type for /dev/cpu/mtrr
 type mtrr_device_t, device_type, dev_fs;
 
+# Type for /dev/pmu 
+type power_device_t, device_type, dev_fs;
 
 # Type for /dev/apm_bios
 type apm_bios_t, device_type, dev_fs;

--------------090606090905010305020205--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
