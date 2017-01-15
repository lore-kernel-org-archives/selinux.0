Subject: [PATCH 06/46] selinux: Use kcalloc() in policydb_index()
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <2c5e5708-72a3-954f-a773-e5716df174d1@users.sourceforge.net>
Date: Sun, 15 Jan 2017 16:03:33 +0100
MIME-Version: 1.0
In-Reply-To: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 14 Jan 2017 13:08:59 +0100

Multiplications for the size determination of memory allocations
indicated that array data structures should be processed.
Thus use the corresponding function "kcalloc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/ss/policydb.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index d719db4219cd..21869b622c0c 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -540,23 +540,23 @@ static int policydb_index(struct policydb *p)
 #endif
 
 	rc = -ENOMEM;
-	p->class_val_to_struct =
-		kzalloc(p->p_classes.nprim * sizeof(*(p->class_val_to_struct)),
-			GFP_KERNEL);
+	p->class_val_to_struct = kcalloc(p->p_classes.nprim,
+					 sizeof(*p->class_val_to_struct),
+					 GFP_KERNEL);
 	if (!p->class_val_to_struct)
 		goto out;
 
 	rc = -ENOMEM;
-	p->role_val_to_struct =
-		kzalloc(p->p_roles.nprim * sizeof(*(p->role_val_to_struct)),
-			GFP_KERNEL);
+	p->role_val_to_struct = kcalloc(p->p_roles.nprim,
+					sizeof(*p->role_val_to_struct),
+					GFP_KERNEL);
 	if (!p->role_val_to_struct)
 		goto out;
 
 	rc = -ENOMEM;
-	p->user_val_to_struct =
-		kzalloc(p->p_users.nprim * sizeof(*(p->user_val_to_struct)),
-			GFP_KERNEL);
+	p->user_val_to_struct = kcalloc(p->p_users.nprim,
+					sizeof(*p->user_val_to_struct),
+					GFP_KERNEL);
 	if (!p->user_val_to_struct)
 		goto out;
 
-- 
2.11.0
