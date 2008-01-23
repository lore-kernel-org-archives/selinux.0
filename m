Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0N0k72S015588
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2008 19:46:07 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0N0k6BR008308
	for <selinux@tycho.nsa.gov>; Wed, 23 Jan 2008 00:46:06 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 26/27] NFS: Display local caching state
To: Trond.Myklebust@netapp.com
Cc: nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Wed, 23 Jan 2008 00:46:03 +0000
Message-ID: <20080123004603.15602.71030.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080123004344.15602.35710.stgit@warthog.procyon.org.uk>
References: <20080123004344.15602.35710.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Display the local caching state in /proc/fs/nfsfs/volumes.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/nfs/client.c  |    7 ++++---
 fs/nfs/fscache.h |   15 +++++++++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)


diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 92f9b84..68d3124 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1335,7 +1335,7 @@ static int nfs_volume_list_show(struct seq_file *m, void *v)
 
 	/* display header on line 1 */
 	if (v == &nfs_volume_list) {
-		seq_puts(m, "NV SERVER   PORT DEV     FSID\n");
+		seq_puts(m, "NV SERVER   PORT DEV     FSID              FSC\n");
 		return 0;
 	}
 	/* display one transport per line on subsequent lines */
@@ -1349,12 +1349,13 @@ static int nfs_volume_list_show(struct seq_file *m, void *v)
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
index 144fb58..9a735fc 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -53,6 +53,17 @@ extern void __nfs_fscache_invalidate_page(struct page *, struct inode *);
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
@@ -109,6 +120,10 @@ static inline void nfs4_fscache_get_client_cookie(struct nfs_client *clp) {}
 static inline void nfs_fscache_release_client_cookie(struct nfs_client *clp) {}
 static inline void nfs_fscache_show_stats(struct seq_file *m,
 					  struct nfs_server *nfss) {}
+static inline const char *nfs_server_fscache_state(struct nfs_server *server)
+{
+	return "no ";
+}
 
 static inline void nfs_fscache_init_fh_cookie(struct inode *inode) {}
 static inline void nfs_fscache_enable_fh_cookie(struct inode *inode) {}


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
