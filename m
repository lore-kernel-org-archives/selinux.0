Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F89C433E0
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 22:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F5FC64F01
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 22:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhCPWXr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Mar 2021 18:23:47 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:36704 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbhCPWX3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Mar 2021 18:23:29 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id B50C35646AA
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 23:23:26 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/1] libsepol: make num_* unsigned int in module_to_cil
Date:   Tue, 16 Mar 2021 23:23:13 +0100
Message-Id: <20210316222313.19793-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Mar 16 23:23:27 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Using signed integer to represent counts can troube some gcc
optimisation passes, for example in
https://github.com/fishilico/selinux/runs/2125501324?check_suite_focus=true#step:9:107

      In function ‘name_list_to_string’,
          inlined from ‘constraint_expr_to_string’ at module_to_cil.c:1799:11:
      module_to_cil.c:1156:8: error: argument 1 range
      [18446744071562067968, 18446744073709551615] exceeds maximum
      object size 9223372036854775807 [-Werror=alloc-size-larger-than=]
       1156 |  str = malloc(len);
            |        ^~~~~~~~~~~
      In file included from module_to_cil.c:39:
      module_to_cil.c: In function ‘constraint_expr_to_string’:
      /usr/include/stdlib.h:539:14: note: in a call to allocation
      function ‘malloc’ declared here
        539 | extern void *malloc (size_t __size) __THROW __attribute_malloc__
            |              ^~~~~~

The wide range (from 18446744071562067968 = 0xffffffff80000000 to
18446744073709551615 = 0xffffffffffffffff) was caused by num_names being
a signed int used in "len += num_names;", even though it should always
be non-negative.

Prevent such issues from occurring by using "unsigned int" where
appropriate.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/module_to_cil.c | 62 ++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index a87bc15e7610..cb1069caffdf 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -717,9 +717,9 @@ exit:
 	return rc;
 }
 
-static int num_digits(int n)
+static unsigned int num_digits(unsigned int n)
 {
-	int num = 1;
+	unsigned int num = 1;
 	while (n >= 10) {
 		n /= 10;
 		num++;
@@ -945,7 +945,7 @@ static char *search_attr_list(struct list *attr_list, int is_type, void *set)
 	return NULL;
 }
 
-static int set_to_names(struct policydb *pdb, int is_type, void *set, struct list *attr_list, char ***names, int *num_names)
+static int set_to_names(struct policydb *pdb, int is_type, void *set, struct list *attr_list, char ***names, unsigned int *num_names)
 {
 	char *attr_name = NULL;
 	int rc = 0;
@@ -982,12 +982,12 @@ exit:
 	return rc;
 }
 
-static int ebitmap_to_names(struct ebitmap *map, char **vals_to_names, char ***names, int *num_names)
+static int ebitmap_to_names(struct ebitmap *map, char **vals_to_names, char ***names, unsigned int *num_names)
 {
 	int rc = 0;
 	struct ebitmap_node *node;
 	uint32_t i;
-	uint32_t num;
+	unsigned int num;
 	char **name_arr;
 
 	num = 0;
@@ -1026,7 +1026,7 @@ exit:
 	return rc;
 }
 
-static int process_roleset(struct policydb *pdb, struct role_set *rs, struct list *attr_list, char ***names, int *num_names)
+static int process_roleset(struct policydb *pdb, struct role_set *rs, struct list *attr_list, char ***names, unsigned int *num_names)
 {
 	int rc = 0;
 
@@ -1049,7 +1049,7 @@ exit:
 	return rc;
 }
 
-static int process_typeset(struct policydb *pdb, struct type_set *ts, struct list *attr_list, char ***names, int *num_names)
+static int process_typeset(struct policydb *pdb, struct type_set *ts, struct list *attr_list, char ***names, unsigned int *num_names)
 {
 	int rc = 0;
 
@@ -1072,7 +1072,7 @@ exit:
 	return rc;
 }
 
-static void names_destroy(char ***names, int *num_names)
+static void names_destroy(char ***names, unsigned int *num_names)
 {
 	free(*names);
 	*names = NULL;
@@ -1083,7 +1083,7 @@ static int roletype_role_in_ancestor_to_cil(struct policydb *pdb, struct stack *
 {
 	struct list_node *curr;
 	char **tnames = NULL;
-	int num_tnames, i;
+	unsigned int num_tnames, i;
 	struct role_list_node *role_node = NULL;
 	int rc;
 	struct type_set *ts;
@@ -1124,12 +1124,12 @@ exit:
 }
 
 
-static int name_list_to_string(char **names, int num_names, char **string)
+static int name_list_to_string(char **names, unsigned int num_names, char **string)
 {
 	// create a space separated string of the names
 	int rc = -1;
 	size_t len = 0;
-	int i;
+	unsigned int i;
 	char *str;
 	char *strpos;
 
@@ -1184,7 +1184,7 @@ static int avrule_list_to_cil(int indent, struct policydb *pdb, struct avrule *a
 	struct avrule *avrule;
 	char **snames = NULL;
 	char **tnames = NULL;
-	int s, t, num_snames, num_tnames;
+	unsigned int s, t, num_snames, num_tnames;
 	struct type_set *ts;
 
 	for (avrule = avrule_list; avrule != NULL; avrule = avrule->next) {
@@ -1257,7 +1257,7 @@ static int cond_expr_to_cil(int indent, struct policydb *pdb, struct cond_expr *
 	char *new_val = NULL;
 	char *val1 = NULL;
 	char *val2 = NULL;
-	int num_params;
+	unsigned int num_params;
 	const char *op;
 	const char *fmt_str;
 	const char *type;
@@ -1432,11 +1432,11 @@ static int role_trans_to_cil(int indent, struct policydb *pdb, struct role_trans
 	int rc = 0;
 	struct role_trans_rule *rule;
 	char **role_names = NULL;
-	int num_role_names = 0;
-	int role;
+	unsigned int num_role_names = 0;
+	unsigned int role;
 	char **type_names = NULL;
-	int num_type_names = 0;
-	int type;
+	unsigned int num_type_names = 0;
+	unsigned int type;
 	uint32_t i;
 	struct ebitmap_node *node;
 	struct type_set *ts;
@@ -1482,10 +1482,10 @@ static int role_allows_to_cil(int indent, struct policydb *pdb, struct role_allo
 	int rc = -1;
 	struct role_allow_rule *rule;
 	char **roles = NULL;
-	int num_roles = 0;
+	unsigned int num_roles = 0;
 	char **new_roles = NULL;
-	int num_new_roles = 0;
-	int i,j;
+	unsigned int num_new_roles = 0;
+	unsigned int i, j;
 	struct role_set *rs;
 
 	for (rule = rules; rule != NULL; rule = rule->next) {
@@ -1525,11 +1525,11 @@ static int range_trans_to_cil(int indent, struct policydb *pdb, struct range_tra
 	int rc = -1;
 	struct range_trans_rule *rule;
 	char **stypes = NULL;
-	int num_stypes = 0;
-	int stype;
+	unsigned int num_stypes = 0;
+	unsigned int stype;
 	char **ttypes = NULL;
-	int num_ttypes = 0;
-	int ttype;
+	unsigned int num_ttypes = 0;
+	unsigned int ttype;
 	struct ebitmap_node *node;
 	uint32_t i;
 	struct type_set *ts;
@@ -1594,11 +1594,11 @@ static int filename_trans_to_cil(int indent, struct policydb *pdb, struct filena
 {
 	int rc = -1;
 	char **stypes = NULL;
-	int num_stypes = 0;
-	int stype;
+	unsigned int num_stypes = 0;
+	unsigned int stype;
 	char **ttypes = NULL;
-	int num_ttypes = 0;
-	int ttype;
+	unsigned int num_ttypes = 0;
+	unsigned int ttype;
 	struct type_set *ts;
 	struct filename_trans_rule *rule;
 
@@ -1716,7 +1716,7 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
 	const char *attr2;
 	char *names = NULL;
 	char **name_list = NULL;
-	int num_names = 0;
+	unsigned int num_names = 0;
 	struct type_set *ts;
 
 	rc = stack_init(&stack);
@@ -2090,9 +2090,9 @@ static int role_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 	int rc = -1;
 	struct ebitmap_node *node;
 	uint32_t i;
-	int j;
+	unsigned int j;
 	char **types = NULL;
-	int num_types = 0;
+	unsigned int num_types = 0;
 	struct role_datum *role = datum;
 	struct type_set *ts;
 	struct list *attr_list = NULL;
-- 
2.31.0

