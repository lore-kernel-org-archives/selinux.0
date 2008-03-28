Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2SF5MUO024051
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2008 11:05:22 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2SF4qUA018693
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2008 15:05:21 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 29/45] NFS: Add comment banners to some NFS functions [ver #35]
To: torvalds@osdl.org, akpm@linux-foundation.org, trond.myklebust@fys.uio.no,
        chuck.lever@oracle.com
Cc: nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Fri, 28 Mar 2008 14:32:39 +0000
Message-ID: <20080328143239.3483.39046.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080328143010.3483.99079.stgit@warthog.procyon.org.uk>
References: <20080328143010.3483.99079.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add comment banners to some NFS functions so that they can be modified by the
NFS fscache patches for further information.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/nfs/file.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)


diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index ef57a5a..26a073b 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -354,6 +354,13 @@ static int nfs_write_end(struct file *file, struct address_space *mapping,
 	return copied;
 }
 
+/*
+ * Partially or wholly invalidate a page
+ * - Release the private state associated with a page if undergoing complete
+ *   page invalidation
+ * - Called if either PG_private or PG_private_2 is set on the page
+ * - Caller holds page lock
+ */
 static void nfs_invalidate_page(struct page *page, unsigned long offset)
 {
 	if (offset != 0)
@@ -362,12 +369,26 @@ static void nfs_invalidate_page(struct page *page, unsigned long offset)
 	nfs_wb_page_cancel(page->mapping->host, page);
 }
 
+/*
+ * Attempt to release the private state associated with a page
+ * - Called if either PG_private or PG_private_2 is set on the page
+ * - Caller holds page lock
+ * - Return true (may release page) or false (may not)
+ */
 static int nfs_release_page(struct page *page, gfp_t gfp)
 {
 	/* If PagePrivate() is set, then the page is not freeable */
 	return 0;
 }
 
+/*
+ * Attempt to clear the private state associated with a page when an error
+ * occurs that requires the cached contents of an inode to be written back or
+ * destroyed
+ * - Called if either PG_private or PG_private_2 is set on the page
+ * - Caller holds page lock
+ * - Return 0 if successful, -error otherwise
+ */
 static int nfs_launder_page(struct page *page)
 {
 	return nfs_wb_page(page->mapping->host, page);
@@ -389,6 +410,11 @@ const struct address_space_operations nfs_file_aops = {
 	.launder_page = nfs_launder_page,
 };
 
+/*
+ * Notification that a PTE pointing to an NFS page is about to be made
+ * writable, implying that someone is about to modify the page through a
+ * shared-writable mapping
+ */
 static int nfs_vm_page_mkwrite(struct vm_area_struct *vma, struct page *page)
 {
 	struct file *filp = vma->vm_file;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
