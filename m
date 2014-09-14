Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8ELgsEL009324
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 17:42:54 -0400
Received: by mail-we0-f171.google.com with SMTP id p10so3081875wes.30
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 14:42:34 -0700 (PDT)
Received: from eversmanni.localdomain (193.147.102.84.rev.sfr.net.
 [84.102.147.193])
 by mx.google.com with ESMTPSA id bj7sm12547688wjc.33.2014.09.14.14.42.33
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 14 Sep 2014 14:42:33 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 16/20] policycoreutils/hll/pp: fix gcc -Wwrite-strings warnings
Date: Sun, 14 Sep 2014 23:41:47 +0200
Message-Id: <1410730911-14512-17-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
References: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 policycoreutils/hll/pp/pp.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
index 93e2889b78f6..c79f4e3ad983 100644
--- a/policycoreutils/hll/pp/pp.c
+++ b/policycoreutils/hll/pp/pp.c
@@ -230,11 +230,11 @@ static int semantic_level_to_cil(struct policydb *pdb, int sens_offset, struct m
 	return 0;
 }
 
-static int avrule_to_cil(int indent, struct policydb *pdb, uint32_t type, char *src, char *tgt, struct class_perm_node *classperms)
+static int avrule_to_cil(int indent, struct policydb *pdb, uint32_t type, const char *src, const char *tgt, const struct class_perm_node *classperms)
 {
 	int rc = -1;
-	char *rule;
-	struct class_perm_node *classperm;
+	const char *rule;
+	const struct class_perm_node *classperm;
 	char *perms;
 
 	switch (type) {
@@ -318,8 +318,8 @@ static int set_to_cil_attr(int indent, struct policydb *pdb, int is_type, struct
 	int rc = -1;
 	struct ebitmap_node *node;
 	unsigned int i;
-	char *attr_infix;
-	char *statement;
+	const char *attr_infix;
+	const char *statement;
 	char *attr;
 	int len;
 	int rlen;
@@ -655,9 +655,9 @@ static int cond_expr_to_cil(int indent, struct policydb *pdb, struct cond_expr *
 	char *val1 = NULL;
 	char *val2 = NULL;
 	int num_params;
-	char *op;
-	char *fmt_str;
-	char *type;
+	const char *op;
+	const char *fmt_str;
+	const char *type;
 
 	rc = stack_init(&stack);
 	if (rc != 0) {
@@ -1105,10 +1105,10 @@ static int constraint_expr_to_string(int indent, struct policydb *pdb, struct co
 	char *val1 = NULL;
 	char *val2 = NULL;
 	uint32_t num_params;
-	char *op;
-	char *fmt_str;
-	char *attr1;
-	char *attr2;
+	const char *op;
+	const char *fmt_str;
+	const char *attr1;
+	const char *attr2;
 	char *names;
 	char **name_list = NULL;
 	uint32_t num_names = 0;
@@ -1315,7 +1315,7 @@ static int constraints_to_cil(int indent, struct policydb *pdb, char *classkey,
 	int rc = -1;
 	struct constraint_node *node;
 	char *expr = NULL;
-	char *mls;
+	const char *mls;
 	char *perms;
 
 	mls = pdb->mls ? "mls" : "";
@@ -1349,7 +1349,7 @@ static int class_to_cil(int indent, struct policydb *pdb, struct avrule_block *U
 {
 	int rc = -1;
 	struct class_datum *class = datum;
-	char *dflt;
+	const char *dflt;
 	struct class_perm_array arr;
 	uint32_t i;
 
@@ -1667,7 +1667,7 @@ static int user_to_cil(int indent, struct policydb *pdb, struct avrule_block *bl
 static int boolean_to_cil(int indent, struct policydb *UNUSED(pdb), struct avrule_block *UNUSED(block), struct avrule_decl *UNUSED(decl), char *key, void *datum,  int scope)
 {
 	struct cond_bool_datum *boolean = datum;
-	char *type;
+	const char *type;
 
 	if (scope == SCOPE_DECL) {
 		if (boolean->flags & COND_BOOL_FLAGS_TUNABLE) {
@@ -1976,7 +1976,7 @@ static int ocontext_selinux_port_to_cil(struct policydb *pdb, struct ocontext *p
 {
 	int rc = -1;
 	struct ocontext *portcon;
-	char *protocol;
+	const char *protocol;
 	uint16_t high;
 	uint16_t low;
 
@@ -2095,7 +2095,7 @@ static int ocontext_selinux_fsuse_to_cil(struct policydb *pdb, struct ocontext *
 {
 	int rc = -1;
 	struct ocontext *fsuse;
-	char *behavior;
+	const char *behavior;
 
 
 	for (fsuse = fsuses; fsuse != NULL; fsuse = fsuse->next) {
@@ -2562,7 +2562,7 @@ static int file_contexts_to_cil(struct sepol_module_package *mod_pkg)
 	char *regex = NULL;
 	char *mode = NULL;
 	char *context = NULL;
-	char *cilmode;
+	const char *cilmode;
 
 	if (fc_len == 0) {
 		return 0;
@@ -3107,7 +3107,7 @@ exit:
 static int handle_unknown_to_cil(struct policydb *pdb)
 {
 	int rc = -1;
-	char *hu;
+	const char *hu;
 
 	switch (pdb->handle_unknown) {
 	case SEPOL_DENY_UNKNOWN:
@@ -3135,7 +3135,7 @@ exit:
 
 static int generate_mls(struct policydb *pdb)
 {
-	char *mls_str = pdb->mls ? "true" : "false";
+	const char *mls_str = pdb->mls ? "true" : "false";
 	cil_println(0, "(mls %s)", mls_str);
 
 	return 0;
-- 
2.1.0
