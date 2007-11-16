Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lAGKBEUh019142
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 15:11:14 -0500
Subject: [PATCH 09/13] NFS: Client implementation of SELINUX Labeling
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: labeled-nfs@linux-nfs.org
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
References: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 16 Nov 2007 15:11:00 -0500
Message-Id: <1195243860.20981.21.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There are several places where recommended attributes are implemented in the
NFSv4 client code. This patch adds two functions to encode and decode the secid
recommended attribute which makes use of the LSM hooks added earlier. It also
adds code to grab the label from the file attribute structures and encode the
label to be sent back to the server. Even though the code is there to encode a
label to be sent back to the server there does not appear to be an interface to
use it yet.

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
Signed-off-by: Matthew N. Dodd <Matthew.Dodd@sparta.com>
---
 fs/nfs/dir.c        |   72 ++++++++++++++++++++-
 fs/nfs/inode.c      |   40 +++++++++++-
 fs/nfs/nfs4proc.c   |  184 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/nfs/nfs4xdr.c    |   47 +++++++++++++
 fs/nfs/super.c      |   11 +++
 security/security.c |    2 +
 6 files changed, 353 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 02e68ff..0738827 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -39,6 +39,10 @@
 #include "delegation.h"
 #include "iostat.h"
 
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+#include <linux/security.h>
+#endif
+
 /* #define NFS_DEBUG_VERBOSE 1 */
 
 static int nfs_opendir(struct inode *, struct file *);
@@ -1218,18 +1222,36 @@ static int nfs_create(struct inode *dir, struct dentry *dentry, int mode,
 	attr.ia_mode = mode;
 	attr.ia_valid = ATTR_MODE;
 
-	if ((nd->flags & LOOKUP_CREATE) != 0)
+	if ((nd->flags & LOOKUP_CREATE) != 0) {
 		open_flags = nd->intent.open.flags;
 
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+		if (nfs_server_capable(dir, NFS_CAP_SECURITY_LABEL)) {
+			error = security_dentry_init_security(dentry,
+					attr.ia_mode,
+					&attr.ia_label, &attr.ia_label_len);
+			if (error == 0)
+				attr.ia_valid |= ATTR_SECURITY_LABEL;
+		}
+#endif
+	}
 	lock_kernel();
 	error = NFS_PROTO(dir)->create(dir, dentry, &attr, open_flags, nd);
 	if (error != 0)
 		goto out_err;
 	unlock_kernel();
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (attr.ia_label != NULL)
+		kfree(attr.ia_label);
+#endif
 	return 0;
 out_err:
 	unlock_kernel();
 	d_drop(dentry);
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (attr.ia_label != NULL)
+		kfree(attr.ia_label);
+#endif
 	return error;
 }
 
@@ -1252,8 +1274,22 @@ nfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t rdev)
 	attr.ia_mode = mode;
 	attr.ia_valid = ATTR_MODE;
 
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (nfs_server_capable(dir, NFS_CAP_SECURITY_LABEL)) {
+		status = security_dentry_init_security(dentry,
+				attr.ia_mode,
+				&attr.ia_label, &attr.ia_label_len);
+		if (status == 0)
+			attr.ia_valid |= ATTR_SECURITY_LABEL;
+	}
+#endif
+
 	lock_kernel();
 	status = NFS_PROTO(dir)->mknod(dir, dentry, &attr, rdev);
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (attr.ia_label != NULL)
+		kfree(attr.ia_label);
+#endif
 	if (status != 0)
 		goto out_err;
 	unlock_kernel();
@@ -1279,15 +1315,31 @@ static int nfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 	attr.ia_valid = ATTR_MODE;
 	attr.ia_mode = mode | S_IFDIR;
 
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (nfs_server_capable(dir, NFS_CAP_SECURITY_LABEL)) {
+		error = security_dentry_init_security(dentry, attr.ia_mode,
+				&attr.ia_label, &attr.ia_label_len);
+		if (error == 0)
+			attr.ia_valid |= ATTR_SECURITY_LABEL;
+	}
+#endif
 	lock_kernel();
 	error = NFS_PROTO(dir)->mkdir(dir, dentry, &attr);
 	if (error != 0)
 		goto out_err;
 	unlock_kernel();
+	#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+		if (attr.ia_label != NULL)
+			kfree(attr.ia_label);
+	#endif
 	return 0;
 out_err:
 	d_drop(dentry);
 	unlock_kernel();
+	#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+		if (attr.ia_label != NULL)
+			kfree(attr.ia_label);
+	#endif
 	return error;
 }
 
@@ -1487,6 +1539,16 @@ static int nfs_symlink(struct inode *dir, struct dentry *dentry, const char *sym
 	attr.ia_mode = S_IFLNK | S_IRWXUGO;
 	attr.ia_valid = ATTR_MODE;
 
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (nfs_server_capable(dir, NFS_CAP_SECURITY_LABEL)) {
+		error = security_dentry_init_security(dentry,
+				attr.ia_mode,
+				&attr.ia_label, &attr.ia_label_len);
+		if (error == 0)
+			attr.ia_valid |= ATTR_SECURITY_LABEL;
+	}
+#endif
+
 	lock_kernel();
 
 	page = alloc_page(GFP_HIGHUSER);
@@ -1509,6 +1571,10 @@ static int nfs_symlink(struct inode *dir, struct dentry *dentry, const char *sym
 		d_drop(dentry);
 		__free_page(page);
 		unlock_kernel();
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+		if (attr.ia_label != NULL)
+			kfree(attr.ia_label);
+#endif
 		return error;
 	}
 
@@ -1527,6 +1593,10 @@ static int nfs_symlink(struct inode *dir, struct dentry *dentry, const char *sym
 		__free_page(page);
 
 	unlock_kernel();
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (attr.ia_label != NULL)
+		kfree(attr.ia_label);
+#endif
 	return 0;
 }
 
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 4c3d501..3982867 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -37,7 +37,7 @@
 #include <linux/vfs.h>
 #include <linux/inet.h>
 #include <linux/nfs_xdr.h>
-
+#include <linux/xattr.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
@@ -47,6 +47,10 @@
 #include "iostat.h"
 #include "internal.h"
 
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+#include <linux/security.h>
+#endif
+
 #define NFSDBG_FACILITY		NFSDBG_VFS
 
 #define NFS_64_BIT_INODE_NUMBERS_ENABLED	1
@@ -237,6 +241,26 @@ nfs_init_locked(struct inode *inode, void *opaque)
 /* Don't use READDIRPLUS on directories that we believe are too large */
 #define NFS_LIMIT_READDIRPLUS (8*PAGE_SIZE)
 
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+static inline void nfs_setsecurity(struct inode *inode, struct nfs_fattr *fattr)
+{
+	int error;
+
+	if ((fattr->valid & NFS_ATTR_FATTR_V4) &&
+	    (fattr->bitmap[1] & FATTR4_WORD1_SECURITY_LABEL) &&
+	    (fattr->label != NULL) &&
+	    (inode->i_security != NULL)) {
+		const char *suffix = security_inode_xattr_getname() +
+					XATTR_SECURITY_PREFIX_LEN;
+		error = security_inode_setsecurity(inode, suffix, fattr->label,
+						   fattr->label_len, 0);
+		if (error)
+			printk("%s() %s %d security_inode_setsecurity() %d\n",
+			       __func__, fattr->label, fattr->label_len,
+			       error);
+	}
+}
+#endif
 /*
  * This is our front-end to iget that looks up inodes by file handle
  * instead of inode number.
@@ -317,6 +341,11 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 		inode->i_nlink = fattr->nlink;
 		inode->i_uid = fattr->uid;
 		inode->i_gid = fattr->gid;
+
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+		nfs_setsecurity(inode, fattr);
+#endif /* CONFIG_NFS_V4_SECURITY_LABEL  */
+
 		if (fattr->valid & (NFS_ATTR_FATTR_V3 | NFS_ATTR_FATTR_V4)) {
 			/*
 			 * report the blocks in 512byte units
@@ -425,6 +454,11 @@ void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr)
 		inode->i_size = attr->ia_size;
 		vmtruncate(inode, attr->ia_size);
 	}
+
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if ((attr->ia_valid & ATTR_SECURITY_LABEL) != 0)
+		inode_setsecurity(inode, attr);
+#endif
 }
 
 static int nfs_wait_schedule(void *word)
@@ -1077,6 +1111,10 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	inode->i_uid = fattr->uid;
 	inode->i_gid = fattr->gid;
 
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	nfs_setsecurity(inode, fattr);
+#endif /* CONFIG_NFS_V4_SECURITY_LABEL */
+
 	if (fattr->valid & (NFS_ATTR_FATTR_V3 | NFS_ATTR_FATTR_V4)) {
 		/*
 		 * report the blocks in 512byte units
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 59dd4eb..47fa612 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -48,11 +48,16 @@
 #include <linux/smp_lock.h>
 #include <linux/namei.h>
 #include <linux/mount.h>
+#include <linux/xattr.h>
 
 #include "nfs4_fs.h"
 #include "delegation.h"
 #include "iostat.h"
 
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+#include <linux/security.h>
+#endif
+
 #define NFSDBG_FACILITY		NFSDBG_PROC
 
 #define NFS4_POLL_RETRY_MIN	(HZ/10)
@@ -1411,7 +1416,6 @@ nfs4_atomic_open(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 	struct rpc_cred *cred;
 	struct nfs4_state *state;
 	struct dentry *res;
-	int error;
 
 	cred = rpcauth_lookupcred(NFS_CLIENT(dir)->cl_auth, 0);
 	if (IS_ERR(cred))
@@ -1423,6 +1427,16 @@ nfs4_atomic_open(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 		attr.ia_valid = ATTR_MODE;
 		if (!IS_POSIXACL(dir))
 			attr.ia_mode &= ~current->fs->umask;
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+		if (nfs_server_capable(dir, NFS_CAP_SECURITY_LABEL)) {
+			int error;
+			error = security_dentry_init_security(dentry,
+					attr.ia_mode,
+					&attr.ia_label, &attr.ia_label_len);
+			if (error == 0)
+				attr.ia_valid |= ATTR_SECURITY_LABEL;
+		}
+#endif
 	} else {
 		attr.ia_valid = 0;
 		BUG_ON(nd->intent.open.flags & O_CREAT);
@@ -1433,6 +1447,10 @@ nfs4_atomic_open(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 	nfs_block_sillyrename(parent);
 	state = nfs4_do_open(dir, &path, nd->intent.open.flags, &attr, cred);
 	put_rpccred(cred);
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (attr.ia_label != NULL)
+		kfree(attr.ia_label);
+#endif
 	if (IS_ERR(state)) {
 		if (PTR_ERR(state) == -ENOENT) {
 			d_add(dentry, NULL);
@@ -1505,6 +1523,12 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 		memcpy(server->attr_bitmask, res.attr_bitmask, sizeof(server->attr_bitmask));
 		if (res.attr_bitmask[0] & FATTR4_WORD0_ACL)
 			server->caps |= NFS_CAP_ACLS;
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+		if (res.attr_bitmask[1] & FATTR4_WORD1_SECURITY_LABEL)
+			server->caps |= NFS_CAP_SECURITY_LABEL;
+#else
+		server->attr_bitmask[1] &= ~FATTR4_WORD1_SECURITY_LABEL;
+#endif
 		if (res.has_links != 0)
 			server->caps |= NFS_CAP_HARDLINKS;
 		if (res.has_symlinks != 0)
@@ -2890,6 +2914,164 @@ static int nfs4_proc_set_acl(struct inode *inode, const void *buf, size_t buflen
 	return err;
 }
 
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+static int _nfs4_get_security_label(struct inode *inode, void *buf,
+				    size_t buflen)
+{
+	struct nfs_server *server = NFS_SERVER(inode);
+	struct nfs_fattr fattr;
+	u32 bitmask[2] = { 0, FATTR4_WORD1_SECURITY_LABEL };
+	struct nfs4_getattr_arg args = {
+		.fh		= NFS_FH(inode),
+		.bitmask	= bitmask,
+	};
+	struct nfs4_getattr_res res = {
+		.fattr		= &fattr,
+		.server		= server,
+	};
+	struct rpc_message msg = {
+		.rpc_proc	= &nfs4_procedures[NFSPROC4_CLNT_GETATTR],
+		.rpc_argp	= &args,
+		.rpc_resp	= &res,
+	};
+	int ret;
+
+	return -EOPNOTSUPP;
+
+	nfs_fattr_alloc(&fattr);
+	nfs_fattr_init(&fattr);
+
+	ret = rpc_call_sync(server->client, &msg, 0);
+	if (ret)
+		goto out;
+	if (!(fattr.bitmap[1] & FATTR4_WORD1_SECURITY_LABEL))
+		return -ENOENT;
+	if (buflen < fattr.label_len) {
+		ret = -ERANGE;
+		goto out;
+	}
+	memcpy(buf, fattr.label, fattr.label_len);
+out:
+	nfs_fattr_fini(&fattr);
+	return ret;
+}
+
+static int nfs4_get_security_label(struct inode *inode, void *buf,
+				   size_t buflen)
+{
+	struct nfs4_exception exception = { };
+	int err;
+
+	if (!nfs_server_capable(inode, NFS_CAP_SECURITY_LABEL))
+		return -EOPNOTSUPP;
+
+	do {
+		err = nfs4_handle_exception(NFS_SERVER(inode),
+				_nfs4_get_security_label(inode, buf, buflen),
+				&exception);
+	} while (exception.retry);
+	return err;
+}
+
+static int _nfs4_do_set_security_label(struct inode *inode,
+				       struct iattr *sattr,
+				       struct nfs_fattr *fattr,
+				       struct nfs4_state *state)
+{
+	struct nfs_server *server = NFS_SERVER(inode);
+	const u32 bitmask[2] = { 0, FATTR4_WORD1_SECURITY_LABEL };
+	struct nfs_setattrargs args = {
+		.fh             = NFS_FH(inode),
+		.iap            = sattr,
+		.server		= server,
+		.bitmask	= bitmask,
+	};
+	struct nfs_setattrres res = {
+		.fattr		= fattr,
+		.server		= server,
+	};
+	struct rpc_message msg = {
+		.rpc_proc       = &nfs4_procedures[NFSPROC4_CLNT_SETATTR],
+		.rpc_argp       = &args,
+		.rpc_resp       = &res,
+	};
+	unsigned long timestamp = jiffies;
+	int status;
+
+	if (nfs4_copy_delegation_stateid(&args.stateid, inode)) {
+		/* Use that stateid */
+	} else if (state != NULL) {
+		msg.rpc_cred = state->owner->so_cred;
+		nfs4_copy_stateid(&args.stateid, state, current->files);
+	} else
+		memcpy(&args.stateid, &zero_stateid, sizeof(args.stateid));
+
+	status = rpc_call_sync(server->client, &msg, 0);
+	if (status == 0 && state != NULL)
+		renew_lease(server, timestamp);
+	return status;
+}
+
+static int nfs4_do_set_security_label(struct inode *inode,
+				       struct iattr *sattr,
+				       struct nfs_fattr *fattr,
+				       struct nfs4_state *state)
+{
+	struct nfs4_exception exception = { };
+	int err;
+	do {
+		err = nfs4_handle_exception(NFS_SERVER(inode),
+				_nfs4_do_set_security_label(inode, sattr,
+							    fattr, state),
+							    &exception);
+	} while (exception.retry);
+	return err;
+}
+
+static int
+nfs4_set_security_label(struct dentry *dentry, const void *buf, size_t buflen)
+{
+	struct nfs_fattr fattr;
+	struct iattr sattr;
+	struct rpc_cred *cred;
+	struct nfs_open_context *ctx;
+	struct nfs4_state *state = NULL;
+	struct inode *inode = dentry->d_inode;
+	int status;
+
+	if (!nfs_server_capable(inode, NFS_CAP_SECURITY_LABEL))
+		return -EOPNOTSUPP;
+
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
+	nfs_fattr_alloc(&fattr);
+	nfs_fattr_init(&fattr);
+
+	memset(&sattr, 0, sizeof(struct iattr));
+	sattr.ia_valid = ATTR_SECURITY_LABEL;
+	sattr.ia_label = (char *)buf;
+	sattr.ia_label_len = buflen;
+
+	cred = rpcauth_lookupcred(NFS_CLIENT(inode)->cl_auth, 0);
+	if (IS_ERR(cred))
+		return PTR_ERR(cred);
+
+	/* Search for an existing open(O_WRITE) file */
+	ctx = nfs_find_open_context(inode, cred, FMODE_WRITE);
+	if (ctx != NULL)
+		state = ctx->state;
+
+	status = nfs4_do_set_security_label(inode, &sattr, &fattr, state);
+	if (status == 0)
+		nfs_setattr_update_inode(inode, &sattr);
+	if (ctx != NULL)
+		put_nfs_open_context(ctx);
+	put_rpccred(cred);
+	nfs_fattr_fini(&fattr);
+	return status;
+}
+#endif
+
+
 static int
 nfs4_async_handle_error(struct rpc_task *task, const struct nfs_server *server)
 {
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 51dd380..3736817 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -51,6 +51,7 @@
 #include <linux/nfs4.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfs_idmap.h>
+#include <linux/security.h>
 #include "nfs4_fs.h"
 
 #define NFSDBG_FACILITY		NFSDBG_XDR
@@ -649,6 +650,10 @@ static int encode_attrs(struct xdr_stream *xdr, const struct iattr *iap, const s
 		}
 		len += 4 + (XDR_QUADLEN(owner_grouplen) << 2);
 	}
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (iap->ia_valid & ATTR_SECURITY_LABEL)
+		len += 4 + (XDR_QUADLEN(iap->ia_label_len) << 2);
+#endif
 	if (iap->ia_valid & ATTR_ATIME_SET)
 		len += 16;
 	else if (iap->ia_valid & ATTR_ATIME)
@@ -707,6 +712,13 @@ static int encode_attrs(struct xdr_stream *xdr, const struct iattr *iap, const s
 		bmval1 |= FATTR4_WORD1_TIME_MODIFY_SET;
 		WRITE32(NFS4_SET_TO_SERVER_TIME);
 	}
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (iap->ia_valid & ATTR_SECURITY_LABEL) {
+		bmval1 |= FATTR4_WORD1_SECURITY_LABEL;
+		WRITE32(iap->ia_label_len);
+		WRITEMEM(iap->ia_label, iap->ia_label_len);
+	}
+#endif /* CONFIG_NFS_V4_SECURITY_LABEL */
 	
 	/*
 	 * Now we backfill the bitmap and the attribute buffer length.
@@ -2952,6 +2964,37 @@ static int decode_attr_time_modify(struct xdr_stream *xdr, uint32_t *bitmap, str
 	return status;
 }
 
+static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap, char **ctx, u32 *ctxlen)
+{
+	uint32_t len;
+	__be32 *p;
+	int rc = 0;
+
+	if (unlikely(bitmap[1] & (FATTR4_WORD1_SECURITY_LABEL - 1U)))
+		return -EIO;
+	if (likely(bitmap[1] & FATTR4_WORD1_SECURITY_LABEL)) {
+		READ_BUF(4);
+		READ32(len);
+		READ_BUF(len);
+		if (len < XDR_MAX_NETOBJ) {
+			if (*ctx != NULL) {
+				if (*ctxlen < len) {
+					printk("%s(): ctxlen (%d) < len (%d)\n",
+							__func__, *ctxlen, len);
+				} else {
+					memcpy(*ctx, (char *)p, len);
+					(*ctx)[len + 1] = '\0';
+				}
+			}
+			*ctxlen = len;
+		} else
+			printk(KERN_WARNING "%s: label too long (%u)!\n",
+					__FUNCTION__, len);
+		bitmap[1] &= ~FATTR4_WORD1_SECURITY_LABEL;
+	}
+	return rc;
+}
+
 static int verify_attr_len(struct xdr_stream *xdr, __be32 *savep, uint32_t attrlen)
 {
 	unsigned int attrwords = XDR_QUADLEN(attrlen);
@@ -3184,6 +3227,10 @@ static int decode_getfattr(struct xdr_stream *xdr, struct nfs_fattr *fattr, cons
 		goto xdr_error;
 	if ((status = decode_attr_mounted_on_fileid(xdr, bitmap, &fileid)) != 0)
 		goto xdr_error;
+	if ((status = decode_attr_security_label(xdr, bitmap,
+						 &fattr->label,
+						 &fattr->label_len)) != 0)
+		goto xdr_error;
 	if (fattr->fileid == 0 && fileid != 0)
 		fattr->fileid = fileid;
 	if ((status = verify_attr_len(xdr, savep, attrlen)) == 0)
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index c8f64da..012211f 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -462,6 +462,13 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
 	seq_printf(m, ",timeo=%lu", 10U * clp->retrans_timeo / HZ);
 	seq_printf(m, ",retrans=%u", clp->retrans_count);
 	seq_printf(m, ",sec=%s", nfs_pseudoflavour_to_name(nfss->client->cl_auth->au_flavor));
+
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if ((nfss->nfs_client->cl_nfsversion == 4) &&
+	    (nfss->attr_bitmask[1] & FATTR4_WORD1_SECURITY_LABEL))
+		seq_printf(m, ",security_label");
+#endif /* CONFIG_NFS_V4_SECURITY_LABEL */
+
 }
 
 /*
@@ -516,6 +523,10 @@ static int nfs_show_stats(struct seq_file *m, struct vfsmount *mnt)
 		seq_printf(m, "bm0=0x%x", nfss->attr_bitmask[0]);
 		seq_printf(m, ",bm1=0x%x", nfss->attr_bitmask[1]);
 		seq_printf(m, ",acl=0x%x", nfss->acl_bitmask);
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+		if (nfss->attr_bitmask[1] & FATTR4_WORD1_SECURITY_LABEL)
+			seq_printf(m, ",security_label");
+#endif /* CONFIG_NFS_V4_SECURITY_LABEL */
 	}
 #endif
 
diff --git a/security/security.c b/security/security.c
index c481405..5471489 100644
--- a/security/security.c
+++ b/security/security.c
@@ -499,6 +499,7 @@ int security_inode_getsecurity(const struct inode *inode, const char *name, void
 		return 0;
 	return security_ops->inode_getsecurity(inode, name, buffer, alloc);
 }
+EXPORT_SYMBOL(security_inode_getsecurity);
 
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
 {
@@ -506,6 +507,7 @@ int security_inode_setsecurity(struct inode *inode, const char *name, const void
 		return 0;
 	return security_ops->inode_setsecurity(inode, name, value, size, flags);
 }
+EXPORT_SYMBOL(security_inode_setsecurity);
 
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
 {
-- 
1.5.3.4



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
