Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NJdiVV006877
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 15:39:44 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NJdgsr010097
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 19:39:43 GMT
Message-ID: <46042CF3.2070906@redhat.com>
Date: Fri, 23 Mar 2007 15:39:31 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Remove unconfined_domain from ldconfig
Content-Type: multipart/mixed;
 boundary="------------010306090905050501080209"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010306090905050501080209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Removed textrel_shlib_t from all mozilla libraries.



--------------010306090905050501080209
Content-Type: text/x-patch;
 name="libraries.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libraries.patch"

--- nsaserefpolicy/policy/modules/system/libraries.fc	2007-03-01 10:01:49.000000000 -0500
+++ serefpolicy-2.5.10/policy/modules/system/libraries.fc	2007-03-22 15:06:59.000000000 -0400
@@ -202,12 +202,6 @@
 /usr/lib(64)?/.*/program/libsoffice\.so  --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/(.*/)?pcsc/drivers(/.*)?/lib(cm2020|cm4000|SCR24x)\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 
-/usr/lib(64)?/firefox.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib(64)?/mozilla.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib(64)?/seamonkey.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib(64)?/sunbird.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib(64)?/thunderbird.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-
 # Fedora Extras packages: ladspa, imlib2, ocaml
 /usr/lib(64)?/ladspa/analogue_osc_1416\.so --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/ladspa/bandpass_a_iir_1893\.so --	gen_context(system_u:object_r:textrel_shlib_t,s0)
--- nsaserefpolicy/policy/modules/system/libraries.te	2007-03-01 10:01:49.000000000 -0500
+++ serefpolicy-2.5.10/policy/modules/system/libraries.te	2007-03-22 15:08:18.000000000 -0400
@@ -51,6 +51,11 @@
 init_system_domain(ldconfig_t,ldconfig_exec_t)
 role system_r types ldconfig_t;
 
+type ldconfig_tmp_t;
+files_tmp_file(ldconfig_tmp_t)
+
+allow ldconfig_t self:capability sys_chroot;
+
 allow ldconfig_t ld_so_cache_t:file manage_file_perms;
 files_etc_filetrans(ldconfig_t,ld_so_cache_t,file)
 
@@ -74,6 +79,13 @@
 libs_use_ld_so(ldconfig_t)
 libs_use_shared_libs(ldconfig_t)
 
+manage_dirs_pattern(ldconfig_t,ldconfig_tmp_t,ldconfig_tmp_t)
+manage_files_pattern(ldconfig_t,ldconfig_tmp_t,ldconfig_tmp_t)
+files_tmp_filetrans(ldconfig_t, ldconfig_tmp_t, { file dir })
+files_read_generic_tmp_symlinks(ldconfig_t)
+
+miscfiles_read_localization(ldconfig_t)
+
 logging_send_syslog_msg(ldconfig_t)
 
 userdom_use_all_users_fds(ldconfig_t)
@@ -86,10 +98,16 @@
 
 ifdef(`targeted_policy',`
 	allow ldconfig_t lib_t:file read_file_perms;
-	unconfined_domain(ldconfig_t) 
+	term_dontaudit_use_generic_ptys(ldconfig_t)
+	term_dontaudit_use_unallocated_ttys(ldconfig_t)
 ')
 
 optional_policy(`
 	# dontaudit access to /usr/lib/apache, normal programs cannot read these libs anyway
 	apache_dontaudit_search_modules(ldconfig_t)
 ')
+
+optional_policy(`
+	rpm_manage_script_tmp_files(ldconfig_t)
+')
+

--------------010306090905050501080209--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
