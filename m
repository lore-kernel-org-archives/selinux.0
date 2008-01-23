Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0NHMYt3022560
	for <selinux@tycho.nsa.gov>; Wed, 23 Jan 2008 12:22:34 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0NHMXbP026824
	for <selinux@tycho.nsa.gov>; Wed, 23 Jan 2008 17:22:33 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 21/27] CacheFiles: Export things for CacheFiles [try #2]
To: Trond.Myklebust@netapp.com
Cc: nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Wed, 23 Jan 2008 17:22:31 +0000
Message-ID: <20080123172230.11107.61391.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080123172038.11107.86025.stgit@warthog.procyon.org.uk>
References: <20080123172038.11107.86025.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Export a number of functions for CacheFiles's use.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/super.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)


diff --git a/fs/super.c b/fs/super.c
index ceaf2e3..cd199ae 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -266,6 +266,7 @@ int fsync_super(struct super_block *sb)
 	__fsync_super(sb);
 	return sync_blockdev(sb->s_bdev);
 }
+EXPORT_SYMBOL_GPL(fsync_super);
 
 /**
  *	generic_shutdown_super	-	common helper for ->kill_sb()


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
