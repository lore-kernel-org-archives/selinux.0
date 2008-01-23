Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0N0jZTd015360
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2008 19:45:35 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0N0jYps028982
	for <selinux@tycho.nsa.gov>; Wed, 23 Jan 2008 00:45:34 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 20/27] CacheFiles: Permit the page lock state to be monitored
To: Trond.Myklebust@netapp.com
Cc: nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Wed, 23 Jan 2008 00:45:32 +0000
Message-ID: <20080123004531.15602.96078.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080123004344.15602.35710.stgit@warthog.procyon.org.uk>
References: <20080123004344.15602.35710.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add a function to install a monitor on the page lock waitqueue for a particular
page, thus allowing the page being unlocked to be detected.

This is used by CacheFiles to detect read completion on a page in the backing
filesystem so that it can then copy the data to the waiting netfs page.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/pagemap.h |    5 +++++
 mm/filemap.c            |   18 ++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)


diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index f9e0f81..e9f37b3 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -223,6 +223,11 @@ static inline void wait_on_page_owner_priv_2(struct page *page)
 extern void end_page_owner_priv_2(struct page *page);
 
 /*
+ * Add an arbitrary waiter to a page's wait queue
+ */
+extern void add_page_wait_queue(struct page *page, wait_queue_t *waiter);
+
+/*
  * Fault a userspace page into pagetables.  Return non-zero on a fault.
  *
  * This assumes that two userspace pages are always sufficient.  That's
diff --git a/mm/filemap.c b/mm/filemap.c
index ed52b0b..4d50623 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -533,6 +533,24 @@ void fastcall wait_on_page_bit(struct page *page, int bit_nr)
 EXPORT_SYMBOL(wait_on_page_bit);
 
 /**
+ * add_page_wait_queue - Add an arbitrary waiter to a page's wait queue
+ * @page - Page defining the wait queue of interest
+ * @waiter - Waiter to add to the queue
+ *
+ * Add an arbitrary @waiter to the wait queue for the nominated @page.
+ */
+void add_page_wait_queue(struct page *page, wait_queue_t *waiter)
+{
+	wait_queue_head_t *q = page_waitqueue(page);
+	unsigned long flags;
+
+	spin_lock_irqsave(&q->lock, flags);
+	__add_wait_queue(q, waiter);
+	spin_unlock_irqrestore(&q->lock, flags);
+}
+EXPORT_SYMBOL_GPL(add_page_wait_queue);
+
+/**
  * unlock_page - unlock a locked page
  * @page: the page
  *


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
