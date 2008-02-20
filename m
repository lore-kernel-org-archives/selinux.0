Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1KGiYW6004462
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 11:44:34 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1KGiRBu011669
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 16:44:33 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 33/37] NFS: nfs_readpage_async() needs to be accessible as a
	fallback for local caching
To: Trond.Myklebust@netapp.com, chuck.lever@oracle.com, casey@schaufler-ca.com
Cc: nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Wed, 20 Feb 2008 16:08:55 +0000
Message-ID: <20080220160855.4715.84031.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080220160557.4715.66608.stgit@warthog.procyon.org.uk>
References: <20080220160557.4715.66608.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

nfs_readpage_async() needs to be non-static so that it can be used as a
fallback for the local on-disk caching should an EIO crop up when reading the
cache.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/nfs/read.c          |    4 ++--
 include/linux/nfs_fs.h |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)


diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 3d7d963..725a5a2 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -114,8 +114,8 @@ static void nfs_readpage_truncate_uninitialised_page(struct nfs_read_data *data)
 	}
 }
 
-static int nfs_readpage_async(struct nfs_open_context *ctx, struct inode *inode,
-		struct page *page)
+int nfs_readpage_async(struct nfs_open_context *ctx, struct inode *inode,
+		       struct page *page)
 {
 	LIST_HEAD(one_request);
 	struct nfs_page	*new;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index d9adb53..d1d545e 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -505,6 +505,8 @@ extern int  nfs_readpages(struct file *, struct address_space *,
 		struct list_head *, unsigned);
 extern int  nfs_readpage_result(struct rpc_task *, struct nfs_read_data *);
 extern void nfs_readdata_release(void *data);
+extern int  nfs_readpage_async(struct nfs_open_context *, struct inode *,
+			       struct page *);
 
 /*
  * Allocate nfs_read_data structures


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
