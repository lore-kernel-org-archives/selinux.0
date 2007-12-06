Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB6KQtdm013403
	for <selinux@tycho.nsa.gov>; Thu, 6 Dec 2007 15:26:55 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lB6KQsTn015613
	for <selinux@tycho.nsa.gov>; Thu, 6 Dec 2007 20:26:55 GMT
Message-ID: <47585B0C.5060300@redhat.com>
Date: Thu, 06 Dec 2007 15:26:52 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Some file context for kernel and systems directory.
Content-Type: multipart/mixed;
 boundary="------------040600050907020109030201"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040600050907020109030201
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------040600050907020109030201
Content-Type: text/x-patch;
 name="filecontext.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="filecontext.diff"

--- nsaserefpolicy/policy/modules/kernel/corecommands.fc	2007-10-29 18:02:31.000000000 -0400
+++ serefpolicy-3.2.3/policy/modules/kernel/corecommands.fc	2007-12-06 15:20:26.000000000 -0500
@@ -168,8 +168,10 @@
 /usr/libexec/openssh/sftp-server --	gen_context(system_u:object_r:bin_t,s0)
 
 /usr/local/lib(64)?/ipsec/.*	-- 	gen_context(system_u:object_r:bin_t,s0)
-/usr/local/Brother/lpd(/.*)?		gen_context(system_u:object_r:bin_t,s0)
-/usr/local/Brother/Printer/[^/]*/cupswrapper(/.*)?      gen_context(system_u:object_r:bin_t,s0)
+/usr/local/Brother(/.*)?/cupswrapper(/.*)?		gen_context(system_u:object_r:bin_t,s0)
+/usr/local/Brother(/.*)?/lpd(/.*)?		gen_context(system_u:object_r:bin_t,s0)
+/usr/local/Printer/[^/]*/cupswrapper(/.*)?      gen_context(system_u:object_r:bin_t,s0)
+/usr/local/Printer/[^/]*/lpd(/.*)?      	gen_context(system_u:object_r:bin_t,s0)
 
 /usr/sbin/sesh			--	gen_context(system_u:object_r:shell_exec_t,s0)
 
@@ -269,3 +271,15 @@
 ifdef(`distro_suse',`
 /var/lib/samba/bin/.+			gen_context(system_u:object_r:bin_t,s0)
 ')
+
+/lib/dbus-1/dbus-daemon-launch-helper --    gen_context(system_u:object_r:bin_t,s0)
+/lib64/dbus-1/dbus-daemon-launch-helper --    gen_context(system_u:object_r:bin_t,s0)
+
+/etc/apcupsd/apccontrol  --    gen_context(system_u:object_r:bin_t,s0)
+/etc/apcupsd/changeme  --    gen_context(system_u:object_r:bin_t,s0)
+/etc/apcupsd/commfailure  --    gen_context(system_u:object_r:bin_t,s0)
+/etc/apcupsd/commok  --    gen_context(system_u:object_r:bin_t,s0)
+/etc/apcupsd/masterconnect  --    gen_context(system_u:object_r:bin_t,s0)
+/etc/apcupsd/mastertimeout  --    gen_context(system_u:object_r:bin_t,s0)
+/etc/apcupsd/offbattery  --    gen_context(system_u:object_r:bin_t,s0)
+/etc/apcupsd/onbattery  --    gen_context(system_u:object_r:bin_t,s0)
--- nsaserefpolicy/policy/modules/kernel/devices.fc	2007-11-14 16:20:13.000000000 -0500
+++ serefpolicy-3.2.3/policy/modules/kernel/devices.fc	2007-12-06 15:20:26.000000000 -0500
@@ -4,6 +4,7 @@
 
 /dev/.*mouse.*		-c	gen_context(system_u:object_r:mouse_device_t,s0)
 /dev/adsp.*		-c	gen_context(system_u:object_r:sound_device_t,s0)
+/dev/admmidi.*		-c	gen_context(system_u:object_r:sound_device_t,s0)
 /dev/(misc/)?agpgart	-c	gen_context(system_u:object_r:agp_device_t,s0)
 /dev/aload.*		-c	gen_context(system_u:object_r:sound_device_t,s0)
 /dev/amidi.*		-c	gen_context(system_u:object_r:sound_device_t,s0)
@@ -13,6 +14,7 @@
 /dev/audio.*		-c	gen_context(system_u:object_r:sound_device_t,s0)
 /dev/beep		-c	gen_context(system_u:object_r:sound_device_t,s0)
 /dev/dmfm		-c	gen_context(system_u:object_r:sound_device_t,s0)
+/dev/dmmidi.*		-c	gen_context(system_u:object_r:sound_device_t,s0)
 /dev/dsp.*		-c	gen_context(system_u:object_r:sound_device_t,s0)
 /dev/efirtc		-c	gen_context(system_u:object_r:clock_device_t,s0)
 /dev/em8300.*		-c	gen_context(system_u:object_r:v4l_device_t,s0)
@@ -20,7 +22,9 @@
 /dev/evtchn		-c	gen_context(system_u:object_r:xen_device_t,s0)
 /dev/fb[0-9]*		-c	gen_context(system_u:object_r:framebuf_device_t,s0)
 /dev/full		-c	gen_context(system_u:object_r:null_device_t,s0)
+/dev/[0-9].*		-c	gen_context(system_u:object_r:usb_device_t,s0)
 /dev/fw.*		-c	gen_context(system_u:object_r:usb_device_t,s0)
+/dev/hidraw.*		-c	gen_context(system_u:object_r:usb_device_t,s0)
 /dev/hiddev.*		-c	gen_context(system_u:object_r:usb_device_t,s0)
 /dev/hpet		-c	gen_context(system_u:object_r:clock_device_t,s0)
 /dev/hw_random		-c	gen_context(system_u:object_r:random_device_t,s0)
@@ -30,6 +34,8 @@
 /dev/js.*		-c	gen_context(system_u:object_r:mouse_device_t,s0)
 /dev/kmem		-c	gen_context(system_u:object_r:memory_device_t,mls_systemhigh)
 /dev/kmsg		-c	gen_context(system_u:object_r:kmsg_device_t,mls_systemhigh)
+/dev/kvm		-c	gen_context(system_u:object_r:kvm_device_t,s0)
+/dev/lircm		-c	gen_context(system_u:object_r:mouse_device_t,s0)
 /dev/logibm		-c	gen_context(system_u:object_r:mouse_device_t,s0)
 /dev/lp.*		-c	gen_context(system_u:object_r:printer_device_t,s0)
 /dev/mcelog		-c	gen_context(system_u:object_r:kmsg_device_t,mls_systemhigh)
--- nsaserefpolicy/policy/modules/kernel/terminal.fc	2007-10-29 18:02:31.000000000 -0400
+++ serefpolicy-3.2.3/policy/modules/kernel/terminal.fc	2007-12-06 15:20:26.000000000 -0500
@@ -14,6 +14,7 @@
 /dev/isdn.*		-c	gen_context(system_u:object_r:tty_device_t,s0)
 /dev/ptmx		-c	gen_context(system_u:object_r:ptmx_t,s0)
 /dev/rfcomm[0-9]+	-c	gen_context(system_u:object_r:tty_device_t,s0)
+/dev/slamr[0-9]+	-c	gen_context(system_u:object_r:tty_device_t,s0)
 /dev/tty			-c	gen_context(system_u:object_r:devtty_t,s0)
 /dev/ttySG.*		-c	gen_context(system_u:object_r:tty_device_t,s0)
 /dev/xvc[^/]*		-c	gen_context(system_u:object_r:tty_device_t,s0)
--- nsaserefpolicy/policy/modules/system/authlogin.fc	2007-10-29 18:02:31.000000000 -0400
+++ serefpolicy-3.2.3/policy/modules/system/authlogin.fc	2007-12-06 15:20:26.000000000 -0500
@@ -41,3 +41,6 @@
 /var/run/console(/.*)?	 	gen_context(system_u:object_r:pam_var_console_t,s0)
 
 /var/run/sudo(/.*)?		gen_context(system_u:object_r:pam_var_run_t,s0)
+/var/lib/pam_ssh(/.*)?		gen_context(system_u:object_r:var_auth_t,s0)
+
+/var/cache/coolkey(/.*)?	gen_context(system_u:object_r:auth_cache_t,s0)
--- nsaserefpolicy/policy/modules/system/fstools.fc	2007-09-26 12:15:01.000000000 -0400
+++ serefpolicy-3.2.3/policy/modules/system/fstools.fc	2007-12-06 15:20:26.000000000 -0500
@@ -1,4 +1,3 @@
-/sbin/badblocks		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
 /sbin/blkid		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
 /sbin/blockdev		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
 /sbin/cfdisk		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
@@ -21,7 +20,6 @@
 /sbin/mkfs.*		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
 /sbin/mkraid		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
 /sbin/mkreiserfs	--	gen_context(system_u:object_r:fsadm_exec_t,s0)
-/sbin/mkswap		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
 /sbin/parted		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
 /sbin/partprobe		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
 /sbin/partx		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
--- nsaserefpolicy/policy/modules/system/ipsec.fc	2007-02-19 11:32:53.000000000 -0500
+++ serefpolicy-3.2.3/policy/modules/system/ipsec.fc	2007-12-06 15:20:26.000000000 -0500
@@ -32,3 +32,4 @@
 /var/racoon(/.*)?			gen_context(system_u:object_r:ipsec_var_run_t,s0)
 
 /var/run/pluto(/.*)?			gen_context(system_u:object_r:ipsec_var_run_t,s0)
+/var/run/racoon.pid		--	gen_context(system_u:object_r:ipsec_var_run_t,s0)
--- nsaserefpolicy/policy/modules/system/libraries.fc	2007-10-12 08:56:08.000000000 -0400
+++ serefpolicy-3.2.3/policy/modules/system/libraries.fc	2007-12-06 15:20:26.000000000 -0500
@@ -65,11 +65,15 @@
 /opt/(.*/)?java/.+\.jar			--	gen_context(system_u:object_r:lib_t,s0)
 /opt/(.*/)?jre.*/.+\.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /opt/(.*/)?jre/.+\.jar			--	gen_context(system_u:object_r:lib_t,s0)
+/opt/ibm/java.*/jre/.+\.jar		--	gen_context(system_u:object_r:lib_t,s0)
+/opt/ibm/java.*/jre/.+\.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /opt/cisco-vpnclient/lib/libvpnapi\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /opt/netbeans(.*/)?jdk.*/linux/.+\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 /opt/cxoffice/lib/wine/.+\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/opt/f-secure/fspms/libexec/librapi.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
-/opt/ibm/java2-ppc64-50/jre/bin/.+\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+/opt/f-secure/fspms/libexec/librapi\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+/opt/Adobe(/.*?)/nppdf\.so 		-- 	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib/firefox-[^/]/plugins/nppdf\.so 		-- 	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib/mozilla/plugins/nppdf\.so 		-- 	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 ifdef(`distro_gentoo',`
 # despite the extensions, they are actually libs
@@ -111,6 +115,7 @@
 
 /usr/lib/vlc/codec/libdmo_plugin\.so	   --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib/vlc/codec/librealaudio_plugin\.so  --	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib/VBoxVMM\.so  --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 /usr/(.*/)?lib(64)?(/.*)?/nvidia/.+\.so(\..*)? -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?(/.*)?/nvidia/.+\.so(\..*)? --	gen_context(system_u:object_r:textrel_shlib_t,s0)
@@ -135,6 +140,8 @@
 /usr/(local/)?lib(64)?/(sse2/)?libfame-.*\.so.*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/NX/lib/libXcomp\.so.*		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/NX/lib/libjpeg\.so.* 		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib/nx/libXcomp\.so.*		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib/nx/libjpeg\.so.* 		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 /usr/X11R6/lib/libGL\.so.* 		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/X11R6/lib/libXvMCNVIDIA\.so.* 	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
@@ -158,6 +165,7 @@
 # Fedora Core packages: gstreamer-plugins, compat-libstdc++, Glide3, libdv
 # 	HelixPlayer, SDL, xorg-x11, xorg-x11-libs, Hermes, valgrind, openoffice.org-libs, httpd - php
 /usr/lib(64)?/gstreamer-.*/[^/]*\.so.* --	gen_context(system_u:object_r:textrel_shlib_t,s0)
+HOME_DIR/.*/\.gstreamer-.*/plugins/*\.so.* --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 /usr/lib(64)?/libstdc\+\+\.so\.2\.7\.2\.8 --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libg\+\+\.so\.2\.7\.2\.8	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
@@ -216,6 +224,7 @@
 /usr/lib(64)?/libpostproc\.so.*		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libavformat.*\.so(\.[^/]*)* --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libavcodec.*\.so(\.[^/]*)* --	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/codecs/drv[1-9c]\.so(\.[^/]*)* --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libavutil.*\.so(\.[^/]*)* --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libxvidcore\.so.*		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/xine/plugins/.+\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
@@ -236,7 +245,9 @@
 /usr/lib(64)?/libdivxdecore\.so\.0	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libdivxencore\.so\.0	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
-/usr/lib(64)?/python2.4/site-packages/M2Crypto/__m2crypto.so --	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/libdvdcss\.so.*  		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+
+/usr/lib(64)?/python2.4/site-packages/M2Crypto/__m2crypto\.so --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 # vmware 
 /usr/lib(64)?/vmware/lib(/.*)?/libgdk-x11-.*\.so.* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
@@ -284,3 +295,13 @@
 /var/spool/postfix/lib(64)?(/.*)? 		gen_context(system_u:object_r:lib_t,s0)
 /var/spool/postfix/usr(/.*)?			gen_context(system_u:object_r:lib_t,s0)
 /var/spool/postfix/lib(64)?/ld.*\.so.*	--	gen_context(system_u:object_r:ld_so_t,s0)
+/usr/lib/mozilla/plugins/libvlcplugin\.so  --	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib64/mozilla/plugins/libvlcplugin\.so  --	gen_context(system_u:object_r:textrel_shlib_t,s0)
+
+/var/cache/ldconfig(/.*)?		    	gen_context(system_u:object_r:ldconfig_cache_t,s0)
+/usr/lib/libFLAC\.so.* 	  --	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib/maxima/[^/]+/binary-gcl/maxima  --	gen_context(system_u:object_r:textrel_shlib_t,s0)
+
+/usr/lib/firefox-[^/]*/plugins/nppdf.so	 --	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/opt/Adobe/Reader8/Reader/intellinux/plug_ins/.*\.api	 --	gen_context(system_u:object_r:textrel_shlib_t,s0)
+
--- nsaserefpolicy/policy/modules/system/logging.fc	2007-11-06 09:18:37.000000000 -0500
+++ serefpolicy-3.2.3/policy/modules/system/logging.fc	2007-12-06 15:20:26.000000000 -0500
@@ -29,6 +29,11 @@
 
 /var/log		-d	gen_context(system_u:object_r:var_log_t,s0-mls_systemhigh)
 /var/log/.*			gen_context(system_u:object_r:var_log_t,s0)
+/var/log/messages[^/]*		gen_context(system_u:object_r:var_log_t,mls_systemhigh)
+/var/log/secure[^/]*		gen_context(system_u:object_r:var_log_t,mls_systemhigh)
+/var/log/cron[^/]*		gen_context(system_u:object_r:var_log_t,mls_systemhigh)
+/var/log/maillog[^/]*		gen_context(system_u:object_r:var_log_t,mls_systemhigh)
+/var/log/spooler[^/]*		gen_context(system_u:object_r:var_log_t,mls_systemhigh)
 /var/log/audit(/.*)?		gen_context(system_u:object_r:auditd_log_t,mls_systemhigh)
 /var/log/syslog-ng(/.*)? --	gen_context(system_u:object_r:syslogd_var_run_t,s0)
 
@@ -36,6 +41,8 @@
 /var/log/audit\.log	--	gen_context(system_u:object_r:auditd_log_t,mls_systemhigh)
 ')
 
+/var/named/chroot/var/log	-d	gen_context(system_u:object_r:var_log_t,s0)
+
 /var/run/audit_events	-s	gen_context(system_u:object_r:auditd_var_run_t,s0)
 /var/run/audispd_events	-s	gen_context(system_u:object_r:auditd_var_run_t,s0)
 /var/run/auditd\.pid	--	gen_context(system_u:object_r:auditd_var_run_t,s0)
--- nsaserefpolicy/policy/modules/system/lvm.fc	2007-10-12 08:56:08.000000000 -0400
+++ serefpolicy-3.2.3/policy/modules/system/lvm.fc	2007-12-06 15:20:26.000000000 -0500
@@ -15,6 +15,7 @@
 #
 /etc/lvm(/.*)?			gen_context(system_u:object_r:lvm_etc_t,s0)
 /etc/lvm/\.cache	--	gen_context(system_u:object_r:lvm_metadata_t,s0)
+/etc/lvm/cache(/.*)?		gen_context(system_u:object_r:lvm_metadata_t,s0)
 /etc/lvm/archive(/.*)?		gen_context(system_u:object_r:lvm_metadata_t,s0)
 /etc/lvm/backup(/.*)?		gen_context(system_u:object_r:lvm_metadata_t,s0)
 /etc/lvm/lock(/.*)?		gen_context(system_u:object_r:lvm_lock_t,s0)
--- nsaserefpolicy/policy/modules/system/sysnetwork.fc	2006-11-16 17:15:24.000000000 -0500
+++ serefpolicy-3.2.3/policy/modules/system/sysnetwork.fc	2007-12-06 15:20:26.000000000 -0500
@@ -52,8 +52,7 @@
 /var/lib/dhcpcd(/.*)?		gen_context(system_u:object_r:dhcpc_state_t,s0)
 /var/lib/dhclient(/.*)?		gen_context(system_u:object_r:dhcpc_state_t,s0)
 
-/var/run/dhclient.*\.pid --	gen_context(system_u:object_r:dhcpc_var_run_t,s0)
-/var/run/dhclient.*\.leases --	gen_context(system_u:object_r:dhcpc_var_run_t,s0)
+/var/run/dhclient.*		--	gen_context(system_u:object_r:dhcpc_var_run_t,s0)
 
 ifdef(`distro_gentoo',`
 /var/lib/dhcpc(/.*)?		gen_context(system_u:object_r:dhcpc_state_t,s0)

--------------040600050907020109030201
Content-Type: application/octet-stream;
 name="filecontext.diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="filecontext.diff.sig"

iD8DBQBHWFsMrlYvE4MpobMRAiVtAKCCuSC+X7EY7tERwKL3Rh7qrA7LDgCgoykzl2Kd4v6s
UOT3Ab83rYmcCFA=
--------------040600050907020109030201--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
