Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i88J0brT006648
	for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 15:00:38 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i88IxgR0023833
	for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 18:59:43 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 4363F61AFC
	for <selinux@tycho.nsa.gov>; Thu,  9 Sep 2004 05:00:34 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 05399-09 for <selinux@tycho.nsa.gov>;
	Thu, 9 Sep 2004 05:00:33 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 82FBE61AF9
	for <selinux@tycho.nsa.gov>; Thu,  9 Sep 2004 05:00:33 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id B2156B5A0C
	for <selinux@tycho.nsa.gov>; Thu,  9 Sep 2004 05:00:31 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: dev_filesystem policy
Date: Thu, 9 Sep 2004 05:00:31 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Pb1PBF0gkCVnU2H"
Message-Id: <200409090500.31105.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_Pb1PBF0gkCVnU2H
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

To use tmpfs for /dev we need to allow all device types to associate with the 
tmpfs.  To make this easier I have attached a patch to give all types that 
may be used for objects under /tmp the attribute dev_filesystem.

I am still working on getting the tmpfs to work correctly, but this is a 
necessary first step.


Steve, if you don't like the name dev_filesystem then please feel free to 
change it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_Pb1PBF0gkCVnU2H
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru /usr/src/se/policy/attrib.te ./attrib.te
--- /usr/src/se/policy/attrib.te	2004-09-02 23:18:47.000000000 +1000
+++ ./attrib.te	2004-09-09 04:17:12.000000000 +1000
@@ -205,6 +205,10 @@
 # The device_type attribute identifies all types assigned to device nodes
 attribute device_type;
 
+# The dev_filesystem attribute identifies all types that may be assigned to
+# files, sockets, or pipes under /dev.
+attribute dev_filesystem;
+
 # The sysadmfile attribute identifies all types assigned to files 
 # that should be completely accessible to administrators.  It is used
 # in TE rules to grant such access for administrator domains.
diff -ru /usr/src/se/policy/domains/program/init.te ./domains/program/init.te
--- /usr/src/se/policy/domains/program/init.te	2004-09-02 23:18:48.000000000 +1000
+++ ./domains/program/init.te	2004-09-09 04:21:32.000000000 +1000
@@ -18,7 +18,7 @@
 role system_r types init_t;
 uses_shlib(init_t);
 type init_exec_t, file_type, sysadmfile, exec_type;
-type initctl_t, file_type, sysadmfile;
+type initctl_t, file_type, sysadmfile, dev_filesystem;
 
 # for init to determine whether SE Linux is active so it can know whether to
 # activate it
diff -ru /usr/src/se/policy/domains/program/syslogd.te ./domains/program/syslogd.te
--- /usr/src/se/policy/domains/program/syslogd.te	2004-08-28 12:05:01.000000000 +1000
+++ ./domains/program/syslogd.te	2004-09-09 04:29:13.000000000 +1000
@@ -25,7 +25,7 @@
 
 r_dir_file(syslogd_t, sysfs_t)
 
-type devlog_t, file_type, sysadmfile;
+type devlog_t, file_type, sysadmfile, dev_filesystem;
 
 # if something can log to syslog they should be able to log to the console
 allow privlog console_device_t:chr_file { ioctl read write getattr };
diff -ru /usr/src/se/policy/domains/program/unused/lpd.te ./domains/program/unused/lpd.te
--- /usr/src/se/policy/domains/program/unused/lpd.te	2004-08-28 12:05:03.000000000 +1000
+++ ./domains/program/unused/lpd.te	2004-09-09 04:33:27.000000000 +1000
@@ -22,7 +22,7 @@
 
 r_dir_file(lpd_t, fonts_t)
 
-type printer_t, file_type, sysadmfile;
+type printer_t, file_type, sysadmfile, dev_filesystem;
 
 type printconf_t, file_type, sysadmfile;   # Type for files in /usr/share/printconf.
 
diff -ru /usr/src/se/policy/domains/program/unused/lvm.te ./domains/program/unused/lvm.te
--- /usr/src/se/policy/domains/program/unused/lvm.te	2004-08-28 12:05:03.000000000 +1000
+++ ./domains/program/unused/lvm.te	2004-09-09 04:18:08.000000000 +1000
@@ -16,7 +16,7 @@
 #
 type lvm_vg_t, file_type, sysadmfile;
 type lvm_metadata_t, file_type, sysadmfile;
-type lvm_control_t, file_type, device_type;
+type lvm_control_t, file_type, device_type, dev_filesystem;
 etcdir_domain(lvm)
 allow lvm_t var_t:dir search;
 lock_domain(lvm)
diff -ru /usr/src/se/policy/domains/program/unused/vmware.te ./domains/program/unused/vmware.te
--- /usr/src/se/policy/domains/program/unused/vmware.te	2004-06-18 10:47:57.000000000 +1000
+++ ./domains/program/unused/vmware.te	2004-09-09 04:18:18.000000000 +1000
@@ -27,7 +27,7 @@
 type vmware_user_exec_t, file_type, exec_type;
 
 # Type for vmware devices.
-type vmware_device_t, file_type, device_type;
+type vmware_device_t, file_type, device_type, dev_filesystem;
 
 # Type for files in /var/run when a user starts VMWare
 type vmware_user_var_run_t, file_type, pidfile;
diff -ru /usr/src/se/policy/domains/program/unused/watchdog.te ./domains/program/unused/watchdog.te
--- /usr/src/se/policy/domains/program/unused/watchdog.te	2004-08-28 12:05:07.000000000 +1000
+++ ./domains/program/unused/watchdog.te	2004-09-09 04:37:40.000000000 +1000
@@ -10,7 +10,7 @@
 #
 
 daemon_domain(watchdog, `, privmail')
-type watchdog_device_t, file_type, device_type;
+type watchdog_device_t, file_type, device_type, dev_filesystem;
 
 log_domain(watchdog)
 
diff -ru /usr/src/se/policy/types/device.te ./types/device.te
--- /usr/src/se/policy/types/device.te	2004-08-19 17:10:47.000000000 +1000
+++ ./types/device.te	2004-09-09 04:18:55.000000000 +1000
@@ -10,141 +10,141 @@
 #
 # device_t is the type of /dev.
 #
-type device_t, file_type;
+type device_t, file_type, dev_filesystem;
 
 #
 # null_device_t is the type of /dev/null.
 #
-type null_device_t, device_type, mlstrustedobject;
+type null_device_t, device_type, dev_filesystem, mlstrustedobject;
 
 #
 # zero_device_t is the type of /dev/zero.
 #
-type zero_device_t, device_type, mlstrustedobject;
+type zero_device_t, device_type, dev_filesystem, mlstrustedobject;
 
 #
 # console_device_t is the type of /dev/console.
 #
-type console_device_t, device_type;
+type console_device_t, device_type, dev_filesystem;
 
 #
 # memory_device_t is the type of /dev/kmem,
 # /dev/mem, and /dev/port.
 #
-type memory_device_t, device_type;
+type memory_device_t, device_type, dev_filesystem;
 
 #
 # random_device_t is the type of /dev/random
 # urandom_device_t is the type of /dev/urandom
 #
-type random_device_t, device_type;
-type urandom_device_t, device_type;
+type random_device_t, device_type, dev_filesystem;
+type urandom_device_t, device_type, dev_filesystem;
 
 #
 # devtty_t is the type of /dev/tty.
 #
-type devtty_t, device_type, mlstrustedobject;
+type devtty_t, device_type, dev_filesystem, mlstrustedobject;
 
 #
 # tty_device_t is the type of /dev/*tty*
 #
-type tty_device_t, serial_device, device_type;
+type tty_device_t, serial_device, device_type, dev_filesystem;
 
 #
 # bsdpty_device_t is the type of /dev/[tp]ty[abcdepqrstuvwxyz][0-9a-f]
-type bsdpty_device_t, device_type;
+type bsdpty_device_t, device_type, dev_filesystem;
 
 #
 # usbtty_device_t is the type of /dev/usr/tty*
 #
-type usbtty_device_t, serial_device, device_type;
+type usbtty_device_t, serial_device, device_type, dev_filesystem;
 
 #
 # printer_device_t is the type for printer devices
 #
-type printer_device_t, file_type, device_type;
+type printer_device_t, file_type, device_type, dev_filesystem;
 
 #
 # fixed_disk_device_t is the type of 
 # /dev/hd* and /dev/sd*.
 #
-type fixed_disk_device_t, device_type;
+type fixed_disk_device_t, device_type, dev_filesystem;
 
 #
 # scsi_generic_device_t is the type of /dev/sg*
 # it gives access to ALL SCSI devices (both fixed and removable)
 #
-type scsi_generic_device_t, device_type;
+type scsi_generic_device_t, device_type, dev_filesystem;
 
 #
 # removable_device_t is the type of
 # /dev/scd* and /dev/fd*.
 #
-type removable_device_t, device_type;
+type removable_device_t, device_type, dev_filesystem;
 
 #
 # clock_device_t is the type of
 # /dev/rtc.
 #
-type clock_device_t, device_type;
+type clock_device_t, device_type, dev_filesystem;
 
 #
 # tun_tap_device_t is the type of /dev/net/tun/* and /dev/net/tap/*
 #
-type tun_tap_device_t, device_type;
+type tun_tap_device_t, device_type, dev_filesystem;
 
 #
 # misc_device_t is the type of miscellaneous devices.
 # XXX:  FIXME!  Appropriate access to these devices need to be identified.
 #
-type misc_device_t, device_type;
+type misc_device_t, device_type, dev_filesystem;
 
 #
 # A more general type for mouse devices.
 #
-type mouse_device_t, device_type;
+type mouse_device_t, device_type, dev_filesystem;
 
 #
 # For generic /dev/input/event* event devices
 #
-type event_device_t, device_type;
+type event_device_t, device_type, dev_filesystem;
 
 #
 # Not sure what these devices are for, but X wants access to them.
 #
-type agp_device_t, device_type;
-type dri_device_t, device_type;
+type agp_device_t, device_type, dev_filesystem;
+type dri_device_t, device_type, dev_filesystem;
 
 # Type for sound devices.
-type sound_device_t, device_type;
+type sound_device_t, device_type, dev_filesystem;
 
 # Type for /dev/ppp.
-type ppp_device_t, device_type;
+type ppp_device_t, device_type, dev_filesystem;
 
 # Type for frame buffer /dev/fb/*
-type framebuf_device_t, device_type;
+type framebuf_device_t, device_type, dev_filesystem;
 
 # Type for /dev/.devfsd
-type devfs_control_t, device_type;
+type devfs_control_t, device_type, dev_filesystem;
 
 # Type for /dev/cpu/mtrr
-type mtrr_device_t, device_type;
+type mtrr_device_t, device_type, dev_filesystem;
 
 
 # Type for /dev/apm_bios
-type apm_bios_t, device_type;
+type apm_bios_t, device_type, dev_filesystem;
 
 # Type for v4l
-type v4l_device_t, device_type;
+type v4l_device_t, device_type, dev_filesystem;
 
 # tape drives
-type tape_device_t, device_type;
+type tape_device_t, device_type, dev_filesystem;
 
 # scanners
-type scanner_device_t, device_type;
+type scanner_device_t, device_type, dev_filesystem;
 
 # cpu control devices /dev/cpu/0/*
-type cpu_device_t, device_type;
+type cpu_device_t, device_type, dev_filesystem;
 
 # for other device nodes such as the NVidia binary-only driver
-type xserver_misc_device_t, device_type;
+type xserver_misc_device_t, device_type, dev_filesystem;
diff -ru /usr/src/se/policy/types/devpts.te ./types/devpts.te
--- /usr/src/se/policy/types/devpts.te	2004-01-24 12:15:54.000000000 +1100
+++ ./types/devpts.te	2004-09-09 04:19:11.000000000 +1000
@@ -10,7 +10,7 @@
 #
 # ptmx_t is the type for /dev/ptmx.
 #
-type ptmx_t, file_type, sysadmfile, device_type;
+type ptmx_t, file_type, sysadmfile, device_type, dev_filesystem;
 
 #
 # devpts_t is the type of the devpts file system and 

--Boundary-00=_Pb1PBF0gkCVnU2H--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
