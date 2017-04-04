Subject: [PATCH 1/3] selinux: Return directly after a failed memory allocation
 in policydb_index()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: Casey Schaufler <casey@schaufler-ca.com>,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <5704e656-708a-b611-5611-70fc65dc67e8@users.sourceforge.net>
Message-ID: <8a517289-e5a7-8dde-0f5f-9e57f3e270c7@users.sourceforge.net>
Date: Tue, 4 Apr 2017 13:12:46 +0200
MIME-Version: 1.0
In-Reply-To: <5704e656-708a-b611-5611-70fc65dc67e8@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 4 Apr 2017 10:20:46 +0200

Replace five goto statements (and previous variable assignments) by
direct returns after a memory allocation failure in this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/ss/policydb.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 0080122760ad..87d645d3a39f 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -538,34 +538,30 @@ static int policydb_index(struct policydb *p)
 	symtab_hash_eval(p->symtab);
 #endif
 
-	rc = -ENOMEM;
 	p->class_val_to_struct = kcalloc(p->p_classes.nprim,
 					 sizeof(*p->class_val_to_struct),
 					 GFP_KERNEL);
 	if (!p->class_val_to_struct)
-		goto out;
+		return -ENOMEM;
 
-	rc = -ENOMEM;
 	p->role_val_to_struct = kcalloc(p->p_roles.nprim,
 					sizeof(*p->role_val_to_struct),
 					GFP_KERNEL);
 	if (!p->role_val_to_struct)
-		goto out;
+		return -ENOMEM;
 
-	rc = -ENOMEM;
 	p->user_val_to_struct = kcalloc(p->p_users.nprim,
 					sizeof(*p->user_val_to_struct),
 					GFP_KERNEL);
 	if (!p->user_val_to_struct)
-		goto out;
+		return -ENOMEM;
 
 	/* Yes, I want the sizeof the pointer, not the structure */
-	rc = -ENOMEM;
 	p->type_val_to_struct_array = flex_array_alloc(sizeof(struct type_datum *),
 						       p->p_types.nprim,
 						       GFP_KERNEL | __GFP_ZERO);
 	if (!p->type_val_to_struct_array)
-		goto out;
+		return -ENOMEM;
 
 	rc = flex_array_prealloc(p->type_val_to_struct_array, 0,
 				 p->p_types.nprim, GFP_KERNEL | __GFP_ZERO);
@@ -577,12 +573,11 @@ static int policydb_index(struct policydb *p)
 		goto out;
 
 	for (i = 0; i < SYM_NUM; i++) {
-		rc = -ENOMEM;
 		p->sym_val_to_name[i] = flex_array_alloc(sizeof(char *),
 							 p->symtab[i].nprim,
 							 GFP_KERNEL | __GFP_ZERO);
 		if (!p->sym_val_to_name[i])
-			goto out;
+			return -ENOMEM;
 
 		rc = flex_array_prealloc(p->sym_val_to_name[i],
 					 0, p->symtab[i].nprim,
-- 
2.12.2
