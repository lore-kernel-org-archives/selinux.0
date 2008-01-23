Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0NHLqdP022210
	for <selinux@tycho.nsa.gov>; Wed, 23 Jan 2008 12:21:52 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0NHLpeY021541
	for <selinux@tycho.nsa.gov>; Wed, 23 Jan 2008 17:21:51 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 13/27] FS-Cache: Release page->private after failed readahead
	[try #2]
To: Trond.Myklebust@netapp.com
Cc: nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Wed, 23 Jan 2008 17:21:48 +0000
Message-ID: <20080123172148.11107.2607.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080123172038.11107.86025.stgit@warthog.procyon.org.uk>
References: <20080123172038.11107.86025.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The attached patch causes read_cache_pages() to release page-private data on a
page for which add_to_page_cache() fails or the filler function fails. This
permits pages with caching references associated with them to be cleaned up.

The invalidatepage() address space op is called (indirectly) to do the honours.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 mm/readahead.c |   39 +++++++++++++++++++++++++++++++++++++--
 1 files changed, 37 insertions(+), 2 deletions(-)


diff --git a/mm/readahead.c b/mm/readahead.c
index c9c50ca..75aa6b6 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -44,6 +44,41 @@ EXPORT_SYMBOL_GPL(file_ra_state_init);
 
 #define list_to_page(head) (list_entry((head)->prev, struct page, lru))
 
+/*
+ * see if a page needs releasing upon read_cache_pages() failure
+ * - the caller of read_cache_pages() may have set PG_private before calling,
+ *   such as the NFS fs marking pages that are cached locally on disk, thus we
+ *   need to give the fs a chance to clean up in the event of an error
+ */
+static void read_cache_pages_invalidate_page(struct address_space *mapping,
+					     struct page *page)
+{
+	if (PagePrivate(page)) {
+		if (TestSetPageLocked(page))
+			BUG();
+		page->mapping = mapping;
+		do_invalidatepage(page, 0);
+		page->mapping = NULL;
+		unlock_page(page);
+	}
+	page_cache_release(page);
+}
+
+/*
+ * release a list of pages, invalidating them first if need be
+ */
+static void read_cache_pages_invalidate_pages(struct address_space *mapping,
+					      struct list_head *pages)
+{
+	struct page *victim;
+
+	while (!list_empty(pages)) {
+		victim = list_to_page(pages);
+		list_del(&victim->lru);
+		read_cache_pages_invalidate_page(mapping, victim);
+	}
+}
+
 /**
  * read_cache_pages - populate an address space with some pages & start reads against them
  * @mapping: the address_space
@@ -65,14 +100,14 @@ int read_cache_pages(struct address_space *mapping, struct list_head *pages,
 		list_del(&page->lru);
 		if (add_to_page_cache_lru(page, mapping,
 					page->index, GFP_KERNEL)) {
-			page_cache_release(page);
+			read_cache_pages_invalidate_page(mapping, page);
 			continue;
 		}
 		page_cache_release(page);
 
 		ret = filler(data, page);
 		if (unlikely(ret)) {
-			put_pages_list(pages);
+			read_cache_pages_invalidate_pages(mapping, pages);
 			break;
 		}
 		task_io_account_read(PAGE_CACHE_SIZE);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
