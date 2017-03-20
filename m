Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2KFIa8O027563
 for <selinux@tycho.nsa.gov>; Mon, 20 Mar 2017 11:18:36 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/3] libsepol/cil: Allow hexadecimal numbers in Xen context
 rules
Date: Mon, 20 Mar 2017 11:18:57 -0400
Message-Id: <1490023139-12045-2-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1490023139-12045-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1490023139-12045-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Allow the use of hexadecimal numbers in iomemcon, ioportcon, and
pcidevicecon statements. The use of hexadecimal numbers is often
the natural choice for these rules.

A zero base is now passed to strtol() and strtoull() which will
assume base 16 if the string has a prefix of "0x", base 8 if the
string starts with "0", and base 10 otherwise.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/src/cil_build_ast.c | 30 +++++++++++++++---------------
 libsepol/cil/src/cil_build_ast.h |  4 ++--
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index d3d663b..442f100 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -4228,12 +4228,12 @@ int cil_gen_portcon(struct cil_db *db, struct cil_tree_node *parse_current, stru
 	if (parse_current->next->next->cl_head != NULL) {
 		if (parse_current->next->next->cl_head->next != NULL
 		&& parse_current->next->next->cl_head->next->next == NULL) {
-			rc = cil_fill_integer(parse_current->next->next->cl_head, &portcon->port_low);
+			rc = cil_fill_integer(parse_current->next->next->cl_head, &portcon->port_low, 10);
 			if (rc != SEPOL_OK) {
 				cil_log(CIL_ERR, "Improper port specified\n");
 				goto exit;
 			}
-			rc = cil_fill_integer(parse_current->next->next->cl_head->next, &portcon->port_high);
+			rc = cil_fill_integer(parse_current->next->next->cl_head->next, &portcon->port_high, 10);
 			if (rc != SEPOL_OK) {
 				cil_log(CIL_ERR, "Improper port specified\n");
 				goto exit;
@@ -4244,7 +4244,7 @@ int cil_gen_portcon(struct cil_db *db, struct cil_tree_node *parse_current, stru
 			goto exit;
 		}
 	} else {
-		rc = cil_fill_integer(parse_current->next->next, &portcon->port_low);
+		rc = cil_fill_integer(parse_current->next->next, &portcon->port_low, 10);
 		if (rc != SEPOL_OK) {
 			cil_log(CIL_ERR, "Improper port specified\n");
 			goto exit;
@@ -4538,7 +4538,7 @@ int cil_gen_pirqcon(struct cil_db *db, struct cil_tree_node *parse_current, stru
 
 	cil_pirqcon_init(&pirqcon);
 
-	rc = cil_fill_integer(parse_current->next, &pirqcon->pirq);
+	rc = cil_fill_integer(parse_current->next, &pirqcon->pirq, 10);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -4604,12 +4604,12 @@ int cil_gen_iomemcon(struct cil_db *db, struct cil_tree_node *parse_current, str
 	if (parse_current->next->cl_head != NULL) {
 		if (parse_current->next->cl_head->next != NULL &&
 		    parse_current->next->cl_head->next->next == NULL) {
-			rc = cil_fill_integer64(parse_current->next->cl_head, &iomemcon->iomem_low);
+			rc = cil_fill_integer64(parse_current->next->cl_head, &iomemcon->iomem_low, 0);
 			if (rc != SEPOL_OK) {
 				cil_log(CIL_ERR, "Improper iomem specified\n");
 				goto exit;
 			}
-			rc = cil_fill_integer64(parse_current->next->cl_head->next, &iomemcon->iomem_high);
+			rc = cil_fill_integer64(parse_current->next->cl_head->next, &iomemcon->iomem_high, 0);
 			if (rc != SEPOL_OK) {
 				cil_log(CIL_ERR, "Improper iomem specified\n");
 				goto exit;
@@ -4620,7 +4620,7 @@ int cil_gen_iomemcon(struct cil_db *db, struct cil_tree_node *parse_current, str
 			goto exit;
 		}
 	} else {
-		rc = cil_fill_integer64(parse_current->next, &iomemcon->iomem_low);;
+		rc = cil_fill_integer64(parse_current->next, &iomemcon->iomem_low, 0);
 		if (rc != SEPOL_OK) {
 			cil_log(CIL_ERR, "Improper iomem specified\n");
 			goto exit;
@@ -4689,12 +4689,12 @@ int cil_gen_ioportcon(struct cil_db *db, struct cil_tree_node *parse_current, st
 	if (parse_current->next->cl_head != NULL) {
 		if (parse_current->next->cl_head->next != NULL &&
 		    parse_current->next->cl_head->next->next == NULL) {
-			rc = cil_fill_integer(parse_current->next->cl_head, &ioportcon->ioport_low);
+			rc = cil_fill_integer(parse_current->next->cl_head, &ioportcon->ioport_low, 10);
 			if (rc != SEPOL_OK) {
 				cil_log(CIL_ERR, "Improper ioport specified\n");
 				goto exit;
 			}
-			rc = cil_fill_integer(parse_current->next->cl_head->next, &ioportcon->ioport_high);
+			rc = cil_fill_integer(parse_current->next->cl_head->next, &ioportcon->ioport_high, 10);
 			if (rc != SEPOL_OK) {
 				cil_log(CIL_ERR, "Improper ioport specified\n");
 				goto exit;
@@ -4705,7 +4705,7 @@ int cil_gen_ioportcon(struct cil_db *db, struct cil_tree_node *parse_current, st
 			goto exit;
 		}
 	} else {
-		rc = cil_fill_integer(parse_current->next, &ioportcon->ioport_low);
+		rc = cil_fill_integer(parse_current->next, &ioportcon->ioport_low, 10);
 		if (rc != SEPOL_OK) {
 			cil_log(CIL_ERR, "Improper ioport specified\n");
 			goto exit;
@@ -4771,7 +4771,7 @@ int cil_gen_pcidevicecon(struct cil_db *db, struct cil_tree_node *parse_current,
 
 	cil_pcidevicecon_init(&pcidevicecon);
 
-	rc = cil_fill_integer(parse_current->next, &pcidevicecon->dev);
+	rc = cil_fill_integer(parse_current->next, &pcidevicecon->dev, 0);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -5364,7 +5364,7 @@ void cil_destroy_ipaddr(struct cil_ipaddr *ipaddr)
 	free(ipaddr);
 }
 
-int cil_fill_integer(struct cil_tree_node *int_node, uint32_t *integer)
+int cil_fill_integer(struct cil_tree_node *int_node, uint32_t *integer, int base)
 {
 	int rc = SEPOL_ERR;
 	char *endptr = NULL;
@@ -5375,7 +5375,7 @@ int cil_fill_integer(struct cil_tree_node *int_node, uint32_t *integer)
 	}
 
 	errno = 0;
-	val = strtol(int_node->data, &endptr, 10);
+	val = strtol(int_node->data, &endptr, base);
 	if (errno != 0 || endptr == int_node->data || *endptr != '\0') {
 		rc = SEPOL_ERR;
 		goto exit;
@@ -5390,7 +5390,7 @@ exit:
 	return rc;
 }
 
-int cil_fill_integer64(struct cil_tree_node *int_node, uint64_t *integer)
+int cil_fill_integer64(struct cil_tree_node *int_node, uint64_t *integer, int base)
 {
 	int rc = SEPOL_ERR;
 	char *endptr = NULL;
@@ -5401,7 +5401,7 @@ int cil_fill_integer64(struct cil_tree_node *int_node, uint64_t *integer)
 	}
 
 	errno = 0;
-	val = strtoull(int_node->data, &endptr, 10);
+	val = strtoull(int_node->data, &endptr, base);
 	if (errno != 0 || endptr == int_node->data || *endptr != '\0') {
 		rc = SEPOL_ERR;
 		goto exit;
diff --git a/libsepol/cil/src/cil_build_ast.h b/libsepol/cil/src/cil_build_ast.h
index 825029e..5466203 100644
--- a/libsepol/cil/src/cil_build_ast.h
+++ b/libsepol/cil/src/cil_build_ast.h
@@ -221,8 +221,8 @@ void cil_destroy_src_info(struct cil_src_info *info);
 int cil_fill_cats(struct cil_tree_node *curr, struct cil_cats **cats);
 void cil_destroy_cats(struct cil_cats *cats);
 int cil_fill_context(struct cil_tree_node *user_node, struct cil_context *context);
-int cil_fill_integer(struct cil_tree_node *int_node, uint32_t *integer);
-int cil_fill_integer64(struct cil_tree_node *int_node, uint64_t *integer);
+int cil_fill_integer(struct cil_tree_node *int_node, uint32_t *integer, int base);
+int cil_fill_integer64(struct cil_tree_node *int_node, uint64_t *integer, int base);
 int cil_fill_ipaddr(struct cil_tree_node *addr_node, struct cil_ipaddr *addr);
 int cil_fill_level(struct cil_tree_node *sens, struct cil_level *level);
 
-- 
2.7.4
