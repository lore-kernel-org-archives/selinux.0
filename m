Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>
Subject: [PATCH 1/2] selinux: simple cleanup for cond_read_node()
Date: Sun, 15 Jun 2014 01:19:01 +0900
Message-Id: <1402762742-2808-1-git-send-email-namhyung@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The node->cur_state and len can be read in a single call of next_entry().
And setting len before reading is a dead write so can be eliminated.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 security/selinux/ss/conditional.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 377d148e7157..4766a38fae9a 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -402,19 +402,14 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
 	int rc;
 	struct cond_expr *expr = NULL, *last = NULL;
 
-	rc = next_entry(buf, fp, sizeof(u32));
+	rc = next_entry(buf, fp, sizeof(buf));
 	if (rc)
 		return rc;
 
 	node->cur_state = le32_to_cpu(buf[0]);
 
-	len = 0;
-	rc = next_entry(buf, fp, sizeof(u32));
-	if (rc)
-		return rc;
-
 	/* expr */
-	len = le32_to_cpu(buf[0]);
+	len = le32_to_cpu(buf[1]);
 
 	for (i = 0; i < len; i++) {
 		rc = next_entry(buf, fp, sizeof(u32) * 2);
-- 
2.0.0
