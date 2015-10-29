Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9T0lfPh011960
 for <selinux@tycho.nsa.gov>; Wed, 28 Oct 2015 20:47:43 -0400
From: Andreas Gruenbacher <agruenba@redhat.com>
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v4 1/7] selinux: Remove unused variable in
 selinux_inode_init_security
Date: Thu, 29 Oct 2015 01:47:09 +0100
Message-Id: <1446079635-22462-2-git-send-email-agruenba@redhat.com>
In-Reply-To: <1446079635-22462-1-git-send-email-agruenba@redhat.com>
References: <1446079635-22462-1-git-send-email-agruenba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e4369d8..fc8f626 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2756,13 +2756,11 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 				       void **value, size_t *len)
 {
 	const struct task_security_struct *tsec = current_security();
-	struct inode_security_struct *dsec;
 	struct superblock_security_struct *sbsec;
 	u32 sid, newsid, clen;
 	int rc;
 	char *context;
 
-	dsec = dir->i_security;
 	sbsec = dir->i_sb->s_security;
 
 	sid = tsec->sid;
-- 
2.5.0
