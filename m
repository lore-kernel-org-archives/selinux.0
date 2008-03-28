Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2SF5lxv024421
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2008 11:05:47 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2SF4qUM018693
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2008 15:05:43 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 42/45] NFS: Read pages from FS-Cache into an NFS inode [ver
	#35]
To: torvalds@osdl.org, akpm@linux-foundation.org, trond.myklebust@fys.uio.no,
        chuck.lever@oracle.com
Cc: nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Fri, 28 Mar 2008 14:33:46 +0000
Message-ID: <20080328143346.3483.9477.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080328143010.3483.99079.stgit@warthog.procyon.org.uk>
References: <20080328143010.3483.99079.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Read pages from an FS-Cache data storage object representing an inode into an
NFS inode.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/nfs/fscache.c |  112 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/fscache.h |   47 +++++++++++++++++++++++
 fs/nfs/read.c    |   18 +++++++++
 3 files changed, 177 insertions(+), 0 deletions(-)


diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index d06f837..d147bd0 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -391,3 +391,115 @@ void __nfs_fscache_invalidate_page(struct page *page, struct inode *inode)
 	nfs_add_fscache_stats(page->mapping->host,
 			      NFSIOS_FSCACHE_PAGES_UNCACHED, 1);
 }
+
+/*
+ * Handle completion of a page being read from the cache.
+ * - Called in process (keventd) context.
+ */
+static void nfs_readpage_from_fscache_complete(struct page *page,
+					       void *context,
+					       int error)
+{
+	dfprintk(FSCACHE,
+		 "NFS: readpage_from_fscache_complete (0x%p/0x%p/%d)\n",
+		 page, context, error);
+
+	/* if the read completes with an error, we just unlock the page and let
+	 * the VM reissue the readpage */
+	if (!error) {
+		SetPageUptodate(page);
+		unlock_page(page);
+	} else {
+		error = nfs_readpage_async(context, page->mapping->host, page);
+		if (error)
+			unlock_page(page);
+	}
+}
+
+/*
+ * Retrieve a page from fscache
+ */
+int __nfs_readpage_from_fscache(struct nfs_open_context *ctx,
+				struct inode *inode, struct page *page)
+{
+	int ret;
+
+	dfprintk(FSCACHE,
+		 "NFS: readpage_from_fscache(fsc:%p/p:%p(i:%lx f:%lx)/0x%p)\n",
+		 NFS_I(inode)->fscache, page, page->index, page->flags, inode);
+
+	ret = fscache_read_or_alloc_page(NFS_I(inode)->fscache,
+					 page,
+					 nfs_readpage_from_fscache_complete,
+					 ctx,
+					 GFP_KERNEL);
+
+	switch (ret) {
+	case 0: /* read BIO submitted (page in fscache) */
+		dfprintk(FSCACHE,
+			 "NFS:    readpage_from_fscache: BIO submitted\n");
+		nfs_add_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_OK, 1);
+		return ret;
+
+	case -ENOBUFS: /* inode not in cache */
+	case -ENODATA: /* page not in cache */
+		nfs_add_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_FAIL, 1);
+		dfprintk(FSCACHE,
+			 "NFS:    readpage_from_fscache %d\n", ret);
+		return 1;
+
+	default:
+		dfprintk(FSCACHE, "NFS:    readpage_from_fscache %d\n", ret);
+		nfs_add_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_FAIL, 1);
+	}
+	return ret;
+}
+
+/*
+ * Retrieve a set of pages from fscache
+ */
+int __nfs_readpages_from_fscache(struct nfs_open_context *ctx,
+				 struct inode *inode,
+				 struct address_space *mapping,
+				 struct list_head *pages,
+				 unsigned *nr_pages)
+{
+	int ret, npages = *nr_pages;
+
+	dfprintk(FSCACHE, "NFS: nfs_getpages_from_fscache (0x%p/%u/0x%p)\n",
+		 NFS_I(inode)->fscache, npages, inode);
+
+	ret = fscache_read_or_alloc_pages(NFS_I(inode)->fscache,
+					  mapping, pages, nr_pages,
+					  nfs_readpage_from_fscache_complete,
+					  ctx,
+					  mapping_gfp_mask(mapping));
+	if (*nr_pages < npages)
+		nfs_add_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_OK,
+				      npages);
+	if (*nr_pages > 0)
+		nfs_add_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_FAIL,
+				      *nr_pages);
+
+	switch (ret) {
+	case 0: /* read submitted to the cache for all pages */
+		BUG_ON(!list_empty(pages));
+		BUG_ON(*nr_pages != 0);
+		dfprintk(FSCACHE,
+			 "NFS: nfs_getpages_from_fscache: submitted\n");
+
+		return ret;
+
+	case -ENOBUFS: /* some pages aren't cached and can't be */
+	case -ENODATA: /* some pages aren't cached */
+		dfprintk(FSCACHE,
+			 "NFS: nfs_getpages_from_fscache: no page: %d\n", ret);
+		return 1;
+
+	default:
+		dfprintk(FSCACHE,
+			 "NFS: nfs_getpages_from_fscache: ret  %d\n", ret);
+	}
+
+	return ret;
+}
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index e17cc1b..52f0ccf 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -87,6 +87,12 @@ extern void nfs_fscache_attr_changed(struct inode *);
 extern void __nfs_fscache_invalidate_page(struct page *, struct inode *);
 extern int nfs_fscache_release_page(struct page *, gfp_t);
 
+extern int __nfs_readpage_from_fscache(struct nfs_open_context *,
+				       struct inode *, struct page *);
+extern int __nfs_readpages_from_fscache(struct nfs_open_context *,
+					struct inode *, struct address_space *,
+					struct list_head *, unsigned *);
+
 /*
  * release the caching state associated with a page if undergoing complete page
  * invalidation
@@ -98,6 +104,32 @@ static inline void nfs_fscache_invalidate_page(struct page *page,
 		__nfs_fscache_invalidate_page(page, inode);
 }
 
+/*
+ * Retrieve a page from an inode data storage object.
+ */
+static inline int nfs_readpage_from_fscache(struct nfs_open_context *ctx,
+					    struct inode *inode,
+					    struct page *page)
+{
+	if (NFS_I(inode)->fscache)
+		return __nfs_readpage_from_fscache(ctx, inode, page);
+	return -ENOBUFS;
+}
+
+/*
+ * Retrieve a set of pages from an inode data storage object.
+ */
+static inline int nfs_readpages_from_fscache(struct nfs_open_context *ctx,
+					     struct inode *inode,
+					     struct address_space *mapping,
+					     struct list_head *pages,
+					     unsigned *nr_pages)
+{
+	if (NFS_I(inode)->fscache)
+		return __nfs_readpages_from_fscache(ctx, inode, mapping, pages,
+						    nr_pages);
+	return -ENOBUFS;
+}
 
 #else /* CONFIG_NFS_FSCACHE */
 static inline int nfs_fscache_register(void) { return 0; }
@@ -128,5 +160,20 @@ static inline int nfs_fscache_release_page(struct page *page, gfp_t gfp)
 static inline void nfs_fscache_invalidate_page(struct page *page,
 					       struct inode *inode) {}
 
+static inline int nfs_readpage_from_fscache(struct nfs_open_context *ctx,
+					    struct inode *inode,
+					    struct page *page)
+{
+	return -ENOBUFS;
+}
+static inline int nfs_readpages_from_fscache(struct nfs_open_context *ctx,
+					     struct inode *inode,
+					     struct address_space *mapping,
+					     struct list_head *pages,
+					     unsigned *nr_pages)
+{
+	return -ENOBUFS;
+}
+
 #endif /* CONFIG_NFS_FSCACHE */
 #endif /* _NFS_FSCACHE_H */
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 2b61a0b..63be802 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -24,6 +24,7 @@
 
 #include "internal.h"
 #include "iostat.h"
+#include "fscache.h"
 
 #define NFSDBG_FACILITY		NFSDBG_PAGECACHE
 
@@ -493,9 +494,16 @@ int nfs_readpage(struct file *file, struct page *page)
 			goto out_unlock;
 	} else
 		ctx = get_nfs_open_context(nfs_file_open_context(file));
+ 
+	if (!IS_SYNC(inode)) {
+		error = nfs_readpage_from_fscache(ctx, inode, page);
+		if (error == 0)
+			goto out;
+	}
 
 	error = nfs_readpage_async(ctx, inode, page);
 
+out:
 	put_nfs_open_context(ctx);
 	return error;
 out_unlock:
@@ -574,6 +582,15 @@ int nfs_readpages(struct file *filp, struct address_space *mapping,
 			return -EBADF;
 	} else
 		desc.ctx = get_nfs_open_context(nfs_file_open_context(filp));
+
+	/* attempt to read as many of the pages as possible from the cache
+	 * - this returns -ENOBUFS immediately if the cookie is negative
+	 */
+	ret = nfs_readpages_from_fscache(desc.ctx, inode, mapping,
+					 pages, &nr_pages);
+	if (ret == 0)
+		goto read_complete; /* all pages were read */
+
 	if (rsize < PAGE_CACHE_SIZE)
 		nfs_pageio_init(&pgio, inode, nfs_pagein_multi, rsize, 0);
 	else
@@ -584,6 +601,7 @@ int nfs_readpages(struct file *filp, struct address_space *mapping,
 	nfs_pageio_complete(&pgio);
 	npages = (pgio.pg_bytes_written + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 	nfs_add_stats(inode, NFSIOS_READPAGES, npages);
+read_complete:
 	put_nfs_open_context(desc.ctx);
 out:
 	return ret;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
