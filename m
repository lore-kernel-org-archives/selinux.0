Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE52C4743E
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 16:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B68B760FEA
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 16:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhFHQCa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:02:30 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:42691 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbhFHQC2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Jun 2021 12:02:28 -0400
Received: by mail-ej1-f48.google.com with SMTP id k25so27948940eja.9
        for <selinux@vger.kernel.org>; Tue, 08 Jun 2021 09:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aAZjW58Wsgpjs3ntxspU4uWrr852AOQHgRC4H8b0Gxo=;
        b=BtbqOVY++aanhi9crUnDnQyqYJvz00xGDpeuVXIypDBLBMb+qlx6WZ1JP7RM1LkUnz
         49ixWnW/pph32i/X+1azquGAt61ZFMcowpkIXFM14jZ1Yc9EWCc4qLpBMJUDIyco61pL
         MU8cpmQyfV2OLYjY69dbM8TR+SZC5lnZSL79T6fPRJhvU8h8/EZlessyUXKrfTG4Wu5i
         07EqAawaH2fWtRKTZHT3Bysk1nsEe2lY9Xm0VR3Qye2icJDp50bI1VyQJFwLrlbxtJ8T
         aFvaoMyvbjHUFYi1EjsZChUfFLAyDDq2v7ETJQLw3nKoNts0oCYsgIqO/stwOMqCv4hd
         Nrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aAZjW58Wsgpjs3ntxspU4uWrr852AOQHgRC4H8b0Gxo=;
        b=Olj2kuGCs2zuUFOAyX93NbgrRXu01gyOLvoNcTr2Cmnlvapd50P6bgsBsg52WYflF1
         +31w2GbLSxmo9jq3Vs0ne9Uz2uI7Rmy/P8CQEolOZM+ogZnXhWwD/TVZmqjfhvFVVVdj
         xOJSwnZ5tDb9aD74ltVELNMxrAtLM3QslWjqh09tIBkACuBJIiJJuuY9+NZx2IIY+kvr
         yyC3SMz1kTUVV1GVmioLE/y6eZBD+ImocuxjgOnncr8RZHTCvRwMZ0OEcNy5dqndUY/x
         0RT7U35h4kzgOZDhtdKVETKAoYONHhK0zQfFUa62GyoDXaPYUq4ugAKI+Hg3vXDoHGoQ
         PE3Q==
X-Gm-Message-State: AOAM530/AUwlyaO1zm18/1I6fPOu+xhGIUvmsBjxlbiON2cN0UHDaKa1
        +wqKf9EqqCw7kMAdTeKVqStrVM2B7oY=
X-Google-Smtp-Source: ABdhPJwOJs7sAsnS5/YgNrq034mJlq3bxFIPeEz+b8m0eZrTDVdQpIQZ7Ar6ojl2/AU+yOm9B3Jizg==
X-Received: by 2002:a17:906:b19:: with SMTP id u25mr23772384ejg.238.1623167963254;
        Tue, 08 Jun 2021 08:59:23 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-183-231.95.112.pool.telefonica.de. [95.112.183.231])
        by smtp.gmail.com with ESMTPSA id n13sm51134ejk.97.2021.06.08.08.59.22
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:59:22 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 07/23] libsepol: follow declaration-after-statement
Date:   Tue,  8 Jun 2021 17:58:56 +0200
Message-Id: <20210608155912.32047-8-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608155912.32047-1-cgzones@googlemail.com>
References: <20210608155912.32047-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Follow the project style of no declaration after statement.

Found by the gcc warning -Wdeclaration-after-statement

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/booleans.c      |  6 ++--
 libsepol/src/debug.c         |  2 +-
 libsepol/src/ebitmap.c       | 11 ++++---
 libsepol/src/module_to_cil.c | 10 +++---
 libsepol/src/nodes.c         |  6 ++--
 libsepol/src/services.c      | 59 ++++++++++++++++++------------------
 libsepol/src/util.c          |  2 +-
 7 files changed, 50 insertions(+), 46 deletions(-)

diff --git a/libsepol/src/booleans.c b/libsepol/src/booleans.c
index 30fcf29d..716da6b4 100644
--- a/libsepol/src/booleans.c
+++ b/libsepol/src/booleans.c
@@ -19,6 +19,7 @@ static int bool_update(sepol_handle_t * handle,
 	const char *cname;
 	char *name;
 	int value;
+	cond_bool_datum_t *datum;
 
 	sepol_bool_key_unpack(key, &cname);
 	name = strdup(cname);
@@ -27,8 +28,7 @@ static int bool_update(sepol_handle_t * handle,
 	if (!name)
 		goto omem;
 
-	cond_bool_datum_t *datum =
-	    hashtab_search(policydb->p_bools.table, name);
+	datum = hashtab_search(policydb->p_bools.table, name);
 	if (!datum) {
 		ERR(handle, "boolean %s no longer in policy", name);
 		goto err;
@@ -84,10 +84,10 @@ int sepol_bool_set(sepol_handle_t * handle,
 		   const sepol_bool_key_t * key, const sepol_bool_t * data)
 {
 
+	policydb_t *policydb = &p->p;
 	const char *name;
 	sepol_bool_key_unpack(key, &name);
 
-	policydb_t *policydb = &p->p;
 	if (bool_update(handle, policydb, key, data) < 0)
 		goto err;
 
diff --git a/libsepol/src/debug.c b/libsepol/src/debug.c
index 0458e353..f6a59ae7 100644
--- a/libsepol/src/debug.c
+++ b/libsepol/src/debug.c
@@ -44,6 +44,7 @@ void sepol_msg_default_handler(void *varg __attribute__ ((unused)),
 {
 
 	FILE *stream = NULL;
+	va_list ap;
 
 	switch (sepol_msg_get_level(handle)) {
 
@@ -60,7 +61,6 @@ void sepol_msg_default_handler(void *varg __attribute__ ((unused)),
 	fprintf(stream, "%s.%s: ",
 		sepol_msg_get_channel(handle), sepol_msg_get_fname(handle));
 
-	va_list ap;
 	va_start(ap, fmt);
 	vfprintf(stream, fmt, ap);
 	va_end(ap);
diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
index 7f425349..522e14a6 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -113,9 +113,10 @@ int ebitmap_not(ebitmap_t *dst, ebitmap_t *e1, unsigned int maxbit)
 
 int ebitmap_andnot(ebitmap_t *dst, ebitmap_t *e1, ebitmap_t *e2, unsigned int maxbit)
 {
+	int rc;
 	ebitmap_t e3;
 	ebitmap_init(dst);
-	int rc = ebitmap_not(&e3, e2, maxbit);
+	rc = ebitmap_not(&e3, e2, maxbit);
 	if (rc < 0)
 		return rc;
 	rc = ebitmap_and(dst, e1, &e3);
@@ -138,13 +139,15 @@ unsigned int ebitmap_cardinality(ebitmap_t *e1)
 
 int ebitmap_hamming_distance(ebitmap_t * e1, ebitmap_t * e2)
 {
+	int rc;
+	ebitmap_t tmp;
+	int distance;
 	if (ebitmap_cmp(e1, e2))
 		return 0;
-	ebitmap_t tmp;
-	int rc = ebitmap_xor(&tmp, e1, e2);
+	rc = ebitmap_xor(&tmp, e1, e2);
 	if (rc < 0)
 		return -1;
-	int distance = ebitmap_cardinality(&tmp);
+	distance = ebitmap_cardinality(&tmp);
 	ebitmap_destroy(&tmp);
 	return distance;
 }
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 41605eb8..73ec7971 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -107,8 +107,8 @@ static void cil_printf(const char *fmt, ...) {
 __attribute__ ((format(printf, 2, 3)))
 static void cil_println(int indent, const char *fmt, ...)
 {
-	cil_indent(indent);
 	va_list argptr;
+	cil_indent(indent);
 	va_start(argptr, fmt);
 	if (vfprintf(out_file, fmt, argptr) < 0) {
 		log_err("Failed to write to output");
@@ -235,12 +235,14 @@ static void role_list_destroy(void)
 
 static void attr_list_destroy(struct list **attr_list)
 {
+	struct list_node *curr;
+	struct attr_list_node *attr;
+
 	if (attr_list == NULL || *attr_list == NULL) {
 		return;
 	}
 
-	struct list_node *curr = (*attr_list)->head;
-	struct attr_list_node *attr;
+	curr = (*attr_list)->head;
 
 	while (curr != NULL) {
 		attr = curr->data;
@@ -3525,12 +3527,12 @@ exit:
 static int additive_scopes_to_cil(int indent, struct policydb *pdb, struct avrule_block *block, struct stack *decl_stack)
 {
 	int rc = -1;
+	struct avrule_decl *decl = stack_peek(decl_stack);
 	struct map_args args;
 	args.pdb = pdb;
 	args.block = block;
 	args.decl_stack = decl_stack;
 	args.indent = indent;
-	struct avrule_decl *decl = stack_peek(decl_stack);
 
 	for (args.sym_index = 0; args.sym_index < SYM_NUM; args.sym_index++) {
 		if (func_to_cil[args.sym_index] == NULL) {
diff --git a/libsepol/src/nodes.c b/libsepol/src/nodes.c
index 820346d0..97a0f959 100644
--- a/libsepol/src/nodes.c
+++ b/libsepol/src/nodes.c
@@ -19,20 +19,20 @@ static int node_from_record(sepol_handle_t * handle,
 	ocontext_t *tmp_node = NULL;
 	context_struct_t *tmp_con = NULL;
 	char *addr_buf = NULL, *mask_buf = NULL;
+	size_t addr_bsize, mask_bsize;
+	int proto;
 
 	tmp_node = (ocontext_t *) calloc(1, sizeof(ocontext_t));
 	if (!tmp_node)
 		goto omem;
 
-	size_t addr_bsize, mask_bsize;
-
 	/* Address and netmask */
 	if (sepol_node_get_addr_bytes(handle, data, &addr_buf, &addr_bsize) < 0)
 		goto err;
 	if (sepol_node_get_mask_bytes(handle, data, &mask_buf, &mask_bsize) < 0)
 		goto err;
 
-	int proto = sepol_node_get_proto(data);
+	proto = sepol_node_get_proto(data);
 
 	switch (proto) {
 	case SEPOL_PROTO_IP4:
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index ff91f7d2..d647c8f5 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -290,6 +290,19 @@ static char *get_class_info(sepol_security_class_t tclass,
 {
 	constraint_expr_t *e;
 	int mls, state_num;
+	/* Determine statement type */
+	const char *statements[] = {
+		"constrain ",			/* 0 */
+		"mlsconstrain ",		/* 1 */
+		"validatetrans ",		/* 2 */
+		"mlsvalidatetrans ",	/* 3 */
+		0 };
+	size_t class_buf_len = 0;
+	size_t new_class_buf_len;
+	size_t buf_used;
+	int len;
+	char *class_buf = NULL, *p;
+	char *new_class_buf = NULL;
 
 	/* Find if MLS statement or not */
 	mls = 0;
@@ -300,26 +313,11 @@ static char *get_class_info(sepol_security_class_t tclass,
 		}
 	}
 
-	/* Determine statement type */
-	const char *statements[] = {
-		"constrain ",			/* 0 */
-		"mlsconstrain ",		/* 1 */
-		"validatetrans ",		/* 2 */
-		"mlsvalidatetrans ",	/* 3 */
-		0 };
-
 	if (xcontext == NULL)
 		state_num = mls + 0;
 	else
 		state_num = mls + 2;
 
-	size_t class_buf_len = 0;
-	size_t new_class_buf_len;
-	size_t buf_used;
-	int len;
-	char *class_buf = NULL, *p;
-	char *new_class_buf = NULL;
-
 	while (1) {
 		new_class_buf_len = class_buf_len + EXPR_BUF_SIZE;
 		new_class_buf = realloc(class_buf, new_class_buf_len);
@@ -417,6 +415,8 @@ static int constraint_expr_eval_reason(context_struct_t *scontext,
 	char *tgt = NULL;
 	int rc = 0, x;
 	char *class_buf = NULL;
+	int expr_list_len = 0;
+	int expr_count;
 
 	/*
 	 * The array of expression answer buffer pointers and counter.
@@ -424,6 +424,11 @@ static int constraint_expr_eval_reason(context_struct_t *scontext,
 	char **answer_list = NULL;
 	int answer_counter = 0;
 
+	/* The pop operands */
+	char *a;
+	char *b;
+	int a_len, b_len;
+
 	class_buf = get_class_info(tclass, constraint, xcontext);
 	if (!class_buf) {
 		ERR(NULL, "failed to allocate class buffer");
@@ -431,7 +436,6 @@ static int constraint_expr_eval_reason(context_struct_t *scontext,
 	}
 
 	/* Original function but with buffer support */
-	int expr_list_len = 0;
 	expr_counter = 0;
 	expr_list = NULL;
 	for (e = constraint->expr; e; e = e->next) {
@@ -701,7 +705,7 @@ mls_ops:
 	 * expr_list malloc's. Normally they are released by the RPN to
 	 * infix code.
 	 */
-	int expr_count = expr_counter;
+	expr_count = expr_counter;
 	expr_counter = 0;
 
 	/*
@@ -715,11 +719,6 @@ mls_ops:
 		goto out;
 	}
 
-	/* The pop operands */
-	char *a;
-	char *b;
-	int a_len, b_len;
-
 	/* Convert constraint from RPN to infix notation. */
 	for (x = 0; x != expr_count; x++) {
 		if (strncmp(expr_list[x], "and", 3) == 0 || strncmp(expr_list[x],
@@ -778,14 +777,6 @@ mls_ops:
 			xcontext ? "Validatetrans" : "Constraint",
 			s[0] ? "GRANTED" : "DENIED");
 
-	int len, new_buf_len;
-	char *p, **new_buf = r_buf;
-	/*
-	 * These contain the constraint components that are added to the
-	 * callers reason buffer.
-	 */
-	const char *buffers[] = { class_buf, a, "); ", tmp_buf, 0 };
-
 	/*
 	 * This will add the constraints to the callers reason buffer (who is
 	 * responsible for freeing the memory). It will handle any realloc's
@@ -796,6 +787,14 @@ mls_ops:
 
 	if (r_buf && ((s[0] == 0) || ((s[0] == 1 &&
 				(flags & SHOW_GRANTED) == SHOW_GRANTED)))) {
+		int len, new_buf_len;
+		char *p, **new_buf = r_buf;
+		/*
+		* These contain the constraint components that are added to the
+		* callers reason buffer.
+		*/
+		const char *buffers[] = { class_buf, a, "); ", tmp_buf, 0 };
+
 		for (x = 0; buffers[x] != NULL; x++) {
 			while (1) {
 				p = *r_buf + reason_buf_used;
diff --git a/libsepol/src/util.c b/libsepol/src/util.c
index d51750af..a47cae87 100644
--- a/libsepol/src/util.c
+++ b/libsepol/src/util.c
@@ -129,9 +129,9 @@ char *sepol_extended_perms_to_string(avtab_extended_perms_t *xperms)
 	unsigned int bit;
 	unsigned int in_range = 0;
 	static char xpermsbuf[2048];
-	xpermsbuf[0] = '\0';
 	char *p;
 	int len, xpermslen = 0;
+	xpermsbuf[0] = '\0';
 	p = xpermsbuf;
 
 	if ((xperms->specified != AVTAB_XPERMS_IOCTLFUNCTION)
-- 
2.32.0

