From: Colin King <colin.king@canonical.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E . Hallyn" <serge@hallyn.com>, Nick Kralevich <nnk@google.com>,
 Jeff Vander Stoep <jeffv@google.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: fix memory leak on node_ptr on error return path
Date: Mon, 21 Mar 2016 23:00:13 +0000
Message-Id: <1458601213-5835-1-git-send-email-colin.king@canonical.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Colin Ian King <colin.king@canonical.com>

node_ptr is not being free'd if the list allocation fails, fix
this by kfree'ing it before exiting on the error path.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/selinux/ss/conditional.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 456e1a9..5d010ef 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -332,6 +332,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 	list = kzalloc(sizeof(struct cond_av_list), GFP_KERNEL);
 	if (!list) {
 		rc = -ENOMEM;
+		kfree(node_ptr);
 		goto err;
 	}
 
-- 
2.7.3
