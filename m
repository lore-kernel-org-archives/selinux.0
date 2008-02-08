Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m18Gt3bJ008403
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2008 11:55:03 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m18Gt2J4017019
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2008 16:55:02 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 32/37] NFS: Add read context retention for FS-Cache to call
	back with
To: Trond.Myklebust@netapp.com, chuck.lever@oracle.com
Cc: nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Fri, 08 Feb 2008 16:54:48 +0000
Message-ID: <20080208165448.15902.66028.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080208165156.15902.62457.stgit@warthog.procyon.org.uk>
References: <20080208165156.15902.62457.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add read context retention so that FS-Cache can call back into NFS when a read
operation on the cache fails EIO rather than reading data.  This permits NFS to
then fetch the data from the server instead using the appropriate security
context.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/nfs/fscache-index.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)


diff --git a/fs/nfs/fscache-index.c b/fs/nfs/fscache-index.c
index eec8e7e..af9f06b 100644
--- a/fs/nfs/fscache-index.c
+++ b/fs/nfs/fscache-index.c
@@ -285,6 +285,30 @@ static void nfs_cache_inode_now_uncached(void *cookie_netfs_data)
 }
 
 /*
+ * Get an extra reference on a read context.
+ * - This function can be absent if the completion function doesn't require a
+ *   context.
+ * - The read context is passed back to NFS in the event that a data read on the
+ *   cache fails with EIO - in which case the server must be contacted to
+ *   retrieve the data, which requires the read context for security.
+ */
+static void nfs_fh_get_context(void *cookie_netfs_data, void *context)
+{
+	get_nfs_open_context(context);
+}
+
+/*
+ * Release an extra reference on a read context.
+ * - This function can be absent if the completion function doesn't require a
+ *   context.
+ */
+static void nfs_fh_put_context(void *cookie_netfs_data, void *context)
+{
+	if (context)
+		put_nfs_open_context(context);
+}
+
+/*
  * Define the inode object for FS-Cache.  This is used to describe an inode
  * object to fscache_acquire_cookie().  It is keyed by the NFS file handle for
  * an inode.
@@ -301,4 +325,6 @@ const struct fscache_cookie_def nfs_cache_inode_object_def = {
 	.get_aux	= nfs_cache_inode_get_aux,
 	.check_aux	= nfs_cache_inode_check_aux,
 	.now_uncached	= nfs_cache_inode_now_uncached,
+	.get_context	= nfs_fh_get_context,
+	.put_context	= nfs_fh_put_context,
 };


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
