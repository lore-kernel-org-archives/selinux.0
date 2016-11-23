Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uANM7eoK023722
 for <selinux@tycho.nsa.gov>; Wed, 23 Nov 2016 17:07:40 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 895FE564A10
 for <selinux@tycho.nsa.gov>; Wed, 23 Nov 2016 23:07:37 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 5/5] libsepol: detect duplicated symbol IDs
Date: Wed, 23 Nov 2016 23:06:46 +0100
Message-Id: <20161123220646.23504-5-nicolas.iooss@m4x.org>
In-Reply-To: <20161123220646.23504-1-nicolas.iooss@m4x.org>
References: <20161123220646.23504-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

A valid policy would not have two symbols (classes, roles, users...)
sharing the same unique identifier. Make policydb_read() rejects such
policy files.

When ..._val_to_name translation tables were allocated with malloc(),
change to calloc() in order to initialize the tables with NULLs.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/conditional.c |  5 +++++
 libsepol/src/policydb.c    | 45 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
index e1bc961b2b52..8b2060ce3ff2 100644
--- a/libsepol/src/conditional.c
+++ b/libsepol/src/conditional.c
@@ -25,6 +25,7 @@
 #include <sepol/policydb/conditional.h>
 
 #include "private.h"
+#include "debug.h"
 
 /* move all type rules to top of t/f lists to help kernel on evaluation */
 static void cond_optimize(cond_av_list_t ** l)
@@ -551,6 +552,10 @@ int cond_index_bool(hashtab_key_t key, hashtab_datum_t datum, void *datap)
 	if (!booldatum->s.value || booldatum->s.value > p->p_bools.nprim)
 		return -EINVAL;
 
+	if (p->p_bool_val_to_name[booldatum->s.value - 1] != NULL ) {
+		ERR(NULL, "duplicated boolean ID %u", booldatum->s.value);
+		return -EINVAL;
+	}
 	p->p_bool_val_to_name[booldatum->s.value - 1] = key;
 	p->bool_val_to_struct[booldatum->s.value - 1] = booldatum;
 
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 38c38f42cd2d..cb5fba9c9c94 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -849,6 +849,10 @@ static int common_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
 	p = (policydb_t *) datap;
 	if (!comdatum->s.value || comdatum->s.value > p->p_commons.nprim)
 		return -EINVAL;
+	if (p->p_common_val_to_name[comdatum->s.value - 1] != NULL) {
+		ERR(NULL, "duplicated common ID %u", comdatum->s.value);
+		return -EINVAL;
+	}
 	p->p_common_val_to_name[comdatum->s.value - 1] = (char *)key;
 
 	return 0;
@@ -863,6 +867,11 @@ static int class_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
 	p = (policydb_t *) datap;
 	if (!cladatum->s.value || cladatum->s.value > p->p_classes.nprim)
 		return -EINVAL;
+	if (p->p_class_val_to_name[cladatum->s.value - 1] != NULL ||
+	    p->class_val_to_struct[cladatum->s.value - 1] != NULL ) {
+		ERR(NULL, "duplicated class ID %u", cladatum->s.value);
+		return -EINVAL;
+	}
 	p->p_class_val_to_name[cladatum->s.value - 1] = (char *)key;
 	p->class_val_to_struct[cladatum->s.value - 1] = cladatum;
 
@@ -878,6 +887,11 @@ static int role_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
 	p = (policydb_t *) datap;
 	if (!role->s.value || role->s.value > p->p_roles.nprim)
 		return -EINVAL;
+	if (p->p_role_val_to_name[role->s.value - 1] != NULL ||
+	    p->role_val_to_struct[role->s.value - 1] != NULL ) {
+		ERR(NULL, "duplicated role ID %u", role->s.value);
+		return -EINVAL;
+	}
 	p->p_role_val_to_name[role->s.value - 1] = (char *)key;
 	p->role_val_to_struct[role->s.value - 1] = role;
 
@@ -895,6 +909,11 @@ static int type_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
 	if (typdatum->primary) {
 		if (!typdatum->s.value || typdatum->s.value > p->p_types.nprim)
 			return -EINVAL;
+		if (p->p_type_val_to_name[typdatum->s.value - 1] != NULL ||
+		    p->type_val_to_struct[typdatum->s.value - 1] != NULL ) {
+			ERR(NULL, "duplicated type ID %u", typdatum->s.value);
+			return -EINVAL;
+		}
 		p->p_type_val_to_name[typdatum->s.value - 1] = (char *)key;
 		p->type_val_to_struct[typdatum->s.value - 1] = typdatum;
 	}
@@ -912,7 +931,11 @@ static int user_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
 
 	if (!usrdatum->s.value || usrdatum->s.value > p->p_users.nprim)
 		return -EINVAL;
-
+	if (p->p_user_val_to_name[usrdatum->s.value - 1] != NULL ||
+	    p->user_val_to_struct[usrdatum->s.value - 1] != NULL ) {
+		ERR(NULL, "duplicated user ID %u", usrdatum->s.value);
+		return -EINVAL;
+	}
 	p->p_user_val_to_name[usrdatum->s.value - 1] = (char *)key;
 	p->user_val_to_struct[usrdatum->s.value - 1] = usrdatum;
 
@@ -931,6 +954,10 @@ static int sens_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
 		if (!levdatum->level->sens ||
 		    levdatum->level->sens > p->p_levels.nprim)
 			return -EINVAL;
+		if (p->p_sens_val_to_name[levdatum->level->sens - 1] != NULL ) {
+			ERR(NULL, "duplicated sensitivity level %u", levdatum->level->sens);
+			return -EINVAL;
+		}
 		p->p_sens_val_to_name[levdatum->level->sens - 1] = (char *)key;
 	}
 
@@ -948,6 +975,10 @@ static int cat_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
 	if (!catdatum->isalias) {
 		if (!catdatum->s.value || catdatum->s.value > p->p_cats.nprim)
 			return -EINVAL;
+		if (p->p_cat_val_to_name[catdatum->s.value - 1] != NULL ) {
+			ERR(NULL, "duplicated cat ID %u", catdatum->s.value);
+			return -EINVAL;
+		}
 		p->p_cat_val_to_name[catdatum->s.value - 1] = (char *)key;
 	}
 
@@ -968,7 +999,7 @@ int policydb_index_classes(policydb_t * p)
 {
 	free(p->p_common_val_to_name);
 	p->p_common_val_to_name = (char **)
-	    malloc(p->p_commons.nprim * sizeof(char *));
+	    calloc(p->p_commons.nprim, sizeof(char *));
 	if (!p->p_common_val_to_name)
 		return -1;
 
@@ -977,13 +1008,13 @@ int policydb_index_classes(policydb_t * p)
 
 	free(p->class_val_to_struct);
 	p->class_val_to_struct = (class_datum_t **)
-	    malloc(p->p_classes.nprim * sizeof(class_datum_t *));
+	    calloc(p->p_classes.nprim, sizeof(class_datum_t *));
 	if (!p->class_val_to_struct)
 		return -1;
 
 	free(p->p_class_val_to_name);
 	p->p_class_val_to_name = (char **)
-	    malloc(p->p_classes.nprim * sizeof(char *));
+	    calloc(p->p_classes.nprim, sizeof(char *));
 	if (!p->p_class_val_to_name)
 		return -1;
 
@@ -999,7 +1030,7 @@ int policydb_index_bools(policydb_t * p)
 	if (cond_init_bool_indexes(p) == -1)
 		return -1;
 	p->p_bool_val_to_name = (char **)
-	    malloc(p->p_bools.nprim * sizeof(char *));
+	    calloc(p->p_bools.nprim, sizeof(char *));
 	if (!p->p_bool_val_to_name)
 		return -1;
 	if (hashtab_map(p->p_bools.table, cond_index_bool, p))
@@ -1035,6 +1066,10 @@ int policydb_index_decls(policydb_t * p)
 				ERR(NULL, "invalid decl ID %u", decl->decl_id);
 				return -1;
 			}
+			if (p->decl_val_to_struct[decl->decl_id - 1] != NULL) {
+				ERR(NULL, "duplicated decl ID %u", decl->decl_id);
+				return -1;
+			}
 			p->decl_val_to_struct[decl->decl_id - 1] = decl;
 		}
 	}
-- 
2.10.2
