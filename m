Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB2FgWlM006648
 for <selinux@tycho.nsa.gov>; Wed, 2 Dec 2015 10:42:42 -0500
Received: by igbxm8 with SMTP id xm8so35036728igb.1
 for <selinux@tycho.nsa.gov>; Wed, 02 Dec 2015 07:42:31 -0800 (PST)
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
Subject: [PATCH 14/19] fs: Permit FIBMAP for users with CAP_SYS_RAWIO in
 s_user_ns
Date: Wed,  2 Dec 2015 09:40:14 -0600
Message-Id: <1449070821-73820-15-git-send-email-seth.forshee@canonical.com>
In-Reply-To: <1449070821-73820-1-git-send-email-seth.forshee@canonical.com>
References: <1449070821-73820-1-git-send-email-seth.forshee@canonical.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 fs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 5d01d2638ca5..45c371bed7ee 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -55,7 +55,7 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
 	/* do we support this mess? */
 	if (!mapping->a_ops->bmap)
 		return -EINVAL;
-	if (!capable(CAP_SYS_RAWIO))
+	if (!ns_capable(filp->f_inode->i_sb->s_user_ns, CAP_SYS_RAWIO))
 		return -EPERM;
 	res = get_user(block, p);
 	if (res)
-- 
1.9.1
