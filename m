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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531FEC4743F
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 16:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D4D3610A2
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 16:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbhFHQCb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:02:31 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:43563 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbhFHQCa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Jun 2021 12:02:30 -0400
Received: by mail-ej1-f45.google.com with SMTP id ci15so33423479ejc.10
        for <selinux@vger.kernel.org>; Tue, 08 Jun 2021 09:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=P6GPJC2qa5dzk47OPuHyvIvE3Fkla02EA5B4DBJukQ4=;
        b=luFgcmUYUTGlev2XyEQNnKbsiTHeLQ+avIz4JCUFywX6wcwiljh0TdCgkRVmkgzm90
         cDAeR9ZQmoFr/TeqiWYijEiJ0mPqUMcd2VvNxTheyrb+KWA6T9TYEzOMt+RNsYSNlds9
         uH6StFToP21VdoPBBnXej50FFKTp9o2p/q3W3rxbrzoqFtNbXG2xV2SUQWUnHQBlHtDO
         igdsdhTRIBC90XcWYSbm94pjKzcDKGhhV61gEdcAqpEHNrRLKciDxihAEv+8U08ja9+y
         FsLibTanWybauSNtwN0dV+irDTmib7bh/qJWuUAAROGMxWxWzWvnVbDWZTmUhYews74u
         YbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P6GPJC2qa5dzk47OPuHyvIvE3Fkla02EA5B4DBJukQ4=;
        b=IPUMLff0WXWjUG5C3KtHo+tPOLIvyRfkiQUCwtgsby9PAo0RBi+XjTnEV4imNorKlu
         Ffo0K32F3W3hd/eEx5O62STmPQCPcUGCs+12pZxaH+inxKDckmslDvK0krKQS43BMCDa
         EwIDNqaQohl7Ac20yeKDIMmqxhs+oTcAiMpR0FWaQLWVsJ2bIsOyQOEbrDfn0uUE6K6H
         ns1pCaVx4RwdMfWYHdUcOFX69vqtQxxLKT6QlBu771ka+sOoviaz1YJk3tUq2ZCWMfQL
         BmP4ytdr6wwcbsCpnLzxqpWLHnPMzllSrdN4vCODXAjwVzAJQLLydBWoTPQf4ZJIQ740
         0goA==
X-Gm-Message-State: AOAM533yuR7SB4HSNmU79PWk9ZepSd/dTbZAYzBnn6V+0+XZP0Ye6cJ1
        ZpGH//xYeIAkJ127Rsdz038qoY/Ww5g=
X-Google-Smtp-Source: ABdhPJy2p7tk4N7vdoUAt/GCE22c3WtfUJZf/j9CfZwdIDzTcBZsyJuM+2+QtcP7iEbSbrYNvt3LoQ==
X-Received: by 2002:a17:907:2bd9:: with SMTP id gv25mr23826906ejc.157.1623167964405;
        Tue, 08 Jun 2021 08:59:24 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-183-231.95.112.pool.telefonica.de. [95.112.183.231])
        by smtp.gmail.com with ESMTPSA id n13sm51134ejk.97.2021.06.08.08.59.23
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:59:24 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 09/23] libsepol: remove dead stores
Date:   Tue,  8 Jun 2021 17:58:58 +0200
Message-Id: <20210608155912.32047-10-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608155912.32047-1-cgzones@googlemail.com>
References: <20210608155912.32047-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

conditional.c:391:4: warning: Value stored to 'i' is never read [deadcode.DeadStores]
                        i = 0;
                        ^   ~
conditional.c:718:2: warning: Value stored to 'len' is never read [deadcode.DeadStores]
        len = 0;
        ^     ~
conditional.c:772:2: warning: Value stored to 'len' is never read [deadcode.DeadStores]
        len = 0;
        ^     ~

services.c:89:10: warning: Value stored to 'new_stack' during its initialization is never read [deadcode.DeadStores]
                char **new_stack = stack;
                       ^~~~~~~~~   ~~~~~

services.c:440:11: warning: Value stored to 'new_expr_list' during its initialization is never read [deadcode.DeadStores]
                        char **new_expr_list = expr_list;
                               ^~~~~~~~~~~~~   ~~~~~~~~~

../cil/src/cil_binary.c:2230:24: warning: Value stored to 'cb_node' during its initialization is never read [deadcode.DeadStores]
        struct cil_tree_node *cb_node = node->cl_head;
                              ^~~~~~~   ~~~~~~~~~~~~~

Found by clang-analyzer

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/conditional.c | 3 ---
 libsepol/src/services.c    | 4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
index 823b649a..e3ede694 100644
--- a/libsepol/src/conditional.c
+++ b/libsepol/src/conditional.c
@@ -388,7 +388,6 @@ int cond_normalize_expr(policydb_t * p, cond_node_t * cn)
 	for (e = cn->expr; e != NULL; e = e->next) {
 		switch (e->expr_type) {
 		case COND_BOOL:
-			i = 0;
 			/* see if we've already seen this bool */
 			if (!bool_present(e->bool, cn->bool_ids, cn->nbools)) {
 				/* count em all but only record up to COND_MAX_BOOLS */
@@ -715,7 +714,6 @@ static int cond_read_av_list(policydb_t * p, void *fp,
 
 	*ret_list = NULL;
 
-	len = 0;
 	rc = next_entry(buf, fp, sizeof(uint32_t));
 	if (rc < 0)
 		return -1;
@@ -769,7 +767,6 @@ static int cond_read_node(policydb_t * p, cond_node_t * node, void *fp)
 
 	node->cur_state = le32_to_cpu(buf[0]);
 
-	len = 0;
 	rc = next_entry(buf, fp, sizeof(uint32_t));
 	if (rc < 0)
 		goto err;
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index d647c8f5..c34bb966 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -86,7 +86,7 @@ static int next_stack_entry;
 static void push(char *expr_ptr)
 {
 	if (next_stack_entry >= stack_len) {
-		char **new_stack = stack;
+		char **new_stack;
 		int new_stack_len;
 
 		if (stack_len == 0)
@@ -441,7 +441,7 @@ static int constraint_expr_eval_reason(context_struct_t *scontext,
 	for (e = constraint->expr; e; e = e->next) {
 		/* Allocate a stack to hold expression buffer entries */
 		if (expr_counter >= expr_list_len) {
-			char **new_expr_list = expr_list;
+			char **new_expr_list;
 			int new_expr_list_len;
 
 			if (expr_list_len == 0)
-- 
2.32.0

