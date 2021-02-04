Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF319C433E0
	for <selinux@archiver.kernel.org>; Thu,  4 Feb 2021 22:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925DB64F8C
	for <selinux@archiver.kernel.org>; Thu,  4 Feb 2021 22:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhBDWCV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Feb 2021 17:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhBDWCS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Feb 2021 17:02:18 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353E8C061786
        for <selinux@vger.kernel.org>; Thu,  4 Feb 2021 14:01:38 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id o18so3593299qtp.10
        for <selinux@vger.kernel.org>; Thu, 04 Feb 2021 14:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xwWRsYsf9rQpA127td9FEiB1AepgYvmno5AdQEg46f0=;
        b=OyV+Bf7FHnoai966p/t7AidUTR/QMEbEYgnXdoRzltPNUaB5i/kxDZk6WpbQN7uTlp
         zUCPrx+as2qqzOTapJSwI3/ehpne8hY5lNkij0y1LmpmV3LTf3CKW1JsYhzn1WrSf0Dr
         oyUp8w+p22a2SVeaH2G0i14GAb6TTo/bPky3+fQt4biMUBboxguC1PsFZh9EVsfpNCu2
         lTipuhAN2qU7RGbxSyJv2Fzu5NQifxnxZ/X4rG8ZF93G/SboaSEsJzc6Dkl91LPsEShT
         t9JaQx+fWrRt8w3l5EIsuTGnSkwLe+/bbWJFwaSQy0dB0DJYql/+C4Id7/LtmgJ/A1p+
         wQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xwWRsYsf9rQpA127td9FEiB1AepgYvmno5AdQEg46f0=;
        b=fWjM/S70esAw4tGbOUzRXrHQrXRmq37s8/ukWmiaXVFcG+9lSFmLRo+D/Lgtm5po1c
         nVaPSDDZcXhxbi5yQqUqGC3dpSH4ZOHwayz0m4Hlgp4rY2I4fG7+IyjSLY/htGC3VlG8
         6ln22X0MsiVY9y2yCVWA2K7nBQPT1VKA1uRfprYow5SMrVp05XILYcLULMtL1RwVbDGD
         B9rGdVmQGLlArgHM5vgkWKxq8JqIU9i+YbLC88mQWZbBSyjubCc47TTj/PtVtaIaDJIz
         7qyuQVjKO/tkjXsUsznBb9iu8jOFKaKyJDYd+NsSh0WcM+hoT02k79zB/mwhR0lnMwKy
         Z74g==
X-Gm-Message-State: AOAM533GgwKihKwTYAZ/m0Xz1ysOXgRNubdj98VtpJiOKJal7tc28nRx
        stebyc8THMZJUpJKvvXwFbeytqzeKtk=
X-Google-Smtp-Source: ABdhPJyBR2/fOqll7fqQdjKDRwl/ujpNNBly3g/EhE4YDCgK5R2n+nTzllacUsDQ+lcySdpcBR5pEg==
X-Received: by 2002:ac8:4c90:: with SMTP id j16mr1645114qtv.121.1612476097277;
        Thu, 04 Feb 2021 14:01:37 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id e7sm5800291qto.46.2021.02.04.14.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 14:01:36 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     bill.c.roberts@gmail.com, James Carter <jwcart2@tycho.nsa.gov>,
        Nicolass Iooss <nicolas.iooss@m4x.org>,
        James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Fix integer overflow in the handling of hll line marks
Date:   Thu,  4 Feb 2021 17:01:31 -0500
Message-Id: <20210204220131.229753-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: James Carter <jwcart2@tycho.nsa.gov>

Nicolass Iooss reports:
  OSS-Fuzz found an integer overflow when compiling the following
  (empty) CIL policy:

  ;;*lms 2147483647 a
  ; (empty line)

Change hll_lineno to uint32_t which is the type of the field hll_line
in struct cil_tree_node where the line number will be stored eventually.
Read the line number into an unsigned long variable using strtoul()
instead of strtol(). On systems where ULONG_MAX > UINT32_MAX, set the
value to 0 and print a warning if it is larger than UINT32_MAX before
storing it in hll_lineno.

Also change hll_expand to uint32_t, since its value will be either
0 or 1 and there is no need for it to be signed.

Reported-by: Nicolass Iooss <nicolas.iooss@m4x.org>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_parser.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/libsepol/cil/src/cil_parser.c b/libsepol/cil/src/cil_parser.c
index b62043b9..9d3bd580 100644
--- a/libsepol/cil/src/cil_parser.c
+++ b/libsepol/cil/src/cil_parser.c
@@ -46,11 +46,11 @@ char *CIL_KEY_HLL_LMX;
 char *CIL_KEY_HLL_LME;
 
 struct hll_info {
-	int hll_lineno;
-	int hll_expand;
+	uint32_t hll_lineno;
+	uint32_t hll_expand;
 };
 
-static void push_hll_info(struct cil_stack *stack, int hll_lineno, int hll_expand)
+static void push_hll_info(struct cil_stack *stack, uint32_t hll_lineno, uint32_t hll_expand)
 {
 	struct hll_info *new = cil_malloc(sizeof(*new));
 
@@ -60,7 +60,7 @@ static void push_hll_info(struct cil_stack *stack, int hll_lineno, int hll_expan
 	cil_stack_push(stack, CIL_NONE, new);
 }
 
-static void pop_hll_info(struct cil_stack *stack, int *hll_lineno, int *hll_expand)
+static void pop_hll_info(struct cil_stack *stack, uint32_t *hll_lineno, uint32_t *hll_expand)
 {
 	struct cil_stack_item *curr = cil_stack_pop(stack);
 	struct cil_stack_item *prev = cil_stack_peek(stack);
@@ -69,8 +69,8 @@ static void pop_hll_info(struct cil_stack *stack, int *hll_lineno, int *hll_expa
 	free(curr->data);
 
 	if (!prev) {
-		*hll_lineno = -1;
-		*hll_expand = -1;
+		*hll_lineno = 0;
+		*hll_expand = 0;
 	} else {
 		old = prev->data;
 		*hll_lineno = old->hll_lineno;
@@ -78,7 +78,7 @@ static void pop_hll_info(struct cil_stack *stack, int *hll_lineno, int *hll_expa
 	}
 }
 
-static void create_node(struct cil_tree_node **node, struct cil_tree_node *current, int line, int hll_line, void *value)
+static void create_node(struct cil_tree_node **node, struct cil_tree_node *current, uint32_t line, uint32_t hll_line, void *value)
 {
 	cil_tree_node_init(node);
 	(*node)->parent = current;
@@ -98,13 +98,14 @@ static void insert_node(struct cil_tree_node *node, struct cil_tree_node *curren
 	current->cl_tail = node;
 }
 
-static int add_hll_linemark(struct cil_tree_node **current, int *hll_lineno, int *hll_expand, struct cil_stack *stack, char *path)
+static int add_hll_linemark(struct cil_tree_node **current, uint32_t *hll_lineno, uint32_t *hll_expand, struct cil_stack *stack, char *path)
 {
 	char *hll_type;
 	struct cil_tree_node *node;
 	struct token tok;
 	char *hll_file;
 	char *end = NULL;
+	unsigned long val;
 
 	cil_lexer_next(&tok);
 	hll_type = cil_strpool_add(tok.value);
@@ -140,11 +141,19 @@ static int add_hll_linemark(struct cil_tree_node **current, int *hll_lineno, int
 			cil_log(CIL_ERR, "Invalid line mark syntax\n");
 			goto exit;
 		}
-		*hll_lineno = strtol(tok.value, &end, 10);
+
+		val = strtoul(tok.value, &end, 10);
 		if (errno == ERANGE || *end != '\0') {
 			cil_log(CIL_ERR, "Problem parsing line number for line mark\n");
 			goto exit;
 		}
+#if ULONG_MAX > UINT32_MAX
+		if (val > UINT32_MAX) {
+			cil_log(CIL_WARN, "Line mark line number > UINT32_MAX\n");
+			val = 0;
+		}
+#endif
+		*hll_lineno = val;
 
 		push_hll_info(stack, *hll_lineno, *hll_expand);
 
@@ -206,8 +215,8 @@ int cil_parser(const char *_path, char *buffer, uint32_t size, struct cil_tree *
 	struct cil_tree_node *current = NULL;
 	char *path = cil_strpool_add(_path);
 	struct cil_stack *stack;
-	int hll_lineno = -1;
-	int hll_expand = -1;
+	uint32_t hll_lineno = 0;
+	uint32_t hll_expand = 0;
 	struct token tok;
 	int rc = SEPOL_OK;
 
-- 
2.26.2

