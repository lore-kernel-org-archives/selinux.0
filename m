From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> 
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org, sds@tycho.nsa.gov,
        trond.myklebust@fys.uio.no
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        aviro@redhat.com, steved@redhat.com
Subject: [PATCH 22/19] FS-Cache: NFS: Rename NFS_INO_CACHEABLE
Date: Wed, 15 Nov 2006 13:23:24 +0000
Message-ID: <24065.1163597004@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Rename NFS_INO_CACHEABLE and NFS_CACHEABLE to be NFS_INO_FSCACHE and
NFS_FSCACHE.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/nfs/fscache.h       |    8 ++++----
 include/linux/nfs_fs.h |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 0be6ffe..b82b896 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -94,7 +94,7 @@ static inline void nfs_fscache_init_fh_c
 {
 	NFS_I(inode)->fscache = NULL;
 	if (S_ISREG(inode->i_mode))
-		set_bit(NFS_INO_CACHEABLE, &NFS_I(inode)->flags);
+		set_bit(NFS_INO_FSCACHE, &NFS_I(inode)->flags);
 }
 
 /*
@@ -105,7 +105,7 @@ static inline void nfs_fscache_enable_fh
 	struct super_block *sb = inode->i_sb;
 	struct nfs_inode *nfsi = NFS_I(inode);
 
-	if (nfsi->fscache || !NFS_CACHEABLE(inode))
+	if (nfsi->fscache || !NFS_FSCACHE(inode))
 		return;
 
 	if ((NFS_SB(sb)->flags & NFS_MOUNT_FSCACHE)) {
@@ -190,7 +190,7 @@ static inline void nfs_fscache_zap_fh_co
  */
 static inline void nfs_fscache_disable_fh_cookie(struct inode *inode)
 {
-	clear_bit(NFS_INO_CACHEABLE, &NFS_I(inode)->flags);
+	clear_bit(NFS_INO_FSCACHE, &NFS_I(inode)->flags);
 
 	if (NFS_I(inode)->fscache) {
 		dfprintk(FSCACHE,
@@ -214,7 +214,7 @@ static inline void nfs_fscache_disable_f
 static inline void nfs_fscache_set_fh_cookie(struct inode *inode,
 					     struct file *filp)
 {
-	if (NFS_CACHEABLE(inode)) {
+	if (NFS_FSCACHE(inode)) {
 		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
 			nfs_fscache_disable_fh_cookie(inode);
 		else
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index b2e5e86..59e433f 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -205,7 +205,7 @@ #define NFS_INO_REVALIDATING	(0)		/* rev
 #define NFS_INO_ADVISE_RDPLUS	(1)		/* advise readdirplus */
 #define NFS_INO_STALE		(2)		/* possible stale inode */
 #define NFS_INO_ACL_LRU_SET	(3)		/* Inode is on the LRU list */
-#define NFS_INO_CACHEABLE	(4)		/* inode can be cached by FS-Cache */
+#define NFS_INO_FSCACHE		(4)		/* inode can be cached by FS-Cache */
 
 static inline struct nfs_inode *NFS_I(struct inode *inode)
 {
@@ -231,7 +231,7 @@ #define NFS_ATTRTIMEO_UPDATE(inode)	(NFS
 
 #define NFS_FLAGS(inode)		(NFS_I(inode)->flags)
 #define NFS_STALE(inode)		(test_bit(NFS_INO_STALE, &NFS_FLAGS(inode)))
-#define NFS_CACHEABLE(inode)		(test_bit(NFS_INO_CACHEABLE, &NFS_FLAGS(inode)))
+#define NFS_FSCACHE(inode)		(test_bit(NFS_INO_FSCACHE, &NFS_FLAGS(inode)))
 
 #define NFS_FILEID(inode)		(NFS_I(inode)->fileid)
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
