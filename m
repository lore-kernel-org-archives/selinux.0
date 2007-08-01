From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: selinux@tycho.nsa.gov, labeled-nfs@linux-nfs.org
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: [PATCH 3/7] KConfig: Add KConfig entries for MAC labeled NFS
Date: Wed,  1 Aug 2007 16:02:08 -0400
Message-Id: <118599853274-git-send-email-dpquigl@tycho.nsa.gov>
In-Reply-To: <11859985322836-git-send-email-dpquigl@tycho.nsa.gov>
References: <11859985322836-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: David P. Quigley <dpquigl@tycho.nsa.gov>

This patch adds two entries into the fs/KConfig file. The first entry
NFS_V4_MAC enables MAC labeling support to the NFSv4 client while the second
entry NFSD_V4_MAC enables MAC labeling support on the server side.

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
---
 fs/Kconfig |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 58a0650..c4e42e2 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -1593,6 +1593,15 @@ config NFS_V4
 
 	  If unsure, say N.
 
+config NFS_V4_MAC
+	bool "Provide MAC Labeled NFSv4 client support"
+	depends on NFS_V4 && SECURITY_SELINUX
+	help
+	  Say Y here if you want label attribute support for NFS version 4.
+
+	  If unsure, say N.
+
+
 config NFS_DIRECTIO
 	bool "Allow direct I/O on NFS files"
 	depends on NFS_FS
@@ -1682,6 +1691,15 @@ config NFSD_V4
 	  should only be used if you are interested in helping to test NFSv4.
 	  If unsure, say N.
 
+config NFSD_V4_MAC
+	bool "Provide MAC Labeled NFSv4 server support"
+	depends on NFSD_V4 && SECURITY_SELINUX
+	help
+	  If you would like to include support for label file attributes
+	  over NFSv4, say Y here.
+
+	  If unsure, say N.
+
 config NFSD_TCP
 	bool "Provide NFS server over TCP support"
 	depends on NFSD
-- 
1.5.2.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
