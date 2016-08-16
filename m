From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, jwcart2@tycho.nsa.gov, seandroid-list@tycho.nsa.gov,
 sds@tycho.nsa.gov
Subject: [PATCH v4 6/7] libsepol: fix unitialized jmp and invalid dereference
Date: Tue, 16 Aug 2016 10:28:36 -0700
Message-Id: <1471368517-20552-7-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1471368517-20552-1-git-send-email-william.c.roberts@intel.com>
References: <1471368517-20552-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

When initializing role_datum_t array, initialize the array.
This corrects this issue:

==25766== Conditional jump or move depends on uninitialised value(s)
==25766==    at 0x40ABFE: context_is_valid (context.c:59)
==25766==    by 0x40AAED: policydb_context_isvalid (context.c:19)
==25766==    by 0x43CBF4: context_read_and_validate (policydb.c:1881)
==25766==    by 0x43E7B3: ocontext_read_selinux (policydb.c:2631)
==25766==    by 0x43EC4D: ocontext_read (policydb.c:2729)
==25766==    by 0x442019: policydb_read (policydb.c:3937)
==25766==    by 0x442F15: sepol_policydb_read (policydb_public.c:174)
==25766==    by 0x407ED4: init (check_seapp.c:885)
==25766==    by 0x408D83: main (check_seapp.c:1230)

Also, check for NULL when determining if a role can be associated
with a type.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsepol/src/context.c  | 2 +-
 libsepol/src/policydb.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/context.c b/libsepol/src/context.c
index 84dad34..420ee16 100644
--- a/libsepol/src/context.c
+++ b/libsepol/src/context.c
@@ -55,7 +55,7 @@ int context_is_valid(const policydb_t * p, const context_struct_t * c)
 		 * Role must be authorized for the type.
 		 */
 		role = p->role_val_to_struct[c->role - 1];
-		if (!ebitmap_get_bit(&role->cache, c->type - 1))
+		if (!role || !ebitmap_get_bit(&role->cache, c->type - 1))
 			/* role may not be associated with type */
 			return 0;
 
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index b8f6ca8..60761b7 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1068,7 +1068,7 @@ int policydb_index_others(sepol_handle_t * handle,
 
 	free(p->role_val_to_struct);
 	p->role_val_to_struct = (role_datum_t **)
-	    malloc(p->p_roles.nprim * sizeof(role_datum_t *));
+	    calloc(p->p_roles.nprim, sizeof(role_datum_t *));
 	if (!p->role_val_to_struct)
 		return -1;
 
-- 
1.9.1
