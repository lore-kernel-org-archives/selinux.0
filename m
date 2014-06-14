Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>
Subject: [PATCH 2/2] selinux: fix a possible memory leak in cond_read_node()
Date: Sun, 15 Jun 2014 01:19:02 +0900
Message-Id: <1402762742-2808-2-git-send-email-namhyung@kernel.org>
In-Reply-To: <1402762742-2808-1-git-send-email-namhyung@kernel.org>
References: <1402762742-2808-1-git-send-email-namhyung@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The cond_read_node() should free the given node on error path as it's
not linked to p->cond_list yet.  This is done via cond_node_destroy()
but it's not called when next_entry() fails before the expr loop.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 security/selinux/ss/conditional.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 4766a38fae9a..470d5cca8d14 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -404,7 +404,7 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
 
 	rc = next_entry(buf, fp, sizeof(buf));
 	if (rc)
-		return rc;
+		goto err;
 
 	node->cur_state = le32_to_cpu(buf[0]);
 
-- 
2.0.0
