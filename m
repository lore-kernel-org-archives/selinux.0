Message-Id: <200212202042.PAA03791@moss-shockers.ncsc.mil>
Date: Fri, 20 Dec 2002 15:42:15 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: nfsd kernel NULL pointer dereference
To: SELinux@tycho.nsa.gov, MartinRobb@ieee.org
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY=Flight_of_Pigeons_549_000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Flight_of_Pigeons_549_000
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: W8NLYuRVJQ8lDpgjoZIpPw==


> I am running the selinux-2002102211 package against the 2.4.19 kernel 
> patched with lsm-2.4-2002102211.  The system seems basically functional 
> in non-enforcing mode, but my nfs service is hanging, and in fact the 
> system is hanging on a shutdown.  In the system log I get:
> 
> Unable to handle kernel NULL pointer dereference in ...
> 
> I'm attaching the relevant lines from the system log.  I don't claim to 
> totally follow the dump, but it appears to me that 
> selinux_file_permission() is getting called with a null struct file 
> pointer -- ultimately by nfsd and apparently through vfs_readdir().
> 
> FWIW, the system in question is built from scratch using kickstart and 
> the selinux kernel and utilities become part of a larger rpm.  I did 
> have to go through some contortions to get the ~600 files that selinux 
> installs under / to install elsewhere, but things appear to be working 
> other than this nfsd issue so I don't think that is the source of the 
> problem.  The production version of this system has been using an 
> LSM-patched 2.4.14 kernel without selinux, and has been quite stable 
> with no NFS problems.
> 
> Any thoughts on the source of this problem?

Yes.  You need to apply the two attached patches.  The first patch
changes init_private_file to call file_alloc_securiy for private file
structures and adds a release_private_file function.  The second patch
modifies nfsd_open to use init_private_file, a back port by Chris Wright
of hch's cleanup in 2.5.

As a side note, you are not using the latest version of SELinux, but
even it requires applying the second of the two attached patches to
fully fix the problem in the 2.4 kernel.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil

--Flight_of_Pigeons_549_000
Content-Type: TEXT/plain; name="initprivate.patch"; charset=us-ascii; x-unix-mode=0644
Content-Description: initprivate.patch
Content-MD5: f2D92xhHJsN8wleHe/kINA==

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux Security Module
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.365   -> 1.366  
#	      kernel/ksyms.c	1.24    -> 1.25   
#	security/selinux/psid.c	1.5     -> 1.6    
#	     fs/file_table.c	1.11    -> 1.12   
#	     fs/nfsd/nfsfh.c	1.10    -> 1.11   
#	  include/linux/fs.h	1.37    -> 1.38   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/15	sds@lorax.epoch.ncsc.mil	1.366
# Added a file_alloc_security call to init_private_file, and created a 
# release_private_file function to encapsulate the f_op->release call and
# the file_free_security call.
# Initial patch by James Carter, with modifications by me, and further
# modifications by Chris Wright.
# --------------------------------------------
#
diff -Nru a/fs/file_table.c b/fs/file_table.c
--- a/fs/file_table.c	Fri Dec 20 15:21:50 2002
+++ b/fs/file_table.c	Fri Dec 20 15:21:50 2002
@@ -91,6 +91,7 @@
  */
 int init_private_file(struct file *filp, struct dentry *dentry, int mode)
 {
+	int error;
 	memset(filp, 0, sizeof(*filp));
 	filp->f_mode   = mode;
 	atomic_set(&filp->f_count, 1);
@@ -98,10 +99,23 @@
 	filp->f_uid    = current->fsuid;
 	filp->f_gid    = current->fsgid;
 	filp->f_op     = dentry->d_inode->i_fop;
-	if (filp->f_op->open)
-		return filp->f_op->open(dentry->d_inode, filp);
-	else
-		return 0;
+	error = security_ops->file_alloc_security(filp);
+	if (!error)
+		if (filp->f_op->open) {
+			error = filp->f_op->open(dentry->d_inode, filp);
+			if (error)
+				security_ops->file_free_security(filp);
+		}
+	return error;
+}
+
+void release_private_file(struct file *file)
+{
+	struct inode * inode = file->f_dentry->d_inode;
+
+	if (file->f_op && file->f_op->release)
+		file->f_op->release(inode, file);
+	security_ops->file_free_security(file);
 }
 
 void fput(struct file * file)
diff -Nru a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
--- a/fs/nfsd/nfsfh.c	Fri Dec 20 15:21:50 2002
+++ b/fs/nfsd/nfsfh.c	Fri Dec 20 15:21:50 2002
@@ -113,8 +113,7 @@
 	}
 
 out_close:
-	if (file.f_op->release)
-		file.f_op->release(dir, &file);
+	release_private_file(&file);
 out:
 	return error;
 }
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Fri Dec 20 15:21:50 2002
+++ b/include/linux/fs.h	Fri Dec 20 15:21:50 2002
@@ -554,6 +554,7 @@
 #define file_count(x)	atomic_read(&(x)->f_count)
 
 extern int init_private_file(struct file *, struct dentry *, int);
+extern void release_private_file(struct file *file);
 
 #define	MAX_NON_LFS	((1UL<<31) - 1)
 
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Fri Dec 20 15:21:50 2002
+++ b/kernel/ksyms.c	Fri Dec 20 15:21:50 2002
@@ -168,6 +168,7 @@
 EXPORT_SYMBOL(fd_install);
 EXPORT_SYMBOL(get_empty_filp);
 EXPORT_SYMBOL(init_private_file);
+EXPORT_SYMBOL(release_private_file);
 EXPORT_SYMBOL(filp_open);
 EXPORT_SYMBOL(filp_close);
 EXPORT_SYMBOL(put_filp);
diff -Nru a/security/selinux/psid.c b/security/selinux/psid.c
--- a/security/selinux/psid.c	Fri Dec 20 15:21:50 2002
+++ b/security/selinux/psid.c	Fri Dec 20 15:21:50 2002
@@ -178,6 +178,7 @@
 	for (i = 0; i < PSEC_NFILES; i++) {
 		if (t->files[i].f_dentry) {
 			dput(t->files[i].f_dentry);
+			release_private_file(&t->files[i]);
 		}
 	}
 

--Flight_of_Pigeons_549_000
Content-Type: TEXT/plain; name="nfsd.patch"; charset=us-ascii; x-unix-mode=0644
Content-Description: nfsd.patch
Content-MD5: dQww4M5AqChVi8GB0ddFww==

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux Security Module
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.377   -> 1.378  
#	       fs/nfsd/vfs.c	1.12    -> 1.13   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/19	chris@wirex.com	1.378
# back port 2.5 nfsd_open cleanup by hch.  this ensures that privately
# allocated filp's have security_file_alloc() called.
# --------------------------------------------
#
diff -Nru a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
--- a/fs/nfsd/vfs.c	Fri Dec 20 15:25:41 2002
+++ b/fs/nfsd/vfs.c	Fri Dec 20 15:25:41 2002
@@ -427,11 +427,13 @@
 {
 	struct dentry	*dentry;
 	struct inode	*inode;
-	int		err;
+	int		flags = O_RDONLY|O_LARGEFILE, mode = FMODE_READ, err;
 
-	/* If we get here, then the client has already done an "open", and (hopefully)
-	 * checked permission - so allow OWNER_OVERRIDE in case a chmod has now revoked
-	 * permission */
+	/*
+	 * If we get here, then the client has already done an "open",
+	 * and (hopefully) checked permission - so allow OWNER_OVERRIDE
+	 * in case a chmod has now revoked permission.
+	 */
 	err = fh_verify(rqstp, fhp, type, access | MAY_OWNER_OVERRIDE);
 	if (err)
 		goto out;
@@ -456,37 +458,24 @@
 	if (err)
 		goto out_nfserr;
 
-	if ((access & MAY_WRITE) && (err = get_write_access(inode)) != 0)
-		goto out_nfserr;
-
-	memset(filp, 0, sizeof(*filp));
-	filp->f_op    = fops_get(inode->i_fop);
-	atomic_set(&filp->f_count, 1);
-	filp->f_dentry = dentry;
-	filp->f_vfsmnt = fhp->fh_export->ex_mnt;
 	if (access & MAY_WRITE) {
-		filp->f_flags = O_WRONLY|O_LARGEFILE;
-		filp->f_mode  = FMODE_WRITE;
+		err = get_write_access(inode);
+		if (err)
+			goto out_nfserr;
+
+		flags = O_WRONLY|O_LARGEFILE;
+		mode  = FMODE_WRITE;
+
 		DQUOT_INIT(inode);
-	} else {
-		filp->f_flags = O_RDONLY|O_LARGEFILE;
-		filp->f_mode  = FMODE_READ;
 	}
 
-	err = 0;
-	if (filp->f_op && filp->f_op->open) {
-		err = filp->f_op->open(inode, filp);
-		if (err) {
-			fops_put(filp->f_op);
-			if (access & MAY_WRITE)
-				put_write_access(inode);
-
-			/* I nearly added put_filp() call here, but this filp
-			 * is really on callers stack frame. -DaveM
-			 */
-			atomic_dec(&filp->f_count);
-		}
-	}
+	err = init_private_file(filp, dentry, mode);
+	if (!err) {
+		filp->f_flags = flags;
+		filp->f_vfsmnt = fhp->fh_export->ex_mnt;
+	} else if (access & MAY_WRITE)
+		put_write_access(inode);
+
 out_nfserr:
 	if (err)
 		err = nfserrno(err);
@@ -503,9 +492,7 @@
 	struct dentry	*dentry = filp->f_dentry;
 	struct inode	*inode = dentry->d_inode;
 
-	if (filp->f_op && filp->f_op->release)
-		filp->f_op->release(inode, filp);
-	fops_put(filp->f_op);
+	release_private_file(filp);
 	if (filp->f_mode & FMODE_WRITE)
 		put_write_access(inode);
 }

--Flight_of_Pigeons_549_000--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
