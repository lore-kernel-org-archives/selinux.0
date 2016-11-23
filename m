From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 1/2] libsepol: do not write object_r types to policy file
Date: Wed, 23 Nov 2016 12:11:28 -0500
Message-Id: <1479921089-11519-2-git-send-email-sds@tycho.nsa.gov>
In-Reply-To: <1479921089-11519-1-git-send-email-sds@tycho.nsa.gov>
References: <1479921089-11519-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Originally object_r's types bitmap was empty since we exempt
object_r from the normal user-role and role-type checks.  CIL
however sets object_r's types to all types to avoid special case
logic.  However, the kernel does not load object_r types from the
policy file; it predefines object_r and merely validates that the
object_r definition in the policy has the expected value.  Thus,
the actual policy file and the /sys/fs/selinux/policy file were
differing in their object_r entry.  Fix this by not writing object_r's
types to the policy file, since they are ignored by the kernel
anyway.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsepol/src/write.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index d87ea61..fbc6dad 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -1078,8 +1078,25 @@ static int role_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 	if (ebitmap_write(&role->dominates, fp))
 		return POLICYDB_ERROR;
 	if (p->policy_type == POLICY_KERN) {
-		if (ebitmap_write(&role->types.types, fp))
-			return POLICYDB_ERROR;
+		if (role->s.value == OBJECT_R_VAL) {
+			/*
+			 * CIL populates object_r's types map
+			 * rather than handling it as a special case.
+			 * However, this creates an inconsistency with
+			 * the kernel policy read from /sys/fs/selinux/policy
+			 * because the kernel ignores everything except for
+			 * object_r's value from the policy file.
+			 * Make them consistent by writing an empty
+			 * ebitmap instead.
+			 */
+			ebitmap_t empty;
+			ebitmap_init(&empty);
+			if (ebitmap_write(&empty, fp))
+				return POLICYDB_ERROR;
+		} else {
+			if (ebitmap_write(&role->types.types, fp))
+				return POLICYDB_ERROR;
+		}
 	} else {
 		if (type_set_write(&role->types, fp))
 			return POLICYDB_ERROR;
-- 
2.7.4
