From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: [PATCH 2/3] selinux: initialize structures
Date: Tue, 23 Aug 2016 13:49:24 -0700
Message-Id: <1471985365-1197-2-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1471985365-1197-1-git-send-email-william.c.roberts@intel.com>
References: <1471985365-1197-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

libsepol pointed out an issue where its possible to have
an unitialized jmp and invalid dereference, fix this.
While we're here, zero allocate all the *_val_to_struct
structures.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 security/selinux/ss/policydb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 992a315..4b24385 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -541,21 +541,21 @@ static int policydb_index(struct policydb *p)
 
 	rc = -ENOMEM;
 	p->class_val_to_struct =
-		kmalloc(p->p_classes.nprim * sizeof(*(p->class_val_to_struct)),
+		kzalloc(p->p_classes.nprim * sizeof(*(p->class_val_to_struct)),
 			GFP_KERNEL);
 	if (!p->class_val_to_struct)
 		goto out;
 
 	rc = -ENOMEM;
 	p->role_val_to_struct =
-		kmalloc(p->p_roles.nprim * sizeof(*(p->role_val_to_struct)),
+		kzalloc(p->p_roles.nprim * sizeof(*(p->role_val_to_struct)),
 			GFP_KERNEL);
 	if (!p->role_val_to_struct)
 		goto out;
 
 	rc = -ENOMEM;
 	p->user_val_to_struct =
-		kmalloc(p->p_users.nprim * sizeof(*(p->user_val_to_struct)),
+		kzalloc(p->p_users.nprim * sizeof(*(p->user_val_to_struct)),
 			GFP_KERNEL);
 	if (!p->user_val_to_struct)
 		goto out;
@@ -964,7 +964,7 @@ int policydb_context_isvalid(struct policydb *p, struct context *c)
 		 * Role must be authorized for the type.
 		 */
 		role = p->role_val_to_struct[c->role - 1];
-		if (!ebitmap_get_bit(&role->types, c->type - 1))
+		if (!role || !ebitmap_get_bit(&role->types, c->type - 1))
 			/* role may not be associated with type */
 			return 0;
 
-- 
1.9.1
