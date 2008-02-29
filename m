Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1T0lENB026210
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 19:47:14 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1T0kkVG001021
	for <selinux@tycho.nsa.gov>; Fri, 29 Feb 2008 00:47:06 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 23/37] NFS: Permit local filesystem caching to be enabled for
	NFS [ver #34]
To: Trond.Myklebust@netapp.com, chuck.lever@oracle.com, casey@schaufler-ca.com
Cc: nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Fri, 29 Feb 2008 00:45:36 +0000
Message-ID: <20080229004536.4142.44898.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080229004332.4142.51771.stgit@warthog.procyon.org.uk>
References: <20080229004332.4142.51771.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Permit local filesystem caching to be enabled for NFS in the kernel
configuration.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/Kconfig |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)


diff --git a/fs/Kconfig b/fs/Kconfig
index c42ec50..fa8e978 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -1644,6 +1644,14 @@ config NFS_V4
 
 	  If unsure, say N.
 
+config NFS_FSCACHE
+	bool "Provide NFS client caching support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	depends on NFS_FS=m && FSCACHE || NFS_FS=y && FSCACHE=y
+	help
+	  Say Y here if you want NFS data to be cached locally on disc through
+	  the general filesystem cache manager
+
 config NFS_DIRECTIO
 	bool "Allow direct I/O on NFS files"
 	depends on NFS_FS


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
