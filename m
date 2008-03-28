Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2SF5DJi023871
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2008 11:05:13 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2SF4qU2018693
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2008 15:05:12 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 24/45] CacheFiles: Export things for CacheFiles [ver #35]
To: torvalds@osdl.org, akpm@linux-foundation.org, trond.myklebust@fys.uio.no,
        chuck.lever@oracle.com
Cc: nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Fri, 28 Mar 2008 14:32:14 +0000
Message-ID: <20080328143214.3483.24952.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080328143010.3483.99079.stgit@warthog.procyon.org.uk>
References: <20080328143010.3483.99079.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Export a number of functions for CacheFiles's use.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/super.c          |    1 +
 security/security.c |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)


diff --git a/fs/super.c b/fs/super.c
index 09008db..8030909 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -267,6 +267,7 @@ int fsync_super(struct super_block *sb)
 	__fsync_super(sb);
 	return sync_blockdev(sb->s_bdev);
 }
+EXPORT_SYMBOL_GPL(fsync_super);
 
 /**
  *	generic_shutdown_super	-	common helper for ->kill_sb()
diff --git a/security/security.c b/security/security.c
index 87cd150..deb2e65 100644
--- a/security/security.c
+++ b/security/security.c
@@ -358,6 +358,7 @@ int security_inode_create(struct inode *dir, struct dentry *dentry, int mode)
 		return 0;
 	return security_ops->inode_create(dir, dentry, mode);
 }
+EXPORT_SYMBOL_GPL(security_inode_create);
 
 int security_inode_link(struct dentry *old_dentry, struct inode *dir,
 			 struct dentry *new_dentry)
@@ -388,6 +389,7 @@ int security_inode_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 		return 0;
 	return security_ops->inode_mkdir(dir, dentry, mode);
 }
+EXPORT_SYMBOL_GPL(security_inode_mkdir);
 
 int security_inode_rmdir(struct inode *dir, struct dentry *dentry)
 {


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
