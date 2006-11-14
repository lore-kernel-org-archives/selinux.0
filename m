From: David Howells <dhowells@redhat.com>
Subject: [PATCH 10/19] CacheFiles: Export things for CacheFiles
Date: Tue, 14 Nov 2006 20:06:43 +0000
To: torvalds@osdl.org, akpm@osdl.org, sds@tycho.nsa.gov,
        trond.myklebust@fys.uio.no
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        aviro@redhat.com, steved@redhat.com
Message-Id: <20061114200643.12943.71244.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Export a number of functions for CacheFiles's use.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/file_table.c  |    1 +
 fs/super.c       |    2 ++
 kernel/auditsc.c |    2 ++
 3 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 24f25a0..10dec73 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -235,6 +235,7 @@ struct file fastcall *fget_light(unsigne
 	return file;
 }
 
+EXPORT_SYMBOL_GPL(fget_light);
 
 void put_filp(struct file *file)
 {
diff --git a/fs/super.c b/fs/super.c
index 47e554c..da8020d 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -251,6 +251,8 @@ int fsync_super(struct super_block *sb)
 	return sync_blockdev(sb->s_bdev);
 }
 
+EXPORT_SYMBOL_GPL(fsync_super);
+
 /**
  *	generic_shutdown_super	-	common helper for ->kill_sb()
  *	@sb: superblock to kill
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 42f2f11..05908b9 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1425,6 +1425,8 @@ #endif
 	audit_copy_inode(&context->names[idx], inode);
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
