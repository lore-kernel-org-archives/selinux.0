Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB2FgWlL006648
 for <selinux@tycho.nsa.gov>; Wed, 2 Dec 2015 10:42:41 -0500
Received: by igcto18 with SMTP id to18so34151456igc.0
 for <selinux@tycho.nsa.gov>; Wed, 02 Dec 2015 07:42:38 -0800 (PST)
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 Richard Weinberger <richard.weinberger@gmail.com>,
 Austin S Hemmelgarn <ahferroin7@gmail.com>,
 linux-bcache@vger.kernel.org, dm-devel@redhat.com,
 linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.sourceforge.net,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH 18/19] fuse: Restrict allow_other to the superblock's
 namespace or a descendant
Date: Wed,  2 Dec 2015 09:40:18 -0600
Message-Id: <1449070821-73820-19-git-send-email-seth.forshee@canonical.com>
In-Reply-To: <1449070821-73820-1-git-send-email-seth.forshee@canonical.com>
References: <1449070821-73820-1-git-send-email-seth.forshee@canonical.com>
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
---
 fs/fuse/dir.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index f67f4dd86b36..5b8edb1203b8 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1018,8 +1018,14 @@ int fuse_allow_current_process(struct fuse_conn *fc)
 {
 	const struct cred *cred;
 
-	if (fc->flags & FUSE_ALLOW_OTHER)
-		return 1;
+	if (fc->flags & FUSE_ALLOW_OTHER) {
+		struct user_namespace *ns;
+		for (ns = current_user_ns(); ns; ns = ns->parent) {
+			if (ns == fc->user_ns)
+				return 1;
+		}
+		return 0;
+	}
 
 	cred = current_cred();
 	if (uid_eq(cred->euid, fc->user_id) &&
-- 
1.9.1
