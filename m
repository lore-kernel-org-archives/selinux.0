Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72IXmqw013893
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 14:33:48 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72IXmOD012505
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 18:33:48 GMT
Message-ID: <46B22385.30901@redhat.com>
Date: Thu, 02 Aug 2007 14:33:41 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: [Fwd: [PATCH] refpolicy: admin_kudzu changes]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


kudzu needs to ptrace init in order to setup init on first boot
Do not want to run kudzu unconfined anymore

--- nsaserefpolicy/policy/modules/admin/kudzu.te	2007-05-29 14:10:59.000000000 -0400
+++ serefpolicy-3.0.4/policy/modules/admin/kudzu.te	2007-07-25 12:27:26.000000000 -0400
@@ -21,8 +21,8 @@
 # Local policy
 #
 
-allow kudzu_t self:capability { dac_override sys_admin sys_rawio net_admin sys_tty_config mknod };
-dontaudit kudzu_t self:capability { sys_ptrace sys_tty_config };
+allow kudzu_t self:capability { dac_override sys_admin sys_ptrace sys_rawio net_admin sys_tty_config mknod };
+dontaudit kudzu_t self:capability sys_tty_config;
 allow kudzu_t self:process { signal_perms execmem };
 allow kudzu_t self:fifo_file rw_fifo_file_perms;
 allow kudzu_t self:unix_stream_socket { connectto create_stream_socket_perms };
@@ -103,6 +103,8 @@
 init_use_fds(kudzu_t)
 init_use_script_ptys(kudzu_t)
 init_stream_connect_script(kudzu_t)
+init_read_init_state(kudzu_t)
+init_ptrace_init_domain(kudzu_t)
 # kudzu will telinit to make init re-read
 # the inittab after configuring serial consoles
 init_telinit(kudzu_t)
@@ -141,15 +143,6 @@
         udev_read_db(kudzu_t)
 ')
 
-optional_policy(`
-	# cjp: this was originally in the else block
-	# of ifdef userhelper.te, but it seems to
-	# make more sense here.  also, require
-	# blocks curently do not work in the
-	# else block of optionals
-	unconfined_domain(kudzu_t)
-')
-
 ifdef(`TODO',`
 allow kudzu_t modules_conf_t:file unlink;
 optional_policy(`
--- nsaserefpolicy/policy/modules/system/init.if	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.4/policy/modules/system/init.if	2007-07-25 12:27:26.000000000 -0400
@@ -194,9 +194,13 @@
 	gen_require(`
 		type initrc_t;
 		role system_r;
+		attribute daemon;
 	')
 
-	application_domain($1,$2)
+	domain_type($1)
+	domain_entry_file($1,$2)
+
+	typeattribute $1 daemon;
 
 	role system_r types $1;
 
@@ -1250,7 +1254,7 @@
 		type initrc_var_run_t;
 	')
 
-	dontaudit $1 initrc_var_run_t:file { getattr read write append };
+	dontaudit $1 initrc_var_run_t:file rw_file_perms;
 ')
 
 ########################################
@@ -1271,3 +1275,42 @@
 	files_search_pids($1)
 	allow $1 initrc_var_run_t:file manage_file_perms;
 ')
+
+########################################
+## <summary>
+##	Read the process state (/proc/pid) of init.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`init_read_init_state',`
+	gen_require(`
+		attribute init_t;
+	')
+
+	allow $1 init_t:dir search_dir_perms;
+	allow $1 init_t:file r_file_perms;
+	allow $1 init_t:lnk_file r_file_perms;
+')
+
+########################################
+## <summary>
+##	Ptrace init
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`init_ptrace_init_domain',`
+	gen_require(`
+		attribute init_t;
+	')
+
+	allow $1 init_t:process ptrace;
+')


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
