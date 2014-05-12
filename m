Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4CDODhG020938
 for <selinux@tycho.nsa.gov>; Mon, 12 May 2014 09:24:13 -0400
To: miklos@szeredi.hu, jmorris@namei.org, john.johansen@canonical.com,
 selinux@tycho.nsa.gov
Subject: [PATCH (for 3.15) 2/5] SELinux: Handle the rename flags.
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <201404242020.FJD18726.LOOJtOQMFVFFSH@I-love.SAKURA.ne.jp>
 <201405012058.JEG30273.LJFHOOFMtOFQVS@I-love.SAKURA.ne.jp>
 <201405051449.GAE81222.LOOFtFJMQFOSVH@I-love.SAKURA.ne.jp>
 <201405120053.HJG95368.HFLQSFMOOtOVJF@I-love.SAKURA.ne.jp>
 <201405122221.DBG43278.LOQtJSOFVFFOHM@I-love.SAKURA.ne.jp>
In-Reply-To: <201405122221.DBG43278.LOQtJSOFVFFOHM@I-love.SAKURA.ne.jp>
Message-Id: <201405122223.BDG04510.tVFSQJOMFOOHFL@I-love.SAKURA.ne.jp>
Date: Mon, 12 May 2014 22:23:36 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

>From 39e4aea3b42b53d844c87f6c7e54f0a9837ebbfd Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Mon, 12 May 2014 21:34:36 +0900
Subject: [PATCH (for 3.15) 2/5] SELinux: Handle the rename flags.

For SELinux, the RENAME_EXCHANGE flag means "check permissions with
reversed arguments".

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/selinux/hooks.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 33f6f56..64d8497 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2752,7 +2752,10 @@ static int selinux_inode_rename(struct inode *old_inode, struct dentry *old_dent
 				struct inode *new_inode, struct dentry *new_dentry,
 				unsigned int flags)
 {
-	return may_rename(old_inode, old_dentry, new_inode, new_dentry);
+	int err = may_rename(old_inode, old_dentry, new_inode, new_dentry);
+	if (!err && (flags & RENAME_EXCHANGE))
+		err = may_rename(new_inode, new_dentry, old_inode, old_dentry);
+	return err;
 }
 
 static int selinux_inode_readlink(struct dentry *dentry)
-- 
1.7.1
