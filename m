Subject: [PATCH 03/46] selinux: Improve size determinations in four functions
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <f36c8dc9-0d90-6eee-9229-fb02d6b27708@users.sourceforge.net>
Date: Sun, 15 Jan 2017 16:00:04 +0100
MIME-Version: 1.0
In-Reply-To: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 14 Jan 2017 11:22:12 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/ss/conditional.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 4a3bf29f7565..771c96afe1d5 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -227,7 +227,7 @@ int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp)
 	u32 len;
 	int rc;
 
-	booldatum = kzalloc(sizeof(struct cond_bool_datum), GFP_KERNEL);
+	booldatum = kzalloc(sizeof(*booldatum), GFP_KERNEL);
 	if (!booldatum)
 		return -ENOMEM;
 
@@ -332,7 +332,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 		goto err;
 	}
 
-	list = kzalloc(sizeof(struct cond_av_list), GFP_KERNEL);
+	list = kzalloc(sizeof(*list), GFP_KERNEL);
 	if (!list) {
 		rc = -ENOMEM;
 		goto err;
@@ -421,7 +421,7 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
 			goto err;
 
 		rc = -ENOMEM;
-		expr = kzalloc(sizeof(struct cond_expr), GFP_KERNEL);
+		expr = kzalloc(sizeof(*expr), GFP_KERNEL);
 		if (!expr)
 			goto err;
 
@@ -472,7 +472,7 @@ int cond_read_list(struct policydb *p, void *fp)
 
 	for (i = 0; i < len; i++) {
 		rc = -ENOMEM;
-		node = kzalloc(sizeof(struct cond_node), GFP_KERNEL);
+		node = kzalloc(sizeof(*node), GFP_KERNEL);
 		if (!node)
 			goto err;
 
-- 
2.11.0
