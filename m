From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: hch@infradead.org, viro@zeniv.linux.org.uk, casey@schaufler-ca.com,
        sds@tycho.nsa.gov, matthew.dodd@sparta.com, trond.myklebust@fys.uio.no,
        bfields@fieldses.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org, "David P. Quigley" <dpquigl@tycho.nsa.gov>,
        "Matthew N. Dodd" <Matthew.Dodd@sparta.com>
Subject: [PATCH 06/14] KConfig: Add KConfig entries for Labeled NFS
Date: Mon, 29 Sep 2008 13:06:18 -0400
Message-Id: <1222707986-26606-7-git-send-email-dpquigl@tycho.nsa.gov>
In-Reply-To: <1222707986-26606-1-git-send-email-dpquigl@tycho.nsa.gov>
References: <1222707986-26606-1-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds two entries into the fs/KConfig file. The first entry
NFS_V4_SECURITY_LABEL enables security label support for the NFSv4 client while
the second entry NFSD_V4_SECURITY_LABEL enables security labeling support on
the server side.

Signed-off-by: Matthew N. Dodd <Matthew.Dodd@sparta.com>
Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
---
 fs/Kconfig |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index abccb5d..47ffb42 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -1633,6 +1633,7 @@ config NFS_V4
 
 	  If unsure, say N.
 
+
 config ROOT_NFS
 	bool "Root file system on NFS"
 	depends on NFS_FS=y && IP_PNP
@@ -1644,6 +1645,15 @@ config ROOT_NFS
 
 	  Most people say N here.
 
+config NFS_V4_SECURITY_LABEL
+	bool "Provide Security Label support for NFSv4 client"
+	depends on NFS_V4 && SECURITY
+	help
+	  Say Y here if you want label attribute support for NFS version 4.
+
+
+	  If unsure, say N.
+
 config NFSD
 	tristate "NFS server support"
 	depends on INET
@@ -1725,6 +1735,13 @@ config NFSD_V4
 
 	  If unsure, say N.
 
+config NFSD_V4_SECURITY_LABEL
+	bool "Provide Security Label support for NFSv4 server"
+	depends on NFSD_V4 && SECURITY
+	help
+	  If you would like to include support for label file attributes
+	  over NFSv4, say Y here.
+
 config LOCKD
 	tristate
 
-- 
1.5.5.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
