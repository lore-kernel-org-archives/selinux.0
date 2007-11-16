Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lAGK8sk5018812
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 15:08:54 -0500
Subject: [PATCH 06/13] KConfig: Add KConfig entries for SELinux labeled NFS
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: labeled-nfs@linux-nfs.org
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
References: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 16 Nov 2007 15:08:53 -0500
Message-Id: <1195243733.20981.15.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds two entries into the fs/KConfig file. The first entry
NFS_V4_SELINUX enables SELinux labeling support to the NFSv4 client
while the second
entry NFSD_V4_SELINUX enables SELinux labeling support on the server
side.

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
Signed-off-by: Matthew N. Dodd <Matthew.Dodd@sparta.com>
---
 fs/Kconfig |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 429a002..896085f 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -1634,6 +1634,15 @@ config NFS_V4
 
 	  If unsure, say N.
 
+config NFS_V4_SECURITY_LABEL
+	bool "Provide Security Label support for NFSv4 client"
+	depends on NFS_V4 && SECURITY
+	help
+	  Say Y here if you want label attribute support for NFS version 4.
+
+	  If unsure, say N.
+
+
 config NFS_DIRECTIO
 	bool "Allow direct I/O on NFS files"
 	depends on NFS_FS
@@ -1723,6 +1732,15 @@ config NFSD_V4
 	  should only be used if you are interested in helping to test NFSv4.
 	  If unsure, say N.
 
+config NFSD_V4_SECURITY_LABEL
+	bool "Provide Security Label support for NFSv4 server"
+	depends on NFSD_V4 && SECURITY
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
1.5.3.4



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
