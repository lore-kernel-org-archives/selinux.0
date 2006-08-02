Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k77FDk51001644
	for <selinux@tycho.nsa.gov>; Mon, 7 Aug 2006 11:13:46 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k77FDUME023971
	for <selinux@tycho.nsa.gov>; Mon, 7 Aug 2006 15:13:30 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6) with ESMTP id k77FDZmi019495
	for <selinux@tycho.nsa.gov>; Mon, 7 Aug 2006 11:13:35 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.7/8.13.7/Submit) id k77FDZpX019494
	for selinux@tycho.nsa.gov; Mon, 7 Aug 2006 11:13:35 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k72HXUlN003522
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 13:33:30 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k72HXNeA001214
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 17:33:24 GMT
Message-ID: <44D0E1E4.1050400@redhat.com>
Date: Wed, 02 Aug 2006 13:33:24 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Latest diffs
Content-Type: multipart/mixed;
 boundary="------------060305000104020600060009"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060305000104020600060009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

mls constraints changed by evaluator

consoletype/hostname need to ignore open fds from xen.  Xen leaks them 
and uses them to communicate.  Maybe someday they will fix this.

firstboot needs to dbus chat with hal


apt runs as rpm on Red Hat platforms

userad
d and groupadd need to transition to nscd

mozilla fixes for strict policy

qemu-ifup should be bin_t

xfs now supports xattrs

Added new access to kernel:key

xen wants to getattr on devpts filesystem

Fixes for amavis

Apache should not ignore access to sysadm home dirs

avahi needs access to certs for encryption

bluetooth running on ypbind systems

Fixes for crontab in strict/mls policies

Fixes for newversion of cupsd that is SELinux aware

user dbus needs to talk to hal in strict policy

ldap has   a socket

ntp needs net_bind_service

Fixes for postfix

Samba needs to be able to create a log directory

setroubleshoot has been cleaned up to be one process.

spam wants to read postfix config

squid needs to be able to setrlimit, and sys_resource

xserver in strict policy needs additional privs

libavutil changed its name

login programs need self:key {search write }.  Should this be moved to 
auth_pgm?

Audit is being changed to use a socket.

Avahi has its own  localtime

mount wants to check if selinux in enforcing mode

semanage_t needs to be able to read files created by secadm_t

uncofined_execmem_t needs to be chating

We need to coordinat the changes to userdomain.

 





--------------060305000104020600060009
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/mls serefpolicy-2.3.4/policy/mls
--- nsaserefpolicy/policy/mls	2006-07-14 17:04:46.000000000 -0400
+++ serefpolicy-2.3.4/policy/mls	2006-08-02 11:32:53.000000000 -0400
@@ -184,19 +184,12 @@
 	 ( t2 == mlstrustedobject ));
 
 # the "single level" file "write" ops
-mlsconstrain { file lnk_file fifo_file } { write create setattr relabelfrom append unlink link rename mounton }
+mlsconstrain { file lnk_file fifo_file dir chr_file blk_file sock_file } { write create setattr relabelfrom append unlink link rename mounton }
 	(( l1 eq l2 ) or
 	 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
 	 ( t1 == mlsfilewrite ) or
 	 ( t2 == mlstrustedobject ));
 
-# the "ranged" file "write" ops
-mlsconstrain { dir chr_file blk_file sock_file } { write create setattr relabelfrom append unlink link rename mounton }
-	((( l1 dom l2 ) and ( l1 domby h2 )) or
-	 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
-	 ( t1 == mlsfilewrite ) or
-	 ( t2 == mlstrustedobject ));
-
 mlsconstrain dir { add_name remove_name reparent rmdir }
 	((( l1 dom l2 ) and ( l1 domby h2 )) or
 	 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/consoletype.te serefpolicy-2.3.4/policy/modules/admin/consoletype.te
--- nsaserefpolicy/policy/modules/admin/consoletype.te	2006-07-14 17:04:46.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/admin/consoletype.te	2006-08-02 11:32:53.000000000 -0400
@@ -8,7 +8,12 @@
 
 type consoletype_t;
 type consoletype_exec_t;
-init_domain(consoletype_t,consoletype_exec_t)
+#dont transition from initrc
+#init_domain(consoletype_t,consoletype_exec_t)
+domain_type(consoletype_t)
+domain_entry_file(consoletype_t,consoletype_exec_t)
+role system_r types consoletype_t;
+
 mls_file_read_up(consoletype_t)
 mls_file_write_down(consoletype_t)
 role system_r types consoletype_t;
@@ -114,3 +119,7 @@
 	xen_append_log(consoletype_t)
 	xen_dontaudit_rw_unix_stream_sockets(consoletype_t)
 ')
+
+optional_policy(`
+	xen_dontaudit_use_fds(consoletype_t)
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/firstboot.te serefpolicy-2.3.4/policy/modules/admin/firstboot.te
--- nsaserefpolicy/policy/modules/admin/firstboot.te	2006-08-02 10:34:09.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/admin/firstboot.te	2006-08-02 11:32:53.000000000 -0400
@@ -106,7 +106,7 @@
 ')
 
 optional_policy(`
-	hal_dbus_send(firstboot_t)
+	hal_dbus_chat(firstboot_t)
 ')
 
 optional_policy(`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/rpm.fc serefpolicy-2.3.4/policy/modules/admin/rpm.fc
--- nsaserefpolicy/policy/modules/admin/rpm.fc	2006-07-14 17:04:46.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/admin/rpm.fc	2006-08-02 11:32:53.000000000 -0400
@@ -19,6 +19,8 @@
 /usr/sbin/pup			--	gen_context(system_u:object_r:rpm_exec_t,s0)
 /usr/sbin/rhn_check		--	gen_context(system_u:object_r:rpm_exec_t,s0)
 /usr/sbin/up2date		--	gen_context(system_u:object_r:rpm_exec_t,s0)
+/usr/bin/apt-get		--	gen_context(system_u:object_r:rpm_exec_t,s0)
+/usr/bin/apt-shell		--	gen_context(system_u:object_r:rpm_exec_t,s0)
 ')
 
 /var/lib/alternatives(/.*)?		gen_context(system_u:object_r:rpm_var_lib_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/usermanage.te serefpolicy-2.3.4/policy/modules/admin/usermanage.te
--- nsaserefpolicy/policy/modules/admin/usermanage.te	2006-08-02 10:34:09.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/admin/usermanage.te	2006-08-02 11:32:53.000000000 -0400
@@ -260,7 +260,7 @@
 ')
 
 optional_policy(`
-	nscd_exec(groupadd_t)
+	nscd_domtrans(groupadd_t)
 	nscd_socket_use(groupadd_t)
 ')
 
@@ -535,7 +535,7 @@
 ')
 
 optional_policy(`
-	nscd_exec(useradd_t)
+	nscd_domtrans(useradd_t)
 	nscd_socket_use(useradd_t)
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/mozilla.if serefpolicy-2.3.4/policy/modules/apps/mozilla.if
--- nsaserefpolicy/policy/modules/apps/mozilla.if	2006-07-14 17:04:31.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/apps/mozilla.if	2006-08-02 11:32:53.000000000 -0400
@@ -63,6 +63,7 @@
 	allow $1_mozilla_t self:unix_stream_socket { listen accept };
 	# Browse the web, connect to printer
 	allow $1_mozilla_t self:tcp_socket create_socket_perms;
+	allow $1_mozilla_t self:netlink_route_socket r_netlink_socket_perms;
 
 	# for bash - old mozilla binary
 	can_exec($1_mozilla_t, mozilla_exec_t)
@@ -175,6 +176,7 @@
 	logging_send_syslog_msg($1_mozilla_t)
 
 	miscfiles_read_fonts($1_mozilla_t)
+	miscfiles_read_localization($1_mozilla_t)
 
 	# Browse the web, connect to printer
 	sysnet_dns_name_resolve($1_mozilla_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/corecommands.fc serefpolicy-2.3.4/policy/modules/kernel/corecommands.fc
--- nsaserefpolicy/policy/modules/kernel/corecommands.fc	2006-08-02 10:34:05.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/kernel/corecommands.fc	2006-08-02 11:32:53.000000000 -0400
@@ -62,6 +62,7 @@
 /etc/X11/xinit(/.*)?			gen_context(system_u:object_r:bin_t,s0)
 
 /etc/xen/scripts(/.*)?			gen_context(system_u:object_r:bin_t,s0)
+/etc/xen/qemu-ifup		--	gen_context(system_u:object_r:bin_t,s0)
 
 ifdef(`distro_debian',`
 /etc/mysql/debian-start		--	gen_context(system_u:object_r:bin_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/corenetwork.te.in serefpolicy-2.3.4/policy/modules/kernel/corenetwork.te.in
--- nsaserefpolicy/policy/modules/kernel/corenetwork.te.in	2006-08-02 10:34:05.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/kernel/corenetwork.te.in	2006-08-02 11:32:53.000000000 -0400
@@ -73,6 +73,7 @@
 network_port(dhcpc, udp,68,s0)
 network_port(dhcpd, udp,67,s0, tcp,647,s0, udp,647,s0, tcp,847,s0, udp,847,s0)
 network_port(dict, tcp,2628,s0)
+network_port(setroubleshoot, tcp,3267,s0)
 network_port(distccd, tcp,3632,s0)
 network_port(dns, udp,53,s0, tcp,53,s0)
 network_port(fingerd, tcp,79,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/filesystem.te serefpolicy-2.3.4/policy/modules/kernel/filesystem.te
--- nsaserefpolicy/policy/modules/kernel/filesystem.te	2006-08-02 10:34:05.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/kernel/filesystem.te	2006-08-02 11:32:53.000000000 -0400
@@ -24,6 +24,7 @@
 fs_use_xattr ext2 gen_context(system_u:object_r:fs_t,s0);
 fs_use_xattr ext3 gen_context(system_u:object_r:fs_t,s0);
 fs_use_xattr gfs2 gen_context(system_u:object_r:fs_t,s0);
+fs_use_xattr gfs gen_context(system_u:object_r:fs_t,s0);
 fs_use_xattr jfs gen_context(system_u:object_r:fs_t,s0);
 fs_use_xattr xfs gen_context(system_u:object_r:fs_t,s0);
 
@@ -181,7 +182,6 @@
 genfscon hfs / gen_context(system_u:object_r:nfs_t,s0)
 genfscon hfsplus / gen_context(system_u:object_r:nfs_t,s0)
 genfscon reiserfs / gen_context(system_u:object_r:nfs_t,s0)
-genfscon gfs / gen_context(system_u:object_r:nfs_t,s0)
 
 ########################################
 #
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/kernel.if serefpolicy-2.3.4/policy/modules/kernel/kernel.if
--- nsaserefpolicy/policy/modules/kernel/kernel.if	2006-07-14 17:04:30.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/kernel/kernel.if	2006-08-02 11:32:53.000000000 -0400
@@ -1456,6 +1456,42 @@
 
 ########################################
 ## <summary>
+##	Allow search the kernel key ring.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`kernel_search_key',`
+	gen_require(`
+		type kernel_t;
+	')
+
+	allow $1 kernel_t:key search;
+')
+
+########################################
+## <summary>
+##	Allow link to the kernel key ring.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`kernel_link_key',`
+	gen_require(`
+		type kernel_t;
+	')
+
+	allow $1 kernel_t:key link;
+')
+
+########################################
+## <summary>
 ##	Read filesystem sysctls.
 ## </summary>
 ## <param name="domain">
@@ -2099,3 +2135,42 @@
 
 	typeattribute $1 kern_unconfined;
 ')
+
+########################################
+## <summary>
+##	Do not audit attempts to list sysctl_type directories.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`kernel_dontaudit_list_sysctls',`
+	gen_require(`
+		attribute sysctl_type;
+	')
+
+	dontaudit $1 sysctl_type:dir list_dir_perms;
+')
+
+
+########################################
+## <summary>
+##	Do not audit attempts to list proc_type file/directories.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`kernel_dontaudit_list_all_proc',`
+	gen_require(`
+		attribute proc_type;
+	')
+
+	dontaudit $1 proc_type:dir list_dir_perms;
+	dontaudit $1 proc_type:file getattr;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/terminal.if serefpolicy-2.3.4/policy/modules/kernel/terminal.if
--- nsaserefpolicy/policy/modules/kernel/terminal.if	2006-08-02 10:34:05.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/kernel/terminal.if	2006-08-02 11:32:53.000000000 -0400
@@ -308,6 +308,7 @@
 		type devpts_t;
 	')
 
+	dev_dontaudit_list_all_dev_nodes($1)
 	dontaudit $1 devpts_t:dir search;
 ')
 
@@ -948,3 +949,21 @@
 	dontaudit $1 ttynode:chr_file { read write };
 ')
 
+########################################
+## <summary>
+##	Get the attributes of a pty filesystem
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`term_getattr_ptys_fs',`
+	gen_require(`
+		type devpts_t;
+	')
+
+	allow $1 devpts_t:filesystem getattr;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/amavis.te serefpolicy-2.3.4/policy/modules/services/amavis.te
--- nsaserefpolicy/policy/modules/services/amavis.te	2006-07-14 17:04:40.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/services/amavis.te	2006-08-02 11:32:53.000000000 -0400
@@ -62,10 +62,12 @@
 allow amavis_t amavis_quarantine_t:dir create_dir_perms;
 
 # Spool Files
+files_search_spool(amavis_t)
 allow amavis_t amavis_spool_t:dir manage_dir_perms;
 allow amavis_t amavis_spool_t:file manage_file_perms;
 allow amavis_t amavis_spool_t:sock_file manage_file_perms;
 files_spool_filetrans(amavis_t,amavis_spool_t,{ dir file })
+type_transition amavis_t amavis_spool_t:sock_file amavis_var_run_t;
 
 # tmp files
 allow amavis_t amavis_tmp_t:file create_file_perms;
@@ -116,6 +118,7 @@
 # bind to incoming port
 corenet_tcp_bind_amavisd_recv_port(amavis_t)
 corenet_udp_bind_generic_port(amavis_t)
+corenet_tcp_connect_razor_port(amavis_t)
 
 dev_read_rand(amavis_t)
 dev_read_urand(amavis_t)
@@ -180,3 +183,7 @@
 	spamassassin_exec(amavis_t)
 	spamassassin_exec_client(amavis_t)
 ')
+
+optional_policy(`
+	postfix_read_config(amavis_t)
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/apache.te serefpolicy-2.3.4/policy/modules/services/apache.te
--- nsaserefpolicy/policy/modules/services/apache.te	2006-07-14 17:04:41.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/services/apache.te	2006-08-02 11:32:53.000000000 -0400
@@ -273,7 +273,6 @@
 sysnet_read_config(httpd_t)
 
 userdom_use_unpriv_users_fds(httpd_t)
-userdom_dontaudit_search_sysadm_home_dirs(httpd_t)
 
 mta_send_mail(httpd_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/avahi.te serefpolicy-2.3.4/policy/modules/services/avahi.te
--- nsaserefpolicy/policy/modules/services/avahi.te	2006-08-02 10:34:07.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/services/avahi.te	2006-08-02 11:32:54.000000000 -0400
@@ -79,6 +79,7 @@
 
 sysnet_read_config(avahi_t)
 sysnet_use_ldap(avahi_t)
+miscfiles_read_certs(avahi_t)
 
 userdom_dontaudit_use_unpriv_user_fds(avahi_t)
 userdom_dontaudit_search_sysadm_home_dirs(avahi_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/bluetooth.te serefpolicy-2.3.4/policy/modules/services/bluetooth.te
--- nsaserefpolicy/policy/modules/services/bluetooth.te	2006-08-02 10:34:07.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/services/bluetooth.te	2006-08-02 11:32:54.000000000 -0400
@@ -247,3 +247,8 @@
 optional_policy(`
        	xserver_stream_connect_xdm(bluetooth_helper_t)
 ')	
+
+optional_policy(`
+	nis_use_ypbind(bluetooth_helper_t)
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/clamav.if serefpolicy-2.3.4/policy/modules/services/clamav.if
--- nsaserefpolicy/policy/modules/services/clamav.if	2006-08-02 10:34:07.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/services/clamav.if	2006-08-02 13:15:45.000000000 -0400
@@ -102,3 +102,4 @@
 	allow clamscan_t $1:fifo_file rw_file_perms;
 	allow clamscan_t $1:process sigchld;
 ')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cron.if serefpolicy-2.3.4/policy/modules/services/cron.if
--- nsaserefpolicy/policy/modules/services/cron.if	2006-07-14 17:04:41.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/services/cron.if	2006-08-02 11:32:54.000000000 -0400
@@ -181,6 +181,7 @@
 	allow $1_crontab_t $2:fd use;
 	allow $1_crontab_t $2:fifo_file rw_file_perms;
 	allow $1_crontab_t $2:process sigchld;
+	allow $2 $1_crontab_t:process sigchld;
 
 	# crontab shows up in user ps
 	allow $2 $1_crontab_t:dir { search getattr read };
@@ -194,14 +195,19 @@
 	# Allow crond to read those crontabs in cron spool.
 	allow crond_t $1_cron_spool_t:file create_file_perms;
 
+	allow $1_crontab_t tmp_t:dir rw_dir_perms;
+	allow $1_crontab_t $1_tmp_t:file create_file_perms;
+	type_transition $1_crontab_t tmp_t:file $1_tmp_t;
+
 	# dac_override is to create the file in the directory under /tmp
-	allow $1_crontab_t self:capability { setuid setgid chown dac_override };
+	allow $1_crontab_t self:capability { fowner setuid setgid chown dac_override };
 	allow $1_crontab_t self:process signal_perms;
 
 	# create files in /var/spool/cron
-	allow $1_crontab_t $1_cron_spool_t:file create_file_perms;
+	files_search_spool($1_crontab_t)
 	allow $1_crontab_t cron_spool_t:dir rw_dir_perms;
-	type_transition $1_crontab_t $1_cron_spool_t:file $1_cron_spool_t;
+	allow $1_crontab_t $1_cron_spool_t:file create_file_perms;
+	type_transition $1_crontab_t cron_spool_t:file $1_cron_spool_t;
 
 	# crontab signals crond by updating the mtime on the spooldir
 	allow $1_crontab_t cron_spool_t:dir setattr;
@@ -239,6 +245,10 @@
 	# Read user crontabs
 	userdom_read_user_home_content_files($1,$1_crontab_t)
 
+	optional_policy(`
+		nscd_socket_use($1_crontab_t)
+	')
+
 	tunable_policy(`fcron_crond', `
 		# fcron wants an instant update of a crontab change for the administrator
 		# also crontab does a security check for crontab -u
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cups.te serefpolicy-2.3.4/policy/modules/services/cups.te
--- nsaserefpolicy/policy/modules/services/cups.te	2006-07-14 17:04:41.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/services/cups.te	2006-08-02 11:32:54.000000000 -0400
@@ -81,6 +81,7 @@
 allow cupsd_t self:unix_stream_socket { create_stream_socket_perms connectto };
 allow cupsd_t self:unix_dgram_socket create_socket_perms;
 allow cupsd_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
+allow cupsd_t self:netlink_selinux_socket create_socket_perms;
 allow cupsd_t self:netlink_route_socket r_netlink_socket_perms;
 allow cupsd_t self:tcp_socket { create_stream_socket_perms connectto acceptfrom recvfrom };
 allow cupsd_t self:udp_socket create_socket_perms;
@@ -153,6 +154,8 @@
 dev_read_sysfs(cupsd_t)
 dev_read_usbfs(cupsd_t)
 
+domain_read_all_domains_state(cupsd_t)
+
 fs_getattr_all_fs(cupsd_t)
 fs_search_auto_mountpoints(cupsd_t)
 # from old usercanread attrib:
@@ -202,7 +205,8 @@
 # invoking ghostscript needs to read fonts
 miscfiles_read_fonts(cupsd_t)
 
-seutil_dontaudit_read_config(cupsd_t)
+seutil_read_config(cupsd_t)
+selinux_compute_access_vector(cupsd_t)
 
 sysnet_read_config(cupsd_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/dbus.if serefpolicy-2.3.4/policy/modules/services/dbus.if
--- nsaserefpolicy/policy/modules/services/dbus.if	2006-07-14 17:04:41.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/services/dbus.if	2006-08-02 11:32:54.000000000 -0400
@@ -171,6 +171,11 @@
 		xserver_use_xdm_fds($1_dbusd_t)
 		xserver_rw_xdm_pipes($1_dbusd_t)
 	')
+
+	optional_policy(`
+		hal_dbus_chat($1_dbusd_t)
+	')
+
 ')
 
 #######################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ldap.te serefpolicy-2.3.4/policy/modules/services/ldap.te
--- nsaserefpolicy/policy/modules/services/ldap.te	2006-08-02 10:34:07.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/services/ldap.te	2006-08-02 11:32:54.000000000 -0400
@@ -72,7 +72,7 @@
 
 allow slapd_t slapd_var_run_t:file create_file_perms;
 allow slapd_t slapd_var_run_t:dir rw_dir_perms;
-files_pid_filetrans(slapd_t,slapd_var_run_t,file)
+files_pid_filetrans(slapd_t,slapd_var_run_t,{ file socket })
 
 kernel_read_system_state(slapd_t)
 kernel_read_kernel_sysctls(slapd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/nis.te serefpolicy-2.3.4/policy/modules/services/nis.te
--- nsaserefpolicy/policy/modules/services/nis.te	2006-08-02 10:34:07.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/services/nis.te	2006-08-02 13:30:44.000000000 -0400
@@ -249,8 +249,6 @@
 allow ypserv_t self:unix_dgram_socket create_socket_perms;
 allow ypserv_t self:unix_stream_socket create_stream_socket_perms;
 allow ypserv_t self:netlink_route_socket r_netlink_socket_perms;
-allow ypserv_t self:tcp_socket connected_stream_socket_perms;
-allow ypserv_t self:udp_socket create_socket_perms;
 
 allow ypserv_t var_yp_t:dir rw_dir_perms;
 allow ypserv_t var_yp_t:file create_file_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ntp.te serefpolicy-2.3.4/policy/modules/services/ntp.te
--- nsaserefpolicy/policy/modules/services/ntp.te	2006-07-14 17:04:41.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/services/ntp.te	2006-08-02 11:32:54.000000000 -0400
@@ -32,7 +32,7 @@
 
 # sys_resource and setrlimit is for locking memory
 # ntpdate wants sys_nice
-allow ntpd_t self:capability { chown dac_override kill setgid setuid sys_time ipc_lock sys_chroot sys_nice sys_resource };
+allow ntpd_t self:capability { chown dac_override kill setgid setuid sys_time ipc_lock net_bind_service sys_chroot sys_nice sys_resource };
 dontaudit ntpd_t self:capability { net_admin sys_tty_config fsetid sys_nice };
 allow ntpd_t self:process { signal_perms setcap setsched setrlimit };
 allow ntpd_t self:fifo_file { read write getattr };
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/pegasus.if serefpolicy-2.3.4/policy/modules/services/pegasus.if
--- nsaserefpolicy/policy/modules/services/pegasus.if	2006-07-14 17:04:41.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/services/pegasus.if	2006-08-02 11:32:54.000000000 -0400
@@ -1 +1,32 @@
 ## <summary>The Open Group Pegasus CIM/WBEM Server.</summary>
+
+########################################
+## <summary>
+##	Execute a domain transition to run pegasus.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed to transition.
+##	</summary>
+## </param>
+#
+interface(`pegasus_domtrans',`
+	gen_require(`
+		type pegasus_t, pegasus_exec_t;
+	')
+
+	ifdef(`targeted_policy',`
+		if(pegasus_disable_trans) {
+			can_exec($1,pegasus_exec_t)
+		} else {
+			domain_auto_trans($1,pegasus_exec_t,pegasus_t)
+		}
+	', `
+		domain_auto_trans($1,pegasus_exec_t,pegasus_t)
+	')
+
+	allow $1 pegasus_t:fd use;
+	allow pegasus_t $1:fd use;
+	allow pegasus_t $1:fifo_file rw_file_perms;
+	allow pegasus_t $1:process sigchld;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/pegasus.te serefpolicy-2.3.4/policy/modules/services/pegasus.te
--- nsaserefpolicy/policy/modules/services/pegasus.te	2006-07-14 17:04:41.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/services/pegasus.te	2006-08-02 11:32:54.000000000 -0400
@@ -100,13 +100,12 @@
 
 auth_use_nsswitch(pegasus_t)
 auth_domtrans_chk_passwd(pegasus_t)
+auth_read_shadow(pegasus_t)
 
 domain_use_interactive_fds(pegasus_t)
 domain_read_all_domains_state(pegasus_t)
 
-files_read_etc_files(pegasus_t)
-files_list_var_lib(pegasus_t)
-files_read_var_lib_files(pegasus_t)
+files_read_all_files(pegasus_t)
 files_read_var_lib_symlinks(pegasus_t)
 
 hostname_exec(pegasus_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/postfix.te serefpolicy-2.3.4/policy/modules/services/postfix.te
--- nsaserefpolicy/policy/modules/services/postfix.te	2006-08-02 10:34:07.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/services/postfix.te	2006-08-02 11:32:54.000000000 -0400
@@ -250,6 +250,7 @@
 allow postfix_cleanup_t postfix_spool_t:lnk_file create_lnk_perms;
 
 allow postfix_cleanup_t postfix_spool_bounce_t:dir r_dir_perms;
+corecmd_exec_bin(postfix_cleanup_t)
 
 ########################################
 #
@@ -293,6 +294,10 @@
 	procmail_domtrans(postfix_local_t)
 ')
 
+optional_policy(`
+	clamav_search_lib(postfix_local_t)
+')
+
 ########################################
 #
 # Postfix map local policy
@@ -519,6 +524,7 @@
 allow postfix_qmgr_t postfix_spool_bounce_t:dir { getattr read search };
 allow postfix_qmgr_t postfix_spool_bounce_t:file { read getattr };
 allow postfix_qmgr_t postfix_spool_bounce_t:lnk_file { getattr read };
+corecmd_exec_bin(postfix_qmgr_t)
 
 ########################################
 #
@@ -589,6 +595,7 @@
 # for OpenSSL certificates
 files_read_usr_files(postfix_smtpd_t)
 mta_read_aliases(postfix_smtpd_t)
+corecmd_exec_bin(postfix_smtpd_t)
 
 optional_policy(`
 	postgrey_stream_connect(postfix_smtpd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/procmail.te serefpolicy-2.3.4/policy/modules/services/procmail.te
--- nsaserefpolicy/policy/modules/services/procmail.te	2006-08-02 10:34:07.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/services/procmail.te	2006-08-02 13:19:00.000000000 -0400
@@ -29,6 +29,7 @@
 kernel_read_kernel_sysctls(procmail_t)
 
 corenet_non_ipsec_sendrecv(procmail_t)
+corenet_udp_bind_inaddr_any_node(procmail_t)
 corenet_tcp_sendrecv_all_if(procmail_t)
 corenet_udp_sendrecv_all_if(procmail_t)
 corenet_tcp_sendrecv_all_nodes(procmail_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/samba.te serefpolicy-2.3.4/policy/modules/services/samba.te
--- nsaserefpolicy/policy/modules/services/samba.te	2006-08-02 10:34:07.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/services/samba.te	2006-08-02 11:32:54.000000000 -0400
@@ -191,7 +191,7 @@
 allow smbd_t samba_etc_t:dir rw_dir_perms;
 allow smbd_t samba_etc_t:file { rw_file_perms setattr };
 
-allow smbd_t samba_log_t:dir { ra_dir_perms setattr };
+allow smbd_t samba_log_t:dir { create ra_dir_perms setattr };
 dontaudit smbd_t samba_log_t:dir remove_name;
 allow smbd_t samba_log_t:file { create ra_file_perms };
 
@@ -367,7 +367,7 @@
 allow nmbd_t samba_etc_t:dir { search getattr };
 allow nmbd_t samba_etc_t:file { getattr read };
 
-allow nmbd_t samba_log_t:dir { ra_dir_perms setattr };
+allow nmbd_t samba_log_t:dir { create ra_dir_perms setattr };
 allow nmbd_t samba_log_t:file { create ra_file_perms };
 
 allow nmbd_t samba_var_t:dir rw_dir_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/setroubleshoot.fc serefpolicy-2.3.4/policy/modules/services/setroubleshoot.fc
--- nsaserefpolicy/policy/modules/services/setroubleshoot.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.3.4/policy/modules/services/setroubleshoot.fc	2006-08-02 11:32:54.000000000 -0400
@@ -0,0 +1,9 @@
+# setroubleshoot executables
+
+/usr/sbin/setroubleshootd		--	gen_context(system_u:object_r:setroubleshootd_exec_t,s0)
+
+/var/run/setroubleshoot(/.*)?			gen_context(system_u:object_r:setroubleshoot_var_run_t,s0)
+
+/var/log/setroubleshoot(/.*)?			gen_context(system_u:object_r:setroubleshoot_var_log_t,s0)
+
+/var/lib/setroubleshoot(/.*)?			gen_context(system_u:object_r:setroubleshoot_var_lib_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/setroubleshoot.if serefpolicy-2.3.4/policy/modules/services/setroubleshoot.if
--- nsaserefpolicy/policy/modules/services/setroubleshoot.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.3.4/policy/modules/services/setroubleshoot.if	2006-08-02 11:32:54.000000000 -0400
@@ -0,0 +1,3 @@
+## <summary>policy for setroubleshoot</summary>
+
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/setroubleshoot.te serefpolicy-2.3.4/policy/modules/services/setroubleshoot.te
--- nsaserefpolicy/policy/modules/services/setroubleshoot.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.3.4/policy/modules/services/setroubleshoot.te	2006-08-02 11:32:54.000000000 -0400
@@ -0,0 +1,101 @@
+policy_module(setroubleshoot,1.0.0)
+
+########################################
+#
+# Declarations 
+#
+
+type setroubleshootd_t;
+type setroubleshootd_exec_t;
+domain_type(setroubleshootd_t)
+init_daemon_domain(setroubleshootd_t, setroubleshootd_exec_t)
+typealias setroubleshootd_t alias setroubleshoot_t;
+
+# log files
+type setroubleshoot_var_log_t;
+logging_log_file(setroubleshoot_var_log_t)
+
+# pid files
+type setroubleshoot_var_run_t;
+files_pid_file(setroubleshoot_var_run_t)
+
+type setroubleshoot_var_lib_t;
+files_type(setroubleshoot_var_lib_t)
+
+########################################
+#
+# setroubleshootd local policy
+#
+allow setroubleshootd_t self:capability { dac_override sys_tty_config };
+allow setroubleshootd_t self:tcp_socket create_stream_socket_perms;
+allow setroubleshootd_t self:process { signal getattr };
+allow setroubleshootd_t self:fifo_file { read write };
+allow setroubleshootd_t self:unix_stream_socket { create_stream_socket_perms connectto };
+allow setroubleshootd_t self:unix_dgram_socket create_socket_perms;
+allow setroubleshootd_t self:netlink_route_socket r_netlink_socket_perms;
+
+files_dontaudit_getattr_tmp_dirs(setroubleshootd_t)
+files_dontaudit_search_home(setroubleshootd_t)
+files_read_usr_files(setroubleshootd_t)
+files_read_etc_files(setroubleshootd_t)
+
+libs_use_ld_so(setroubleshootd_t)
+libs_use_shared_libs(setroubleshootd_t)
+miscfiles_read_localization(setroubleshootd_t)
+
+logging_send_syslog_msg(setroubleshootd_t)
+
+# pid file
+files_search_pids(setroubleshootd_t)
+allow setroubleshootd_t setroubleshoot_var_run_t:file manage_file_perms;
+allow setroubleshootd_t setroubleshoot_var_run_t:sock_file manage_file_perms;
+allow setroubleshootd_t setroubleshoot_var_run_t:dir rw_dir_perms;
+files_pid_filetrans(setroubleshootd_t,setroubleshoot_var_run_t, { file sock_file })
+
+# log files
+logging_search_logs(setroubleshootd_t)
+allow setroubleshootd_t setroubleshoot_var_log_t:file create_file_perms;
+allow setroubleshootd_t setroubleshoot_var_log_t:sock_file create_file_perms;
+allow setroubleshootd_t setroubleshoot_var_log_t:dir { rw_dir_perms setattr };
+logging_log_filetrans(setroubleshootd_t,setroubleshoot_var_log_t,{ file dir })
+
+# database files
+allow setroubleshootd_t setroubleshoot_var_lib_t:file create_file_perms;
+allow setroubleshootd_t setroubleshoot_var_lib_t:dir { rw_dir_perms setattr };
+files_var_lib_filetrans(setroubleshootd_t,setroubleshoot_var_lib_t,{ file dir })
+corenet_tcp_bind_generic_node(setroubleshootd_t)
+corenet_tcp_bind_lo_node(setroubleshootd_t)
+corenet_tcp_bind_setroubleshoot_port(setroubleshootd_t)
+corenet_non_ipsec_sendrecv(setroubleshootd_t)
+corenet_tcp_sendrecv_generic_if(setroubleshootd_t)
+corenet_raw_sendrecv_generic_if(setroubleshootd_t)
+corenet_tcp_sendrecv_all_nodes(setroubleshootd_t)
+corenet_raw_sendrecv_all_nodes(setroubleshootd_t)
+corenet_tcp_sendrecv_all_ports(setroubleshootd_t)
+corenet_tcp_bind_all_nodes(setroubleshootd_t)
+corenet_tcp_connect_smtp_port(setroubleshootd_t)
+
+corecmd_exec_sbin(setroubleshootd_t)
+corecmd_exec_bin(setroubleshootd_t)
+
+dev_read_urand(setroubleshootd_t)
+
+kernel_read_kernel_sysctls(setroubleshootd_t)
+kernel_read_system_state(setroubleshootd_t)
+
+init_read_utmp(setroubleshootd_t)
+init_dontaudit_write_utmp(setroubleshootd_t)
+init_use_fds(setroubleshootd_t)
+
+sysnet_read_config(setroubleshootd_t)
+
+seutil_read_config(setroubleshootd_t)
+selinux_get_enforce_mode(setroubleshootd_t)
+
+term_dontaudit_use_console(setroubleshootd_t)
+term_dontaudit_use_generic_ptys(setroubleshootd_t)
+
+optional_policy(`
+	rpm_read_db(setroubleshootd_t)
+	rpm_dontaudit_manage_db(setroubleshootd_t)
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/spamassassin.te serefpolicy-2.3.4/policy/modules/services/spamassassin.te
--- nsaserefpolicy/policy/modules/services/spamassassin.te	2006-07-14 17:04:41.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/services/spamassassin.te	2006-08-02 11:32:54.000000000 -0400
@@ -194,3 +194,7 @@
 optional_policy(`
 	udev_read_db(spamd_t)
 ')
+
+optional_policy(`
+	postfix_read_config(spamd_t)
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/squid.te serefpolicy-2.3.4/policy/modules/services/squid.te
--- nsaserefpolicy/policy/modules/services/squid.te	2006-08-02 10:34:07.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/services/squid.te	2006-08-02 11:32:54.000000000 -0400
@@ -28,9 +28,9 @@
 # Local policy
 #
 
-allow squid_t self:capability { setgid setuid dac_override };
+allow squid_t self:capability { setgid setuid dac_override sys_resource };
 dontaudit squid_t self:capability sys_tty_config;
-allow squid_t self:process ~{ ptrace setcurrent setexec setfscreate setrlimit execmem execstack execheap };
+allow squid_t self:process ~{ ptrace setcurrent setexec setfscreate execmem execstack execheap };
 allow squid_t self:fifo_file rw_file_perms;
 allow squid_t self:sock_file r_file_perms;
 allow squid_t self:fd use;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/stunnel.te serefpolicy-2.3.4/policy/modules/services/stunnel.te
--- nsaserefpolicy/policy/modules/services/stunnel.te	2006-08-02 10:34:07.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/services/stunnel.te	2006-08-02 11:32:54.000000000 -0400
@@ -105,6 +105,10 @@
 	')
 
 	optional_policy(`
+        	mount_send_nfs_client_request(stunnel_t)
+	')
+
+	optional_policy(`
         	seutil_sigchld_newrole(stunnel_t)
 	')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xserver.if serefpolicy-2.3.4/policy/modules/services/xserver.if
--- nsaserefpolicy/policy/modules/services/xserver.if	2006-08-02 10:34:07.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/services/xserver.if	2006-08-02 11:32:54.000000000 -0400
@@ -120,7 +120,9 @@
 	dev_setattr_generic_dirs($1_xserver_t)
 	# raw memory access is needed if not using the frame buffer
 	dev_read_raw_memory($1_xserver_t)
-	dev_write_raw_memory($1_xserver_t)
+	dev_wx_raw_memory($1_xserver_t)
+	dev_rw_sysfs($1_xserver_t)
+	
 	# for other device nodes such as the NVidia binary-only driver
 	dev_rw_xserver_misc($1_xserver_t)
 	# read events - the synaptics touchpad driver reads raw events
@@ -160,6 +162,10 @@
 	sysnet_read_config($1_xserver_t)
 
 	optional_policy(`
+		apm_stream_connect($1_xserver_t)
+	')
+
+	optional_policy(`
 		auth_search_pam_console_data($1_xserver_t)
 	')
 
@@ -1125,7 +1131,47 @@
 	')
 
 	files_search_tmp($1)
-	allow $1 xdm_xserver_tmp_t:dir search_dir_perms;
+	xserver_search_xdm_xserver_tmp_dir($1)
 	allow $1 xdm_xserver_tmp_t:sock_file write;
 	allow $1 xdm_xserver_t:unix_stream_socket connectto;
 ')
+
+
+########################################
+## <summary>
+##	search xdm temporary directory
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit
+##	</summary>
+## </param>
+#
+interface(`xserver_search_xdm_xserver_tmp_dir',`
+	gen_require(`
+		type xdm_xserver_tmp_t;
+	')
+
+	allow $1 xdm_xserver_tmp_t:dir search_dir_perms;
+')
+
+########################################
+## <summary>
+##	Create a named socket in a ice
+##	temporary directory.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`xserver_create_ice_tmp_sockets',`
+	gen_require(`
+		type ice_tmp_t;
+	')
+
+	files_search_tmp($1)
+	allow $1 ice_tmp_t:dir ra_dir_perms;
+	allow $1 ice_tmp_t:sock_file create_file_perms;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xserver.te serefpolicy-2.3.4/policy/modules/services/xserver.te
--- nsaserefpolicy/policy/modules/services/xserver.te	2006-08-02 10:34:07.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/services/xserver.te	2006-08-02 11:32:54.000000000 -0400
@@ -81,7 +81,7 @@
 #
 
 allow xdm_t self:capability { setgid setuid sys_resource kill sys_tty_config mknod chown dac_override dac_read_search fowner fsetid ipc_owner sys_nice sys_rawio net_bind_service };
-allow xdm_t self:process { setexec setpgid setsched setrlimit signal_perms setkeycreate };
+allow xdm_t self:process { setexec setpgid getsched setsched setrlimit signal_perms setkeycreate };
 allow xdm_t self:fifo_file rw_file_perms;
 allow xdm_t self:shm create_shm_perms;
 allow xdm_t self:sem create_sem_perms;
@@ -89,7 +89,9 @@
 allow xdm_t self:unix_dgram_socket create_socket_perms;
 allow xdm_t self:tcp_socket create_stream_socket_perms;
 allow xdm_t self:udp_socket create_socket_perms;
-allow xdm_t self:key write;
+allow xdm_t self:socket create_socket_perms;
+allow xdm_t self:appletalk_socket create_socket_perms;
+allow xdm_t self:key { search write };
 
 # Supress permission check on .ICE-unix
 dontaudit xdm_t ice_tmp_t:dir { getattr setattr };
@@ -106,6 +108,7 @@
 
 kernel_read_system_state(xdm_t)
 kernel_read_kernel_sysctls(xdm_t)
+kernel_read_network_state(xdm_t)
 
 corecmd_exec_shell(xdm_t)
 corecmd_exec_bin(xdm_t)
@@ -154,6 +157,7 @@
 domain_dontaudit_read_all_domains_state(xdm_t)
 
 files_read_etc_files(xdm_t)
+files_read_var_files(xdm_t)
 files_read_etc_runtime_files(xdm_t)
 files_exec_etc_files(xdm_t)
 files_list_mnt(xdm_t)
@@ -257,7 +261,7 @@
 	allow xdm_t xdm_xserver_tmp_t:sock_file unlink;
 	allow xdm_t xdm_xserver_tmp_t:file unlink;
 
-	allow xdm_t xserver_log_t:dir { rw_dir_perms setattr };
+	allow xdm_t xserver_log_t:dir { create_dir_perms setattr };
 	allow xdm_t xserver_log_t:file manage_file_perms;
 	allow xdm_t xserver_log_t:fifo_file manage_file_perms;
 	logging_log_filetrans(xdm_t,xserver_log_t,file)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/hostname.te serefpolicy-2.3.4/policy/modules/system/hostname.te
--- nsaserefpolicy/policy/modules/system/hostname.te	2006-07-14 17:04:44.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/system/hostname.te	2006-08-02 11:32:54.000000000 -0400
@@ -8,7 +8,10 @@
 
 type hostname_t;
 type hostname_exec_t;
-init_system_domain(hostname_t,hostname_exec_t)
+
+#dont transition from initrc
+domain_type(hostname_t)
+domain_entry_file(hostname_t,hostname_exec_t)
 role system_r types hostname_t;
 
 ########################################
@@ -56,6 +59,7 @@
 sysnet_read_config(hostname_t)
 sysnet_dns_name_resolve(hostname_t)
 
-
-
+optional_policy(`
+	xen_dontaudit_use_fds(hostname_t)
+')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.if serefpolicy-2.3.4/policy/modules/system/init.if
--- nsaserefpolicy/policy/modules/system/init.if	2006-07-14 17:04:44.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/system/init.if	2006-08-02 11:32:54.000000000 -0400
@@ -158,13 +158,6 @@
 	allow $1 initrc_t:fifo_file rw_file_perms;
 	allow $1 initrc_t:process sigchld;
 
-	ifdef(`hide_broken_symptoms',`
-		# RHEL4 systems seem to have a stray
-		# fds open from the initrd
-		ifdef(`distro_rhel4',`
-			kernel_dontaudit_use_fds($1)
-		')
-	')
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/libraries.fc serefpolicy-2.3.4/policy/modules/system/libraries.fc
--- nsaserefpolicy/policy/modules/system/libraries.fc	2006-08-02 10:34:08.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/system/libraries.fc	2006-08-02 11:32:54.000000000 -0400
@@ -200,7 +200,7 @@
 /usr/lib(64)?/libpostproc\.so.*		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libavformat.*\.so(\.[^/]*)* --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libavcodec-.*\.so(\.[^/]*)* --	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib(64)?/libavutil-.*\.so(\.[^/]*)* --	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/libavutil.*\.so(\.[^/]*)* --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libxvidcore\.so.*		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/xine/plugins/.+\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libgsm\.so.*		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/locallogin.te serefpolicy-2.3.4/policy/modules/system/locallogin.te
--- nsaserefpolicy/policy/modules/system/locallogin.te	2006-08-02 10:34:08.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/system/locallogin.te	2006-08-02 11:32:54.000000000 -0400
@@ -47,7 +47,7 @@
 allow local_login_t self:sem create_sem_perms;
 allow local_login_t self:msgq create_msgq_perms;
 allow local_login_t self:msg { send receive };
-allow local_login_t self:key write;
+allow local_login_t self:key { search write };
 
 allow local_login_t local_login_lock_t:file create_file_perms;
 files_lock_filetrans(local_login_t,local_login_lock_t,file)
@@ -58,6 +58,8 @@
 
 kernel_read_system_state(local_login_t)
 kernel_read_kernel_sysctls(local_login_t)
+kernel_search_key(local_login_t)
+kernel_link_key(local_login_t)
 
 dev_setattr_mouse_dev(local_login_t)
 dev_getattr_mouse_dev(local_login_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/logging.fc serefpolicy-2.3.4/policy/modules/system/logging.fc
--- nsaserefpolicy/policy/modules/system/logging.fc	2006-08-02 10:34:08.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/system/logging.fc	2006-08-02 11:32:54.000000000 -0400
@@ -38,3 +38,6 @@
 /var/spool/postfix/pid	-d	gen_context(system_u:object_r:var_run_t,s0)
 
 /var/tinydns/log/main(/.*)?	gen_context(system_u:object_r:var_log_t,s0)
+
+/var/run/auditd\.pid	--	gen_context(system_u:object_r:auditd_var_run_t,s0)
+/var/run/auditd_sock	-s	gen_context(system_u:object_r:auditd_var_run_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/logging.te serefpolicy-2.3.4/policy/modules/system/logging.te
--- nsaserefpolicy/policy/modules/system/logging.te	2006-08-02 10:34:08.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/system/logging.te	2006-08-02 11:32:54.000000000 -0400
@@ -120,9 +120,10 @@
 allow auditd_t auditd_log_t:lnk_file create_lnk_perms;
 allow auditd_t var_log_t:dir search;
 
+allow auditd_t auditd_var_run_t:sock_file create_file_perms;
 allow auditd_t auditd_var_run_t:file create_file_perms;
 allow auditd_t auditd_var_run_t:dir rw_dir_perms;
-files_pid_filetrans(auditd_t,auditd_var_run_t,file)
+files_pid_filetrans(auditd_t,auditd_var_run_t,{ file sock_file })
 
 kernel_read_kernel_sysctls(auditd_t)
 # Needs to be able to run dispatcher.  see /etc/audit/auditd.conf
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/miscfiles.fc serefpolicy-2.3.4/policy/modules/system/miscfiles.fc
--- nsaserefpolicy/policy/modules/system/miscfiles.fc	2006-07-14 17:04:43.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/system/miscfiles.fc	2006-08-02 11:32:54.000000000 -0400
@@ -9,6 +9,7 @@
 # /etc
 #
 /etc/localtime		--	gen_context(system_u:object_r:locale_t,s0)
+/etc/avahi/etc/localtime --	gen_context(system_u:object_r:locale_t,s0)
 /etc/pki(/.*)?			gen_context(system_u:object_r:cert_t,s0)
 
 #
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/mount.te serefpolicy-2.3.4/policy/modules/system/mount.te
--- nsaserefpolicy/policy/modules/system/mount.te	2006-07-14 17:04:44.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/system/mount.te	2006-08-02 11:32:54.000000000 -0400
@@ -97,6 +97,8 @@
 
 sysnet_use_portmap(mount_t)
 
+selinux_get_enforce_mode(mount_t)
+
 userdom_use_all_users_fds(mount_t)
 
 ifdef(`distro_redhat',`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.te serefpolicy-2.3.4/policy/modules/system/selinuxutil.te
--- nsaserefpolicy/policy/modules/system/selinuxutil.te	2006-08-02 10:34:09.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/system/selinuxutil.te	2006-08-02 13:31:02.000000000 -0400
@@ -355,6 +355,8 @@
 kernel_relabelfrom_unlabeled_symlinks(restorecon_t)
 kernel_relabelfrom_unlabeled_pipes(restorecon_t)
 kernel_relabelfrom_unlabeled_sockets(restorecon_t)
+kernel_dontaudit_list_all_proc(restorecon_t)
+kernel_dontaudit_list_sysctls(restorecon_t)
 
 dev_relabel_all_dev_nodes(restorecon_t)
 # cjp: why is this needed?
@@ -613,6 +615,10 @@
 	userdom_read_generic_user_home_content_files(semanage_t)
 ')
 
+ifdef(`enable_mls',`
+	userdom_read_user_tmp_files(secadm, semanage_t)
+')
+
 optional_policy(`
 	nscd_socket_use(semanage_t)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.if serefpolicy-2.3.4/policy/modules/system/unconfined.if
--- nsaserefpolicy/policy/modules/system/unconfined.if	2006-08-02 10:34:09.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/system/unconfined.if	2006-08-02 11:32:54.000000000 -0400
@@ -20,6 +20,7 @@
 	# Use any Linux capability.
 	allow $1 self:capability *;
 	allow $1 self:fifo_file create_file_perms;
+	allow $1 self:key *;
 
 	# Transition to myself, to make get_ordered_context_list happy.
 	allow $1 self:process transition;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.te serefpolicy-2.3.4/policy/modules/system/unconfined.te
--- nsaserefpolicy/policy/modules/system/unconfined.te	2006-08-02 10:34:09.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/system/unconfined.te	2006-08-02 11:32:54.000000000 -0400
@@ -195,4 +195,9 @@
 ifdef(`targeted_policy',`
 	allow unconfined_execmem_t self:process { execstack execmem };
 	unconfined_domain_noaudit(unconfined_execmem_t)
+	optional_policy(`
+		init_dbus_chat_script(unconfined_execmem_t)
+		dbus_stub(unconfined_execmem_t)
+		unconfined_dbus_chat(unconfined_execmem_t)
+	')
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.if serefpolicy-2.3.4/policy/modules/system/userdomain.if
--- nsaserefpolicy/policy/modules/system/userdomain.if	2006-07-14 17:04:43.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/system/userdomain.if	2006-08-02 11:32:54.000000000 -0400
@@ -8,11 +8,10 @@
 ## <desc>
 ##	<p>
 ##	This template creates a user domain, types, and
-##	rules for the user's tty, pty, home directories,
-##	tmp, and tmpfs files.
+##	rules for the user's tty, pty, tmp, and tmpfs files.
 ##	</p>
 ##	<p>
-##	This generally should not be used, rather the
+##	This should only be used for new non login user roles, rather the
 ##	unpriv_user_template or admin_user_template should
 ##	be used.
 ##	</p>
@@ -25,7 +24,9 @@
 ## </param>
 #
 template(`base_user_template',`
-
+	gen_require(`
+		attribute userdomain, unpriv_userdomain;
+	')
 	attribute $1_file_type;
 
 	type $1_t, userdomain;
@@ -42,44 +43,17 @@
 	term_user_pty($1_t,$1_devpts_t)
 	files_type($1_devpts_t)
 
-	# type for contents of home directory
-	type $1_home_t, $1_file_type, home_type;
-	files_type($1_home_t)
-	files_associate_tmp($1_home_t)
-	fs_associate_tmpfs($1_home_t)
-
-	# type of home directory
-	type $1_home_dir_t, home_dir_type, home_type;
-	files_type($1_home_dir_t)
-	files_associate_tmp($1_home_dir_t)
-	fs_associate_tmpfs($1_home_dir_t)
-
 	type $1_tmp_t, $1_file_type;
 	files_tmp_file($1_tmp_t)
 
 	type $1_tmpfs_t;
 	files_tmpfs_file($1_tmpfs_t)
 
-	# types for network-obtained content
-	type $1_untrusted_content_t, $1_file_type, untrusted_content_type; #, customizable
-	files_type($1_untrusted_content_t)
-	files_poly_member($1_untrusted_content_t)
-
-	type $1_untrusted_content_tmp_t, $1_file_type, untrusted_content_tmp_type; # customizable
-	files_tmp_file($1_untrusted_content_tmp_t)
-
 	type $1_tty_device_t; 
 	term_tty($1_t,$1_tty_device_t)
 
 	##############################
 	#
-	# User home directory file rules
-	#
-
-	allow $1_file_type $1_home_t:filesystem associate;
-
-	##############################
-	#
 	# User domain Local policy
 	#
 
@@ -103,19 +77,6 @@
 	dontaudit $1_t self:netlink_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
 	dontaudit $1_t self:netlink_route_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown nlmsg_read nlmsg_write };
 
-	# execute files in the home directory
-	can_exec($1_t,$1_home_t)
-
-	# full control of the home directory
-	allow $1_t $1_home_t:file { create_file_perms relabelfrom relabelto entrypoint };
-	allow $1_t $1_home_t:lnk_file { create_lnk_perms relabelfrom relabelto };
-	allow $1_t $1_home_t:dir { create_dir_perms relabelfrom relabelto };
-	allow $1_t $1_home_t:sock_file { create_file_perms relabelfrom relabelto };
-	allow $1_t $1_home_t:fifo_file { create_file_perms relabelfrom relabelto };
-	allow $1_t $1_home_dir_t:dir { create_dir_perms relabelfrom relabelto };
-	type_transition $1_t $1_home_dir_t:{ dir notdevfile_class_set } $1_home_t;
-	files_search_home($1_t)
-
 	can_exec($1_t,$1_tmp_t)
 
 	# user temporary files
@@ -138,15 +99,16 @@
 	fs_tmpfs_filetrans($1_t,$1_tmpfs_t, { dir notdevfile_class_set } )
 
 	allow $1_t $1_tty_device_t:chr_file { setattr rw_file_perms };
-
-	# Allow user to relabel untrusted content
-	allow $1_t { $1_untrusted_content_t $1_untrusted_content_tmp_t }:dir { create_dir_perms relabelto relabelfrom };
-	allow $1_t { $1_untrusted_content_t $1_untrusted_content_tmp_t }:file { getattr unlink relabelto relabelfrom rename };
+	allow $1_t $1_devpts_t:chr_file { setattr rw_file_perms };
+	term_create_pty($1_t,$1_devpts_t)
 
 	allow $1_t unpriv_userdomain:fd use;
 
+	kernel_read_system_state($1_t)
+	kernel_read_network_state($1_t)
 	kernel_read_kernel_sysctls($1_t)
 	kernel_read_net_sysctls($1_t)
+	kernel_read_fs_sysctls($1_t)
 	kernel_dontaudit_list_unlabeled($1_t)
 	kernel_dontaudit_getattr_unlabeled_files($1_t)
 	kernel_dontaudit_getattr_unlabeled_symlinks($1_t)
@@ -165,8 +127,10 @@
 
 	corenet_non_ipsec_sendrecv($1_t)
 	corenet_tcp_sendrecv_all_if($1_t)
+	corenet_raw_sendrecv_all_if($1_t)
 	corenet_udp_sendrecv_all_if($1_t)
 	corenet_tcp_sendrecv_all_nodes($1_t)
+	corenet_raw_sendrecv_all_nodes($1_t)
 	corenet_udp_sendrecv_all_nodes($1_t)
 	corenet_tcp_sendrecv_all_ports($1_t)
 	corenet_udp_sendrecv_all_ports($1_t)
@@ -193,6 +157,7 @@
 	fs_getattr_all_fs($1_t)
 	fs_getattr_all_dirs($1_t)
 	fs_search_auto_mountpoints($1_t)
+	fs_list_inotifyfs($1_t)
 
 	# cjp: some of this probably can be removed
 	selinux_get_fs_mount($1_t)
@@ -234,6 +199,11 @@
 	files_dontaudit_getattr_non_security_sockets($1_t)
 	files_dontaudit_getattr_non_security_blk_files($1_t)
 	files_dontaudit_getattr_non_security_chr_files($1_t)
+	files_read_var_files($1_t)
+	files_read_etc_files($1_t)
+	files_read_etc_runtime_files($1_t)
+	files_read_usr_files($1_t)
+	files_exec_usr_files($1_t)
 
 	# Caused by su - init scripts
 	init_dontaudit_use_script_ptys($1_t)
@@ -254,16 +224,88 @@
 	seutil_read_default_contexts($1_t)
 	seutil_run_newrole($1_t,$1_r,{ $1_devpts_t $1_tty_device_t })
 
-	tunable_policy(`allow_execmem',`
-		# Allow loading DSOs that require executable stack.
-		allow $1_t self:process execmem;
-	')
+	sysnet_dns_name_resolve($1_t)
 
-	tunable_policy(`allow_execmem && allow_execstack',`
-		# Allow making the stack executable via mprotect.
-		allow $1_t self:process execstack;
+')
+#######################################
+## <summary>
+##	The template containing rules common to unprivileged
+##	users and administrative users.
+## </summary>
+## <desc>
+##	<p>
+##	This template creates a user home directories,
+##	</p>
+##	<p>
+##	This generally should not be used, rather the
+##	unpriv_user_template or admin_user_template should
+##	be used.
+##	</p>
+## </desc>
+## <param name="userdomain_prefix">
+##	<summary>
+##	The prefix of the user domain (e.g., user
+##	is the prefix for user_t).
+##	</summary>
+## </param>
+#
+template(`base_login_user_template',`
+
+	gen_require(`
+		attribute $1_file_type;
+		attribute home_dir_type, home_type;
+		attribute untrusted_content_type;
 	')
 
+	# type for contents of home directory
+	type $1_home_t, $1_file_type, home_type;
+	files_type($1_home_t)
+	files_associate_tmp($1_home_t)
+	fs_associate_tmpfs($1_home_t)
+
+	# type of home directory
+	type $1_home_dir_t, home_dir_type, home_type;
+	files_type($1_home_dir_t)
+	files_associate_tmp($1_home_dir_t)
+	fs_associate_tmpfs($1_home_dir_t)
+
+	# types for network-obtained content
+	type $1_untrusted_content_t, $1_file_type, untrusted_content_type; #, customizable
+	files_type($1_untrusted_content_t)
+	files_poly_member($1_untrusted_content_t)
+
+	type $1_untrusted_content_tmp_t, $1_file_type, untrusted_content_tmp_type; # customizable
+	files_tmp_file($1_untrusted_content_tmp_t)
+
+	##############################
+	#
+	# User home directory file rules
+	#
+
+	allow $1_file_type $1_home_t:filesystem associate;
+
+	##############################
+	#
+	# User domain Local policy
+	#
+
+	# execute files in the home directory
+	can_exec($1_t,$1_home_t)
+
+	# full control of the home directory
+	allow $1_t $1_home_t:file { create_file_perms relabelfrom relabelto entrypoint };
+	allow $1_t $1_home_t:lnk_file { create_lnk_perms relabelfrom relabelto };
+	allow $1_t $1_home_t:dir { create_dir_perms relabelfrom relabelto };
+	allow $1_t $1_home_t:sock_file { create_file_perms relabelfrom relabelto };
+	allow $1_t $1_home_t:fifo_file { create_file_perms relabelfrom relabelto };
+	allow $1_t $1_home_dir_t:dir { create_dir_perms relabelfrom relabelto };
+	type_transition $1_t $1_home_dir_t:{ dir notdevfile_class_set } $1_home_t;
+	files_search_home($1_t)
+
+	# Allow user to relabel untrusted content
+	allow $1_t { $1_untrusted_content_t $1_untrusted_content_tmp_t }:dir { create_dir_perms relabelto relabelfrom };
+	allow $1_t { $1_untrusted_content_t $1_untrusted_content_tmp_t }:file { getattr unlink relabelto relabelfrom rename };
+
 	tunable_policy(`read_default_t',`
 		files_list_default($1_t)
 		files_read_default_files($1_t)
@@ -322,6 +364,10 @@
 	')
 
 	optional_policy(`
+		alsa_read_rw_config($1_t)
+	')
+
+	optional_policy(`
 		canna_stream_connect($1_t)
 	')
 
@@ -472,6 +518,7 @@
 		xserver_read_xdm_pid($1_t)
 		# gnome-session creates socket under /tmp/.ICE-unix/
 		xserver_create_xdm_tmp_sockets($1_t)
+		xserver_create_ice_tmp_sockets($1_t)
 	')
 ')
 
@@ -501,6 +548,7 @@
 
 	# Inherit rules for ordinary users.
 	base_user_template($1)
+	base_login_user_template($1)
 
 	typeattribute $1_t unpriv_userdomain;
 	domain_interactive_fd($1_t)
@@ -521,9 +569,6 @@
 	# Local policy
 	#
 
-	allow $1_t $1_devpts_t:chr_file { setattr ioctl read getattr lock write append };
-	term_create_pty($1_t,$1_devpts_t)
-
 	# Rules used to associate a homedir as a mountpoint
 	allow $1_home_t self:filesystem associate;
 	allow $1_file_type $1_home_t:filesystem associate;
@@ -535,10 +580,6 @@
 	allow privhome $1_home_t:sock_file create_file_perms;
 	allow privhome $1_home_t:fifo_file create_file_perms;
 	type_transition privhome $1_home_dir_t:{ dir notdevfile_class_set } $1_home_t;
-
-	kernel_read_system_state($1_t)
-	kernel_read_network_state($1_t)
-
 	dev_read_sysfs($1_t)
 
 	corecmd_exec_all_executables($1_t)
@@ -546,11 +587,8 @@
 	# port access is audited even if dac would not have allowed it, so dontaudit it here
 	corenet_dontaudit_tcp_bind_all_reserved_ports($1_t)
 
-	files_read_etc_files($1_t)
-	files_read_etc_runtime_files($1_t)
+
 	files_list_home($1_t)
-	files_read_usr_files($1_t)
-	files_exec_usr_files($1_t)
 	# Read directories and files with the readable_t type.
 	# This type is a general type for "world"-readable files.
 	files_list_world_readable($1_t)
@@ -558,8 +596,6 @@
 	files_read_world_readable_symlinks($1_t)
 	files_read_world_readable_pipes($1_t)
 	files_read_world_readable_sockets($1_t)
-	# cjp: why?
-	files_read_kernel_symbol_table($1_t)
 
 	init_read_utmp($1_t)
 	# The library functions always try to open read-write first,
@@ -748,6 +784,7 @@
 
 	# Inherit rules for ordinary users.
 	base_user_template($1)
+	base_login_user_template($1)
 
 	typeattribute $1_t privhome;
 	domain_obj_id_change_exemption($1_t)
@@ -783,11 +820,6 @@
 
 	allow $1_t self:netlink_audit_socket nlmsg_readpriv;
 
-	allow $1_t $1_devpts_t:chr_file { setattr ioctl read getattr lock write append };
-	term_create_pty($1_t,$1_devpts_t)
-
-	kernel_read_system_state($1_t)
-	kernel_read_network_state($1_t)
 	kernel_read_software_raid_state($1_t)
 	kernel_getattr_core_if($1_t)
 	kernel_getattr_message_if($1_t)
@@ -855,6 +887,7 @@
 	domain_getattr_all_sockets($1_t)
 
 	files_exec_usr_src_files($1_t)
+	files_create_boot_flag($1_t)
 
 	init_rw_initctl($1_t)
 
@@ -3408,6 +3441,25 @@
 
 ########################################
 ## <summary>
+##	Do not audit attempts to append to the sysadm
+##	users home directory.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`userdom_dontaudit_append_sysadm_home_content_files',`
+	gen_require(`
+		type sysadm_home_t;
+	')
+
+	dontaudit $1 sysadm_home_t:file append;
+')
+
+########################################
+## <summary>
 ##	Read files in the staff users home directory.
 ## </summary>
 ## <param name="domain">
@@ -4128,7 +4180,7 @@
 	gen_require(`
 		type user_home_dir_t;
 	')
-
+	allow $1 user_home_dir_t:dir manage_dir_perms;
 	files_home_filetrans($1,user_home_dir_t,dir)
 ')
 
@@ -4789,3 +4841,34 @@
 	allow $1 user_home_dir_t:dir create_dir_perms;
 	files_home_filetrans($1,user_home_dir_t,dir)
 ')
+
+########################################
+## <summary>
+##	The template containing rules for changing from one role to another
+## </summary>
+## <desc>
+##	<p>
+##	This should only be used for new non login user roles, rather the
+##	unpriv_user_template or admin_user_template should
+##	be used.
+##	</p>
+## </desc>
+## <param name="userdomain_prefix">
+##	<summary>
+##	userdomain changing from 
+##	</summary>
+## </param>
+## <param name="userdomain_prefix">
+##	<summary>
+##	userdomain changing to
+##	</summary>
+## </param>
+#
+template(`role_change_template',`
+        allow $1_r $2_r;
+        type_change $2_t $1_devpts_t:chr_file $2_devpts_t;
+        type_change $2_t $1_tty_device_t:chr_file $2_tty_device_t;
+        # avoid annoying messages on terminal hangup
+        dontaudit $1_t { $2_devpts_t $2_tty_device_t }:chr_file ioctl;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.te serefpolicy-2.3.4/policy/modules/system/userdomain.te
--- nsaserefpolicy/policy/modules/system/userdomain.te	2006-07-14 17:04:43.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/system/userdomain.te	2006-08-02 11:32:54.000000000 -0400
@@ -56,14 +56,6 @@
 # Local policy
 #
 
-define(`role_change',`
-	allow $1_r $2_r;
-	type_change $2_t $1_devpts_t:chr_file $2_devpts_t;
-	type_change $2_t $1_tty_device_t:chr_file $2_tty_device_t;
-	# avoid annoying messages on terminal hangup
-	dontaudit $1_t { $2_devpts_t $2_tty_device_t }:chr_file ioctl;
-')
-
 ifdef(`targeted_policy',`
 	# Define some type aliases to help with compatibility with
 	# macros and domains from the "strict" policy.
@@ -85,7 +77,7 @@
 	# compatibility for switching from strict
 #	dominance { role secadm_r { role system_r; }}
 #	dominance { role auditadm_r { role system_r; }}
-#	dominance { role sysadm_r { role system_r; }}
+	dominance { role sysadm_r { role system_r; }}
 #	dominance { role user_r { role system_r; }}
 #	dominance { role staff_r { role system_r; }}
 
@@ -124,34 +116,34 @@
 
 	# user role change rules:
 	# sysadm_r can change to user roles
-	role_change(sysadm, user)
-	role_change(sysadm, staff)
+	role_change_template(sysadm, user)
+	role_change_template(sysadm, staff)
 
 	# only staff_r can change to sysadm_r
-	role_change(staff, sysadm)
+	role_change_template(staff, sysadm)
 
 	ifdef(`enable_mls',`
 		unpriv_user_template(secadm)
 		unpriv_user_template(auditadm)
 
-		role_change(staff,auditadm)
-		role_change(staff,secadm)
+		role_change_template(staff,auditadm)
+		role_change_template(staff,secadm)
 
-		role_change(sysadm,secadm)
-		role_change(sysadm,auditadm)
+		role_change_template(sysadm,secadm)
+		role_change_template(sysadm,auditadm)
 
-		role_change(auditadm,secadm)
-		role_change(auditadm,sysadm)
+		role_change_template(auditadm,secadm)
+		role_change_template(auditadm,sysadm)
 
-		role_change(secadm,auditadm)
-		role_change(secadm,sysadm)
+		role_change_template(secadm,auditadm)
+		role_change_template(secadm,sysadm)
 	')
 
 	# this should be tunable_policy, but
 	# currently type_change and RBAC allow
 	# do not work in conditionals
 	ifdef(`user_canbe_sysadm',`
-		role_change(user,sysadm)
+		role_change_template(user,sysadm)
 	')
 
 	allow privhome home_root_t:dir { getattr search };
@@ -172,6 +164,8 @@
 
 	mls_process_read_up(sysadm_t)
 
+	term_getattr_all_user_ttys(sysadm_t)
+
 	init_exec(sysadm_t)
 
 	ifdef(`direct_sysadm_daemon',`
@@ -210,7 +204,9 @@
 		init_exec(secadm_t)
 		logging_read_audit_log(secadm_t)
 	        logging_read_generic_logs(secadm_t)
-		userdom_dontaudit_append_staff_home_content_files(secadm_t)
+		userdom_dontaudit_append_sysadm_home_content_files(secadm_t)
+		userdom_dontaudit_read_sysadm_home_content_files(secadm_t)
+
 	', `
 		logging_manage_audit_log(sysadm_t)
 		logging_manage_audit_config(sysadm_t)
@@ -443,11 +439,11 @@
 			selinux_set_parameters(secadm_t)
 
 			seutil_manage_bin_policy(secadm_t)
-			seutil_run_checkpolicy(secadm_t,secadm_r,admin_terminal)
-			seutil_run_loadpolicy(secadm_t,secadm_r,admin_terminal)
-			seutil_run_semanage(secadm_t,secadm_r,admin_terminal)
-			seutil_run_setfiles(secadm_t,secadm_r,admin_terminal)
-			seutil_run_restorecon(secadm_t,secadm_r,admin_terminal)
+			seutil_run_checkpolicy(secadm_t,secadm_r,{ secadm_tty_device_t secadm_devpts_t })
+			seutil_run_loadpolicy(secadm_t,secadm_r,{ secadm_tty_device_t secadm_devpts_t })
+			seutil_run_semanage(secadm_t,secadm_r,{ secadm_tty_device_t secadm_devpts_t })
+			seutil_run_setfiles(secadm_t,secadm_r,{ secadm_tty_device_t secadm_devpts_t })
+			seutil_run_restorecon(secadm_t,secadm_r,{ secadm_tty_device_t secadm_devpts_t })
 		', `
 			selinux_set_enforce_mode(sysadm_t)
 			selinux_set_boolean(sysadm_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/xen.if serefpolicy-2.3.4/policy/modules/system/xen.if
--- nsaserefpolicy/policy/modules/system/xen.if	2006-07-14 17:04:43.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/system/xen.if	2006-08-02 11:32:54.000000000 -0400
@@ -127,3 +127,41 @@
 	allow xm_t $1:fifo_file rw_file_perms;
 	allow xm_t $1:process sigchld;
 ')
+
+
+########################################
+## <summary>
+##	Inherit and use xen file descriptors.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`xen_use_fds',`
+	gen_require(`
+		type xen_t;
+	')
+
+	allow $1 xen_t:fd use;
+')
+
+########################################
+## <summary>
+##	Do not audit attempts to inherit
+##	xen file descriptors.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`xen_dontaudit_use_fds',`
+	gen_require(`
+		type xen_t;
+	')
+
+	dontaudit $1 xen_t:fd use;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/xen.te serefpolicy-2.3.4/policy/modules/system/xen.te
--- nsaserefpolicy/policy/modules/system/xen.te	2006-08-02 10:34:08.000000000 -0400
+++ serefpolicy-2.3.4/policy/modules/system/xen.te	2006-08-02 11:32:54.000000000 -0400
@@ -70,6 +70,8 @@
 
 allow xend_t self:capability { dac_override ipc_lock net_admin setuid sys_nice sys_tty_config net_raw };
 allow xend_t self:process { signal sigkill };
+dontaudit xend_t self:process ptrace;
+
 # internal communication is often done using fifo and unix sockets.
 allow xend_t self:fifo_file rw_file_perms;
 allow xend_t self:unix_stream_socket create_stream_socket_perms;
@@ -130,6 +132,8 @@
 corenet_tcp_bind_soundd_port(xend_t)
 corenet_sendrecv_xen_server_packets(xend_t)
 corenet_sendrecv_soundd_server_packets(xend_t)
+corenet_tcp_bind_generic_port(xend_t)
+corenet_rw_tun_tap_dev(xend_t)
 
 dev_read_urand(xend_t)
 dev_manage_xen(xend_t)
@@ -144,13 +148,17 @@
 files_read_kernel_img(xend_t)
 files_manage_etc_runtime_files(xend_t)
 files_etc_filetrans_etc_runtime(xend_t,file)
+files_read_usr_files(xend_t)
 
 storage_raw_read_fixed_disk(xend_t)
 
 term_dontaudit_getattr_all_user_ptys(xend_t)
 term_dontaudit_use_generic_ptys(xend_t)
+term_use_ptmx(xend_t)
+term_getattr_ptys_fs(xend_t)
 
 init_use_fds(xend_t)
+init_use_script_ptys(xend_t)
 
 libs_use_ld_so(xend_t)
 libs_use_shared_libs(xend_t)
@@ -200,6 +208,7 @@
 term_use_console(xenconsoled_t)
 
 init_use_fds(xenconsoled_t)
+init_use_script_ptys(xenconsoled_t)
 
 libs_use_ld_so(xenconsoled_t)
 libs_use_shared_libs(xenconsoled_t)
@@ -238,10 +247,11 @@
 dev_filetrans_xen(xenstored_t)
 dev_rw_xen(xenstored_t)
 
-term_dontaudit_use_generic_ptys(xenstored_t)
-term_dontaudit_use_console(xenconsoled_t)
+term_use_generic_ptys(xenstored_t)
+term_use_console(xenconsoled_t)
 
 init_use_fds(xenstored_t)
+init_use_script_ptys(xenstored_t)
 
 libs_use_ld_so(xenstored_t)
 libs_use_shared_libs(xenstored_t)

--------------060305000104020600060009--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
