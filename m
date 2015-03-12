From: Daniel De Graaf <dgdegra@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/4] Expand Xen IOMEMCON to 64 bits
Date: Thu, 12 Mar 2015 13:12:27 -0400
Message-Id: <1426180350-16259-2-git-send-email-dgdegra@tycho.nsa.gov>
In-Reply-To: <1426180350-16259-1-git-send-email-dgdegra@tycho.nsa.gov>
References: <1426180350-16259-1-git-send-email-dgdegra@tycho.nsa.gov>
Cc: xen-devel@lists.xenproject.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This change is required to support static I/O memory range labeling for
systems with over 16TB of physical address space.

Signed-off-by: Daniel De Graaf <dgdegra@tycho.nsa.gov>
---
 checkpolicy/policy_define.c                |  6 +++---
 checkpolicy/policy_define.h                |  2 +-
 checkpolicy/policy_parse.y                 |  9 +++++++--
 libsepol/cil/src/cil_build_ast.c           | 32 +++++++++++++++++++++++++++---
 libsepol/cil/src/cil_build_ast.h           |  1 +
 libsepol/cil/src/cil_internal.h            |  4 ++--
 libsepol/cil/src/cil_policy.c              |  2 +-
 libsepol/cil/src/cil_tree.c                |  2 +-
 libsepol/include/sepol/policydb/policydb.h |  7 +++++--
 libsepol/src/policydb.c                    | 28 ++++++++++++++++++++------
 libsepol/src/write.c                       | 25 ++++++++++++++++-------
 policycoreutils/hll/pp/pp.c                |  4 ++--
 12 files changed, 92 insertions(+), 30 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index a6c5d65..f4c6fba 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -3932,7 +3932,7 @@ bad:
 	return -1;
 }
 
-int define_iomem_context(unsigned long low, unsigned long high)
+int define_iomem_context(uint64_t low, uint64_t high)
 {
 	ocontext_t *newc, *c, *l, *head;
 	char *id;
@@ -3972,13 +3972,13 @@ int define_iomem_context(unsigned long low, unsigned long high)
 
 	head = policydbp->ocontexts[OCON_XEN_IOMEM];
 	for (l = NULL, c = head; c; l = c, c = c->next) {
-		uint32_t low2, high2;
+		uint64_t low2, high2;
 
 		low2 = c->u.iomem.low_iomem;
 		high2 = c->u.iomem.high_iomem;
 		if (low <= high2 && low2 <= high) {
 			yyerror2("iomemcon entry for 0x%lx-0x%lx overlaps with "
-				"earlier entry 0x%x-0x%x", low, high,
+				"earlier entry 0x%lx-0x%lx", low, high,
 				low2, high2);
 			goto bad;
 		}
diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
index 4ef0f4f..14d30e1 100644
--- a/checkpolicy/policy_define.h
+++ b/checkpolicy/policy_define.h
@@ -46,7 +46,7 @@ int define_permissive(void);
 int define_polcap(void);
 int define_port_context(unsigned int low, unsigned int high);
 int define_pirq_context(unsigned int pirq);
-int define_iomem_context(unsigned long low, unsigned long high);
+int define_iomem_context(uint64_t low, uint64_t high);
 int define_ioport_context(unsigned long low, unsigned long high);
 int define_pcidevice_context(unsigned long device);
 int define_range_trans(int class_specified);
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 15c8997..a489088 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -67,6 +67,7 @@ typedef int (* require_func_t)(int pass);
 
 %union {
 	unsigned int val;
+	uint64_t val64;
 	uintptr_t valptr;
 	void *ptr;
         require_func_t require_func;
@@ -78,6 +79,7 @@ typedef int (* require_func_t)(int pass);
 %type <ptr> role_def roles
 %type <valptr> cexpr cexpr_prim op role_mls_op
 %type <val> ipv4_addr_def number
+%type <val64> number64
 %type <require_func> require_decl_def
 
 %token PATH
@@ -646,9 +648,9 @@ dev_context_def		: pirq_context_def |
 pirq_context_def 	: PIRQCON number security_context_def
 		        {if (define_pirq_context($2)) return -1;}
 		        ;
-iomem_context_def	: IOMEMCON number security_context_def
+iomem_context_def	: IOMEMCON number64 security_context_def
 		        {if (define_iomem_context($2,$2)) return -1;}
-		        | IOMEMCON number '-' number security_context_def
+		        | IOMEMCON number64 '-' number64 security_context_def
 		        {if (define_iomem_context($2,$4)) return -1;}
 		        ;
 ioport_context_def	: IOPORTCON number security_context_def
@@ -812,6 +814,9 @@ filename		: FILENAME
 number			: NUMBER 
 			{ $$ = strtoul(yytext,NULL,0); }
 			;
+number64		: NUMBER
+			{ $$ = strtoull(yytext,NULL,0); }
+			;
 ipv6_addr		: IPV6_ADDR
 			{ if (insert_id(yytext,0)) return -1; }
 			;
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 419c20f..1949d2b 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -4319,12 +4319,12 @@ int cil_gen_iomemcon(__attribute__((unused)) struct cil_db *db, struct cil_tree_
 	if (parse_current->next->cl_head != NULL) {
 		if (parse_current->next->cl_head->next != NULL &&
 		    parse_current->next->cl_head->next->next == NULL) {
-			rc = cil_fill_integer(parse_current->next->cl_head, &iomemcon->iomem_low);
+			rc = cil_fill_integer64(parse_current->next->cl_head, &iomemcon->iomem_low);
 			if (rc != SEPOL_OK) {
 				cil_log(CIL_ERR, "Improper iomem specified\n");
 				goto exit;
 			}
-			rc = cil_fill_integer(parse_current->next->cl_head->next, &iomemcon->iomem_high);
+			rc = cil_fill_integer64(parse_current->next->cl_head->next, &iomemcon->iomem_high);
 			if (rc != SEPOL_OK) {
 				cil_log(CIL_ERR, "Improper iomem specified\n");
 				goto exit;
@@ -4335,7 +4335,7 @@ int cil_gen_iomemcon(__attribute__((unused)) struct cil_db *db, struct cil_tree_
 			goto exit;
 		}
 	} else {
-		rc = cil_fill_integer(parse_current->next, &iomemcon->iomem_low);;
+		rc = cil_fill_integer64(parse_current->next, &iomemcon->iomem_low);;
 		if (rc != SEPOL_OK) {
 			cil_log(CIL_ERR, "Improper iomem specified\n");
 			goto exit;
@@ -5054,6 +5054,32 @@ exit:
 	return rc;
 }
 
+int cil_fill_integer64(struct cil_tree_node *int_node, uint64_t *integer)
+{
+	int rc = SEPOL_ERR;
+	char *endptr = NULL;
+	uint64_t val;
+
+	if (int_node == NULL || integer == NULL) {
+		goto exit;
+	}
+
+	errno = 0;
+	val = strtoull(int_node->data, &endptr, 10);
+	if (errno != 0 || endptr == int_node->data || *endptr != '\0') {
+		rc = SEPOL_ERR;
+		goto exit;
+	}
+
+	*integer = val;
+
+	return SEPOL_OK;
+
+exit:
+	cil_log(CIL_ERR, "Failed to create integer from string\n");
+	return rc;
+}
+
 int cil_fill_ipaddr(struct cil_tree_node *addr_node, struct cil_ipaddr *addr)
 {
 	int rc = SEPOL_ERR;
diff --git a/libsepol/cil/src/cil_build_ast.h b/libsepol/cil/src/cil_build_ast.h
index 5b07c14..1bd33ce 100644
--- a/libsepol/cil/src/cil_build_ast.h
+++ b/libsepol/cil/src/cil_build_ast.h
@@ -211,6 +211,7 @@ int cil_fill_cats(struct cil_tree_node *curr, struct cil_cats **cats);
 void cil_destroy_cats(struct cil_cats *cats);
 int cil_fill_context(struct cil_tree_node *user_node, struct cil_context *context);
 int cil_fill_integer(struct cil_tree_node *int_node, uint32_t *integer);
+int cil_fill_integer64(struct cil_tree_node *int_node, uint64_t *integer);
 int cil_fill_ipaddr(struct cil_tree_node *addr_node, struct cil_ipaddr *addr);
 int cil_fill_level(struct cil_tree_node *sens, struct cil_level *level);
 
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index cf0a8b1..11a2085 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -719,8 +719,8 @@ struct cil_pirqcon {
 };
 
 struct cil_iomemcon {
-	uint32_t iomem_low;
-	uint32_t iomem_high;
+	uint64_t iomem_low;
+	uint64_t iomem_high;
 	char *context_str;
 	struct cil_context *context;
 };
diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index ec38f69..7707a75 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -236,7 +236,7 @@ int cil_iomemcon_to_policy(FILE **file_arr, struct cil_sort *sort)
 
 	for (i = 0; i < sort->count; i++) {
 		struct cil_iomemcon *iomemcon = (struct cil_iomemcon*)sort->array[i];
-		fprintf(file_arr[NETIFCONS], "iomemcon %d-%d ", iomemcon->iomem_low, iomemcon->iomem_high);
+		fprintf(file_arr[NETIFCONS], "iomemcon %ld-%ld ", iomemcon->iomem_low, iomemcon->iomem_high);
 		cil_context_to_policy(file_arr, NETIFCONS, iomemcon->context);
 		fprintf(file_arr[NETIFCONS], ";\n");
 	}
diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 4f9f480..5420af2 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -1392,7 +1392,7 @@ void cil_tree_print_node(struct cil_tree_node *node)
 		case CIL_IOMEMCON: {
 			struct cil_iomemcon *iomemcon = node->data;
 
-			cil_log(CIL_INFO, "IOMEMCON ( %d %d )", iomemcon->iomem_low, iomemcon->iomem_high);
+			cil_log(CIL_INFO, "IOMEMCON ( %ld %ld )", iomemcon->iomem_low, iomemcon->iomem_high);
 			if (iomemcon->context != NULL) {
 				cil_tree_print_context(iomemcon->context);
 			} else {
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 6254fef..eaa87ef 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -325,8 +325,8 @@ typedef struct ocontext {
 		uint32_t device;
 		uint16_t pirq;
 		struct {
-			uint32_t low_iomem;
-			uint32_t high_iomem;
+			uint64_t low_iomem;
+			uint64_t high_iomem;
 		} iomem;
 		struct {
 			uint32_t low_ioport;
@@ -690,6 +690,9 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define POLICYDB_VERSION_DEFAULT_TYPE	28
 #define POLICYDB_VERSION_CONSTRAINT_NAMES	29
 
+#define POLICYDB_XEN_VERSION_BASE   24
+#define POLICYDB_XEN_VERSION_AARCH  25
+
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
 #define POLICYDB_VERSION_MAX	POLICYDB_VERSION_CONSTRAINT_NAMES
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 667e98a..84d97ad 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -61,7 +61,14 @@ const char *policydb_target_strings[] = { POLICYDB_STRING, POLICYDB_XEN_STRING }
 static struct policydb_compat_info policydb_compat[] = {
 	{
 	 .type = POLICY_KERN,
-	 .version = POLICYDB_VERSION_BOUNDARY,
+	 .version = POLICYDB_XEN_VERSION_BASE,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_XEN_PCIDEVICE + 1,
+	 .target_platform = SEPOL_TARGET_XEN,
+	 },
+	{
+	 .type = POLICY_KERN,
+	 .version = POLICYDB_XEN_VERSION_AARCH,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = OCON_XEN_PCIDEVICE + 1,
 	 .target_platform = SEPOL_TARGET_XEN,
@@ -2514,11 +2521,20 @@ static int ocontext_read_xen(struct policydb_compat_info *info,
 					return -1;
 				break;
 			case OCON_XEN_IOMEM:
-				rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
-				if (rc < 0)
-					return -1;
-				c->u.iomem.low_iomem = le32_to_cpu(buf[0]);
-				c->u.iomem.high_iomem = le32_to_cpu(buf[1]);
+				if (p->policyvers >= POLICYDB_XEN_VERSION_AARCH) {
+					uint64_t b64[2];
+					rc = next_entry(b64, fp, sizeof(uint64_t) * 2);
+					if (rc < 0)
+						return -1;
+					c->u.iomem.low_iomem = le64_to_cpu(b64[0]);
+					c->u.iomem.high_iomem = le64_to_cpu(b64[1]);
+				} else {
+					rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
+					if (rc < 0)
+						return -1;
+					c->u.iomem.low_iomem = le32_to_cpu(buf[0]);
+					c->u.iomem.high_iomem = le32_to_cpu(buf[1]);
+				}
 				if (context_read_and_validate
 				    (&c->context[0], p, fp))
 					return -1;
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index d03dc20..d98a5eb 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -1252,13 +1252,24 @@ static int ocontext_write_xen(struct policydb_compat_info *info, policydb_t *p,
 					return POLICYDB_ERROR;
 				break;
 			case OCON_XEN_IOMEM:
-				buf[0] = c->u.iomem.low_iomem;
-				buf[1] = c->u.iomem.high_iomem;
-				for (j = 0; j < 2; j++)
-					buf[j] = cpu_to_le32(buf[j]);
-				items = put_entry(buf, sizeof(uint32_t), 2, fp);
-				if (items != 2)
-					return POLICYDB_ERROR;
+				if (p->policyvers >= POLICYDB_XEN_VERSION_AARCH) {
+					uint64_t b64[2];
+					b64[0] = c->u.iomem.low_iomem;
+					b64[1] = c->u.iomem.high_iomem;
+					for (j = 0; j < 2; j++)
+						b64[j] = cpu_to_le64(b64[j]);
+					items = put_entry(b64, sizeof(uint64_t), 2, fp);
+					if (items != 2)
+						return POLICYDB_ERROR;
+				} else {
+					buf[0] = c->u.iomem.low_iomem;
+					buf[1] = c->u.iomem.high_iomem;
+					for (j = 0; j < 2; j++)
+						buf[j] = cpu_to_le32(buf[j]);
+					items = put_entry(buf, sizeof(uint32_t), 2, fp);
+					if (items != 2)
+						return POLICYDB_ERROR;
+				}
 				if (context_write(p, &c->context[0], fp))
 					return POLICYDB_ERROR;
 				break;
diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
index b863346..60c493d 100644
--- a/policycoreutils/hll/pp/pp.c
+++ b/policycoreutils/hll/pp/pp.c
@@ -2695,8 +2695,8 @@ static int ocontext_xen_ioport_to_cil(struct policydb *pdb, struct ocontext *iop
 static int ocontext_xen_iomem_to_cil(struct policydb *pdb, struct ocontext *iomems)
 {
 	struct ocontext *iomem;
-	uint32_t low;
-	uint32_t high;
+	uint64_t low;
+	uint64_t high;
 
 	for (iomem = iomems; iomem != NULL; iomem = iomem->next) {
 		low = iomem->u.iomem.low_iomem;
-- 
2.1.0
