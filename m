Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4AHiPRb016633
	for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 13:44:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4AHiMYW024779
	for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 17:44:22 GMT
Received: from turing-police.cirt.vt.edu (turing-police.cirt.vt.edu [128.173.54.129])
        by jazzband.ncsc.mil  with ESMTP id i4AHiMBf024769 for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 17:44:22 GMT
Received: from turing-police.cc.vt.edu (IDENT:valdis@[127.0.0.1])
	by turing-police.cc.vt.edu (8.13.0.Beta0/8.13.0.Beta0) with ESMTP id i4A2cDRW027971
	for <selinux@tycho.nsa.gov>; Sun, 9 May 2004 22:38:14 -0400
Message-Id: <200405100238.i4A2cDRW027971@turing-police.cc.vt.edu>
To: selinux@tycho.nsa.gov
Subject: Linux 2.6.6-rc3-mm2 and SELinux support of stacked modules
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_874948280P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Sun, 09 May 2004 22:38:12 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_874948280P
Content-Type: text/plain; charset=us-ascii

I finally got a weekend free, and started doing some major code hacking,
working on producing an LSM-based version of Brad Spengler's Grsecurity patch
(I previously posted to lkml an earlier version that did many of the parts that
weren't doable in an LSM).  As a starting point for the LSM itself, I used
the 'capabilities' module, and started adding the hooks I needed. (I'd
like to thank Serge Hallyn - his BSDJail LSM has been helpful.. Life got a
lot simpler once I realized that although grsecurity hooks chroot() and the
*chdir() functions, we really don't need to, since we can do what we need
via inode_permission() ;)

The ultimate goal is to produce something that will do much of the same
things as BSDJail, a number of other generally-useful system hardening things,
and be able to work either stand-alone or stacked with SELinux.

I discovered a few things:

1) if you have an LSM that's non-modular, you can't call the
register_sysctl_table() function from the security_initcall(), because it
happens before the sysctl infrastructure gets set up - you get a very dead
system, even early_printk doesn't do any good...  I ended up adding a call in
post_mountroot(), which was meant for that sort of thing...

2) It stacks just fine with SELinux, except there's hooks that selinux/hooks.c
either doesn't hook, or it doesn't call secondary_ops() in its hook.

I've attached a patch that does the secondary_ops callback for essentially
everything used by either my already-written code, in-progress code, or the
BSDJail module.  I've done a careful check of the list of hooks, the grsecurity
stuff, the BSDJail stuff, and my to-do list, and I believe that this is a
fairly complete list for everything I'm trying to do. The only things that
aren't addressed are the BSD Jail's use of the task_(alloc|free)_security and
network restrictions (which would require some major rethinking for
usage in a stacked LSM).

Question:  In some places, hooks.c calls secondary_ops->foo() before doing
its own checking, and some places, it does it afterwards.  I'm failing to
understand the rhyme and reason...

--- linux-2.6.6-rc3-mm2/security/selinux/hooks.c.vt	2004-05-08 14:37:12.000000000 -0400
+++ linux-2.6.6-rc3-mm2/security/selinux/hooks.c	2004-05-09 21:55:14.559521204 -0400
@@ -1402,6 +1402,10 @@ static int selinux_sysctl(ctl_table *tab
 	u32 tsid;
 	int rc;
 
+	rc = secondary_ops->sysctl(table, op);
+	if (rc)
+		return rc;
+
 	tsec = current->security;
 
 	rc = selinux_proc_get_sid(table->de, (op == 001) ?
@@ -2048,6 +2052,12 @@ static int selinux_mount(char * dev_name
                          unsigned long flags,
                          void * data)
 {
+	int rc;
+
+	rc = secondary_ops->sb_mount(dev_name, nd, type, flags, data);
+	if (rc)
+		return rc;
+
 	if (flags & MS_REMOUNT)
 		return superblock_has_perm(current, nd->mnt->mnt_sb,
 		                           FILESYSTEM__REMOUNT, NULL);
@@ -2058,10 +2068,32 @@ static int selinux_mount(char * dev_name
 
 static int selinux_umount(struct vfsmount *mnt, int flags)
 {
+	int rc;
+
+	rc = secondary_ops->sb_umount(mnt, flags);
+	if (rc)
+		return rc;
+
 	return superblock_has_perm(current,mnt->mnt_sb,
 	                           FILESYSTEM__UNMOUNT,NULL);
 }
 
+static void selinux_post_mountroot(void)
+{
+	secondary_ops->sb_post_mountroot();
+}
+
+static int selinux_pivotroot(struct nameidata *old_nd, struct nameidata *new_nd)
+{
+	int rc;
+
+	rc = secondary_ops->sb_pivotroot(old_nd, new_nd);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
 /* inode security operations */
 
 static int selinux_inode_alloc_security(struct inode *inode)
@@ -2131,6 +2163,12 @@ static int selinux_inode_rmdir(struct in
 
 static int selinux_inode_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
 {
+	int rc;
+
+	rc = secondary_ops->inode_mknod(dir, dentry, mode, dev);
+	if (rc)
+		return rc;
+
 	return may_create(dir, dentry, inode_mode_to_security_class(mode));
 }
 
@@ -2169,17 +2207,29 @@ static int selinux_inode_follow_link(str
 static int selinux_inode_permission(struct inode *inode, int mask,
 				    struct nameidata *nd)
 {
+	int rc;
+
 	if (!mask) {
 		/* No permission to check.  Existence test. */
 		return 0;
 	}
 
+	rc = secondary_ops->inode_permission(inode, mask, nd);
+	if (rc)
+		return rc;
+
 	return inode_has_perm(current, inode,
 			       file_mask_to_av(inode->i_mode, mask), NULL, NULL);
 }
 
 static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
 {
+	int rc;
+
+	rc = secondary_ops->inode_setattr(dentry, iattr);
+	if (rc)
+		return rc;
+
 	if (iattr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID |
 			       ATTR_ATIME_SET | ATTR_MTIME_SET))
 		return dentry_has_perm(current, NULL, dentry, FILE__SETATTR);
@@ -2446,6 +2496,11 @@ static int selinux_file_ioctl(struct fil
 static int selinux_file_mmap(struct file *file, unsigned long prot, unsigned long flags)
 {
 	u32 av;
+	int rc;
+
+	rc = secondary_ops->file_mmap(file, prot, flags);
+	if (rc)
+		return rc;
 
 	if (file) {
 		/* read access is always possible with a mapping */
@@ -2466,6 +2521,12 @@ static int selinux_file_mmap(struct file
 static int selinux_file_mprotect(struct vm_area_struct *vma,
 				 unsigned long prot)
 {
+	int rc;
+
+	rc = secondary_ops->file_mprotect(vma, prot);
+	if (rc)
+		return rc;
+
 	return selinux_file_mmap(vma->vm_file, prot, vma->vm_flags);
 }
 
@@ -2563,6 +2624,12 @@ static int selinux_file_receive(struct f
 
 static int selinux_task_create(unsigned long clone_flags)
 {
+	int rc;
+
+	rc = secondary_ops->task_create(clone_flags);
+	if (rc)
+		return rc;
+
 	return task_has_perm(current, current, PROCESS__FORK);
 }
 
@@ -2638,13 +2705,24 @@ static int selinux_task_setgroups(struct
 
 static int selinux_task_setnice(struct task_struct *p, int nice)
 {
+	int rc;
+
+	rc = secondary_ops->task_setnice(p, nice);
+	if (rc)
+		return rc;
+
 	return task_has_perm(current,p, PROCESS__SETSCHED);
 }
 
 static int selinux_task_setrlimit(unsigned int resource, struct rlimit *new_rlim)
 {
 	struct rlimit *old_rlim = current->rlim + resource;
+	int rc;
 
+	rc = secondary_ops->task_setrlimit(resource, new_rlim);
+	if (rc)
+		return rc;
+	
 	/* Control the ability to change the hard limit (whether
 	   lowering or raising it), so that the hard limit can
 	   later be used as a safe reset point for the soft limit
@@ -2678,6 +2756,11 @@ static int selinux_task_getscheduler(str
 static int selinux_task_kill(struct task_struct *p, struct siginfo *info, int sig)
 {
 	u32 perm;
+	int rc;
+
+	rc = secondary_ops->task_kill(p, info, sig);
+	if (rc)
+		return rc;
 
 	if (info && ((unsigned long)info == 1 ||
 	             (unsigned long)info == 2 || SI_FROMKERNEL(info)))
@@ -3119,6 +3202,10 @@ static int selinux_socket_unix_stream_co
 	struct avc_audit_data ad;
 	int err;
 
+	err = secondary_ops->unix_stream_connect(sock, other, newsk);
+	if (err)
+		return err;
+
 	isec = SOCK_INODE(sock)->i_security;
 	other_isec = SOCK_INODE(other)->i_security;
 
@@ -3783,6 +3870,11 @@ static int selinux_shm_shmat(struct shmi
 			     char *shmaddr, int shmflg)
 {
 	u32 perms;
+	int rc;
+
+	rc = secondary_ops->shm_shmat(shp, shmaddr, shmflg);
+	if (rc)
+		return rc;
 
 	if (shmflg & SHM_RDONLY)
 		perms = SHM__READ;
@@ -4080,6 +4172,8 @@ struct security_operations selinux_ops =
 	.sb_statfs =			selinux_sb_statfs,
 	.sb_mount =			selinux_mount,
 	.sb_umount =			selinux_umount,
+	.sb_post_mountroot =		selinux_post_mountroot,
+	.sb_pivotroot =			selinux_pivotroot,
 
 	.inode_alloc_security =		selinux_inode_alloc_security,
 	.inode_free_security =		selinux_inode_free_security,



--==_Exmh_874948280P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAnusTcC3lWbTT17ARAo+zAKC7SNVZxsj3M51vKkKFpbifniHC2wCfVkbQ
qr65jirvs6S8Sz6vcGkl4og=
=QwrB
-----END PGP SIGNATURE-----

--==_Exmh_874948280P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
