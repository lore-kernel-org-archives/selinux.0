Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s92GBUKE011989
 for <selinux@tycho.nsa.gov>; Thu, 2 Oct 2014 12:11:30 -0400
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH] policycoreutils/hll/pp: only print certain roles when
 declared in base modules
Date: Thu, 2 Oct 2014 12:11:11 -0400
Message-ID: <1412266271-20158-1-git-send-email-slawrence@tresys.com>
In-Reply-To: <542D6E4E.1070602@tresys.com>
References: <542D6E4E.1070602@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Some roles (i.e. user_r, staff_r, sysadm_r, system_r, unconfined_r) are
declared in the base module, and sometimes in non-base modules. This
could result in duplicate declarations of roles, which isn't allowed in
CIL. So for these roles, only generate their declarations if they appear
in a base module, otherwise ignore their declarations. All other roles
are printed regardlss of their declaration location.

Note that this means that if a policy author does not include one of the
roles in the base module then they will not be included in the resulting
policy, likely causing a compliation error in CIL.

Signed-off-by: Steve Lawrence <slawrence@tresys.com>
---
 policycoreutils/hll/pp/pp.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
index ee6a12c..1a18888 100644
--- a/policycoreutils/hll/pp/pp.c
+++ b/policycoreutils/hll/pp/pp.c
@@ -1889,7 +1889,29 @@ static int role_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 	switch (role->flavor) {
 	case ROLE_ROLE:
 		if (scope == SCOPE_DECL) {
-			cil_println(indent, "(role %s)", key);
+			// Only declare certain roles if we are reading a base module.
+			// These roles are defined in the base module and sometimes in
+			// other non-base modules. If we generated the roles regardless of
+			// the policy type, it would result in duplicate declarations,
+			// which isn't allowed in CIL. Patches have been made to refpolicy
+			// to remove these duplicate role declarations, but we need to be
+			// backwards compatable and support older policies. Since we know
+			// these roles are always declared in base, only print them when we
+			// see them in the base module. If the declarations appear in a
+			// non-base module, ignore their declarations.
+			//
+			// Note that this is a hack, and if a policy author does not define
+			// one of these roles in base, the declaration will not appeaer in
+			// the resulting policy, likely resulting in a compilation error in
+			// CIL.
+			int is_base_role = (!strcmp(key, "user_r") ||
+			                    !strcmp(key, "staff_r") ||
+			                    !strcmp(key, "sysadm_r") ||
+			                    !strcmp(key, "system_r") ||
+			                    !strcmp(key, "unconfined_r"));
+			if ((is_base_role && pdb->policy_type == SEPOL_POLICY_BASE) || !is_base_role) {
+				cil_println(indent, "(role %s)", key);
+			}
 		}
 
 		if (ebitmap_cardinality(&role->dominates) > 1) {
-- 
1.9.3
