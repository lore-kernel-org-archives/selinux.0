Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5EIM8qW019297
 for <selinux@tycho.nsa.gov>; Wed, 14 Jun 2017 14:22:08 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH v2] libsepol/cil: Fix bugs when writing policy.conf rules
Date: Wed, 14 Jun 2017 14:23:08 -0400
Message-Id: <20170614182308.22885-1-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The typebounds rules should end with a ";".

The netifcon and nodecon rules should not end with a ";".

The default rules are missing a "_". They should be "default_user",
"default_role" and "default_type".

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
v2: "default_user", not "default_usr"

 libsepol/cil/src/cil_policy.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index 2196ae8..729b6e0 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -1069,7 +1069,7 @@ static void cil_typebounds_to_policy(FILE *out, struct cil_list *types)
 		child = i1->data;
 		if (child->bounds != NULL) {
 			parent = child->bounds;
-			fprintf(out, "typebounds %s %s\n", parent->datum.fqn, child->datum.fqn);
+			fprintf(out, "typebounds %s %s;\n", parent->datum.fqn, child->datum.fqn);
 		}
 	}
 }
@@ -1779,7 +1779,7 @@ static void cil_netifcons_to_policy(FILE *out, struct cil_sort *netifcons, int m
 		cil_context_to_policy(out, netifcon->if_context, mls);
 		fprintf(out, " ");
 		cil_context_to_policy(out, netifcon->packet_context, mls);
-		fprintf(out, ";\n");
+		fprintf(out, "\n");
 	}
 }
 
@@ -1836,7 +1836,7 @@ static void cil_nodecons_to_policy(FILE *out, struct cil_sort *nodecons, int mls
 		}
 
 		cil_context_to_policy(out, nodecon->context, mls);
-		fprintf(out, ";\n");
+		fprintf(out, "\n");
 	}
 }
 
@@ -1928,9 +1928,9 @@ void cil_gen_policy(FILE *out, struct cil_db *db)
 	cil_commons_to_policy(out, lists[CIL_LIST_COMMON]);
 	cil_classes_to_policy(out, db->classorder);
 
-	cil_defaults_to_policy(out, lists[CIL_LIST_DEFAULT_USER], CIL_KEY_DEFAULTUSER);
-	cil_defaults_to_policy(out, lists[CIL_LIST_DEFAULT_ROLE], CIL_KEY_DEFAULTROLE);
-	cil_defaults_to_policy(out, lists[CIL_LIST_DEFAULT_TYPE], CIL_KEY_DEFAULTTYPE);
+	cil_defaults_to_policy(out, lists[CIL_LIST_DEFAULT_USER], "default_user");
+	cil_defaults_to_policy(out, lists[CIL_LIST_DEFAULT_ROLE], "default_role");
+	cil_defaults_to_policy(out, lists[CIL_LIST_DEFAULT_TYPE], "default_type");
 
 	if (db->mls == CIL_TRUE) {
 		cil_default_ranges_to_policy(out, lists[CIL_LIST_DEFAULT_RANGE]);
-- 
2.9.4
