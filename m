From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: paul@paul-moore.com, sds@tycho.nsa.gov, eparis@parisplace.org,
 james.l.morris@oracle.com, serge@hallyn.com
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>
Date: Wed,  4 Oct 2017 20:32:17 +0200
Message-Id: <20171004183218.4786-1-clabbe.montjoie@gmail.com>
Subject: [PATCH 1/2] selinux: fix build warning by removing the
 unused sid variable
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch remove the unused variable sid
This fix the following build warning:
security/selinux/hooks.c:2921:6: warning: variable 'sid' set but not used [-Wunused-but-set-variable]

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 security/selinux/hooks.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f5d304736852..8507a56f85e4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2918,13 +2918,12 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 {
 	const struct task_security_struct *tsec = current_security();
 	struct superblock_security_struct *sbsec;
-	u32 sid, newsid, clen;
+	u32 newsid, clen;
 	int rc;
 	char *context;
 
 	sbsec = dir->i_sb->s_security;
 
-	sid = tsec->sid;
 	newsid = tsec->create_sid;
 
 	rc = selinux_determine_inode_label(current_security(),
-- 
2.13.6
