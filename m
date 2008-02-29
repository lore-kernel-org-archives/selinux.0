Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1T0lG2q026269
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 19:47:16 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1T0khVG001003
	for <selinux@tycho.nsa.gov>; Fri, 29 Feb 2008 00:47:08 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 30/37] NFS: Add some new I/O event counters for FS-Cache
	events [ver #34]
To: Trond.Myklebust@netapp.com, chuck.lever@oracle.com, casey@schaufler-ca.com
Cc: nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Fri, 29 Feb 2008 00:46:14 +0000
Message-ID: <20080229004614.4142.57875.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080229004332.4142.51771.stgit@warthog.procyon.org.uk>
References: <20080229004332.4142.51771.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add some new NFS I/O event counters for FS-Cache events.  They have to be
added as byte counters because I may need to be able to increase the numbers
by more than 1 at a time.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/nfs/iostat.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)


diff --git a/fs/nfs/iostat.h b/fs/nfs/iostat.h
index 6350ecb..0e3b170 100644
--- a/fs/nfs/iostat.h
+++ b/fs/nfs/iostat.h
@@ -60,6 +60,13 @@ enum nfs_stat_bytecounters {
 	NFSIOS_SERVERWRITTENBYTES,
 	NFSIOS_READPAGES,
 	NFSIOS_WRITEPAGES,
+#ifdef CONFIG_NFS_FSCACHE
+	NFSIOS_FSCACHE_READ_OK,
+	NFSIOS_FSCACHE_READ_FAIL,
+	NFSIOS_FSCACHE_WRITE_OK,
+	NFSIOS_FSCACHE_WRITE_FAIL,
+	NFSIOS_FSCACHE_UNCACHE,
+#endif
 	__NFSIOS_BYTESMAX,
 };
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
