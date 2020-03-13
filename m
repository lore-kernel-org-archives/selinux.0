Return-Path: <SRS0=2KQY=46=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCB2C10DCE
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 13:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829D620749
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 13:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqNdEiTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgCMNmN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:42:13 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42962 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgCMNmN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Mar 2020 09:42:13 -0400
Received: by mail-qt1-f195.google.com with SMTP id g16so7448946qtp.9
        for <selinux@vger.kernel.org>; Fri, 13 Mar 2020 06:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fyYGtTVWus2jx7Z64QOyctK01kkEsDl6Aepi1ra8DTs=;
        b=qqNdEiTgWXPtmyZIgMVIOidKh9sfDkWeDevWEnCTCBi+vG+EBZobNQ5dnXt0curRid
         X/l26zv6JQG1hckYl6VqlVOiYkDRrxgi21t9xexLxlSZnFMYhY75RYB+RY8JuzGQlqUf
         /bcCd4JHxF/Map9bJ7wisk7cviT1U5B/Z2lENmpsPqWTxW6CQwdYHxat9cD4QxG3+alj
         gwZeC2kK/cveKg1OgXWqGwrAX/ycvit4S+sdAGpLwVtDKWH5KgwtcJC2hBEdhTb9fTH/
         g21umgdfzsiQfvlyts5Ej9uSMqDaijh2/zUNW935HRSJKxRAzIyAt2fY+QCfCkKYDOAW
         X51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fyYGtTVWus2jx7Z64QOyctK01kkEsDl6Aepi1ra8DTs=;
        b=XzhVsfAIQkskaimbEyIv0ji19dVgW5UbHrOCXNG6JHNnkASddTjaGGqGckfcsKGMsE
         7bjQfZ0ib3kicaUfBNq+fbfJxTi8T0Gr24Oxryug6tf4jq6jHOrrk8w0+huKmKcnXHMf
         1TzqdN7tDdvAR1oCPrqq4U8OFdxQ/PwrfbJ0TDbnZsSjQ0SRe2zxf/B+41ny2fOhRJgg
         QKlEYdpROAmI8fgwiCK/st+sCM8ZZnAwrcc2NT7azU6mO//3ps26Bil6Z1xQxcqEz5mw
         tK9VWYw6oOQIR9IDkKoaLa26CHdQH4oOjCWX6pUiLOtATMnSyaeJaKVQB1YRX+fcG2Mb
         cfJA==
X-Gm-Message-State: ANhLgQ12tsdtrYos2U+snTd6FX3q+558iEkcRqqjCqg7NiL4zu3vvNi7
        K459/vFCymYWE5nlwiiKiqs=
X-Google-Smtp-Source: ADFU+vt7mC2hIRMcAagCkS1V5HCm+PzRbBbieEv60mUYJuhi3hGAenQedGbQlR1Dl2T4TfDDWxyXZg==
X-Received: by 2002:ac8:6615:: with SMTP id c21mr7130025qtp.191.1584106929023;
        Fri, 13 Mar 2020 06:42:09 -0700 (PDT)
Received: from r21-ubuntu-01.ltsnet.net ([65.127.220.137])
        by smtp.gmail.com with ESMTPSA id g4sm7761266qki.8.2020.03.13.06.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 06:42:08 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH] libsepol,secilc,policycoreutils: add unprivileged sandboxing capability
Date:   Fri, 13 Mar 2020 09:41:50 -0400
Message-Id: <20200313134150.27492-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Stephen Smalley <sds@tycho.nsa.gov>

This patch provides support in the selinux userspace for the
unprivileged sandboxing capability introduced by the previous kernel
patch.  As with that patch, this is a RFC on an early prototype of a
new capability to support unprivileged sandboxing.  See the kernel
patch description for a fuller description of the background, goals,
and approach.

This patch adds libsepol support for sandbox policies including deny
statements and it adds a secilc option for compiling a cil policy into
a binary sandbox file. It also adds a new utility called sebox that
allows a user to load and unload sandbox policies to the kernel.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsepol/cil/include/cil/cil.h             |   1 +
 libsepol/cil/src/cil.c                     |  10 ++
 libsepol/cil/src/cil_binary.c              |   3 +
 libsepol/cil/src/cil_build_ast.c           |   9 +
 libsepol/cil/src/cil_internal.h            |   7 +-
 libsepol/cil/src/cil_tree.c                |   3 +
 libsepol/include/sepol/policydb.h          |  11 ++
 libsepol/include/sepol/policydb/avtab.h    |   4 +-
 libsepol/include/sepol/policydb/policydb.h |   8 +-
 libsepol/src/libsepol.map.in               |   1 +
 libsepol/src/policydb_public.c             |   6 +
 libsepol/src/write.c                       |  95 ++++++++++
 policycoreutils/.gitignore                 |   1 +
 policycoreutils/Makefile                   |   2 +-
 policycoreutils/sebox/Makefile             |  28 +++
 policycoreutils/sebox/sebox.8              |  50 ++++++
 policycoreutils/sebox/sebox.c              | 200 +++++++++++++++++++++
 secilc/secilc.c                            |  33 +++-
 18 files changed, 467 insertions(+), 5 deletions(-)
 create mode 100644 policycoreutils/sebox/Makefile
 create mode 100644 policycoreutils/sebox/sebox.8
 create mode 100644 policycoreutils/sebox/sebox.c

diff --git a/libsepol/cil/include/cil/cil.h b/libsepol/cil/include/cil/cil.h
index f8cfc3be..d75d7401 100644
--- a/libsepol/cil/include/cil/cil.h
+++ b/libsepol/cil/include/cil/cil.h
@@ -59,6 +59,7 @@ extern void cil_set_attrs_expand_generated(struct cil_db *db, int attrs_expand_g
 extern void cil_set_attrs_expand_size(struct cil_db *db, unsigned attrs_expand_size);
 extern void cil_set_target_platform(cil_db_t *db, int target_platform);
 extern void cil_set_policy_version(cil_db_t *db, int policy_version);
+extern void cil_set_sandbox(cil_db_t *db, int sandbox);
 extern void cil_write_policy_conf(FILE *out, struct cil_db *db);
 
 enum cil_log_level {
diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index c010ca2a..353d6413 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -238,6 +238,7 @@ char *CIL_KEY_UNORDERED;
 char *CIL_KEY_SRC_INFO;
 char *CIL_KEY_SRC_CIL;
 char *CIL_KEY_SRC_HLL;
+char *CIL_KEY_SANDBOXDENY;
 
 static void cil_init_keys(void)
 {
@@ -403,6 +404,7 @@ static void cil_init_keys(void)
 	CIL_KEY_SRC_INFO = cil_strpool_add("<src_info>");
 	CIL_KEY_SRC_CIL = cil_strpool_add("<src_cil>");
 	CIL_KEY_SRC_HLL = cil_strpool_add("<src_hll>");
+	CIL_KEY_SANDBOXDENY = cil_strpool_add("deny");
 }
 
 void cil_db_init(struct cil_db **db)
@@ -459,6 +461,7 @@ void cil_db_init(struct cil_db **db)
 	(*db)->mls = -1;
 	(*db)->target_platform = SEPOL_TARGET_SELINUX;
 	(*db)->policy_version = POLICYDB_VERSION_MAX;
+	(*db)->sandbox = 0;
 }
 
 void cil_db_destroy(struct cil_db **db)
@@ -1218,6 +1221,8 @@ const char * cil_node_to_string(struct cil_tree_node *node)
 			return CIL_KEY_DONTAUDIT;
 		case CIL_AVRULE_NEVERALLOW:
 			return CIL_KEY_NEVERALLOW;
+		case CIL_AVRULE_SANDBOXDENY:
+			return CIL_KEY_SANDBOXDENY;
 		default:
 			break;
 		}
@@ -1871,6 +1876,11 @@ void cil_set_policy_version(struct cil_db *db, int policy_version)
 	db->policy_version = policy_version;
 }
 
+void cil_set_sandbox(struct cil_db *db, int sandbox)
+{
+	db->sandbox = sandbox;
+}
+
 void cil_symtab_array_init(symtab_t symtab[], int symtab_sizes[CIL_SYM_NUM])
 {
 	uint32_t i = 0;
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 62178d99..3e8ba8a2 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -1295,6 +1295,9 @@ int __cil_insert_avrule(policydb_t *pdb, uint32_t kind, uint32_t src, uint32_t t
 	case CIL_AVRULE_DONTAUDIT:
 		avtab_key.specified = AVTAB_AUDITDENY;
 		break;
+	case CIL_AVRULE_SANDBOXDENY:
+		avtab_key.specified = AVTAB_SANDBOXDENY;
+		break;
 	default:
 		rc = SEPOL_ERR;
 		goto exit;
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index fcecdc4f..ba56bc80 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -6328,6 +6328,15 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 	} else if (parse_current->data == CIL_KEY_NEVERALLOW) {
 		rc = cil_gen_avrule(parse_current, ast_node, CIL_AVRULE_NEVERALLOW);
 		*finished = CIL_TREE_SKIP_NEXT;
+	} else if (parse_current->data == CIL_KEY_SANDBOXDENY) {
+		if (!db->sandbox) {
+			cil_log(CIL_ERR, "Error: deny statements permitted only in sandbox\n");
+			rc = SEPOL_ERR;
+		} else {
+			rc = cil_gen_avrule(parse_current, ast_node,
+					    CIL_AVRULE_SANDBOXDENY);
+		}
+		*finished = CIL_TREE_SKIP_NEXT;
 	} else if (parse_current->data == CIL_KEY_ALLOWX) {
 		rc = cil_gen_avrulex(parse_current, ast_node, CIL_AVRULE_ALLOWED);
 		*finished = CIL_TREE_SKIP_NEXT;
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index 9bdcbdd0..065be4d5 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -235,6 +235,7 @@ extern char *CIL_KEY_UNORDERED;
 extern char *CIL_KEY_SRC_INFO;
 extern char *CIL_KEY_SRC_CIL;
 extern char *CIL_KEY_SRC_HLL;
+extern char *CIL_KEY_SANDBOXDENY;
 
 /*
 	Symbol Table Array Indices
@@ -321,6 +322,7 @@ struct cil_db {
 	int multiple_decls;
 	int target_platform;
 	int policy_version;
+	int sandbox;
 };
 
 struct cil_root {
@@ -597,7 +599,10 @@ struct cil_tunable {
 #define CIL_AVRULE_AUDITALLOW  2
 #define CIL_AVRULE_DONTAUDIT   8
 #define CIL_AVRULE_NEVERALLOW 128
-#define CIL_AVRULE_AV         (AVRULE_ALLOWED | AVRULE_AUDITALLOW | AVRULE_DONTAUDIT | AVRULE_NEVERALLOW)
+#define CIL_AVRULE_SANDBOXDENY 4096
+#define CIL_AVRULE_AV		(AVRULE_ALLOWED | AVRULE_AUDITALLOW | \
+				 AVRULE_DONTAUDIT | AVRULE_NEVERALLOW | \
+				 AVRULE_SANDBOXDENY)
 struct cil_avrule {
 	int is_extended;
 	uint32_t rule_kind;
diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index b1cbda91..8ed8d686 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -1178,6 +1178,9 @@ void cil_tree_print_node(struct cil_tree_node *node)
 			case CIL_AVRULE_NEVERALLOW:
 				cil_log(CIL_INFO, "NEVERALLOW:");
 				break;
+			case CIL_AVRULE_SANDBOXDENY:
+				cil_log(CIL_INFO, "DENY:");
+				break;
 			}
 
 			if (rule->src != NULL) {
diff --git a/libsepol/include/sepol/policydb.h b/libsepol/include/sepol/policydb.h
index 792913dd..a4d369a3 100644
--- a/libsepol/include/sepol/policydb.h
+++ b/libsepol/include/sepol/policydb.h
@@ -119,6 +119,17 @@ extern int sepol_policydb_read(sepol_policydb_t * p, sepol_policy_file_t * pf);
  */
 extern int sepol_policydb_write(sepol_policydb_t * p, sepol_policy_file_t * pf);
 
+/*
+ * Write a policydb to a sandbox binary file.
+ * The generated image will be in the binary format desgined specifically
+ * for sandboxes.
+ */
+#define SEPOL_SANDBOX_ALLOW 0x00
+#define SEPOL_SANDBOX_DENY 0x01
+extern int sepol_policydb_write_sandbox(sepol_policydb_t *p,
+					sepol_policy_file_t *pf,
+					char *context, int mode);
+
 /*
  * Extract a policydb from a binary policy memory image.  
  * This is equivalent to sepol_policydb_read with a policy file
diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/include/sepol/policydb/avtab.h
index 10ecde9a..0db4f408 100644
--- a/libsepol/include/sepol/policydb/avtab.h
+++ b/libsepol/include/sepol/policydb/avtab.h
@@ -55,7 +55,9 @@ typedef struct avtab_key {
 #define AVTAB_AUDITALLOW	0x0002
 #define AVTAB_AUDITDENY		0x0004
 #define AVTAB_NEVERALLOW	0x0080
-#define AVTAB_AV		(AVTAB_ALLOWED | AVTAB_AUDITALLOW | AVTAB_AUDITDENY)
+#define AVTAB_SANDBOXDENY	0x1000
+#define AVTAB_AV		(AVTAB_ALLOWED | AVTAB_AUDITALLOW | \
+				 AVTAB_AUDITDENY | AVTAB_SANDBOXDENY)
 #define AVTAB_TRANSITION	0x0010
 #define AVTAB_MEMBER		0x0020
 #define AVTAB_CHANGE		0x0040
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 81b63fef..8f97bbcc 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -272,7 +272,10 @@ typedef struct avrule {
 #define AVRULE_AUDITDENY		AVTAB_AUDITDENY
 #define AVRULE_DONTAUDIT		0x0008
 #define AVRULE_NEVERALLOW		AVTAB_NEVERALLOW
-#define AVRULE_AV         (AVRULE_ALLOWED | AVRULE_AUDITALLOW | AVRULE_AUDITDENY | AVRULE_DONTAUDIT | AVRULE_NEVERALLOW)
+#define AVRULE_SANDBOXDENY              AVTAB_SANDBOXDENY
+#define AVRULE_AV			(AVRULE_ALLOWED | AVRULE_AUDITALLOW | \
+					 AVRULE_AUDITDENY | AVRULE_DONTAUDIT | \
+					 AVRULE_NEVERALLOW | AVRULE_SANDBOXDENY)
 #define AVRULE_TRANSITION		AVTAB_TRANSITION
 #define AVRULE_MEMBER			AVTAB_MEMBER
 #define AVRULE_CHANGE			AVTAB_CHANGE
@@ -723,6 +726,9 @@ extern int avrule_read_list(policydb_t * p, avrule_t ** avrules,
 			    struct policy_file *fp);
 
 extern int policydb_write(struct policydb *p, struct policy_file *pf);
+extern int policydb_write_sandbox(struct policydb *p,
+				  struct policy_file *pf,
+				  char *context, int mode);
 extern int policydb_set_target_platform(policydb_t *p, int platform);
 
 #define PERM_SYMTAB_SIZE 32
diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index f4946a79..e4d27d81 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -50,6 +50,7 @@ LIBSEPOL_1.1 {
 	cil_set_attrs_expand_generated;
 	cil_set_attrs_expand_size;
 	cil_set_multiple_decls;
+	cil_set_sandbox;
 	cil_write_policy_conf;
 	sepol_ppfile_to_module_package;
 	sepol_module_package_to_cil;
diff --git a/libsepol/src/policydb_public.c b/libsepol/src/policydb_public.c
index 747a43ff..b25636f9 100644
--- a/libsepol/src/policydb_public.c
+++ b/libsepol/src/policydb_public.c
@@ -184,6 +184,12 @@ int sepol_policydb_write(sepol_policydb_t * p, sepol_policy_file_t * pf)
 	return policydb_write(&p->p, &pf->pf);
 }
 
+int sepol_policydb_write_sandbox(sepol_policydb_t *p, sepol_policy_file_t *pf,
+				 char *context, int mode)
+{
+	return policydb_write_sandbox(&p->p, &pf->pf, context, mode);
+}
+
 int sepol_policydb_from_image(sepol_handle_t * handle,
 			      void *data, size_t len, sepol_policydb_t * p)
 {
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 1fd6a16a..eb97700b 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -2332,3 +2332,98 @@ int policydb_write(policydb_t * p, struct policy_file *fp)
 
 	return POLICYDB_SUCCESS;
 }
+
+int policydb_write_sandbox(policydb_t *p, struct policy_file *fp,
+			   char *context, int mode)
+{
+	uint32_t buf[32], config;
+	size_t items, len;
+	struct policy_data pd;
+
+	if (p->unsupported_format)
+		return POLICYDB_UNSUPPORTED;
+
+	pd.fp = fp;
+	pd.p = p;
+
+	config = 0;
+	if (p->mls) {
+		if ((p->policyvers < POLICYDB_VERSION_MLS &&
+		    p->policy_type == POLICY_KERN) ||
+		    (p->policyvers < MOD_POLICYDB_VERSION_MLS &&
+		    p->policy_type == POLICY_BASE) ||
+		    (p->policyvers < MOD_POLICYDB_VERSION_MLS &&
+		    p->policy_type == POLICY_MOD)) {
+			ERR(fp->handle, "policy version %d cannot support MLS",
+			    p->policyvers);
+			return POLICYDB_ERROR;
+		}
+		config |= POLICYDB_CONFIG_MLS;
+	}
+
+	config |= (POLICYDB_CONFIG_UNKNOWN_MASK & p->handle_unknown);
+
+	/* Write the context length and context */
+	len = strlen(context);
+	buf[0] = cpu_to_le32(len);
+	items = put_entry(buf, sizeof(uint32_t), 1, fp);
+	if (items != 1)
+		return POLICYDB_ERROR;
+	items = put_entry(context, 1, len, fp);
+	if (items != len)
+		return POLICYDB_ERROR;
+
+	/* Write mode */
+	buf[0] = cpu_to_le32(mode);
+	items = put_entry(buf, sizeof(uint32_t), 1, fp);
+	if (items != 1)
+		return POLICYDB_ERROR;
+
+	/* Write out commons */
+	buf[0] = cpu_to_le32(p->symtab[SYM_COMMONS].nprim);
+	buf[1] = p->symtab[SYM_COMMONS].table->nel;
+	buf[1] = cpu_to_le32(buf[1]);
+	items = put_entry(buf, sizeof(uint32_t), 2, fp);
+	if (items != 2)
+		return POLICYDB_ERROR;
+	if (hashtab_map(p->symtab[SYM_COMMONS].table, write_f[SYM_COMMONS], &pd))
+		return POLICYDB_ERROR;
+
+	/* Write out classes */
+	buf[0] = cpu_to_le32(p->symtab[SYM_CLASSES].nprim);
+	buf[1] = p->symtab[SYM_CLASSES].table->nel;
+	buf[1] = cpu_to_le32(buf[1]);
+	items = put_entry(buf, sizeof(uint32_t), 2, fp);
+	if (items != 2)
+		return POLICYDB_ERROR;
+	if (hashtab_map(p->symtab[SYM_CLASSES].table, write_f[SYM_CLASSES], &pd))
+		return POLICYDB_ERROR;
+
+	/* Write out types */
+	buf[0] = cpu_to_le32(p->symtab[SYM_TYPES].nprim);
+	buf[1] = p->symtab[SYM_TYPES].table->nel;
+
+	/*
+	 * A special case when writing type/attribute symbol table.
+	 * The kernel policy version less than 24 does not support
+	 * to load entries of attribute, so we have to re-calculate
+	 * the actual number of types except for attributes.
+	 */
+	if (p->policyvers < POLICYDB_VERSION_BOUNDARY &&
+	    p->policy_type == POLICY_KERN) {
+		hashtab_map(p->symtab[SYM_TYPES].table,
+			    type_attr_uncount, &buf[1]);
+	}
+	buf[1] = cpu_to_le32(buf[1]);
+	items = put_entry(buf, sizeof(uint32_t), 2, fp);
+	if (items != 2)
+		return POLICYDB_ERROR;
+	if (hashtab_map(p->symtab[SYM_TYPES].table, write_f[SYM_TYPES], &pd))
+		return POLICYDB_ERROR;
+
+	/* Write out te rules */
+	if (avtab_write(p, &p->te_avtab, fp))
+		return POLICYDB_ERROR;
+
+	return POLICYDB_SUCCESS;
+}
diff --git a/policycoreutils/.gitignore b/policycoreutils/.gitignore
index 47c9cc52..35963ddf 100644
--- a/policycoreutils/.gitignore
+++ b/policycoreutils/.gitignore
@@ -10,3 +10,4 @@ setfiles/restorecon_xattr
 setfiles/setfiles
 setsebool/setsebool
 hll/pp/pp
+sebox/sebox
diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
index b930b297..e92a6b53 100644
--- a/policycoreutils/Makefile
+++ b/policycoreutils/Makefile
@@ -1,4 +1,4 @@
-SUBDIRS = setfiles load_policy newrole run_init secon sestatus semodule setsebool scripts po man hll
+SUBDIRS = setfiles load_policy newrole run_init secon sestatus semodule setsebool sebox scripts po man hll
 
 all install relabel clean indent:
 	@for subdir in $(SUBDIRS); do \
diff --git a/policycoreutils/sebox/Makefile b/policycoreutils/sebox/Makefile
new file mode 100644
index 00000000..0dd0d540
--- /dev/null
+++ b/policycoreutils/sebox/Makefile
@@ -0,0 +1,28 @@
+# Installation directories.
+PREFIX ?= /usr
+SBINDIR ?= $(PREFIX)/sbin
+MANDIR = $(PREFIX)/share/man
+ETCDIR ?= /etc
+
+CFLAGS ?= -Werror -Wall -W
+override CFLAGS += -D_FILE_OFFSET_BITS=64
+override LDLIBS += -lselinux
+
+all: sebox
+
+sebox: sebox.o
+
+install: all
+	[ -d $(DESTDIR)$(MANDIR)/man8 ] || mkdir -p $(DESTDIR)$(MANDIR)/man8
+	-mkdir -p $(DESTDIR)$(SBINDIR)
+	install -m 755 sebox $(DESTDIR)$(SBINDIR)
+	install -m 644 sebox.8 $(DESTDIR)$(MANDIR)/man8
+	-mkdir -p $(DESTDIR)$(ETCDIR)
+
+clean:
+	rm -f sebox *.o
+
+indent:
+	../../scripts/Lindent $(wildcard *.[ch])
+
+relabel:
diff --git a/policycoreutils/sebox/sebox.8 b/policycoreutils/sebox/sebox.8
new file mode 100644
index 00000000..32d73cbc
--- /dev/null
+++ b/policycoreutils/sebox/sebox.8
@@ -0,0 +1,50 @@
+.TH "sebox" "8" "01 Mar 2019" "Security Enhanced Linux" "SELinux command line documentation"
+.SH "NAME"
+sebox \- SELinux sandbox tool
+
+.SH "SYNOPSIS"
+.B sebox
+.I \-l FILE
+.br
+.B sebox
+.I \-u FILE
+.br
+.B sebox
+.I \-L
+
+.SH "DESCRIPTION"
+.sp
+This tool is used to load and unload sandbox policy files into a running SELinux system.
+.RS
+.SH "OPTIONS"
+.B \-l, --load=FILE
+.RS
+Load sandbox policy
+.RE
+.sp
+.B \-u, --unload=FILE
+.RS
+Unload sandbox policy
+.RE
+.sp
+.B \-L, --list
+.RS
+List sandbox policies
+.RE
+.sp
+.B \-v, --verbose
+.RS
+Verbose output
+.RE
+.sp
+.B \-h, --help
+.RS
+Help
+.RE
+.SH "AUTHOR"
+This man page was written by ......
+.br
+The program was written by .......
+
+.SH "SEE ALSO"
+.BR selinux "(8), " sestatus.conf "(5)
diff --git a/policycoreutils/sebox/sebox.c b/policycoreutils/sebox/sebox.c
new file mode 100644
index 00000000..13331d8d
--- /dev/null
+++ b/policycoreutils/sebox/sebox.c
@@ -0,0 +1,200 @@
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/stat.h>
+#include <getopt.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <selinux/selinux.h>
+
+#define MODE_LOAD 1
+#define MODE_UNLOAD 2
+#define MODE_LIST 3
+
+#define SELINUXFS_SANDBOX_LOAD "/sys/fs/selinux/sandbox/sandbox_load"
+#define SELINUXFS_SANDBOX_UNLOAD "/sys/fs/selinux/sandbox/sandbox_unload"
+
+extern char *selinux_mnt;
+
+static __attribute__((__noreturn__)) void usage(const char *prog)
+{
+	printf("Usage: %s [OPTIONS]...\n", prog);
+	printf("  %s --load FILE\n", prog);
+	printf("  %s --unload FILE\n", prog);
+	printf("  %s --list\n", prog);
+	printf("\n");
+	printf("Options\n");
+	printf("  -l, --load=<file>              load sandbox policy\n");
+	printf("  -u, --unload=<file>            unload sandbox policy\n");
+	printf("  -L, --list                     list installed sandboxes\n");
+	printf("  -v  --verbose                  verbose\n");
+	printf("  -h, --help                     display usage information\n");
+	exit(1);
+}
+
+int main(int argc, char **argv)
+{
+	int opt = 0;
+	int opt_index = 0;
+	int verbose = 0;
+	int mode = 0;
+	char *filepath = NULL;
+	FILE *file = NULL;
+	struct stat filedata;
+	ssize_t datalen = 0;
+	char *data = NULL;
+	int fd = -1;
+	ssize_t written = 0;
+	static struct option long_opts[] = {
+		{"help", no_argument, 0, 'h'},
+		{"verbose", no_argument, 0, 'v'},
+		{"load", required_argument, 0, 'l'},
+		{"unload", required_argument, 0, 'u'},
+		{"list", no_argument, 0, 'L'},
+		{0, 0, 0, 0}
+	};
+	int rc = 0;
+
+	while (1) {
+
+		opt = getopt_long(argc, argv, "hvl:u:L", long_opts, &opt_index);
+
+		if (opt == -1)
+			break;
+
+		switch (opt) {
+		case 'v':
+			verbose = 1;
+			break;
+		case 'l':
+			if (mode) {
+				fprintf(stderr, "Only one action at a time!\n");
+				usage(argv[0]);
+			}
+			mode = MODE_LOAD;
+			filepath = strdup(optarg);
+			break;
+		case 'u':
+			if (mode) {
+				fprintf(stderr, "Only one action at a time!\n");
+				usage(argv[0]);
+			}
+			mode = MODE_UNLOAD;
+			filepath = strdup(optarg);
+			break;
+		case 'L':
+			if (mode) {
+				fprintf(stderr, "Only one action at a time!\n");
+				usage(argv[0]);
+			}
+			mode = MODE_LIST;
+			break;
+		case 'h':
+			usage(argv[0]);
+			break;
+		default:
+			fprintf(stderr, "Unsupported option %s\n", optarg);
+			usage(argv[0]);
+		}
+
+	}
+
+	if (!mode) {
+		printf("Please specify an action (load/unload/list)\n");
+		return -1;
+	}
+
+	/* make sure selinux is enabled */
+	rc = is_selinux_enabled();
+	if (rc != 1) {
+		printf("SELinux is not enabled\n");
+		printf("Please enable selinux to use sandboxing\n");
+		return -1;
+	}
+
+	/* confirm selinuxfs is mounted */
+	if (selinux_mnt == NULL) {
+		printf("SELinuxfs not mounted\n");
+		printf("Please mount selinuxfs for proper results\n");
+		return -1;
+	}
+
+	/* MODE_LIST doesn't require any input files, handle it first */
+	if (mode == MODE_LIST) {
+		printf("under construction\n");
+		return 0;
+	}
+
+	/* read in file data */
+	file = fopen(filepath, "r");
+	if (!file) {
+		fprintf(stderr, "Could not open file: %s\n", filepath);
+		return -1;
+	}
+
+	rc = stat(filepath, &filedata);
+	if (rc == -1) {
+		fprintf(stderr, "Could not stat file: %s\n", filepath);
+		rc = -1;
+		goto exit;
+	}
+	datalen = filedata.st_size;
+
+	data = malloc(datalen);
+	rc = fread(data, datalen, 1, file);
+	if (rc != 1) {
+		fprintf(stderr, "Failure reading file: %s\n", filepath);
+		rc = -1;
+		goto exit;
+	}
+	fclose(file);
+	file = NULL;
+
+	/* open selinux fs node for writing */
+	if (mode == MODE_LOAD) {
+
+		fd = open(SELINUXFS_SANDBOX_LOAD, O_WRONLY);
+		if (fd < 0) {
+			fprintf(stderr, "Could not open selinuxfs node: %s\n",
+				SELINUXFS_SANDBOX_LOAD);
+			rc = -1;
+			goto exit;
+		}
+
+	} else {
+
+		fd = open(SELINUXFS_SANDBOX_UNLOAD, O_WRONLY);
+		if (fd < 0) {
+			fprintf(stderr, "Could not open selinuxfs node: %s\n",
+				SELINUXFS_SANDBOX_UNLOAD);
+			rc = -1;
+			goto exit;
+		}
+
+	}
+
+	written = write(fd, data, datalen);
+	if (written != datalen) {
+		fprintf(stderr, "Failure writing to selinuxfs node: %s\n",
+			SELINUXFS_SANDBOX_LOAD);
+		rc = -1;
+		goto exit;
+	}
+	close(fd);
+	fd = -1;
+
+	if (verbose)
+		printf("done\n");
+
+	rc = 0;
+
+exit:
+	if (file)
+		fclose(file);
+	if (fd)
+		close(fd);
+	free(data);
+	return rc;
+}
diff --git a/secilc/secilc.c b/secilc/secilc.c
index 186c5a73..b22d93d7 100644
--- a/secilc/secilc.c
+++ b/secilc/secilc.c
@@ -69,6 +69,9 @@ static __attribute__((__noreturn__)) void usage(const char *prog)
 	printf("  -X, --expand-size <SIZE>       Expand type attributes with fewer than <SIZE>\n");
 	printf("                                 members.\n");
 	printf("  -O, --optimize                 optimize final policy\n");
+	printf("  -s, --sandbox=<context>        write a binary sandbox policy file\n");
+	printf("  -a, --sandbox-allow            set sandbox policy in allow mode\n");
+	printf("  -d, --sandbox-deny             set sandbox policy in deny mode (default)\n");
 	printf("  -v, --verbose                  increment verbosity level\n");
 	printf("  -h, --help                     display usage information\n");
 	exit(1);
@@ -86,6 +89,7 @@ int main(int argc, char *argv[])
 	struct stat filedata;
 	uint32_t file_size;
 	char *output = NULL;
+	char *sandbox_context = NULL;
 	char *filecontexts = NULL;
 	struct cil_db *db = NULL;
 	int target = SEPOL_TARGET_SELINUX;
@@ -101,6 +105,8 @@ int main(int argc, char *argv[])
 	int optimize = 0;
 	int opt_char;
 	int opt_index = 0;
+	int sandbox = 0;
+	int sandbox_mode = SEPOL_SANDBOX_DENY;
 	char *fc_buf = NULL;
 	size_t fc_size;
 	enum cil_log_level log_level = CIL_ERR;
@@ -120,12 +126,15 @@ int main(int argc, char *argv[])
 		{"expand-generated", no_argument, 0, 'G'},
 		{"expand-size", required_argument, 0, 'X'},
 		{"optimize", no_argument, 0, 'O'},
+		{"sandbox", required_argument, 0, 's'},
+		{"sandbox-allow", no_argument, 0, 'a'},
+		{"sandbox-deny", no_argument, 0, 'd'},
 		{0, 0, 0, 0}
 	};
 	int i;
 
 	while (1) {
-		opt_char = getopt_long(argc, argv, "o:f:U:hvt:M:PDmNOc:GX:n", long_opts, &opt_index);
+		opt_char = getopt_long(argc, argv, "o:f:U:hvt:M:PDmNOc:GX:s:n", long_opts, &opt_index);
 		if (opt_char == -1) {
 			break;
 		}
@@ -217,6 +226,16 @@ int main(int argc, char *argv[])
 			case 'O':
 				optimize = 1;
 				break;
+			case 's':
+				sandbox_context = strdup(optarg);
+				sandbox = 1;
+				break;
+			case 'a':
+				sandbox_mode = SEPOL_SANDBOX_ALLOW;
+				break;
+			case 'd':
+				sandbox_mode = SEPOL_SANDBOX_DENY;
+				break;
 			case 'h':
 				usage(argv[0]);
 			case '?':
@@ -252,6 +271,7 @@ int main(int argc, char *argv[])
 	if (attrs_expand_size >= 0) {
 		cil_set_attrs_expand_size(db, (unsigned)attrs_expand_size);
 	}
+	cil_set_sandbox(db, sandbox);
 
 	for (i = optind; i < argc; i++) {
 		file = fopen(argv[i], "r");
@@ -338,6 +358,17 @@ int main(int argc, char *argv[])
 
 	sepol_policy_file_set_fp(pf, binary);
 
+	if (sandbox) {
+		rc = sepol_policydb_write_sandbox(pdb, pf, sandbox_context,
+						  sandbox_mode);
+		if (rc != 0) {
+			fprintf(stderr,
+				"Failed to write binary sandbox policy :%d\n",
+				rc);
+		}
+		goto exit;
+	}
+
 	rc = sepol_policydb_write(pdb, pf);
 	if (rc != 0) {
 		fprintf(stderr, "Failed to write binary policy: %d\n", rc);
-- 
2.17.1

