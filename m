Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j12DX553022138
	for <selinux@tycho.nsa.gov>; Wed, 2 Feb 2005 08:33:06 -0500 (EST)
Message-ID: <4200D68A.6030309@redhat.com>
Date: Wed, 02 Feb 2005 08:32:58 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Latest diffs
References: <1106940328.32737.120.camel@moss-spartans.epoch.ncsc.mil>	 <41FA9717.2000609@redhat.com>	 <1107283533.31281.8.camel@moss-lions.epoch.ncsc.mil>	 <1107287300.26936.226.camel@moss-spartans.epoch.ncsc.mil>	 <1107349736.890.72.camel@moss-spartans.epoch.ncsc.mil> <1107350272.890.82.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1107350272.890.82.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------050407090204050907050608"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050407090204050907050608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added mplayer policy

Switched /u?dev back to /dev since this is no longer needed.

more fixes for smbmount.

Made some of the changes Stephen suggested.

Dan

--------------050407090204050907050608
Content-Type: text/x-patch;
 name="policy-20050201.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-20050201.patch"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/mount.te policy-1.21.7/domains/program/mount.te
--- nsapolicy/domains/program/mount.te	2005-02-01 15:08:35.000000000 -0500
+++ policy-1.21.7/domains/program/mount.te	2005-02-02 08:27:37.000000000 -0500
@@ -49,7 +49,6 @@
 allow mount_t devpts_t:dir mounton;
 allow mount_t usbdevfs_t:dir mounton;
 allow mount_t sysfs_t:dir mounton;
-allow mount_t binfmt_misc_fs_t:dir mounton;
 allow mount_t nfs_t:dir mounton;
 allow mount_t nfs_t:dir search;
 # nfsv4 has a filesystem to mount for its userspace daemons
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.21.7/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2005-02-01 15:08:36.000000000 -0500
+++ policy-1.21.7/domains/program/unused/apache.te	2005-02-02 08:27:37.000000000 -0500
@@ -349,3 +349,4 @@
 read_sysctl(httpd_sys_script_t)
 allow httpd_sys_script_t var_lib_t:dir search;
 dontaudit httpd_t selinux_config_t:dir search;
+r_dir_file(httpd_t, cert_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/i18n_input.te policy-1.21.7/domains/program/unused/i18n_input.te
--- nsapolicy/domains/program/unused/i18n_input.te	2005-01-31 10:02:05.000000000 -0500
+++ policy-1.21.7/domains/program/unused/i18n_input.te	2005-02-02 08:27:37.000000000 -0500
@@ -25,4 +25,5 @@
 allow i18n_input_t etc_t:file r_file_perms;
 allow i18n_input_t self:unix_dgram_socket create_socket_perms;
 allow i18n_input_t self:unix_stream_socket create_stream_socket_perms;
+allow i18n_input_t i18n_input_var_run_t:dir create_dir_perms;
 allow i18n_input_t i18n_input_var_run_t:sock_file create_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mplayer.te policy-1.21.7/domains/program/unused/mplayer.te
--- nsapolicy/domains/program/unused/mplayer.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.21.7/domains/program/unused/mplayer.te	2005-02-02 08:27:37.000000000 -0500
@@ -0,0 +1,12 @@
+#DESC mplayer - media player 
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+
+# Type for the mplayer executable.
+type mplayer_exec_t, file_type, exec_type, sysadmfile;
+type mencoder_exec_t, file_type, exec_type, sysadmfile;
+type mplayer_etc_t, file_type, sysadmfile;
+
+# Everything else is in the mplayer_domain macro in
+# macros/program/mplayer_macros.te.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/samba.te policy-1.21.7/domains/program/unused/samba.te
--- nsapolicy/domains/program/unused/samba.te	2005-02-01 15:08:38.000000000 -0500
+++ policy-1.21.7/domains/program/unused/samba.te	2005-02-02 08:27:37.000000000 -0500
@@ -124,32 +124,65 @@
 #
 # Domain for running smbmount
 #
-application_domain(smbmount, `, fs_domain, nscd_client_domain');
+
+# Derive from app. domain. Transition from mount.
+application_domain(smbmount, `, fs_domain, nscd_client_domain')
+domain_auto_trans(mount_t, smbmount_exec_t, smbmount_t)
+
+# Capabilities
+# FIXME: is all of this really necessary?
+allow smbmount_t self:capability { net_bind_service sys_rawio sys_admin dac_override chown };
+
+# Access samba config
+allow smbmount_t samba_etc_t:file r_file_perms;
+allow smbmount_t samba_etc_t:dir r_dir_perms;
+
+# Write samba log
+allow smbmount_t samba_log_t:file create_file_perms;
+allow smbmount_t samba_log_t:dir r_dir_perms; 
+
+# Write stuff in var
+allow smbmount_t var_log_t:dir r_dir_perms;
+rw_dir_create_file(smbmount_t, samba_var_t)
+
+# Access mtab
+file_type_auto_trans(smbmount_t, etc_t, etc_runtime_t, file)
+
+# Read nsswitch.conf
+allow smbmount_t etc_t:file r_file_perms;
+
+# Networking
 can_network(smbmount_t)
 can_ypbind(smbmount_t)
-allow smbmount_t cifs_t:dir r_dir_perms;
 allow smbmount_t self:unix_dgram_socket create_socket_perms;
-allow smbmount_t samba_etc_t:file r_file_perms;
-allow smbmount_t samba_log_t:dir r_dir_perms;
-allow smbmount_t samba_log_t:file ra_file_perms;
-rw_dir_create_file(smbmount_t, samba_var_t)
-domain_auto_trans(mount_t, smbmount_exec_t, smbmount_t)
+allow smbmount_t self:unix_stream_socket create_socket_perms;
+allow kernel_t smbmount_t:tcp_socket { read write };
+allow userdomain smbmount_t:tcp_socket write;
+
+# Proc
+# FIXME: is this necessary?
 r_dir_file(smbmount_t, proc_t)
-allow smbmount_t self:capability { net_bind_service sys_rawio sys_admin dac_override chown };
+
+# Fork smbmnt 
+# FIXME: label bin_t as more restricted type?
+allow smbmount_t bin_t:dir r_dir_perms;
+can_exec(smbmount_t,bin_t)
 allow smbmount_t self:process { fork signal_perms };
-file_type_auto_trans(smbmount_t, etc_t, etc_runtime_t, file)
-allow smbmount_t cifs_t:dir mounton;
-allow smbmount_t cifs_t:dir search;
+
+# Mount 
+allow smbmount_t cifs_t:filesystem mount_fs_perms;
+allow smbmount_t cifs_t:dir r_dir_perms;
+allow smbmount_t mnt_t:dir r_dir_perms;
 allow smbmount_t mnt_t:dir mounton;
-read_locale(smbmount_t)
+
+# Terminal
+read_locale(smbmount_t) 
+allow smbmount_t devtty_t:chr_file rw_file_perms;
+allow smbmount_t devpts_t:dir r_dir_perms;
+allow smbmount_t devpts_t:chr_file rw_file_perms;
+allow smbmount_t sysadm_tty_device_t:chr_file rw_file_perms;
+allow smbmount_t sysadm_devpts_t:chr_file rw_file_perms;
+#FIXME: what about user_tty_device_t, user_devpts_t?
 allow smbmount_t userdomain:fd use;
-allow smbmount_t self:unix_stream_socket create_socket_perms;
-can_exec(smbmount_t, bin_t)
-allow kernel_t smbmount_t:tcp_socket { read write };
-allow smbmount_t file_type:filesystem { unmount mount relabelto };
 allow smbmount_t local_login_t:fd use;
-allow smbmount_t mnt_t:dir { search getattr };
-allow smbmount_t samba_etc_t:dir search;
-allow smbmount_t sysadm_tty_device_t:chr_file { read write };
-allow smbmount_t etc_t:file { getattr read };
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/mplayer.fc policy-1.21.7/file_contexts/program/mplayer.fc
--- nsapolicy/file_contexts/program/mplayer.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.21.7/file_contexts/program/mplayer.fc	2005-02-02 08:27:37.000000000 -0500
@@ -0,0 +1,6 @@
+# mplayer
+/usr/bin/mplayer	--	   	system_u:object_r:mplayer_exec_t
+/usr/bin/mencoder	--	   	system_u:object_r:mencoder_exec_t
+
+/etc/mplayer(/.*)?		system_u:object_r:mplayer_etc_t
+HOME_DIR/\.mplayer(/.*)?        system_u:object_r:ROLE_mplayer_rw_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.21.7/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2005-02-02 08:11:42.000000000 -0500
+++ policy-1.21.7/file_contexts/types.fc	2005-02-02 08:27:37.000000000 -0500
@@ -115,34 +115,34 @@
 #
 # /dev
 #
-/u?dev(/.*)?			system_u:object_r:device_t
-/u?dev/pts(/.*)?		<<none>>
-/u?dev/cpu/.*		-c	system_u:object_r:cpu_device_t
-/u?dev/microcode	-c	system_u:object_r:cpu_device_t
-/u?dev/MAKEDEV		--	system_u:object_r:sbin_t
-/u?dev/null		-c	system_u:object_r:null_device_t
-/u?dev/full		-c	system_u:object_r:null_device_t
-/u?dev/zero		-c	system_u:object_r:zero_device_t
-/u?dev/console		-c	system_u:object_r:console_device_t
-/u?dev/xconsole		-p	system_u:object_r:xconsole_device_t
-/u?dev/(kmem|mem|port)	-c	system_u:object_r:memory_device_t
-/u?dev/nvram		-c	system_u:object_r:memory_device_t
-/u?dev/random		-c	system_u:object_r:random_device_t
-/u?dev/urandom		-c	system_u:object_r:urandom_device_t
-/u?dev/capi.*		-c	system_u:object_r:tty_device_t
-/u?dev/dcbri[0-9]+	-c	system_u:object_r:tty_device_t
-/u?dev/irlpt[0-9]+	-c	system_u:object_r:printer_device_t
-/u?dev/ircomm[0-9]+	-c	system_u:object_r:tty_device_t
-/u?dev/isdn.*		-c	system_u:object_r:tty_device_t
-/u?dev/.*tty[^/]*	-c	system_u:object_r:tty_device_t
-/u?dev/[pt]ty[abcdepqrstuvwxyz][0-9a-f]	-c system_u:object_r:bsdpty_device_t
-/u?dev/cu.*		-c	system_u:object_r:tty_device_t
-/u?dev/vcs[^/]*		-c	system_u:object_r:tty_device_t
-/u?dev/ip2[^/]*		-c	system_u:object_r:tty_device_t
-/u?dev/hvc.*		-c	system_u:object_r:tty_device_t
-/u?dev/hvsi.*		-c	system_u:object_r:tty_device_t
-/u?dev/ttySG.*		-c	system_u:object_r:tty_device_t
-/u?dev/tty		-c	system_u:object_r:devtty_t
+/dev(/.*)?			system_u:object_r:device_t
+/dev/pts(/.*)?		<<none>>
+/dev/cpu/.*		-c	system_u:object_r:cpu_device_t
+/dev/microcode	-c	system_u:object_r:cpu_device_t
+/dev/MAKEDEV		--	system_u:object_r:sbin_t
+/dev/null		-c	system_u:object_r:null_device_t
+/dev/full		-c	system_u:object_r:null_device_t
+/dev/zero		-c	system_u:object_r:zero_device_t
+/dev/console		-c	system_u:object_r:console_device_t
+/dev/xconsole		-p	system_u:object_r:xconsole_device_t
+/dev/(kmem|mem|port)	-c	system_u:object_r:memory_device_t
+/dev/nvram		-c	system_u:object_r:memory_device_t
+/dev/random		-c	system_u:object_r:random_device_t
+/dev/urandom		-c	system_u:object_r:urandom_device_t
+/dev/capi.*		-c	system_u:object_r:tty_device_t
+/dev/dcbri[0-9]+	-c	system_u:object_r:tty_device_t
+/dev/irlpt[0-9]+	-c	system_u:object_r:printer_device_t
+/dev/ircomm[0-9]+	-c	system_u:object_r:tty_device_t
+/dev/isdn.*		-c	system_u:object_r:tty_device_t
+/dev/.*tty[^/]*	-c	system_u:object_r:tty_device_t
+/dev/[pt]ty[abcdepqrstuvwxyz][0-9a-f]	-c system_u:object_r:bsdpty_device_t
+/dev/cu.*		-c	system_u:object_r:tty_device_t
+/dev/vcs[^/]*		-c	system_u:object_r:tty_device_t
+/dev/ip2[^/]*		-c	system_u:object_r:tty_device_t
+/dev/hvc.*		-c	system_u:object_r:tty_device_t
+/dev/hvsi.*		-c	system_u:object_r:tty_device_t
+/dev/ttySG.*		-c	system_u:object_r:tty_device_t
+/dev/tty		-c	system_u:object_r:devtty_t
 /dev/lp.*		-c	system_u:object_r:printer_device_t
 /dev/par.*		-c	system_u:object_r:printer_device_t
 /dev/usb/lp.*		-c	system_u:object_r:printer_device_t
@@ -150,103 +150,103 @@
 ifdef(`distro_redhat', `
 /dev/root		-b	system_u:object_r:fixed_disk_device_t
 ')
-/u?dev/[shmx]d[^/]*	-b	system_u:object_r:fixed_disk_device_t
-/u?dev/dm-[0-9]+	-b	system_u:object_r:fixed_disk_device_t
-/u?dev/sg[0-9]+		-c	system_u:object_r:scsi_generic_device_t
-/u?dev/rd.*		-b	system_u:object_r:fixed_disk_device_t
-/u?dev/i2o/hd[^/]*	-b	system_u:object_r:fixed_disk_device_t
-/u?dev/ubd[^/]*		-b	system_u:object_r:fixed_disk_device_t
-/u?dev/cciss/[^/]*	-b	system_u:object_r:fixed_disk_device_t
-/u?dev/ida/[^/]*	-b	system_u:object_r:fixed_disk_device_t
-/u?dev/dasd[^/]*	-b	system_u:object_r:fixed_disk_device_t
-/u?dev/flash[^/]*	-b	system_u:object_r:fixed_disk_device_t
-/u?dev/nb[^/]+		-b	system_u:object_r:fixed_disk_device_t
-/u?dev/ataraid/.*	-b	system_u:object_r:fixed_disk_device_t
-/u?dev/loop.*		-b	system_u:object_r:fixed_disk_device_t
-/u?dev/net/.*		-c	system_u:object_r:tun_tap_device_t
-/u?dev/ram.*		-b	system_u:object_r:fixed_disk_device_t
-/u?dev/rawctl		-c	system_u:object_r:fixed_disk_device_t
-/u?dev/raw/raw[0-9]+	-c	system_u:object_r:fixed_disk_device_t
-/u?dev/scramdisk/.*	-b	system_u:object_r:fixed_disk_device_t
-/u?dev/initrd		-b	system_u:object_r:fixed_disk_device_t
-/u?dev/jsfd		-b	system_u:object_r:fixed_disk_device_t
-/u?dev/js.*		-c	system_u:object_r:mouse_device_t
-/u?dev/jsflash		-c	system_u:object_r:fixed_disk_device_t
-/u?dev/s(cd|r)[^/]*	-b	system_u:object_r:removable_device_t
-/u?dev/usb/rio500	-c	system_u:object_r:removable_device_t
-/u?dev/fd[^/]+		-b	system_u:object_r:removable_device_t
+/dev/[shmx]d[^/]*	-b	system_u:object_r:fixed_disk_device_t
+/dev/dm-[0-9]+	-b	system_u:object_r:fixed_disk_device_t
+/dev/sg[0-9]+		-c	system_u:object_r:scsi_generic_device_t
+/dev/rd.*		-b	system_u:object_r:fixed_disk_device_t
+/dev/i2o/hd[^/]*	-b	system_u:object_r:fixed_disk_device_t
+/dev/ubd[^/]*		-b	system_u:object_r:fixed_disk_device_t
+/dev/cciss/[^/]*	-b	system_u:object_r:fixed_disk_device_t
+/dev/ida/[^/]*	-b	system_u:object_r:fixed_disk_device_t
+/dev/dasd[^/]*	-b	system_u:object_r:fixed_disk_device_t
+/dev/flash[^/]*	-b	system_u:object_r:fixed_disk_device_t
+/dev/nb[^/]+		-b	system_u:object_r:fixed_disk_device_t
+/dev/ataraid/.*	-b	system_u:object_r:fixed_disk_device_t
+/dev/loop.*		-b	system_u:object_r:fixed_disk_device_t
+/dev/net/.*		-c	system_u:object_r:tun_tap_device_t
+/dev/ram.*		-b	system_u:object_r:fixed_disk_device_t
+/dev/rawctl		-c	system_u:object_r:fixed_disk_device_t
+/dev/raw/raw[0-9]+	-c	system_u:object_r:fixed_disk_device_t
+/dev/scramdisk/.*	-b	system_u:object_r:fixed_disk_device_t
+/dev/initrd		-b	system_u:object_r:fixed_disk_device_t
+/dev/jsfd		-b	system_u:object_r:fixed_disk_device_t
+/dev/js.*		-c	system_u:object_r:mouse_device_t
+/dev/jsflash		-c	system_u:object_r:fixed_disk_device_t
+/dev/s(cd|r)[^/]*	-b	system_u:object_r:removable_device_t
+/dev/usb/rio500	-c	system_u:object_r:removable_device_t
+/dev/fd[^/]+		-b	system_u:object_r:removable_device_t
 # I think a parallel port disk is a removable device...
-/u?dev/pd[a-d][^/]*	-b	system_u:object_r:removable_device_t
-/u?dev/p[fg][0-3]	-b	system_u:object_r:removable_device_t
-/u?dev/aztcd		-b	system_u:object_r:removable_device_t
-/u?dev/bpcd		-b	system_u:object_r:removable_device_t
-/u?dev/gscd		-b	system_u:object_r:removable_device_t
-/u?dev/hitcd		-b	system_u:object_r:removable_device_t
-/u?dev/pcd[0-3]		-b	system_u:object_r:removable_device_t
-/u?dev/mcdx?		-b	system_u:object_r:removable_device_t
-/u?dev/cdu.*		-b	system_u:object_r:removable_device_t
-/u?dev/cm20.*		-b	system_u:object_r:removable_device_t
-/u?dev/optcd		-b	system_u:object_r:removable_device_t
-/u?dev/sbpcd.*		-b	system_u:object_r:removable_device_t
-/u?dev/sjcd		-b	system_u:object_r:removable_device_t
-/u?dev/sonycd		-b	system_u:object_r:removable_device_t
+/dev/pd[a-d][^/]*	-b	system_u:object_r:removable_device_t
+/dev/p[fg][0-3]	-b	system_u:object_r:removable_device_t
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
 # parallel port ATAPI generic device
-/u?dev/pg[0-3]		-c	system_u:object_r:removable_device_t
-/u?dev/rtc		-c	system_u:object_r:clock_device_t
-/u?dev/psaux		-c	system_u:object_r:mouse_device_t
-/u?dev/atibm		-c	system_u:object_r:mouse_device_t
-/u?dev/logibm		-c	system_u:object_r:mouse_device_t
-/u?dev/.*mouse.*	-c	system_u:object_r:mouse_device_t
-/u?dev/input/.*mouse.*	-c	system_u:object_r:mouse_device_t
-/u?dev/input/event.*	-c	system_u:object_r:event_device_t
-/u?dev/input/mice	-c	system_u:object_r:mouse_device_t
-/u?dev/input/js.*	-c	system_u:object_r:mouse_device_t
-/u?dev/ptmx		-c	system_u:object_r:ptmx_t
-/u?dev/sequencer	-c	system_u:object_r:misc_device_t
-/u?dev/fb[0-9]*		-c	system_u:object_r:framebuf_device_t
-/u?dev/apm_bios		-c	system_u:object_r:apm_bios_t
-/u?dev/cpu/mtrr		-c	system_u:object_r:mtrr_device_t
-/u?dev/pmu		-c	system_u:object_r:power_device_t
-/u?dev/(radio|video|vbi|vtx).* -c	system_u:object_r:v4l_device_t
-/u?dev/winradio.	-c	system_u:object_r:v4l_device_t
-/u?dev/vttuner		-c	system_u:object_r:v4l_device_t
-/u?dev/tlk[0-3]		-c	system_u:object_r:v4l_device_t
-/u?dev/adsp		-c	system_u:object_r:sound_device_t
-/u?dev/mixer.*		-c	system_u:object_r:sound_device_t
-/u?dev/dsp.*		-c	system_u:object_r:sound_device_t
-/u?dev/audio.*		-c	system_u:object_r:sound_device_t
-/u?dev/r?midi.*		-c	system_u:object_r:sound_device_t
-/u?dev/sequencer2	-c	system_u:object_r:sound_device_t
-/u?dev/smpte.*		-c	system_u:object_r:sound_device_t
-/u?dev/sndstat		-c	system_u:object_r:sound_device_t
-/u?dev/beep		-c	system_u:object_r:sound_device_t
-/u?dev/patmgr[01]	-c	system_u:object_r:sound_device_t
-/u?dev/mpu401.*		-c	system_u:object_r:sound_device_t
-/u?dev/srnd[0-7]	-c	system_u:object_r:sound_device_t
-/u?dev/aload.*		-c	system_u:object_r:sound_device_t
-/u?dev/amidi.*		-c	system_u:object_r:sound_device_t
-/u?dev/amixer.*		-c	system_u:object_r:sound_device_t
-/u?dev/snd/.*		-c	system_u:object_r:sound_device_t
-/u?dev/n?[hs]t[0-9].*	-c	system_u:object_r:tape_device_t
-/u?dev/n?(raw)?[qr]ft[0-3] -c	system_u:object_r:tape_device_t
-/u?dev/n?z?qft[0-3]	-c	system_u:object_r:tape_device_t
-/u?dev/n?tpqic[12].*	-c	system_u:object_r:tape_device_t
-/u?dev/ht[0-1]		-b	system_u:object_r:tape_device_t
-/u?dev/n?osst[0-3].*	-c	system_u:object_r:tape_device_t
-/u?dev/n?pt[0-9]+	-c	system_u:object_r:tape_device_t
-/u?dev/tape.*		-c	system_u:object_r:tape_device_t
+/dev/pg[0-3]		-c	system_u:object_r:removable_device_t
+/dev/rtc		-c	system_u:object_r:clock_device_t
+/dev/psaux		-c	system_u:object_r:mouse_device_t
+/dev/atibm		-c	system_u:object_r:mouse_device_t
+/dev/logibm		-c	system_u:object_r:mouse_device_t
+/dev/.*mouse.*	-c	system_u:object_r:mouse_device_t
+/dev/input/.*mouse.*	-c	system_u:object_r:mouse_device_t
+/dev/input/event.*	-c	system_u:object_r:event_device_t
+/dev/input/mice	-c	system_u:object_r:mouse_device_t
+/dev/input/js.*	-c	system_u:object_r:mouse_device_t
+/dev/ptmx		-c	system_u:object_r:ptmx_t
+/dev/sequencer	-c	system_u:object_r:misc_device_t
+/dev/fb[0-9]*		-c	system_u:object_r:framebuf_device_t
+/dev/apm_bios		-c	system_u:object_r:apm_bios_t
+/dev/cpu/mtrr		-c	system_u:object_r:mtrr_device_t
+/dev/pmu		-c	system_u:object_r:power_device_t
+/dev/(radio|video|vbi|vtx).* -c	system_u:object_r:v4l_device_t
+/dev/winradio.	-c	system_u:object_r:v4l_device_t
+/dev/vttuner		-c	system_u:object_r:v4l_device_t
+/dev/tlk[0-3]		-c	system_u:object_r:v4l_device_t
+/dev/adsp		-c	system_u:object_r:sound_device_t
+/dev/mixer.*		-c	system_u:object_r:sound_device_t
+/dev/dsp.*		-c	system_u:object_r:sound_device_t
+/dev/audio.*		-c	system_u:object_r:sound_device_t
+/dev/r?midi.*		-c	system_u:object_r:sound_device_t
+/dev/sequencer2	-c	system_u:object_r:sound_device_t
+/dev/smpte.*		-c	system_u:object_r:sound_device_t
+/dev/sndstat		-c	system_u:object_r:sound_device_t
+/dev/beep		-c	system_u:object_r:sound_device_t
+/dev/patmgr[01]	-c	system_u:object_r:sound_device_t
+/dev/mpu401.*		-c	system_u:object_r:sound_device_t
+/dev/srnd[0-7]	-c	system_u:object_r:sound_device_t
+/dev/aload.*		-c	system_u:object_r:sound_device_t
+/dev/amidi.*		-c	system_u:object_r:sound_device_t
+/dev/amixer.*		-c	system_u:object_r:sound_device_t
+/dev/snd/.*		-c	system_u:object_r:sound_device_t
+/dev/n?[hs]t[0-9].*	-c	system_u:object_r:tape_device_t
+/dev/n?(raw)?[qr]ft[0-3] -c	system_u:object_r:tape_device_t
+/dev/n?z?qft[0-3]	-c	system_u:object_r:tape_device_t
+/dev/n?tpqic[12].*	-c	system_u:object_r:tape_device_t
+/dev/ht[0-1]		-b	system_u:object_r:tape_device_t
+/dev/n?osst[0-3].*	-c	system_u:object_r:tape_device_t
+/dev/n?pt[0-9]+	-c	system_u:object_r:tape_device_t
+/dev/tape.*		-c	system_u:object_r:tape_device_t
 ifdef(`distro_suse', `
-/u?dev/usbscanner	-c	system_u:object_r:scanner_device_t
+/dev/usbscanner	-c	system_u:object_r:scanner_device_t
 ')
-/u?dev/usb/scanner.*	-c	system_u:object_r:scanner_device_t
-/u?dev/usb/dc2xx.*	-c	system_u:object_r:scanner_device_t
-/u?dev/usb/mdc800.*	-c	system_u:object_r:scanner_device_t
-/u?dev/usb/tty.*	-c	system_u:object_r:usbtty_device_t
-/u?dev/mmetfgrab	-c	system_u:object_r:scanner_device_t
-/u?dev/nvidia.*		-c	system_u:object_r:xserver_misc_device_t
-/u?dev/dri/.+		-c	system_u:object_r:dri_device_t
-/u?dev/radeon		-c	system_u:object_r:dri_device_t
-/u?dev/agpgart		-c	system_u:object_r:agp_device_t
+/dev/usb/scanner.*	-c	system_u:object_r:scanner_device_t
+/dev/usb/dc2xx.*	-c	system_u:object_r:scanner_device_t
+/dev/usb/mdc800.*	-c	system_u:object_r:scanner_device_t
+/dev/usb/tty.*	-c	system_u:object_r:usbtty_device_t
+/dev/mmetfgrab	-c	system_u:object_r:scanner_device_t
+/dev/nvidia.*		-c	system_u:object_r:xserver_misc_device_t
+/dev/dri/.+		-c	system_u:object_r:dri_device_t
+/dev/radeon		-c	system_u:object_r:dri_device_t
+/dev/agpgart		-c	system_u:object_r:agp_device_t
 
 #
 # Misc
@@ -333,10 +333,11 @@
 /usr(/.*)?			system_u:object_r:usr_t
 /usr(/.*)?/lib(64)?(/.*)?	system_u:object_r:lib_t
 /usr(/.*)?/lib(64)?/.*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
-/usr(/.*)?/java/.*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
+/usr/lib/win32/.*	--	system_u:object_r:shlib_t
+/usr(/.*)?/java/.*\.so(\.[^/]*)*	--	system_u:object_r:texrel_shlib_t
 /usr(/.*)?/java/.*\.jar	--	system_u:object_r:shlib_t
 /usr(/.*)?/java/.*\.jsa	--	system_u:object_r:shlib_t
-/usr(/.*)?/HelixPlayer/.*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
+/usr(/.*)?/HelixPlayer/.*\.so(\.[^/]*)*	--	system_u:object_r:texrel_shlib_t
 /usr(/.*)?/lib(64)?(/.*)?/ld-[^/]*\.so(\.[^/]*)* system_u:object_r:ld_so_t
 /usr(/.*)?/bin(/.*)?		system_u:object_r:bin_t
 /usr(/.*)?/Bin(/.*)?		system_u:object_r:bin_t
@@ -356,9 +357,6 @@
 /usr(/.*)?/nvidia/.*\.so(\..*)?	-- system_u:object_r:texrel_shlib_t
 /usr/X11R6/lib/libXvMCNVIDIA\.so.* 	-- system_u:object_r:texrel_shlib_t
 
-# libGL
-/usr/X11R6/lib/libGL\.so.* 	-- system_u:object_r:texrel_shlib_t
-
 ifdef(`distro_debian', `
 /usr/share/selinux(/.*)?	system_u:object_r:policy_src_t
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.21.7/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2005-02-02 08:11:43.000000000 -0500
+++ policy-1.21.7/macros/base_user_macros.te	2005-02-02 08:27:37.000000000 -0500
@@ -187,6 +187,10 @@
 ifdef(`using_spamassassin', `spamassassin_domain($1)')
 ifdef(`uml.te', `uml_domain($1)')
 ifdef(`cdrecord.te', `cdrecord_domain($1)')
+ifdef(`mplayer.te', `
+mplayer_domain($1)
+mencoder_domain($1)
+')
 
 # Instantiate a derived domain for user cron jobs.
 ifdef(`crond.te', `crond_domain($1)')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te policy-1.21.7/macros/global_macros.te
--- nsapolicy/macros/global_macros.te	2005-02-01 15:08:42.000000000 -0500
+++ policy-1.21.7/macros/global_macros.te	2005-02-02 08:27:37.000000000 -0500
@@ -106,9 +106,6 @@
 allow $1 ld_so_t:lnk_file r_file_perms;
 allow $1 { texrel_shlib_t shlib_t }:file rx_file_perms;
 allow $1 { texrel_shlib_t shlib_t }:lnk_file r_file_perms;
-if (allow_execmod) {
-allow $1 texrel_shlib_t:file execmod;
-}
 allow $1 ld_so_cache_t:file r_file_perms;
 allow $1 device_t:dir search;
 allow $1 null_device_t:chr_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/games_domain.te policy-1.21.7/macros/program/games_domain.te
--- nsapolicy/macros/program/games_domain.te	2005-01-31 10:02:06.000000000 -0500
+++ policy-1.21.7/macros/program/games_domain.te	2005-02-02 08:27:37.000000000 -0500
@@ -39,7 +39,6 @@
 allow $1_games_t var_lib_t:dir search;
 r_dir_file($1_games_t, man_t)
 allow $1_games_t proc_t:file { read getattr };
-dontaudit $1_games_t devpts_t:dir search;
 ifdef(`mozilla.te', ` 
 dontaudit $1_games_t $1_mozilla_t:unix_stream_socket connectto;
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mplayer_macros.te policy-1.21.7/macros/program/mplayer_macros.te
--- nsapolicy/macros/program/mplayer_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.21.7/macros/program/mplayer_macros.te	2005-02-02 08:28:15.000000000 -0500
@@ -0,0 +1,117 @@
+#
+# Macros for mplayer
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+#
+# mplayer_domain(domain_prefix)
+# mencoder_domain(domain_prefix)
+
+################################################
+#    mplayer_common(prefix, mplayer domain)    #
+################################################
+
+define(`mplayer_common',`
+
+# Home directory stuff
+if (use_nfs_home_dirs) {
+create_dir_file($1_$2_t, nfs_t)
+}
+if (use_samba_home_dirs) {
+create_dir_file($1_$2_t, cifs_t)
+}
+allow $1_$2_t autofs_t:dir { search getattr };
+
+# Read local config
+r_dir_file($1_$2_t, $1_mplayer_rw_t)
+
+# Read global config
+r_dir_file($1_$2_t, mplayer_etc_t)
+
+# Read data in /usr/share (fonts, icons..)
+r_dir_file($1_$2_t, usr_t)
+
+# Read /proc files and directories
+# Necessary for /proc/meminfo, /proc/cpuinfo, etc..
+allow $1_$2_t proc_t:dir search;
+allow $1_$2_t proc_t:file { getattr read };
+
+# Sysctl on kernel version 
+allow $1_$2_t sysctl_kernel_t:dir search;
+allow $1_$2_t sysctl_kernel_t:file { getattr read };
+
+# allow ps
+can_ps($1_t, $1_$2_t)
+
+# uses shared libraries
+uses_shlib($1_$2_t)
+
+# localization
+read_locale($1_$2_t)
+
+# Access the terminal.
+allow $1_$2_t devpts_t:dir { search };
+allow $1_$2_t $1_tty_device_t:chr_file rw_file_perms;
+allow $1_$2_t $1_devpts_t:chr_file rw_file_perms;
+
+# Required for win32 binary loader 
+allow $1_$2_t zero_device_t:chr_file { read write execute };
+if (allow_execmem) {
+allow $1_$2_t self:process { execmem };
+}
+
+# Access to DVD/CD/V4L
+allow $1_$2_t device_t:dir r_dir_perms;
+allow $1_$2_t device_t:lnk_file { getattr read };
+allow $1_$2_t removable_device_t:blk_file { getattr read };
+allow $1_$2_t v4l_device_t:chr_file { getattr read };
+')
+
+##############################
+#  mplayer_domain(prefix)    #
+##############################
+
+define(`mplayer_domain',`
+
+# Derive from X client domain
+x_client_domain($1, `mplayer', `')
+
+# Mplayer common stuff
+mplayer_common($1, mplayer)
+
+# Additional rules for search /tmp/.X11-unix
+ifdef(`xdm.te', `
+allow $1_mplayer_t xdm_tmp_t:dir search;
+')dnl end if xdm.te
+
+# Prevent getattr denials on restricted types when browsing with gmplayer
+dontaudit $1_mplayer_t file_type:dir_file_class_set { getattr };
+
+# Audio
+allow $1_mplayer_t sound_device_t:chr_file rw_file_perms;
+
+# RTC clock 
+allow $1_mplayer_t clock_device_t:chr_file { ioctl read };
+
+# Read home directory content
+r_dir_file($1_mplayer_t, $1_home_t);
+') dnl end mplayer_domain
+
+##############################
+#  mencoder_domain(prefix)   #
+##############################
+
+define(`mencoder_domain',`
+
+# Privhome type transitions to $1_home_t in home dir.
+type $1_mencoder_t, domain, privhome;
+
+# Transition
+domain_auto_trans($1_t, mencoder_exec_t, $1_mencoder_t)
+can_exec($1_mencoder_t, mencoder_exec_t)
+role $1_r types $1_mencoder_t;
+
+# Mplayer common stuff
+mplayer_common($1, mencoder)
+
+') dnl end mencoder_domain
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/samba_macros.te policy-1.21.7/macros/program/samba_macros.te
--- nsapolicy/macros/program/samba_macros.te	2005-01-31 10:02:06.000000000 -0500
+++ policy-1.21.7/macros/program/samba_macros.te	2005-02-02 08:27:37.000000000 -0500
@@ -19,6 +19,7 @@
 ifdef(`samba.te', `
 define(`samba_domain',`
 if ( samba_enable_home_dirs ) {
+allow smbd_t home_root_t:dir r_dir_perms;
 file_type_auto_trans(smbd_t, $1_home_dir_t, $1_home_t)
 }
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/appconfig/default_contexts policy-1.21.7/targeted/appconfig/default_contexts
--- nsapolicy/targeted/appconfig/default_contexts	2005-01-31 10:02:06.000000000 -0500
+++ policy-1.21.7/targeted/appconfig/default_contexts	2005-02-02 08:27:37.000000000 -0500
@@ -2,3 +2,4 @@
 system_r:initrc_t	system_r:unconfined_t
 system_r:remote_login_t system_r:unconfined_t
 system_r:rshd_t		system_r:unconfined_t
+system_r:crond_t	system_r:unconfined_t
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/program/crond.te policy-1.21.7/targeted/domains/program/crond.te
--- nsapolicy/targeted/domains/program/crond.te	2005-02-01 15:08:45.000000000 -0500
+++ policy-1.21.7/targeted/domains/program/crond.te	2005-02-02 08:27:37.000000000 -0500
@@ -11,7 +11,7 @@
 # This domain is defined just for targeted policy.
 #
 type crond_exec_t, file_type, sysadmfile, exec_type;
-type crond_t, domain;
+type crond_t, domain, privuser, privrole, privowner;
 typealias crond_t alias system_crond_t;
 type anacron_exec_t, file_type, sysadmfile, exec_type;
 type system_crond_tmp_t, file_type, sysadmfile;
@@ -19,7 +19,7 @@
 type sysadm_cron_spool_t, file_type, sysadmfile;
 type crond_log_t, file_type, sysadmfile;
 type crond_var_run_t, file_type, sysadmfile;
-role system_r types system_crond_t;
+role system_r types crond_t;
 domain_auto_trans(initrc_t, crond_exec_t, crond_t)
 domain_auto_trans(initrc_t, anacron_exec_t, crond_t)
 unconfined_domain(crond_t)
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.21.7/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2005-01-31 10:02:06.000000000 -0500
+++ policy-1.21.7/tunables/distro.tun	2005-02-02 08:27:37.000000000 -0500
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.21.7/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2005-01-31 10:02:06.000000000 -0500
+++ policy-1.21.7/tunables/tunable.tun	2005-02-02 08:27:37.000000000 -0500
@@ -1,27 +1,27 @@
 # Allow users to execute the mount command
-dnl define(`user_can_mount')
+define(`user_can_mount')
 
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
-dnl define(`unlimitedUtils')
+define(`unlimitedUtils')
 
 # Allow rc scripts to run unconfined, including any daemon
 # started by an rc script that does not have a domain transition
 # explicitly defined.
-dnl define(`unlimitedRC')
+define(`unlimitedRC')
 
 # Allow sysadm_t to directly start daemons
 define(`direct_sysadm_daemon')
 
 # Do not audit things that we know to be broken but which
 # are not security risks
-dnl define(`hide_broken_symptoms')
+define(`hide_broken_symptoms')
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
-dnl define(`user_canbe_sysadm')
+define(`user_canbe_sysadm')
 
 # Allow xinetd to run unconfined, including any services it starts
 # that do not have a domain transition explicitly defined.

--------------050407090204050907050608--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
