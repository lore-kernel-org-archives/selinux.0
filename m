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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D61C433E0
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 22:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25BB564FB4
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 22:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbhBEWNH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbhBEOkc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Feb 2021 09:40:32 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D26C06178B
        for <selinux@vger.kernel.org>; Fri,  5 Feb 2021 08:18:31 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id l23so5304948qtq.13
        for <selinux@vger.kernel.org>; Fri, 05 Feb 2021 08:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tgF+0aCMfMp43Tu02MwEVJOSMscik+ZbDNYs5ATuRlc=;
        b=t+pquyAss4k5LQHzXZSUlevomE5njDkfmc8KUK1m9jmx1X2zHaa4b0y1ieMzanPOfO
         Z/DORW1wmMibaaHsbdeLz8QChjXMJddAzU1iKQaovUiJCQL0NIsul69JYMVg02JlYtRv
         DJJhhAHPa8kH+8DO3o6T4IuZfDPgZLM3tAA/baYViKxRNLx/gvawQZAvHxjXz1LFyIio
         Q0IL4zAUWQsR2O2rC2dr2zvsPFnCsNl1byoXIhR2g0kYOu/LahSBkEAGBCJ/Kfg1Xvpq
         B4RKIfK+TfdbUOrktxHuuiSvJjW4GdVpmNpHW4QxAUJpIoSHGQM/yAiomkAVabn85w6o
         EBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tgF+0aCMfMp43Tu02MwEVJOSMscik+ZbDNYs5ATuRlc=;
        b=Ss/pPYuIXwuqdtM762SgvcJe2bD8YIAQooXYe8/DXGliK437vZpPBjUUm7hSUV8yLC
         uci8ETqEWOG5u36f4FdBNUq0b6l2cjYsxm+hWLW43YRdyex2TWlf9R9SdwIrs9ULlPXr
         9GSztPf5pTu6CGpTXVEDnyQIV/Y5NK/rrQNRVjOlX1819VeKkilioYcGmOrsKCvOpIn8
         AcciZJXVNJVADN5OZ2NVGdAIFll8WE1k8/Ez2Fj4DY+hKQRNXqNFtN4IRz3x7BBCmmFv
         /eElQRqhFKyaBvGUMriuTpydR9saG3nrmqlpJiCrND1fCjUcv6iCtPJdqxoDMI7RvXL7
         u5lg==
X-Gm-Message-State: AOAM531yDdxFw93RUPWU02O9buD3DlQWiFplbNti6xEro9TznBa40m8m
        RVhVHRQ1a73khl1cb6p15JpXncutPWulLA==
X-Google-Smtp-Source: ABdhPJyJz+mKy4BfTHyt2EhW4VoG99kju6xcIOMHZWhJ7XXvoTCYB4Wg10kifgrZEMvQURvufjCr5w==
X-Received: by 2002:ac8:1403:: with SMTP id k3mr4582502qtj.266.1612536267466;
        Fri, 05 Feb 2021 06:44:27 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id l24sm1017798qtr.16.2021.02.05.06.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:44:26 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@tycho.nsa.gov>,
        Nicolass Iooss <nicolas.iooss@m4x.org>,
        James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Fix integer overflow in the handling of hll line marks
Date:   Fri,  5 Feb 2021 09:44:21 -0500
Message-Id: <20210205144421.279511-1-jwcart2@gmail.com>
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
instead of strtol(). On systems where ULONG_MAX > UINT32_MAX, return
an error if the value is larger than UINT32_MAX.

Also change hll_expand to uint32_t, since its value will be either
0 or 1 and there is no need for it to be signed.

Reported-by: Nicolass Iooss <nicolas.iooss@m4x.org>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_parser.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/libsepol/cil/src/cil_parser.c b/libsepol/cil/src/cil_parser.c
index 0038eed6..a9306218 100644
--- a/libsepol/cil/src/cil_parser.c
+++ b/libsepol/cil/src/cil_parser.c
@@ -47,11 +47,11 @@ char *CIL_KEY_HLL_LMX;
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
 
@@ -61,7 +61,7 @@ static void push_hll_info(struct cil_stack *stack, int hll_lineno, int hll_expan
 	cil_stack_push(stack, CIL_NONE, new);
 }
 
-static void pop_hll_info(struct cil_stack *stack, int *hll_lineno, int *hll_expand)
+static void pop_hll_info(struct cil_stack *stack, uint32_t *hll_lineno, uint32_t *hll_expand)
 {
 	struct cil_stack_item *curr = cil_stack_pop(stack);
 	struct cil_stack_item *prev = cil_stack_peek(stack);
@@ -70,8 +70,8 @@ static void pop_hll_info(struct cil_stack *stack, int *hll_lineno, int *hll_expa
 	free(curr->data);
 
 	if (!prev) {
-		*hll_lineno = -1;
-		*hll_expand = -1;
+		*hll_lineno = 0;
+		*hll_expand = 0;
 	} else {
 		old = prev->data;
 		*hll_lineno = old->hll_lineno;
@@ -79,7 +79,7 @@ static void pop_hll_info(struct cil_stack *stack, int *hll_lineno, int *hll_expa
 	}
 }
 
-static void create_node(struct cil_tree_node **node, struct cil_tree_node *current, int line, int hll_line, void *value)
+static void create_node(struct cil_tree_node **node, struct cil_tree_node *current, uint32_t line, uint32_t hll_line, void *value)
 {
 	cil_tree_node_init(node);
 	(*node)->parent = current;
@@ -99,13 +99,14 @@ static void insert_node(struct cil_tree_node *node, struct cil_tree_node *curren
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
@@ -141,11 +142,19 @@ static int add_hll_linemark(struct cil_tree_node **current, int *hll_lineno, int
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
+			cil_log(CIL_ERR, "Line mark line number > UINT32_MAX\n");
+			goto exit;
+		}
+#endif
+		*hll_lineno = val;
 
 		push_hll_info(stack, *hll_lineno, *hll_expand);
 
@@ -175,7 +184,7 @@ static int add_hll_linemark(struct cil_tree_node **current, int *hll_lineno, int
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Problem with high-level line mark at line %d of %s\n", tok.line, path);
+	cil_log(CIL_ERR, "Problem with high-level line mark at line %u of %s\n", tok.line, path);
 	return SEPOL_ERR;
 }
 
@@ -207,8 +216,8 @@ int cil_parser(const char *_path, char *buffer, uint32_t size, struct cil_tree *
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

