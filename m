Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA65OKIi005352
	for <selinux@tycho.nsa.gov>; Sat, 6 Nov 2004 00:24:20 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA65OK3G003741
	for <selinux@tycho.nsa.gov>; Sat, 6 Nov 2004 05:24:23 GMT
Message-ID: <418C5FEF.8060102@redhat.com>
Date: Sat, 06 Nov 2004 00:23:59 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: Russell Coker <russell@coker.com.au>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Remaining changes from my patch excluding can_network changes.
References: <41741A2C.8040408@redhat.com>	 <200410260138.19426.russell@coker.com.au>	 <20041025213122.GA2535@jmh.mhn.de>	 <200410270036.14935.russell@coker.com.au> <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------000101020404020806060502"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000101020404020806060502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Most of these are small bug fix changes.  Some are quite critical like the
removable_t associate one.


--------------000101020404020806060502
Content-Type: text/x-patch;
 name="policy-small.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-small.patch"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/init.te policy-1.18.2/domains/program/init.te
--- nsapolicy/domains/program/init.te	2004-10-14 23:25:17.000000000 -0400
+++ policy-1.18.2/domains/program/init.te	2004-11-06 00:09:29.695365943 -0500
@@ -14,7 +14,7 @@
 # by init during initialization.  This pipe is used
 # to communicate with init.
 #
-type init_t, domain, privlog, mlstrustedreader, mlstrustedwriter, sysctl_kernel_writer;
+type init_t, domain, privlog, mlstrustedreader, mlstrustedwriter, sysctl_kernel_writer, nscd_client_domain;
 role system_r types init_t;
 uses_shlib(init_t);
 type init_exec_t, file_type, sysadmfile, exec_type;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/acct.te policy-1.18.2/domains/program/unused/acct.te
--- nsapolicy/domains/program/unused/acct.te	2004-10-19 16:03:05.000000000 -0400
+++ policy-1.18.2/domains/program/unused/acct.te	2004-11-06 00:09:29.695365943 -0500
@@ -63,6 +63,8 @@
 
 ifdef(`logrotate.te', `
 domain_auto_trans(logrotate_t, acct_exec_t, acct_t)
+allow logrotate_t acct_data_t:dir { search };
 allow logrotate_t acct_data_t:file { create_file_perms };
+can_exec(logrotate_t, acct_data_t)
 ')
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apmd.te policy-1.18.2/domains/program/unused/apmd.te
--- nsapolicy/domains/program/unused/apmd.te	2004-09-09 16:22:12.000000000 -0400
+++ policy-1.18.2/domains/program/unused/apmd.te	2004-11-06 00:09:29.696365838 -0500
@@ -9,7 +9,7 @@
 #
 # Rules for the apmd_t domain.
 #
-daemon_domain(apmd, `, privmodule')
+daemon_domain(apmd, `, privmodule, nscd_client_domain')
 
 # for SSP
 allow apmd_t urandom_device_t:chr_file read;
@@ -123,3 +123,4 @@
 # for a find /dev operation that gets /dev/shm
 dontaudit apmd_t tmpfs_t:dir r_dir_perms;
 dontaudit apmd_t selinux_config_t:dir search;
+allow apmd_t user_tty_type:chr_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cardmgr.te policy-1.18.2/domains/program/unused/cardmgr.te
--- nsapolicy/domains/program/unused/cardmgr.te	2004-09-27 20:48:35.000000000 -0400
+++ policy-1.18.2/domains/program/unused/cardmgr.te	2004-11-06 00:09:29.696365838 -0500
@@ -82,3 +82,7 @@
 dontaudit insmod_t cardmgr_dev_t:chr_file { read write };
 dontaudit ifconfig_t cardmgr_dev_t:chr_file { read write };
 ')
+ifdef(`hald.te', `
+rw_dir_file(hald_t, cardmgr_var_run_t)
+allow hald_t cardmgr_var_run_t:chr_file create_file_perms;
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/consoletype.te policy-1.18.2/domains/program/unused/consoletype.te
--- nsapolicy/domains/program/unused/consoletype.te	2004-10-14 23:25:18.000000000 -0400
+++ policy-1.18.2/domains/program/unused/consoletype.te	2004-11-06 00:09:29.697365732 -0500
@@ -59,3 +59,5 @@
 ')
 dontaudit consoletype_t proc_t:file { read };
 dontaudit consoletype_t root_t:file { read };
+allow consoletype_t crond_t:fifo_file { read };
+allow consoletype_t fs_t:filesystem { getattr };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cpuspeed.te policy-1.18.2/domains/program/unused/cpuspeed.te
--- nsapolicy/domains/program/unused/cpuspeed.te	2004-03-17 13:26:05.000000000 -0500
+++ policy-1.18.2/domains/program/unused/cpuspeed.te	2004-11-06 00:09:29.697365732 -0500
@@ -8,3 +8,5 @@
 allow cpuspeed_t sysfs_t:file rw_file_perms;
 allow cpuspeed_t proc_t:dir r_dir_perms;
 allow cpuspeed_t proc_t:file { getattr read };
+allow cpuspeed_t etc_runtime_t:file { getattr read };
+allow cpuspeed_t etc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dbskkd.te policy-1.18.2/domains/program/unused/dbskkd.te
--- nsapolicy/domains/program/unused/dbskkd.te	2004-10-06 09:18:32.000000000 -0400
+++ policy-1.18.2/domains/program/unused/dbskkd.te	2004-11-06 00:09:29.698365627 -0500
@@ -9,5 +9,6 @@
 #
 # dbskkd_exec_t is the type of the dbskkd executable.
 #
+# Depends: inetd.te
 
 inetd_child_domain(dbskkd)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ktalkd.te policy-1.18.2/domains/program/unused/ktalkd.te
--- nsapolicy/domains/program/unused/ktalkd.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.18.2/domains/program/unused/ktalkd.te	2004-11-06 00:09:29.699365522 -0500
@@ -2,6 +2,7 @@
 #
 # Author:  Dan Walsh <dwalsh@redhat.com>
 #
+# Depends: inetd.te
 
 #################################
 #
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/kudzu.te policy-1.18.2/domains/program/unused/kudzu.te
--- nsapolicy/domains/program/unused/kudzu.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.18.2/domains/program/unused/kudzu.te	2004-11-06 00:09:29.700365417 -0500
@@ -13,7 +13,7 @@
 allow kudzu_t ramfs_t:dir search;
 allow kudzu_t ramfs_t:sock_file write;
 allow kudzu_t etc_t:file { getattr read };
-allow kudzu_t self:capability { dac_override sys_admin sys_rawio net_admin sys_tty_config };
+allow kudzu_t self:capability { dac_override sys_admin sys_rawio net_admin sys_tty_config mknod };
 allow kudzu_t modules_conf_t:file { getattr read };
 allow kudzu_t modules_object_t:dir r_dir_perms;
 allow kudzu_t { modules_object_t modules_dep_t }:file { getattr read };
@@ -80,7 +80,8 @@
 allow kudzu_t sysfs_t:lnk_file read;
 file_type_auto_trans(kudzu_t, etc_t, etc_runtime_t, file)
 allow kudzu_t tape_device_t:chr_file r_file_perms;
-allow kudzu_t tmp_t:dir { search };
+tmp_domain(kudzu)
+file_type_auto_trans(kudzu_t, tmp_t, kudzu_tmp_t, chr_file)
 
 # for file systems that are not yet mounted
 dontaudit kudzu_t file_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mdadm.te policy-1.18.2/domains/program/unused/mdadm.te
--- nsapolicy/domains/program/unused/mdadm.te	2004-10-13 22:41:57.000000000 -0400
+++ policy-1.18.2/domains/program/unused/mdadm.te	2004-11-06 00:09:29.700365417 -0500
@@ -40,4 +40,4 @@
 dontaudit mdadm_t tmpfs_t:dir r_dir_perms;
 dontaudit mdadm_t initctl_t:fifo_file { getattr };
 var_run_domain(mdadm)
-allow mdadm_t var_t:dir { getattr };
+allow mdadm_t var_t:dir { getattr search };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/portmap.te policy-1.18.2/domains/program/unused/portmap.te
--- nsapolicy/domains/program/unused/portmap.te	2004-10-09 21:06:14.000000000 -0400
+++ policy-1.18.2/domains/program/unused/portmap.te	2004-11-06 00:10:58.306027721 -0500
@@ -23,6 +23,7 @@
 tmp_domain(portmap)
 
 allow portmap_t portmap_port_t:{ udp_socket tcp_socket } name_bind;
+dontaudit portmap_t reserved_port_type:tcp_socket name_bind;
 
 # portmap binds to arbitary ports
 allow portmap_t port_t:{ udp_socket tcp_socket } name_bind;
@@ -51,4 +52,5 @@
 
 # Use capabilities
 allow portmap_t self:capability { net_bind_service setuid setgid };
+allow portmap_t self:netlink_route_socket r_netlink_socket_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rsync.te policy-1.18.2/domains/program/unused/rsync.te
--- nsapolicy/domains/program/unused/rsync.te	2004-10-19 16:03:06.000000000 -0400
+++ policy-1.18.2/domains/program/unused/rsync.te	2004-11-06 00:09:29.703365101 -0500
@@ -2,6 +2,7 @@
 #
 # Author:  Dan Walsh <dwalsh@redhat.com>
 #
+# Depends: inetd.te
 
 #################################
 #
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/slocate.te policy-1.18.2/domains/program/unused/slocate.te
--- nsapolicy/domains/program/unused/slocate.te	2004-10-14 23:25:18.000000000 -0400
+++ policy-1.18.2/domains/program/unused/slocate.te	2004-11-06 00:11:31.375539016 -0500
@@ -2,6 +2,7 @@
 #
 # Author:  Dan Walsh <dwalsh@redhat.com>
 #
+# Depends: inetd.te
 
 #################################
 #
@@ -70,3 +71,6 @@
 typealias sysadm_t alias sysadm_locate_t;
 
 allow locate_t userdomain:fd { use };
+ifdef(`cardmgr.te', `
+allow locate_t cardmgr_var_run_t:chr_file getattr;
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.18.2/domains/program/unused/udev.te
--- nsapolicy/domains/program/unused/udev.te	2004-11-05 23:24:16.000000000 -0500
+++ policy-1.18.2/domains/program/unused/udev.te	2004-11-06 00:09:29.766358467 -0500
@@ -81,6 +81,7 @@
 ifdef(`xdm.te', `
 allow udev_t xdm_var_run_t:file { getattr read };
 ')
+dontaudit udev_t staff_home_dir_t:dir { search };
 
 ifdef(`hotplug.te', `
 r_dir_file(udev_t, hotplug_etc_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ypserv.te policy-1.18.2/domains/program/unused/ypserv.te
--- nsapolicy/domains/program/unused/ypserv.te	2004-10-13 22:41:58.000000000 -0400
+++ policy-1.18.2/domains/program/unused/ypserv.te	2004-11-06 00:09:29.724362890 -0500
@@ -40,3 +40,4 @@
 allow rpcd_t ypserv_conf_t:file { getattr read };
 ')
 allow ypserv_t reserved_port_t:{ udp_socket tcp_socket } { name_bind };
+dontaudit ypserv_t reserved_port_type:{ tcp_socket udp_socket } { name_bind };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/useradd.te policy-1.18.2/domains/program/useradd.te
--- nsapolicy/domains/program/useradd.te	2004-11-05 23:24:16.000000000 -0500
+++ policy-1.18.2/domains/program/useradd.te	2004-11-06 00:09:29.724362890 -0500
@@ -25,7 +25,7 @@
 domain_auto_trans(initrc_t, $1_exec_t, $1_t)
 
 # Use capabilities.
-allow $1_t self:capability { dac_override chown };
+allow $1_t self:capability { dac_override chown kill };
 
 # Allow access to context for shadow file
 can_getsecurity($1_t)
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/innd.fc policy-1.18.2/file_contexts/program/innd.fc
--- nsapolicy/file_contexts/program/innd.fc	2004-10-19 16:03:07.000000000 -0400
+++ policy-1.18.2/file_contexts/program/innd.fc	2004-11-06 00:09:29.740361205 -0500
@@ -27,7 +27,6 @@
 /usr/lib(64)?/news/bin/grephistory	--	system_u:object_r:innd_exec_t
 /usr/lib(64)?/news/bin/inews	--	system_u:object_r:innd_exec_t
 /usr/lib(64)?/news/bin/innconfval	--	system_u:object_r:innd_exec_t
-/usr/lib(64)?/news/bin/innd	--	system_u:object_r:innd_exec_t
 /usr/lib(64)?/news/bin/inndf	--	system_u:object_r:innd_exec_t
 /usr/lib(64)?/news/bin/inndstart	--	system_u:object_r:innd_exec_t
 /usr/lib(64)?/news/bin/innfeed	--	system_u:object_r:innd_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/mailman.fc policy-1.18.2/file_contexts/program/mailman.fc
--- nsapolicy/file_contexts/program/mailman.fc	2004-10-13 22:41:58.000000000 -0400
+++ policy-1.18.2/file_contexts/program/mailman.fc	2004-11-06 00:09:29.741361100 -0500
@@ -1,25 +1,24 @@
 # mailman list server
+/var/lib/mailman(/.*)?		   system_u:object_r:mailman_data_t
 /var/log/mailman(/.*)?		   system_u:object_r:mailman_log_t
 /usr/lib/mailman/cron/.*	-- system_u:object_r:mailman_queue_exec_t
 /usr/lib/mailman/bin/mailmanctl -- system_u:object_r:mailman_mail_exec_t
+/var/run/mailman(/.*)?		   system_u:object_r:mailman_lock_t
+/var/lib/mailman/archives(/.*)?	system_u:object_r:mailman_archive_t
 
 ifdef(`distro_debian', `
 /usr/lib/cgi-bin/mailman/.* -- system_u:object_r:mailman_cgi_exec_t
 /usr/lib/mailman/mail/wrapper -- system_u:object_r:mailman_mail_exec_t
 /usr/mailman/mail/wrapper 	-- system_u:object_r:mailman_mail_exec_t
-/var/lib/mailman(/.*)?	   system_u:object_r:mailman_data_t
-/var/lib/mailman/archives(/.*)?	system_u:object_r:mailman_archive_t
 /etc/cron\.daily/mailman 	-- system_u:object_r:mailman_queue_exec_t
 /etc/cron\.monthly/mailman 	-- system_u:object_r:mailman_queue_exec_t
 ')
 
 ifdef(`distro_redhat', `
-/usr/lib/mailman/cgi-bin/.*	-- system_u:object_r:mailman_cgi_exec_t
-/var/mailman(/.*)?		   system_u:object_r:mailman_data_t
-/var/mailman/locks(/.*)?	   system_u:object_r:mailman_lock_t
-/var/mailman/archives(/.*)?	   system_u:object_r:mailman_archive_t
+/usr/lib/mailman/cgi-bin/.*	 -- system_u:object_r:mailman_cgi_exec_t
+/var/lock/mailman(/.*)?		    system_u:object_r:mailman_lock_t
 /usr/lib/mailman/scripts/mailman -- system_u:object_r:mailman_mail_exec_t
-/usr/lib/mailman/bin/qrunner  	-- system_u:object_r:mailman_queue_exec_t
-/var/mailman/lists(/.*)?	system_u:object_r:mailman_data_t
-/var/mailman/logs(/.*)?		   system_u:object_r:mailman_log_t
+/usr/lib/mailman/bin/qrunner  	 -- system_u:object_r:mailman_queue_exec_t
+/etc/mailman(/.*)?		   system_u:object_r:mailman_data_t
+/var/spool/mailman(/.*)?	   system_u:object_r:mailman_data_t
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/ntpd.fc policy-1.18.2/file_contexts/program/ntpd.fc
--- nsapolicy/file_contexts/program/ntpd.fc	2004-10-09 21:06:15.000000000 -0400
+++ policy-1.18.2/file_contexts/program/ntpd.fc	2004-11-06 00:09:29.741361100 -0500
@@ -3,7 +3,7 @@
 /etc/ntp(d)?\.conf		--	system_u:object_r:net_conf_t
 /etc/ntp/step-tickers		--	system_u:object_r:net_conf_t
 /usr/sbin/ntpd			--	system_u:object_r:ntpd_exec_t
-/usr/sbin/ntpdate		--	system_u:object_r:ntpd_exec_t
+/usr/sbin/ntpdate		--	system_u:object_r:ntpdate_exec_t
 /var/log/ntpstats(/.*)?			system_u:object_r:ntpd_log_t
 /var/log/ntpd.*			--	system_u:object_r:ntpd_log_t
 /var/log/xntpd.*		--	system_u:object_r:ntpd_log_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/vpnc.fc policy-1.18.2/file_contexts/program/vpnc.fc
--- nsapolicy/file_contexts/program/vpnc.fc	2004-10-05 10:43:34.000000000 -0400
+++ policy-1.18.2/file_contexts/program/vpnc.fc	2004-11-06 00:09:29.742360994 -0500
@@ -1,2 +1,3 @@
 # vpnc
 /usr/sbin/vpnc		--	system_u:object_r:vpnc_exec_t
+/sbin/vpnc		--	system_u:object_r:vpnc_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.18.2/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2004-10-27 14:32:49.000000000 -0400
+++ policy-1.18.2/file_contexts/types.fc	2004-11-06 00:09:29.743360889 -0500
@@ -339,7 +339,8 @@
 /usr/inclu.e(/.*)?		system_u:object_r:usr_t
 /usr/libexec(/.*)?		system_u:object_r:bin_t
 /usr/src(/.*)?			system_u:object_r:src_t
-/usr/tmp(/.*)?			system_u:object_r:tmp_t
+/usr/tmp		-d	system_u:object_r:tmp_t
+/usr/tmp/.*			<<none>>
 /usr/man(/.*)?			system_u:object_r:man_t
 /usr/share/man(/.*)?		system_u:object_r:man_t
 /usr/share/mc/extfs/.*	--	system_u:object_r:bin_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/admin_macros.te policy-1.18.2/macros/admin_macros.te
--- nsapolicy/macros/admin_macros.te	2004-10-01 15:05:32.000000000 -0400
+++ policy-1.18.2/macros/admin_macros.te	2004-11-06 00:09:29.743360889 -0500
@@ -195,4 +195,5 @@
 
 # for lsof
 allow $1_t domain:socket_class_set getattr;
+allow $1_t eventpollfs_t:file getattr;
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.18.2/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2004-11-05 23:24:17.000000000 -0500
+++ policy-1.18.2/macros/base_user_macros.te	2004-11-06 00:09:29.744360784 -0500
@@ -46,9 +46,12 @@
 allow $1_t root_dir_type:dir { getattr };
 
 # open office is looking for the following
+allow $1_t dri_device_t:chr_file getattr;
 dontaudit $1_t dri_device_t:chr_file rw_file_perms;
-# Do not flood message log, if the user does ls /dev 
+# Do not flood message log, if the user does ls -lR /
 dontaudit $1_t dev_fs:dir_file_class_set getattr;
+dontaudit $1_t sysadmfile:file getattr;
+dontaudit $1_t sysadmfile:dir read;
 
 # allow ptrace
 can_ptrace($1_t, $1_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mount_macros.te policy-1.18.2/macros/program/mount_macros.te
--- nsapolicy/macros/program/mount_macros.te	2004-10-19 16:03:08.000000000 -0400
+++ policy-1.18.2/macros/program/mount_macros.te	2004-11-06 00:09:29.745360678 -0500
@@ -67,9 +67,11 @@
 ifdef(`gnome-pty-helper.te', `allow $2_t $1_gph_t:fd use;')
 
 ifdef(`distro_redhat',`
+ifdef(`pamconsole.te',`
 r_dir_file($2_t,pam_var_console_t)
 # mount config by default sets fscontext=removable_t
 allow $2_t dosfs_t:filesystem { relabelfrom };
+') dnl end pamconsole.te
 ') dnl end distro_redhat
 ') dnl end mount_domain
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/newrole_macros.te policy-1.18.2/macros/program/newrole_macros.te
--- nsapolicy/macros/program/newrole_macros.te	2004-11-01 11:04:37.000000000 -0500
+++ policy-1.18.2/macros/program/newrole_macros.te	2004-11-06 00:09:29.766358467 -0500
@@ -10,7 +10,7 @@
 # $1_t is the domain for the program.
 # $1_exec_t is the type of the executable.
 #
-type $1_t, domain, privrole, privowner, privlog, auth_chkpwd, privfd $2;
+type $1_t, domain, privrole, privowner, privlog, auth_chkpwd, nscd_client_domain, privfd $2;
 in_user_role($1_t)
 role sysadm_r types $1_t;
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/sudo_macros.te policy-1.18.2/macros/program/sudo_macros.te
--- nsapolicy/macros/program/sudo_macros.te	2004-11-01 11:04:37.000000000 -0500
+++ policy-1.18.2/macros/program/sudo_macros.te	2004-11-06 00:09:29.745360678 -0500
@@ -31,4 +31,5 @@
 rw_dir_create_file($1_sudo_t, $1_tmp_t)
 rw_dir_create_file($1_sudo_t, $1_home_t)
 domain_auto_trans($1_t, sudo_exec_t, $1_sudo_t)
+r_dir_file($1_sudo_t, selinux_config_t)
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/tvtime_macros.te policy-1.18.2/macros/program/tvtime_macros.te
--- nsapolicy/macros/program/tvtime_macros.te	2004-10-05 14:52:36.000000000 -0400
+++ policy-1.18.2/macros/program/tvtime_macros.te	2004-11-06 00:09:29.746360573 -0500
@@ -33,7 +33,9 @@
 allow $1_tvtime_t self:capability { setuid sys_nice sys_resource };
 allow $1_tvtime_t self:process { setsched };
 allow $1_tvtime_t usr_t:file { getattr read };
+ifdef(`xdm.te', `
 allow $1_tvtime_t xdm_tmp_t:dir { search };
+')
 
 ')dnl end tvtime_domain
 
diff --exclude-from=exclude -N -u -r nsapolicy/net_contexts policy-1.18.2/net_contexts
--- nsapolicy/net_contexts	2004-10-19 16:03:01.000000000 -0400
+++ policy-1.18.2/net_contexts	2004-11-06 00:12:13.252118368 -0500
@@ -93,7 +93,12 @@
 ifdef(`comsat.te', `
 portcon udp 512 system_u:object_r:comsat_port_t
 ')
-ifdef(`slapd.te', `portcon tcp 389 system_u:object_r:ldap_port_t')
+ifdef(`slapd.te', `
+portcon tcp 389 system_u:object_r:ldap_port_t
+portcon udp 389 system_u:object_r:ldap_port_t
+portcon tcp 636 system_u:object_r:ldap_port_t
+portcon udp 636 system_u:object_r:ldap_port_t
+')
 ifdef(`rlogind.te', `portcon tcp 513 system_u:object_r:rlogin_port_t')
 ifdef(`rshd.te', `portcon tcp 514 system_u:object_r:rsh_port_t')
 ifdef(`lpd.te', `portcon tcp 515 system_u:object_r:printer_port_t')
@@ -110,9 +115,12 @@
 ')
 ifdef(`kerberos.te', `
 portcon tcp 88 system_u:object_r:kerberos_port_t
+portcon udp 88 system_u:object_r:kerberos_port_t
 portcon tcp 749 system_u:object_r:kerberos_admin_port_t
 portcon tcp 750 system_u:object_r:kerberos_port_t
+portcon udp 750 system_u:object_r:kerberos_port_t
 portcon tcp 4444 system_u:object_r:kerberos_master_port_t
+portcon udp 4444 system_u:object_r:kerberos_master_port_t
 ')
 ifdef(`spamd.te', `portcon tcp 783 system_u:object_r:spamd_port_t')
 ifdef(`rsync.te', `
@@ -143,12 +151,12 @@
 ')
 ifdef(`asterisk.te', `
 portcon tcp 1720 system_u:object_r:asterisk_port_t
-portcon tcp 2000 system_u:object_r:asterisk_port_t
 portcon udp 2427 system_u:object_r:asterisk_port_t
 portcon udp 2727 system_u:object_r:asterisk_port_t
 portcon udp 4569 system_u:object_r:asterisk_port_t
 portcon udp 5060 system_u:object_r:asterisk_port_t
 ')
+portcon tcp 2000 system_u:object_r:mail_port_t
 ifdef(`zebra.te', `portcon tcp 2601 system_u:object_r:zebra_port_t')
 ifdef(`dictd.te', `portcon tcp 2628 system_u:object_r:dict_port_t')
 ifdef(`mysqld.te', `portcon tcp 3306 system_u:object_r:mysqld_port_t')
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.18.2/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-10-27 14:32:49.000000000 -0400
+++ policy-1.18.2/tunables/tunable.tun	2004-11-06 00:12:58.735313440 -0500
@@ -1,9 +1,3 @@
-# Allow all domains to connect to nscd
-dnl define(`nscd_all_connect')
-
-# Allow users to control network interfaces (also needs USERCTL=true)
-dnl define(`user_net_control')
-
 # Allow users to execute the mount command
 dnl define(`user_can_mount')
 
diff --exclude-from=exclude -N -u -r nsapolicy/types/file.te policy-1.18.2/types/file.te
--- nsapolicy/types/file.te	2004-11-05 23:24:17.000000000 -0500
+++ policy-1.18.2/types/file.te	2004-11-06 00:09:29.750360152 -0500
@@ -301,3 +301,4 @@
 # removable_t is the default type of all removable media
 type removable_t, file_type, sysadmfile, usercanread;
 allow removable_t self:filesystem associate;
+allow file_type removable_t:filesystem associate;
diff --exclude-from=exclude -N -u -r nsapolicy/types/network.te policy-1.18.2/types/network.te
--- nsapolicy/types/network.te	2004-10-13 22:41:58.000000000 -0400
+++ policy-1.18.2/types/network.te	2004-11-06 00:09:29.750360152 -0500
@@ -59,6 +59,11 @@
 #
 
 #
+# mail_port_t is for generic mail ports shared by different mail servers
+#
+type mail_port_t, port_type;
+
+#
 # port_t is the default type of INET port numbers.
 # The *_port_t types are used for specific port
 # numbers in net_contexts or net_contexts.mls.

--------------000101020404020806060502--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
