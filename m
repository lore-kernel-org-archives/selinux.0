Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5ECmJgA014265
	for <selinux@tycho.nsa.gov>; Tue, 14 Jun 2005 08:48:20 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5ECdZvj004522
	for <selinux@tycho.nsa.gov>; Tue, 14 Jun 2005 12:39:35 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id j5ECemRo018714
	for <selinux@tycho.nsa.gov>; Tue, 14 Jun 2005 08:40:48 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1/Submit) id j5ECemYI018713
	for selinux@tycho.nsa.gov; Tue, 14 Jun 2005 08:40:48 -0400
Subject: Content macros - request for comments
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: SELinux <SELinux@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>
Content-Type: multipart/mixed; boundary="=-KoqveQIvkYr+ftuIajNc"
Date: Tue, 14 Jun 2005 06:16:41 -0400
Message-Id: <1118744201.3416.13.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-KoqveQIvkYr+ftuIajNc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

What is your opinion of the attached patch. Ignore the
ethereal/gift/minor stuff. The focus of the patch
is content handling, specifically untrusted content.

It introduces new macros:
read_content, write_trusted, and write_untrusted.
Applications would choose between write_trusted and write_untrusted.

The goal of the patch is to unify content handling - 
allow reading from multiple sources for all apps that
are concerned with "content" and not just ROLE_t,
as well as introduce control over untrusted types.

This patch also separates out certain macros into
their own files to improve readability. Home domain
macros lose the transition, as it becomes the
responsibility of the caller. One backwards
compatibility alias in home domain is removed.

Auditing: is suppressed failing a boolean check,
since the app is working properly, but the sysadmin
has chosen to disable this functionality.

Boolean Control: certain sensitive roles such
as writing to ROLE_home_t, or reading from ROLE_home_t
can have a boolean prefix passed in to construct
a new boolean. To make this optional (I don't want
a boolean for ROLE_t, for example), I tried
to rely on constants true/false, but no such thing
seems to exist - any suggestions?

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-KoqveQIvkYr+ftuIajNc
Content-Disposition: attachment; filename=content.diff
Content-Type: text/x-patch; name=content.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naur --exclude-from=excludes policy.orig/domains/program/ethereal.te policy/domains/program/ethereal.te
--- policy.orig/domains/program/ethereal.te	2005-06-10 14:21:19.000000000 -0400
+++ policy/domains/program/ethereal.te	2005-05-31 18:16:39.000000000 -0400
@@ -8,39 +8,6 @@
 type ethereal_exec_t, file_type, exec_type, sysadmfile;
 
 ########################################################
-# ethereal_common(app_prefix) - common ethereal rules
-#
-define(`ethereal_common', `
-
-uses_shlib($1_t)
-read_locale($1_t)
-
-# Terminal output
-access_terminal($1_t, sysadm)
-
-# /proc
-read_sysctl($1_t)
-allow $1_t { self proc_t }:dir { read search getattr };
-allow $1_t { self proc_t }:{ file lnk_file } { read getattr };
-
-# Access root
-allow $1_t root_t:dir search;
-
-# Read ethereal files in /usr
-allow $1_t usr_t:file { read getattr };
-
-# /etc/nsswitch.conf
-allow $1_t etc_t:file { read getattr };
-
-# Networking privileges
-allow $1_t self:netlink_route_socket create_netlink_socket_perms;
-allow $1_t self:unix_stream_socket create_stream_socket_perms;
-allow $1_t self:udp_socket create_socket_perms;
-allow $1_t self:packet_socket create_socket_perms; 
-
-') dnl ethereal_common
-
-########################################################
 # Tethereal 
 #
 
@@ -51,23 +18,31 @@
 domain_auto_trans(sysadm_t, tethereal_exec_t, tethereal_t)
 role sysadm_r types tethereal_t;
 
-# Ethereal common
-ethereal_common(tethereal)
+uses_shlib(tethereal_t)
+read_locale(tethereal_t)
 
-########################################################
-# Ethereal (GNOME) 
-#
+# Terminal output
+access_terminal(tethereal_t, sysadm)
 
-ifdef(`gnome.te', `
+# /proc
+read_sysctl(tethereal_t)
+allow tethereal_t { self proc_t }:dir { read search getattr };
+allow tethereal_t { self proc_t }:{ file lnk_file } { read getattr };
 
-# Type for program
-type ethereal_t, domain, nscd_client_domain;
+# Access root
+allow tethereal_t root_t:dir search;
 
-# Transition from sysadm type
-domain_auto_trans(sysadm_t, ethereal_exec_t, ethereal_t)
-role sysadm_r types ethereal_t;
+# Read ethereal files in /usr
+allow tethereal_t usr_t:file { read getattr };
+
+# /etc/nsswitch.conf
+allow tethereal_t etc_t:file { read getattr };
+
+# Ethereal sysadm rules
+ethereal_networking(tethereal)
 
-# Ethereal common
-ethereal_common(ethereal)
+# FIXME: policy is incomplete
 
-') dnl gnome.te
+#####################################
+# Ethereal (GNOME) policy can be found
+# in ethereal_macros.te 
diff -Naur --exclude-from=excludes policy.orig/domains/program/gift.te policy/domains/program/gift.te
--- policy.orig/domains/program/gift.te	2005-06-10 14:21:19.000000000 -0400
+++ policy/domains/program/gift.te	2005-06-04 00:23:46.000000000 -0400
@@ -6,8 +6,5 @@
 type gift_exec_t, file_type, exec_type, sysadmfile;
 type giftd_exec_t, file_type, exec_type, sysadmfile;
 type giftd_port_t, port_type;
-type giftd_openft_port_t, port_type;
-type giftd_fasttrack_port_t, port_type;
-type giftd_gnutella_port_t, port_type;
 
 # Everything else is in macros/gift_macros.te
diff -Naur --exclude-from=excludes policy.orig/domains/program/mozilla.te policy/domains/program/mozilla.te
--- policy.orig/domains/program/mozilla.te	2005-06-10 14:21:19.000000000 -0400
+++ policy/domains/program/mozilla.te	2005-06-10 21:02:01.000000000 -0400
@@ -8,12 +8,6 @@
 type mozilla_exec_t, file_type, sysadmfile, exec_type;
 type mozilla_conf_t, file_type, sysadmfile;
 
-# Allow mozilla to read files in the user home directory
-bool mozilla_readhome false;
-
-# Allow mozilla to write files in the user home directory
-bool mozilla_writehome false;
-
 # Run in user_t
 bool disable_mozilla_trans false;
 
diff -Naur --exclude-from=excludes policy.orig/domains/user.te policy/domains/user.te
--- policy.orig/domains/user.te	2005-06-10 14:21:19.000000000 -0400
+++ policy/domains/user.te	2005-06-14 04:51:44.000000000 -0400
@@ -4,6 +4,16 @@
 
 # Booleans for user domains.
 
+# Allow applications to read untrusted content
+# If this is disallowed, Internet content has
+# to be manually relabeled for read access to be granted
+bool read_untrusted_content false;
+
+# Allow applications to write untrusted content
+# If this is disallowed, no Internet content
+# will be stored.
+bool write_untrusted_content false;
+
 # Allow users to read system messages.
 bool user_dmesg false;
 
@@ -79,9 +89,9 @@
 dontaudit $1_su_t { sysadm_home_t staff_home_t }:file create_file_perms;
 ') dnl ifdef su.te
 ifdef(`xauth.te', `
-file_type_auto_trans($1_xauth_t, sysadm_home_dir_t, sysadm_home_xauth_t,file)
+file_type_auto_trans($1_xauth_t, sysadm_home_dir_t, sysadm_xauth_home_t,file)
 ifdef(`userhelper.te', `
-file_type_auto_trans($1_userhelper_t, sysadm_home_dir_t, sysadm_home_xauth_t,file)
+file_type_auto_trans($1_userhelper_t, sysadm_home_dir_t, sysadm_xauth_home_t,file)
 ') dnl userhelper.te 
 ') dnl xauth.te 
 ') dnl reach_sysadm
diff -Naur --exclude-from=excludes policy.orig/file_contexts/program/irc.fc policy/file_contexts/program/irc.fc
--- policy.orig/file_contexts/program/irc.fc	2005-06-10 14:21:19.000000000 -0400
+++ policy/file_contexts/program/irc.fc	2005-06-14 04:52:51.000000000 -0400
@@ -2,4 +2,4 @@
 /usr/bin/[st]irc	--	system_u:object_r:irc_exec_t
 /usr/bin/ircII		--	system_u:object_r:irc_exec_t
 /usr/bin/tinyirc	--	system_u:object_r:irc_exec_t
-HOME_DIR/\.ircmotd	--	system_u:object_r:ROLE_home_irc_t
+HOME_DIR/\.ircmotd	--	system_u:object_r:ROLE_irc_home_t
diff -Naur --exclude-from=excludes policy.orig/file_contexts/program/xauth.fc policy/file_contexts/program/xauth.fc
--- policy.orig/file_contexts/program/xauth.fc	2005-06-10 14:21:19.000000000 -0400
+++ policy/file_contexts/program/xauth.fc	2005-06-10 14:57:31.000000000 -0400
@@ -1,3 +1,4 @@
 # xauth
 /usr/X11R6/bin/xauth	--	system_u:object_r:xauth_exec_t
+HOME_DIR/\.xauth.*	--	system_u:object_r:ROLE_xauth_home_t
 HOME_DIR/\.Xauthority.* --	system_u:object_r:ROLE_xauth_home_t
diff -Naur --exclude-from=excludes policy.orig/macros/admin_macros.te policy/macros/admin_macros.te
--- policy.orig/macros/admin_macros.te	2005-06-10 14:21:19.000000000 -0400
+++ policy/macros/admin_macros.te	2005-06-14 05:30:07.000000000 -0400
@@ -22,7 +22,9 @@
 # Type and access for pty devices.
 can_create_pty($1, `, admin_tty_type')
 
-tmp_domain($1, `, $1_file_type', `{ file dir lnk_file sock_file fifo_file }')
+# Transition manually for { lnk sock fifo }. The rest is in content macros.
+tmp_domain_notrans($1, `, $1_file_type')
+file_type_auto_trans($1_t, tmp_t, $1_tmp_t, { lnk_file sock_file fifo_file })
 allow $1_t $1_tmp_t:{ dir file } { relabelto relabelfrom };
 
 # Type for tty devices.
diff -Naur --exclude-from=excludes policy.orig/macros/base_user_macros.te policy/macros/base_user_macros.te
--- policy.orig/macros/base_user_macros.te	2005-06-10 14:21:19.000000000 -0400
+++ policy/macros/base_user_macros.te	2005-06-14 05:45:09.000000000 -0400
@@ -2,12 +2,6 @@
 # Macros for all user login domains.
 #
 
-define(`network_home_dir', `
-create_dir_file($1, $2)
-can_exec($1, $2)
-allow $1 $2:{ sock_file fifo_file } create_file_perms;
-')
-
 #
 # base_user_domain(domain_prefix)
 #
@@ -24,11 +18,23 @@
 
 # Type for network-obtained content
 type $1_untrusted_content_t, file_type, $1_file_type, sysadmfile, customizable;
-bool $1_access_untrusted_content false;
-if ($1_access_untrusted_content) {
-rw_dir_file($1_t, $1_untrusted_content_t) 
-}
-#allow $1_t $1_untrusted_content_t:{ dir file } { relabelto relabelfrom };
+
+# Allow user to relabel untrusted content
+allow $1_t $1_untrusted_content_t:{ dir file } { relabelto relabelfrom };
+
+# Read content
+read_content($1_t, $1, user)
+
+# Write trusted content. This includes proper transition
+# for /home, and /tmp, so no other transition is necessary (or allowed)
+write_trusted($1_t, $1, user)
+
+# Maybe the home directory is networked
+network_home($1_t)
+
+# Relabel files in the home directory 
+allow $1_t $1_home_t:{ notdevfile_class_set dir } { relabelfrom relabelto };
+can_setfscreate($1_t)
 
 allow $1_t self:capability { setgid chown fowner };
 dontaudit $1_t self:capability { sys_nice fsetid };
@@ -58,12 +64,6 @@
 allow $1_t texrel_shlib_t:file execmod;
 }
 
-# Allow user to run restorecon and relabel files
-can_getsecurity($1_t)
-allow $1_t default_context_t:file read;
-allow $1_t file_context_t:file read;
-
-
 #
 # kdeinit wants this access
 #
@@ -94,26 +94,11 @@
 # allow ptrace
 can_ptrace($1_t, $1_t)
 
-# Create, access, and remove files in home directory.
-file_type_auto_trans($1_t, $1_home_dir_t, $1_home_t)
-allow $1_t $1_home_t:{ notdevfile_class_set dir } { relabelfrom relabelto };
-can_setfscreate($1_t)
-
 # Allow user to run restorecon and relabel files
 can_getsecurity($1_t)
 r_dir_file($1_t, default_context_t)
 r_dir_file($1_t, file_context_t)
 
-allow $1_t autofs_t:dir { search getattr };
-
-if (use_nfs_home_dirs) {
-network_home_dir($1_t, nfs_t)
-}
-
-if (use_samba_home_dirs) {
-network_home_dir($1_t, cifs_t)
-}
-
 can_exec($1_t, { removable_t noexattrfile } )
 if (user_rw_noexattrfile) {
 create_dir_file($1_t, noexattrfile)
@@ -386,6 +371,10 @@
 
 r_dir_file($1_t, src_t)
 
+# Allow user to read default_t files
+# This is different from reading default_t content, 
+# because it also includes sockets, fifos, and links
+
 if (read_default_t) {
 allow $1_t default_t:dir r_dir_perms;
 allow $1_t default_t:notdevfile_class_set r_file_perms;
diff -Naur --exclude-from=excludes policy.orig/macros/content_macros.te policy/macros/content_macros.te
--- policy.orig/macros/content_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy/macros/content_macros.te	2005-06-14 05:45:39.000000000 -0400
@@ -0,0 +1,152 @@
+# Content access macros
+
+# FIXME: After nested booleans are supported, replace NFS/CIFS
+# w/ read_network_home, and write_network_home macros from global
+
+############################################################
+# read_content(domain, role_prefix, bool_prefix)
+#
+# Allow the given domain to read content.
+# Content may be trusted or untrusted,
+# Reading anything is subject to a controlling boolean based on bool_prefix.
+# Reading untrusted content is additionally subject to read_untrusted_content
+# Reading default_t is additionally subject to read_default_t
+
+define(`read_content', `
+
+ifdef(`$3_read_content_defined', `', `
+define(`$3_read_content_defined')
+ifelse($3, user, `
+bool $3_read_content true;
+', `
+bool $3_read_content false;
+') dnl ifelse
+') dnl ifdef
+
+if ($3_read_content && use_nfs_home_dirs) {
+allow $1 home_root_t:dir { search getattr };
+r_dir_file($1, nfs_t)
+} else {
+dontaudit $1 home_root_t:dir { search getattr };
+dontaudit $1 nfs_t:file r_file_perms;
+dontaudit $1 nfs_t:dir r_dir_perms;
+}
+
+if ($3_read_content && use_samba_home_dirs) {
+allow $1 home_root_t:dir { search getattr };
+r_dir_file($1, cifs_t)
+} else {
+dontaudit $1 home_root_t:dir { search getattr };
+dontaudit $1 cifs_t:file r_file_perms;
+dontaudit $1 cifs_t:dir r_dir_perms;
+}
+
+if ($3_read_content) {	
+allow $1 { autofs_t tmp_t home_root_t $2_home_dir_t }:dir { getattr search };
+r_dir_file($1, { removable_t $2_tmp_t $2_home_t } )
+} else {
+dontaudit $1 { tmp_t home_root_t $2_home_dir_t }:dir { getattr search };
+dontaudit $1 { removable_t $2_tmp_t $2_home_t }:dir r_dir_perms;
+dontaudit $1 { removable_t $2_tmp_t $2_home_t }:file r_file_perms;
+}
+
+if ($3_read_content && read_default_t) {
+r_dir_file($1, default_t)
+} else {
+dontaudit $1 default_t:file r_file_perms;
+dontaudit $1 default_t:dir r_dir_perms;
+}
+
+if ($3_read_content && read_untrusted_content) {
+allow $1 { autofs_t tmp_t home_root_t $2_home_dir_t }:dir { getattr search };
+r_dir_file($1, $2_untrusted_content_t)
+} else {
+dontaudit $1 { autofs_t tmp_t home_root_t $2_home_dir_t }:dir { getattr search };
+dontaudit $1 $2_untrusted_content_t:dir r_dir_perms;
+dontaudit $1 $2_untrusted_content_t:file r_file_perms;
+}
+')
+
+#################################################
+# write_trusted(domain, role_prefix, bool_prefix)
+#
+# Allow the given domain to write trusted content.
+# This is subject to a controlling boolean based
+# on bool_prefix.
+
+define(`write_trusted', `
+
+ifdef(`$3_write_content_defined', `', `
+define(`$3_write_content_defined')
+ifelse($3, user, `
+bool $3_write_content true;
+', `
+bool $3_write_content false;
+') dnl ifelse
+') dnl ifdef
+
+if ($3_write_content && use_nfs_home_dirs) {
+allow $1 home_root_t:dir { search getattr };
+create_dir_file($1, nfs_t)
+} else {
+dontaudit $1 home_root_t:dir { search getattr };
+dontaudit $1 nfs_t:file create_file_perms;
+dontaudit $1 nfs_t:dir create_dir_perms;
+}
+
+if ($3_write_content && use_samba_home_dirs) {
+allow $1 home_root_t:dir { search getattr };
+create_dir_file($1, nfs_t)
+} else {
+dontaudit $1 home_root_t:dir { search getattr };
+dontaudit $1 cifs_t:file create_file_perms;
+dontaudit $1 cifs_t:dir create_dir_perms;
+}
+
+if ($3_write_content) {
+allow $1 autofs_t:dir { search getattr };
+file_type_auto_trans($1, tmp_t, $2_tmp_t, { dir file } )
+file_type_auto_trans($1, $2_home_dir_t, $2_home_t, { dir file } )
+} else {
+dontaudit $1 { autofs_t tmp_t home_root_t $2_home_dir_t }:dir { getattr search };
+dontaudit $1 { $2_tmp_t $2_home_t }:dir create_dir_perms;
+dontaudit $1 { $2_tmp_t $2_home_t }:file create_file_perms;
+}
+')
+
+#########################################
+# write_untrusted(domain, role_prefix)
+#
+# Allow the given domain to write untrusted content. 
+# This is subject to the global boolean write_untrusted.
+
+define(`write_untrusted', `
+
+if (write_untrusted_content && use_nfs_home_dirs) {
+allow $1 home_root_t:dir { search getattr };
+create_dir_file($1, nfs_t)
+} else {
+dontaudit $1 home_root_t:dir { search getattr };
+dontaudit $1 nfs_t:file create_file_perms;
+dontaudit $1 nfs_t:dir create_dir_perms;
+}
+
+if (write_untrusted_content && use_samba_home_dirs) {
+allow $1 home_root_t:dir { search getattr };
+create_dir_file($1, nfs_t)
+} else {
+dontaudit $1 home_root_t:dir { search getattr };
+dontaudit $1 cifs_t:file create_file_perms;
+dontaudit $1 cifs_t:dir create_dir_perms;
+}
+
+if (write_untrusted_content) {
+allow $1 autofs_t:dir { search getattr };
+file_type_auto_trans($1, { tmp_t $2_tmp_t }, $2_untrusted_content_t, { dir file } )
+file_type_auto_trans($1, { $2_home_t $2_home_dir_t }, $2_untrusted_content_t, { dir file } )
+} else {
+dontaudit $1 { autofs_t tmp_t home_root_t $2_home_dir_t }:dir { getattr search };
+dontaudit $1 { $2_tmp_t $2_home_t }:dir create_dir_perms;
+dontaudit $1 { $2_tmp_t $2_home_t }:file create_file_perms;
+}
+')
diff -Naur --exclude-from=excludes policy.orig/macros/global_macros.te policy/macros/global_macros.te
--- policy.orig/macros/global_macros.te	2005-06-14 05:27:49.000000000 -0400
+++ policy/macros/global_macros.te	2005-06-14 05:28:39.000000000 -0400
@@ -442,6 +442,11 @@
 `file_type_auto_trans($1_t, tmp_t, $1_tmp_t, `$3')')
 ')
 
+# grant access to /tmp. Do not perform an automatic transition.
+define(`tmp_domain_notrans', `
+type $1_tmp_t, file_type, sysadmfile, polymember, tmpfile $2;
+')
+
 define(`tmpfs_domain', `
 ifdef(`$1_tmpfs_t_defined',`', `
 define(`$1_tmpfs_t_defined')
@@ -496,115 +501,6 @@
 file_type_auto_trans($1_t, var_lock_t, $1_lock_t, file)
 ')
 
-####################################################################
-# home_domain_ro_access(source, user, app) 
-# 
-# Gives source access to the read-only home
-# domain of app for the given user type
-#
-
-define(`home_domain_ro_access', `
-
-allow $1 home_root_t:dir search;
-
-if (use_nfs_home_dirs) {
-r_dir_file($1, nfs_t)
-}
-if (use_samba_home_dirs) {
-r_dir_file($1, cifs_t)
-}
-allow $1 autofs_t:dir { search getattr };
-
-r_dir_file($1, $2_$3_ro_home_t)
-
-') dnl home_domain_ro_access
-
-####################################################################
-# home_domain_access(source, user, app, trans_classes)
-#
-# Gives source full access to the home
-# domain of app for the given user type
-#
-# You can also specify the transition classes
-# By default the only trans. class in /home is dir
-
-define(`home_domain_access', `
-
-allow $1 home_root_t:dir search;
-
-if (use_nfs_home_dirs) {
-create_dir_file($1, nfs_t)
-}
-if (use_samba_home_dirs) {
-create_dir_file($1, cifs_t)
-}
-allow $1 autofs_t:dir { search getattr };
-
-create_dir_file($1, $2_$3_home_t)
-
-ifelse($4, `', `
-file_type_auto_trans($1, $2_home_dir_t, $2_$3_home_t, dir)
-', `
-file_type_auto_trans($1, $2_home_dir_t, $2_$3_home_t, $4)
-')
-
-') dnl home_domain_access
-
-####################################################################
-# home_domain (prefix, app, trans_classes)
-#
-# Creates a domain in the prefix home where an application can
-# store its settings. It is accessible by the prefix domain.
-#
-# You can also specify the transition classes
-# By default the only trans. class in /home is dir
-
-define(`home_domain', `
-
-# Declare home domain
-# FIXME: the second alias is problematic because
-# home_domain and home_domain_ro cannot be used in parallel
-# Remove the second alias when compatibility is no longer an issue
-
-type $1_$2_home_t, file_type, $1_file_type, sysadmfile;
-typealias $1_$2_home_t alias $1_$2_rw_t;
-typealias $1_$2_home_t alias $1_home_$2_t;
-
-# User side access
-create_dir_file($1_t, $1_$2_home_t)
-allow $1_t $1_$2_home_t:{ dir file lnk_file } { relabelfrom relabelto };
-
-# App side access
-home_domain_access($1_$2_t, $1, $2, $3)
-')
-
-####################################################################
-# home_domain_ro (user, app)
-#
-# Creates a read-only domain in the user home where an application can
-# store its settings. It is fully accessible by the user, but
-# it is read-only for the application.
-#
-
-define(`home_domain_ro', `
-
-# Declare home domain
-# FIXME: the second alias is problematic because
-# home_domain and home_domain_ro cannot be used in parallel
-# Remove the second alias when compatibility is no longer an issue
-
-type $1_$2_ro_home_t, file_type, $1_file_type, sysadmfile;
-typealias $1_$2_ro_home_t alias $1_$2_ro_t;
-typealias $1_$2_ro_home_t alias $1_home_$2_t;
-
-# User side access
-create_dir_file($1_t, $1_$2_ro_home_t)
-allow $1_t $1_$2_ro_home_t:{ dir file lnk_file } { relabelfrom relabelto };
-
-# App side access
-home_domain_ro_access($1_$2_t, $1, $2)
-')
-
 #######################
 # application_domain(domain_prefix)
 #
diff -Naur --exclude-from=excludes policy.orig/macros/home_macros.te policy/macros/home_macros.te
--- policy.orig/macros/home_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy/macros/home_macros.te	2005-06-14 05:06:57.000000000 -0400
@@ -0,0 +1,128 @@
+# Home macros
+
+################################################
+# network_home(source)
+#
+# Allows source domain to use a network home
+# This includes privileges of create and execute
+# as well as the ability to create sockets and fifo
+
+define(`network_home', `
+allow $1 autofs_t:dir { search getattr };
+
+if (use_nfs_home_dirs) {
+create_dir_file($1, nfs_t)
+can_exec($1, nfs_t)
+allow $1 nfs_t:{ sock_file fifo_file } create_file_perms;
+}
+
+if (use_samba_home_dirs) {
+create_dir_file($1, cifs_t)
+can_exec($1, cifs_t)
+allow $1 cifs_t:{ sock_file fifo_file } create_file_perms;
+}
+') dnl network_home
+
+################################################
+# write_network_home(source)
+#
+# Allows source domain to create directories and
+# files on network file system
+
+define(`write_network_home', `
+allow $1 home_root_t:dir search;
+
+if (use_nfs_home_dirs) {
+create_dir_file($1, nfs_t)
+}
+if (use_samba_home_dirs) {
+create_dir_file($1, cifs_t)
+}
+allow $1 autofs_t:dir { search getattr };
+') dnl write_network_home
+
+################################################
+# read_network_home(source)
+#
+# Allows source domain to read directories and
+# files on network file system
+
+define(`read_network_home', `
+allow $1 home_root_t:dir search;
+
+if (use_nfs_home_dirs) {
+r_dir_file($1, nfs_t)
+}
+if (use_samba_home_dirs) {
+r_dir_file($1, cifs_t)
+}
+allow $1 autofs_t:dir { search getattr };
+') dnl read_network_home
+
+##################################################
+# home_domain_ro_access(source, user, app)
+#
+# Gives source access to the read-only home
+# domain of app for the given user type
+
+define(`home_domain_ro_access', `
+read_network_home($1)
+r_dir_file($1, $2_$3_ro_home_t)
+') dnl home_domain_ro_access
+
+#################################################
+# home_domain_access(source, user, app)
+#
+# Gives source full access to the home
+# domain of app for the given user type
+#
+# Requires transition in caller
+
+define(`home_domain_access', `
+write_network_home($1)
+create_dir_file($1, $2_$3_home_t)
+') dnl home_domain_access
+
+####################################################################
+# home_domain (prefix, app)
+#
+# Creates a domain in the prefix home where an application can
+# store its settings. It is accessible by the prefix domain.
+#
+# Requires transition in caller
+
+define(`home_domain', `
+
+# Declare home domain
+type $1_$2_home_t, file_type, $1_file_type, sysadmfile;
+typealias $1_$2_home_t alias $1_$2_rw_t;
+
+# User side access
+create_dir_file($1_t, $1_$2_home_t)
+allow $1_t $1_$2_home_t:{ dir file lnk_file } { relabelfrom relabelto };
+
+# App side access
+home_domain_access($1_$2_t, $1, $2)
+')
+
+####################################################################
+# home_domain_ro (user, app)
+#
+# Creates a read-only domain in the user home where an application can
+# store its settings. It is fully accessible by the user, but
+# it is read-only for the application.
+#
+
+define(`home_domain_ro', `
+
+# Declare home domain
+type $1_$2_ro_home_t, file_type, $1_file_type, sysadmfile;
+typealias $1_$2_ro_home_t alias $1_$2_ro_t;
+
+# User side access
+create_dir_file($1_t, $1_$2_ro_home_t)
+allow $1_t $1_$2_ro_home_t:{ dir file lnk_file } { relabelfrom relabelto };
+
+# App side access
+home_domain_ro_access($1_$2_t, $1, $2)
+')
diff -Naur --exclude-from=excludes policy.orig/macros/program/ethereal_macros.te policy/macros/program/ethereal_macros.te
--- policy.orig/macros/program/ethereal_macros.te	2005-06-10 14:21:19.000000000 -0400
+++ policy/macros/program/ethereal_macros.te	2005-06-14 05:22:38.000000000 -0400
@@ -17,6 +17,8 @@
 allow $1_t self:unix_stream_socket create_stream_socket_perms;
 allow $1_t self:tcp_socket create_socket_perms;
 
+allow $1_t self:capability { dac_override dac_read_search net_raw setgid setuid };
+
 # Resolve names via DNS
 can_resolve($1_t)
 
@@ -35,16 +37,35 @@
 domain_auto_trans($1_t, ethereal_exec_t, $1_ethereal_t)
 role $1_r types $1_ethereal_t;
 
+# Manual transition from userhelper 
+ifdef(`userhelper.te', `
+allow $1_userhelper_t { sysadm_ethereal_t $1_ethereal_t }:process { transition siginh rlimitinh noatsecure };
+allow sysadm_ethereal_t $1_userhelper_t:fd use;
+allow sysadm_ethereal_t $1_userhelper_t:process sigchld;
+')
+
 # X, GNOME
 x_client_domain($1_ethereal, $1)
 gnome_application($1_ethereal, $1)
 gnome_file_dialog($1_ethereal, $1)
 
+# Why does it write this?
+ifdef(`snmpd.te', `
+dontaudit sysadm_ethereal_t snmpd_var_lib_t:file write;
+')
+
 # /home/.ethereal
 home_domain($1, ethereal)
+file_type_auto_trans($1_ethereal_t, $1_home_dir_t, $1_ethereal_home_t, dir)
 
 # Enable restricted networking rules for sysadm - this is shared w/ tethereal
-ifelse($1, `sysadm', `ethereal_networking($1_ethereal)', `')
+ifelse($1, `sysadm', `
+ethereal_networking($1_ethereal) 
+
+# Ethereal tries to write to user terminal
+dontaudit sysadm_ethereal_t user_tty_type:chr_file { read write };
+dontaudit sysadm_ethereal_t unpriv_userdomain:fd use;
+', `')
 
 # Store temporary files
 tmp_domain($1_ethereal)
diff -Naur --exclude-from=excludes policy.orig/macros/program/evolution_macros.te policy/macros/program/evolution_macros.te
--- policy.orig/macros/program/evolution_macros.te	2005-06-10 14:21:19.000000000 -0400
+++ policy/macros/program/evolution_macros.te	2005-06-14 05:22:44.000000000 -0400
@@ -137,7 +137,7 @@
 
 # /tmp/.exchange-$USER
 tmp_domain($1_evolution_exchange)
-  
+ 
 # Allow netstat
 allow $1_evolution_exchange_t bin_t:dir search; 
 can_exec($1_evolution_exchange_t, bin_t)
@@ -145,6 +145,9 @@
 allow $1_evolution_exchange_t sysctl_net_t:dir search;
 allow $1_evolution_exchange_t self:{ udp_socket tcp_socket } create_socket_perms;
 
+# Clock applet talks to exchange (FIXME: Needs policy)
+bonobo_connect($1, $1_evolution_exchange)
+
 # FIXME: policy incomplete
 
 ') dnl evolution_exchange
@@ -179,9 +182,6 @@
 # Access .evolution
 home_domain($1, evolution)
 
-# Store documents in /tmp (to print, etc..)
-tmp_domain($1_evolution)
-
 # Store passwords in .gnome2_private
 gnome_private_store($1_evolution, $1) 
 
diff -Naur --exclude-from=excludes policy.orig/macros/program/fontconfig_macros.te policy/macros/program/fontconfig_macros.te
--- policy.orig/macros/program/fontconfig_macros.te	2005-06-10 14:21:19.000000000 -0400
+++ policy/macros/program/fontconfig_macros.te	2005-06-14 03:10:01.000000000 -0400
@@ -18,6 +18,9 @@
 create_dir_file($1_t, $1_fonts_t)
 allow $1_t $1_fonts_t:{ dir file } { relabelto relabelfrom };
 
+create_dir_file($1_t, $1_fonts_config_t)
+allow $1_t $1_fonts_config_t:file { relabelto relabelfrom };
+
 # For startup relabel
 allow $1_t $1_fonts_cache_t:{ dir file } { relabelto relabelfrom };
 
@@ -33,7 +36,9 @@
 
 ifelse(`$2', `', `', `
 
-allow $1 $2_fonts_cache_t:file create_file_perms;
+# Manipulate the global font cache
+create_dir_file($1, $2_fonts_cache_t)
+
 # Read per user fonts and font config
 r_dir_file($1, $2_fonts_t)
 r_dir_file($1, $2_fonts_config_t)
diff -Naur --exclude-from=excludes policy.orig/macros/program/games_domain.te policy/macros/program/games_domain.te
--- policy.orig/macros/program/games_domain.te	2005-06-10 14:21:19.000000000 -0400
+++ policy/macros/program/games_domain.te	2005-06-14 05:32:19.000000000 -0400
@@ -24,7 +24,7 @@
 
 # X access, GNOME, /tmp files
 x_client_domain($1_games, $1)
-tmp_domain($1_games, `', { dir notdevfile_class_set })
+tmp_domain($1_games, `', `{ dir notdevfile_class_set }')
 gnome_application($1_games, $1)
 gnome_file_dialog($1_games, $1)
 
diff -Naur --exclude-from=excludes policy.orig/macros/program/gconf_macros.te policy/macros/program/gconf_macros.te
--- policy.orig/macros/program/gconf_macros.te	2005-06-10 14:21:19.000000000 -0400
+++ policy/macros/program/gconf_macros.te	2005-06-14 05:23:05.000000000 -0400
@@ -23,6 +23,7 @@
 
 # Access .gconfd and .gconf
 home_domain($1, gconfd)
+file_type_auto_trans($1_gconfd_t, $1_home_dir_t, $1_gconfd_home_t, dir)
 
 # Access /etc/gconf
 r_dir_file($1_gconfd_t, gconf_etc_t)
diff -Naur --exclude-from=excludes policy.orig/macros/program/gift_macros.te policy/macros/program/gift_macros.te
--- policy.orig/macros/program/gift_macros.te	2005-06-10 14:21:19.000000000 -0400
+++ policy/macros/program/gift_macros.te	2005-06-14 05:10:26.000000000 -0400
@@ -21,7 +21,7 @@
 x_client_domain($1_gift, $1)
 gnome_application($1_gift, $1)
 home_domain($1, gift)
-tmp_domain($1_gift)
+file_type_auto_trans($1_gift_t, $1_home_dir_t, $1_gift_home_t, dir)
 
 # Allow the user domain to signal/ps.
 can_ps($1_t, $1_gift_t)
@@ -75,6 +75,7 @@
 
 # Access home domain
 home_domain_access($1_giftd_t, $1, gift)
+file_type_auto_trans($1_gift_t, $1_home_dir_t, $1_gift_home_t, dir)
 
 # Serve content on various p2p networks. Ports can be random.
 can_network_server($1_giftd_t)
diff -Naur --exclude-from=excludes policy.orig/macros/program/iceauth_macros.te policy/macros/program/iceauth_macros.te
--- policy.orig/macros/program/iceauth_macros.te	2005-06-10 14:21:19.000000000 -0400
+++ policy/macros/program/iceauth_macros.te	2005-06-10 16:29:12.000000000 -0400
@@ -15,7 +15,8 @@
 role $1_r types $1_iceauth_t;
 
 # Store .ICEauthority files
-home_domain($1, iceauth, file)
+home_domain($1, iceauth)
+file_type_auto_trans($1_iceauth_t, $1_home_dir_t, $1_iceauth_home_t, file)
 
 # Supress xdm trying to restore .ICEauthority permissions
 ifdef(`xdm.te', `
diff -Naur --exclude-from=excludes policy.orig/macros/program/irc_macros.te policy/macros/program/irc_macros.te
--- policy.orig/macros/program/irc_macros.te	2005-06-10 14:21:19.000000000 -0400
+++ policy/macros/program/irc_macros.te	2005-06-10 16:29:32.000000000 -0400
@@ -21,6 +21,7 @@
 
 # Home domain
 home_domain($1, irc)
+file_type_auto_trans($1_irc_t, $1_home_dir_t, $1_irc_home_t, dir)
 
 # Derived domain based on the calling user domain and the program.
 type $1_irc_t, domain;
diff -Naur --exclude-from=excludes policy.orig/macros/program/lpr_macros.te policy/macros/program/lpr_macros.te
--- policy.orig/macros/program/lpr_macros.te	2005-06-10 14:21:19.000000000 -0400
+++ policy/macros/program/lpr_macros.te	2005-06-14 05:23:55.000000000 -0400
@@ -53,7 +53,6 @@
 ')
 
 tmp_domain($1_lpr)
-r_dir_file($1_lpr_t, $1_tmp_t)
 
 # Type for spool files.
 type $1_print_spool_t, file_type, sysadmfile;
@@ -72,18 +71,8 @@
 allow $1_lpr_t privfd:fd use;
 
 # Read user files. 
-allow sysadm_lpr_t { home_root_t $1_home_t $1_home_dir_t }:dir search;  
-allow sysadm_lpr_t $1_home_t:{ file lnk_file } r_file_perms;  
-allow $1_lpr_t { home_root_t $1_home_t $1_home_dir_t }:dir search;  
-allow $1_lpr_t $1_home_t:{ file lnk_file } r_file_perms;  
-
-if (use_nfs_home_dirs) {
-r_dir_file($1_lpr_t, nfs_t)
-}
-
-if (use_samba_home_dirs) {
-r_dir_file($1_lpr_t, cifs_t)
-}
+read_content(sysadm_lpr_t, $1, lpr) 
+read_content($1_lpr_t, $1, lpr)
 
 # Read and write shared files in the spool directory.
 allow $1_lpr_t print_spool_t:file rw_file_perms;
@@ -124,11 +113,5 @@
 can_tcp_connect({ $1_lpr_t $1_t }, cupsd_t)
 ')dnl end ifdef cups.te
 
-ifdef(`hide_broken_symptoms', `
-# thunderbird causes these
-dontaudit $1_lpr_t $1_t:tcp_socket { read write };
-dontaudit $1_lpr_t { $1_home_t $1_tmp_t }:file write;
-')
-
 ')dnl end macro definition
 
diff -Naur --exclude-from=excludes policy.orig/macros/program/mail_client_macros.te policy/macros/program/mail_client_macros.te
--- policy.orig/macros/program/mail_client_macros.te	2005-06-10 14:21:19.000000000 -0400
+++ policy/macros/program/mail_client_macros.te	2005-06-14 04:32:31.000000000 -0400
@@ -4,10 +4,6 @@
 # Author: Ivan Gyurdiev <ivg2@cornell.edu>
 #
 
-# Home access
-bool mail_writehome false;
-bool mail_readhome false;
-
 ########################################
 # mail_client_domain(client, role_prefix)
 #
@@ -36,25 +32,17 @@
 ifdef(`lpr.te', `
 domain_auto_trans($1_t, lpr_exec_t, $2_lpr_t)
 ')
-# FIXME - common type needed for internet content
-allow $2_lpr_t $1_tmp_t:file r_file_perms;
 
-# Save mail in the home directory
-# FIXME - common type needed for internet content
-if (mail_writehome) {
-file_type_auto_trans($1_t, { $2_home_t $2_home_dir_t }, $1_home_t, file)
-}
-
-# Read home (for attachments) 
-if (mail_readhome || mail_writehome) {
-r_dir_file($1_t, $2_home_t)
-}
+# Attachments
+read_content($1_t, $2, mail)
+
+# Save mail
+write_untrusted($1_t, $2)
 
 # Encrypt mail
 ifdef(`gpg.te', `
 domain_auto_trans($1_t, gpg_exec_t, $2_gpg_t)
-# FIXME - common type needed for internet content
-allow $2_gpg_t $1_tmp_t:file r_file_perms;
+allow $2_gpg_t $2_untrusted_content_t:file r_file_perms;
 ')
 
 ')
diff -Naur --exclude-from=excludes policy.orig/macros/program/mozilla_macros.te policy/macros/program/mozilla_macros.te
--- policy.orig/macros/program/mozilla_macros.te	2005-06-10 14:21:19.000000000 -0400
+++ policy/macros/program/mozilla_macros.te	2005-06-14 04:46:04.000000000 -0400
@@ -81,26 +81,14 @@
 # interacting with gstreamer
 r_dir_file($1_mozilla_t, var_t)
 
-# Write files to tmp
-tmp_domain($1_mozilla)
+# Uploads, local html
+read_content($1_mozilla_t, $1, mozilla) 
 
-# Execute downloaded programs.
-can_exec($1_mozilla_t, $1_mozilla_tmp_t)
+# Save web pages
+write_untrusted($1_mozilla_t, $1)
 
-# Allow mozilla to read user home content
-if (mozilla_readhome || mozilla_writehome) {
-r_dir_file($1_mozilla_t, $1_home_t)
-} else {
-dontaudit $1_mozilla_t $1_home_t:dir setattr;
-dontaudit $1_mozilla_t $1_home_t:file setattr;
-}
-
-if (mozilla_writehome) {
-# FIXME: Common internet downloads type is needed here.
-# FIXME: additionally, dir transition to such a type conflicts with ~/.mozilla
-file_type_auto_trans($1_mozilla_t, $1_home_dir_t, $1_mozilla_home_t, file )
-file_type_auto_trans($1_mozilla_t, $1_home_t, $1_mozilla_home_t, { dir file } )
-}
+# Execute java programs (FIXME)
+can_exec($1_mozilla_t, $1_untrusted_content_t)
 
 allow $1_mozilla_t $1_t:unix_stream_socket connectto;
 allow $1_mozilla_t sysctl_net_t:dir search;
@@ -125,29 +113,21 @@
 ifdef(`lpr.te', `
 domain_auto_trans($1_mozilla_t, lpr_exec_t, $1_lpr_t)
 
-# Print document
-allow $1_lpr_t $1_mozilla_tmp_t:file rw_file_perms;
-
 # Suppress history.fop denial
 # FIXME: common type is needed for internet content
-dontaudit $1_lpr_t $1_mozilla_home_t:file { read write };
+#dontaudit $1_lpr_t $1_mozilla_home_t:file { read write };
 
-dontaudit $1_lpr_t $1_mozilla_t:tcp_socket { read write };
-dontaudit $1_lpr_t $1_mozilla_t:unix_stream_socket { read write };
+#dontaudit $1_lpr_t $1_mozilla_t:tcp_socket { read write };
+#dontaudit $1_lpr_t $1_mozilla_t:unix_stream_socket { read write };
 ')
 
 # Mplayer plugin
 ifdef(`mplayer.te', `
 domain_auto_trans($1_mozilla_t, mplayer_exec_t, $1_mplayer_t)
 
-# Read mozilla content in /tmp
-# FIXME: common type is needed for internet content
-r_dir_file($1_mplayer_t, $1_mozilla_tmp_t);
-
 # Suppress history.fop denial
-dontaudit $1_mplayer_t $1_mozilla_home_t:file write;
-
-dontaudit $1_mplayer_t $1_mozilla_t:unix_stream_socket { read write };
+#dontaudit $1_mplayer_t $1_mozilla_home_t:file write;
+#dontaudit $1_mplayer_t $1_mozilla_t:unix_stream_socket { read write };
 ')dnl end if mplayer.te  
 
 # Launch email client, and make webcal links work
diff -Naur --exclude-from=excludes policy.orig/macros/program/mplayer_macros.te policy/macros/program/mplayer_macros.te
--- policy.orig/macros/program/mplayer_macros.te	2005-06-10 14:21:19.000000000 -0400
+++ policy/macros/program/mplayer_macros.te	2005-06-14 04:59:20.000000000 -0400
@@ -92,10 +92,6 @@
 # RTC clock 
 allow $1_mplayer_t clock_device_t:chr_file { ioctl read };
 
-# Play content from /home, and from CDs
-r_dir_file($1_mplayer_t, $1_home_t);
-r_dir_file($1_mplayer_t, removable_t);
-
 # Legacy domain issues
 if (allow_mplayer_execstack) {
 allow $1_mplayer_t $1_mplayer_tmpfs_t:file execute;
@@ -120,6 +116,9 @@
 can_exec($1_mplayer_t, shell_exec_t)
 #============================#
 
+# Read songs
+read_content($1_mplayer_t, $1, mplayer)
+
 ') dnl end mplayer_domain
 
 ###################################
@@ -128,7 +127,6 @@
 
 define(`mencoder_domain',`
 
-# FIXME: privhome temporarily removed...
 type $1_mencoder_t, domain;
 
 # Type transition
@@ -141,6 +139,9 @@
 # Mplayer common stuff
 mplayer_common($1, mencoder)
 
+# Save encoded files
+write_trusted($1_mplayer_t, $1, mplayer)
+
 ') dnl end mencoder_domain
 
 #############################
diff -Naur --exclude-from=excludes policy.orig/macros/program/orbit_macros.te policy/macros/program/orbit_macros.te
--- policy.orig/macros/program/orbit_macros.te	2005-06-10 14:21:19.000000000 -0400
+++ policy/macros/program/orbit_macros.te	2005-06-10 11:42:29.000000000 -0400
@@ -13,12 +13,11 @@
 ifdef(`orbit_domain_$1_$2', `', `
 define(`orbit_domain_$1_$2')
 
-# Type for ORBit sockets
-type $1_orbit_tmp_t, file_type, $2_file_type, sysadmfile, tmpfile;
-
 # Relabel directory (startup script)
 allow $1_t $1_orbit_tmp_t:{ dir file } { relabelfrom relabelto };
 
+# Type for ORBit sockets
+type $1_orbit_tmp_t, file_type, $2_file_type, sysadmfile, tmpfile;
 file_type_auto_trans($1_t, $2_orbit_tmp_t, $1_orbit_tmp_t)
 allow $1_t tmp_t:dir { read search getattr };
 
@@ -42,7 +41,4 @@
 can_unix_connect($1_t, $2_t)
 allow $1_t $2_orbit_tmp_t:sock_file write;
 
-# Why do they do that?
-dontaudit $1_t $2_orbit_tmp_t:dir setattr;
-
 ') dnl orbit_connect
diff -Naur --exclude-from=excludes policy.orig/macros/program/pyzor_macros.te policy/macros/program/pyzor_macros.te
--- policy.orig/macros/program/pyzor_macros.te	2005-06-10 14:21:19.000000000 -0400
+++ policy/macros/program/pyzor_macros.te	2005-06-14 05:24:17.000000000 -0400
@@ -52,6 +52,7 @@
 
 # Per-user config/data files
 home_domain($1, pyzor)
+file_type_auto_trans($1_pyzor_t, $1_home_dir_t, $1_pyzor_home_t, dir)
 
 # System config files
 r_dir_file($1_pyzor_t, pyzor_etc_t)
diff -Naur --exclude-from=excludes policy.orig/macros/program/razor_macros.te policy/macros/program/razor_macros.te
--- policy.orig/macros/program/razor_macros.te	2005-06-10 14:21:19.000000000 -0400
+++ policy/macros/program/razor_macros.te	2005-06-14 05:24:22.000000000 -0400
@@ -62,6 +62,7 @@
 
 # Per-user config/data files
 home_domain($1, razor)
+file_type_auto_trans($1_razor_t, $1_home_dir_t, $1_razor_home_t, dir)
 
 tmp_domain($1_razor)
 
diff -Naur --exclude-from=excludes policy.orig/macros/program/spamassassin_macros.te policy/macros/program/spamassassin_macros.te
--- policy.orig/macros/program/spamassassin_macros.te	2005-06-10 14:21:19.000000000 -0400
+++ policy/macros/program/spamassassin_macros.te	2005-06-14 05:24:59.000000000 -0400
@@ -44,7 +44,6 @@
 uses_shlib($1_$2_t)
 read_locale($1_$2_t)
 dontaudit $1_$2_t var_t:dir search;
-allow $1_$2_t $1_home_dir_t:dir r_dir_perms;
 tmp_domain($1_$2)
 allow $1_$2_t privfd:fd use;
 allow $1_$2_t userpty_type:chr_file rw_file_perms;
@@ -81,6 +80,7 @@
 
 # For ~/.spamassassin
 home_domain($1, spamassassin)
+file_type_auto_trans($1_spamassassin_t, $1_home_dir_t, $1_spamassassin_home_t, dir)
 
 spamassassin_agent_privs($1_spamassassin_t, $1)
 
diff -Naur --exclude-from=excludes policy.orig/macros/program/thunderbird_macros.te policy/macros/program/thunderbird_macros.te
--- policy.orig/macros/program/thunderbird_macros.te	2005-06-10 14:21:19.000000000 -0400
+++ policy/macros/program/thunderbird_macros.te	2005-06-10 16:34:28.000000000 -0400
@@ -51,8 +51,6 @@
 # Access ~/.thunderbird
 home_domain($1, thunderbird)
 
-tmp_domain($1_thunderbird)
-
 # RSS feeds
 can_network_client_tcp($1_thunderbird_t, http_port_t) 
 allow $1_thunderbird_t http_port_t:tcp_socket name_connect;
diff -Naur --exclude-from=excludes policy.orig/macros/program/tvtime_macros.te policy/macros/program/tvtime_macros.te
--- policy.orig/macros/program/tvtime_macros.te	2005-06-10 14:21:19.000000000 -0400
+++ policy/macros/program/tvtime_macros.te	2005-06-14 05:25:17.000000000 -0400
@@ -26,6 +26,7 @@
 
 # X access, Home files
 home_domain($1, tvtime)
+file_type_auto_trans($1_tvtime_t, $1_home_dir_t, $1_tvtime_home_t, dir)
 x_client_domain($1_tvtime, $1)
 
 uses_shlib($1_tvtime_t)
diff -Naur --exclude-from=excludes policy.orig/macros/program/xauth_macros.te policy/macros/program/xauth_macros.te
--- policy.orig/macros/program/xauth_macros.te	2005-06-10 14:21:19.000000000 -0400
+++ policy/macros/program/xauth_macros.te	2005-06-14 05:25:43.000000000 -0400
@@ -23,7 +23,8 @@
 
 allow $1_xauth_t self:process signal;
 
-home_domain($1, xauth, file)
+home_domain($1, xauth)
+file_type_auto_trans($1_xauth_t, $1_home_dir_t, $1_xauth_home_t, dir)
 
 # Transition from the user domain to this domain.
 domain_auto_trans($1_t, xauth_exec_t, $1_xauth_t)
diff -Naur --exclude-from=excludes policy.orig/macros/user_macros.te policy/macros/user_macros.te
--- policy.orig/macros/user_macros.te	2005-06-10 14:21:19.000000000 -0400
+++ policy/macros/user_macros.te	2005-06-14 05:29:44.000000000 -0400
@@ -21,7 +21,9 @@
 type $1_home_dir_t, file_type, sysadmfile, home_dir_type, home_type, user_home_dir_type, polydir;
 type $1_home_t, file_type, sysadmfile, home_type, user_home_type, $1_file_type, polymember;
 
-tmp_domain($1, `, user_tmpfile, $1_file_type', `{ file lnk_file dir sock_file fifo_file }')
+# Transition manually for { lnk sock fifo }. The rest is in content macros.
+tmp_domain_notrans($1, `, user_tmpfile, $1_file_type')
+file_type_auto_trans($1_t, tmp_t, $1_tmp_t, { lnk_file sock_file fifo_file })
 allow $1_t $1_tmp_t:{ dir file } { relabelto relabelfrom };
 
 ifdef(`support_polyinstantiation', `

--=-KoqveQIvkYr+ftuIajNc--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
