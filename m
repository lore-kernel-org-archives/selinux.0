Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l79Hrv4J025056
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 13:53:57 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l79HrtVe011547
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 17:53:55 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l79HrsC2023832
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 13:53:54 -0400
Received: from warthog.cambridge.redhat.com (warthog.cambridge.redhat.com [172.16.18.73])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l79Hrr3M002230
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 13:53:53 -0400
Received: from redhat.com (localhost.localdomain [127.0.0.1])
	by warthog.cambridge.redhat.com (8.14.1/8.13.8) with ESMTP id l79HrqUu020547
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 18:53:52 +0100
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
        trond.myklebust@fys.uio.no
Date: Thu, 09 Aug 2007 17:05:20 +0100
Message-ID: <20070809160520.17906.51993.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20070809160438.17906.76348.stgit@warthog.cambridge.redhat.com>
References: <20070809160438.17906.76348.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: [Linux-cachefs] [PATCH 08/14] CacheFiles: Export things for
	CacheFiles [try #2]
Reply-To: Linux filesystem caching discussion list <linux-cachefs@redhat.com>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/linux-cachefs>
List-Post: <mailto:linux-cachefs@redhat.com>
List-Help: <mailto:linux-cachefs-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=subscribe>
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
index a777d37..1c068ec 100644
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
Linux-cachefs mailing list
Linux-cachefs@redhat.com
https://www.redhat.com/mailman/listinfo/linux-cachefs


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
