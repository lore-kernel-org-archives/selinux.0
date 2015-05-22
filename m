Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4MHYvrq018775
 for <selinux@tycho.nsa.gov>; Fri, 22 May 2015 13:34:57 -0400
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH 1/2] libsepol: with pp to CIL,
 only associate declared roleattributes with in-scope types
Date: Fri, 22 May 2015 13:34:28 -0400
Message-ID: <1432316069-24113-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When a roleattribute is in a declared scope, CIL roletype statements are
generated for all types associated with it. This incorrectly includes
types that are associated with the roleattribute in optional blocks,
which can result in CIL resolution failures if the optional block is
turned off due to a missing type. So, change the roletype CIL statement
generation with roleattributes to mimic the behavior of roles, ensuring
declared roleattributes are only associated with in-scope types.

Signed-off-by: Steve Lawrence <slawrence@tresys.com>
Reported-by: Miroslav Grepl <mgrepl@redhat.com>
---
 libsepol/src/module_to_cil.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 8d16d3e..1ded21d 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2091,7 +2091,9 @@ static int role_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 
 
 		for (i = 0; i < num_types; i++) {
-			cil_println(indent, "(roletype %s %s)", key, types[i]);
+			if (is_id_in_scope(pdb, decl_stack, types[i], SYM_TYPES)) {
+				cil_println(indent, "(roletype %s %s)", key, types[i]);
+			}
 		}
 
 		break;
-- 
2.1.0
