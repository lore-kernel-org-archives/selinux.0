Subject: [PATCH 05/46] selinux: Adjust four checks for null pointers
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <44727e74-99ac-b0bd-2d7b-e5928d77ea75@users.sourceforge.net>
Date: Sun, 15 Jan 2017 16:02:30 +0100
MIME-Version: 1.0
In-Reply-To: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 14 Jan 2017 12:36:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The script "checkpatch.pl" pointed information out like the following.

Comparison to NULL could be written !…

Thus fix affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/ss/hashtab.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index dc99fff64ecb..3858706a29fb 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -17,7 +17,7 @@ struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *
 	u32 i;
 
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	if (p == NULL)
+	if (!p)
 		return p;
 
 	p->size = size;
@@ -25,7 +25,7 @@ struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *
 	p->hash_value = hash_value;
 	p->keycmp = keycmp;
 	p->htable = kmalloc_array(size, sizeof(*p->htable), GFP_KERNEL);
-	if (p->htable == NULL) {
+	if (!p->htable) {
 		kfree(p);
 		return NULL;
 	}
@@ -58,7 +58,7 @@ int hashtab_insert(struct hashtab *h, void *key, void *datum)
 		return -EEXIST;
 
 	newnode = kzalloc(sizeof(*newnode), GFP_KERNEL);
-	if (newnode == NULL)
+	if (!newnode)
 		return -ENOMEM;
 	newnode->key = key;
 	newnode->datum = datum;
@@ -87,7 +87,7 @@ void *hashtab_search(struct hashtab *h, const void *key)
 	while (cur && h->keycmp(h, key, cur->key) > 0)
 		cur = cur->next;
 
-	if (cur == NULL || (h->keycmp(h, key, cur->key) != 0))
+	if (!cur || (h->keycmp(h, key, cur->key) != 0))
 		return NULL;
 
 	return cur->datum;
-- 
2.11.0
