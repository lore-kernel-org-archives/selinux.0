Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m18Gsgl8008247
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2008 11:54:42 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m18GsfJ4016914
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2008 16:54:41 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 23/37] NFS: Permit local filesystem caching to be enabled for
	NFS
To: Trond.Myklebust@netapp.com, chuck.lever@oracle.com
Cc: nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Fri, 08 Feb 2008 16:54:00 +0000
Message-ID: <20080208165400.15902.53982.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080208165156.15902.62457.stgit@warthog.procyon.org.uk>
References: <20080208165156.15902.62457.stgit@warthog.procyon.org.uk>
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
