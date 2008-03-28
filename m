Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2SEZFRu017690
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2008 10:35:15 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2SEZBTs005515
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2008 14:35:12 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 44/45] NFS: Display local caching state [ver #35]
To: torvalds@osdl.org, akpm@linux-foundation.org, trond.myklebust@fys.uio.no,
        chuck.lever@oracle.com
Cc: nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Fri, 28 Mar 2008 14:33:56 +0000
Message-ID: <20080328143356.3483.8208.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080328143010.3483.99079.stgit@warthog.procyon.org.uk>
References: <20080328143010.3483.99079.stgit@warthog.procyon.org.uk>
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
index 51e9346..d67d52f 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1451,7 +1451,7 @@ static int nfs_volume_list_show(struct seq_file *m, void *v)
 
 	/* display header on line 1 */
 	if (v == &nfs_volume_list) {
-		seq_puts(m, "NV SERVER   PORT DEV     FSID\n");
+		seq_puts(m, "NV SERVER   PORT DEV     FSID              FSC\n");
 		return 0;
 	}
 	/* display one transport per line on subsequent lines */
@@ -1465,12 +1465,13 @@ static int nfs_volume_list_show(struct seq_file *m, void *v)
 		 (unsigned long long) server->fsid.major,
 		 (unsigned long long) server->fsid.minor);
 
-	seq_printf(m, "v%u %s %s %-7s %-17s\n",
+	seq_printf(m, "v%u %s %s %-7s %-17s %s\n",
 		   clp->rpc_ops->version,
 		   rpc_peeraddr2str(clp->cl_rpcclient, RPC_DISPLAY_HEX_ADDR),
 		   rpc_peeraddr2str(clp->cl_rpcclient, RPC_DISPLAY_HEX_PORT),
 		   dev,
-		   fsid);
+		   fsid,
+		   nfs_server_fscache_state(server));
 
 	return 0;
 }
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 2f71d7e..027a4ca 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -144,6 +144,16 @@ static inline void nfs_readpage_to_fscache(struct inode *inode,
 		__nfs_readpage_to_fscache(inode, page, sync);
 }
 
+/*
+ * indicate the client caching state as readable text
+ */
+static inline const char *nfs_server_fscache_state(struct nfs_server *server)
+{
+	if (server->fscache && (server->options & NFS_OPTION_FSCACHE))
+		return "yes";
+	return "no ";
+}
+
 
 #else /* CONFIG_NFS_FSCACHE */
 static inline int nfs_fscache_register(void) { return 0; }
@@ -191,5 +201,10 @@ static inline int nfs_readpages_from_fscache(struct nfs_open_context *ctx,
 static inline void nfs_readpage_to_fscache(struct inode *inode,
 					   struct page *page, int sync) {}
 
+static inline const char *nfs_server_fscache_state(struct nfs_server *server)
+{
+	return "no ";
+}
+
 #endif /* CONFIG_NFS_FSCACHE */
 #endif /* _NFS_FSCACHE_H */


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
