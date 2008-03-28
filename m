Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2SEYQNx017571
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2008 10:34:26 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2SEYMTs005166
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2008 14:34:23 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 43/45] NFS: Store pages from an NFS inode into a local cache
	[ver #35]
To: torvalds@osdl.org, akpm@linux-foundation.org, trond.myklebust@fys.uio.no,
        chuck.lever@oracle.com
Cc: nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Fri, 28 Mar 2008 14:33:51 +0000
Message-ID: <20080328143351.3483.864.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080328143010.3483.99079.stgit@warthog.procyon.org.uk>
References: <20080328143010.3483.99079.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Store pages from an NFS inode into the cache data storage object associated
with that inode.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/nfs/fscache.c |   28 ++++++++++++++++++++++++++++
 fs/nfs/fscache.h |   16 ++++++++++++++++
 fs/nfs/read.c    |    5 +++++
 3 files changed, 49 insertions(+), 0 deletions(-)


diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index d147bd0..5ca900a 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -503,3 +503,31 @@ int __nfs_readpages_from_fscache(struct nfs_open_context *ctx,
 
 	return ret;
 }
+
+/*
+ * Store a newly fetched page in fscache
+ * - PG_fscache must be set on the page
+ */
+void __nfs_readpage_to_fscache(struct inode *inode, struct page *page, int sync)
+{
+	int ret;
+
+	dfprintk(FSCACHE,
+		 "NFS: readpage_to_fscache(fsc:%p/p:%p(i:%lx f:%lx)/%d)\n",
+		 NFS_I(inode)->fscache, page, page->index, page->flags, sync);
+
+	ret = fscache_write_page(NFS_I(inode)->fscache, page, GFP_KERNEL);
+	dfprintk(FSCACHE,
+		 "NFS:     readpage_to_fscache: p:%p(i:%lu f:%lx) ret %d\n",
+		 page, page->index, page->flags, ret);
+
+	if (ret != 0) {
+		fscache_uncache_page(NFS_I(inode)->fscache, page);
+		nfs_add_fscache_stats(inode,
+				      NFSIOS_FSCACHE_PAGES_WRITTEN_FAIL, 1);
+		nfs_add_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_UNCACHED, 1);
+	} else {
+		nfs_add_fscache_stats(inode,
+				      NFSIOS_FSCACHE_PAGES_WRITTEN_OK, 1);
+	}
+}
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 52f0ccf..2f71d7e 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -92,6 +92,7 @@ extern int __nfs_readpage_from_fscache(struct nfs_open_context *,
 extern int __nfs_readpages_from_fscache(struct nfs_open_context *,
 					struct inode *, struct address_space *,
 					struct list_head *, unsigned *);
+extern void __nfs_readpage_to_fscache(struct inode *, struct page *, int);
 
 /*
  * release the caching state associated with a page if undergoing complete page
@@ -131,6 +132,19 @@ static inline int nfs_readpages_from_fscache(struct nfs_open_context *ctx,
 	return -ENOBUFS;
 }
 
+/*
+ * Store a page newly fetched from the server in an inode data storage object
+ * in the cache.
+ */
+static inline void nfs_readpage_to_fscache(struct inode *inode,
+					   struct page *page,
+					   int sync)
+{
+	if (PageFsCache(page))
+		__nfs_readpage_to_fscache(inode, page, sync);
+}
+
+
 #else /* CONFIG_NFS_FSCACHE */
 static inline int nfs_fscache_register(void) { return 0; }
 static inline void nfs_fscache_unregister(void) {}
@@ -174,6 +188,8 @@ static inline int nfs_readpages_from_fscache(struct nfs_open_context *ctx,
 {
 	return -ENOBUFS;
 }
+static inline void nfs_readpage_to_fscache(struct inode *inode,
+					   struct page *page, int sync) {}
 
 #endif /* CONFIG_NFS_FSCACHE */
 #endif /* _NFS_FSCACHE_H */
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 63be802..071dda1 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -143,6 +143,11 @@ int nfs_readpage_async(struct nfs_open_context *ctx, struct inode *inode,
 
 static void nfs_readpage_release(struct nfs_page *req)
 {
+	struct inode *d_inode = req->wb_context->path.dentry->d_inode;
+
+	if (PageUptodate(req->wb_page))
+		nfs_readpage_to_fscache(d_inode, req->wb_page, 0);
+
 	unlock_page(req->wb_page);
 
 	dprintk("NFS: read done (%s/%Ld %d@%Ld)\n",


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
