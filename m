Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8DEIQmx029342
	for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2006 10:18:26 -0400
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8DEI02A024603
	for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2006 14:18:00 GMT
Subject: More policy changes from Debian
From: Erich Schubert <erich@debian.org>
To: selinux@tycho.nsa.gov
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>
Content-Type: multipart/mixed; boundary="=-AmBsKjxsCJZHNaKmVI91"
Date: Wed, 13 Sep 2006 16:18:18 +0200
Message-Id: <1158157098.1594.29.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-AmBsKjxsCJZHNaKmVI91
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached are three more diffs.
- moving logcheck from logrotate policy to logwatch. Seems more
appropriate.
Since logcheck runs as user logcheck, cron will search the home
directory.
I don't want cron to search the logrotate dirs.
- apt needs getattr_all_fs, to check for free diskspace.
- sxid wants to read the /etc/localtime symlink. I guess access to /etc
is okay.

best regards,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
    The infinite! No other question has ever moved so profoundly    //\
                the spirit of man. --- David Hilbert                V_/_
      Ein Freund ist ein Geschenk, das man sich selbst macht.

--=-AmBsKjxsCJZHNaKmVI91
Content-Disposition: attachment; filename=apt-getattr-fs
Content-Type: text/plain; name=apt-getattr-fs; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

# Needed to check for free diskspace.
Index: policy/modules/admin/apt.te
===================================================================
--- policy/modules/admin/apt.te	(Revision 245)
+++ policy/modules/admin/apt.te	(Revision 246)
@@ -97,7 +97,7 @@
 files_read_etc_files(apt_t)
 files_read_etc_runtime_files(apt_t)
 
-fs_dontaudit_getattr_all_fs(apt_t)
+fs_getattr_all_fs(apt_t)
 
 term_list_ptys(apt_t)
 term_use_all_terms(apt_t)

--=-AmBsKjxsCJZHNaKmVI91
Content-Disposition: attachment; filename=logcheck
Content-Type: text/plain; name=logcheck; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

# logcheck is more like logwatch than logrotate.
# cron needs to be able to getattr the logcheck home dir.
Index: policy/modules/services/cron.te
===================================================================
--- policy/modules/services/cron.te	(Revision 242)
+++ policy/modules/services/cron.te	(Arbeitskopie)
@@ -191,6 +191,13 @@
 	hal_dbus_send(crond_t)
 ')
 
+ifdef(`distro_debian', `
+	optional_policy(`
+		# Debian logcheck has the home dir set to its cache
+		logwatch_search_cache_dir(crond_t)
+	')
+')
+
 optional_policy(`
 	# cjp: why?
 	munin_search_lib(crond_t)
Index: policy/modules/admin/logwatch.te
===================================================================
--- policy/modules/admin/logwatch.te	(Revision 242)
+++ policy/modules/admin/logwatch.te	(Arbeitskopie)
@@ -15,6 +15,9 @@
 type logwatch_cache_t;
 files_type(logwatch_cache_t)
 
+type logwatch_lock_t;
+files_lock_file(logwatch_lock_t)
+
 type logwatch_tmp_t;
 files_tmp_file(logwatch_tmp_t)
 
@@ -27,6 +30,8 @@
 allow logwatch_t self:fifo_file rw_file_perms;
 allow logwatch_t self:unix_stream_socket create_stream_socket_perms;
 
+allow logwatch_t self:process signal;
+
 allow logwatch_t logwatch_cache_t:dir create_dir_perms;
 allow logwatch_t logwatch_cache_t:file create_file_perms;
 
@@ -34,6 +39,9 @@
 allow logwatch_t logwatch_tmp_t:file create_file_perms;
 files_tmp_filetrans(logwatch_t, logwatch_tmp_t, { file dir })
 
+allow logwatch_t logwatch_lock_t:file create_file_perms;
+files_lock_filetrans(logwatch_t,logwatch_lock_t,file)
+
 kernel_read_fs_sysctls(logwatch_t)
 kernel_read_kernel_sysctls(logwatch_t)
 kernel_read_system_state(logwatch_t)
@@ -41,7 +49,9 @@
 corecmd_read_sbin_symlinks(logwatch_t)
 corecmd_read_sbin_files(logwatch_t)
 corecmd_exec_bin(logwatch_t)
+corecmd_exec_sbin(logwatch_t)
 corecmd_exec_shell(logwatch_t)
+corecmd_exec_ls(logwatch_t)
 
 dev_read_urand(logwatch_t)
 
@@ -109,5 +119,9 @@
 ')
 
 optional_policy(`
+	hostname_exec(logwatch_t)
+')
+
+optional_policy(`
 	samba_read_log(logwatch_t)
 ')
Index: policy/modules/admin/logwatch.if
===================================================================
--- policy/modules/admin/logwatch.if	(Revision 242)
+++ policy/modules/admin/logwatch.if	(Arbeitskopie)
@@ -18,3 +18,21 @@
 	files_search_tmp($1)
 	allow $1 logwatch_tmp_t:file r_file_perms;
 ')
+
+########################################
+## <summary>
+##	Search logwatch cache directory.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`logwatch_search_cache_dir',`
+	gen_require(`
+		type logwatch_cache_t;
+	')
+
+	allow $1 logwatch_cache_t:dir search;
+')
Index: policy/modules/admin/logrotate.fc
===================================================================
--- policy/modules/admin/logrotate.fc	(Revision 242)
+++ policy/modules/admin/logrotate.fc	(Arbeitskopie)
@@ -1,13 +1,7 @@
 /etc/cron\.(daily|weekly)/sysklogd -- gen_context(system_u:object_r:logrotate_exec_t,s0)
 
-/usr/sbin/logcheck	--	gen_context(system_u:object_r:logrotate_exec_t,s0)
 /usr/sbin/logrotate	--	gen_context(system_u:object_r:logrotate_exec_t,s0)
 
-/var/lib/logcheck(/.*)?		gen_context(system_u:object_r:logrotate_var_lib_t,s0)
-
-# using a hard-coded name under /var/tmp is a bug - new version fixes it
-/var/tmp/logcheck	-d	gen_context(system_u:object_r:logrotate_tmp_t,s0)
-
 ifdef(`distro_debian', `
 /usr/bin/savelog	--	gen_context(system_u:object_r:logrotate_exec_t,s0)
 /var/lib/logrotate(/.*)?	gen_context(system_u:object_r:logrotate_var_lib_t,s0)
Index: policy/modules/admin/logwatch.fc
===================================================================
--- policy/modules/admin/logwatch.fc	(Revision 242)
+++ policy/modules/admin/logwatch.fc	(Arbeitskopie)
@@ -1,3 +1,4 @@
+/usr/sbin/logcheck	--	gen_context(system_u:object_r:logwatch_exec_t,s0)
 
 /usr/share/logwatch/scripts/logwatch\.pl	--	gen_context(system_u:object_r:logwatch_exec_t, s0)
 
@@ -2 +3,3 @@
 /var/cache/logwatch(/.*)?			gen_context(system_u:object_r:logwatch_cache_t, s0)
+/var/lib/logcheck(/.*)?		gen_context(system_u:object_r:logwatch_cache_t,s0)
+/var/log/logcheck/.+	--	gen_context(system_u:object_r:logwatch_lock_t,s0)

--=-AmBsKjxsCJZHNaKmVI91
Content-Disposition: attachment; filename=sxid-tweak
Content-Type: text/plain; name=sxid-tweak; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

# just for /etc/localtime symlink, but I mean... it's just etc_t
Index: policy/modules/admin/sxid.te
===================================================================
--- policy/modules/admin/sxid.te	(Revision 246)
+++ policy/modules/admin/sxid.te	(Revision 247)
@@ -57,6 +57,7 @@
 
 domain_use_interactive_fds(sxid_t)
 
+files_read_etc_files(sxid_t)
 files_list_all(sxid_t)
 files_getattr_all_symlinks(sxid_t)
 files_getattr_all_pipes(sxid_t)

--=-AmBsKjxsCJZHNaKmVI91--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
