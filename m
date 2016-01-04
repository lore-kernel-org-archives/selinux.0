Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u04I4gpL013588
 for <selinux@tycho.nsa.gov>; Mon, 4 Jan 2016 13:04:49 -0500
Received: by mail-ig0-f170.google.com with SMTP id ph11so250382872igc.1
 for <selinux@tycho.nsa.gov>; Mon, 04 Jan 2016 10:04:47 -0800 (PST)
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 Richard Weinberger <richard.weinberger@gmail.com>,
 Austin S Hemmelgarn <ahferroin7@gmail.com>,
 linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
 dm-devel@redhat.com, linux-raid@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.sourceforge.net,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH RESEND v2 17/18] fuse: Restrict allow_other to the
 superblock's namespace or a descendant
Date: Mon,  4 Jan 2016 12:03:56 -0600
Message-Id: <1451930639-94331-18-git-send-email-seth.forshee@canonical.com>
In-Reply-To: <1451930639-94331-1-git-send-email-seth.forshee@canonical.com>
References: <1451930639-94331-1-git-send-email-seth.forshee@canonical.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Unprivileged users are normally restricted from mounting with the
allow_other option by system policy, but this could be bypassed
for a mount done with user namespace root permissions. In such
cases allow_other should not allow users outside the userns
to access the mount as doing so would give the unprivileged user
the ability to manipulate processes it would otherwise be unable
to manipulate. Restrict allow_other to apply to users in the same
userns used at mount or a descendant of that namespace.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
Acked-by: Serge Hallyn <serge.hallyn@canonical.com>
---
 fs/fuse/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 8fd9fe4dcd43..24e4cdb554f1 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1015,7 +1015,7 @@ int fuse_allow_current_process(struct fuse_conn *fc)
 	const struct cred *cred;
 
 	if (fc->flags & FUSE_ALLOW_OTHER)
-		return 1;
+		return current_in_userns(fc->user_ns);
 
 	cred = current_cred();
 	if (uid_eq(cred->euid, fc->user_id) &&
-- 
1.9.1
