Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA02691
	for <selinux@tycho.nsa.gov>; Mon, 16 Dec 2002 11:21:38 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gBGGLaI06316
	for <selinux@tycho.nsa.gov>; Mon, 16 Dec 2002 16:21:36 GMT
Received: from moss-sooners.epoch.ncsc.mil (moss-sooners.epoch.ncsc.mil [144.51.25.14])
        by jazzband.ncsc.mil  with ESMTP id gBGGLaf06312 for <selinux@tycho.nsa.gov>; Mon, 16 Dec 2002 16:21:36 GMT
Received: from moss-sooners.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-sooners.epoch.ncsc.mil (8.12.5/8.12.5) with ESMTP id gBGGOnDA001913
	for <selinux@tycho.nsa.gov>; Mon, 16 Dec 2002 11:24:49 -0500
Received: (from hdholm@localhost)
	by moss-sooners.epoch.ncsc.mil (8.12.5/8.12.5/Submit) id gBGGOmNU001911
	for selinux@tycho.nsa.gov; Mon, 16 Dec 2002 11:24:48 -0500
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA02161
	for <selinux@tycho.nsa.gov>; Mon, 16 Dec 2002 10:35:57 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA16751
	for <selinux@tycho.nsa.gov>; Mon, 16 Dec 2002 15:33:32 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id PAA16747
	for <selinux@tycho.nsa.gov>; Mon, 16 Dec 2002 15:33:30 GMT
Received: from moss-shockers.ncsc.mil (moss-shockers [144.51.25.21])
	by epoch.ncsc.mil (8.9.3/8.9.3) with SMTP id KAA02976
	for <selinux@tycho.nsa.gov>; Mon, 16 Dec 2002 10:35:50 -0500 (EST)
Message-Id: <200212161543.KAA00550@moss-shockers.ncsc.mil>
Date: Mon, 16 Dec 2002 10:43:16 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: [patch] Synchronize lsm-2.5 with lsm-2.5-bk
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY=Stare_of_Owls_334_000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Stare_of_Owls_334_000
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: sbVaqWYQGiqGvJwr4LEAPQ==


The first attached patch, also committed to the sourceforge CVS tree, 
synchronizes our lsm-2.5 tree with the head of the lsm-2.5 BitKeeper tree.
Note that one of these changes conflicts with the selinux-2.5.patch,
so revert that patch prior to applying.  An updated selinux-2.5.patch
is attached, and has been committed to the sourceforge CVS tree as well.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil

--Stare_of_Owls_334_000
Content-Type: TEXT/plain; name="lsm-2.5-bk.patch"; charset=us-ascii; x-unix-mode=0644
Content-Description: lsm-2.5-bk.patch
Content-MD5: nAW0f8OPMwUnL/Q4iHV9aA==

Index: lsm-2.5/security/Kconfig
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.5/security/Kconfig,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 Kconfig
--- lsm-2.5/security/Kconfig	13 Dec 2002 21:01:26 -0000	1.1.1.1
+++ lsm-2.5/security/Kconfig	16 Dec 2002 15:16:07 -0000
@@ -36,7 +36,7 @@
 
 config SECURITY_OWLSM
 	tristate "LSM port of Openwall (EXPERIMENTAL)"
-	depends EXPERIMENTAL
+	depends SECURITY && EXPERIMENTAL
 	help
 	  This enables the LSM port of the Openwall kernel patch.
 	  This is NOT official Openwall.  For more information on the
@@ -145,7 +145,7 @@
 
 config SECURITY_DTE
 	tristate "Domain and Type Enforcement (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends SECURITY && EXPERIMENTAL
 	help
 	  This enables Domain and Type Enforcement.  It assigns labels to
 	  files and processes.  File labels are called types, and process
Index: lsm-2.5/security/dummy.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.5/security/dummy.c,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 dummy.c
--- lsm-2.5/security/dummy.c	13 Dec 2002 21:01:26 -0000	1.1.1.7
+++ lsm-2.5/security/dummy.c	16 Dec 2002 15:16:07 -0000
@@ -722,15 +722,15 @@
 	return;
 }
 
-static int dummy_socket_unix_stream_connect (struct socket *sock,
-					     struct socket *other,
-					     struct sock *newsk)
+static int dummy_unix_stream_connect (struct socket *sock,
+				      struct socket *other,
+				      struct sock *newsk)
 {
 	return 0;
 }
 
-static int dummy_socket_unix_may_send (struct socket *sock,
-				       struct socket *other)
+static int dummy_unix_may_send (struct socket *sock,
+				struct socket *other)
 {
 	return 0;
 }
@@ -873,178 +873,7 @@
 	return -EINVAL;
 }
 
-struct security_operations dummy_security_ops = {
-	.sethostname =			dummy_sethostname,
-	.setdomainname =		dummy_setdomainname,
-	.reboot =			dummy_reboot,
-	.ioperm =			dummy_ioperm,
-	.iopl =				dummy_iopl,
-	.ptrace =			dummy_ptrace,
-	.capget =			dummy_capget,
-	.capset_check =			dummy_capset_check,
-	.capset_set =			dummy_capset_set,
-	.acct =				dummy_acct,
-	.capable =			dummy_capable,
-	.sysctl =			dummy_sysctl,
-	.swapon =			dummy_swapon,
-	.swapoff =			dummy_swapoff,
-	.quotactl =			dummy_quotactl,
-	.quota_on =			dummy_quota_on,
-	.syslog =			dummy_syslog,
-	.settime =			dummy_settime,
-
-	.netlink_send =			dummy_netlink_send,
-	.netlink_recv =			dummy_netlink_recv,
-
-	.unix_stream_connect =		dummy_socket_unix_stream_connect,
-	.unix_may_send =		dummy_socket_unix_may_send,
-
-	.bprm_alloc_security =		dummy_bprm_alloc_security,
-	.bprm_free_security =		dummy_bprm_free_security,
-	.bprm_compute_creds =		dummy_bprm_compute_creds,
-	.bprm_set_security =		dummy_bprm_set_security,
-	.bprm_check_security =		dummy_bprm_check_security,
-
-	.sb_alloc_security =		dummy_sb_alloc_security,
-	.sb_free_security =		dummy_sb_free_security,
-	.sb_kern_mount =		dummy_sb_kern_mount,
-	.sb_statfs =			dummy_sb_statfs,
-	.sb_mount =			dummy_sb_mount,
-	.sb_check_sb =			dummy_sb_check_sb,
-	.sb_umount =			dummy_sb_umount,
-	.sb_umount_close =		dummy_sb_umount_close,
-	.sb_umount_busy =		dummy_sb_umount_busy,
-	.sb_post_remount =		dummy_sb_post_remount,
-	.sb_post_mountroot =		dummy_sb_post_mountroot,
-	.sb_post_addmount =		dummy_sb_post_addmount,
-	.sb_pivotroot =			dummy_sb_pivotroot,
-	.sb_post_pivotroot =		dummy_sb_post_pivotroot,
-
-	.inode_alloc_security =		dummy_inode_alloc_security,
-	.inode_free_security =		dummy_inode_free_security,
-	.inode_create =			dummy_inode_create,
-	.inode_post_create =		dummy_inode_post_create,
-	.inode_link =			dummy_inode_link,
-	.inode_post_link =		dummy_inode_post_link,
-	.inode_unlink =			dummy_inode_unlink,
-	.inode_symlink =		dummy_inode_symlink,
-	.inode_post_symlink =		dummy_inode_post_symlink,
-	.inode_mkdir =			dummy_inode_mkdir,
-	.inode_post_mkdir =		dummy_inode_post_mkdir,
-	.inode_rmdir =			dummy_inode_rmdir,
-	.inode_mknod =			dummy_inode_mknod,
-	.inode_post_mknod =		dummy_inode_post_mknod,
-	.inode_rename =			dummy_inode_rename,
-	.inode_post_rename =		dummy_inode_post_rename,
-	.inode_readlink =		dummy_inode_readlink,
-	.inode_follow_link =		dummy_inode_follow_link,
-	.inode_permission =		dummy_inode_permission,
-	.inode_permission_lite =	dummy_inode_permission_lite,
-	.inode_setattr =		dummy_inode_setattr,
-	.inode_getattr =		dummy_inode_getattr,
-	.inode_post_lookup =		dummy_inode_post_lookup,
-	.inode_delete =			dummy_inode_delete,
-	.inode_setxattr =		dummy_inode_setxattr,
-	.inode_getxattr =		dummy_inode_getxattr,
-	.inode_listxattr =		dummy_inode_listxattr,
-	.inode_removexattr =		dummy_inode_removexattr,
-
-	.file_permission =		dummy_file_permission,
-	.file_alloc_security =		dummy_file_alloc_security,
-	.file_free_security =		dummy_file_free_security,
-	.file_ioctl =			dummy_file_ioctl,
-	.file_mmap =			dummy_file_mmap,
-	.file_mprotect =		dummy_file_mprotect,
-	.file_lock =			dummy_file_lock,
-	.file_fcntl =			dummy_file_fcntl,
-	.file_set_fowner =		dummy_file_set_fowner,
-	.file_send_sigiotask =		dummy_file_send_sigiotask,
-	.file_receive =			dummy_file_receive,
-
-	.task_create =			dummy_task_create,
-	.task_alloc_security =		dummy_task_alloc_security,
-	.task_free_security =		dummy_task_free_security,
-	.task_setuid =			dummy_task_setuid,
-	.task_post_setuid =		dummy_task_post_setuid,
-	.task_setgid =			dummy_task_setgid,
-	.task_setpgid =			dummy_task_setpgid,
-	.task_getpgid =			dummy_task_getpgid,
-	.task_getsid =			dummy_task_getsid,
-	.task_setgroups =		dummy_task_setgroups,
-	.task_setnice =			dummy_task_setnice,
-	.task_setrlimit =		dummy_task_setrlimit,
-	.task_setscheduler =		dummy_task_setscheduler,
-	.task_getscheduler =		dummy_task_getscheduler,
-	.task_wait =			dummy_task_wait,
-	.task_kill =			dummy_task_kill,
-	.task_prctl =			dummy_task_prctl,
-	.task_kmod_set_label =		dummy_task_kmod_set_label,
-	.task_reparent_to_init =	dummy_task_reparent_to_init,
-
-	.socket_create =		dummy_socket_create,
-	.socket_post_create =		dummy_socket_post_create,
-	.socket_bind =			dummy_socket_bind,
-	.socket_connect =		dummy_socket_connect,
-	.socket_listen =		dummy_socket_listen,
-	.socket_accept =		dummy_socket_accept,
-	.socket_post_accept =		dummy_socket_post_accept,
-	.socket_sendmsg =		dummy_socket_sendmsg,
-	.socket_recvmsg =		dummy_socket_recvmsg,
-	.socket_getsockname =		dummy_socket_getsockname,
-	.socket_getpeername =		dummy_socket_getpeername,
-	.socket_getsockopt =		dummy_socket_getsockopt,
-	.socket_setsockopt =		dummy_socket_setsockopt,
-	.socket_shutdown =		dummy_socket_shutdown,
-	.socket_sock_alloc_security =	dummy_socket_sock_alloc_security,
-	.socket_sock_free_security =	dummy_socket_sock_free_security,
-	.socket_sock_rcv_skb =		dummy_socket_sock_rcv_skb,
-	.open_request_alloc_security =	dummy_open_request_alloc_security,
-	.open_request_free_security =	dummy_open_request_free_security,
-	.tcp_connection_request =	dummy_tcp_connection_request,
-	.tcp_synack =			dummy_tcp_synack,
-	.tcp_create_openreq_child =	dummy_tcp_create_openreq_child,
-
-	.skb_alloc_security =		dummy_skb_alloc_security,
-	.skb_clone =			dummy_skb_clone,
-	.skb_copy =			dummy_skb_copy,
-	.skb_set_owner_w =		dummy_skb_set_owner_w,
-	.skb_recv_datagram =		dummy_skb_recv_datagram,
-	.skb_free_security =		dummy_skb_free_security,
-
-	.ip_fragment =			dummy_ip_fragment,
-	.ip_defragment =		dummy_ip_defragment,
-	.ip_encapsulate =		dummy_ip_encapsulate,
-	.ip_decapsulate =		dummy_ip_decapsulate,
-	.ip_decode_options =		dummy_ip_decode_options,
-
-	.ipc_permission =		dummy_ipc_permission,
-
-	.netdev_unregister =		dummy_netdev_unregister,
-
-	.msg_msg_alloc_security =	dummy_msg_msg_alloc_security,
-	.msg_msg_free_security =	dummy_msg_msg_free_security,
-
-	.msg_queue_alloc_security =	dummy_msg_queue_alloc_security,
-	.msg_queue_free_security =	dummy_msg_queue_free_security,
-	.msg_queue_associate =		dummy_msg_queue_associate,
-	.msg_queue_msgctl =		dummy_msg_queue_msgctl,
-	.msg_queue_msgsnd =		dummy_msg_queue_msgsnd,
-	.msg_queue_msgrcv =		dummy_msg_queue_msgrcv,
-
-	.shm_alloc_security =		dummy_shm_alloc_security,
-	.shm_free_security =		dummy_shm_free_security,
-	.shm_associate =		dummy_shm_associate,
-	.shm_shmctl =			dummy_shm_shmctl,
-	.shm_shmat =			dummy_shm_shmat,
-
-	.sem_alloc_security =		dummy_sem_alloc_security,
-	.sem_free_security =		dummy_sem_free_security,
-	.sem_associate =		dummy_sem_associate,
-	.sem_semctl =			dummy_sem_semctl,
-
-	.register_security =		dummy_register_security,
-	.unregister_security =		dummy_unregister_security,
-};
+struct security_operations dummy_security_ops;
 
 #define set_to_dummy_if_null(ops, function)				\
 	do {								\
@@ -1150,5 +979,65 @@
 	set_to_dummy_if_null(ops, sem_free_security);
 	set_to_dummy_if_null(ops, register_security);
 	set_to_dummy_if_null(ops, unregister_security);
+	set_to_dummy_if_null(ops, sethostname);
+	set_to_dummy_if_null(ops, setdomainname);
+	set_to_dummy_if_null(ops, reboot);
+	set_to_dummy_if_null(ops, ioperm);
+	set_to_dummy_if_null(ops, iopl);
+	set_to_dummy_if_null(ops, sysctl);
+	set_to_dummy_if_null(ops, swapon);
+	set_to_dummy_if_null(ops, swapoff);
+	set_to_dummy_if_null(ops, syslog);
+	set_to_dummy_if_null(ops, settime);
+	set_to_dummy_if_null(ops, netlink_send);
+	set_to_dummy_if_null(ops, netlink_recv);
+	set_to_dummy_if_null(ops, sb_kern_mount);
+	set_to_dummy_if_null(ops, ip_fragment);
+	set_to_dummy_if_null(ops, ip_defragment);
+	set_to_dummy_if_null(ops, ip_decapsulate);
+	set_to_dummy_if_null(ops, ip_encapsulate);
+	set_to_dummy_if_null(ops, ip_decode_options);
+	set_to_dummy_if_null(ops, netdev_unregister);
+	set_to_dummy_if_null(ops, socket_create);
+	set_to_dummy_if_null(ops, socket_post_create);
+	set_to_dummy_if_null(ops, socket_bind);
+	set_to_dummy_if_null(ops, socket_connect);
+	set_to_dummy_if_null(ops, socket_listen);
+	set_to_dummy_if_null(ops, socket_accept);
+	set_to_dummy_if_null(ops, socket_post_accept);
+	set_to_dummy_if_null(ops, socket_sendmsg);
+	set_to_dummy_if_null(ops, socket_recvmsg);
+	set_to_dummy_if_null(ops, socket_getsockname);
+	set_to_dummy_if_null(ops, socket_getpeername);
+	set_to_dummy_if_null(ops, socket_setsockopt);
+	set_to_dummy_if_null(ops, socket_getsockopt);
+	set_to_dummy_if_null(ops, socket_shutdown);
+	set_to_dummy_if_null(ops, socket_sock_alloc_security);
+	set_to_dummy_if_null(ops, socket_sock_free_security);
+	set_to_dummy_if_null(ops, socket_sock_rcv_skb);
+	set_to_dummy_if_null(ops, open_request_alloc_security);
+	set_to_dummy_if_null(ops, open_request_free_security);
+	set_to_dummy_if_null(ops, tcp_connection_request);
+	set_to_dummy_if_null(ops, tcp_synack);
+	set_to_dummy_if_null(ops, tcp_create_openreq_child);
+	set_to_dummy_if_null(ops, unix_stream_connect);
+	set_to_dummy_if_null(ops, unix_may_send);
+	set_to_dummy_if_null(ops, msg_msg_alloc_security);
+	set_to_dummy_if_null(ops, msg_msg_free_security);
+	set_to_dummy_if_null(ops, msg_queue_associate);
+	set_to_dummy_if_null(ops, msg_queue_msgctl);
+	set_to_dummy_if_null(ops, msg_queue_msgsnd);
+	set_to_dummy_if_null(ops, msg_queue_msgrcv);
+	set_to_dummy_if_null(ops, shm_associate);
+	set_to_dummy_if_null(ops, shm_shmctl);
+	set_to_dummy_if_null(ops, shm_shmat);
+	set_to_dummy_if_null(ops, sem_associate);
+	set_to_dummy_if_null(ops, sem_semctl);
+	set_to_dummy_if_null(ops, skb_alloc_security);
+	set_to_dummy_if_null(ops, skb_clone);
+	set_to_dummy_if_null(ops, skb_copy);
+	set_to_dummy_if_null(ops, skb_set_owner_w);
+	set_to_dummy_if_null(ops, skb_recv_datagram);
+	set_to_dummy_if_null(ops, skb_free_security);
 }
 
Index: lsm-2.5/security/owlsm.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.5/security/owlsm.c,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 owlsm.c
--- lsm-2.5/security/owlsm.c	13 Dec 2002 21:01:26 -0000	1.1.1.7
+++ lsm-2.5/security/owlsm.c	16 Dec 2002 15:16:07 -0000
@@ -30,63 +30,6 @@
 /* flag to keep track of how we were registered */
 static int secondary;
 
-static int owlsm_sethostname (char *hostname)
-{
-	return 0;
-}
-
-static int owlsm_setdomainname (char *domainname)
-{
-	return 0;
-}
-
-static int owlsm_reboot (unsigned int cmd)
-{
-	return 0;
-}
-
-static int owlsm_ioperm (unsigned long from, unsigned long num, int turn_on)
-{
-	return 0;
-}
-
-static int owlsm_iopl (unsigned int old, unsigned int level)
-{
-	return 0;
-}
-
-static int owlsm_ptrace (struct task_struct *parent, struct task_struct *child) 
-{ 
-	return 0; 
-}
-
-static int owlsm_capget (struct task_struct *target, kernel_cap_t * effective,
-                        kernel_cap_t * inheritable, kernel_cap_t * permitted)
-{
-	return 0;
-}
-
-static int owlsm_capset_check (struct task_struct *target,
-                             kernel_cap_t * effective,
-                             kernel_cap_t * inheritable,
-                             kernel_cap_t * permitted)
-{
-	return 0;
-}
-
-static void owlsm_capset_set (struct task_struct *target,
-                            kernel_cap_t * effective,
-                            kernel_cap_t * inheritable,
-                            kernel_cap_t * permitted)
-{
-	return;
-}
-
-static int owlsm_acct (struct file *file) 
-{
-	return 0;
-}
-
 static int owlsm_capable (struct task_struct *tsk, int cap)
 {
 	/* from dummy.c */
@@ -98,47 +41,6 @@
 	return -EPERM;
 }
 
-static int owlsm_sysctl (ctl_table * table, int op) 
-{
-	return 0;
-}
-
-static int owlsm_sys_security (unsigned int id, unsigned int call,
-                             unsigned long *args)
-{
-        return -ENOSYS;
-}
-
-static int owlsm_swapon (struct swap_info_struct *swap)
-{
-        return 0;
-}
-
-static int owlsm_swapoff (struct swap_info_struct *swap)
-{
-        return 0;
-}
-
-static int owlsm_quotactl (int cmds, int type, int id, struct super_block *sb)
-{
-        return 0;
-}
-
-static int owlsm_quota_on (struct file *f)
-{
-        return 0;
-}
-
-static int owlsm_syslog (int type)
-{
-        return 0;
-}
-
-static int owlsm_settime (struct timeval *tv, struct timezone *tz)
-{
-        return 0;
-}
-
 static int owlsm_netlink_send (struct sk_buff *skb)
 {
 	/* from dummy.c */
@@ -182,879 +84,54 @@
 	return do_owlsm_sfd_set(bprm);
 }
 
-static int owlsm_binprm_check_security (struct linux_binprm *bprm)
-{
-	return 0;
-}
-
-static int owlsm_sb_alloc_security (struct super_block *sb)
-{
-	return 0;
-}
-
-static void owlsm_sb_free_security (struct super_block *sb)
-{
-	return;
-}
-
-static int owlsm_sb_kern_mount (struct super_block *sb)
-{
-	return 0;
-}
-
-static int owlsm_sb_statfs (struct super_block *sb) 
-{
-	return 0;
-}
-
-static int owlsm_sb_mount (char *devname, struct nameidata *nd, char *type, 
-			  unsigned long flags, void *data) 
-{
-	return 0;
-}
-
-static int owlsm_sb_check_sb (struct vfsmount *mnt, struct nameidata *nd)
-{
-	return 0;
-}
-
-static int owlsm_sb_umount (struct vfsmount *mnt, int flags) 
-{
-	return 0;
-}
-
-static void owlsm_sb_umount_close (struct vfsmount *mnt)
-{
-	return;
-}
-
-static void owlsm_sb_umount_busy (struct vfsmount *mnt) 
-{
-	return;
-}
-static void owlsm_sb_post_remount (struct vfsmount *mnt, unsigned long flags, 
-				  void *data)
-{
-	return;
-}
-
-static void owlsm_sb_post_mountroot (void)
-{
-	return;
-}
-
-static void owlsm_sb_post_addmount (struct vfsmount *mnt, struct nameidata *nd)
-{
-	return;
-}
-
-static int owlsm_pivotroot (struct nameidata *old_nd, struct nameidata *new_nd)
-{
-	return 0;
-}
-
-static void owlsm_post_pivotroot (struct nameidata *old_nd, struct nameidata *new_nd)
-{
-	return;
-}
-
-static int owlsm_inode_alloc_security (struct inode *inode)
-{
-	return 0;
-}
-
-static void owlsm_inode_free_security (struct inode *inode)
-{
-	return;
-}
-
-static int owlsm_inode_create (struct inode *inode, struct dentry *dentry, 
-			      int mask) 
-{
-	return 0;
-}
-
-static void owlsm_inode_post_create (struct inode *inode, struct dentry *dentry,
-				    int mask) 
-{
-	return;
-}
-
 static int owlsm_inode_link (struct dentry *old_dentry, struct inode *inode, 
 			    struct dentry *new_dentry) 
 {
 	return do_owlsm_link(old_dentry, inode, new_dentry);
 }
 
-static void owlsm_inode_post_link (struct dentry *old_dentry, 
-				  struct inode *inode, 
-				  struct dentry *new_dentry) 
-{
-	return;
-}
-
-static int owlsm_inode_unlink (struct inode *inode, struct dentry *dentry)
-{
-	return 0;
-}
-
-static int owlsm_inode_symlink (struct inode *inode, struct dentry *dentry, 
-			       const char *name)
-{
-	return 0;
-}
-
-static void owlsm_inode_post_symlink (struct inode *inode, 
-				      struct dentry *dentry, const char *name)
-{
-	return;
-}
-
-static int owlsm_inode_mkdir (struct inode *inode, struct dentry *dentry, 
-			     int mask) 
-{
-	return 0;
-}
-
-static void owlsm_inode_post_mkdir (struct inode *inode, struct dentry *dentry, 
-				   int mask) 
-{
-	return;
-}
-
-static int owlsm_inode_rmdir (struct inode *inode, struct dentry *dentry) 
-{
-	return 0;
-}
-
-static int owlsm_inode_mknod (struct inode *inode, struct dentry *dentry, 
-			     int major, dev_t minor) 
-{
-	return 0;
-}
-
-static void owlsm_inode_post_mknod (struct inode *inode, struct dentry *dentry, 
-				   int major, dev_t minor)
-{
-	return;
-}
-
-static int owlsm_inode_rename (struct inode *old_inode, 
-			      struct dentry *old_dentry, 
-			      struct inode *new_inode, 
-			      struct dentry *new_dentry) 
-{
-	return 0;
-}
-
-static void owlsm_inode_post_rename (struct inode *old_inode, 
-				    struct dentry *old_dentry, 
-				    struct inode *new_inode, 
-				    struct dentry *new_dentry) 
-{
-	return;
-}
-
-static int owlsm_inode_readlink (struct dentry *dentry)
-{
-	return 0;
-}
-
 static int owlsm_inode_follow_link (struct dentry *dentry, 
 				   struct nameidata *nameidata) 
 {
 	return do_owlsm_follow_link(dentry, nameidata);
 }
 
-static int owlsm_inode_permission (struct inode *inode, int mask)
-{
-	return 0;
-}
-
-static int owlsm_inode_permission_lite (struct inode *inode, int mask)
-{
-	return 0;
-}
-
-static int owlsm_inode_setattr (struct dentry *dentry, struct iattr *iattr)
-{
-	return 0;
-}
-
-static int owlsm_inode_getattr (struct vfsmount *mnt, struct dentry *dentry)
-{
-	return 0;
-}
-
-static void owlsm_post_lookup (struct inode *ino, struct dentry *d) 
-{
-	return;
-}
-
-static void owlsm_delete (struct inode *ino) 
-{
-	return;
-}
-
-static int owlsm_inode_setxattr (struct dentry *dentry, char *name, void *value,
-				size_t size, int flags)
-{
-	return 0;
-}
-
-static int owlsm_inode_getxattr (struct dentry *dentry, char *name)
-{
-	return 0;
-}
-
-static int owlsm_inode_listxattr (struct dentry *dentry)
-{
-	return 0;
-}
-
-static int owlsm_inode_removexattr (struct dentry *dentry, char *name)
-{
-	return 0;
-}
-
-static int owlsm_file_permission (struct file *file, int mask)
-{
-	return 0;
+static void owlsm_task_reparent_to_init (struct task_struct *p) 
+{ 
+	p->euid = p->fsuid = 0;
+	return; 
 }
 
-static int owlsm_file_alloc_security (struct file *file)	
+static int owlsm_decode_options (struct sk_buff *skb, const char *optptr,
+				unsigned char **pp_ptr)
 {
+	/* from dummy.c */
+	if (!skb && !capable (CAP_NET_RAW)) {
+		(const unsigned char *) *pp_ptr = optptr;
+		return -EPERM;
+	}
 	return 0;
 }
 
-static void owlsm_file_free_security (struct file *file)	
-{
-	return;
-}
-
-static int owlsm_file_ioctl (struct file *file, unsigned int command , 
-			    unsigned long arg)
-{
-	return 0;
-}
 
-static int owlsm_file_mmap (struct file *file, unsigned long prot, 
-			   unsigned long flags)	
-{
-	return 0;
-}
+static struct security_operations owlsm_ops = {
+	capable:			owlsm_capable,
 
-static int owlsm_file_mprotect (struct vm_area_struct *vma, unsigned long prot)
-{
-	return 0;
-}
+	netlink_send:			owlsm_netlink_send,
+	netlink_recv:			owlsm_netlink_recv,
+	
+	bprm_alloc_security:		owlsm_binprm_alloc_security,
+	bprm_free_security:		owlsm_binprm_free_security,
+	bprm_compute_creds:		owlsm_binprm_compute_creds,
+	bprm_set_security:		owlsm_binprm_set_security,
+	
+	inode_link:			owlsm_inode_link,
 
-static int owlsm_file_lock (struct file *file, unsigned int cmd)
-{
-	return 0;
-}
+	inode_follow_link:		owlsm_inode_follow_link,
 
-static int owlsm_file_fcntl (struct file *file, unsigned int cmd, 
-			     unsigned long arg)
-{
-	return 0;
-}
+	task_reparent_to_init:		owlsm_task_reparent_to_init,
 
-static int owlsm_file_set_fowner (struct file *file)
-{
-	return 0;
-}
-
-static int owlsm_file_send_sigiotask (struct task_struct *tsk, 
-				      struct fown_struct *fown, 
-				      int fd, int reason) 
-{ 
-	return 0;
-}
-
-static int owlsm_file_receive (struct file *file)
-{
-	return 0;
-}
-
-static int owlsm_task_create (unsigned long clone_flags)
-{
-	return 0;
-}
-
-static int owlsm_task_alloc_security (struct task_struct *p)
-{
-	return 0;
-}
-
-static void owlsm_task_free_security (struct task_struct *p)
-{
-	return;
-}
-
-static int owlsm_task_setuid (uid_t id0, uid_t id1, uid_t id2, int flags)
-{ 
-	return 0; 
-}
-
-static int owlsm_task_post_setuid(uid_t old_ruid, uid_t old_euid, 
-				 uid_t old_suid, int flags)
-{
-	return 0;
-}
-
-static int owlsm_task_setgid (gid_t id0, gid_t id1, gid_t id2, int flags) 
-{
-	return 0;
-}
-
-static int owlsm_task_setpgid (struct task_struct *p, pid_t pgid) 
-{
-	return 0;
-}
-
-static int owlsm_task_getpgid (struct task_struct *p) 
-{
-	return 0;
-}
-
-static int owlsm_task_getsid (struct task_struct *p) 
-{
-	return 0;
-}
-
-static int owlsm_task_setgroups (int gidsetsize, gid_t *grouplist)
-{
-	return 0;
-}
-
-static int owlsm_task_setnice (struct task_struct *p, int nice)
-{
-	return 0;
-}
-
-static int owlsm_task_setrlimit (unsigned int resource, struct rlimit *new_rlim)
-{
-	return 0;
-}
-
-static int owlsm_task_setscheduler (struct task_struct *p, int policy,
-				   struct sched_param *lp)
-{
-	return 0;
-}
-
-static int owlsm_task_getscheduler (struct task_struct *p) 
-{ 
-	return 0; 
-}
-
-static int owlsm_task_wait (struct task_struct *p) 
-{
-	return 0;
-}
-
-static int owlsm_task_kill (struct task_struct *p, struct siginfo *info, int sig)
-{
-	return 0;
-}
-
-static int owlsm_task_prctl (int option, unsigned long arg2, unsigned long arg3,
-			     unsigned long arg4, unsigned long arg5)
-{
-	return 0;
-}
-
-static void owlsm_task_kmod_set_label (void) 
-{ 
-	return; 
-}
-
-static void owlsm_task_reparent_to_init (struct task_struct *p) 
-{ 
-	p->euid = p->fsuid = 0;
-	return; 
-}
-
-static void owlsm_ip_fragment (struct sk_buff *newskb, 
-			      const struct sk_buff *oldskb) 
-{
-	return;
-}
-
-static int owlsm_ip_defragment (struct sk_buff *skb) 
-{
-	return 0;
-}
-
-static void owlsm_ip_encapsulate (struct sk_buff *skb) 
-{
-	return;
-}
-
-static void owlsm_ip_decapsulate (struct sk_buff *skb) 
-{
-	return;
-}
-
-static int owlsm_decode_options (struct sk_buff *skb, const char *optptr,
-				unsigned char **pp_ptr)
-{
-	/* from dummy.c */
-	if (!skb && !capable (CAP_NET_RAW)) {
-		(const unsigned char *) *pp_ptr = optptr;
-		return -EPERM;
-	}
-	return 0;
-}
-
-static void owlsm_netdev_unregister (struct net_device *dev) 
-{
-	return;
-}
-
-static int owlsm_socket_create (int family, int type, int protocol) 
-{
-	return 0;
-}
-static void owlsm_socket_post_create (struct socket *sock, int family, 
-				      int type, int protocol) 
-{
-	return;
-}
-
-static int owlsm_socket_bind (struct socket *sock, struct sockaddr *address, 
-			      int addrlen) 
-{
-	return 0;
-}
-
-static int owlsm_socket_connect (struct socket *sock, struct sockaddr *address, 
-				 int addrlen) 
-{
-	return 0;
-}
-
-static int owlsm_socket_listen (struct socket *sock, int backlog) 
-{
-	return 0;
-}
-
-static int owlsm_socket_accept (struct socket *sock, struct socket *newsock) 
-{
-	return 0;
-}
-
-static void owlsm_socket_post_accept (struct socket *sock, 
-				      struct socket *newsock) 
-{
-	return;
-}
-
-static int owlsm_socket_sendmsg (struct socket *sock, struct msghdr *msg, 
-				int size) 
-{
-	return 0;
-}
-
-static int owlsm_socket_recvmsg (struct socket *sock, struct msghdr *msg, 
-				int size, int flags) 
-{
-	return 0;
-}
-
-static int owlsm_socket_getsockname (struct socket *sock) 
-{
-	return 0;
-}
-
-static int owlsm_socket_getpeername (struct socket *sock) 
-{
-	return 0;
-}
-
-static int owlsm_socket_setsockopt (struct socket *sock, int level, int optname)
-{
-	return 0;
-}
-
-static int owlsm_socket_getsockopt (struct socket *sock, int level, int optname)
-{
-	return 0;
-}
-
-static int owlsm_socket_shutdown (struct socket *sock, int how) 
-{
-	return 0;
-}
-
-static int owlsm_socket_sock_alloc_security(struct sock *sk, int gfp_mask)
-{
-	return 0;
-}
-
-static void owlsm_socket_sock_free_security(struct sock *sk)
-{
-	return;
-}
-
-static int owlsm_socket_sock_rcv_skb (struct sock *sk, struct sk_buff *skb)
-{
-	return 0;
-}
-
-static int owlsm_open_request_alloc_security(struct open_request * req)
-{
-	return 0;
-}
-
-static void owlsm_open_request_free_security(struct open_request * req)
-{
-	return;
-}
-
-static void owlsm_tcp_connection_request(struct sock *sk, struct sk_buff * skb, 
-					 struct open_request *req)
-{
-	return;
-}
-
-static void owlsm_tcp_synack(struct sock *sk, struct sk_buff * skb, 
-			     struct open_request *req)
-{
-	return;
-}
-
-static void owlsm_tcp_create_openreq_child(struct sock *sk, struct sock *newsk, 
-					   struct sk_buff *skb,
-					   struct open_request *req)
-{
-	return;
-}
-
-static int owlsm_socket_unix_stream_connect (struct socket *sock, 
-					     struct socket *other,
-					     struct sock *newsk)
-{
-	return 0;
-}
-
-static int owlsm_socket_unix_may_send (struct socket *sock, 
-				       struct socket *other)
-{
-	return 0;
-}
-
-static int owlsm_ipc_permission (struct kern_ipc_perm *ipcp, short flag) 
-{
-	return 0;
-}
-
-static int owlsm_msg_msg_alloc_security (struct msg_msg *msg)	
-{
-	return 0;
-}
-
-static void owlsm_msg_msg_free_security	(struct msg_msg *msg)
-{
-	return;
-}
-
-static int owlsm_msg_queue_alloc_security (struct msg_queue *msq)	
-{
-	return 0;
-}
-
-static void owlsm_msg_queue_free_security (struct msg_queue *msq)	
-{
-	return;
-}
-
-static int owlsm_msg_queue_associate (struct msg_queue *msq, 
-				     int msgflg)	
-{
-	return 0;
-}
-
-static int owlsm_msg_queue_msgctl (struct msg_queue *msq, int cmd)
-{
-	return 0;
-}
-
-static int owlsm_msg_queue_msgsnd (struct msg_queue *msq, struct msg_msg *msg, 
-				  int msgflg)
-{
-	return 0;
-}
-
-static int owlsm_msg_queue_msgrcv (struct msg_queue *msq, struct msg_msg *msg, 
-				  struct task_struct *target, 
-				  long type, int mode)
-{
-	return 0;
-}
-
-static int owlsm_shm_alloc_security (struct shmid_kernel *shp)
-{
-	return 0;
-}
-
-static void owlsm_shm_free_security (struct shmid_kernel *shp)
-{
-	return;
-}
-
-static int owlsm_shm_associate (struct shmid_kernel *shp, int shmflg)
-{
-	return 0;
-}
-
-static int owlsm_shm_shmctl (struct shmid_kernel *shp, int cmd)
-{
-	return 0;
-}
-
-static int owlsm_shm_shmat (struct shmid_kernel *shp, char *shmaddr, 
-			   int shmflg) 
-{
-	return 0;
-}
-
-static int owlsm_sem_alloc_security (struct sem_array *sma) 
-{
-	return 0;
-}
-
-static void owlsm_sem_free_security (struct sem_array *sma) 
-{
-	return;
-}
-
-static int owlsm_sem_associate (struct sem_array *sma, int semflg) 
-{
-	return 0;
-}
-
-static int owlsm_sem_semctl (struct sem_array *sma, int cmd) 
-{
-	return 0;
-}
-
-static int owlsm_skb_alloc_security (struct sk_buff *skb, int priority)
-{
-	return 0;
-}
-
-static int owlsm_skb_clone (struct sk_buff *newskb, 
-			    const struct sk_buff *oldskb)
-{
-	return 0;
-}
-
-static void owlsm_skb_copy (struct sk_buff *newskb, 
-			    const struct sk_buff *oldskb) 
-{
-	return;
-}
-
-static void owlsm_skb_set_owner_w (struct sk_buff *skb, struct sock *sk)
-{
-        return;
-}
-
-static void owlsm_skb_recv_datagram (struct sk_buff *skb, struct sock *sk,
-				     unsigned flags)
-{
-        return;
-}
-
-static void owlsm_skb_free_security (struct sk_buff *skb)
-{
-	return;
-}
-
-static int owlsm_register (const char *name, struct security_operations *ops)	
-{
-	return -EINVAL;
-}
-
-static int owlsm_unregister (const char *name, struct security_operations *ops)
-{
-	return -EINVAL;
-}
-
-static struct security_operations owlsm_ops = {
-	sethostname:			owlsm_sethostname,
-	setdomainname:			owlsm_setdomainname,
-	reboot:				owlsm_reboot,
-	ioperm:				owlsm_ioperm,
-	iopl:				owlsm_iopl,
-	ptrace:				owlsm_ptrace,
-	capget:				owlsm_capget,
-	capset_check:			owlsm_capset_check,
-	capset_set:			owlsm_capset_set,
-	acct:				owlsm_acct,
-	sysctl:				owlsm_sysctl,
-	capable:			owlsm_capable,
-	sys_security:			owlsm_sys_security,
-	swapon:				owlsm_swapon,
-	swapoff:			owlsm_swapoff,
-	quotactl:			owlsm_quotactl,
-	quota_on:			owlsm_quota_on,
-	syslog:				owlsm_syslog,
-	settime:                        owlsm_settime,
-
-	netlink_send:			owlsm_netlink_send,
-	netlink_recv:			owlsm_netlink_recv,
-	
-	unix_stream_connect:		owlsm_socket_unix_stream_connect,
-	unix_may_send:			owlsm_socket_unix_may_send,
-
-	bprm_alloc_security:		owlsm_binprm_alloc_security,
-	bprm_free_security:		owlsm_binprm_free_security,
-	bprm_compute_creds:		owlsm_binprm_compute_creds,
-	bprm_set_security:		owlsm_binprm_set_security,
-	bprm_check_security:		owlsm_binprm_check_security,
-	
-	sb_alloc_security:		owlsm_sb_alloc_security,
-	sb_free_security:		owlsm_sb_free_security,
-	sb_kern_mount:		        owlsm_sb_kern_mount,
-	sb_statfs:		        owlsm_sb_statfs,
-	sb_mount:			owlsm_sb_mount,
-	sb_check_sb:			owlsm_sb_check_sb,
-	sb_umount:			owlsm_sb_umount,
-	sb_umount_close:		owlsm_sb_umount_close,
-	sb_umount_busy:			owlsm_sb_umount_busy,
-	sb_post_remount:		owlsm_sb_post_remount,
-	sb_post_mountroot:		owlsm_sb_post_mountroot,
-	sb_post_addmount:		owlsm_sb_post_addmount,
-	sb_pivotroot:			owlsm_pivotroot,
-	sb_post_pivotroot:		owlsm_post_pivotroot,
-	
-	inode_alloc_security:		owlsm_inode_alloc_security,
-	inode_free_security:		owlsm_inode_free_security,
-	inode_create:			owlsm_inode_create,
-	inode_post_create:		owlsm_inode_post_create,
-	inode_link:			owlsm_inode_link,
-	inode_post_link:		owlsm_inode_post_link,
-	inode_unlink:			owlsm_inode_unlink,
-	inode_symlink:			owlsm_inode_symlink,
-	inode_post_symlink:		owlsm_inode_post_symlink,
-	inode_mkdir:			owlsm_inode_mkdir,
-	inode_post_mkdir:		owlsm_inode_post_mkdir,
-	inode_rmdir:			owlsm_inode_rmdir,
-	inode_mknod:			owlsm_inode_mknod,
-	inode_post_mknod:		owlsm_inode_post_mknod,
-	inode_rename:			owlsm_inode_rename,
-	inode_post_rename:		owlsm_inode_post_rename,
-	inode_readlink:			owlsm_inode_readlink,
-	inode_follow_link:		owlsm_inode_follow_link,
-	inode_permission:		owlsm_inode_permission,
-	inode_permission_lite:		owlsm_inode_permission_lite,
-	inode_setattr:			owlsm_inode_setattr,
-	inode_getattr:			owlsm_inode_getattr,
-	inode_post_lookup:		owlsm_post_lookup,
-	inode_delete:			owlsm_delete,
-	inode_setxattr:			owlsm_inode_setxattr,
-	inode_getxattr:			owlsm_inode_getxattr,
-	inode_listxattr:		owlsm_inode_listxattr,
-	inode_removexattr:		owlsm_inode_removexattr,
-	
-	file_permission:		owlsm_file_permission,
-	file_alloc_security:		owlsm_file_alloc_security,
-	file_free_security:		owlsm_file_free_security,
-	file_ioctl:			owlsm_file_ioctl,
-	file_mmap:			owlsm_file_mmap,
-	file_mprotect:			owlsm_file_mprotect,
-	file_lock:			owlsm_file_lock,
-	file_fcntl:			owlsm_file_fcntl,
-	file_set_fowner:		owlsm_file_set_fowner,
-	file_send_sigiotask:		owlsm_file_send_sigiotask,
-	file_receive:			owlsm_file_receive,
-	
-	task_create:			owlsm_task_create,
-	task_alloc_security:		owlsm_task_alloc_security,
-	task_free_security:		owlsm_task_free_security,
-	task_setuid:			owlsm_task_setuid,
-	task_post_setuid:		owlsm_task_post_setuid,
-	task_setgid:			owlsm_task_setgid,
-	task_setpgid:			owlsm_task_setpgid,
-	task_getpgid:			owlsm_task_getpgid,
-	task_getsid:			owlsm_task_getsid,
-	task_setgroups:			owlsm_task_setgroups,
-	task_setnice:			owlsm_task_setnice,
-	task_setrlimit:			owlsm_task_setrlimit,
-	task_setscheduler:		owlsm_task_setscheduler,
-	task_getscheduler:		owlsm_task_getscheduler,
-	task_wait:			owlsm_task_wait,
-	task_kill:			owlsm_task_kill,
-	task_prctl:			owlsm_task_prctl,
-	task_kmod_set_label:		owlsm_task_kmod_set_label,
-	task_reparent_to_init:		owlsm_task_reparent_to_init,
-
-	socket_create:			owlsm_socket_create,
-	socket_post_create:		owlsm_socket_post_create,
-	socket_bind:			owlsm_socket_bind,
-	socket_connect:			owlsm_socket_connect,
-	socket_listen:			owlsm_socket_listen,
-	socket_accept:			owlsm_socket_accept,
-	socket_post_accept:		owlsm_socket_post_accept,
-	socket_sendmsg:			owlsm_socket_sendmsg,
-	socket_recvmsg:			owlsm_socket_recvmsg,
-	socket_getsockname:		owlsm_socket_getsockname,
-	socket_getpeername:		owlsm_socket_getpeername,
-	socket_getsockopt:		owlsm_socket_getsockopt,
-	socket_setsockopt:		owlsm_socket_setsockopt,
-	socket_shutdown:		owlsm_socket_shutdown,
-	socket_sock_alloc_security:	owlsm_socket_sock_alloc_security,
-	socket_sock_free_security:	owlsm_socket_sock_free_security,
-	socket_sock_rcv_skb:		owlsm_socket_sock_rcv_skb,
-	open_request_alloc_security:	owlsm_open_request_alloc_security,
-	open_request_free_security:	owlsm_open_request_free_security,
-	tcp_connection_request:		owlsm_tcp_connection_request,
-	tcp_synack:			owlsm_tcp_synack,
-	tcp_create_openreq_child:	owlsm_tcp_create_openreq_child,
-	
-	skb_alloc_security:		owlsm_skb_alloc_security,
-	skb_clone:			owlsm_skb_clone,
-	skb_copy:			owlsm_skb_copy,
-	skb_set_owner_w:		owlsm_skb_set_owner_w,
-	skb_recv_datagram:		owlsm_skb_recv_datagram,
-	skb_free_security:		owlsm_skb_free_security,
-	
-	ip_fragment:			owlsm_ip_fragment,
-	ip_defragment:			owlsm_ip_defragment,
-	ip_encapsulate:			owlsm_ip_encapsulate,
-	ip_decapsulate:			owlsm_ip_decapsulate,
 	ip_decode_options:		owlsm_decode_options,
-
-	netdev_unregister:		owlsm_netdev_unregister,
-	
-	ipc_permission:			owlsm_ipc_permission,
-	
-	msg_msg_alloc_security:		owlsm_msg_msg_alloc_security,
-	msg_msg_free_security:		owlsm_msg_msg_free_security,
-
-	msg_queue_alloc_security:	owlsm_msg_queue_alloc_security,
-	msg_queue_free_security:	owlsm_msg_queue_free_security,
-	msg_queue_associate:		owlsm_msg_queue_associate,
-	msg_queue_msgctl:		owlsm_msg_queue_msgctl,
-	msg_queue_msgsnd:		owlsm_msg_queue_msgsnd,
-	msg_queue_msgrcv:		owlsm_msg_queue_msgrcv,
-
-	shm_alloc_security:		owlsm_shm_alloc_security,
-	shm_free_security:		owlsm_shm_free_security,
-	shm_associate:			owlsm_shm_associate,
-	shm_shmctl:			owlsm_shm_shmctl,
-	shm_shmat:			owlsm_shm_shmat,
-	
-	sem_alloc_security: 		owlsm_sem_alloc_security,
-	sem_free_security:		owlsm_sem_free_security,
-	sem_associate:			owlsm_sem_associate,
-	sem_semctl:			owlsm_sem_semctl,
-	
-	register_security:		owlsm_register,
-	unregister_security:		owlsm_unregister,
 };
 
 #if defined(CONFIG_SECURITY_owlsm_MODULE)
Index: lsm-2.5/security/security.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.5/security/security.c,v
retrieving revision 1.1.1.5
diff -u -r1.1.1.5 security.c
--- lsm-2.5/security/security.c	13 Dec 2002 21:01:26 -0000	1.1.1.5
+++ lsm-2.5/security/security.c	16 Dec 2002 15:16:07 -0000
@@ -48,6 +48,12 @@
 	printk (KERN_INFO "Security Scaffold v" SECURITY_SCAFFOLD_VERSION
 		" initialized\n");
 
+	if (verify (&dummy_security_ops)) {
+		printk (KERN_ERR "%s could not verify "
+			"dummy_security_ops structure.\n", __FUNCTION__);
+		return -EIO;
+	}
+
 	security_ops = &dummy_security_ops;
 
 	return 0;
Index: lsm-2.5/security/lids/Kconfig
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.5/security/lids/Kconfig,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 Kconfig
--- lsm-2.5/security/lids/Kconfig	13 Dec 2002 21:01:27 -0000	1.1.1.1
+++ lsm-2.5/security/lids/Kconfig	16 Dec 2002 15:16:08 -0000
@@ -2,12 +2,11 @@
 #	Kconfig for LIDS
 #
 
-menu "Linux Intrusion Detection System"
-
-if EXPERIMENTAL && SYSCTL
+if EXPERIMENTAL && SYSCTL && SECURITY
 
 config LIDS
 	tristate "Linux Intrusion Detection System support (EXPERIMENTAL)"
+	depends SECURITY && EXPERIMENTAL
 	help
 	  LIDS - Linux Intrusion Detection System can let you protect
 	  your linux kernel.
@@ -39,26 +38,25 @@
 
 if LIDS
 
-comment "Lids features"
-
 config LIDS_MAX_INODE 
 	int "Maximum protected objects to manage"
-	default 256
+	default 1024 
 
 config LIDS_MAX_SACL
 	int "Maximum ACL subjects to manage"
-	default 256
+	default 1024 
 
 config LIDS_MAX_OACL
 	int "Maximum ACL objects to manage"
-	default 256
+	default 1024 
 
 config LIDS_MAX_PROTECTED_PID
 	int "Maximum protected proceeds"
-	default 256
+	default 1024
 
 config LIDS_SA_EXEC_UP
 	bool "Security alert when execing unprotected programs before sealing LIDS"
+	default n
 	help
 	  Saying yes will generate a security alert for each unprotected
 	  program that is executed before LIDS is sealed (with lidsadm
@@ -71,6 +69,7 @@
 
 config LIDS_NO_EXEC_UP
 	bool "Do not execute unprotected programs before sealing LIDS"
+	default n
 	depends on LIDS_SA_EXEC_UP
 	help
 
@@ -87,6 +86,7 @@
 
 config LIDS_NO_FLOOD_LOG
 	bool "Attempt not to flood logs"
+	default y
 	help
 	  If you say Yes here, LIDS will try not to flood logs with the
 	  same message repeated a lot of times.
@@ -107,6 +107,7 @@
 
 config  LIDS_ALLOW_SWITCH
 	bool "Allow switching LIDS protections"
+	default y
 	help
 	  If you say Yes here, you will enable the possibility to switch
 	  LIDS on and off.
@@ -119,6 +120,7 @@
 
 config LIDS_RESTRICT_MODE_SWITCH
 	bool "Restrict mode switching to specified terminals" 
+	default n
 	help
 	  If you enable this option, mode switching will be only allowed
 	  from specified terminal types.
@@ -127,6 +129,7 @@
 
 config LIDS_MODE_SWITCH_CONSOLE
 	bool "Allow mode switching from a Linux Console"
+	default y
 	help
 	  Allow mode switching from a Linux Console.
 
@@ -161,20 +164,9 @@
 
 	  The higher it is, the more secure the system will be.
 
-config LIDS_ALLOW_ANY_PROG_SWITCH
-	bool "Allow any program to switch LIDS protections"
-	help
-	  If you say Yes here, you will allow programs others than
-	  /sbin/lidsadm to feed /proc/sys/lids/locks.
-  
-	  Notes : * It is strongly recommended to leave this option
-	            unmarked ! Don't say yes !
-	          * I don't know what it could be useful for :)
-
-	  Say no.
-
 config LIDS_RELOAD_CONF
 	bool "Allow reloading config. file"
+	default y 
 	help
 	  Saying Yes here will compile the necessary code to reload
 	  the config file. Each time you pass +RELOAD_CONF argument to
@@ -194,6 +186,7 @@
 
 config LIDS_SA_THROUGH_NET
 	bool "Send security alerts through network"
+	default n
 	help
 	  Say yes here if you want to send LIDS security alerts to a
 	  remote machine through the network, directly from the kernel,
@@ -261,11 +254,10 @@
 
 config LIDS_DEBUG
   bool "LIDS Debug"
+  default n
 
 # endif LIDS
 endif
 
 # endif EXPERIMENTAL && SYSCTL
 endif
-
-endmenu
Index: lsm-2.5/security/lids/lids_acl.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.5/security/lids/lids_acl.c,v
retrieving revision 1.1.1.6
diff -u -r1.1.1.6 lids_acl.c
--- lsm-2.5/security/lids/lids_acl.c	13 Dec 2002 21:01:27 -0000	1.1.1.6
+++ lsm-2.5/security/lids/lids_acl.c	16 Dec 2002 15:16:08 -0000
@@ -40,7 +40,7 @@
 
 #include <asm/namei.h>
 
-#include <linux/utime.h>
+#include <linux/time.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 
@@ -119,11 +119,7 @@
 			read_unlock(&tasklist_lock);
 			return 1;
 		}
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,7)
 		t=t->parent;
-#else
-		t=t->p_pptr;
-#endif
 	}
 	read_unlock(&tasklist_lock);
 	return 0;
@@ -200,7 +196,7 @@
 	struct lids_sys_acl *current_sys_acl = current->security;
 
 	if (!current_sys_acl) return -1;
-	return lids_time_checker(get_seconds()%(60*60*24), current_sys_acl->cap[cap].time);	
+	return lids_time_checker(get_seconds()%(60*60*24), current_sys_acl->cap[cap].time);
 	
 }
 /*
@@ -293,7 +289,7 @@
 		return -EPERM; 
 
 	ino = inode->i_ino;
-	dev = to_kdev_t(inode->i_dev);
+	dev = to_kdev_t(inode->i_sb->s_dev);
 
 	if (check_domain)
 		acl = current_sys_acl->lids_domain;
@@ -713,7 +709,7 @@
 	
 	while (dentry) {
 		if ((ino=dentry->d_inode)!=NULL)
-		    if ((retval=lids_search_inode(ino->i_ino,to_kdev_t(ino->i_dev),
+		    if ((retval=lids_search_inode(ino->i_ino,to_kdev_t(ino->i_sb->s_dev),
 			&lids_data[lids_curr&1])) >= 0) {
 			return (retval & flag) ? 0:
 				lids_check_acl(base,flag,lids_curr,0);
Index: lsm-2.5/security/lids/lids_exec.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.5/security/lids/lids_exec.c,v
retrieving revision 1.1.1.6
diff -u -r1.1.1.6 lids_exec.c
--- lsm-2.5/security/lids/lids_exec.c	13 Dec 2002 21:01:27 -0000	1.1.1.6
+++ lsm-2.5/security/lids/lids_exec.c	16 Dec 2002 15:16:08 -0000
@@ -128,8 +128,8 @@
 		dentry = bprm->file->f_dentry;
 		lids_security_alert("Attempt to give [%.128s] to privilegied program %.128s (dev %d:%d inode %ld)", 					
 			kaddr, bprm->filename,
-			MAJOR(dentry->d_inode->i_dev),
-			MINOR(dentry->d_inode->i_dev),
+			MAJOR(dentry->d_inode->i_sb->s_dev),
+			MINOR(dentry->d_inode->i_sb->s_dev),
 			dentry->d_inode->i_ino);
 	}
 	kfree(p);
@@ -158,15 +158,11 @@
 	struct lids_sys_acl *current_sys_acl = current->security;
 	struct dentry *dentry;
 	
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,7)
 	if(current->parent->pid == 0) return 0;
-#else
-	if(current->p_pptr->pid == 0) return 0;
-#endif
 
 	if(!bprm || !bprm->file) { printk("%s:BUG!\n",__FUNCTION__); return 0; }
 
-	LIDS_DBG("%s:##### pid %i exec [%s]\n",__FUNCTION__ ,current->pid,bprm->filename);
+	LIDS_DBG("%s:##### pid %i exec [%s]\n",__FUNCTION__,current->pid,bprm->filename);
 	dentry = bprm->file->f_dentry;
 	/* check if this program is protected or not */
 	if (lids_check_base(dentry,LIDS_APPEND)) {
@@ -180,7 +176,7 @@
 		
 		/* if it is protected, set the ACLs */
 		lids_get_task_acl(&current_acl, current);
-		new_sys_acl = lids_search_acl(dentry->d_inode->i_ino,to_kdev_t(dentry->d_inode->i_dev),lids_current);
+		new_sys_acl = lids_search_acl(dentry->d_inode->i_ino,to_kdev_t(dentry->d_inode->i_sb->s_dev),lids_current);
 
 		if (lids_compute_acls(&current_acl,new_sys_acl,&computed_acl) < 0) {
 			dput(dentry);
@@ -203,8 +199,8 @@
 #ifdef CONFIG_LIDS_NO_EXEC_UP
 			lids_security_alert("Attempt to exec unprotected program %s (dev %d:%d inode %ld) before sealing LIDS",
 					    bprm->filename,
-					    MAJOR(dentry->d_inode->i_dev),
-					    MINOR(dentry->d_inode->i_dev),
+					    MAJOR(dentry->d_inode->i_sb->s_dev),
+					    MINOR(dentry->d_inode->i_sb->s_dev),
 					    dentry->d_inode->i_ino);
 			if (dentry)
 				dput(dentry);
@@ -212,8 +208,8 @@
 #else
 			lids_security_alert("Exec'ed unprotected program %s (dev %d:%d inode %ld) before sealing LIDS",
 					    bprm->filename,
-					    MAJOR(dentry->d_inode->i_dev),
-					    MINOR(dentry->d_inode->i_dev),
+					    MAJOR(dentry->d_inode->i_sb->s_dev),
+					    MINOR(dentry->d_inode->i_sb->s_dev),
 					    dentry->d_inode->i_ino);
 #endif
 		}
@@ -222,7 +218,7 @@
 		/* maybe we need some locks here */
 		if (current_sys_acl) {
 			lids_get_task_acl(&current_acl, current);
-			new_sys_acl = lids_search_acl(dentry->d_inode->i_ino,to_kdev_t(dentry->d_inode->i_dev),lids_current);
+			new_sys_acl = lids_search_acl(dentry->d_inode->i_ino,to_kdev_t(dentry->d_inode->i_sb->s_dev),lids_current);
 			if (lids_compute_acls(&current_acl,new_sys_acl,&computed_acl) < 0) {
 				dput(dentry);
 				return -EPERM;
@@ -232,8 +228,8 @@
 			    || computed_acl.lids_sys_acl->flags ) {
 				lids_security_alert("Attempt to transmit privileges to an unprotected program (%s dev %d:%d inode %ld)",
 					bprm->filename,
-					MAJOR(dentry->d_inode->i_dev),
-					MINOR(dentry->d_inode->i_dev),
+					MAJOR(dentry->d_inode->i_sb->s_dev),
+					MINOR(dentry->d_inode->i_sb->s_dev),
 					dentry->d_inode->i_ino);
 			}
 			current_sys_acl->lids_cap=0;
@@ -254,11 +250,8 @@
 	struct lids_task_acl src,dst;
 
 	if(!tsk) {printk("%s: BUG\n", __FUNCTION__); return 0 ;}
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,7)
+
 	if(!tsk->parent->pid) return 0;
-#else
-	if(!tsk->p_pptr->pid) return 0;
-#endif
 	
 	lids_get_task_acl(&src, current);
 	if (lids_task_acl_deep_copy(&dst,&src) < 0) {
@@ -277,11 +270,7 @@
 	if(!task_sys_acl) return 0;
 	if ( cap_raised(task_sys_acl->lids_cap, CAP_PROTECTED) ) {
 		if (current->pid && (current->pid != p->pid) 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,7)
 			&& ((sig != SIGCHLD) || (current->parent->pid != p->pid))) {
-#else
-			&& ((sig != SIGCHLD) || (current->p_pptr->pid != p->pid))) {
-#endif
 			if (!capable(CAP_KILL_PROTECTED)) {
 				lids_security_alert("Attempt to kill pid=%d with sig=%d",p->pid,sig);
 				return -1;
Index: lsm-2.5/security/lids/lids_init.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.5/security/lids/lids_init.c,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 lids_init.c
--- lsm-2.5/security/lids/lids_init.c	26 Aug 2002 11:25:09 -0000	1.1.1.4
+++ lsm-2.5/security/lids/lids_init.c	16 Dec 2002 15:16:08 -0000
@@ -224,7 +224,7 @@
 			*ino=simple_strtoul(ino_str,0,0);
 			*dev= (kdev_t){simple_strtoul(dev_str,0,0)};
 			if ((*ino != d_file->d_inode->i_ino) ||
-			    (!kdev_same(*dev, to_kdev_t(d_file->d_inode->i_dev)))) {
+			    (!kdev_same(*dev, to_kdev_t(d_file->d_inode->i_sb->s_dev)))) {
 				LIDS_DBG("now=%p\n",d_file);
 				printk("LIDS: [%s] dev/inode in lids.conf seems wrong\n",q);
 			}
@@ -643,10 +643,8 @@
 	int	finished=0;
 	int	error = 0;
 	_lids_data_t *data=&lids_data[(lids_current&1)^1];
-#ifndef CONFIG_LIDS_ALLOW_ANY_PROG_SWITCH
 	struct dentry *dentry;
 	struct nameidata nd;
-#endif
 
 
 	/* Get lidsadm dev/inode */
@@ -666,14 +664,8 @@
 
 	memset(data->fastguess,0,sizeof(data->fastguess));
 
-#ifndef CONFIG_LIDS_ALLOW_ANY_PROG_SWITCH
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,6)
 	error = path_lookup(LIDS_ADM_PATH, LOOKUP_FOLLOW,&nd);
-#else
-	if (path_init(LIDS_ADM_PATH, LOOKUP_FOLLOW|LOOKUP_POSITIVE,&nd))
-		error = path_walk(LIDS_ADM_PATH,&nd);
-#endif
+
 	if (error)
 		return -1;
 	/*
@@ -689,7 +681,7 @@
   	}
 	else {
 		if (!dentry->d_inode ||
-		   !dentry->d_inode->i_dev ||
+		   !dentry->d_inode->i_sb->s_dev ||
 		   !dentry->d_inode->i_ino) {
 			printk("LIDS: something wrong with " LIDS_ADM_PATH "\n");
 			lidsadm.ino = 0;
@@ -697,11 +689,11 @@
 		}
 		else {
 			lidsadm.ino = dentry->d_inode->i_ino;
-			lidsadm.dev = to_kdev_t(dentry->d_inode->i_dev);
+			lidsadm.dev = to_kdev_t(dentry->d_inode->i_sb->s_dev);
 		}
 	}
 	path_release(&nd);
-#endif
+
 	/* Now, try to read lids.conf */
 
 /*	if ( init_add_file(LIDS_CONF_DIR,data) < 0 ) {
Index: lsm-2.5/security/lids/lids_logs.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.5/security/lids/lids_logs.c,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 lids_logs.c
--- lsm-2.5/security/lids/lids_logs.c	13 Dec 2002 21:01:27 -0000	1.1.1.4
+++ lsm-2.5/security/lids/lids_logs.c	16 Dec 2002 15:16:08 -0000
@@ -99,8 +99,8 @@
 		strncpy(progname,f_dentry->d_iname,63);
 		snprintf(proginfo,127,"%s (dev %d:%d inode %ld)",
 			 progname,
-			 MAJOR(f_dentry->d_inode->i_dev),
-			 MINOR(f_dentry->d_inode->i_dev),
+			 MAJOR(f_dentry->d_inode->i_sb->s_dev),
+			 MINOR(f_dentry->d_inode->i_sb->s_dev),
 			 f_dentry->d_inode->i_ino);
 	}
 	else {
@@ -110,11 +110,7 @@
 	/* Make the message string */
 	vsnprintf(msgstr,255,message,args);
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,7)
 	parent_pid = current->parent->pid;
-#else
-	parent_pid = current->p_pptr->pid,			
-#endif
 
 	/* Make the log string */
 	lids_print("LIDS: %s pid %d ppid %d uid/gid (%d/%d) on (%s) : %s %s\n", 
Index: lsm-2.5/security/lids/lids_lsm.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.5/security/lids/lids_lsm.c,v
retrieving revision 1.1.1.6
diff -u -r1.1.1.6 lids_lsm.c
--- lsm-2.5/security/lids/lids_lsm.c	13 Dec 2002 21:01:27 -0000	1.1.1.6
+++ lsm-2.5/security/lids/lids_lsm.c	16 Dec 2002 15:16:08 -0000
@@ -25,31 +25,6 @@
 
 struct security_operations *lids_secondary_ops;
 
-static int lids_sethostname (char *hostname)
-{
-	return 0;
-}
-
-static int lids_setdomainname (char *domainname)
-{
-	return 0;
-}
-
-static int lids_reboot (unsigned int cmd)
-{
-	return 0;
-}
-
-static int lids_ioperm (unsigned long from, unsigned long num, int turn_on)
-{
-	return 0;
-}
-
-static int lids_iopl (unsigned int old, unsigned int level)
-{
-	return 0;
-}
-
 static int lids_ptrace (struct task_struct *parent, struct task_struct *child)
 {
 	return 0;
@@ -96,27 +71,6 @@
 	return -EPERM;
 }
 
-static int lids_sysctl (ctl_table * table, int op)
-{
-	return 0;
-}
-
-static int lids_sys_security (unsigned int id, unsigned int call,
-			       unsigned long *args)
-{
-	return -ENOSYS;
-}
-
-static int lids_swapon (struct swap_info_struct *swap)
-{
-	return 0;
-}
-
-static int lids_swapoff (struct swap_info_struct *swap)
-{
-	return 0;
-}
-
 static int lids_quotactl (int cmds, int type, int id, struct super_block *sb)
 {
 	return 0;
@@ -127,33 +81,7 @@
 	return 0;
 }
 
-static int lids_syslog (int type)
-{
-	return 0;
-}
-
-static int lids_settime (struct timeval *tv, struct timezone *tz)
-{
-        return 0;
-}
-
-static int lids_netlink_send (struct sk_buff *skb)
-{
-	if (current->euid == 0)
-		cap_raise (NETLINK_CB (skb).eff_cap, CAP_NET_ADMIN);
-	else
-		NETLINK_CB (skb).eff_cap = 0;
-	return 0;
-}
-
-static int lids_netlink_recv (struct sk_buff *skb)
-{
-	if (!cap_raised (NETLINK_CB (skb).eff_cap, CAP_NET_ADMIN))
-		return -EPERM;
-	return 0;
-}
-
-static int lids_binprm_alloc_security (struct linux_binprm *bprm)
+static int lids_bprm_alloc_security (struct linux_binprm *bprm)
 {
 	int rc=0;
 
@@ -163,21 +91,21 @@
 	return rc;
 }
 
-static void lids_binprm_free_security (struct linux_binprm *bprm)
+static void lids_bprm_free_security (struct linux_binprm *bprm)
 {
 	if (lids_secondary_ops)
 		lids_secondary_ops->bprm_free_security(bprm);
 	return;
 }
 
-static void lids_binprm_compute_creds (struct linux_binprm *bprm)
+static void lids_bprm_compute_creds (struct linux_binprm *bprm)
 {
 	if (lids_secondary_ops)
 		lids_secondary_ops->bprm_compute_creds(bprm);
 	return;
 }
 
-static int lids_binprm_set_security (struct linux_binprm *bprm)
+static int lids_bprm_set_security (struct linux_binprm *bprm)
 {
 	int rc=0;
 
@@ -187,7 +115,7 @@
 	return rc;
 }
 
-static int lids_binprm_check_security (struct linux_binprm *bprm)
+static int lids_bprm_check_security (struct linux_binprm *bprm)
 {
 	/* do the do_execve here */
 	if(copy_lids_acls(bprm)) 
@@ -205,11 +133,6 @@
 	return;
 }
 
-static int lids_sb_kern_mount (struct super_block *sb)
-{
-	return 0;
-}
-
 static int lids_sb_statfs (struct super_block *sb)
 {
 	return 0;
@@ -513,7 +436,7 @@
 
 static int lids_inode_permission_lite (struct inode *inode, int mask)
 {
-	return -EAGAIN;
+	return 0;
 }
 
 static int lids_inode_setattr (struct dentry *dentry, struct iattr *iattr)
@@ -542,7 +465,6 @@
 	return;
 }
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,2)
 static int lids_inode_setxattr (struct dentry *dentry, char *name, void *value,
 				size_t size, int flags)
 {
@@ -563,7 +485,6 @@
 {
 	return 0;
 }
-#endif
 
 static int lids_file_permission (struct file *file, int mask)
 {
@@ -734,196 +655,15 @@
 
 static void lids_task_reparent_to_init (struct task_struct *p)
 {
+	p->euid = p->fsuid = 0;
 	return;
 }
 
-static void lids_ip_fragment (struct sk_buff *newskb,
-			       const struct sk_buff *oldskb)
-{
-	return;
-}
-
-static int lids_ip_defragment (struct sk_buff *skb)
-{
-	return 0;
-}
-
-static void lids_ip_decapsulate (struct sk_buff *skb)
-{
-	return;
-}
-
-static void lids_ip_encapsulate (struct sk_buff *skb)
-{
-	return;
-}
-
-static int lids_ip_decode_options (struct sk_buff *skb, const char *optptr,
-				    unsigned char **pp_ptr)
-{
-	if (!skb && !capable (CAP_NET_RAW)) {
-		(const unsigned char *) *pp_ptr = optptr;
-		return -EPERM;
-	}
-	return 0;
-}
-
-static void lids_netdev_unregister (struct net_device *dev)
-{
-	return;
-}
-
-static int lids_socket_create (int family, int type, int protocol)
-{
-	return 0;
-}
-
-static void lids_socket_post_create (struct socket *sock, int family, int type,
-				      int protocol)
-{
-	return;
-}
-
-static int lids_socket_bind (struct socket *sock, struct sockaddr *address,
-			      int addrlen)
-{
-	return 0;
-}
-
-static int lids_socket_connect (struct socket *sock, struct sockaddr *address,
-				 int addrlen)
-{
-	return 0;
-}
-
-static int lids_socket_listen (struct socket *sock, int backlog)
-{
-	return 0;
-}
-
-static int lids_socket_accept (struct socket *sock, struct socket *newsock)
-{
-	return 0;
-}
-
-static void lids_socket_post_accept (struct socket *sock, 
-				     struct socket *newsock)
-{
-	return;
-}
-
-static int lids_socket_sendmsg (struct socket *sock, struct msghdr *msg,
-				 int size)
-{
-	return 0;
-}
-
-static int lids_socket_recvmsg (struct socket *sock, struct msghdr *msg,
-				 int size, int flags)
-{
-	return 0;
-}
-
-static int lids_socket_getsockname (struct socket *sock)
-{
-	return 0;
-}
-
-static int lids_socket_getpeername (struct socket *sock)
-{
-	return 0;
-}
-
-static int lids_socket_setsockopt (struct socket *sock, int level, int optname)
-{
-	return 0;
-}
-
-static int lids_socket_getsockopt (struct socket *sock, int level, int optname)
-{
-	return 0;
-}
-
-static int lids_socket_shutdown (struct socket *sock, int how)
-{
-	return 0;
-}
-
-static int lids_socket_sock_alloc_security (struct sock *sk, int gfp_mask)
-{
-	return 0;
-}
-
-static void lids_socket_sock_free_security (struct sock *sk)
-{
-	return;
-}
-
-static int lids_sock_rcv_skb (struct sock *sk, struct sk_buff *skb)
-{
-	return 0;
-}
-
-static int lids_open_request_alloc_security (struct open_request *req)
-{
-	return 0;
-}
-
-static void lids_open_request_free_security (struct open_request *req)
-{
-	return;
-}
-
-static void lids_tcp_connection_request (struct sock *sk,
-				 	 struct sk_buff *skb,
-					 struct open_request *req)
-{
-	return;
-}
-
-static void lids_tcp_synack (struct sock *sk, struct sk_buff *skb,
-			     struct open_request *req)
-{
-	return;
-}
-
-
-static void lids_tcp_create_openreq_child (struct sock *sk,
-					   struct sock *newsk,
-					   struct sk_buff *skb,
-					   struct open_request *req)
-{
-	return;
-}
-
-static int lids_socket_unix_stream_connect (struct socket *sock,
-					    struct socket *other,
-					    struct sock *newsk)
-{
-	return 0;
-}
-
-static int lids_socket_unix_may_send (struct socket *sock,
-				      struct socket *other)
-{
-	return 0;
-}
-
 static int lids_ipc_permission (struct kern_ipc_perm *ipcp, short flag)
 {
 	return 0;
 }
 
-static int lids_msg_msg_alloc_security (struct msg_msg *msg)
-{
-	return 0;
-}
-
-static void lids_msg_msg_free_security (struct msg_msg *msg)
-{
-	return;
-}
-
 static int lids_msg_queue_alloc_security (struct msg_queue *msq)
 {
 	return 0;
@@ -934,30 +674,6 @@
 	return;
 }
 
-static int lids_msg_queue_associate (struct msg_queue *msq, 
-				      int msqflg)
-{
-	return 0;
-}
-
-static int lids_msg_queue_msgctl (struct msg_queue *msq, int cmd)
-{
-	return 0;
-}
-
-static int lids_msg_queue_msgsnd (struct msg_queue *msq, struct msg_msg *msg,
-				   int msgflg)
-{
-	return 0;
-}
-
-static int lids_msg_queue_msgrcv (struct msg_queue *msq, struct msg_msg *msg,
-				   struct task_struct *target, long type,
-				   int mode)
-{
-	return 0;
-}
-
 static int lids_shm_alloc_security (struct shmid_kernel *shp)
 {
 	return 0;
@@ -968,22 +684,6 @@
 	return;
 }
 
-static int lids_shm_associate (struct shmid_kernel *shp, int shmflg)
-{
-	return 0;
-}
-
-static int lids_shm_shmctl (struct shmid_kernel *shp, int cmd)
-{
-	return 0;
-}
-
-static int lids_shm_shmat (struct shmid_kernel *shp, char *shmaddr,
-			    int shmflg)
-{
-	return 0;
-}
-
 static int lids_sem_alloc_security (struct sem_array *sma)
 {
 	return 0;
@@ -994,49 +694,6 @@
 	return;
 }
 
-static int lids_sem_associate (struct sem_array *sma, int semflg)
-{
-	return 0;
-}
-
-static int lids_sem_semctl (struct sem_array *sma, int cmd)
-{
-	return 0;
-}
-
-static int lids_skb_alloc_security (struct sk_buff *skb, int gfp_mask)
-{
-	return 0;
-}
-
-static int lids_skb_clone (struct sk_buff *newskb,
-			     const struct sk_buff *oldskb)
-{
-	return 0;
-}
-
-static void lids_skb_copy (struct sk_buff *newskb,
-			    const struct sk_buff *oldskb)
-{
-	return;
-}
-
-static void lids_skb_set_owner_w (struct sk_buff *skb, struct sock *sk)
-{
-	return;
-}
-
-static void lids_skb_recv_datagram (struct sk_buff *skb, struct sock *sk,
-				    unsigned flags)
-{
-	return;
-}
-
-static void lids_skb_free_security (struct sk_buff *skb)
-{
-	return;
-}
-
 static int lids_register (const char *name, struct security_operations *ops)
 {
 	if (lids_secondary_ops !=NULL) {
@@ -1058,7 +715,6 @@
 		printk(KERN_NOTICE "LIDS: no secondary module %s.\n", name);
 		return -EINVAL;
 	}else if (ops == lids_secondary_ops) {
-		lids_secondary_ops = NULL;
 		printk(KERN_NOTICE "LIDS: unregistering module %s.\n", name);
 		return 0;
 	}
@@ -1067,179 +723,109 @@
 }
 
 struct security_operations lids_security_ops = {
-	sethostname:			lids_sethostname,
-	setdomainname:			lids_setdomainname,
-	reboot:				lids_reboot,
-	ioperm:				lids_ioperm,
-	iopl:				lids_iopl,
-	ptrace:				lids_ptrace,
-	capget:				lids_capget,
-	capset_check:			lids_capset_check,
-	capset_set:			lids_capset_set,
-	acct:				lids_acct,
-	capable:			lids_capable,
-	sysctl:				lids_sysctl,
-	sys_security:			lids_sys_security,
-	swapon:				lids_swapon,
-	swapoff:			lids_swapoff,
-	quotactl:			lids_quotactl,
-	quota_on:			lids_quota_on,
-	syslog:				lids_syslog,
-	settime:                        lids_settime,
-	
-	netlink_send:			lids_netlink_send,
-	netlink_recv:			lids_netlink_recv,
-	
-	unix_stream_connect:		lids_socket_unix_stream_connect,
-	unix_may_send:			lids_socket_unix_may_send,
-
-	bprm_alloc_security:		lids_binprm_alloc_security,
-	bprm_free_security:		lids_binprm_free_security,
-	bprm_compute_creds:		lids_binprm_compute_creds,
-	bprm_set_security:		lids_binprm_set_security,
-	bprm_check_security:		lids_binprm_check_security,
+	.ptrace =			lids_ptrace,
+	.capget =			lids_capget,
+	.capset_check =			lids_capset_check,
+	.capset_set =			lids_capset_set,
+	.acct =				lids_acct,
+	.capable =			lids_capable,
+	.quotactl =			lids_quotactl,
+	.quota_on =			lids_quota_on,
+
+	.bprm_alloc_security =		lids_bprm_alloc_security,
+	.bprm_free_security =		lids_bprm_free_security,
+	.bprm_compute_creds =		lids_bprm_compute_creds,
+	.bprm_set_security =		lids_bprm_set_security,
+	.bprm_check_security =		lids_bprm_check_security,
+
+	.sb_alloc_security =		lids_sb_alloc_security,
+	.sb_free_security =		lids_sb_free_security,
+	.sb_statfs =			lids_sb_statfs,
+	.sb_mount =			lids_mount,
+	.sb_check_sb =			lids_check_sb,
+	.sb_umount =			lids_umount,
+	.sb_umount_close =		lids_umount_close,
+	.sb_umount_busy =		lids_umount_busy,
+	.sb_post_remount =		lids_post_remount,
+	.sb_post_mountroot =		lids_post_mountroot,
+	.sb_post_addmount =		lids_post_addmount,
+	.sb_pivotroot =			lids_pivotroot,
+	.sb_post_pivotroot =		lids_post_pivotroot,
+	
+	.inode_alloc_security =		lids_inode_alloc_security,
+	.inode_free_security =		lids_inode_free_security,
+	.inode_create =			lids_inode_create,
+	.inode_post_create =		lids_inode_post_create,
+	.inode_link =			lids_inode_link,
+	.inode_post_link =		lids_inode_post_link,
+	.inode_unlink =			lids_inode_unlink,
+	.inode_symlink =		lids_inode_symlink,
+	.inode_post_symlink =		lids_inode_post_symlink,
+	.inode_mkdir =			lids_inode_mkdir,
+	.inode_post_mkdir =		lids_inode_post_mkdir,
+	.inode_rmdir =			lids_inode_rmdir,
+	.inode_mknod =			lids_inode_mknod,
+	.inode_post_mknod =		lids_inode_post_mknod,
+	.inode_rename =			lids_inode_rename,
+	.inode_post_rename =		lids_inode_post_rename,
+	.inode_readlink =		lids_inode_readlink,
+	.inode_follow_link =		lids_inode_follow_link,
+	.inode_permission =		lids_inode_permission,
+	.inode_permission_lite =	lids_inode_permission_lite,
+	.inode_setattr =		lids_inode_setattr,
+	.inode_getattr =		lids_inode_getattr,
+	.inode_post_lookup =		lids_post_lookup,
+	.inode_delete =			lids_delete,
+	.inode_setxattr =		lids_inode_setxattr,
+	.inode_getxattr =		lids_inode_getxattr,
+	.inode_listxattr =		lids_inode_listxattr,
+	.inode_removexattr =		lids_inode_removexattr,
+
+	.file_permission =		lids_file_permission,
+	.file_alloc_security =		lids_file_alloc_security,
+	.file_free_security =		lids_file_free_security,
+	.file_ioctl =			lids_file_ioctl,
+	.file_mmap =			lids_file_mmap,
+	.file_mprotect =		lids_file_mprotect,
+	.file_lock =			lids_file_lock,
+	.file_fcntl =			lids_file_fcntl,
+	.file_set_fowner =		lids_file_set_fowner,
+	.file_send_sigiotask =		lids_file_send_sigiotask,
+	.file_receive =			lids_file_receive,
+
+	.task_create =			lids_task_create,
+	.task_alloc_security =		lids_task_alloc_security,
+	.task_free_security =		lids_task_free_security,
+	.task_setuid =			lids_task_setuid,
+	.task_post_setuid =		lids_task_post_setuid,
+	.task_setgid =			lids_task_setgid,
+	.task_setpgid =			lids_task_setpgid,
+	.task_getpgid =			lids_task_getpgid,
+	.task_getsid =			lids_task_getsid,
+	.task_setgroups =		lids_task_setgroups,
+	.task_setnice =			lids_task_setnice,
+	.task_setrlimit =		lids_task_setrlimit,
+	.task_setscheduler =		lids_task_setscheduler,
+	.task_getscheduler =		lids_task_getscheduler,
+	.task_wait =			lids_task_wait,
+	.task_kill =			lids_task_kill,
+	.task_prctl =			lids_task_prctl,
+	.task_kmod_set_label =		lids_task_kmod_set_label,
+	.task_reparent_to_init =	lids_task_reparent_to_init,
+
+	.ipc_permission =		lids_ipc_permission,
+	
+	.msg_queue_alloc_security =	lids_msg_queue_alloc_security,
+	.msg_queue_free_security =	lids_msg_queue_free_security,
 	
-	sb_alloc_security:		lids_sb_alloc_security,
-	sb_free_security:		lids_sb_free_security,
-	sb_kern_mount:                  lids_sb_kern_mount,
-	sb_statfs:			lids_sb_statfs,
-	sb_mount:			lids_mount,
-	sb_check_sb:			lids_check_sb,
-	sb_umount:			lids_umount,
-	sb_umount_close:		lids_umount_close,
-	sb_umount_busy:			lids_umount_busy,
-	sb_post_remount:		lids_post_remount,
-	sb_post_mountroot:		lids_post_mountroot,
-	sb_post_addmount:		lids_post_addmount,
-	sb_pivotroot:			lids_pivotroot,
-	sb_post_pivotroot:		lids_post_pivotroot,
+	.shm_alloc_security =		lids_shm_alloc_security,
+	.shm_free_security =		lids_shm_free_security,
 	
-	inode_alloc_security:		lids_inode_alloc_security,
-	inode_free_security:		lids_inode_free_security,
-	inode_create:			lids_inode_create,
-	inode_post_create:		lids_inode_post_create,
-	inode_link:			lids_inode_link,
-	inode_post_link:		lids_inode_post_link,
-	inode_unlink:			lids_inode_unlink,
-	inode_symlink:			lids_inode_symlink,
-	inode_post_symlink:		lids_inode_post_symlink,
-	inode_mkdir:			lids_inode_mkdir,
-	inode_post_mkdir:		lids_inode_post_mkdir,
-	inode_rmdir:			lids_inode_rmdir,
-	inode_mknod:			lids_inode_mknod,
-	inode_post_mknod:		lids_inode_post_mknod,
-	inode_rename:			lids_inode_rename,
-	inode_post_rename:		lids_inode_post_rename,
-	inode_readlink:			lids_inode_readlink,
-	inode_follow_link:		lids_inode_follow_link,
-	inode_permission:		lids_inode_permission,
-	inode_permission_lite:		lids_inode_permission_lite,
-	inode_setattr:			lids_inode_setattr,
-	inode_getattr:			lids_inode_getattr,
-	inode_post_lookup:		lids_post_lookup,
-	inode_delete:			lids_delete,
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,2)
-	inode_setxattr:			lids_inode_setxattr,
-	inode_getxattr:			lids_inode_getxattr,
-	inode_listxattr:		lids_inode_listxattr,
-	inode_removexattr:		lids_inode_removexattr,
-#endif
-
-	file_permission:		lids_file_permission,
-	file_alloc_security:		lids_file_alloc_security,
-	file_free_security:		lids_file_free_security,
-	file_ioctl:			lids_file_ioctl,
-	file_mmap:			lids_file_mmap,
-	file_mprotect:			lids_file_mprotect,
-	file_lock:			lids_file_lock,
-	file_fcntl:			lids_file_fcntl,
-	file_set_fowner:		lids_file_set_fowner,
-	file_send_sigiotask:		lids_file_send_sigiotask,
-	file_receive:			lids_file_receive,
-	
-	task_create:			lids_task_create,
-	task_alloc_security:		lids_task_alloc_security,
-	task_free_security:		lids_task_free_security,
-	task_setuid:			lids_task_setuid,
-	task_post_setuid:		lids_task_post_setuid,
-	task_setgid:			lids_task_setgid,
-	task_setpgid:			lids_task_setpgid,
-	task_getpgid:			lids_task_getpgid,
-	task_getsid:			lids_task_getsid,
-	task_setgroups:			lids_task_setgroups,
-	task_setnice:			lids_task_setnice,
-	task_setrlimit:			lids_task_setrlimit,
-	task_setscheduler:		lids_task_setscheduler,
-	task_getscheduler:		lids_task_getscheduler,
-	task_wait:			lids_task_wait,
-	task_kill:			lids_task_kill,
-	task_prctl:			lids_task_prctl,
-	task_kmod_set_label:		lids_task_kmod_set_label,
-	task_reparent_to_init:		lids_task_reparent_to_init,
-
-	socket_create:			lids_socket_create,
-	socket_post_create:		lids_socket_post_create,
-	socket_bind:			lids_socket_bind,
-	socket_connect:			lids_socket_connect,
-	socket_listen:			lids_socket_listen,
-	socket_accept:			lids_socket_accept,
-	socket_post_accept:		lids_socket_post_accept,
-	socket_sendmsg:			lids_socket_sendmsg,
-	socket_recvmsg:			lids_socket_recvmsg,
-	socket_getsockname:		lids_socket_getsockname,
-	socket_getpeername:		lids_socket_getpeername,
-	socket_getsockopt:		lids_socket_getsockopt,
-	socket_setsockopt:		lids_socket_setsockopt,
-	socket_shutdown:		lids_socket_shutdown,
-	socket_sock_alloc_security:	lids_socket_sock_alloc_security,
-	socket_sock_free_security:	lids_socket_sock_free_security,
-	socket_sock_rcv_skb:		lids_sock_rcv_skb,
-	open_request_alloc_security:	lids_open_request_alloc_security,
-	open_request_free_security:	lids_open_request_free_security,
-	tcp_connection_request:		lids_tcp_connection_request,
-	tcp_synack:			lids_tcp_synack,
-	tcp_create_openreq_child:	lids_tcp_create_openreq_child,
-
-	skb_alloc_security:		lids_skb_alloc_security,
-	skb_clone:			lids_skb_clone,
-	skb_copy:			lids_skb_copy,
-	skb_set_owner_w:		lids_skb_set_owner_w,
-	skb_recv_datagram:		lids_skb_recv_datagram,
-	skb_free_security:		lids_skb_free_security,
-
-	ip_fragment:			lids_ip_fragment,
-	ip_defragment:			lids_ip_defragment,
-	ip_encapsulate:			lids_ip_encapsulate,
-	ip_decapsulate:			lids_ip_decapsulate,
-	ip_decode_options:		lids_ip_decode_options,
-	
-	ipc_permission:			lids_ipc_permission,
-	
-	netdev_unregister:		lids_netdev_unregister,
-	
-	msg_msg_alloc_security:		lids_msg_msg_alloc_security,
-	msg_msg_free_security:		lids_msg_msg_free_security,
+	.sem_alloc_security =		lids_sem_alloc_security,
+	.sem_free_security =		lids_sem_free_security,
 
-	msg_queue_alloc_security:	lids_msg_queue_alloc_security,
-	msg_queue_free_security:	lids_msg_queue_free_security,
-	msg_queue_associate:		lids_msg_queue_associate,
-	msg_queue_msgctl:		lids_msg_queue_msgctl,
-	msg_queue_msgsnd:		lids_msg_queue_msgsnd,
-	msg_queue_msgrcv:		lids_msg_queue_msgrcv,
-
-	shm_alloc_security:		lids_shm_alloc_security,
-	shm_free_security:		lids_shm_free_security,
-	shm_associate:			lids_shm_associate,
-	shm_shmctl:			lids_shm_shmctl,
-	shm_shmat:			lids_shm_shmat,	
-	
-	sem_alloc_security:		lids_sem_alloc_security,
-	sem_free_security:		lids_sem_free_security,
-	sem_associate:			lids_sem_associate,
-	sem_semctl:			lids_sem_semctl,
-	
-	register_security:		lids_register,
-	unregister_security:		lids_unregister,
+	.register_security =		lids_register,
+	.unregister_security =		lids_unregister,
 };
 
 extern void setup_lids_module(void);
Index: lsm-2.5/security/lids/lids_sysctl.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.5/security/lids/lids_sysctl.c,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 lids_sysctl.c
--- lsm-2.5/security/lids/lids_sysctl.c	26 Aug 2002 11:25:09 -0000	1.1.1.3
+++ lsm-2.5/security/lids/lids_sysctl.c	16 Dec 2002 15:16:08 -0000
@@ -45,9 +45,7 @@
 
 
 
-#ifndef CONFIG_LIDS_ALLOW_ANY_PROG_SWITCH
 struct allowed_ino lidsadm;
-#endif
 
 
 /***********************************************************************
@@ -115,17 +113,23 @@
 			lids_flag_lower(lids_flags,LIDS_FLAGS_LIDS_ON);
 	}
 	if ( lids_local_on != (lids_flag_raised(flags,LIDS_FLAGS_LIDS_LOCAL_ON) != 0) ) {
+	#if 1
+		lids_load=(lids_flag_raised(flags,LIDS_FLAGS_LIDS_LOCAL_ON) != 0);
+		lids_security_alert("LIDS switched to %i",lids_load);
+		if (lids_load)
+			lids_flag_raise(lids_flags,LIDS_FLAGS_LIDS_LOCAL_ON);
+		else
+			lids_flag_lower(lids_flags,LIDS_FLAGS_LIDS_LOCAL_ON);
+	#endif
+	#if 0
 		lids_local_on=(lids_flag_raised(flags,LIDS_FLAGS_LIDS_LOCAL_ON) != 0);   /* XXX: Race condition here. We must first assign the PID */
 		lids_security_alert("LIDS locally switched to %i",lids_local_on);
 		if (lids_local_on) {
 			lids_flag_raise(lids_flags,LIDS_FLAGS_LIDS_LOCAL_ON);
 		}
 		else {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,7)
 			lids_local_pid=current->parent->pid;
-#else
-			lids_local_pid=current->p_pptr->pid;
-#endif
+
 			if (lids_local_pid == 1) {  /* this doesn't apply to init */
 				printk("Can't give local lids deactivation to init!!\n");
 				lids_flag_raise(lids_flags,LIDS_FLAGS_LIDS_LOCAL_ON);
@@ -134,6 +138,7 @@
 			else
 				lids_flag_lower(lids_flags,LIDS_FLAGS_LIDS_LOCAL_ON); /* should not be necessary */			
 		}
+	#endif
 	}
 #else
 	if  (!lids_flag_raised(flags,LIDS_FLAGS_LIDS_ON)) {
@@ -226,7 +231,6 @@
 	}
 #endif /* CONFIG_LIDS_RESTRICT_MODE_SWITCH */
 
-#ifndef CONFIG_LIDS_ALLOW_ANY_PROG_SWITCH
 	{
 		struct vm_area_struct * vma;
 		unsigned long ino;
@@ -241,7 +245,7 @@
 				    vma->vm_file && vma->vm_file->f_dentry && 
 				    vma->vm_file->f_dentry->d_inode) {
 					ino=vma->vm_file->f_dentry->d_inode->i_ino;
-					dev=HASHDEV(to_kdev_t(vma->vm_file->f_dentry->d_inode->i_dev));
+					dev=HASHDEV(to_kdev_t(vma->vm_file->f_dentry->d_inode->i_sb->s_dev));
 					break;
 				}
 				vma = vma->vm_next;
@@ -253,7 +257,6 @@
 			return -EPERM;
 		}
 	}
-#endif
 	/* second: check wether it is not a timeout period after two many failed attempts */
 
 	if (wait_after_fail) {
Index: lsm-2.5/security/lids/include/linux/lids.h
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.5/security/lids/include/linux/lids.h,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 lids.h
--- lsm-2.5/security/lids/include/linux/lids.h	26 Aug 2002 11:25:09 -0000	1.1.1.3
+++ lsm-2.5/security/lids/include/linux/lids.h	16 Dec 2002 15:16:08 -0000
@@ -10,6 +10,7 @@
 #include <linux/sysctl.h>
 #include <linux/slab.h>
 #include <linux/tty.h>
+#include <linux/binfmts.h>
 
 #include "lidsext.h"
 #include "lidsif.h"
@@ -18,7 +19,7 @@
 #define KERNEL_VERSION(x,y,z) (((x)<<16)+((y)<<8)+(z))
 #endif
 
-#define LIDS_VERSION	"2.0.1pre4"
+#define LIDS_VERSION	"2.0.2pre2"
 /* FIXME: some more externals in kernel/signal.c and kernel/sysctl.c */
 
 typedef struct
Index: lsm-2.5/security/lids/include/linux/lidsext.h
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.5/security/lids/include/linux/lidsext.h,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 lidsext.h
--- lsm-2.5/security/lids/include/linux/lidsext.h	13 Dec 2002 21:01:27 -0000	1.1.1.2
+++ lsm-2.5/security/lids/include/linux/lidsext.h	16 Dec 2002 15:16:08 -0000
@@ -29,7 +29,7 @@
 #define LIDS_STR(X) LIDS_STR2(X)
 
 #ifdef LIDS_DEBUG
-#define LIDS_DBG(format, args...)  printk(KERN_DEBUG "LIDS.%s.l" LIDS_STR(__LINE__) ": " format, __FUNCTION__ ,  ##args)
+#define LIDS_DBG(msg...)  printk(KERN_DEBUG "LIDS." __FUNCTION__ ".l" LIDS_STR(__LINE__) ": " ##msg)
 #else
 #define LIDS_DBG(msg...)
 #endif

--Stare_of_Owls_334_000
Content-Type: TEXT/plain; name="selinux-2.5.patch"; charset=us-ascii; x-unix-mode=0644
Content-Description: selinux-2.5.patch
Content-MD5: rzeWWyj/sNyMMGUBLbXsaw==

Index: lsm-2.5/Makefile
===================================================================
RCS file: /home/pal/CVS/lsm-2.5/Makefile,v
retrieving revision 1.42
diff -u -r1.42 Makefile
--- lsm-2.5/Makefile	10 Dec 2002 14:38:47 -0000	1.42
+++ lsm-2.5/Makefile	16 Dec 2002 15:23:47 -0000
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 5
 SUBLEVEL = 51
-EXTRAVERSION = -lsm1
+EXTRAVERSION = -selinux
 
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"
Index: lsm-2.5/arch/i386/defconfig
===================================================================
RCS file: /home/pal/CVS/lsm-2.5/arch/i386/defconfig,v
retrieving revision 1.1.1.18
diff -u -r1.1.1.18 defconfig
--- lsm-2.5/arch/i386/defconfig	21 Oct 2002 20:40:23 -0000	1.1.1.18
+++ lsm-2.5/arch/i386/defconfig	16 Dec 2002 15:23:47 -0000
@@ -401,7 +401,7 @@
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 # CONFIG_NETLINK_DEV is not set
-# CONFIG_NETFILTER is not set
+CONFIG_NETFILTER=y
 # CONFIG_FILTER is not set
 CONFIG_UNIX=y
 CONFIG_INET=y
@@ -1169,3 +1169,13 @@
 CONFIG_X86_SMP=y
 CONFIG_X86_HT=y
 CONFIG_X86_BIOS_REBOOT=y
+
+#
+# Security options
+#
+CONFIG_SECURITY=y
+CONFIG_SECURITY_CAPABILITIES=y
+CONFIG_SECURITY_SELINUX=y
+CONFIG_SECURITY_SELINUX_DEVELOP=y
+CONFIG_SECURITY_SELINUX_NSID=y
+CONFIG_SECURITY_SELINUX_SELOPT=y
Index: lsm-2.5/fs/dcache.c
===================================================================
RCS file: /home/pal/CVS/lsm-2.5/fs/dcache.c,v
retrieving revision 1.1.1.18
diff -u -r1.1.1.18 dcache.c
--- lsm-2.5/fs/dcache.c	25 Nov 2002 13:30:33 -0000	1.1.1.18
+++ lsm-2.5/fs/dcache.c	16 Dec 2002 15:23:47 -0000
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <asm/uaccess.h>
+#include <linux/security.h>
 
 #define DCACHE_PARANOIA 1
 /* #define DCACHE_DEBUG 1 */
@@ -699,6 +700,8 @@
 void d_instantiate(struct dentry *entry, struct inode * inode)
 {
 	if (!list_empty(&entry->d_alias)) BUG();
+	if (inode)
+		security_inode_init(inode);
 	spin_lock(&dcache_lock);
 	if (inode)
 		list_add(&entry->d_alias, &inode->i_dentry);
Index: lsm-2.5/fs/pipe.c
===================================================================
RCS file: /home/pal/CVS/lsm-2.5/fs/pipe.c,v
retrieving revision 1.1.1.12
diff -u -r1.1.1.12 pipe.c
--- lsm-2.5/fs/pipe.c	19 Nov 2002 14:18:29 -0000	1.1.1.12
+++ lsm-2.5/fs/pipe.c	16 Dec 2002 15:23:47 -0000
@@ -15,6 +15,7 @@
 #include <linux/pipe_fs_i.h>
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
+#include <linux/security.h>
 
 /*
  * We use a start+len construction, which provides full use of the 
@@ -529,6 +530,7 @@
 	inode->i_gid = current->fsgid;
 	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 	inode->i_blksize = PAGE_SIZE;
+	security_inode_init(inode);
 	return inode;
 
 fail_iput:
Index: lsm-2.5/fs/devpts/inode.c
===================================================================
RCS file: /home/pal/CVS/lsm-2.5/fs/devpts/inode.c,v
retrieving revision 1.1.1.9
diff -u -r1.1.1.9 inode.c
--- lsm-2.5/fs/devpts/inode.c	19 Nov 2002 14:20:22 -0000	1.1.1.9
+++ lsm-2.5/fs/devpts/inode.c	16 Dec 2002 15:23:47 -0000
@@ -16,6 +16,7 @@
 #include <linux/sched.h>
 #include <linux/namei.h>
 #include <linux/mount.h>
+#include <linux/security.h>
 
 #define DEVPTS_SUPER_MAGIC 0x1cd1
 
@@ -142,6 +143,7 @@
 	inode->i_gid = config.setgid ? config.gid : current->fsgid;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	init_special_inode(inode, S_IFCHR|config.mode, device);
+	security_inode_init(inode);
 
 	dentry = get_node(number);
 	if (!IS_ERR(dentry) && !dentry->d_inode)
Index: lsm-2.5/include/linux/security.h
===================================================================
RCS file: /home/pal/CVS/lsm-2.5/include/linux/security.h,v
retrieving revision 1.30
diff -u -r1.30 security.h
--- lsm-2.5/include/linux/security.h	4 Dec 2002 21:58:27 -0000	1.30
+++ lsm-2.5/include/linux/security.h	16 Dec 2002 15:23:47 -0000
@@ -1205,6 +1205,7 @@
 
 	int (*inode_alloc_security) (struct inode *inode);	
 	void (*inode_free_security) (struct inode *inode);
+ 	void (*inode_init) (struct inode * inode);
 	int (*inode_create) (struct inode *dir,
 	                     struct dentry *dentry, int mode);
 	void (*inode_post_create) (struct inode *dir,
@@ -1613,6 +1614,11 @@
 {
 	security_ops->inode_free_security (inode);
 }
+
+static inline void security_inode_init (struct inode *inode)
+{
+	security_ops->inode_init (inode);
+}
 	
 static inline int security_inode_create (struct inode *dir,
 					 struct dentry *dentry,
@@ -2480,6 +2486,9 @@
 }
 
 static inline void security_inode_free (struct inode *inode)
+{ }
+
+static inline void security_inode_init (struct inode *inode)
 { }
 	
 static inline int security_inode_create (struct inode *dir,
Index: lsm-2.5/init/main.c
===================================================================
RCS file: /home/pal/CVS/lsm-2.5/init/main.c,v
retrieving revision 1.23
diff -u -r1.23 main.c
--- lsm-2.5/init/main.c	10 Dec 2002 14:39:02 -0000	1.23
+++ lsm-2.5/init/main.c	16 Dec 2002 15:23:47 -0000
@@ -370,6 +370,10 @@
  	cpu_idle();
 } 
 
+#ifdef CONFIG_SECURITY_SELINUX 
+extern void selinux_init(void);
+#endif
+
 /*
  *	Activate the first processor.
  */
@@ -425,6 +429,9 @@
 	fork_init(num_physpages);
 	proc_caches_init();
 	security_scaffolding_startup();
+#ifdef CONFIG_SECURITY_SELINUX
+	selinux_init();
+#endif
 	buffer_init();
 	vfs_caches_init(num_physpages);
 	radix_tree_init();
Index: lsm-2.5/mm/shmem.c
===================================================================
RCS file: /home/pal/CVS/lsm-2.5/mm/shmem.c,v
retrieving revision 1.1.1.22
diff -u -r1.1.1.22 shmem.c
--- lsm-2.5/mm/shmem.c	25 Nov 2002 13:35:14 -0000	1.1.1.22
+++ lsm-2.5/mm/shmem.c	16 Dec 2002 15:23:47 -0000
@@ -31,6 +31,7 @@
 #include <linux/backing-dev.h>
 #include <linux/shmem_fs.h>
 #include <linux/mount.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 
@@ -1058,6 +1059,7 @@
 		case S_IFLNK:
 			break;
 		}
+ 		security_inode_init(inode);
 	}
 	return inode;
 }
Index: lsm-2.5/net/netsyms.c
===================================================================
RCS file: /home/pal/CVS/lsm-2.5/net/netsyms.c,v
retrieving revision 1.1.1.18
diff -u -r1.1.1.18 netsyms.c
--- lsm-2.5/net/netsyms.c	10 Dec 2002 14:02:35 -0000	1.1.1.18
+++ lsm-2.5/net/netsyms.c	16 Dec 2002 15:23:47 -0000
@@ -324,7 +324,8 @@
 EXPORT_SYMBOL(xfrm_policy_list);
 
 
-#if defined (CONFIG_IPV6_MODULE) || defined (CONFIG_IP_SCTP_MODULE)
+#if defined (CONFIG_IPV6_MODULE) || defined (CONFIG_IP_SCTP_MODULE) || defined (CONFIG_SECURITY_SELINUX_SELOPT_MODULE)
+extern struct tcp_func  ipv4_specific;
 /* inet functions common to v4 and v6 */
 EXPORT_SYMBOL(inet_release);
 EXPORT_SYMBOL(inet_stream_connect);
Index: lsm-2.5/security/dummy.c
===================================================================
RCS file: /home/pal/CVS/lsm-2.5/security/dummy.c,v
retrieving revision 1.30
diff -u -r1.30 dummy.c
--- lsm-2.5/security/dummy.c	13 Dec 2002 20:26:34 -0000	1.30
+++ lsm-2.5/security/dummy.c	16 Dec 2002 15:23:47 -0000
@@ -258,6 +258,11 @@
 	return;
 }
 
+static void dummy_inode_init (struct inode *inode)
+{
+	return;
+}
+
 static int dummy_inode_create (struct inode *inode, struct dentry *dentry,
 			       int mask)
 {
@@ -914,6 +919,7 @@
 	set_to_dummy_if_null(ops, sb_post_pivotroot);
 	set_to_dummy_if_null(ops, inode_alloc_security);
 	set_to_dummy_if_null(ops, inode_free_security);
+	set_to_dummy_if_null(ops, inode_init);
 	set_to_dummy_if_null(ops, inode_create);
 	set_to_dummy_if_null(ops, inode_post_create);
 	set_to_dummy_if_null(ops, inode_link);
Index: lsm-2.5/security/selinux/hooks.c
===================================================================
RCS file: /home/pal/CVS/lsm-2.5/security/selinux/hooks.c,v
retrieving revision 1.84
diff -u -r1.84 hooks.c
--- lsm-2.5/security/selinux/hooks.c	3 Dec 2002 20:40:19 -0000	1.84
+++ lsm-2.5/security/selinux/hooks.c	16 Dec 2002 15:23:47 -0000
@@ -65,6 +65,8 @@
 #include "selinux_plug.h"
 #include "extsocket.h"
 
+#define _SELINUX_KERNEL_PATCH_
+
 #ifndef _SELINUX_KERNEL_PATCH_
 #warning "SELinux:  The separate SELinux kernel patch has not been applied.  Using SELinux without this patch is not recommended."
 #endif
@@ -1919,6 +1921,18 @@
 	inode_free_security(inode);
 }
 
+static void selinux_inode_init(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+	if (sb) {
+		struct superblock_security_struct *sbsec = sb->s_security;
+		if (sbsec && sbsec->uses_genfs)
+			/* Defer to inode_post_lookup. */
+			return;
+	}
+	inode_doinit(inode);
+}
+
 static int selinux_inode_create(struct inode *dir, struct dentry *dentry, int mask)
 {
 	return may_create(dir, dentry, SECCLASS_FILE);
@@ -4041,6 +4055,7 @@
 
 	inode_alloc_security:		selinux_inode_alloc_security,
 	inode_free_security:		selinux_inode_free_security,
+	inode_init:		        selinux_inode_init,
 	inode_create:			selinux_inode_create,
 	inode_post_create:		selinux_inode_post_create,
 	inode_link:			selinux_inode_link,

--Stare_of_Owls_334_000--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
