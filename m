Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4CDPsNA021104
 for <selinux@tycho.nsa.gov>; Mon, 12 May 2014 09:25:59 -0400
To: miklos@szeredi.hu, jmorris@namei.org, john.johansen@canonical.com,
 selinux@tycho.nsa.gov
Subject: [PATCH (for 3.15) 5/5] LSM: Remove duplicated rename handling.
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <201404242020.FJD18726.LOOJtOQMFVFFSH@I-love.SAKURA.ne.jp>
 <201405012058.JEG30273.LJFHOOFMtOFQVS@I-love.SAKURA.ne.jp>
 <201405051449.GAE81222.LOOFtFJMQFOSVH@I-love.SAKURA.ne.jp>
 <201405120053.HJG95368.HFLQSFMOOtOVJF@I-love.SAKURA.ne.jp>
 <201405122221.DBG43278.LOQtJSOFVFFOHM@I-love.SAKURA.ne.jp>
In-Reply-To: <201405122221.DBG43278.LOQtJSOFVFFOHM@I-love.SAKURA.ne.jp>
Message-Id: <201405122225.CIE09825.MFHOtOOSQVFFLJ@I-love.SAKURA.ne.jp>
Date: Mon, 12 May 2014 22:25:54 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

>From 479d305929c4ef600de99948f42ed633b24458b0 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Mon, 12 May 2014 22:02:30 +0900
Subject: [PATCH (for 3.15) 5/5] LSM: Remove duplicated rename handling.

Since all LSM modules are now ready to handle the rename flags,
security_inode_rename() and security_path_rename() no longer need to
call each LSM module with reversed arguments.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/security.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/security/security.c b/security/security.c
index 81d7ffe..fbc4968 100644
--- a/security/security.c
+++ b/security/security.c
@@ -439,15 +439,6 @@ int security_path_rename(struct path *old_dir, struct dentry *old_dentry,
 	if (unlikely(IS_PRIVATE(old_dentry->d_inode) ||
 		     (new_dentry->d_inode && IS_PRIVATE(new_dentry->d_inode))))
 		return 0;
-
-	if (flags & RENAME_EXCHANGE) {
-		int err = security_ops->path_rename(new_dir, new_dentry,
-						    old_dir, old_dentry,
-						    flags);
-		if (err)
-			return err;
-	}
-
 	return security_ops->path_rename(old_dir, old_dentry, new_dir,
 					 new_dentry, flags);
 }
@@ -540,15 +531,6 @@ int security_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
         if (unlikely(IS_PRIVATE(old_dentry->d_inode) ||
             (new_dentry->d_inode && IS_PRIVATE(new_dentry->d_inode))))
 		return 0;
-
-	if (flags & RENAME_EXCHANGE) {
-		int err = security_ops->inode_rename(new_dir, new_dentry,
-						     old_dir, old_dentry,
-						     flags);
-		if (err)
-			return err;
-	}
-
 	return security_ops->inode_rename(old_dir, old_dentry,
 					  new_dir, new_dentry, flags);
 }
-- 
1.7.1
