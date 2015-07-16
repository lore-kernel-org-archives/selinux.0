From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsepol: fix policydb_read for policy versions < 24
Date: Thu, 16 Jul 2015 09:33:32 -0400
Message-Id: <1437053612-17564-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Policy versions < 24 did not include type attributes in the types symtab,
so there can be holes in the type_val_to_struct array.  Fixes a segfault
during the downgrade test performed by a make test in libsepol.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsepol/src/policydb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 670aef8..665f7a9 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -3936,7 +3936,7 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 			/* add the type itself as the degenerate case */
 			if (ebitmap_set_bit(&p->type_attr_map[i], i, 1))
 				goto bad;
-			if (p->type_val_to_struct[i]->flavor != TYPE_ATTRIB) {
+			if (p->type_val_to_struct[i] && p->type_val_to_struct[i]->flavor != TYPE_ATTRIB) {
 				if (ebitmap_set_bit(&p->attr_type_map[i], i, 1))
 					goto bad;
 			}
-- 
2.1.0
