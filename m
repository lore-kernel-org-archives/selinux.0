Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6B90drT026891
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 05:00:39 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6B90ZSC017266
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 09:00:36 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id BBB2261C9E
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 19:00:35 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 18827-05 for <selinux@tycho.nsa.gov>;
	Sun, 11 Jul 2004 19:00:35 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 32FAA61C9D
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 19:00:35 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id E068DB5A98
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 19:00:33 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: device_type vs file_type
Date: Sun, 11 Jul 2004 19:00:33 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xGQ8AH5pCW7r2tk"
Message-Id: <200407111900.33374.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_xGQ8AH5pCW7r2tk
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch removes the file_type attribute from the types for device 
nodes.

In most cases rules using file_type are not intended to catch the types for 
device nodes as well so this should make things simpler.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_xGQ8AH5pCW7r2tk
Content-Type: text/x-diff;
  charset="us-ascii";
  name="device.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="device.diff"

diff -ru types/device.te types/device.te
--- types/device.te	2004-05-12 05:10:56.000000000 +1000
+++ types/device.te	2004-07-09 12:41:01.000000000 +1000
@@ -15,127 +15,127 @@
 #
 # null_device_t is the type of /dev/null.
 #
-type null_device_t, file_type, device_type, mlstrustedobject;
+type null_device_t, device_type, mlstrustedobject;
 
 #
 # zero_device_t is the type of /dev/zero.
 #
-type zero_device_t, file_type, device_type, mlstrustedobject;
+type zero_device_t, device_type, mlstrustedobject;
 
 #
 # console_device_t is the type of /dev/console.
 #
-type console_device_t, file_type, device_type;
+type console_device_t, device_type;
 
 #
 # memory_device_t is the type of /dev/kmem,
 # /dev/mem, and /dev/port.
 #
-type memory_device_t, file_type, device_type;
+type memory_device_t, device_type;
 
 #
 # random_device_t is the type of /dev/random
 # urandom_device_t is the type of /dev/urandom
 #
-type random_device_t, file_type, device_type;
-type urandom_device_t, file_type, device_type;
+type random_device_t, device_type;
+type urandom_device_t, device_type;
 
 #
 # devtty_t is the type of /dev/tty.
 #
-type devtty_t, file_type, device_type, mlstrustedobject;
+type devtty_t, device_type, mlstrustedobject;
 
 #
 # tty_device_t is the type of /dev/*tty*
 #
-type tty_device_t, file_type, serial_device, device_type;
+type tty_device_t, serial_device, device_type;
 
 #
 # usbtty_device_t is the type of /dev/usr/tty*
 #
-type usbtty_device_t, file_type, serial_device, device_type;
+type usbtty_device_t, serial_device, device_type;
 
 #
 # fixed_disk_device_t is the type of 
 # /dev/hd* and /dev/sd*.
 #
-type fixed_disk_device_t, file_type, device_type;
+type fixed_disk_device_t, device_type;
 
 #
 # scsi_generic_device_t is the type of /dev/sg*
 # it gives access to ALL SCSI devices (both fixed and removable)
 #
-type scsi_generic_device_t, file_type, device_type;
+type scsi_generic_device_t, device_type;
 
 #
 # removable_device_t is the type of
 # /dev/scd* and /dev/fd*.
 #
-type removable_device_t, file_type, device_type;
+type removable_device_t, device_type;
 
 #
 # clock_device_t is the type of
 # /dev/rtc.
 #
-type clock_device_t, file_type, device_type;
+type clock_device_t, device_type;
 
 #
 # tun_tap_device_t is the type of /dev/net/tun/* and /dev/net/tap/*
 #
-type tun_tap_device_t, file_type, device_type;
+type tun_tap_device_t, device_type;
 
 #
 # misc_device_t is the type of miscellaneous devices.
 # XXX:  FIXME!  Appropriate access to these devices need to be identified.
 #
-type misc_device_t, file_type, device_type;
+type misc_device_t, device_type;
 
 #
 # A more general type for mouse devices.
 #
-type mouse_device_t, file_type, device_type;
+type mouse_device_t, device_type;
 
 #
 # For generic /dev/input/event* event devices
 #
-type event_device_t, file_type, device_type;
+type event_device_t, device_type;
 
 #
 # Not sure what these devices are for, but X wants access to them.
 #
-type agp_device_t, file_type, device_type;
-type dri_device_t, file_type, device_type;
+type agp_device_t, device_type;
+type dri_device_t, device_type;
 
 # Type for sound devices.
-type sound_device_t, file_type, device_type;
+type sound_device_t, device_type;
 
 # Type for /dev/ppp.
-type ppp_device_t, file_type, device_type;
+type ppp_device_t, device_type;
 
 # Type for frame buffer /dev/fb/*
-type framebuf_device_t, file_type, device_type;
+type framebuf_device_t, device_type;
 
 # Type for /dev/.devfsd
-type devfs_control_t, file_type, device_type;
+type devfs_control_t, device_type;
 
 # Type for /dev/cpu/mtrr
-type mtrr_device_t, file_type, device_type;
+type mtrr_device_t, device_type;
 
 
 # Type for /dev/apm_bios
-type apm_bios_t, file_type, device_type;
+type apm_bios_t, device_type;
 
 # Type for v4l
-type v4l_device_t, file_type, device_type;
+type v4l_device_t, device_type;
 
 # tape drives
-type tape_device_t, file_type, device_type;
+type tape_device_t, device_type;
 
 # scanners
-type scanner_device_t, file_type, device_type;
+type scanner_device_t, device_type;
 
 # cpu control devices /dev/cpu/0/*
-type cpu_device_t, file_type, device_type;
+type cpu_device_t, device_type;
 
 # for other device nodes such as the NVidia binary-only driver
-type xserver_misc_device_t, file_type, device_type;
+type xserver_misc_device_t, device_type;
diff -ru types/file.te types/file.te
--- types/file.te	2004-07-08 13:09:38.000000000 +1000
+++ types/file.te	2004-07-11 18:07:24.000000000 +1000
@@ -257,7 +257,7 @@
 # Allow each file type to be associated with 
 # the default file system type.
 #
-allow file_type fs_t:filesystem associate;
+allow { file_type device_type } fs_t:filesystem associate;
 
 # Allow the pty to be associated with the file system.
 allow devpts_t devpts_t:filesystem associate;

--Boundary-00=_xGQ8AH5pCW7r2tk--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
