Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2SEWTcO017210
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2008 10:32:29 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2SEWQ7C009518
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2008 14:32:26 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 21/45] CacheFiles: Be consistent about the use of mapping vs
	file->f_mapping in Ext3 [ver #35]
To: torvalds@osdl.org, akpm@linux-foundation.org, trond.myklebust@fys.uio.no,
        chuck.lever@oracle.com
Cc: nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Fri, 28 Mar 2008 14:31:58 +0000
Message-ID: <20080328143158.3483.98191.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080328143010.3483.99079.stgit@warthog.procyon.org.uk>
References: <20080328143010.3483.99079.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Change all the usages of file->f_mapping in ext3_*write_end() functions to use
the mapping argument directly.  This has two consequences:

 (*) Consistency.  Without this patch sometimes one is used and sometimes the
     other is.

 (*) A NULL file pointer can be passed.  This feature is then made use of by
     the generic hook in the next patch, which is used by CacheFiles to write
     pages to a file without setting up a file struct.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/ext3/inode.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff --git a/fs/ext3/inode.c b/fs/ext3/inode.c
index eb95670..c976123 100644
--- a/fs/ext3/inode.c
+++ b/fs/ext3/inode.c
@@ -1215,7 +1215,7 @@ static int ext3_generic_write_end(struct file *file,
 				loff_t pos, unsigned len, unsigned copied,
 				struct page *page, void *fsdata)
 {
-	struct inode *inode = file->f_mapping->host;
+	struct inode *inode = mapping->host;
 
 	copied = block_write_end(file, mapping, pos, len, copied, page, fsdata);
 
@@ -1240,7 +1240,7 @@ static int ext3_ordered_write_end(struct file *file,
 				struct page *page, void *fsdata)
 {
 	handle_t *handle = ext3_journal_current_handle();
-	struct inode *inode = file->f_mapping->host;
+	struct inode *inode = mapping->host;
 	unsigned from, to;
 	int ret = 0, ret2;
 
@@ -1281,7 +1281,7 @@ static int ext3_writeback_write_end(struct file *file,
 				struct page *page, void *fsdata)
 {
 	handle_t *handle = ext3_journal_current_handle();
-	struct inode *inode = file->f_mapping->host;
+	struct inode *inode = mapping->host;
 	int ret = 0, ret2;
 	loff_t new_i_size;
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
