Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E477C433EF
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B70860EE5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhJKQ21 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbhJKQ20 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:26 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF184C06161C
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id d9so46036288edh.5
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2ruCt1+N7aypGX9gh1/S/uTgsVDxJ/gF0h3VlIk0pQo=;
        b=eh9GKkQIIXZW0+MjPaumJ9Qhrbti4xct5n06F0Ph6tZbUa7EpSg/h1yz8CqHTu+21t
         RNK+IrkrU0RazC2ptMF34vbz9pgRJGOmtmmmNpcML0zMe2iH690d6MYnhPzWRpkWN4g7
         vAiVPDYPqy86t8nOsoRPebysxvNrGPbEQu0rZmYu5QeZOwD/4RVeKhXvwGjhJpNMzFH2
         T+wPztdgjra6OChZ3PPZsNpBiRID2kx1nCQVaDT48OrNhIW7AtkZZfb/vh+Y2vug0s7o
         zJWfMB9UXlzWacgQqOg0ziSeBXfsOX09HK0UVPjPHRnTZFQ7uB712ZPh2xQR3wi9t8Tz
         0JSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ruCt1+N7aypGX9gh1/S/uTgsVDxJ/gF0h3VlIk0pQo=;
        b=wGToG/n18X65fIlLqhpxtYRMjh3MFigVt5GD84c/mGv+lOjfoOhyAa9EqWNXEwNviN
         Y1ycULROrHjYp9VoJtB6UX1cy48fqIGSXO95rffw2gcy3qK9AsLRTm3Jd/K/q3FWZ1nk
         hv4qpRFa1Ii3nmq/SnIQWWXln60RcqcuGz7Rl9IircSyW3R8hzneN4vkZqOuBRt7+tA4
         pgbKep3sqoebg0wH4kLGTGSzr6uwAXk4/u2PtMdI/VGzDAabt/Iog1+9yht2R7SaEF2o
         QNwT3Awu54C/wqNuN6u2vXb/GHGTZOWiSj2vpUesEgu89eLl50ikbxpr0SwJVqNhFR6d
         T7dg==
X-Gm-Message-State: AOAM533Wn8MS7zD1OAPNQBZgaMiYReYo25zeZ7XXpaX0rlZFGu1WroS4
        5+HAIoiJKYL1gWC9zx3XnwQuN0HVAOY=
X-Google-Smtp-Source: ABdhPJzr5o9kxQN9tfUoSSls+ERPACrWnw2NOZjsTqhTtf4+AWx4yiH2ecdkhY2QQOfuoaO5CDZR6w==
X-Received: by 2002:a17:906:ae14:: with SMTP id le20mr27496321ejb.89.1633969584384;
        Mon, 11 Oct 2021 09:26:24 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.23
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:24 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 06/35] libsepol: use logging framework in conditional.c
Date:   Mon, 11 Oct 2021 18:25:04 +0200
Message-Id: <20211011162533.53404-7-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use the internal logging framework instead of directly writing to
stdout as it might be undesired to do so within a library.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/conditional.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
index e3ede694..a01350a6 100644
--- a/libsepol/src/conditional.c
+++ b/libsepol/src/conditional.c
@@ -25,6 +25,7 @@
 #include <sepol/policydb/conditional.h>
 
 #include "private.h"
+#include "debug.h"
 
 /* move all type rules to top of t/f lists to help kernel on evaluation */
 static void cond_optimize(cond_av_list_t ** l)
@@ -314,8 +315,7 @@ static int evaluate_cond_node(policydb_t * p, cond_node_t * node)
 	if (new_state != node->cur_state) {
 		node->cur_state = new_state;
 		if (new_state == -1)
-			printf
-			    ("expression result was undefined - disabling all rules.\n");
+			WARN(NULL, "expression result was undefined - disabling all rules.\n");
 		/* turn the rules on or off */
 		for (cur = node->true_list; cur != NULL; cur = cur->next) {
 			if (new_state <= 0) {
@@ -368,8 +368,7 @@ int cond_normalize_expr(policydb_t * p, cond_node_t * cn)
 		if (ne) {
 			ne->next = NULL;
 		} else {	/* ne should never be NULL */
-			printf
-			    ("Found expr with no bools and only a ! - this should never happen.\n");
+			ERR(NULL, "Found expr with no bools and only a ! - this should never happen.\n");
 			return -1;
 		}
 		/* swap the true and false lists */
@@ -421,8 +420,7 @@ int cond_normalize_expr(policydb_t * p, cond_node_t * cn)
 			}
 			k = cond_evaluate_expr(p, cn->expr);
 			if (k == -1) {
-				printf
-				    ("While testing expression, expression result "
+				ERR(NULL, "While testing expression, expression result "
 				     "was undefined - this should never happen.\n");
 				return -1;
 			}
@@ -635,8 +633,7 @@ static int cond_insertf(avtab_t * a
 	 */
 	if (k->specified & AVTAB_TYPE) {
 		if (avtab_search(&p->te_avtab, k)) {
-			printf
-			    ("security: type rule already exists outside of a conditional.");
+			INFO(NULL, "security: type rule already exists outside of a conditional.");
 			goto err;
 		}
 		/*
@@ -652,8 +649,7 @@ static int cond_insertf(avtab_t * a
 			if (node_ptr) {
 				if (avtab_search_node_next
 				    (node_ptr, k->specified)) {
-					printf
-					    ("security: too many conflicting type rules.");
+					ERR(NULL, "security: too many conflicting type rules.");
 					goto err;
 				}
 				found = 0;
@@ -664,15 +660,13 @@ static int cond_insertf(avtab_t * a
 					}
 				}
 				if (!found) {
-					printf
-					    ("security: conflicting type rules.\n");
+					ERR(NULL, "security: conflicting type rules.\n");
 					goto err;
 				}
 			}
 		} else {
 			if (avtab_search(&p->te_cond_avtab, k)) {
-				printf
-				    ("security: conflicting type rules when adding type rule for true.\n");
+				ERR(NULL, "security: conflicting type rules when adding type rule for true.\n");
 				goto err;
 			}
 		}
@@ -680,7 +674,7 @@ static int cond_insertf(avtab_t * a
 
 	node_ptr = avtab_insert_nonunique(&p->te_cond_avtab, k, d);
 	if (!node_ptr) {
-		printf("security: could not insert rule.");
+		ERR(NULL, "security: could not insert rule.");
 		goto err;
 	}
 	node_ptr->parse_context = (void *)1;
@@ -742,14 +736,12 @@ static int cond_read_av_list(policydb_t * p, void *fp,
 static int expr_isvalid(policydb_t * p, cond_expr_t * expr)
 {
 	if (expr->expr_type <= 0 || expr->expr_type > COND_LAST) {
-		printf
-		    ("security: conditional expressions uses unknown operator.\n");
+		INFO(NULL, "security: conditional expressions uses unknown operator.\n");
 		return 0;
 	}
 
 	if (expr->bool > p->p_bools.nprim) {
-		printf
-		    ("security: conditional expressions uses unknown bool.\n");
+		INFO(NULL, "security: conditional expressions uses unknown bool.\n");
 		return 0;
 	}
 	return 1;
-- 
2.33.0

