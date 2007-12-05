From: David Howells <dhowells@redhat.com>
Subject: [PATCH 24/28] AFS: Add a function to excise a rejected write from the
	pagecache [try #2]
To: viro@ftp.linux.org.uk, hch@infradead.org, Trond.Myklebust@netapp.com,
        sds@tycho.nsa.gov, casey@schaufler-ca.com
Cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Wed, 05 Dec 2007 19:40:20 +0000
Message-ID: <20071205194020.24617.28880.stgit@warthog.procyon.org.uk>
In-Reply-To: <20071205193818.24617.79771.stgit@warthog.procyon.org.uk>
References: <20071205193818.24617.79771.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add a function - cancel_rejected_write() - to excise a rejected write from the
pagecache.  This function is related to the truncation family of routines.  It
permits the pages modified by a network filesystem client (such as AFS) to be
excised and discarded from the pagecache if the attempt to write them back to
the server fails.

The dirty and writeback states of the afflicted pages are cancelled and the
pages themselves are detached for recycling.  All PTEs referring to those
pages are removed.

Note that the locking is tricky as it's very easy to deadlock against
truncate() and other routines once the pages have been unlocked as part of the
writeback process.  To this end, the PG_error flag is set, then the
PG_writeback flag is cleared, and only *then* can lock_page() be called.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/mm.h |    5 ++-
 mm/truncate.c      |   83 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 520238c..438270f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1005,12 +1005,13 @@ extern int do_munmap(struct mm_struct *, unsigned long, size_t);
 
 extern unsigned long do_brk(unsigned long, unsigned long);
 
-/* filemap.c */
-extern unsigned long page_unuse(struct page *);
+/* truncate.c */
 extern void truncate_inode_pages(struct address_space *, loff_t);
 extern void truncate_inode_pages_range(struct address_space *,
 				       loff_t lstart, loff_t lend);
+extern void cancel_rejected_write(struct address_space *, pgoff_t, pgoff_t);
 
+/* filemap.c */
 /* generic vm_area_ops exported for stackable file systems */
 extern int filemap_fault(struct vm_area_struct *, struct vm_fault *);
 
diff --git a/mm/truncate.c b/mm/truncate.c
index 5b7d1c5..95fc1a8 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -465,3 +465,86 @@ int invalidate_inode_pages2(struct address_space *mapping)
 	return invalidate_inode_pages2_range(mapping, 0, -1);
 }
 EXPORT_SYMBOL_GPL(invalidate_inode_pages2);
+
+/*
+ * Cancel that part of a rejected write that affects a particular page
+ */
+static void cancel_rejected_page(struct address_space *mapping,
+				 struct page *page, pgoff_t *_next)
+{
+	if (!TestSetPageError(page)) {
+		/* can't lock the page until we've cleared PG_writeback lest we
+		 * deadlock with truncate (amongst other things) */
+		end_page_writeback(page);
+		if (page->mapping == mapping) {
+			lock_page(page);
+			if (page->mapping == mapping) {
+				truncate_complete_page(mapping, page);
+				*_next = page->index + 1;
+			}
+			unlock_page(page);
+		}
+	} else if (PageWriteback(page) || PageDirty(page)) {
+		BUG();
+	}
+}
+
+/**
+ * cancel_rejected_write - Cancel a write on a contiguous set of pages
+ * @mapping: mapping affected
+ * @start: first page in set
+ * @end: last page in set
+ *
+ * Cancel a write of a contiguous set of pages when the writeback was rejected
+ * by the target medium or server.
+ *
+ * The pages in question are detached and discarded from the pagecache, and the
+ * writeback and dirty states are cleared prior to invalidation.  The caller
+ * must make sure that all the pages in the range are present in the pagecache,
+ * and the caller must hold PG_writeback on each of them.  NOTE! All the pages
+ * are locked and unlocked as part of this process, so the caller must take
+ * care to avoid deadlock.
+ *
+ * The PTEs pointing to those pages are also cleared, leading to the PTEs being
+ * reset when new pages are allocated and the contents reloaded.
+ */
+void cancel_rejected_write(struct address_space *mapping,
+			   pgoff_t start, pgoff_t end)
+{
+	struct pagevec pvec;
+	pgoff_t n;
+	int i;
+
+	BUG_ON(mapping->nrpages < end - start + 1);
+
+	/* dispose of any PTEs pointing to the affected pages */
+	unmap_mapping_range(mapping,
+			    (loff_t)start << PAGE_CACHE_SHIFT,
+			    (loff_t)(end - start + 1) << PAGE_CACHE_SHIFT,
+			    0);
+
+	pagevec_init(&pvec, 0);
+	do {
+		cond_resched();
+		n = end - start + 1;
+		if (n > PAGEVEC_SIZE)
+			n = PAGEVEC_SIZE;
+		n = pagevec_lookup(&pvec, mapping, start, n);
+		for (i = 0; i < n; i++) {
+			struct page *page = pvec.pages[i];
+
+			if (page->index < start || page->index > end)
+				continue;
+			start++;
+			cancel_rejected_page(mapping, page, &start);
+		}
+		pagevec_release(&pvec);
+	} while (start - 1 < end);
+
+	/* dispose of any new PTEs pointing to the affected pages */
+	unmap_mapping_range(mapping,
+			    (loff_t)start << PAGE_CACHE_SHIFT,
+			    (loff_t)(end - start + 1) << PAGE_CACHE_SHIFT,
+			    0);
+}
+EXPORT_SYMBOL_GPL(cancel_rejected_write);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
