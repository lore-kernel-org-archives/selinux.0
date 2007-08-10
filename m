Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7AG7QZY017871
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 12:07:26 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7AG7P1t020857
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 16:07:25 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 08/16] CacheFiles: Export things for CacheFiles [try #3]
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
        trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov
Date: Fri, 10 Aug 2007 17:05:37 +0100
Message-ID: <20070810160537.24698.90890.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20070810160455.24698.30983.stgit@warthog.cambridge.redhat.com>
References: <20070810160455.24698.30983.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Export a number of functions for CacheFiles's use.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/super.c       |    2 ++
 kernel/auditsc.c |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index fc8ebed..c0d99dd 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -270,6 +270,8 @@ int fsync_super(struct super_block *sb)
 	return sync_blockdev(sb->s_bdev);
 }
 
+EXPORT_SYMBOL_GPL(fsync_super);
+
 /**
  *	generic_shutdown_super	-	common helper for ->kill_sb()
  *	@sb: superblock to kill
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 3401293..0112179 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1526,6 +1526,8 @@ add_names:
 	}
 }
 
+EXPORT_SYMBOL_GPL(__audit_inode_child);
+
 /**
  * auditsc_get_stamp - get local copies of audit_context values
  * @ctx: audit_context for the task


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
