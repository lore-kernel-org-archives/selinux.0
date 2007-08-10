Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7AG7eiT017913
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 12:07:40 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7AG7d1t020908
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 16:07:39 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 16/16] NFS: Display local caching state [try #3]
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
        trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov
Date: Fri, 10 Aug 2007 17:06:18 +0100
Message-ID: <20070810160618.24698.67605.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20070810160455.24698.30983.stgit@warthog.cambridge.redhat.com>
References: <20070810160455.24698.30983.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Display the local caching state in /proc/fs/nfsfs/volumes.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/nfs/client.c  |    7 ++++---
 fs/nfs/fscache.h |   12 ++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 0de4db4..d350668 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1319,7 +1319,7 @@ static int nfs_volume_list_show(struct seq_file *m, void *v)
 
 	/* display header on line 1 */
 	if (v == &nfs_volume_list) {
-		seq_puts(m, "NV SERVER   PORT DEV     FSID\n");
+		seq_puts(m, "NV SERVER   PORT DEV     FSID              FSC\n");
 		return 0;
 	}
 	/* display one transport per line on subsequent lines */
@@ -1333,12 +1333,13 @@ static int nfs_volume_list_show(struct seq_file *m, void *v)
 		 (unsigned long long) server->fsid.major,
 		 (unsigned long long) server->fsid.minor);
 
-	seq_printf(m, "v%d %02x%02x%02x%02x %4hx %-7s %-17s\n",
+	seq_printf(m, "v%d %02x%02x%02x%02x %4hx %-7s %-17s %s\n",
 		   clp->cl_nfsversion,
 		   NIPQUAD(clp->cl_addr.sin_addr),
 		   ntohs(clp->cl_addr.sin_port),
 		   dev,
-		   fsid);
+		   fsid,
+		   nfs_server_fscache_state(server));
 
 	return 0;
 }
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 44bb0d1..77f3450 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -56,6 +56,17 @@ extern void __nfs_fscache_invalidate_page(struct page *, struct inode *);
 extern int nfs_fscache_release_page(struct page *, gfp_t);
 
 /*
+ * indicate the client caching state as readable text
+ */
+static inline const char *nfs_server_fscache_state(struct nfs_server *server)
+{
+	if (server->nfs_client->fscache &&
+	    (server->options & NFS_OPTION_FSCACHE))
+		return "yes";
+	return "no ";
+}
+
+/*
  * release the caching state associated with a page if undergoing complete page
  * invalidation
  */
@@ -110,6 +121,7 @@ static inline void nfs_fscache_unregister(void) {}
 static inline void nfs_fscache_get_client_cookie(struct nfs_client *clp) {}
 static inline void nfs4_fscache_get_client_cookie(struct nfs_client *clp) {}
 static inline void nfs_fscache_release_client_cookie(struct nfs_client *clp) {}
+static inline const char *nfs_server_fscache_state(struct nfs_server *server) { return "no "; }
 
 static inline void nfs_fscache_init_fh_cookie(struct inode *inode) {}
 static inline void nfs_fscache_enable_fh_cookie(struct inode *inode) {}


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
