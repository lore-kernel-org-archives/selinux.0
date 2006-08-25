Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7P0sLkr002430
	for <selinux@tycho.nsa.gov>; Thu, 24 Aug 2006 20:54:21 -0400
Received: from mail.atsec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7P0s3uc017732
	for <selinux@tycho.nsa.gov>; Fri, 25 Aug 2006 00:54:04 GMT
Date: Thu, 24 Aug 2006 19:55:12 -0500
From: Klaus Weidner <klaus@atsec.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Cc: redhat-lspp-list <redhat-lspp@redhat.com>
Subject: [PATCH] Add boolean controlling user access to kernel keyring
Message-ID: <20060825005512.GA17489@w-m-p.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds the boolean "allow_kernel_keyring_user_access" with the
goal of implementing an on/off switch for the kernel keyring as far as
unprivileged users are concerned. It defaults to true which corresponds
to the original behavior without this patch.

The reason for the patch is that the kernel keyring is a fairly complex
piece of code that would need testing and documentation if it were
available in the evaluated configuration for LSPP (labeled security
protection profile) compliant systems, and since it's unlikely to
currently be useful on those systems it would greatly simplify things to
have a way to disable the feature for unprivileged users at runtime.

This is untested (other than checking that the policy compiles and
toggling the boolean doesn't seem to do anything drastic), I don't
currently have any test programs available for the kernel keyring. If
someone can point me to something I'd be happy to verify it.

 policy/modules/kernel/kernel.if        |   10 ++++++++--
 policy/modules/kernel/kernel.te        |    3 +++
 policy/modules/services/remotelogin.te |    4 +++-
 policy/modules/services/xserver.te     |    8 ++++++--
 policy/modules/system/locallogin.te    |    4 +++-
 policy/modules/system/userdomain.if    |    5 ++++-
 6 files changed, 27 insertions(+), 7 deletions(-)

diff --minimal -r -uN serefpolicy-2.3.9.tar.gz.content.22833/policy/modules/kernel/kernel.if serefpolicy-2.3.9-hack/policy/modules/kernel/kernel.if
--- serefpolicy-2.3.9.tar.gz.content.22833/policy/modules/kernel/kernel.if	2006-08-24 13:29:15.000000000 -0500
+++ serefpolicy-2.3.9-hack/policy/modules/kernel/kernel.if	2006-08-24 19:47:09.000000000 -0500
@@ -1454,9 +1454,12 @@
 interface(`kernel_search_key',`
 	gen_require(`
 		type kernel_t;
+		bool allow_kernel_keyring_user_access;
 	')
 
-	allow $1 kernel_t:key search;
+	if (allow_kernel_keyring_user_access) {
+		allow $1 kernel_t:key search;
+	}
 ')
 
 ########################################
@@ -1472,9 +1475,12 @@
 interface(`kernel_link_key',`
 	gen_require(`
 		type kernel_t;
+		bool allow_kernel_keyring_user_access;
 	')
 
-	allow $1 kernel_t:key link;
+	if (allow_kernel_keyring_user_access) {
+		allow $1 kernel_t:key link;
+	}
 ')
 
 ########################################
diff --minimal -r -uN serefpolicy-2.3.9.tar.gz.content.22833/policy/modules/kernel/kernel.te serefpolicy-2.3.9-hack/policy/modules/kernel/kernel.te
--- serefpolicy-2.3.9.tar.gz.content.22833/policy/modules/kernel/kernel.te	2006-08-23 11:15:48.000000000 -0500
+++ serefpolicy-2.3.9-hack/policy/modules/kernel/kernel.te	2006-08-24 13:42:15.000000000 -0500
@@ -353,3 +353,6 @@
 allow kern_unconfined unlabeled_t:packet *;
 
 kernel_rw_all_sysctls(kern_unconfined)
+
+# Are non-admin users permitted to use the kernel keyring facility?
+bool allow_kernel_keyring_user_access true;
diff --minimal -r -uN serefpolicy-2.3.9.tar.gz.content.22833/policy/modules/services/remotelogin.te serefpolicy-2.3.9-hack/policy/modules/services/remotelogin.te
--- serefpolicy-2.3.9.tar.gz.content.22833/policy/modules/services/remotelogin.te	2006-08-23 11:16:14.000000000 -0500
+++ serefpolicy-2.3.9-hack/policy/modules/services/remotelogin.te	2006-08-24 19:22:46.000000000 -0500
@@ -33,7 +33,9 @@
 allow remote_login_t self:sem create_sem_perms;
 allow remote_login_t self:msgq create_msgq_perms;
 allow remote_login_t self:msg { send receive };
-allow remote_login_t self:key write;
+if (allow_kernel_keyring_user_access) {
+	allow remote_login_t self:key write;
+}
 
 allow remote_login_t remote_login_tmp_t:dir create_dir_perms;
 allow remote_login_t remote_login_tmp_t:file create_file_perms;
diff --minimal -r -uN serefpolicy-2.3.9.tar.gz.content.22833/policy/modules/services/xserver.te serefpolicy-2.3.9-hack/policy/modules/services/xserver.te
--- serefpolicy-2.3.9.tar.gz.content.22833/policy/modules/services/xserver.te	2006-08-24 13:29:15.000000000 -0500
+++ serefpolicy-2.3.9-hack/policy/modules/services/xserver.te	2006-08-24 19:25:09.000000000 -0500
@@ -83,7 +83,9 @@
 allow xdm_t self:capability { setgid setuid sys_resource kill sys_tty_config mknod chown dac_override dac_read_search fowner fsetid ipc_owner sys_nice sys_rawio net_bind_service };
 allow xdm_t self:process { setexec setpgid getsched setsched setrlimit signal_perms setkeycreate };
 allow xdm_t self:fifo_file rw_file_perms;
-allow xdm_t self:key link;
+if (allow_kernel_keyring_user_access) {
+	allow xdm_t self:key link;
+}
 allow xdm_t self:shm create_shm_perms;
 allow xdm_t self:sem create_sem_perms;
 allow xdm_t self:unix_stream_socket { connectto create_stream_socket_perms };
@@ -93,7 +95,9 @@
 allow xdm_t self:udp_socket create_socket_perms;
 allow xdm_t self:socket create_socket_perms;
 allow xdm_t self:appletalk_socket create_socket_perms;
-allow xdm_t self:key { search write };
+if (allow_kernel_keyring_user_access) {
+	allow xdm_t self:key { search write };
+}
 
 # Supress permission check on .ICE-unix
 dontaudit xdm_t ice_tmp_t:dir { getattr setattr };
diff --minimal -r -uN serefpolicy-2.3.9.tar.gz.content.22833/policy/modules/system/locallogin.te serefpolicy-2.3.9-hack/policy/modules/system/locallogin.te
--- serefpolicy-2.3.9.tar.gz.content.22833/policy/modules/system/locallogin.te	2006-08-24 13:29:15.000000000 -0500
+++ serefpolicy-2.3.9-hack/policy/modules/system/locallogin.te	2006-08-24 19:20:44.000000000 -0500
@@ -47,7 +47,9 @@
 allow local_login_t self:sem create_sem_perms;
 allow local_login_t self:msgq create_msgq_perms;
 allow local_login_t self:msg { send receive };
-allow local_login_t self:key { search write };
+if (allow_kernel_keyring_user_access) {
+	allow local_login_t self:key { search write };
+}
 
 allow local_login_t local_login_lock_t:file create_file_perms;
 files_lock_filetrans(local_login_t,local_login_lock_t,file)
diff --minimal -r -uN serefpolicy-2.3.9.tar.gz.content.22833/policy/modules/system/userdomain.if serefpolicy-2.3.9-hack/policy/modules/system/userdomain.if
--- serefpolicy-2.3.9.tar.gz.content.22833/policy/modules/system/userdomain.if	2006-08-24 13:29:15.000000000 -0500
+++ serefpolicy-2.3.9-hack/policy/modules/system/userdomain.if	2006-08-24 19:20:00.000000000 -0500
@@ -4748,9 +4748,12 @@
 	ifdef(`strict_policy',`
 		gen_require(`
 			attribute userdomain;
+			bool allow_kernel_keyring_user_access;
 		')
 
-		allow $1 userdomain:key create;
+		if (allow_kernel_keyring_user_access) {
+			allow $1 userdomain:key create;
+		}
 	',`
 		unconfined_create_keys($1)
 	')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
