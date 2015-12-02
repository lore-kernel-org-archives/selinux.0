Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB2FgWlF006648
 for <selinux@tycho.nsa.gov>; Wed, 2 Dec 2015 10:42:32 -0500
Received: by iouu10 with SMTP id u10so50610340iou.0
 for <selinux@tycho.nsa.gov>; Wed, 02 Dec 2015 07:42:28 -0800 (PST)
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 Richard Weinberger <richard.weinberger@gmail.com>,
 Austin S Hemmelgarn <ahferroin7@gmail.com>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-bcache@vger.kernel.org,
 dm-devel@redhat.com, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH 12/19] fs: Don't remove suid for CAP_FSETID in s_user_ns
Date: Wed,  2 Dec 2015 09:40:12 -0600
Message-Id: <1449070821-73820-13-git-send-email-seth.forshee@canonical.com>
In-Reply-To: <1449070821-73820-1-git-send-email-seth.forshee@canonical.com>
References: <1449070821-73820-1-git-send-email-seth.forshee@canonical.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Expand the check in should_remove_suid() to keep privileges for
CAP_FSETID in s_user_ns rather than init_user_ns.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 fs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 01c036fe1950..3e7c74da9304 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1684,7 +1684,8 @@ int should_remove_suid(struct dentry *dentry)
 	if (unlikely((mode & S_ISGID) && (mode & S_IXGRP)))
 		kill |= ATTR_KILL_SGID;
 
-	if (unlikely(kill && !capable(CAP_FSETID) && S_ISREG(mode)))
+	if (unlikely(kill && !ns_capable(dentry->d_sb->s_user_ns, CAP_FSETID) &&
+		     S_ISREG(mode)))
 		return kill;
 
 	return 0;
-- 
1.9.1
