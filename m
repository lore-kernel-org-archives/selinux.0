Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sAJHhRF4012436
 for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2014 12:43:27 -0500
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH] policycoreutils: pp: add roletype statements for both
 declared and required type/typeattributes
Date: Wed, 19 Nov 2014 12:43:04 -0500
Message-ID: <1416418984-18875-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Currently, roletype statements are only added for types when they are
declared (not required). This means that in policy like:

  require {
    type foo_t;
  }
  type bar_t;
  role staff_r types foo_t, bar_t;

only bar_t is associated with staff_r. This patch moves the code that
generates roletype statements for types to outside the SCOPE_DECL check
so that roletype statements are generated for all types, regardless of
the required/declared scope. It further moves the code outside of the
type/typeattribute flavor check so that roletype statements are also
generated for typeattributes.

Reported-by: Sven Vermeulen <sven.vermeulen@siphos.be>
Signed-off-by: Steve Lawrence <slawrence@tresys.com>
Reviewed-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
---
 policycoreutils/hll/pp/pp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
index b1ef27f..4b9f310 100644
--- a/policycoreutils/hll/pp/pp.c
+++ b/policycoreutils/hll/pp/pp.c
@@ -2083,6 +2083,11 @@ static int type_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 		cil_println(indent, "(typeattributeset " GEN_REQUIRE_ATTR " %s)", key);
 	}
 
+	rc = roletype_role_in_ancestor_to_cil(pdb, decl_stack, key, indent);
+	if (rc != 0) {
+		goto exit;
+	}
+
 	switch(type->flavor) {
 	case TYPE_TYPE:
 		if (scope == SCOPE_DECL) {
@@ -2090,11 +2095,6 @@ static int type_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 			// object_r is implicit in checkmodule, but not with CIL,
 			// create it as part of base
 			cil_println(indent, "(roletype " DEFAULT_OBJECT " %s)", key);
-
-			rc = roletype_role_in_ancestor_to_cil(pdb, decl_stack, key, indent);
-			if (rc != 0) {
-				goto exit;
-			}
 		}
 
 		if (type->flags & TYPE_FLAGS_PERMISSIVE) {
-- 
1.9.3
