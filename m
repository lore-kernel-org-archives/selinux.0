Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8IJQkN9022354
 for <selinux@tycho.nsa.gov>; Fri, 18 Sep 2015 15:26:46 -0400
Received: by pacfv12 with SMTP id fv12so59480781pac.2
 for <selinux@tycho.nsa.gov>; Fri, 18 Sep 2015 12:26:44 -0700 (PDT)
From: Jeff Vander Stoep <jeffv@google.com>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, eparis@parisplace.org, sds@tycho.nsa.gov,
 Jeff Vander Stoep <jeffv@google.com>
Subject: [PATCH] selinux: do not check open perm on ftruncate call
Date: Fri, 18 Sep 2015 12:26:39 -0700
Message-Id: <1442604399-23238-1-git-send-email-jeffv@google.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Use the ATTR_FILE attribute to distinguish between truncate()
and ftruncate() system calls. The two other cases where
do_truncate is called with a filp (and therefore ATTR_FILE is set),
are for coredump files and for open(O_TRUNC). In both of those cases
the open permission has already been checked during file open and
therefore does not need to be repeated.

Commit 95dbf739313f ("SELinux: check OPEN on truncate calls") fixed
fixed a major issue where domains were allowed to truncate files
without the open permission. However, it introduced a new bug where
a domain with the write permission can no longer ftruncate files
without the open permission, even when they receive an already open
file.

Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
---
 security/selinux/hooks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f4be0a1..b32f1e1 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2934,7 +2934,8 @@ static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
 			ATTR_ATIME_SET | ATTR_MTIME_SET | ATTR_TIMES_SET))
 		return dentry_has_perm(cred, dentry, FILE__SETATTR);
 
-	if (selinux_policycap_openperm && (ia_valid & ATTR_SIZE))
+	if (selinux_policycap_openperm && (ia_valid & ATTR_SIZE)
+			&& !(ia_valid & ATTR_FILE))
 		av |= FILE__OPEN;
 
 	return dentry_has_perm(cred, dentry, av);
-- 
2.6.0.rc0.131.gf624c3d
