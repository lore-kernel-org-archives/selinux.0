Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82CkurT028471
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 08:46:57 -0400 (EDT)
Message-ID: <41371628.2020408@redhat.com>
Date: Thu, 02 Sep 2004 08:46:32 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: russell@coker.com.au, SELinux <selinux@tycho.nsa.gov>
Subject: Latest Patches
References: <200408241818.40064.russell@coker.com.au>	 <1093640295.24188.29.camel@moss-lions.epoch.ncsc.mil>	 <200408282346.05926.russell@coker.com.au> <1093897455.3227.6.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1093897455.3227.6.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------090506080401020809010209"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090506080401020809010209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Include some stuff from Russell,
Critical patch for tmpfs to get udev on tmpfs working

You sent me a note saying some patches conflict with other changes, 
please point those out so I can remove them.

Dan

--------------090506080401020809010209
Content-Type: text/plain;
 name="policy-20040902.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-20040902.patch"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/fsadm.te policy-1.17.9/domains/program/fsadm.te
--- nsapolicy/domains/program/fsadm.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.9/domains/program/fsadm.te	2004-09-02 08:15:02.734588923 -0400
@@ -29,6 +29,9 @@
 allow fsadm_t sysctl_kernel_t:file r_file_perms;
 allow fsadm_t sysctl_kernel_t:dir r_dir_perms;
 
+# for /dev/shm
+allow fsadm_t tmpfs_t:dir { getattr search };
+
 base_file_read_access(fsadm_t)
 
 # Read /etc.
@@ -81,6 +84,7 @@
 # Access disk devices.
 allow fsadm_t fixed_disk_device_t:devfile_class_set rw_file_perms;
 allow fsadm_t removable_device_t:devfile_class_set rw_file_perms;
+allow fsadm_t scsi_generic_device_t:chr_file r_file_perms;
 
 # Access lost+found.
 allow fsadm_t lost_found_t:dir create_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te policy-1.17.9/domains/program/initrc.te
--- nsapolicy/domains/program/initrc.te	2004-08-30 09:49:15.000000000 -0400
+++ policy-1.17.9/domains/program/initrc.te	2004-09-02 08:15:02.734588923 -0400
@@ -12,12 +12,14 @@
 # initrc_exec_t is the type of the init program.
 #
 # do not use privmail for sendmail as it creates a type transition conflict
-type initrc_t, ifdef(`unlimitedRC', `admin, etc_writer, fs_domain, privmem, auth_write, unrestricted, ') domain, privlog, privowner, privmodule, ifdef(`sendmail.te', `', `privmail,') sysctl_kernel_writer;
 ifdef(`sendmail.te', `
+# do not use privmail for sendmail as it creates a type transition conflict
+type initrc_t, ifdef(`unlimitedRC', `admin, etc_writer, fs_domain, privmem, auth_write, unrestricted, ') domain, privlog, privowner, privmodule, sysctl_kernel_writer;
 allow system_mail_t initrc_t:fd use;
 allow system_mail_t initrc_t:fifo_file write;
+', `
+type initrc_t, ifdef(`unlimitedRC', `admin, etc_writer, fs_domain, privmem,auth_write, unrestricted, ') domain, privlog, privowner, privmodule, sysctl_kernel_writer, privmail;
 ')
-
 role system_r types initrc_t;
 uses_shlib(initrc_t);
 can_ypbind(initrc_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/logrotate.te policy-1.17.9/domains/program/logrotate.te
--- nsapolicy/domains/program/logrotate.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.9/domains/program/logrotate.te	2004-09-02 08:15:02.735588811 -0400
@@ -41,7 +41,8 @@
 allow logrotate_t etc_runtime_t:file r_file_perms;
 
 # it should not require this
-dontaudit logrotate_t {staff_home_dir_t sysadm_home_dir_t}:dir { read getattr search };
+allow logrotate_t {staff_home_dir_t sysadm_home_dir_t}:dir { getattr search };
+dontaudit logrotate_t {staff_home_dir_t sysadm_home_dir_t}:dir { read };
 
 # create lock files
 rw_dir_create_file(logrotate_t, var_lock_t)
@@ -140,10 +141,5 @@
 
 domain_auto_trans(logrotate_t, initrc_exec_t, initrc_t)
 
-r_dir_file(logrotate_t, selinux_config_t)
+dontaudit logrotate_t selinux_config_t:dir search;
 
-#from " logrotate -f /etc/logrotate.conf" while root(sysadm_r)
-allow logrotate_t devpts_t:dir { search };
-allow logrotate_t initrc_t:process { transition };
-dontaudit logrotate_t {sysadm_home_dir_t staff_home_dir_t}:dir { read search };
-allow logrotate_t var_t:file { getattr  read }; 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/setfiles.te policy-1.17.9/domains/program/setfiles.te
--- nsapolicy/domains/program/setfiles.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.9/domains/program/setfiles.te	2004-09-02 08:15:02.736588699 -0400
@@ -40,8 +44,7 @@
 allow setfiles_t { file_type unlabeled_t device_type }:dir_file_class_set { getattr relabelfrom };
 allow setfiles_t file_type:{ dir file lnk_file sock_file fifo_file } relabelto;
 allow setfiles_t unlabeled_t:dir read;
-allow setfiles_t device_type:{ chr_file blk_file } relabelto;
-allow setfiles_t device_t:{ chr_file blk_file } { getattr relabelfrom read };
+allow setfiles_t { device_type device_t }:{ chr_file blk_file } { getattr relabelfrom relabelto };
 allow setfiles_t { ttyfile ptyfile }:chr_file getattr;
 
 allow setfiles_t fs_t:filesystem getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.17.9/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2004-08-30 09:49:15.000000000 -0400
+++ policy-1.17.9/domains/program/unused/apache.te	2004-09-02 08:15:02.737588587 -0400
@@ -41,6 +41,7 @@
 append_logdir_domain(httpd)
 #can read /etc/httpd/logs
 allow httpd_t httpd_log_t:lnk_file { read };
+allow httpd_t httpd_log_t:dir { remove_name };
 
 # For /etc/init.d/apache2 reload
 can_tcp_connect(httpd_t, httpd_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.17.9/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2004-08-30 09:49:15.000000000 -0400
+++ policy-1.17.9/domains/program/unused/cups.te	2004-09-02 08:15:02.737588587 -0400
@@ -157,5 +157,6 @@
 allow cupsd_t ptal_var_run_t:dir { search };
 dontaudit ptal_t { sysadm_home_dir_t staff_home_dir_t }:dir { getattr search };
 
+allow cupsd_t printer_device_t:fifo_file rw_file_perms;
 dontaudit cupsd_t selinux_config_t:dir search;
 dontaudit cupsd_t selinux_config_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dovecot.te policy-1.17.9/domains/program/unused/dovecot.te
--- nsapolicy/domains/program/unused/dovecot.te	2004-09-01 14:00:02.000000000 -0400
+++ policy-1.17.9/domains/program/unused/dovecot.te	2004-09-02 08:15:02.738588475 -0400
@@ -11,7 +11,7 @@
 
 type dovecot_cert_t, file_type, sysadmfile;
 
-allow dovecot_t self:capability { dac_override dac_read_search chown net_bind_service setgid setuid sys_chroot };
+allow dovecot_t self:capability { chown net_bind_service setgid setuid sys_chroot dac_override dac_read_search };
 allow dovecot_t self:process { setrlimit };
 can_network(dovecot_t)
 can_ypbind(dovecot_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ipsec.te policy-1.17.9/domains/program/unused/ipsec.te
--- nsapolicy/domains/program/unused/ipsec.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.9/domains/program/unused/ipsec.te	2004-09-02 08:15:02.739588362 -0400
@@ -127,7 +127,7 @@
 ########## The following rules were added by cvance@tislabs.com ##########
 
 # allow pluto and startup scripts to access /dev/urandom
-allow { ipsec_t ipsec_mgmt_t } random_device_t:chr_file r_file_perms;
+allow { ipsec_t ipsec_mgmt_t } { urandom_device_t random_device_t }:chr_file r_file_perms;
 
 # allow pluto to access /proc/net/ipsec_eroute;
 general_proc_read_access(ipsec_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/named.te policy-1.17.9/domains/program/unused/named.te
--- nsapolicy/domains/program/unused/named.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.9/domains/program/unused/named.te	2004-09-02 08:15:02.739588362 -0400
@@ -113,7 +113,6 @@
 allow ndc_t self:unix_stream_socket create_stream_socket_perms;
 allow ndc_t self:unix_stream_socket connect;
 allow ndc_t self:capability { dac_override net_admin };
-allow ndc_t var_t:dir search;
 allow ndc_t var_run_t:dir search;
 allow ndc_t named_var_run_t:sock_file rw_file_perms;
 allow ndc_t named_t:unix_stream_socket connectto;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rhgb.te policy-1.17.9/domains/program/unused/rhgb.te
--- nsapolicy/domains/program/unused/rhgb.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.9/domains/program/unused/rhgb.te	2004-09-02 08:15:02.740588250 -0400
@@ -33,11 +33,6 @@
 allow insmod_t ramfs_t:file write;
 allow insmod_t rhgb_t:fd use;
 
-allow rhgb_t ramfs_t:filesystem { mount unmount };
-allow rhgb_t root_t:dir { mounton };
-allow rhgb_t rhgb_t:capability { sys_admin };
-dontaudit rhgb_t var_run_t:dir { search };
-
 can_network(rhgb_t)
 can_ypbind(rhgb_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpm.te policy-1.17.9/domains/program/unused/rpm.te
--- nsapolicy/domains/program/unused/rpm.te	2004-09-01 14:00:02.000000000 -0400
+++ policy-1.17.9/domains/program/unused/rpm.te	2004-09-02 08:15:02.740588250 -0400
@@ -19,10 +19,6 @@
 system_crond_entry(rpm_exec_t, rpm_t)
 role sysadm_r types rpm_t;
 domain_auto_trans(sysadm_t, rpm_exec_t, rpm_t)
-ifdef(`unlimitedUsers', `
-role staff_r types rpm_t;
-domain_auto_trans(staff_t, rpm_exec_t, rpm_t)
-')
 
 type rpm_file_t, file_type, sysadmfile;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/spamassassin.te policy-1.17.9/domains/program/unused/spamassassin.te
--- nsapolicy/domains/program/unused/spamassassin.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.9/domains/program/unused/spamassassin.te	2004-09-02 08:15:02.741588138 -0400
@@ -6,4 +6,6 @@
 
 type spamassassin_exec_t, file_type, sysadmfile, exec_type;
 
+bool spamassasin_can_network false;
+
 # Everything else is in spamassassin_macros.te.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.17.9/domains/program/unused/udev.te
--- nsapolicy/domains/program/unused/udev.te	2004-09-01 14:00:02.000000000 -0400
+++ policy-1.17.9/domains/program/unused/udev.te	2004-09-02 08:15:02.742588026 -0400
@@ -43,7 +43,8 @@
 allow udev_t { device_t device_type }:{chr_file blk_file} { relabelfrom relabelto create_file_perms };
 	
 # to read the file_contexts file
-r_dir_file(udev_t, { selinux_config_t file_context_t default_context_t } )
+allow udev_t { selinux_config_t default_context_t }:dir search;
+allow udev_t file_context_t:file { getattr read };
 
 allow udev_t policy_config_t:dir { search };
 allow udev_t proc_t:file { read };
@@ -82,11 +83,6 @@
 ifdef(`consoletype.te', `
 can_exec(udev_t, consoletype_exec_t)
 ')
-ifdef(`pamconsole.te', `
-allow udev_t pam_var_console_t:dir search;
-')
-allow udev_t var_lock_t:dir search;
-allow udev_t var_lock_t:file getattr;
 domain_auto_trans(udev_t, ifconfig_exec_t, ifconfig_t)
 ifdef(`hide_broken_symptoms', `
 dontaudit ifconfig_t udev_t:unix_dgram_socket { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/ipsec.fc policy-1.17.9/file_contexts/program/ipsec.fc
--- nsapolicy/file_contexts/program/ipsec.fc	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.9/file_contexts/program/ipsec.fc	2004-09-02 08:15:02.743587913 -0400
@@ -5,12 +5,16 @@
 /etc/ipsec\.d(/.*)?		system_u:object_r:ipsec_key_file_t
 /usr/lib(64)?/ipsec/.*	--	system_u:object_r:ipsec_mgmt_exec_t
 /usr/local/lib(64)?/ipsec/.*	--	system_u:object_r:ipsec_mgmt_exec_t
+/usr/libexec/ipsec/eroute	--	system_u:object_r:ipsec_exec_t
 /usr/lib(64)?/ipsec/eroute	--	system_u:object_r:ipsec_exec_t
 /usr/local/lib(64)?/ipsec/eroute --	system_u:object_r:ipsec_exec_t
+/usr/libexec/ipsec/klipsdebug	--	system_u:object_r:ipsec_exec_t
 /usr/lib(64)?/ipsec/klipsdebug --	system_u:object_r:ipsec_exec_t
 /usr/local/lib(64)?/ipsec/klipsdebug -- system_u:object_r:ipsec_exec_t
+/usr/libexec/ipsec/pluto	--	system_u:object_r:ipsec_exec_t
 /usr/lib(64)?/ipsec/pluto	--	system_u:object_r:ipsec_exec_t
 /usr/local/lib(64)?/ipsec/pluto --	system_u:object_r:ipsec_exec_t
+/usr/libexec/ipsec/spi	--	system_u:object_r:ipsec_exec_t
 /usr/lib(64)?/ipsec/spi	--	system_u:object_r:ipsec_exec_t
 /usr/local/lib(64)?/ipsec/spi --	system_u:object_r:ipsec_exec_t
 /usr/sbin/ipsec		--	system_u:object_r:ipsec_mgmt_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/fs_use policy-1.17.9/fs_use
--- nsapolicy/fs_use	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.9/fs_use	2004-09-02 08:15:02.743587913 -0400
@@ -8,6 +8,7 @@
 fs_use_xattr ext3 system_u:object_r:fs_t;
 fs_use_xattr xfs system_u:object_r:fs_t;
 fs_use_xattr reiserfs system_u:object_r:fs_t;
+fs_use_xattr tmpfs system_u:object_r:fs_t;
 
 # Use the allocating task SID to label inodes in the following filesystem
 # types, and label the filesystem itself with the specified context.
@@ -23,7 +24,6 @@
 # This is appropriate for pseudo filesystems like devpts and tmpfs
 # where we want to label objects with a derived type.
 fs_use_trans devpts system_u:object_r:devpts_t;
-fs_use_trans tmpfs system_u:object_r:tmpfs_t;
 fs_use_trans shm system_u:object_r:tmpfs_t;
 
 # The separate genfs_contexts configuration can be used for filesystem 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/admin_macros.te policy-1.17.9/macros/admin_macros.te
--- nsapolicy/macros/admin_macros.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.9/macros/admin_macros.te	2004-09-02 08:15:02.744587801 -0400
@@ -73,7 +73,8 @@
 can_sysctl($1_t)
 
 # Create and use all files that have the sysadmfile attribute.
-allow $1_t sysadmfile:notdevfile_class_set create_file_perms;
+allow $1_t sysadmfile:{ file sock_file fifo_file } create_file_perms;
+allow $1_t sysadmfile:lnk_file create_lnk_perms;
 allow $1_t sysadmfile:dir create_dir_perms;
 
 # Set an exec context, e.g. for runcon.
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.17.9/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2004-08-30 09:49:16.000000000 -0400
+++ policy-1.17.9/macros/base_user_macros.te	2004-09-02 08:15:02.745587689 -0400
@@ -223,6 +223,11 @@
 dontaudit $1_t domain:notdevfile_class_set r_file_perms;
 dontaudit $1_t domain:process { getattr getsession };
 
+ifdef(`xserver.te', `
+# for /tmp/.ICE-unix
+file_type_auto_trans($1_t, xdm_xserver_tmp_t, $1_tmp_t, sock_file)
+')
+
 ifdef(`xdm.te', `
 # Connect to the X server run by the X Display Manager.
 can_unix_connect($1_t, xdm_t)
@@ -287,11 +292,6 @@
 allow $1_t default_t:notdevfile_class_set r_file_perms;
 }
 
-ifdef(`unlimitedUsers', `
-allow $1_t unlabeled_t:dir r_dir_perms;
-allow $1_t unlabeled_t:notdevfile_class_set r_file_perms;
-')
-
 allow $1_t sysctl_kernel_t:dir search;
 allow $1_t sysctl_kernel_t:file { getattr read };
 allow $1_t sysctl_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/apache_macros.te policy-1.17.9/macros/program/apache_macros.te
--- nsapolicy/macros/program/apache_macros.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.9/macros/program/apache_macros.te	2004-09-02 08:15:02.746587577 -0400
@@ -21,6 +21,9 @@
 #This type is for webpages
 #
 type httpd_$1_content_t, file_type, homedirfile, sysadmfile;
+ifelse($1, sys, `
+typealias httpd_sys_content_t alias httpd_sysadm_content_t;
+')
 
 # This type is used for .htaccess files
 #
@@ -43,11 +46,13 @@
 uses_shlib(httpd_$1_script_t)
 can_network(httpd_$1_script_t)
 can_ypbind(httpd_$1_script_t)
-allow httpd_$1_script_t { usr_t lib_t }:file { getattr read };
+allow httpd_$1_script_t { usr_t lib_t }:file { getattr read ioctl };
+allow httpd_$1_script_t usr_t:lnk_file { getattr read };
 
 allow httpd_$1_script_t self:process { fork signal_perms };
 
 allow httpd_$1_script_t devtty_t:chr_file { getattr read write };
+allow httpd_$1_script_t urandom_device_t:chr_file { getattr read };
 allow httpd_$1_script_t etc_runtime_t:file { getattr read };
 read_locale(httpd_$1_script_t)
 allow httpd_$1_script_t fs_t:filesystem getattr;
@@ -59,7 +64,6 @@
 
 allow httpd_$1_script_t device_t:dir { getattr search };
 allow httpd_$1_script_t null_device_t:chr_file rw_file_perms;
-
 }
 
 # The following are the only areas that 
@@ -90,11 +94,8 @@
 
 allow httpd_$1_script_t { urandom_device_t random_device_t }:chr_file r_file_perms;
 
-dontaudit httpd_$1_script_t sysctl_kernel_t:dir search;
-dontaudit httpd_$1_script_t sysctl_kernel_t:file read;
-dontaudit httpd_$1_script_t sysctl_t:dir search;
-dontaudit httpd_$1_script_t var_run_t:dir search;
-allow httpd_$1_script_t var_t:dir { search };
+# for nscd
+dontaudit httpd_$1_script_t var_t:dir search;
 
 ###########################################################################
 # Allow the script interpreters to run the scripts.  So
@@ -111,7 +112,6 @@
 allow httpd_$1_script_t httpd_$1_script_exec_t:dir { search getattr };
 allow httpd_$1_script_t home_root_t:dir { getattr search };
 allow httpd_$1_script_t httpd_$1_content_t:dir { getattr search };
-allow httpd_$1_script_t httpd_$1_content_t:file r_file_perms;
 
 #############################################################################
 # Allow the scripts to read, read/write, append to the specified directories
@@ -149,7 +149,7 @@
 # Allow the user to create htaccess files
 #####################################################################
 
-allow $1_t httpd_$1_htaccess_t:{ file lnk_file } { create_file_perms relabelto relabelfrom };
+allow $1_t httpd_$1_htaccess_t:file { create_file_perms relabelto relabelfrom };
 
 #########################################################################
 # Allow user to create files or directories 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/crond_macros.te policy-1.17.9/macros/program/crond_macros.te
--- nsapolicy/macros/program/crond_macros.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.9/macros/program/crond_macros.te	2004-09-02 08:15:02.746587577 -0400
@@ -75,7 +75,7 @@
 allow $1_crond_t etc_runtime_t:file { getattr read };
 allow $1_crond_t self:process { fork signal_perms setsched };
 allow $1_crond_t proc_t:dir r_dir_perms;
-allow $1_crond_t proc_t:file { getattr read };
+allow $1_crond_t proc_t:file { getattr read ioctl };
 read_locale($1_crond_t)
 allow $1_crond_t { sysctl_t sysctl_kernel_t }:dir search;
 allow $1_crond_t sysctl_kernel_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.17.9/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.9/macros/program/mozilla_macros.te	2004-09-02 08:27:27.514998489 -0400
@@ -78,7 +78,6 @@
 #
 if (mozilla_readhome || mozilla_writehome) {
 r_dir_file($1_mozilla_t, $1_home_t)
-r_dir_file($1_mozilla_t, $1_home_dir_t)
 
 ifdef(`gpg.te', `
 dontaudit $1_mozilla_t $1_gpg_secret_t:dir { getattr };
@@ -99,15 +98,7 @@
 file_type_auto_trans($1_mozilla_t, $1_home_t, $1_mozilla_rw_t)
 allow $1_mozilla_t $1_home_t:dir setattr;
 allow $1_mozilla_t $1_home_t:{ file lnk_file } rw_file_perms;
-}
-
-#
-# Reading /usr/tmp
-#
-allow $1_mozilla_t tmp_t:lnk_file { read };
-#
-# Unlinking .fonts.cache-1
-dontaudit $1_mozilla_t $1_home_t:file { unlink };
+} 
 
 allow $1_mozilla_t $1_t:unix_stream_socket { connectto };
 allow $1_mozilla_t sysctl_net_t:dir { search };
@@ -119,7 +110,6 @@
 allow $1_mozilla_t $1_t:tcp_socket { read write };
 
 dontaudit $1_mozilla_t port_type:tcp_socket { name_bind };
-dontaudit $1_mozilla_t device_t:dir r_dir_perms;
 dontaudit $1_mozilla_t dri_device_t:chr_file rw_file_perms;
 
 ifdef(`xdm.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/slocate_macros.te policy-1.17.9/macros/program/slocate_macros.te
--- nsapolicy/macros/program/slocate_macros.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.9/macros/program/slocate_macros.te	2004-09-02 08:15:02.748587352 -0400
@@ -57,12 +57,7 @@
 
 base_file_read_access($1_locate_t)
 r_dir_file($1_locate_t, { etc_t lib_t var_t })
-ifdef(`unlimitedUsers', `
-allow $1_locate_t { root_dir_type file_type }:dir r_dir_perms;
-allow $1_locate_t { root_dir_type file_type -shadow_t}:file { getattr };
-', `
 dontaudit $1_locate_t { root_dir_type file_type }:dir r_dir_perms;
-')
 dontaudit $1_locate_t { root_dir_type file_type -shadow_t}:file { getattr read };
 ')
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/spamassassin_macros.te policy-1.17.9/macros/program/spamassassin_macros.te
--- nsapolicy/macros/program/spamassassin_macros.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.9/macros/program/spamassassin_macros.te	2004-09-02 08:15:02.748587352 -0400
@@ -88,10 +88,10 @@
 spamassassin_agent_privs($1_spamassassin_t, $1)
 
 # set tunable if you have spamassassin do DNS lookups
-ifdef(`spamassasin_can_network', `
+if (spamassasin_can_network) {
 can_network($1_spamassassin_t)
 can_ypbind($1_spamassassin_t)
-')
+}
 
 ###
 # Define the domain for /usr/bin/spamc
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_agent_macros.te policy-1.17.9/macros/program/ssh_agent_macros.te
--- nsapolicy/macros/program/ssh_agent_macros.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.9/macros/program/ssh_agent_macros.te	2004-09-02 08:15:02.749587240 -0400
@@ -86,7 +86,10 @@
 
 ifdef(`xdm.te', `
 allow $1_ssh_agent_t xdm_t:fd { use };
-allow $1_ssh_agent_t xdm_t:fifo_file { write };
+allow $1_ssh_agent_t xdm_t:fifo_file { read write };
+
+# kdm: sigchld
+allow $1_ssh_agent_t xdm_t:process sigchld;
 ')
 
 #
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_macros.te policy-1.17.9/macros/program/ssh_macros.te
--- nsapolicy/macros/program/ssh_macros.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.9/macros/program/ssh_macros.te	2004-09-02 08:22:53.013807132 -0400
@@ -89,6 +89,14 @@
 can_network($1_ssh_t)
 can_ypbind($1_ssh_t)
 
+if (user_tcp_server) {
+# for sshing to a ssh tunnel
+can_tcp_connect($1_ssh_t, $1_ssh_t)
+
+# for other connections to a ssh tunnel
+can_tcp_connect($1_t, $1_ssh_t)
+}
+
 # Use capabilities.
 allow $1_ssh_t self:capability { setuid setgid dac_override dac_read_search };
 
@@ -118,10 +126,21 @@
 # for /bin/sh used to execute xauth
 dontaudit $1_ssh_t proc_t:dir search;
 dontaudit $1_ssh_t proc_t:file { getattr read };
+can_exec($1_ssh_t, shell_exec_t)
 
 # Inherit and use descriptors from gnome-pty-helper.
 ifdef(`gnome-pty-helper.te', `allow $1_ssh_t $1_gph_t:fd use;')
 
+# Connect to sshd.
+ifdef(`inetd.te', `
+ifdef(`run_ssh_inetd', `
+can_tcp_connect($1_ssh_t, inetd_t)
+', `
+can_tcp_connect($1_ssh_t, sshd_t)
+')', `
+can_tcp_connect($1_ssh_t, sshd_t)
+')
+
 # Write to the user domain tty.
 allow $1_ssh_t $1_tty_device_t:chr_file rw_file_perms;
 allow $1_ssh_t $1_devpts_t:chr_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/su_macros.te policy-1.17.9/macros/program/su_macros.te
--- nsapolicy/macros/program/su_macros.te	2004-09-01 14:00:03.000000000 -0400
+++ policy-1.17.9/macros/program/su_macros.te	2004-09-02 08:15:02.750587128 -0400
@@ -45,7 +45,7 @@
 allow $1_su_t proc_t:lnk_file read;
 r_dir_file($1_su_t, self)
 allow $1_su_t proc_t:file read;
-allow $1_su_t self:process setsched;
+allow $1_su_t self:process { setsched setrlimit };
 allow $1_su_t device_t:dir search;
 allow $1_su_t self:process { fork sigchld };
 can_ypbind($1_su_t)
@@ -102,7 +102,6 @@
 # Relabel ttys and ptys.
 allow $1_su_t { device_t devpts_t }:dir { getattr read search };
 allow $1_su_t { ttyfile ptyfile }:chr_file { relabelfrom relabelto };
-allow $1_su_t console_device_t:chr_file { relabelfrom relabelto };
 
 # Close and re-open ttys and ptys to get the fd into the correct domain.
 allow $1_su_t { ttyfile ptyfile }:chr_file { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/userhelper_macros.te policy-1.17.9/macros/program/userhelper_macros.te
--- nsapolicy/macros/program/userhelper_macros.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.9/macros/program/userhelper_macros.te	2004-09-02 08:15:02.751587016 -0400
@@ -17,7 +17,7 @@
 ifdef(`single_userdomain', `
 typealias $1_t alias $1_userhelper_t;
 ', `
-type $1_userhelper_t, domain, userhelperdomain, privlog, privrole, privowner, auth_chkpwd, privfd, privuser;
+type $1_userhelper_t, domain, userhelperdomain, privlog, privrole, privowner, auth_chkpwd, privfd ifdef(`user_canbe_sysadm', `, privuser');
 
 in_user_role($1_userhelper_t)
 role sysadm_r types $1_userhelper_t;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/x_client_macros.te policy-1.17.9/macros/program/x_client_macros.te
--- nsapolicy/macros/program/x_client_macros.te	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.9/macros/program/x_client_macros.te	2004-09-02 08:15:02.752586903 -0400
@@ -72,7 +72,8 @@
 # allow $1_t to create dirs and files in the rw type (the auto_trans rule above
 # does it for $1_$2_t)
 allow $1_t $1_$2_rw_t:dir create_dir_perms;
-allow $1_t $1_$2_rw_t:{ file lnk_file } create_file_perms;
+allow $1_t $1_$2_rw_t:file create_file_perms;
+allow $1_t $1_$2_rw_t:lnk_file create_lnk_perms;
 
 r_dir_file($1_$2_t, $1_$2_ro_t)
 allow $1_$2_t $1_$2_ro_t:fifo_file { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/xserver_macros.te policy-1.17.9/macros/program/xserver_macros.te
--- nsapolicy/macros/program/xserver_macros.te	2004-09-02 08:03:27.267644661 -0400
+++ policy-1.17.9/macros/program/xserver_macros.te	2004-09-02 08:16:31.894582051 -0400
@@ -47,6 +47,7 @@
 ', `
 domain_auto_trans($1_t, xserver_exec_t, $1_xserver_t)
 ')dnl end ifelse xdm
+can_exec($1_xserver_t, xserver_exec_t)
 
 uses_shlib($1_xserver_t)
 can_network($1_xserver_t)
@@ -95,6 +96,8 @@
 ')dnl end ifdef userhelper
 ')dnl end ifelse xdm
 
+allow $1_xserver_t self:process setsched;
+
 allow $1_xserver_t fs_t:filesystem getattr;
 
 # Xorg wants to check if kernel is tainted
@@ -127,7 +130,9 @@
 allow $1_xserver_t mtrr_device_t:file rw_file_perms;
 allow $1_xserver_t apm_bios_t:chr_file rw_file_perms;
 allow $1_xserver_t framebuf_device_t:chr_file rw_file_perms;
+ifdef(`redhat', `
 allow $1_xserver_t device_t:lnk_file { getattr read };
+')
 allow $1_xserver_t devtty_t:chr_file rw_file_perms;
 allow $1_xserver_t devtty_t:lnk_file read;
 
@@ -205,7 +210,7 @@
 
 # Run helper programs in $1_xserver_t.
 allow $1_xserver_t { bin_t sbin_t }:dir search;
-allow $1_xserver_t etc_t:file { getattr read };
+allow $1_xserver_t etc_t:{ file lnk_file } { getattr read };
 allow $1_xserver_t bin_t:lnk_file read;
 can_exec($1_xserver_t, { bin_t shell_exec_t })
 
@@ -226,7 +231,7 @@
 ifelse($1, xdm, `
 ifdef(`xdm.te', `
 allow xdm_xserver_t xdm_t:shm rw_shm_perms;
-rw_dir_file(xdm_xserver_t, xdm_tmpfs_t)
+allow xdm_xserver_t xdm_tmpfs_t:file rw_file_perms;
 ')
 ', `
 allow $1_xserver_t $1_t:shm rw_shm_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/user_macros.te policy-1.17.9/macros/user_macros.te
--- nsapolicy/macros/user_macros.te	2004-09-01 14:00:03.000000000 -0400
+++ policy-1.17.9/macros/user_macros.te	2004-09-02 08:15:02.753586791 -0400
@@ -28,7 +28,7 @@
 allow $1_t device_t:dir { getattr };
 
 # Type for home directory.
-type $1_home_dir_t, file_type, sysadmfile, home_dir_type, home_type, user_home_dir_type, user_home_type;
+type $1_home_dir_t, file_type, sysadmfile, home_dir_type, home_type, user_home_dir_type;
 type $1_home_t, file_type, sysadmfile, home_type, user_home_type;
 
 tmp_domain($1, `, user_tmpfile')
@@ -145,9 +145,7 @@
 define(`full_user_role', `
 
 # user_t/$1_t is an unprivileged users domain.
-type $1_t, domain, userdomain, unpriv_userdomain, web_client_domain, privfd, nscd_client_domain
-ifdef(`unlimitedUsers', `,privhome, etc_writer, privmodule, privlog, privowner, admin, fs_domain, privmem, privowner, sysctl_kernel_writer, auth, auth_write')
-;
+type $1_t, domain, userdomain, unpriv_userdomain, web_client_domain, nscd_client_domain;
 
 # Grant read/search permissions to some of /proc.
 allow $1_t proc_t:dir r_dir_perms;
@@ -251,9 +249,6 @@
 #
 allow $1_home_t $1_home_t:filesystem associate;
 allow homedirfile $1_home_t:filesystem associate;
-ifdef(`unlimitedUsers', `
-unconfined_domain($1_t) 
-')
 ')
 
 undefine(`in_user_role')
diff --exclude-from=exclude -N -u -r nsapolicy/Makefile policy-1.17.9/Makefile
--- nsapolicy/Makefile	2004-09-02 08:03:26.130772258 -0400
+++ policy-1.17.9/Makefile	2004-09-02 08:15:02.754586679 -0400
@@ -147,6 +147,7 @@
 	@grep -v "^/root" $@.tmp > $@.root
 	@/usr/sbin/genhomedircon . $@.root  > $@
 	@grep "^/root" $@.tmp >> $@
+	@for i in /proc/ide/hd*/media; do grep -q cdrom $$i && echo $$i | awk -F / '{ print "/dev/"$$4"\t-b\tsystem_u:object_r:removable_device_t"}' >> $@ || true; done 
 	@-rm $@.tmp $@.root
 
 clean:
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.17.9/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.9/tunables/distro.tun	2004-09-02 08:15:02.755586567 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.17.9/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-08-27 14:44:11.000000000 -0400
+++ policy-1.17.9/tunables/tunable.tun	2004-09-02 08:15:02.755586567 -0400
@@ -5,50 +5,47 @@
 dnl define(`user_net_control')
 
 # Allow users to execute the mount command
-dnl define(`user_can_mount')
+define(`user_can_mount')
 
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
-dnl define(`unlimitedUtils')
+define(`unlimitedUtils')
 
 # Support NFS home directories
-dnl define(`nfs_home_dirs')
+define(`nfs_home_dirs')
 
 # Allow users to run games
-dnl define(`use_games')
+define(`use_games')
 
 # Allow ypbind to run with NIS
-dnl define(`allow_ypbind')
+define(`allow_ypbind')
 
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
 
 # Allow sysadm_t to do almost everything
 dnl define(`unrestricted_admin')
 
 # Allow the read/write/create on any NFS file system
-dnl define(`nfs_export_all_rw')
-
-# Allow users to unrestricted access
-dnl define(`unlimitedUsers')
+define(`nfs_export_all_rw')
 
 # Allow the reading on any NFS file system
 dnl define(`nfs_export_all_ro')
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
-dnl define(`user_canbe_sysadm')
+define(`user_canbe_sysadm')
 
 # Allow xinetd to run unconfined, including any services it starts
 # that do not have a domain transition explicitly defined.

--------------090506080401020809010209--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
