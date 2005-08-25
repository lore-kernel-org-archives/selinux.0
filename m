Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7PN1iOb020750
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2005 19:01:44 -0400 (EDT)
Received: from smtp.osdl.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7PMp5Tl000706
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2005 22:51:07 GMT
Date: Thu, 25 Aug 2005 15:51:04 -0700
From: Chris Wright <chrisw@osdl.org>
To: James Morris <jmorris@namei.org>, Stephen Smalley <sds@epoch.ncsc.mil>
Cc: linux-security-module@wirex.com, selinux@tycho.nsa.gov
Subject: [PATCH] remove selinux stacked ops
Message-ID: <20050825225104.GC7762@shell0.pdx.osdl.net>
References: <20050825221732.GR7991@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050825221732.GR7991@shell0.pdx.osdl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Chris Wright (chrisw@osdl.org) wrote:
> Would it make more sense to directly use cap_* as library functions,
> and drop the whole ad-hoc internal stacking?

Something like this.  Granted, any new stacking would require external
support...

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -102,14 +102,8 @@ static int __init selinux_enabled_setup(
 __setup("selinux=", selinux_enabled_setup);
 #endif
 
-/* Original (dummy) security module. */
-static struct security_operations *original_ops = NULL;
-
-/* Minimal support for a secondary security module,
-   just to allow the use of the dummy or capability modules.
-   The owlsm module can alternatively be used as a secondary
-   module as long as CONFIG_OWLSM_FD is not enabled. */
-static struct security_operations *secondary_ops = NULL;
+/* Original (default) security module. */
+static struct security_operations *original_ops;
 
 /* Lists of inode and superblock security structures initialized
    before the policy was loaded. */
@@ -1352,7 +1346,7 @@ static int selinux_ptrace(struct task_st
 	struct task_security_struct *csec = child->security;
 	int rc;
 
-	rc = secondary_ops->ptrace(parent,child);
+	rc = cap_ptrace(parent,child);
 	if (rc)
 		return rc;
 
@@ -1372,7 +1366,7 @@ static int selinux_capget(struct task_st
 	if (error)
 		return error;
 
-	return secondary_ops->capget(target, effective, inheritable, permitted);
+	return cap_capget(target, effective, inheritable, permitted);
 }
 
 static int selinux_capset_check(struct task_struct *target, kernel_cap_t *effective,
@@ -1380,7 +1374,7 @@ static int selinux_capset_check(struct t
 {
 	int error;
 
-	error = secondary_ops->capset_check(target, effective, inheritable, permitted);
+	error = cap_capset_check(target, effective, inheritable, permitted);
 	if (error)
 		return error;
 
@@ -1390,14 +1384,14 @@ static int selinux_capset_check(struct t
 static void selinux_capset_set(struct task_struct *target, kernel_cap_t *effective,
                                kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
-	secondary_ops->capset_set(target, effective, inheritable, permitted);
+	cap_capset_set(target, effective, inheritable, permitted);
 }
 
 static int selinux_capable(struct task_struct *tsk, int cap)
 {
 	int rc;
 
-	rc = secondary_ops->capable(tsk, cap);
+	rc = cap_capable(tsk, cap);
 	if (rc)
 		return rc;
 
@@ -1412,10 +1406,6 @@ static int selinux_sysctl(ctl_table *tab
 	u32 tsid;
 	int rc;
 
-	rc = secondary_ops->sysctl(table, op);
-	if (rc)
-		return rc;
-
 	tsec = current->security;
 
 	rc = selinux_proc_get_sid(table->de, (op == 001) ?
@@ -1484,7 +1474,7 @@ static int selinux_syslog(int type)
 {
 	int rc;
 
-	rc = secondary_ops->syslog(type);
+	rc = cap_syslog(type);
 	if (rc)
 		return rc;
 
@@ -1515,7 +1505,7 @@ static int selinux_syslog(int type)
  * mapping. 0 means there is enough memory for the allocation to
  * succeed and -ENOMEM implies there is not.
  *
- * Note that secondary_ops->capable and task_has_perm_noaudit return 0
+ * Note that cap_capable and task_has_perm_noaudit return 0
  * if the capability is granted, but __vm_enough_memory requires 1 if
  * the capability is granted.
  *
@@ -1527,7 +1517,7 @@ static int selinux_vm_enough_memory(long
 	int rc, cap_sys_admin = 0;
 	struct task_security_struct *tsec = current->security;
 
-	rc = secondary_ops->capable(current, CAP_SYS_ADMIN);
+	rc = cap_capable(current, CAP_SYS_ADMIN);
 	if (rc == 0)
 		rc = avc_has_perm_noaudit(tsec->sid, tsec->sid,
 					SECCLASS_CAPABILITY,
@@ -1570,7 +1560,7 @@ static int selinux_bprm_set_security(str
 	struct avc_audit_data ad;
 	int rc;
 
-	rc = secondary_ops->bprm_set_security(bprm);
+	rc = cap_bprm_set_security(bprm);
 	if (rc)
 		return rc;
 
@@ -1635,12 +1625,6 @@ static int selinux_bprm_set_security(str
 	return 0;
 }
 
-static int selinux_bprm_check_security (struct linux_binprm *bprm)
-{
-	return secondary_ops->bprm_check_security(bprm);
-}
-
-
 static int selinux_bprm_secureexec (struct linux_binprm *bprm)
 {
 	struct task_security_struct *tsec = current->security;
@@ -1655,7 +1639,7 @@ static int selinux_bprm_secureexec (stru
 					 PROCESS__NOATSECURE, NULL);
 	}
 
-	return (atsecure || secondary_ops->bprm_secureexec(bprm));
+	return (atsecure || cap_bprm_secureexec(bprm));
 }
 
 static void selinux_bprm_free_security(struct linux_binprm *bprm)
@@ -1756,7 +1740,7 @@ static void selinux_bprm_apply_creds(str
 	u32 sid;
 	int rc;
 
-	secondary_ops->bprm_apply_creds(bprm, unsafe);
+	cap_bprm_apply_creds(bprm, unsafe);
 
 	tsec = current->security;
 
@@ -1980,12 +1964,6 @@ static int selinux_mount(char * dev_name
                          unsigned long flags,
                          void * data)
 {
-	int rc;
-
-	rc = secondary_ops->sb_mount(dev_name, nd, type, flags, data);
-	if (rc)
-		return rc;
-
 	if (flags & MS_REMOUNT)
 		return superblock_has_perm(current, nd->mnt->mnt_sb,
 		                           FILESYSTEM__REMOUNT, NULL);
@@ -1996,12 +1974,6 @@ static int selinux_mount(char * dev_name
 
 static int selinux_umount(struct vfsmount *mnt, int flags)
 {
-	int rc;
-
-	rc = secondary_ops->sb_umount(mnt, flags);
-	if (rc)
-		return rc;
-
 	return superblock_has_perm(current,mnt->mnt_sb,
 	                           FILESYSTEM__UNMOUNT,NULL);
 }
@@ -2030,11 +2002,6 @@ static void selinux_inode_post_create(st
 
 static int selinux_inode_link(struct dentry *old_dentry, struct inode *dir, struct dentry *new_dentry)
 {
-	int rc;
-
-	rc = secondary_ops->inode_link(old_dentry,dir,new_dentry);
-	if (rc)
-		return rc;
 	return may_link(dir, old_dentry, MAY_LINK);
 }
 
@@ -2045,11 +2012,6 @@ static void selinux_inode_post_link(stru
 
 static int selinux_inode_unlink(struct inode *dir, struct dentry *dentry)
 {
-	int rc;
-
-	rc = secondary_ops->inode_unlink(dir, dentry);
-	if (rc)
-		return rc;
 	return may_link(dir, dentry, MAY_UNLINK);
 }
 
@@ -2080,12 +2042,6 @@ static int selinux_inode_rmdir(struct in
 
 static int selinux_inode_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
 {
-	int rc;
-
-	rc = secondary_ops->inode_mknod(dir, dentry, mode, dev);
-	if (rc)
-		return rc;
-
 	return may_create(dir, dentry, inode_mode_to_security_class(mode));
 }
 
@@ -2113,23 +2069,12 @@ static int selinux_inode_readlink(struct
 
 static int selinux_inode_follow_link(struct dentry *dentry, struct nameidata *nameidata)
 {
-	int rc;
-
-	rc = secondary_ops->inode_follow_link(dentry,nameidata);
-	if (rc)
-		return rc;
 	return dentry_has_perm(current, NULL, dentry, FILE__READ);
 }
 
 static int selinux_inode_permission(struct inode *inode, int mask,
 				    struct nameidata *nd)
 {
-	int rc;
-
-	rc = secondary_ops->inode_permission(inode, mask, nd);
-	if (rc)
-		return rc;
-
 	if (!mask) {
 		/* No permission to check.  Existence test. */
 		return 0;
@@ -2141,12 +2086,6 @@ static int selinux_inode_permission(stru
 
 static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
 {
-	int rc;
-
-	rc = secondary_ops->inode_setattr(dentry, iattr);
-	if (rc)
-		return rc;
-
 	if (iattr->ia_valid & ATTR_FORCE)
 		return 0;
 
@@ -2451,12 +2390,6 @@ static int file_map_prot_check(struct fi
 static int selinux_file_mmap(struct file *file, unsigned long reqprot,
 			     unsigned long prot, unsigned long flags)
 {
-	int rc;
-
-	rc = secondary_ops->file_mmap(file, reqprot, prot, flags);
-	if (rc)
-		return rc;
-
 	if (selinux_checkreqprot)
 		prot = reqprot;
 
@@ -2470,10 +2403,6 @@ static int selinux_file_mprotect(struct 
 {
 	int rc;
 
-	rc = secondary_ops->file_mprotect(vma, reqprot, prot);
-	if (rc)
-		return rc;
-
 	if (selinux_checkreqprot)
 		prot = reqprot;
 
@@ -2608,12 +2537,6 @@ static int selinux_file_receive(struct f
 
 static int selinux_task_create(unsigned long clone_flags)
 {
-	int rc;
-
-	rc = secondary_ops->task_create(clone_flags);
-	if (rc)
-		return rc;
-
 	return task_has_perm(current, current, PROCESS__FORK);
 }
 
@@ -2662,7 +2585,7 @@ static int selinux_task_setuid(uid_t id0
 
 static int selinux_task_post_setuid(uid_t id0, uid_t id1, uid_t id2, int flags)
 {
-	return secondary_ops->task_post_setuid(id0,id1,id2,flags);
+	return cap_task_post_setuid(id0,id1,id2,flags);
 }
 
 static int selinux_task_setgid(gid_t id0, gid_t id1, gid_t id2, int flags)
@@ -2694,23 +2617,12 @@ static int selinux_task_setgroups(struct
 
 static int selinux_task_setnice(struct task_struct *p, int nice)
 {
-	int rc;
-
-	rc = secondary_ops->task_setnice(p, nice);
-	if (rc)
-		return rc;
-
 	return task_has_perm(current,p, PROCESS__SETSCHED);
 }
 
 static int selinux_task_setrlimit(unsigned int resource, struct rlimit *new_rlim)
 {
 	struct rlimit *old_rlim = current->signal->rlim + resource;
-	int rc;
-
-	rc = secondary_ops->task_setrlimit(resource, new_rlim);
-	if (rc)
-		return rc;
 
 	/* Control the ability to change the hard limit (whether
 	   lowering or raising it), so that the hard limit can
@@ -2735,11 +2647,6 @@ static int selinux_task_getscheduler(str
 static int selinux_task_kill(struct task_struct *p, struct siginfo *info, int sig)
 {
 	u32 perm;
-	int rc;
-
-	rc = secondary_ops->task_kill(p, info, sig);
-	if (rc)
-		return rc;
 
 	if (info && ((unsigned long)info == 1 ||
 	             (unsigned long)info == 2 || SI_FROMKERNEL(info)))
@@ -2778,7 +2685,7 @@ static void selinux_task_reparent_to_ini
 {
   	struct task_security_struct *tsec;
 
-	secondary_ops->task_reparent_to_init(p);
+	cap_task_reparent_to_init(p);
 
 	tsec = p->security;
 	tsec->osid = tsec->sid;
@@ -3227,10 +3134,6 @@ static int selinux_socket_unix_stream_co
 	struct avc_audit_data ad;
 	int err;
 
-	err = secondary_ops->unix_stream_connect(sock, other, newsk);
-	if (err)
-		return err;
-
 	isec = SOCK_INODE(sock)->i_security;
 	other_isec = SOCK_INODE(other)->i_security;
 
@@ -3603,7 +3506,7 @@ static int selinux_netlink_send(struct s
 	struct av_decision avd;
 	int err;
 
-	err = secondary_ops->netlink_send(sk, skb);
+	err = cap_netlink_send(sk, skb);
 	if (err)
 		return err;
 
@@ -3620,13 +3523,6 @@ static int selinux_netlink_send(struct s
 	return err;
 }
 
-static int selinux_netlink_recv(struct sk_buff *skb)
-{
-	if (!cap_raised(NETLINK_CB(skb).eff_cap, CAP_NET_ADMIN))
-		return -EPERM;
-	return 0;
-}
-
 static int ipc_alloc_security(struct task_struct *task,
 			      struct kern_ipc_perm *perm,
 			      u16 sclass)
@@ -3947,11 +3843,6 @@ static int selinux_shm_shmat(struct shmi
 			     char __user *shmaddr, int shmflg)
 {
 	u32 perms;
-	int rc;
-
-	rc = secondary_ops->shm_shmat(shp, shmaddr, shmflg);
-	if (rc)
-		return rc;
 
 	if (shmflg & SHM_RDONLY)
 		perms = SHM__READ;
@@ -4080,37 +3971,6 @@ static int selinux_ipc_permission(struct
 	return ipc_has_perm(ipcp, av);
 }
 
-/* module stacking operations */
-static int selinux_register_security (const char *name, struct security_operations *ops)
-{
-	if (secondary_ops != original_ops) {
-		printk(KERN_INFO "%s:  There is already a secondary security "
-		       "module registered.\n", __FUNCTION__);
-		return -EINVAL;
- 	}
-
-	secondary_ops = ops;
-
-	printk(KERN_INFO "%s:  Registering secondary module %s\n",
-	       __FUNCTION__,
-	       name);
-
-	return 0;
-}
-
-static int selinux_unregister_security (const char *name, struct security_operations *ops)
-{
-	if (ops != secondary_ops) {
-		printk (KERN_INFO "%s:  trying to unregister a security module "
-		        "that is not registered.\n", __FUNCTION__);
-		return -EINVAL;
-	}
-
-	secondary_ops = original_ops;
-
-	return 0;
-}
-
 static void selinux_d_instantiate (struct dentry *dentry, struct inode *inode)
 {
 	if (inode)
@@ -4278,14 +4138,12 @@ static struct security_operations selinu
 	.vm_enough_memory =		selinux_vm_enough_memory,
 
 	.netlink_send =			selinux_netlink_send,
-        .netlink_recv =			selinux_netlink_recv,
 
 	.bprm_alloc_security =		selinux_bprm_alloc_security,
 	.bprm_free_security =		selinux_bprm_free_security,
 	.bprm_apply_creds =		selinux_bprm_apply_creds,
 	.bprm_post_apply_creds =	selinux_bprm_post_apply_creds,
 	.bprm_set_security =		selinux_bprm_set_security,
-	.bprm_check_security =		selinux_bprm_check_security,
 	.bprm_secureexec =		selinux_bprm_secureexec,
 
 	.sb_alloc_security =		selinux_sb_alloc_security,
@@ -4382,9 +4240,6 @@ static struct security_operations selinu
 	.sem_semctl =			selinux_sem_semctl,
 	.sem_semop =			selinux_sem_semop,
 
-	.register_security =		selinux_register_security,
-	.unregister_security =		selinux_unregister_security,
-
 	.d_instantiate =                selinux_d_instantiate,
 
 	.getprocattr =                  selinux_getprocattr,
@@ -4433,9 +4288,7 @@ static __init int selinux_init(void)
 
 	avc_init();
 
-	original_ops = secondary_ops = security_ops;
-	if (!secondary_ops)
-		panic ("SELinux: No initial security operations\n");
+	original_ops = security_ops;
 	if (register_security (&selinux_ops))
 		panic("SELinux: Unable to register with kernel.\n");
 
@@ -4568,8 +4421,8 @@ int selinux_disable(void)
 
 	selinux_disabled = 1;
 
-	/* Reset security_ops to the secondary module, dummy or capability. */
-	security_ops = secondary_ops;
+	/* Reset security_ops to the default */
+	security_ops = original_ops;
 
 	/* Unregister netfilter hooks. */
 	selinux_nf_ip_exit();

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
