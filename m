Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9TFTDWt007415
	for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2003 10:29:13 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9TFTCXK018334
	for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2003 15:29:12 GMT
Received: from lyta.coker.com.au (nat-pool-bos.redhat.com [66.187.230.200])
        by jazzband.ncsc.mil  with ESMTP id h9TFTBj4018328 for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2003 15:29:11 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: types.fc patch
Date: Thu, 30 Oct 2003 02:28:16 +1100
Cc: Howard Holm <hdholm@epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Qy9n/Y2l3IXIYKg"
Message-Id: <200310300228.16375.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_Qy9n/Y2l3IXIYKg
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch amends types.fc to specify the class of the object for as many 
files as possible to speed up setfiles.  It is better than the previous 
version I've sent out which had a few minor errors (such as looking for block 
devices for tape drives), also it adds some new device entries.


-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_Qy9n/Y2l3IXIYKg
Content-Type: text/x-diff;
  charset="us-ascii";
  name="types.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="types.diff"

--- /usr/src/se/policy/file_contexts/types.fc	2003-10-22 02:29:17.000000000 +1000
+++ file_contexts/types.fc	2003-10-24 22:16:22.000000000 +1000
@@ -41,11 +41,12 @@
 #
 # The root directory.
 #
-/				system_u:object_r:root_t
+/			-d	system_u:object_r:root_t
 
 #
 # A common mount point
-/mnt				system_u:object_r:root_t
+/mnt			-d	system_u:object_r:root_t
+/mnt/cdrom		-d	system_u:object_r:root_t
 
 #
 # /var
@@ -59,9 +60,9 @@
 /var/lib/texmf(/.*)?		system_u:object_r:tetex_data_t
 /var/cache/fonts(/.*)?		system_u:object_r:tetex_data_t
 /var/lock(/.*)?			system_u:object_r:var_lock_t
-/var/tmp			system_u:object_r:tmp_t
+/var/tmp		-d	system_u:object_r:tmp_t
 /var/tmp/.*			<<none>>
-/var/tmp/vi\.recover		system_u:object_r:tmp_t
+/var/tmp/vi\.recover	-d	system_u:object_r:tmp_t
 
 #
 # /var/ftp
@@ -69,28 +70,28 @@
 /var/ftp/bin(/.*)?		system_u:object_r:bin_t
 /var/ftp/bin/ls		--	system_u:object_r:ls_exec_t
 /var/ftp/lib(/.*)?		system_u:object_r:lib_t
-/var/ftp/lib/ld.*\.so.*		system_u:object_r:ld_so_t
-/var/ftp/lib/lib.*\.so.*	system_u:object_r:shlib_t
+/var/ftp/lib/ld.*\.so.* --	system_u:object_r:ld_so_t
+/var/ftp/lib/lib.*\.so.* --	system_u:object_r:shlib_t
 /var/ftp/etc(/.*)?		system_u:object_r:etc_t
 
 # 
 # The superuser home directory.
 #
 /root(/.*)?			system_u:object_r:sysadm_home_t
-/root				system_u:object_r:sysadm_home_dir_t
+/root			-d	system_u:object_r:sysadm_home_dir_t
 
 # 
 # Ordinary user home directories.
 #
-/home				system_u:object_r:home_root_t
-/home/[^/]+	-d		system_u:object_r:user_home_dir_t
+/home			-d	system_u:object_r:home_root_t
+/home/[^/]+		-d	system_u:object_r:user_home_dir_t
 /home/[^/]+/.+			system_u:object_r:user_home_t
 
 #
 # Other staff home directories, replace "jadmin" with appropriate name
 #
-/home/jadmin/.+				system_u:object_r:staff_home_t
-/home/jadmin		-d		system_u:object_r:staff_home_dir_t
+/home/jadmin/.+			system_u:object_r:staff_home_t
+/home/jadmin		-d	system_u:object_r:staff_home_dir_t
 
 #
 # /bin
@@ -108,8 +109,8 @@
 # /boot
 #
 /boot(/.*)?			system_u:object_r:boot_t
-/boot/System\.map-.*		system_u:object_r:system_map_t
-/boot/kernel\.h.*		system_u:object_r:boot_runtime_t
+/boot/System\.map-.*	--	system_u:object_r:system_map_t
+/boot/kernel\.h.*	--	system_u:object_r:boot_runtime_t
 
 #
 # /dev
@@ -117,86 +118,96 @@
 /dev(/.*)?			system_u:object_r:device_t
 /dev/pts(/.*)?			<<none>>
 /dev/cpu/.*		-c	system_u:object_r:cpu_device_t
-/dev/MAKEDEV			system_u:object_r:sbin_t
-/dev/null			system_u:object_r:null_device_t
-/dev/full			system_u:object_r:null_device_t
-/dev/zero			system_u:object_r:zero_device_t
-/dev/console			system_u:object_r:console_device_t
-/dev/(kmem|mem|port)		system_u:object_r:memory_device_t
-/dev/nvram			system_u:object_r:memory_device_t
-/dev/random			system_u:object_r:random_device_t
-/dev/urandom			system_u:object_r:random_device_t
+/dev/MAKEDEV		--	system_u:object_r:sbin_t
+/dev/null		-c	system_u:object_r:null_device_t
+/dev/full		-c	system_u:object_r:null_device_t
+/dev/zero		-c	system_u:object_r:zero_device_t
+/dev/console		-c	system_u:object_r:console_device_t
+/dev/(kmem|mem|port)	-c	system_u:object_r:memory_device_t
+/dev/nvram		-c	system_u:object_r:memory_device_t
+/dev/random		-c	system_u:object_r:random_device_t
+/dev/urandom		-c	system_u:object_r:random_device_t
 /dev/.*tty[^/]*		-c	system_u:object_r:tty_device_t
 /dev/cu.*		-c	system_u:object_r:tty_device_t
-/dev/vcs[^/]*			system_u:object_r:tty_device_t
-/dev/ip2[^/]*			system_u:object_r:tty_device_t
-/dev/tty			system_u:object_r:devtty_t
-/dev/[shmx]d[^/]*		system_u:object_r:fixed_disk_device_t
-/dev/sg[0-9]+			system_u:object_r:fixed_disk_device_t
+/dev/vcs[^/]*		-c	system_u:object_r:tty_device_t
+/dev/ip2[^/]*		-c	system_u:object_r:tty_device_t
+/dev/tty		-c	system_u:object_r:devtty_t
+/dev/[shmx]d[^/]*	-b	system_u:object_r:fixed_disk_device_t
+/dev/sg[0-9]+		-c	system_u:object_r:scsi_generic_device_t
 /dev/rd.*		-b	system_u:object_r:fixed_disk_device_t
-/dev/i2o/hd[^/]*		system_u:object_r:fixed_disk_device_t
-/dev/ubd[^/]*			system_u:object_r:fixed_disk_device_t
-/dev/cciss/[^/]*		system_u:object_r:fixed_disk_device_t
-/dev/ida/[^/]*			system_u:object_r:fixed_disk_device_t
-/dev/dasd[^/]*			system_u:object_r:fixed_disk_device_t
-/dev/flash[^/]*			system_u:object_r:fixed_disk_device_t
-/dev/nb[^/]+			system_u:object_r:fixed_disk_device_t
-/dev/ataraid/.*			system_u:object_r:fixed_disk_device_t
-/dev/loop.*			system_u:object_r:fixed_disk_device_t
-/dev/ram.*			system_u:object_r:fixed_disk_device_t
-/dev/rawctl			system_u:object_r:fixed_disk_device_t
-/dev/raw/raw[0-9]+		system_u:object_r:fixed_disk_device_t
-/dev/initrd			system_u:object_r:fixed_disk_device_t
-/dev/s(cd|r)[^/]*		system_u:object_r:removable_device_t
-/dev/fd[^/]+			system_u:object_r:removable_device_t
+/dev/i2o/hd[^/]*	-b	system_u:object_r:fixed_disk_device_t
+/dev/ubd[^/]*		-b	system_u:object_r:fixed_disk_device_t
+/dev/cciss/[^/]*	-b	system_u:object_r:fixed_disk_device_t
+/dev/ida/[^/]*		-b	system_u:object_r:fixed_disk_device_t
+/dev/dasd[^/]*		-b	system_u:object_r:fixed_disk_device_t
+/dev/flash[^/]*		-b	system_u:object_r:fixed_disk_device_t
+/dev/nb[^/]+		-b	system_u:object_r:fixed_disk_device_t
+/dev/ataraid/.*		-b	system_u:object_r:fixed_disk_device_t
+/dev/loop.*		-b	system_u:object_r:fixed_disk_device_t
+/dev/ram.*		-b	system_u:object_r:fixed_disk_device_t
+/dev/rawctl		-c	system_u:object_r:fixed_disk_device_t
+/dev/raw/raw[0-9]+	-c	system_u:object_r:fixed_disk_device_t
+/dev/initrd		-b	system_u:object_r:fixed_disk_device_t
+/dev/jsfd		-b	system_u:object_r:fixed_disk_device_t
+/dev/jsflash		-c	system_u:object_r:fixed_disk_device_t
+/dev/s(cd|r)[^/]*	-b	system_u:object_r:removable_device_t
+/dev/usb/rio500		-c	system_u:object_r:removable_device_t
+/dev/fd[^/]+		-b	system_u:object_r:removable_device_t
 # I think a parallel port disk is a removable device...
-/dev/pd[a-d][^/]*		system_u:object_r:removable_device_t
-/dev/p[fg][0-3]			system_u:object_r:removable_device_t
-/dev/aztcd			system_u:object_r:removable_device_t
-/dev/bpcd			system_u:object_r:removable_device_t
-/dev/gscd			system_u:object_r:removable_device_t
-/dev/hitcd			system_u:object_r:removable_device_t
-/dev/pcd[0-3]			system_u:object_r:removable_device_t
-/dev/mcdx?			system_u:object_r:removable_device_t
-/dev/cdu.*			system_u:object_r:removable_device_t
-/dev/cm20.*			system_u:object_r:removable_device_t
-/dev/optcd			system_u:object_r:removable_device_t
-/dev/sbpcd.*			system_u:object_r:removable_device_t
-/dev/sjcd			system_u:object_r:removable_device_t
-/dev/sonycd			system_u:object_r:removable_device_t
-/dev/rtc			system_u:object_r:clock_device_t
-/dev/psaux			system_u:object_r:mouse_device_t
-/dev/atibm			system_u:object_r:mouse_device_t
-/dev/logibm			system_u:object_r:mouse_device_t
-/dev/.*mouse.*			system_u:object_r:mouse_device_t
-/dev/input/.*mouse.*		system_u:object_r:mouse_device_t
-/dev/input/mice			system_u:object_r:mouse_device_t
-/dev/ptmx			system_u:object_r:ptmx_t
+/dev/pd[a-d][^/]*	-b	system_u:object_r:removable_device_t
+/dev/p[fg][0-3]		-b	system_u:object_r:removable_device_t
+/dev/aztcd		-b	system_u:object_r:removable_device_t
+/dev/bpcd		-b	system_u:object_r:removable_device_t
+/dev/gscd		-b	system_u:object_r:removable_device_t
+/dev/hitcd		-b	system_u:object_r:removable_device_t
+/dev/pcd[0-3]		-b	system_u:object_r:removable_device_t
+/dev/mcdx?		-b	system_u:object_r:removable_device_t
+/dev/cdu.*		-b	system_u:object_r:removable_device_t
+/dev/cm20.*		-b	system_u:object_r:removable_device_t
+/dev/optcd		-b	system_u:object_r:removable_device_t
+/dev/sbpcd.*		-b	system_u:object_r:removable_device_t
+/dev/sjcd		-b	system_u:object_r:removable_device_t
+/dev/sonycd		-b	system_u:object_r:removable_device_t
+# parallel port ATAPI generic device
+/dev/pg[0-3]		-c	system_u:object_r:removable_device_t
+/dev/rtc		-c	system_u:object_r:clock_device_t
+/dev/psaux		-c	system_u:object_r:mouse_device_t
+/dev/atibm		-c	system_u:object_r:mouse_device_t
+/dev/logibm		-c	system_u:object_r:mouse_device_t
+/dev/.*mouse.*		-c	system_u:object_r:mouse_device_t
+/dev/input/.*mouse.*	-c	system_u:object_r:mouse_device_t
+/dev/input/mice		-c	system_u:object_r:mouse_device_t
+/dev/input/js.*		-c	system_u:object_r:mouse_device_t
+/dev/ptmx		-c	system_u:object_r:ptmx_t
 /dev/sequencer			system_u:object_r:misc_device_t
-/dev/fb[0-9]*			system_u:object_r:framebuf_device_t
-/dev/apm_bios			system_u:object_r:apm_bios_t
-/dev/cpu/mtrr			system_u:object_r:mtrr_device_t
+/dev/fb[0-9]*		-c	system_u:object_r:framebuf_device_t
+/dev/apm_bios		-c	system_u:object_r:apm_bios_t
+/dev/cpu/mtrr		-c	system_u:object_r:mtrr_device_t
 /dev/(radio|video|vbi|vtx).* -c	system_u:object_r:v4l_device_t
 /dev/winradio.		-c	system_u:object_r:v4l_device_t
 /dev/vttuner		-c	system_u:object_r:v4l_device_t
 /dev/tlk[0-3]		-c	system_u:object_r:v4l_device_t
-/dev/mixer.*			system_u:object_r:sound_device_t
-/dev/dsp.*			system_u:object_r:sound_device_t
-/dev/audio.*			system_u:object_r:sound_device_t
-/dev/r?midi.*			system_u:object_r:sound_device_t
-/dev/smpte.*			system_u:object_r:sound_device_t
-/dev/sndstat			system_u:object_r:sound_device_t
-/dev/beep			system_u:object_r:sound_device_t
-/dev/patmgr[01]			system_u:object_r:sound_device_t
-/dev/mpu401.*			system_u:object_r:sound_device_t
-/dev/n?[hs]t[0-9].*		system_u:object_r:tape_device_t
-/dev/(n?raw)?qft[0-3]		system_u:object_r:tape_device_t
-/dev/n?z?qft[0-3]		system_u:object_r:tape_device_t
-/dev/n?tpqic[12].*		system_u:object_r:tape_device_t
-/dev/ht[0-1]			system_u:object_r:tape_device_t
-/dev/n?osst[0-3].*		system_u:object_r:tape_device_t
-/dev/n?pt[0-9]+			system_u:object_r:tape_device_t
-/dev/usb/scanner.*		system_u:object_r:scanner_device_t
+/dev/mixer.*		-c	system_u:object_r:sound_device_t
+/dev/dsp.*		-c	system_u:object_r:sound_device_t
+/dev/audio.*		-c	system_u:object_r:sound_device_t
+/dev/r?midi.*		-c	system_u:object_r:sound_device_t
+/dev/smpte.*		-c	system_u:object_r:sound_device_t
+/dev/sndstat		-c	system_u:object_r:sound_device_t
+/dev/beep		-c	system_u:object_r:sound_device_t
+/dev/patmgr[01]		-c	system_u:object_r:sound_device_t
+/dev/mpu401.*		-c	system_u:object_r:sound_device_t
+/dev/srnd[0-7]		-c	system_u:object_r:sound_device_t
+/dev/n?[hs]t[0-9].*	-c	system_u:object_r:tape_device_t
+/dev/(n?raw)?qft[0-3]	-c	system_u:object_r:tape_device_t
+/dev/n?z?qft[0-3]	-c	system_u:object_r:tape_device_t
+/dev/n?tpqic[12].*	-c	system_u:object_r:tape_device_t
+/dev/ht[0-1]		-b	system_u:object_r:tape_device_t
+/dev/n?osst[0-3].*	-c	system_u:object_r:tape_device_t
+/dev/n?pt[0-9]+		-c	system_u:object_r:tape_device_t
+/dev/usb/scanner.*	-c	system_u:object_r:scanner_device_t
+/dev/usb/dc2xx.*	-c	system_u:object_r:scanner_device_t
+/dev/usb/mdc800.*	-c	system_u:object_r:scanner_device_t
+/dev/mmetfgrab		-c	system_u:object_r:scanner_device_t
 
 /proc(/.*)?			<<none>>
 
@@ -204,37 +215,37 @@
 # /etc
 #
 /etc(/.*)?			system_u:object_r:etc_t
-/etc/shadow.*			system_u:object_r:shadow_t
-/etc/gshadow.*			system_u:object_r:shadow_t
-/etc/\.pwd\.lock		system_u:object_r:shadow_t
-/etc/fstab\.REVOKE		system_u:object_r:etc_runtime_t
-/etc/HOSTNAME			system_u:object_r:etc_runtime_t
-/etc/ioctl\.save		system_u:object_r:etc_runtime_t
+/etc/shadow.*		--	system_u:object_r:shadow_t
+/etc/gshadow.*		--	system_u:object_r:shadow_t
+/etc/\.pwd\.lock	--	system_u:object_r:shadow_t
+/etc/fstab\.REVOKE	--	system_u:object_r:etc_runtime_t
+/etc/HOSTNAME		--	system_u:object_r:etc_runtime_t
+/etc/ioctl\.save	--	system_u:object_r:etc_runtime_t
 /etc/mtab		--	system_u:object_r:etc_runtime_t
-/etc/motd			system_u:object_r:etc_runtime_t
-/etc/issue			system_u:object_r:etc_runtime_t
-/etc/issue\.net			system_u:object_r:etc_runtime_t
-/etc/sysconfig/hwconf		system_u:object_r:etc_runtime_t
-/etc/asound\.state		system_u:object_r:etc_runtime_t
-/etc/ld\.so\.cache		system_u:object_r:ld_so_cache_t
-/etc/ld\.so\.preload		system_u:object_r:ld_so_cache_t
-/etc/resolv\.conf.*		system_u:object_r:resolv_conf_t
+/etc/motd		--	system_u:object_r:etc_runtime_t
+/etc/issue		--	system_u:object_r:etc_runtime_t
+/etc/issue\.net		--	system_u:object_r:etc_runtime_t
+/etc/sysconfig/hwconf	--	system_u:object_r:etc_runtime_t
+/etc/asound\.state	--	system_u:object_r:etc_runtime_t
+/etc/ld\.so\.cache	--	system_u:object_r:ld_so_cache_t
+/etc/ld\.so\.preload	--	system_u:object_r:ld_so_cache_t
+/etc/resolv\.conf.*	--	system_u:object_r:resolv_conf_t
 /etc/selinux(/.*)?		system_u:object_r:policy_src_t
 /etc/security/selinux(/.*)?	system_u:object_r:policy_config_t	
 /etc/security/selinux/src(/.*)?	system_u:object_r:policy_src_t
 /etc/security/default_context.*	system_u:object_r:default_context_t
-/etc/services			system_u:object_r:etc_t
+/etc/services		--	system_u:object_r:etc_t
 
 #
 # /lib
 #
 /lib(/.*)?			system_u:object_r:lib_t
-/lib/ld.*\.so.*			system_u:object_r:ld_so_t
-/lib/lib.*\.so.*		system_u:object_r:shlib_t
-/lib/[^/]*/lib.*\.so.*		system_u:object_r:shlib_t
-/lib/devfsd/.*\.so.*		system_u:object_r:shlib_t
-/lib/security/.*\.so.*		system_u:object_r:shlib_t
-/lib/libSegFault.so             system_u:object_r:lib_t
+/lib/ld.*\.so.*		--	system_u:object_r:ld_so_t
+/lib/lib.*\.so.*	--	system_u:object_r:shlib_t
+/lib/[^/]*/lib.*\.so.*	--	system_u:object_r:shlib_t
+/lib/devfsd/.*\.so.*	--	system_u:object_r:shlib_t
+/lib/security/.*\.so.*	--	system_u:object_r:shlib_t
+/lib/libSegFault.so	--	system_u:object_r:lib_t
 
 #
 # /sbin
@@ -244,7 +255,7 @@
 #
 # /tmp
 #
-/tmp				system_u:object_r:tmp_t
+/tmp			-d	system_u:object_r:tmp_t
 /tmp/.*				<<none>>
 /tmp/orbit.*			system_u:object_r:user_tmp_t
 /tmp/\.ICE-unix(/.*)?		system_u:object_r:user_tmp_t
@@ -264,24 +275,23 @@
 # /usr/bin
 #
 /usr/bin(/.*)?			system_u:object_r:bin_t
-/usr/bin/makemap		system_u:object_r:sbin_t
 
 #
 # /usr/lib
 #
 /usr/lib(/.*)?			system_u:object_r:lib_t
-/usr/lib/lib.*\.so.*		system_u:object_r:shlib_t
-/usr/lib/python.*\.so		system_u:object_r:shlib_t
-/usr/lib/.*/lib[^/]*\.so.*	system_u:object_r:shlib_t
-/usr/lib/.*/.*\.so		system_u:object_r:shlib_t
-/usr/lib/autofs/.*\.so		system_u:object_r:shlib_t
+/usr/lib/lib.*\.so.*	--	system_u:object_r:shlib_t
+/usr/lib/python.*\.so	--	system_u:object_r:shlib_t
+/usr/lib/.*/lib[^/]*\.so.* --	system_u:object_r:shlib_t
+/usr/lib/.*/.*\.so	--	system_u:object_r:shlib_t
+/usr/lib/autofs/.*\.so	--	system_u:object_r:shlib_t
 /usr/lib/perl5/man(/.*)?	system_u:object_r:man_t
-/usr/lib/perl.*\.so		system_u:object_r:shlib_t
+/usr/lib/perl.*\.so	--	system_u:object_r:shlib_t
 /usr/lib/selinux(/.*)?		system_u:object_r:policy_src_t
 /usr/lib/emacsen-common/.*	system_u:object_r:bin_t
 /usr/lib/.*/bin(/.*)?		system_u:object_r:bin_t
-/usr/lib/gconv/.*\.so		system_u:object_r:shlib_t
-/usr/share/guile/g-wrapped/.*\.so system_u:object_r:shlib_t
+/usr/lib/gconv/.*\.so	--	system_u:object_r:shlib_t
+/usr/share/guile/g-wrapped/.*\.so -- system_u:object_r:shlib_t
 /usr/share/selinux(/.*)?	system_u:object_r:policy_src_t
 /usr/games(/.*)?		system_u:object_r:bin_t
 
@@ -322,13 +332,12 @@
 # /usr/local/lib
 #
 /usr/local/lib(/.*)?		system_u:object_r:lib_t
-/usr/local/lib/.*\.so		system_u:object_r:shlib_t
+/usr/local/lib/.*\.so.*	--	system_u:object_r:shlib_t
 
 #
 # /usr/sbin
 #
 /usr/sbin(/.*)?			system_u:object_r:sbin_t
-/usr/sbin/makemap		system_u:object_r:sbin_t
 
 #
 # /usr/X11R6/bin
@@ -339,7 +348,7 @@
 # /usr/X11R6/lib
 #
 /usr/X11R6/lib(/.*)?		system_u:object_r:lib_t
-/usr/X11R6/lib/lib.*\.so.*	system_u:object_r:shlib_t
+/usr/X11R6/lib/lib.*\.so.* --	system_u:object_r:shlib_t
 
 #
 # /usr/X11R6/man
@@ -352,7 +361,7 @@
 /usr/kerberos/bin(/.*)?		system_u:object_r:bin_t
 /usr/kerberos/sbin(/.*)?	system_u:object_r:sbin_t
 /usr/kerberos/lib(/.*)?		system_u:object_r:lib_t
-/usr/kerberos/lib/lib.*\.so.*	system_u:object_r:shlib_t
+/usr/kerberos/lib/lib.*\.so.* -- system_u:object_r:shlib_t
 
 #
 # /usr/local/selinux
@@ -378,14 +387,14 @@
 # /var/log
 #
 /var/log(/.*)?			system_u:object_r:var_log_t
-/var/log/wtmp.*			system_u:object_r:wtmp_t
-/var/log/btmp.*			system_u:object_r:faillog_t
-/var/log/faillog		system_u:object_r:faillog_t
+/var/log/wtmp.*		--	system_u:object_r:wtmp_t
+/var/log/btmp.*		--	system_u:object_r:faillog_t
+/var/log/faillog	--	system_u:object_r:faillog_t
 /var/log/sa(/.*)?		system_u:object_r:var_log_sa_t
-/var/log/ksyms.*		system_u:object_r:var_log_ksyms_t
-/var/log/lastlog		system_u:object_r:lastlog_t
+/var/log/ksyms.*	--	system_u:object_r:var_log_ksyms_t
+/var/log/lastlog	--	system_u:object_r:lastlog_t
 /var/log/ksymoops(/.*)?		system_u:object_r:var_log_ksyms_t
-/var/log/syslog			system_u:object_r:var_log_t
+/var/log/syslog		--	system_u:object_r:var_log_t
 
 #
 # Persistent label mappings.
@@ -432,7 +441,7 @@
 #
 # initrd mount point, only used during boot
 #
-/initrd				system_u:object_r:root_t
+/initrd			-d	system_u:object_r:root_t
 
 #
 # The Sun Java development kit, RPM install

--Boundary-00=_Qy9n/Y2l3IXIYKg--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
