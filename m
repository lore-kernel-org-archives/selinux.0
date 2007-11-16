Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lAGKAQjA019033
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 15:10:26 -0500
Subject: [PATCH 08/13] NFS: Introduce lifecycle managment for label
	attribute.
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: labeled-nfs@linux-nfs.org
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
References: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 16 Nov 2007 15:10:24 -0500
Message-Id: <1195243824.20981.19.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Two fields have been added to the nfs_fattr structure to carry the security
label and its length. This has raised the need to provide lifecycle management
for these values. This patch introduces two macros nfs_fattr_alloc and
nfs_fattr_fini which are used to allocate and destroy these fields inside the
nfs_fattr structure. These macros do not modify any other components of the
structure so nfs_fattr_init still has to be used on these structures.

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
Signed-off-by: Matthew N. Dodd <Matthew.Dodd@sparta.com>
---
 fs/nfs/client.c        |   16 ++++++
 fs/nfs/dir.c           |   25 ++++++++++
 fs/nfs/getroot.c       |   33 +++++++++++++
 fs/nfs/inode.c         |   16 ++++++
 fs/nfs/namespace.c     |    3 +
 fs/nfs/nfs3proc.c      |   15 ++++++
 fs/nfs/nfs4proc.c      |  125 ++++++++++++++++++++++++++++++++++++++++++++++-
 fs/nfs/proc.c          |   13 +++++-
 fs/nfs/super.c         |    4 ++
 include/linux/nfs4.h   |    1 -
 include/linux/nfs_fs.h |   37 ++++++++++++++
 11 files changed, 283 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 70587f3..2382f98 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -778,6 +778,8 @@ struct nfs_server *nfs_create_server(const struct nfs_parsed_mount_data *data,
 	struct nfs_fattr fattr;
 	int error;
 
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
+
 	server = nfs_alloc_server();
 	if (!server)
 		return ERR_PTR(-ENOMEM);
@@ -828,10 +830,12 @@ struct nfs_server *nfs_create_server(const struct nfs_parsed_mount_data *data,
 	spin_unlock(&nfs_client_lock);
 
 	server->mount_time = jiffies;
+	nfs_fattr_fini(&fattr)
 	return server;
 
 error:
 	nfs_free_server(server);
+	nfs_fattr_fini(&fattr)
 	return ERR_PTR(error);
 }
 
@@ -957,6 +961,8 @@ struct nfs_server *nfs4_create_server(const struct nfs_parsed_mount_data *data,
 
 	dprintk("--> nfs4_create_server()\n");
 
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
+
 	server = nfs_alloc_server();
 	if (!server)
 		return ERR_PTR(-ENOMEM);
@@ -1008,11 +1014,13 @@ struct nfs_server *nfs4_create_server(const struct nfs_parsed_mount_data *data,
 	spin_unlock(&nfs_client_lock);
 
 	server->mount_time = jiffies;
+	nfs_fattr_fini(&fattr);
 	dprintk("<-- nfs4_create_server() = %p\n", server);
 	return server;
 
 error:
 	nfs_free_server(server);
+	nfs_fattr_fini(&fattr);
 	dprintk("<-- nfs4_create_server() = error %d\n", error);
 	return ERR_PTR(error);
 }
@@ -1030,6 +1038,8 @@ struct nfs_server *nfs4_create_referral_server(struct nfs_clone_mount *data,
 
 	dprintk("--> nfs4_create_referral_server()\n");
 
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
+
 	server = nfs_alloc_server();
 	if (!server)
 		return ERR_PTR(-ENOMEM);
@@ -1084,11 +1094,13 @@ struct nfs_server *nfs4_create_referral_server(struct nfs_clone_mount *data,
 
 	server->mount_time = jiffies;
 
+	nfs_fattr_fini(&fattr);
 	dprintk("<-- nfs_create_referral_server() = %p\n", server);
 	return server;
 
 error:
 	nfs_free_server(server);
+	nfs_fattr_fini(&fattr);
 	dprintk("<-- nfs4_create_referral_server() = error %d\n", error);
 	return ERR_PTR(error);
 }
@@ -1110,6 +1122,8 @@ struct nfs_server *nfs_clone_server(struct nfs_server *source,
 		(unsigned long long) fattr->fsid.major,
 		(unsigned long long) fattr->fsid.minor);
 
+	memset(&fattr_fsinfo, 0, sizeof(struct nfs_fattr));
+
 	server = nfs_alloc_server();
 	if (!server)
 		return ERR_PTR(-ENOMEM);
@@ -1150,11 +1164,13 @@ struct nfs_server *nfs_clone_server(struct nfs_server *source,
 
 	server->mount_time = jiffies;
 
+	nfs_fattr_fini(&fattr_fsinfo);
 	dprintk("<-- nfs_clone_server() = %p\n", server);
 	return server;
 
 out_free_server:
 	nfs_free_server(server);
+	nfs_fattr_fini(&fattr_fsinfo);
 	dprintk("<-- nfs_clone_server() = error %d\n", error);
 	return ERR_PTR(error);
 }
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 3533453..02e68ff 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -534,6 +534,8 @@ static int nfs_readdir(struct file *filp, void *dirent, filldir_t filldir)
 			(long long)filp->f_pos);
 	nfs_inc_stats(inode, NFSIOS_VFSGETDENTS);
 
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
+
 	lock_kernel();
 
 	res = nfs_revalidate_mapping_nolock(inode, filp->f_mapping);
@@ -592,6 +594,7 @@ static int nfs_readdir(struct file *filp, void *dirent, filldir_t filldir)
 			res = 0;
 			break;
 		}
+		nfs_fattr_fini(&fattr);
 	}
 	nfs_unblock_sillyrename(dentry);
 	unlock_kernel();
@@ -751,6 +754,8 @@ static int nfs_lookup_revalidate(struct dentry * dentry, struct nameidata *nd)
 	struct nfs_fh fhandle;
 	struct nfs_fattr fattr;
 
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
+
 	parent = dget_parent(dentry);
 	lock_kernel();
 	dir = parent->d_inode;
@@ -780,6 +785,11 @@ static int nfs_lookup_revalidate(struct dentry * dentry, struct nameidata *nd)
 	if (NFS_STALE(inode))
 		goto out_bad;
 
+	#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+		if (nfs_server_capable(dir, NFS_CAP_SECURITY_LABEL))
+			nfs_fattr_alloc(&fattr);
+	#endif
+
 	error = NFS_PROTO(dir)->lookup(dir, &dentry->d_name, &fhandle, &fattr);
 	if (error)
 		goto out_bad;
@@ -792,6 +802,7 @@ static int nfs_lookup_revalidate(struct dentry * dentry, struct nameidata *nd)
  out_valid:
 	unlock_kernel();
 	dput(parent);
+	nfs_fattr_fini(&fattr);
 	dfprintk(LOOKUPCACHE, "NFS: %s(%s/%s) is valid\n",
 			__FUNCTION__, dentry->d_parent->d_name.name,
 			dentry->d_name.name);
@@ -811,6 +822,7 @@ out_zap_parent:
 	d_drop(dentry);
 	unlock_kernel();
 	dput(parent);
+	nfs_fattr_fini(&fattr);
 	dfprintk(LOOKUPCACHE, "NFS: %s(%s/%s) is invalid\n",
 			__FUNCTION__, dentry->d_parent->d_name.name,
 			dentry->d_name.name);
@@ -878,6 +890,8 @@ static struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, stru
 		dentry->d_parent->d_name.name, dentry->d_name.name);
 	nfs_inc_stats(dir, NFSIOS_VFSLOOKUP);
 
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
+
 	res = ERR_PTR(-ENAMETOOLONG);
 	if (dentry->d_name.len > NFS_SERVER(dir)->namelen)
 		goto out;
@@ -899,6 +913,11 @@ static struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, stru
 
 	parent = dentry->d_parent;
 	/* Protect against concurrent sillydeletes */
+	#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+		if (nfs_server_capable(dir, NFS_CAP_SECURITY_LABEL))
+			nfs_fattr_alloc(&fattr);
+	#endif
+
 	nfs_block_sillyrename(parent);
 	error = NFS_PROTO(dir)->lookup(dir, &dentry->d_name, &fhandle, &fattr);
 	if (error == -ENOENT)
@@ -925,6 +944,8 @@ out_unblock_sillyrename:
 out_unlock:
 	unlock_kernel();
 out:
+	/* Label will give 'unused' warning on 'no_entry' case. */
+	nfs_fattr_fini(&fattr);
 	return res;
 }
 
@@ -1193,6 +1214,7 @@ static int nfs_create(struct inode *dir, struct dentry *dentry, int mode,
 	dfprintk(VFS, "NFS: create(%s/%ld), %s\n",
 			dir->i_sb->s_id, dir->i_ino, dentry->d_name.name);
 
+	memset(&attr, 0, sizeof(struct iattr));
 	attr.ia_mode = mode;
 	attr.ia_valid = ATTR_MODE;
 
@@ -1226,6 +1248,7 @@ nfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t rdev)
 	if (!new_valid_dev(rdev))
 		return -EINVAL;
 
+	memset(&attr, 0, sizeof(struct iattr));
 	attr.ia_mode = mode;
 	attr.ia_valid = ATTR_MODE;
 
@@ -1252,6 +1275,7 @@ static int nfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 	dfprintk(VFS, "NFS: mkdir(%s/%ld), %s\n",
 			dir->i_sb->s_id, dir->i_ino, dentry->d_name.name);
 
+	memset(&attr, 0, sizeof(struct iattr));
 	attr.ia_valid = ATTR_MODE;
 	attr.ia_mode = mode | S_IFDIR;
 
@@ -1459,6 +1483,7 @@ static int nfs_symlink(struct inode *dir, struct dentry *dentry, const char *sym
 	if (pathlen > PAGE_SIZE)
 		return -ENAMETOOLONG;
 
+	memset(&attr, 0, sizeof(struct iattr));
 	attr.ia_mode = S_IFLNK | S_IRWXUGO;
 	attr.ia_valid = ATTR_MODE;
 
diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
index 522e5ad..8ac024e 100644
--- a/fs/nfs/getroot.c
+++ b/fs/nfs/getroot.c
@@ -54,6 +54,8 @@ struct dentry *nfs_get_root(struct super_block *sb, struct nfs_fh *mntfh)
 	struct inode *inode;
 	int error;
 
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
+
 	/* create a dummy root dentry with dummy inode for this superblock */
 	if (!sb->s_root) {
 		struct nfs_fh dummyfh;
@@ -112,6 +114,7 @@ struct dentry *nfs_get_root(struct super_block *sb, struct nfs_fh *mntfh)
 	if (!mntroot->d_op)
 		mntroot->d_op = server->nfs_client->rpc_ops->dentry_ops;
 
+	nfs_fattr_fini(&fattr);
 	return mntroot;
 }
 
@@ -136,6 +139,10 @@ int nfs4_path_walk(struct nfs_server *server,
 
 	dprintk("--> nfs4_path_walk(,,%s)\n", path);
 
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	nfs_fattr_alloc(&fattr); /* Unconditional, no server caps yet. */
+#endif
 	fsinfo.fattr = &fattr;
 	nfs_fattr_init(&fattr);
 
@@ -147,12 +154,14 @@ int nfs4_path_walk(struct nfs_server *server,
 	ret = server->nfs_client->rpc_ops->getroot(server, mntfh, &fsinfo);
 	if (ret < 0) {
 		dprintk("nfs4_get_root: getroot error = %d\n", -ret);
+		nfs_fattr_fini(&fattr);
 		return ret;
 	}
 
 	if (fattr.type != NFDIR) {
 		printk(KERN_ERR "nfs4_get_root:"
 		       " getroot encountered non-directory\n");
+		nfs_fattr_fini(&fattr);
 		return -ENOTDIR;
 	}
 
@@ -160,6 +169,7 @@ int nfs4_path_walk(struct nfs_server *server,
 	if (fattr.valid & NFS_ATTR_FATTR_V4_REFERRAL) {
 		printk(KERN_ERR "nfs4_get_root:"
 		       " getroot obtained referral\n");
+		nfs_fattr_fini(&fattr);
 		return -EREMOTE;
 	}
 
@@ -192,6 +202,7 @@ eat_dot_dir:
 	    ) {
 		printk(KERN_ERR "nfs4_get_root:"
 		       " Mount path contains reference to \"..\"\n");
+		nfs_fattr_fini(&fattr);
 		return -EINVAL;
 	}
 
@@ -200,16 +211,25 @@ eat_dot_dir:
 
 	dprintk("LookupFH: %*.*s [%s]\n", name.len, name.len, name.name, path);
 
+	nfs_fattr_fini(&fattr);
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (server->caps & NFS_CAP_SECURITY_LABEL)
+		nfs_fattr_alloc(&fattr);
+#endif
+
 	ret = server->nfs_client->rpc_ops->lookupfh(server, &lastfh, &name,
 						    mntfh, &fattr);
 	if (ret < 0) {
 		dprintk("nfs4_get_root: getroot error = %d\n", -ret);
+		nfs_fattr_fini(&fattr);
 		return ret;
 	}
 
 	if (fattr.type != NFDIR) {
 		printk(KERN_ERR "nfs4_get_root:"
 		       " lookupfh encountered non-directory\n");
+		nfs_fattr_fini(&fattr);
 		return -ENOTDIR;
 	}
 
@@ -217,6 +237,7 @@ eat_dot_dir:
 	if (fattr.valid & NFS_ATTR_FATTR_V4_REFERRAL) {
 		printk(KERN_ERR "nfs4_get_root:"
 		       " lookupfh obtained referral\n");
+		nfs_fattr_fini(&fattr);
 		return -EREMOTE;
 	}
 
@@ -224,6 +245,7 @@ eat_dot_dir:
 
 path_walk_complete:
 	memcpy(&server->fsid, &fattr.fsid, sizeof(server->fsid));
+	nfs_fattr_fini(&fattr);
 	dprintk("<-- nfs4_path_walk() = 0\n");
 	return 0;
 }
@@ -276,19 +298,30 @@ struct dentry *nfs4_get_root(struct super_block *sb, struct nfs_fh *mntfh)
 		return ERR_PTR(error);
 	}
 
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	/* XXX: Should this be nfs_server_capable(NFS_CAP_SECURITY_LABEL) ?*/
+	if (server->caps & NFS_CAP_SECURITY_LABEL)
+		nfs_fattr_alloc(&fattr);
+#endif
+
 	/* get the actual root for this mount */
 	error = server->nfs_client->rpc_ops->getattr(server, mntfh, &fattr);
 	if (error < 0) {
 		dprintk("nfs_get_root: getattr error = %d\n", -error);
+		nfs_fattr_fini(&fattr);
 		return ERR_PTR(error);
 	}
 
 	inode = nfs_fhget(sb, mntfh, &fattr);
 	if (IS_ERR(inode)) {
 		dprintk("nfs_get_root: get root inode failed\n");
+		nfs_fattr_fini(&fattr);
 		return ERR_PTR(PTR_ERR(inode));
 	}
 
+	nfs_fattr_fini(&fattr);
+
 	/* root dentries normally start off anonymous and get spliced in later
 	 * if the dentry tree reaches them; however if the dentry already
 	 * exists, we'll pick it up at this point and use it as the root
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index db5d96d..4c3d501 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -357,6 +357,12 @@ nfs_setattr(struct dentry *dentry, struct iattr *attr)
 
 	nfs_inc_stats(inode, NFSIOS_VFSSETATTR);
 
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (nfs_server_capable(inode, NFS_CAP_SECURITY_LABEL))
+		nfs_fattr_alloc(&fattr);
+#endif
+
 	/* skip mode change if it's just for clearing setuid/setgid */
 	if (attr->ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID))
 		attr->ia_valid &= ~ATTR_MODE;
@@ -386,6 +392,7 @@ nfs_setattr(struct dentry *dentry, struct iattr *attr)
 	if (error == 0)
 		nfs_refresh_inode(inode, &fattr);
 	unlock_kernel();
+	nfs_fattr_fini(&fattr);
 	return error;
 }
 
@@ -637,6 +644,9 @@ __nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 		inode->i_sb->s_id, (long long)NFS_FILEID(inode));
 
 	nfs_inc_stats(inode, NFSIOS_INODEREVALIDATE);
+
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
+
 	lock_kernel();
 	if (is_bad_inode(inode))
  		goto out_nowait;
@@ -651,6 +661,11 @@ __nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 	if (NFS_STALE(inode))
 		goto out;
 
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (nfs_server_capable(inode, NFS_CAP_SECURITY_LABEL))
+		nfs_fattr_alloc(&fattr);
+#endif
+
 	status = NFS_PROTO(inode)->getattr(server, NFS_FH(inode), &fattr);
 	if (status != 0) {
 		dfprintk(PAGECACHE, "nfs_revalidate_inode: (%s/%Ld) getattr failed, error=%d\n",
@@ -687,6 +702,7 @@ __nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 
  out_nowait:
 	unlock_kernel();
+	nfs_fattr_fini(&fattr);
 	return status;
 }
 
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index acfc56f..79858c7 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -105,6 +105,8 @@ static void * nfs_follow_mountpoint(struct dentry *dentry, struct nameidata *nd)
 
 	dprintk("--> nfs_follow_mountpoint()\n");
 
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
+
 	BUG_ON(IS_ROOT(dentry));
 	dprintk("%s: enter\n", __FUNCTION__);
 	dput(nd->dentry);
@@ -141,6 +143,7 @@ static void * nfs_follow_mountpoint(struct dentry *dentry, struct nameidata *nd)
 	nd->dentry = dget(mnt->mnt_root);
 	schedule_delayed_work(&nfs_automount_task, nfs_mountpoint_expiry_timeout);
 out:
+	nfs_fattr_fini(&fattr);
 	dprintk("%s: done, returned %d\n", __FUNCTION__, err);
 
 	dprintk("<-- nfs_follow_mountpoint() = %d\n", err);
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 4cdc236..1df7137 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -383,6 +383,7 @@ nfs3_proc_unlink_done(struct rpc_task *task, struct inode *dir)
 		return 0;
 	res = task->tk_msg.rpc_resp;
 	nfs_post_op_update_inode(dir, &res->dir_attr);
+	nfs_fattr_fini(&res->dir_attr);
 	return 1;
 }
 
@@ -482,6 +483,9 @@ nfs3_proc_symlink(struct inode *dir, struct dentry *dentry, struct page *page,
 
 	dprintk("NFS call  symlink %s\n", dentry->d_name.name);
 
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
+	memset(&dir_attr, 0, sizeof(struct nfs_fattr));
+
 	nfs_fattr_init(&dir_attr);
 	nfs_fattr_init(&fattr);
 	status = rpc_call_sync(NFS_CLIENT(dir), &msg, 0);
@@ -490,6 +494,8 @@ nfs3_proc_symlink(struct inode *dir, struct dentry *dentry, struct page *page,
 		goto out;
 	status = nfs_instantiate(dentry, &fhandle, &fattr);
 out:
+	nfs_fattr_fini(&fattr);
+	nfs_fattr_fini(&dir_attr);
 	dprintk("NFS reply symlink: %d\n", status);
 	return status;
 }
@@ -522,6 +528,8 @@ nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *sattr)
 
 	sattr->ia_mode &= ~current->fs->umask;
 
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
+	memset(&dir_attr, 0, sizeof(struct nfs_fattr));
 	nfs_fattr_init(&dir_attr);
 	nfs_fattr_init(&fattr);
 	status = rpc_call_sync(NFS_CLIENT(dir), &msg, 0);
@@ -533,6 +541,8 @@ nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *sattr)
 		goto out;
 	status = nfs3_proc_set_default_acl(dir, dentry->d_inode, mode);
 out:
+	nfs_fattr_fini(&fattr);
+	nfs_fattr_fini(&dir_attr);
 	dprintk("NFS reply mkdir: %d\n", status);
 	return status;
 }
@@ -640,6 +650,9 @@ nfs3_proc_mknod(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 	mode_t mode = sattr->ia_mode;
 	int status;
 
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
+	memset(&dir_attr, 0, sizeof(struct nfs_fattr));
+
 	switch (sattr->ia_mode & S_IFMT) {
 	case S_IFBLK:	arg.type = NF3BLK;  break;
 	case S_IFCHR:	arg.type = NF3CHR;  break;
@@ -664,6 +677,8 @@ nfs3_proc_mknod(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 		goto out;
 	status = nfs3_proc_set_default_acl(dir, dentry->d_inode, mode);
 out:
+	nfs_fattr_fini(&fattr);
+	nfs_fattr_fini(&dir_attr);
 	dprintk("NFS reply mknod: %d\n", status);
 	return status;
 }
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index dfa6179..59dd4eb 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -243,6 +243,8 @@ static void nfs4_init_opendata_res(struct nfs4_opendata *p)
 	p->o_res.f_attr = &p->f_attr;
 	p->o_res.dir_attr = &p->dir_attr;
 	p->o_res.server = p->o_arg.server;
+	memset(&p->f_attr, 0, sizeof(struct nfs_fattr));
+	memset(&p->dir_attr, 0, sizeof(struct nfs_fattr));
 	nfs_fattr_init(&p->f_attr);
 	nfs_fattr_init(&p->dir_attr);
 }
@@ -275,6 +277,7 @@ static struct nfs4_opendata *nfs4_opendata_alloc(struct path *path,
 	p->o_arg.server = server;
 	p->o_arg.bitmask = server->attr_bitmask;
 	p->o_arg.claim = NFS4_OPEN_CLAIM_NULL;
+	memset(&p->attrs, 0, sizeof(struct iattr));
 	if (flags & O_EXCL) {
 		u32 *s = (u32 *) p->o_arg.u.verifier.data;
 		s[0] = jiffies;
@@ -282,12 +285,22 @@ static struct nfs4_opendata *nfs4_opendata_alloc(struct path *path,
 	} else if (flags & O_CREAT) {
 		p->o_arg.u.attrs = &p->attrs;
 		memcpy(&p->attrs, attrs, sizeof(p->attrs));
+		/* The above creates an additional reference to ia_label.
+		 * The CALLER must free this, not nfs4_opendata_free()
+		 */
 	}
 	p->c_arg.fh = &p->o_res.fh;
 	p->c_arg.stateid = &p->o_res.stateid;
 	p->c_arg.seqid = p->o_arg.seqid;
 	nfs4_init_opendata_res(p);
 	kref_init(&p->kref);
+
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (server->caps & NFS_CAP_SECURITY_LABEL) {
+		nfs_fattr_alloc(&p->f_attr);
+		nfs_fattr_alloc(&p->dir_attr);
+	}
+#endif
 	return p;
 err_free:
 	kfree(p);
@@ -304,6 +317,8 @@ static void nfs4_opendata_free(struct kref *kref)
 	nfs_free_seqid(p->o_arg.seqid);
 	if (p->state != NULL)
 		nfs4_put_open_state(p->state);
+	nfs_fattr_fini(&p->f_attr);
+	nfs_fattr_fini(&p->dir_attr);
 	nfs4_put_state_owner(p->owner);
 	dput(p->dir);
 	dput(p->path.dentry);
@@ -1213,6 +1228,7 @@ static void nfs4_free_closedata(void *data)
 	nfs4_put_state_owner(sp);
 	dput(calldata->path.dentry);
 	mntput(calldata->path.mnt);
+	nfs_fattr_fini(&calldata->fattr);
 	kfree(calldata);
 }
 
@@ -1319,6 +1335,7 @@ int nfs4_do_close(struct path *path, struct nfs4_state *state, int wait)
 	calldata = kmalloc(sizeof(*calldata), GFP_KERNEL);
 	if (calldata == NULL)
 		goto out;
+	memset(calldata, 0, sizeof(*calldata));
 	calldata->inode = state->inode;
 	calldata->state = state;
 	calldata->arg.fh = NFS_FH(state->inode);
@@ -1333,6 +1350,12 @@ int nfs4_do_close(struct path *path, struct nfs4_state *state, int wait)
 	calldata->path.mnt = mntget(path->mnt);
 	calldata->path.dentry = dget(path->dentry);
 
+	memset(&calldata->fattr, 0, sizeof(struct nfs_fattr));
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (server->caps & NFS_CAP_SECURITY_LABEL)
+		nfs_fattr_alloc(&calldata->fattr);
+#endif
+
 	task = rpc_run_task(server->client, RPC_TASK_ASYNC, &nfs4_close_ops, calldata);
 	if (IS_ERR(task))
 		return PTR_ERR(task);
@@ -1342,6 +1365,7 @@ int nfs4_do_close(struct path *path, struct nfs4_state *state, int wait)
 	rpc_put_task(task);
 	return status;
 out_free_calldata:
+	nfs_fattr_fini(&calldata->fattr);
 	kfree(calldata);
 out:
 	nfs4_put_open_state(state);
@@ -1387,7 +1411,13 @@ nfs4_atomic_open(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 	struct rpc_cred *cred;
 	struct nfs4_state *state;
 	struct dentry *res;
+	int error;
+
+	cred = rpcauth_lookupcred(NFS_CLIENT(dir)->cl_auth, 0);
+	if (IS_ERR(cred))
+		return (struct dentry *)cred;
 
+	memset(&attr, 0, sizeof(struct iattr));
 	if (nd->flags & LOOKUP_CREATE) {
 		attr.ia_mode = nd->intent.open.create_mode;
 		attr.ia_valid = ATTR_MODE;
@@ -1398,9 +1428,6 @@ nfs4_atomic_open(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 		BUG_ON(nd->intent.open.flags & O_CREAT);
 	}
 
-	cred = rpcauth_lookupcred(NFS_CLIENT(dir)->cl_auth, 0);
-	if (IS_ERR(cred))
-		return (struct dentry *)cred;
 	parent = dentry->d_parent;
 	/* Protect against concurrent sillydeletes */
 	nfs_block_sillyrename(parent);
@@ -1761,6 +1788,8 @@ static int _nfs4_proc_access(struct inode *inode, struct nfs_access_entry *entry
 	int mode = entry->mask;
 	int status;
 
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
+
 	/*
 	 * Determine which access bits we want to ask for...
 	 */
@@ -1777,6 +1806,10 @@ static int _nfs4_proc_access(struct inode *inode, struct nfs_access_entry *entry
 		if (mode & MAY_EXEC)
 			args.access |= NFS4_ACCESS_EXECUTE;
 	}
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (server->caps & NFS_CAP_SECURITY_LABEL)
+		nfs_fattr_alloc(&fattr);
+#endif
 	nfs_fattr_init(&fattr);
 	status = rpc_call_sync(NFS_CLIENT(inode), &msg, 0);
 	if (!status) {
@@ -1789,6 +1822,7 @@ static int _nfs4_proc_access(struct inode *inode, struct nfs_access_entry *entry
 			entry->mask |= MAY_EXEC;
 		nfs_refresh_inode(inode, &fattr);
 	}
+	nfs_fattr_fini(&fattr);
 	return status;
 }
 
@@ -1902,10 +1936,17 @@ nfs4_proc_create(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 	nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
 	if (flags & O_EXCL) {
 		struct nfs_fattr fattr;
+		memset(&fattr, 0, sizeof(struct nfs_fattr));
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+		if (nfs_server_capable(state->inode, NFS_CAP_SECURITY_LABEL))
+			nfs_fattr_alloc(&fattr);
+#endif
 		status = nfs4_do_setattr(state->inode, &fattr, sattr, state);
 		if (status == 0)
 			nfs_setattr_update_inode(state->inode, sattr);
 		nfs_post_op_update_inode(state->inode, &fattr);
+
+		nfs_fattr_fini(&fattr);
 	}
 	if (status == 0 && (nd->flags & LOOKUP_OPEN) != 0)
 		status = nfs4_intent_set_file(nd, &path, state);
@@ -1934,12 +1975,18 @@ static int _nfs4_proc_remove(struct inode *dir, struct qstr *name)
 	};
 	int			status;
 
+	memset(&res.dir_attr, 0, sizeof(struct nfs_fattr));
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (server->caps & NFS_CAP_SECURITY_LABEL)
+		nfs_fattr_alloc(&res.dir_attr);
+#endif
 	nfs_fattr_init(&res.dir_attr);
 	status = rpc_call_sync(server->client, &msg, 0);
 	if (status == 0) {
 		update_changeattr(dir, &res.cinfo);
 		nfs_post_op_update_inode(dir, &res.dir_attr);
 	}
+	nfs_fattr_fini(&res.dir_attr);
 	return status;
 }
 
@@ -1964,6 +2011,13 @@ static void nfs4_proc_unlink_setup(struct rpc_message *msg, struct inode *dir)
 	args->bitmask = server->attr_bitmask;
 	res->server = server;
 	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_REMOVE];
+
+	memset(&res->dir_attr, 0, sizeof(struct nfs_fattr));
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (server->caps & NFS_CAP_SECURITY_LABEL)
+		nfs_fattr_alloc(&res->dir_attr);
+#endif
+	nfs_fattr_init(&res->dir_attr);
 }
 
 static int nfs4_proc_unlink_done(struct rpc_task *task, struct inode *dir)
@@ -1974,6 +2028,7 @@ static int nfs4_proc_unlink_done(struct rpc_task *task, struct inode *dir)
 		return 0;
 	update_changeattr(dir, &res->cinfo);
 	nfs_post_op_update_inode(dir, &res->dir_attr);
+	nfs_fattr_fini(&res->dir_attr);
 	return 1;
 }
 
@@ -2001,6 +2056,15 @@ static int _nfs4_proc_rename(struct inode *old_dir, struct qstr *old_name,
 	};
 	int			status;
 	
+
+	memset(&old_fattr, 0, sizeof(struct nfs_fattr));
+	memset(&new_fattr, 0, sizeof(struct nfs_fattr));
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (server->caps & NFS_CAP_SECURITY_LABEL) {
+		nfs_fattr_alloc(&old_fattr);
+		nfs_fattr_alloc(&new_fattr);
+	}
+#endif
 	nfs_fattr_init(res.old_fattr);
 	nfs_fattr_init(res.new_fattr);
 	status = rpc_call_sync(server->client, &msg, 0);
@@ -2011,6 +2075,8 @@ static int _nfs4_proc_rename(struct inode *old_dir, struct qstr *old_name,
 		update_changeattr(new_dir, &res.new_cinfo);
 		nfs_post_op_update_inode(new_dir, res.new_fattr);
 	}
+	nfs_fattr_fini(&old_fattr);
+	nfs_fattr_fini(&new_fattr);
 	return status;
 }
 
@@ -2050,6 +2116,16 @@ static int _nfs4_proc_link(struct inode *inode, struct inode *dir, struct qstr *
 	};
 	int			status;
 
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
+	memset(&dir_attr, 0, sizeof(struct nfs_fattr));
+
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (server->caps & NFS_CAP_SECURITY_LABEL) {
+		nfs_fattr_alloc(&fattr);
+		nfs_fattr_alloc(&dir_attr);
+	}
+#endif
+
 	nfs_fattr_init(res.fattr);
 	nfs_fattr_init(res.dir_attr);
 	status = rpc_call_sync(server->client, &msg, 0);
@@ -2059,6 +2135,8 @@ static int _nfs4_proc_link(struct inode *inode, struct inode *dir, struct qstr *
 		nfs_post_op_update_inode(inode, res.fattr);
 	}
 
+	nfs_fattr_fini(&fattr);
+	nfs_fattr_fini(&dir_attr);
 	return status;
 }
 
@@ -2104,6 +2182,16 @@ static int _nfs4_proc_symlink(struct inode *dir, struct dentry *dentry,
 	if (len > NFS4_MAXPATHLEN)
 		return -ENAMETOOLONG;
 
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
+	memset(&dir_fattr, 0, sizeof(struct nfs_fattr));
+
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (server->caps & NFS_CAP_SECURITY_LABEL) {
+		nfs_fattr_alloc(&fattr);
+		nfs_fattr_alloc(&dir_fattr);
+	}
+#endif
+
 	arg.u.symlink.pages = &page;
 	arg.u.symlink.len = len;
 	nfs_fattr_init(&fattr);
@@ -2115,6 +2203,8 @@ static int _nfs4_proc_symlink(struct inode *dir, struct dentry *dentry,
 		nfs_post_op_update_inode(dir, res.dir_fattr);
 		status = nfs_instantiate(dentry, &fhandle, &fattr);
 	}
+	nfs_fattr_fini(&fattr);
+	nfs_fattr_fini(&dir_fattr);
 	return status;
 }
 
@@ -2159,6 +2249,16 @@ static int _nfs4_proc_mkdir(struct inode *dir, struct dentry *dentry,
 	};
 	int			status;
 
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
+	memset(&dir_fattr, 0, sizeof(struct nfs_fattr));
+
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (server->caps & NFS_CAP_SECURITY_LABEL) {
+		nfs_fattr_alloc(&fattr);
+		nfs_fattr_alloc(&dir_fattr);
+	}
+#endif
+
 	nfs_fattr_init(&fattr);
 	nfs_fattr_init(&dir_fattr);
 	
@@ -2168,6 +2268,8 @@ static int _nfs4_proc_mkdir(struct inode *dir, struct dentry *dentry,
 		nfs_post_op_update_inode(dir, res.dir_fattr);
 		status = nfs_instantiate(dentry, &fhandle, &fattr);
 	}
+	nfs_fattr_fini(&fattr);
+	nfs_fattr_fini(&dir_fattr);
 	return status;
 }
 
@@ -2261,6 +2363,15 @@ static int _nfs4_proc_mknod(struct inode *dir, struct dentry *dentry,
 	int			status;
 	int                     mode = sattr->ia_mode;
 
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
+	memset(&dir_fattr, 0, sizeof(struct nfs_fattr));
+
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (server->caps & NFS_CAP_SECURITY_LABEL) {
+		nfs_fattr_alloc(&fattr);
+		nfs_fattr_alloc(&dir_fattr);
+	}
+#endif
 	nfs_fattr_init(&fattr);
 	nfs_fattr_init(&dir_fattr);
 
@@ -2287,6 +2398,8 @@ static int _nfs4_proc_mknod(struct inode *dir, struct dentry *dentry,
 		nfs_post_op_update_inode(dir, res.dir_fattr);
 		status = nfs_instantiate(dentry, &fh, &fattr);
 	}
+	nfs_fattr_fini(&fattr);
+	nfs_fattr_fini(&dir_fattr);
 	return status;
 }
 
@@ -3001,6 +3114,11 @@ static void nfs4_delegreturn_prepare(struct rpc_task *task, void *calldata)
 		.rpc_resp = &data->res,
 		.rpc_cred = data->cred,
 	};
+	memset(data->res.fattr, 0, sizeof(struct nfs_fattr));
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (data->res.server->caps & NFS_CAP_SECURITY_LABEL)
+		nfs_fattr_alloc(data->res.fattr);
+#endif
 	nfs_fattr_init(data->res.fattr);
 	rpc_call_setup(task, &msg, 0);
 }
@@ -3017,6 +3135,7 @@ static void nfs4_delegreturn_release(void *calldata)
 {
 	struct nfs4_delegreturndata *data = calldata;
 
+	nfs_fattr_fini(data->res.fattr);
 	put_rpccred(data->cred);
 	kfree(calldata);
 }
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 4f80d88..76f9951 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -208,12 +208,15 @@ nfs_proc_create(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 	};
 	int			status;
 
-	nfs_fattr_init(&fattr);
 	dprintk("NFS call  create %s\n", dentry->d_name.name);
+
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
+	nfs_fattr_init(&fattr);
 	status = rpc_call_sync(NFS_CLIENT(dir), &msg, 0);
 	nfs_mark_for_revalidate(dir);
 	if (status == 0)
 		status = nfs_instantiate(dentry, &fhandle, &fattr);
+	nfs_fattr_fini(&fattr);
 	dprintk("NFS reply create: %d\n", status);
 	return status;
 }
@@ -255,6 +258,7 @@ nfs_proc_mknod(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 		sattr->ia_size = new_encode_dev(rdev);/* get out your barf bag */
 	}
 
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
 	nfs_fattr_init(&fattr);
 	status = rpc_call_sync(NFS_CLIENT(dir), &msg, 0);
 	nfs_mark_for_revalidate(dir);
@@ -266,6 +270,7 @@ nfs_proc_mknod(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 	}
 	if (status == 0)
 		status = nfs_instantiate(dentry, &fhandle, &fattr);
+	nfs_fattr_fini(&fattr);
 	dprintk("NFS reply mknod: %d\n", status);
 	return status;
 }
@@ -378,6 +383,8 @@ nfs_proc_symlink(struct inode *dir, struct dentry *dentry, struct page *page,
 
 	dprintk("NFS call  symlink %s\n", dentry->d_name.name);
 
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
+
 	status = rpc_call_sync(NFS_CLIENT(dir), &msg, 0);
 	nfs_mark_for_revalidate(dir);
 
@@ -392,6 +399,7 @@ nfs_proc_symlink(struct inode *dir, struct dentry *dentry, struct page *page,
 		status = nfs_instantiate(dentry, &fhandle, &fattr);
 	}
 
+	nfs_fattr_fini(&fattr);
 	dprintk("NFS reply symlink: %d\n", status);
 	return status;
 }
@@ -419,11 +427,14 @@ nfs_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *sattr)
 	int			status;
 
 	dprintk("NFS call  mkdir %s\n", dentry->d_name.name);
+
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
 	nfs_fattr_init(&fattr);
 	status = rpc_call_sync(NFS_CLIENT(dir), &msg, 0);
 	nfs_mark_for_revalidate(dir);
 	if (status == 0)
 		status = nfs_instantiate(dentry, &fhandle, &fattr);
+	nfs_fattr_fini(&fattr);
 	dprintk("NFS reply mkdir: %d\n", status);
 	return status;
 }
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index fa517ae..c8f64da 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -340,6 +340,8 @@ static int nfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	};
 	int error;
 
+	memset(&fattr, 0, sizeof(struct nfs_fattr));
+
 	lock_kernel();
 
 	error = server->nfs_client->rpc_ops->statfs(server, fh, &res);
@@ -374,11 +376,13 @@ static int nfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_namelen = server->namelen;
 
 	unlock_kernel();
+	nfs_fattr_fini(&fattr);
 	return 0;
 
  out_err:
 	dprintk("%s: statfs error = %d\n", __FUNCTION__, -error);
 	unlock_kernel();
+	nfs_fattr_fini(&fattr);
 	return error;
 }
 
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index af90403..d7130b4 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -21,7 +21,6 @@
 #define NFS4_FHSIZE		128
 #define NFS4_MAXPATHLEN		PATH_MAX
 #define NFS4_MAXNAMLEN		NAME_MAX
-#define NFS4_MAXLABELLEN	255
 
 #define NFS4_ACCESS_READ        0x0001
 #define NFS4_ACCESS_LOOKUP      0x0002
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index e82a6eb..de22a0d 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -564,6 +564,43 @@ extern void * nfs_root_data(void);
 # else
 #  define ifdebug(fac)		if (0)
 # endif
+
+
+/*This was originally in nfs4.h however it can't be since it is
+ *  used nfsv3 code */
+#define NFS_MAXLABELLEN	255
+
+#ifdef CONFIG_SECURITY
+#define	nfs_fattr_alloc(fattr)						\
+{									\
+	(fattr)->label = kmalloc(NFS_MAXLABELLEN, GFP_ATOMIC);		\
+	(fattr)->label_len = NFS_MAXLABELLEN;				\
+	memset((fattr)->label, 0, NFS_MAXLABELLEN);			\
+}
+
+#define	nfs_fattr_fini(fattr)						\
+{									\
+	if ((fattr)->label == NULL) {					\
+		if ((fattr)->label_len != 0) {				\
+			printk("%s:%d %s() nfs_fattr label available (%d)\n",\
+					__FILE__, __LINE__, __func__,	\
+					(fattr)->label_len);		\
+		}							\
+	} else {							\
+		if ((fattr)->label_len == NFS_MAXLABELLEN)		\
+		printk("%s:%d %s() nfs_fattr label unused\n",		\
+				__FILE__, __LINE__, __func__);		\
+									\
+		kfree((fattr)->label);					\
+		(fattr)->label = NULL;					\
+		(fattr)->label_len = 0;					\
+	}								\
+}
+#else
+#define nfs_fattr_alloc(fattr)
+#define nfs_fattr_fini(fattr)
+#endif /* CONFIG_SECURITY */
+
 #endif /* __KERNEL */
 
 #endif
-- 
1.5.3.4



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
