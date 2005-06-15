Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5FK7KgA025506
	for <selinux@tycho.nsa.gov>; Wed, 15 Jun 2005 16:07:21 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5FJwl9j017699
	for <selinux@tycho.nsa.gov>; Wed, 15 Jun 2005 19:58:48 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id j5FJxUKe022838
	for <selinux@tycho.nsa.gov>; Wed, 15 Jun 2005 15:59:30 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1/Submit) id j5FJxUkT022837
	for selinux@tycho.nsa.gov; Wed, 15 Jun 2005 15:59:30 -0400
Subject: Re: Content macros v 2
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: SELinux <SELinux@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1118770918.7853.5.camel@celtics.boston.redhat.com>
References: <1118744201.3416.13.camel@localhost.localdomain>
	 <1118770918.7853.5.camel@celtics.boston.redhat.com>
Content-Type: multipart/mixed; boundary="=-086A4dD5JEH7vgWix0kw"
Date: Wed, 15 Jun 2005 13:07:11 -0400
Message-Id: <1118855232.25735.10.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-086A4dD5JEH7vgWix0kw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Content Macros v.2 

Requires .mplayer and .gpg to be pre-created (selinux.sh,
for lack of a better solution).

Dan, merge at your discretion. 

I think most things will work fine, but certain
things start to break when the booleans get turned off.
In particular, mozilla generates icons, writes them 
in /tmp and reads them back in again. This doesn't
work when read_mozilla_content or read_untrusted_content
is disabled. This is an app misbehavior IMHO, and needs to be fixed
there. Discussing this w/ mozilla people...

The other major thing that doesn't work is printing
if read_APP_content or read_untrusted is disabled.
I need to investigate how printing is done to get
this working. In particular, why isn't lpr
reading the document, instead of APP. If lpr
was reading the document, we could add a print_untrusted boolean
to lpr that's different from read_untrusted_content.

Also, mplayer-mozilla interaction I have yet to test,
as well as java (since I removed some things).

--=-086A4dD5JEH7vgWix0kw
Content-Disposition: attachment; filename=content.diff
Content-Type: text/x-patch; name=content.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naur --exclude-from=excludes policy.orig/domains/program/gpg.te policy/domains/program/gpg.te
--- policy.orig/domains/program/gpg.te	2005-06-14 09:53:24.000000000 -0400
+++ policy/domains/program/gpg.te	2005-06-15 09:40:50.000000000 -0400
@@ -11,8 +11,5 @@
 allow sysadm_gpg_t { home_root_t user_home_dir_type }:dir search;
 allow sysadm_gpg_t ptyfile:chr_file rw_file_perms;
 
-# Allow gpg exec stack
-bool allow_gpg_execstack false;
-
 # Everything else is in the gpg_domain macro in
 # macros/program/gpg_macros.te.
diff -Naur --exclude-from=excludes policy.orig/domains/program/mount.te policy/domains/program/mount.te
--- policy.orig/domains/program/mount.te	2005-06-14 09:53:24.000000000 -0400
+++ policy/domains/program/mount.te	2005-06-14 16:18:34.000000000 -0400
@@ -68,7 +68,7 @@
 # for localization
 allow mount_t lib_t:file { getattr read };
 allow mount_t autofs_t:dir read;
-allow mount_t fs_t:filesystem relabelfrom;
+allow mount_t fs_type:filesystem relabelfrom;
 #
 # This rule needs to be generalized.  Only admin, initrc should have it.
 #
diff -Naur --exclude-from=excludes policy.orig/domains/program/mozilla.te policy/domains/program/mozilla.te
--- policy.orig/domains/program/mozilla.te	2005-06-14 09:53:24.000000000 -0400
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
 
diff -Naur --exclude-from=excludes policy.orig/domains/program/xdm.te policy/domains/program/xdm.te
--- policy.orig/domains/program/xdm.te	2005-06-14 09:53:24.000000000 -0400
+++ policy/domains/program/xdm.te	2005-06-14 16:04:59.000000000 -0400
@@ -326,7 +326,7 @@
 allow xdm_t pam_var_run_t:dir create_dir_perms;
 allow xdm_t pam_var_run_t:file create_file_perms;
 allow pam_t xdm_t:fifo_file { getattr ioctl write };
-can_exec(xdm_t, pam_console_exec_t)
+domain_auto_trans(xdm_t, pam_console_exec_t, pam_console_t)
 can_exec(xdm_t, pam_exec_t)
 # For pam_console
 rw_dir_create_file(xdm_t, pam_var_console_t)
@@ -368,7 +368,7 @@
 # Allow gdm to run gdm-binary
 can_exec(xdm_t, xdm_exec_t)
 
-# Supress getattr check on .ICE-unix
-dontaudit xdm_t ice_tmp_t:dir getattr;
+# Supress permission check on .ICE-unix
+dontaudit xdm_t ice_tmp_t:dir { getattr setattr };
 
 #### Also see xdm_macros.te
diff -Naur --exclude-from=excludes policy.orig/domains/user.te policy/domains/user.te
--- policy.orig/domains/user.te	2005-06-14 09:53:24.000000000 -0400
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
diff -Naur --exclude-from=excludes policy.orig/file_contexts/distros.fc policy/file_contexts/distros.fc
--- policy.orig/file_contexts/distros.fc	2005-06-14 09:53:24.000000000 -0400
+++ policy/file_contexts/distros.fc	2005-06-14 15:46:45.000000000 -0400
@@ -88,18 +88,9 @@
 /usr/X11R6/lib/modules/dri/.*\.so		-- system_u:object_r:texrel_shlib_t
 /usr/X11R6/lib/libOSMesa\.so.*			-- system_u:object_r:texrel_shlib_t
 /usr/lib/libHermes\.so.*			-- system_u:object_r:texrel_shlib_t
-/usr/lib/valgrind/libpthread\.so		-- system_u:object_r:texrel_shlib_t
-/usr/lib/valgrind/vgpreload_addrcheck\.so	-- system_u:object_r:texrel_shlib_t
-/usr/lib/valgrind/vgpreload_memcheck\.so	-- system_u:object_r:texrel_shlib_t
-/usr/lib/valgrind/vgskin_addrcheck\.so		-- system_u:object_r:texrel_shlib_t
-/usr/lib/valgrind/vgskin_cachegrind\.so		-- system_u:object_r:texrel_shlib_t
-/usr/lib/valgrind/vgskin_callgrind\.so		-- system_u:object_r:texrel_shlib_t
-/usr/lib/valgrind/vgskin_corecheck\.so		-- system_u:object_r:texrel_shlib_t
-/usr/lib/valgrind/vgskin_helgrind\.so		-- system_u:object_r:texrel_shlib_t
-/usr/lib/valgrind/vgskin_lackey\.so		-- system_u:object_r:texrel_shlib_t
-/usr/lib/valgrind/vgskin_massif\.so		-- system_u:object_r:texrel_shlib_t
-/usr/lib/valgrind/vgskin_memcheck\.so		-- system_u:object_r:texrel_shlib_t
-/usr/lib/valgrind/vgskin_none\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/valgrind/hp2ps				-- system_u:object_r:texrel_shlib_t
+/usr/lib/valgrind/stage2			-- system_u:object_r:texrel_shlib_t
+/usr/lib/valgrind/vg.*\.so			-- system_u:object_r:texrel_shlib_t
 /usr/lib/.*/program/libicudata\.so.*		-- system_u:object_r:texrel_shlib_t
 /usr/lib/.*/program/libsts645li\.so		-- system_u:object_r:texrel_shlib_t
 /usr/lib/.*/program/libvclplug_gen645li\.so	-- system_u:object_r:texrel_shlib_t
diff -Naur --exclude-from=excludes policy.orig/file_contexts/program/irc.fc policy/file_contexts/program/irc.fc
--- policy.orig/file_contexts/program/irc.fc	2005-06-14 09:53:24.000000000 -0400
+++ policy/file_contexts/program/irc.fc	2005-06-14 04:52:51.000000000 -0400
@@ -2,4 +2,4 @@
 /usr/bin/[st]irc	--	system_u:object_r:irc_exec_t
 /usr/bin/ircII		--	system_u:object_r:irc_exec_t
 /usr/bin/tinyirc	--	system_u:object_r:irc_exec_t
-HOME_DIR/\.ircmotd	--	system_u:object_r:ROLE_home_irc_t
+HOME_DIR/\.ircmotd	--	system_u:object_r:ROLE_irc_home_t
diff -Naur --exclude-from=excludes policy.orig/macros/admin_macros.te policy/macros/admin_macros.te
--- policy.orig/macros/admin_macros.te	2005-06-14 09:53:24.000000000 -0400
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
--- policy.orig/macros/base_user_macros.te	2005-06-14 09:53:24.000000000 -0400
+++ policy/macros/base_user_macros.te	2005-06-14 16:54:56.000000000 -0400
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
@@ -24,11 +18,27 @@
 
 # Type for network-obtained content
 type $1_untrusted_content_t, file_type, $1_file_type, sysadmfile, customizable;
-bool $1_access_untrusted_content false;
-if ($1_access_untrusted_content) {
-rw_dir_file($1_t, $1_untrusted_content_t) 
-}
-#allow $1_t $1_untrusted_content_t:{ dir file } { relabelto relabelfrom };
+type $1_untrusted_content_tmp_t, file_type, $1_file_type, sysadmfile, tmpfile, customizable;
+
+# Allow user to relabel untrusted content
+allow $1_t $1_untrusted_content_t:{ dir file } { getattr unlink relabelto relabelfrom };
+allow $1_t $1_untrusted_content_tmp_t:{ dir file } { getattr unlink relabelto relabelfrom };
+
+# Read content
+read_content($1_t, $1)
+
+# Write trusted content. This includes proper transition
+# for /home, and /tmp, so no other transition is necessary (or allowed)
+write_trusted($1_t, $1)
+
+# Maybe the home directory is networked
+network_home($1_t)
+
+# Transition for { lnk, fifo, sock }. The rest is covered by write_trusted.
+# Relabel files in the home directory 
+file_type_auto_trans($1_t, $1_home_dir_t, $1_home_t, { fifo_file sock_file lnk_file }); 
+allow $1_t $1_home_t:{ notdevfile_class_set dir } { relabelfrom relabelto };
+can_setfscreate($1_t)
 
 allow $1_t self:capability { setgid chown fowner };
 dontaudit $1_t self:capability { sys_nice fsetid };
@@ -88,26 +98,11 @@
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
@@ -380,6 +375,10 @@
 
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
+++ policy/macros/content_macros.te	2005-06-15 11:15:07.000000000 -0400
@@ -0,0 +1,194 @@
+# Content access macros
+
+# FIXME: After nested booleans are supported, replace NFS/CIFS
+# w/ read_network_home, and write_network_home macros from global
+
+# FIXME: If true/false constant booleans are supported, replace
+# ugly $3 ifdefs with if(true), if(false)...
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
+# Declare controlling boolean
+ifelse($3, `', `', `
+ifdef(`$3_read_content_defined', `', `
+define(`$3_read_content_defined')
+bool $3_read_content false;
+') dnl ifdef 
+') dnl ifelse
+
+# Handle nfs home dirs
+ifelse($3, `', 
+`if (use_nfs_home_dirs) { ', 
+`if ($3_read_content && use_nfs_home_dirs) {')
+allow $1 { autofs_t home_root_t }:dir { read search getattr };
+r_dir_file($1, nfs_t)
+} else {
+dontaudit $1 { autofs_t home_root_t }:dir { read search getattr };
+dontaudit $1 nfs_t:file r_file_perms;
+dontaudit $1 nfs_t:dir r_dir_perms;
+}
+
+# Handle samba home dirs
+ifelse($3, `',
+`if (use_samba_home_dirs) { ',
+`if ($3_read_content && use_samba_home_dirs) {')
+allow $1 { autofs_t home_root_t }:dir { read search getattr };
+r_dir_file($1, cifs_t)
+} else {
+dontaudit $1 { autofs_t home_root_t }:dir { read search getattr };
+dontaudit $1 cifs_t:file r_file_perms;
+dontaudit $1 cifs_t:dir r_dir_perms;
+}
+
+# Handle removable media, /tmp, and /home
+ifelse($3, `', `', 
+`if ($3_read_content) {')
+allow $1 { tmp_t home_root_t $2_home_dir_t }:dir { read getattr search };
+r_dir_file($1, { removable_t $2_tmp_t $2_home_t } )
+
+ifelse($3, `', `', 
+`} else {
+dontaudit $1 { tmp_t home_root_t $2_home_dir_t }:dir { read getattr search };
+dontaudit $1 { removable_t $2_tmp_t $2_home_t }:dir r_dir_perms;
+dontaudit $1 { removable_t $2_tmp_t $2_home_t }:file r_file_perms;
+}') 
+
+# Handle default_t content
+ifelse($3, `',
+`if (read_default_t) { ',
+`if ($3_read_content && read_default_t) {')
+r_dir_file($1, default_t)
+} else {
+dontaudit $1 default_t:file r_file_perms;
+dontaudit $1 default_t:dir r_dir_perms;
+} 
+
+# Handle untrusted content
+ifelse($3, `',
+`if (read_untrusted_content) { ',
+`if ($3_read_content && read_untrusted_content) {')
+allow $1 { tmp_t home_root_t $2_home_dir_t }:dir { read getattr search };
+r_dir_file($1, { $2_untrusted_content_t $2_untrusted_content_tmp_t })
+} else {
+dontaudit $1 { tmp_t home_root_t $2_home_dir_t }:dir { read getattr search };
+dontaudit $1 { $2_untrusted_content_t $2_untrusted_content_tmp_t }:dir r_dir_perms;
+dontaudit $1 { $2_untrusted_content_t $2_untrusted_content_tmp_t }:file r_file_perms;
+}
+') dnl read_content
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
+# Declare controlling boolean
+ifelse($3, `', `', `
+ifdef(`$3_write_content_defined', `', `
+define(`$3_write_content_defined')
+bool $3_write_content false;
+') dnl ifdef
+') dnl ifelse
+
+# Handle nfs homedirs
+ifelse($3, `',
+`if (use_nfs_home_dirs) { ',
+`if ($3_write_content && use_nfs_home_dirs) {')
+allow $1 { autofs_t home_root_t }:dir { read search getattr };
+allow $1 nfs_t:file create_noread_file_perms;
+allow $1 nfs_t:dir create_dir_perms;
+} else {
+dontaudit $1 { autofs_t home_root_t }:dir { read search getattr };
+dontaudit $1 nfs_t:file create_noread_file_perms;
+dontaudit $1 nfs_t:dir create_dir_perms;
+}
+
+# Handle samba homedirs
+ifelse($3, `',
+`if (use_samba_home_dirs) { ',
+`if ($3_write_content && use_samba_home_dirs) {')
+allow $1 { autofs_t home_root_t }:dir { read search getattr };
+allow $1 cifs_t:file create_noread_file_perms;
+allow $1 cifs_t:dir create_dir_perms;
+} else {
+dontaudit $1 { autofs_t home_root_t }:dir { read search getattr };
+dontaudit $1 cifs_t:file create_noread_file_perms;
+dontaudit $1 cifs_t:dir create_dir_perms;
+}
+
+# Handle /tmp and /home
+ifelse($3, `', `', 
+`if ($3_write_content) {') 
+allow $1 home_root_t:dir { read getattr search };
+allow $1 { tmp_t $2_home_dir_t }:dir rw_dir_perms;
+type_transition $1 tmp_t:{ dir file } $2_tmp_t;
+type_transition $1 $2_home_dir_t:{ dir file } $2_home_t;
+allow $1 { $2_tmp_t $2_home_t }:file create_noread_file_perms;
+allow $1 { $2_tmp_t $2_home_t }:dir create_dir_perms;
+
+ifelse($3, `', `', 
+`} else {
+dontaudit $1 { tmp_t home_root_t $2_home_dir_t }:dir { read getattr search };
+dontaudit $1 { $2_tmp_t $2_home_t }:file create_noread_file_perms;
+dontaudit $1 { $2_tmp_t $2_home_t }:dir create_dir_perms;
+}')
+
+') dnl write_trusted
+
+#########################################
+# write_untrusted(domain, role_prefix)
+#
+# Allow the given domain to write untrusted content. 
+# This is subject to the global boolean write_untrusted.
+
+define(`write_untrusted', `
+
+# Handle nfs homedirs
+if (write_untrusted_content && use_nfs_home_dirs) {
+allow $1 { autofs_t home_root_t }:dir { read search getattr };
+allow $1 nfs_t:file create_noread_file_perms;
+allow $1 nfs_t:dir create_dir_perms;
+} else {
+dontaudit $1 { autofs_t home_root_t }:dir { read search getattr };
+dontaudit $1 nfs_t:file create_noread_file_perms;
+dontaudit $1 nfs_t:dir create_dir_perms;
+}
+
+# Handle samba homedirs
+if (write_untrusted_content && use_samba_home_dirs) {
+allow $1 { autofs_t home_root_t }:dir { read search getattr };
+allow $1 cifs_t:file create_noread_file_perms;
+allow $1 cifs_t:dir create_dir_perms;
+} else {
+dontaudit $1 { autofs_t home_root_t }:dir { read search getattr };
+dontaudit $1 cifs_t:file create_noread_file_perms;
+dontaudit $1 cifs_t:dir create_dir_perms;
+}
+
+# Handle /tmp and /home
+if (write_untrusted_content) {
+allow $1 home_root_t:dir { read getattr search };
+allow $1 { tmp_t $2_home_dir_t }:dir rw_dir_perms;
+type_transition $1 { tmp_t $2_tmp_t }:{ dir file } $2_untrusted_content_tmp_t;
+type_transition $1 { $2_home_t $2_home_dir_t }:{ dir file } $2_untrusted_content_tmp_t;
+allow $1 { $2_untrusted_content_t $2_untrusted_content_tmp_t }:file create_noread_file_perms; 
+allow $1 { $2_untrusted_content_t $2_untrusted_content_tmp_t }:dir create_dir_perms;
+} else {
+dontaudit $1 { tmp_t home_root_t $2_home_dir_t }:dir { read getattr search };
+dontaudit $1 { $2_tmp_t $2_home_t }:dir create_dir_perms;
+dontaudit $1 { $2_tmp_t $2_home_t }:file create_noread_file_perms;
+}
+
+') dnl write_untrusted
diff -Naur --exclude-from=excludes policy.orig/macros/core_macros.te policy/macros/core_macros.te
--- policy.orig/macros/core_macros.te	2005-06-14 09:53:24.000000000 -0400
+++ policy/macros/core_macros.te	2005-06-15 11:03:10.000000000 -0400
@@ -103,6 +103,11 @@
 # 
 define(`create_file_perms', `{ create ioctl read getattr lock write setattr append link unlink rename }')
 
+#
+# Permissions for creating files, but not reading 
+#
+define(`create_noread_file_perms', `{ create ioctl getattr lock write setattr append link unlink rename }')
+
 # 
 # Permissions for reading directories and their attributes.
 #
diff -Naur --exclude-from=excludes policy.orig/macros/global_macros.te policy/macros/global_macros.te
--- policy.orig/macros/global_macros.te	2005-06-14 09:53:24.000000000 -0400
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
+++ policy/macros/home_macros.te	2005-06-14 14:19:11.000000000 -0400
@@ -0,0 +1,130 @@
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
+allow $1 { home_root_t $2_home_dir_t }:dir { search getattr };
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
+allow $1 { home_root_t $2_home_dir_t }:dir { search getattr };
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
diff -Naur --exclude-from=excludes policy.orig/macros/program/evolution_macros.te policy/macros/program/evolution_macros.te
--- policy.orig/macros/program/evolution_macros.te	2005-06-14 09:53:24.000000000 -0400
+++ policy/macros/program/evolution_macros.te	2005-06-15 11:21:37.000000000 -0400
@@ -61,6 +61,9 @@
 can_network_client_tcp($1_evolution_server_t, ldap_port_t)
 allow $1_evolution_server_t ldap_port_t:tcp_socket name_connect;
 
+# Look in /etc/pki
+allow $1_evolution_server_t cert_t:dir r_dir_perms;
+
 ') dnl evolution_data_server
 
 #######################################
@@ -137,7 +140,7 @@
 
 # /tmp/.exchange-$USER
 tmp_domain($1_evolution_exchange)
-  
+ 
 # Allow netstat
 allow $1_evolution_exchange_t bin_t:dir search; 
 can_exec($1_evolution_exchange_t, bin_t)
@@ -145,6 +148,9 @@
 allow $1_evolution_exchange_t sysctl_net_t:dir search;
 allow $1_evolution_exchange_t self:{ udp_socket tcp_socket } create_socket_perms;
 
+# Clock applet talks to exchange (FIXME: Needs policy)
+bonobo_connect($1, $1_evolution_exchange)
+
 # FIXME: policy incomplete
 
 ') dnl evolution_exchange
@@ -179,9 +185,6 @@
 # Access .evolution
 home_domain($1, evolution)
 
-# Store documents in /tmp (to print, etc..)
-tmp_domain($1_evolution)
-
 # Store passwords in .gnome2_private
 gnome_private_store($1_evolution, $1) 
 
diff -Naur --exclude-from=excludes policy.orig/macros/program/gconf_macros.te policy/macros/program/gconf_macros.te
--- policy.orig/macros/program/gconf_macros.te	2005-06-14 09:53:24.000000000 -0400
+++ policy/macros/program/gconf_macros.te	2005-06-14 05:23:05.000000000 -0400
@@ -23,6 +23,7 @@
 
 # Access .gconfd and .gconf
 home_domain($1, gconfd)
+file_type_auto_trans($1_gconfd_t, $1_home_dir_t, $1_gconfd_home_t, dir)
 
 # Access /etc/gconf
 r_dir_file($1_gconfd_t, gconf_etc_t)
diff -Naur --exclude-from=excludes policy.orig/macros/program/gift_macros.te policy/macros/program/gift_macros.te
--- policy.orig/macros/program/gift_macros.te	2005-06-14 09:53:24.000000000 -0400
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
diff -Naur --exclude-from=excludes policy.orig/macros/program/gpg_macros.te policy/macros/program/gpg_macros.te
--- policy.orig/macros/program/gpg_macros.te	2005-06-14 09:53:24.000000000 -0400
+++ policy/macros/program/gpg_macros.te	2005-06-15 09:42:30.000000000 -0400
@@ -23,6 +23,7 @@
 
 # Transition from the user domain to the derived domain.
 domain_auto_trans($1_t, gpg_exec_t, $1_gpg_t)
+role $1_r types $1_gpg_t;
 
 can_network($1_gpg_t)
 allow $1_gpg_t port_type:tcp_socket name_connect;
@@ -31,20 +32,6 @@
 # for a bug in kmail
 dontaudit $1_gpg_t $1_t:unix_stream_socket { getattr read write };
 
-# The user role is authorized for this domain.
-role $1_r types $1_gpg_t;
-
-# Legacy
-if (allow_gpg_execstack) {
-legacy_domain($1_gpg)
-allow $1_gpg_t locale_t:file execute;
-
-# Not quite sure why this is needed... 
-allow $1_gpg_t gpg_exec_t:file execmod;
-}
-
-allow $1_t $1_gpg_secret_t:file getattr;
-
 allow $1_gpg_t device_t:dir r_dir_perms;
 allow $1_gpg_t { random_device_t urandom_device_t }:chr_file r_file_perms;
 
@@ -68,38 +55,21 @@
 
 uses_shlib($1_gpg_t)
 
-# should not need read access...
-allow $1_gpg_t home_root_t:dir { read search };
-
-# use $1_gpg_secret_t for files it creates
-# NB we are doing the type transition for directory creation only!
-# so ~/.gnupg will be of $1_gpg_secret_t, then files created under it such as
-# secring.gpg will be of $1_gpg_secret_t too.  But when you use gpg to decrypt
-# a file and write output to your home directory it will use user_home_t.
-file_type_auto_trans($1_gpg_t, $1_home_dir_t, $1_gpg_secret_t, dir)
+# Access .gnupg
 rw_dir_create_file($1_gpg_t, $1_gpg_secret_t)
 
-file_type_auto_trans($1_gpg_t, $1_home_dir_t, $1_home_t, file)
-create_dir_file($1_gpg_t, $1_home_t)
-
-# allow the usual access to /tmp
-file_type_auto_trans($1_gpg_t, tmp_t, $1_tmp_t)
+# Read content to encrypt/decrypt/sign
+read_content($1_gpg_t, $1)
 
-if (use_nfs_home_dirs) {
-create_dir_file($1_gpg_t, nfs_t)
-}
-if (use_samba_home_dirs) {
-create_dir_file($1_gpg_t, cifs_t)
-}
+# Write content to encrypt/decrypt/sign
+write_trusted($1_gpg_t, $1)
 
 allow $1_gpg_t self:capability { ipc_lock setuid };
-rw_dir_create_file($1_gpg_t, $1_file_type)
 
 allow $1_gpg_t { etc_t usr_t }:dir r_dir_perms;
 allow $1_gpg_t fs_t:filesystem getattr;
 allow $1_gpg_t usr_t:file r_file_perms;
 read_locale($1_gpg_t)
-allow $1_t $1_gpg_secret_t:dir rw_dir_perms;
 
 dontaudit $1_gpg_t var_t:dir search;
 
diff -Naur --exclude-from=excludes policy.orig/macros/program/iceauth_macros.te policy/macros/program/iceauth_macros.te
--- policy.orig/macros/program/iceauth_macros.te	2005-06-14 09:53:24.000000000 -0400
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
--- policy.orig/macros/program/irc_macros.te	2005-06-14 09:53:24.000000000 -0400
+++ policy/macros/program/irc_macros.te	2005-06-10 16:29:32.000000000 -0400
@@ -21,6 +21,7 @@
 
 # Home domain
 home_domain($1, irc)
+file_type_auto_trans($1_irc_t, $1_home_dir_t, $1_irc_home_t, dir)
 
 # Derived domain based on the calling user domain and the program.
 type $1_irc_t, domain;
diff -Naur --exclude-from=excludes policy.orig/macros/program/lpr_macros.te policy/macros/program/lpr_macros.te
--- policy.orig/macros/program/lpr_macros.te	2005-06-14 09:53:24.000000000 -0400
+++ policy/macros/program/lpr_macros.te	2005-06-15 12:19:24.000000000 -0400
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
+read_content(sysadm_lpr_t, $1) 
+read_content($1_lpr_t, $1)
 
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
--- policy.orig/macros/program/mail_client_macros.te	2005-06-14 09:53:24.000000000 -0400
+++ policy/macros/program/mail_client_macros.te	2005-06-15 09:42:53.000000000 -0400
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
+allow $1_t $2_gpg_t:process signal;
 ')
 
 ')
diff -Naur --exclude-from=excludes policy.orig/macros/program/mozilla_macros.te policy/macros/program/mozilla_macros.te
--- policy.orig/macros/program/mozilla_macros.te	2005-06-14 09:53:24.000000000 -0400
+++ policy/macros/program/mozilla_macros.te	2005-06-15 12:14:06.000000000 -0400
@@ -43,9 +43,10 @@
 # Look for plugins 
 allow $1_mozilla_t bin_t:dir { getattr read search };
 
+# Browse the web, connect to printer
 can_resolve($1_mozilla_t)
-can_network_client_tcp($1_mozilla_t, { http_port_t http_cache_port_t ftp_port_t } )
-allow $1_mozilla_t { http_port_t http_cache_port_t ftp_port_t }:tcp_socket name_connect;
+can_network_client_tcp($1_mozilla_t, { http_port_t http_cache_port_t ftp_port_t ipp_port_t } )
+allow $1_mozilla_t { http_port_t http_cache_port_t ftp_port_t ipp_port_t }:tcp_socket name_connect;
 
 allow $1_mozilla_t sound_device_t:chr_file rw_file_perms;
 
@@ -57,10 +58,12 @@
 can_ps($1_t, $1_mozilla_t)
 allow $1_t $1_mozilla_t:process signal_perms;
 
-# Access /proc
+# Access /proc, sysctl
 allow $1_mozilla_t proc_t:dir search;
 allow $1_mozilla_t proc_t:file { getattr read };
 allow $1_mozilla_t proc_t:lnk_file read;
+allow $1_mozilla_t sysctl_net_t:dir search;
+allow $1_mozilla_t sysctl_t:dir search;
 
 allow $1_mozilla_t var_lib_t:file { getattr read };
 allow $1_mozilla_t self:socket create_socket_perms;
@@ -81,80 +84,44 @@
 # interacting with gstreamer
 r_dir_file($1_mozilla_t, var_t)
 
-# Write files to tmp
-tmp_domain($1_mozilla)
-
-# Execute downloaded programs.
-can_exec($1_mozilla_t, $1_mozilla_tmp_t)
-
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
+# Uploads, local html
+read_content($1_mozilla_t, $1, mozilla) 
 
-allow $1_mozilla_t $1_t:unix_stream_socket connectto;
-allow $1_mozilla_t sysctl_net_t:dir search;
-allow $1_mozilla_t sysctl_t:dir search;
-ifdef(`cups.te', `
-allow $1_mozilla_t cupsd_etc_t:dir search;
-allow $1_mozilla_t cupsd_rw_etc_t:file { getattr read };
-')
-allow $1_mozilla_t $1_t:tcp_socket { read write };
+# Save web pages
+write_untrusted($1_mozilla_t, $1)
 
 allow $1_mozilla_t mozilla_conf_t:file r_file_perms;
 dontaudit $1_mozilla_t port_type:tcp_socket name_bind;
 dontaudit $1_mozilla_t dri_device_t:chr_file rw_file_perms;
 allow $1_mozilla_t self:sem create_sem_perms;
 
-# Java plugin
+######### Java plugin
 ifdef(`java.te', `
 javaplugin_domain($1_mozilla, $1)
-')
+') dnl java.te
 
-# Use printer
+######### Print web content
+ifdef(`cups.te', `
+allow $1_mozilla_t cupsd_etc_t:dir search;
+allow $1_mozilla_t cupsd_rw_etc_t:file { getattr read };
+')
 ifdef(`lpr.te', `
 domain_auto_trans($1_mozilla_t, lpr_exec_t, $1_lpr_t)
-
-# Print document
-allow $1_lpr_t $1_mozilla_tmp_t:file rw_file_perms;
-
-# Suppress history.fop denial
-# FIXME: common type is needed for internet content
 dontaudit $1_lpr_t $1_mozilla_home_t:file { read write };
-
 dontaudit $1_lpr_t $1_mozilla_t:tcp_socket { read write };
-dontaudit $1_lpr_t $1_mozilla_t:unix_stream_socket { read write };
-')
+') dnl if lpr.te
 
-# Mplayer plugin
+######### Launch mplayer
 ifdef(`mplayer.te', `
 domain_auto_trans($1_mozilla_t, mplayer_exec_t, $1_mplayer_t)
-
-# Read mozilla content in /tmp
-# FIXME: common type is needed for internet content
-r_dir_file($1_mplayer_t, $1_mozilla_tmp_t);
-
-# Suppress history.fop denial
-dontaudit $1_mplayer_t $1_mozilla_home_t:file write;
-
-dontaudit $1_mplayer_t $1_mozilla_t:unix_stream_socket { read write };
+dontaudit $1_mplayer_t $1_mozilla_home_t:file { read write };
 ')dnl end if mplayer.te  
 
-# Launch email client, and make webcal links work
+######### Launch email client, and make webcal links work
 ifdef(`evolution.te', `
 domain_auto_trans($1_mozilla_t, evolution_exec_t, $1_evolution_t)
 domain_auto_trans($1_mozilla_t, evolution_webcal_exec_t, $1_evolution_webcal_t)
-')
+') dnl if evolution.te
 
 if (allow_execmem) {
 allow $1_mozilla_t self:process execmem;
diff -Naur --exclude-from=excludes policy.orig/macros/program/mplayer_macros.te policy/macros/program/mplayer_macros.te
--- policy.orig/macros/program/mplayer_macros.te	2005-06-14 09:53:24.000000000 -0400
+++ policy/macros/program/mplayer_macros.te	2005-06-15 10:11:33.000000000 -0400
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
+read_content($1_mplayer_t, $1)
+
 ') dnl end mplayer_domain
 
 ###################################
@@ -128,7 +127,6 @@
 
 define(`mencoder_domain',`
 
-# FIXME: privhome temporarily removed...
 type $1_mencoder_t, domain;
 
 # Type transition
@@ -141,6 +139,12 @@
 # Mplayer common stuff
 mplayer_common($1, mencoder)
 
+# Read content to encode
+read_content($1_mencoder_t, $1)
+
+# Save encoded files
+write_trusted($1_mencoder_t, $1)
+
 ') dnl end mencoder_domain
 
 #############################
diff -Naur --exclude-from=excludes policy.orig/macros/program/pyzor_macros.te policy/macros/program/pyzor_macros.te
--- policy.orig/macros/program/pyzor_macros.te	2005-06-14 09:53:24.000000000 -0400
+++ policy/macros/program/pyzor_macros.te	2005-06-14 05:24:17.000000000 -0400
@@ -52,6 +52,7 @@
 
 # Per-user config/data files
 home_domain($1, pyzor)
+file_type_auto_trans($1_pyzor_t, $1_home_dir_t, $1_pyzor_home_t, dir)
 
 # System config files
 r_dir_file($1_pyzor_t, pyzor_etc_t)
diff -Naur --exclude-from=excludes policy.orig/macros/program/razor_macros.te policy/macros/program/razor_macros.te
--- policy.orig/macros/program/razor_macros.te	2005-06-14 09:53:24.000000000 -0400
+++ policy/macros/program/razor_macros.te	2005-06-14 05:24:22.000000000 -0400
@@ -62,6 +62,7 @@
 
 # Per-user config/data files
 home_domain($1, razor)
+file_type_auto_trans($1_razor_t, $1_home_dir_t, $1_razor_home_t, dir)
 
 tmp_domain($1_razor)
 
diff -Naur --exclude-from=excludes policy.orig/macros/program/spamassassin_macros.te policy/macros/program/spamassassin_macros.te
--- policy.orig/macros/program/spamassassin_macros.te	2005-06-14 09:53:24.000000000 -0400
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
--- policy.orig/macros/program/thunderbird_macros.te	2005-06-14 09:53:24.000000000 -0400
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
--- policy.orig/macros/program/tvtime_macros.te	2005-06-14 09:53:24.000000000 -0400
+++ policy/macros/program/tvtime_macros.te	2005-06-14 05:25:17.000000000 -0400
@@ -26,6 +26,7 @@
 
 # X access, Home files
 home_domain($1, tvtime)
+file_type_auto_trans($1_tvtime_t, $1_home_dir_t, $1_tvtime_home_t, dir)
 x_client_domain($1_tvtime, $1)
 
 uses_shlib($1_tvtime_t)
diff -Naur --exclude-from=excludes policy.orig/macros/program/xauth_macros.te policy/macros/program/xauth_macros.te
--- policy.orig/macros/program/xauth_macros.te	2005-06-14 09:53:24.000000000 -0400
+++ policy/macros/program/xauth_macros.te	2005-06-14 05:50:15.000000000 -0400
@@ -23,7 +23,8 @@
 
 allow $1_xauth_t self:process signal;
 
-home_domain($1, xauth, file)
+home_domain($1, xauth)
+file_type_auto_trans($1_xauth_t, $1_home_dir_t, $1_xauth_home_t, file)
 
 # Transition from the user domain to this domain.
 domain_auto_trans($1_t, xauth_exec_t, $1_xauth_t)
diff -Naur --exclude-from=excludes policy.orig/macros/program/xdm_macros.te policy/macros/program/xdm_macros.te
--- policy.orig/macros/program/xdm_macros.te	2005-06-14 09:53:24.000000000 -0400
+++ policy/macros/program/xdm_macros.te	2005-06-14 05:51:04.000000000 -0400
@@ -7,5 +7,5 @@
 
 define(`can_pipe_xdm', `
 allow $1 xdm_t:fd use;
-allow $1 xdm_t:fifo_file { getattr read write };
+allow $1 xdm_t:fifo_file { getattr read write ioctl };
 ') dnl can_pipe_xdm
diff -Naur --exclude-from=excludes policy.orig/macros/user_macros.te policy/macros/user_macros.te
--- policy.orig/macros/user_macros.te	2005-06-14 09:53:24.000000000 -0400
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

--=-086A4dD5JEH7vgWix0kw--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
