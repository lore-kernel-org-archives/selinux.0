Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8ELg5sO009297
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 17:42:24 -0400
Received: by mail-wi0-f170.google.com with SMTP id em10so1605022wid.5
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 14:42:30 -0700 (PDT)
Received: from eversmanni.localdomain (193.147.102.84.rev.sfr.net.
 [84.102.147.193])
 by mx.google.com with ESMTPSA id bj7sm12547688wjc.33.2014.09.14.14.42.29
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 14 Sep 2014 14:42:29 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 13/20] libsepol/cil: fix gcc -Wwrite-strings warnings
Date: Sun, 14 Sep 2014 23:41:44 +0200
Message-Id: <1410730911-14512-14-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
References: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 libsepol/cil/src/cil.c         |  2 +-
 libsepol/cil/src/cil_mem.c     |  2 +-
 libsepol/cil/src/cil_mem.h     |  2 +-
 libsepol/cil/src/cil_policy.c  | 10 +++++-----
 libsepol/cil/src/cil_strpool.c |  2 +-
 libsepol/cil/src/cil_strpool.h |  2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index b8ba6dc5d0a7..9e88e45b83d9 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -1326,7 +1326,7 @@ int cil_filecons_to_string(struct cil_db *db, sepol_policydb_t *sepol_db, char *
 	for (i = 0; i < filecons->count; i++) {
 		struct cil_filecon *filecon = filecons->array[i];
 		struct cil_context *ctx = filecon->context;
-		char *str_type = NULL; 
+		const char *str_type = NULL;
 
 		buf_pos = sprintf(str_tmp, "%s", filecon->path_str);
 		str_tmp += buf_pos;
diff --git a/libsepol/cil/src/cil_mem.c b/libsepol/cil/src/cil_mem.c
index 06d9e1086fa6..e19bc358e365 100644
--- a/libsepol/cil/src/cil_mem.c
+++ b/libsepol/cil/src/cil_mem.c
@@ -83,7 +83,7 @@ void *cil_realloc(void *ptr, size_t size)
 }
 
 
-char *cil_strdup(char *str)
+char *cil_strdup(const char *str)
 {
 	char *mem = NULL;
 
diff --git a/libsepol/cil/src/cil_mem.h b/libsepol/cil/src/cil_mem.h
index bf4b1ab256c5..3e4263c133e3 100644
--- a/libsepol/cil/src/cil_mem.h
+++ b/libsepol/cil/src/cil_mem.h
@@ -34,7 +34,7 @@
 void *cil_malloc(size_t size);
 void *cil_calloc(size_t num_elements, size_t element_size);
 void *cil_realloc(void *ptr, size_t size);
-char *cil_strdup(char *str);
+char *cil_strdup(const char *str);
 void (*cil_mem_error_handler)(void);
 
 #endif /* CIL_MEM_H_ */
diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index 9b131ee57e55..d19accbf21c7 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -542,7 +542,7 @@ void cil_constrain_to_policy(FILE **file_arr, __attribute__((unused)) uint32_t f
 	cil_constrain_to_policy_helper(file_arr, kind, cons->classperms, cons->datum_expr);
 }
 
-void cil_avrule_to_policy_helper(FILE **file_arr, uint32_t file_index, char *kind, char *src, char *tgt, struct cil_list *classperms)
+void cil_avrule_to_policy_helper(FILE **file_arr, uint32_t file_index, const char *kind, const char *src, const char *tgt, struct cil_list *classperms)
 {
 	struct cil_list_item *i;
 
@@ -573,9 +573,9 @@ void cil_avrule_to_policy_helper(FILE **file_arr, uint32_t file_index, char *kin
 
 int cil_avrule_to_policy(FILE **file_arr, uint32_t file_index, struct cil_avrule *rule)
 {
-	char *kind_str = NULL;
-	char *src_str = DATUM(rule->src)->name;
-	char *tgt_str = DATUM(rule->tgt)->name;
+	const char *kind_str = NULL;
+	const char *src_str = DATUM(rule->src)->name;
+	const char *tgt_str = DATUM(rule->tgt)->name;
 
 
 	switch (rule->rule_kind) {
@@ -974,7 +974,7 @@ int cil_name_to_policy(FILE **file_arr, struct cil_tree_node *current)
 		fprintf(file_arr[TYPEATTRTYPES], "role %s;\n", ((struct cil_symtab_datum*)current->data)->name);
 		break;
 	case CIL_BOOL: {
-		char *boolean = ((struct cil_bool*)current->data)->value ? "true" : "false";
+		const char *boolean = ((struct cil_bool*)current->data)->value ? "true" : "false";
 		fprintf(file_arr[TYPEATTRTYPES], "bool %s %s;\n", ((struct cil_symtab_datum*)current->data)->name, boolean);
 		break;
 	}
diff --git a/libsepol/cil/src/cil_strpool.c b/libsepol/cil/src/cil_strpool.c
index 65af77d85865..ad2a334f8ebf 100644
--- a/libsepol/cil/src/cil_strpool.c
+++ b/libsepol/cil/src/cil_strpool.c
@@ -64,7 +64,7 @@ static int cil_strpool_compare(hashtab_t h __attribute__ ((unused)), hashtab_key
 	return strcmp(keyp1, keyp2);
 }
 
-char *cil_strpool_add(char *str)
+char *cil_strpool_add(const char *str)
 {
 	struct cil_strpool_entry *strpool_ref = NULL;
 
diff --git a/libsepol/cil/src/cil_strpool.h b/libsepol/cil/src/cil_strpool.h
index 0c3f1c547eb6..a61a2d954092 100644
--- a/libsepol/cil/src/cil_strpool.h
+++ b/libsepol/cil/src/cil_strpool.h
@@ -32,7 +32,7 @@
 
 #include <sepol/policydb/hashtab.h>
 
-char *cil_strpool_add(char *str);
+char *cil_strpool_add(const char *str);
 void cil_strpool_init(void);
 void cil_strpool_destroy(void);
 #endif /* CIL_STRPOOL_H_ */
-- 
2.1.0
