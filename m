Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F0BC4332F
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhLIQ4E (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241357AbhLIQ4E (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:56:04 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9930C061746
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:52:30 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id g14so20891280edb.8
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=njRU7bLxjyOwbsy17KQnmIWSmP19HRbpEcxQ2c0CijM=;
        b=UQdwQcErCXLeQZZcGbIQ/QPsilWrJPsMuXhJFhUNoJP6qLaHrZtjGoEJOuemxoCUeR
         f3u2ASYfEHLLxYaiWkPgbpjcKYwgxWl2jqs5CynIj6qavqVibPVBWNRAtKnUeT7o0lmA
         H/B0QEAPMpkcG58xjOB4mIBU1bS8CkQX4bryVII2VllH7KIHPjGbIzONunlRlGN3eXne
         OH/IuFrHkAkYUXd5gEZWjFJRONruIMhJujpXSrx2LAy+ALjkoyGZnnOSadCrPxI/WZUB
         RYdLr8hebvlA/ZBH/+xHIC/Dq86bIO7FeZ4p1aBix/9m+hrIbOr/sQ/MINJWJYixe0ua
         T94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=njRU7bLxjyOwbsy17KQnmIWSmP19HRbpEcxQ2c0CijM=;
        b=ZHVRRyesrQsg21jb4q6dawFo6NSM3Tb8BfE06JLX2jad4vny2/BXS5TNrnrgJ7/RuP
         Mbs+aXtnT9V/USaKbmOdkNpidfXNNJcJ2dlzz7drPiv0fmAz4UB+tnmGJSLJ4RoR3rrN
         Q5wHBsmsWN6TPHRPfYjQu5qC/6ITOktVcgGa760RmStWR17KmG7gLkhyVvWPAhv0xU1N
         Cfl7LtmW5bKJIubTFJhaTaF82wqTnY2WGGUdMf2ky9zOGruLQ5f2HYn7MyHhSgy5L5Ot
         aM5x1SJ5bQPBUy3j34ygSOGVR1cYp6kz9DKGce47r/L0dBuZ4mG6bTQMqOkDR9vYJ1H3
         D0VA==
X-Gm-Message-State: AOAM530S1zE4SLSawHEwaTa1N8PQGW5A4pivxcQcbJri3BkADSlNcNne
        4N4Gfu5iXdhP3rgNyyI67W36Q85SlQc=
X-Google-Smtp-Source: ABdhPJxm2//srjy7kMPBVQPa/zmCoQDcG6T0mPFUWJHLFV484rbo8Ipc+XASSCCXoqfJ0cXZSse2mQ==
X-Received: by 2002:a50:fc10:: with SMTP id i16mr30357048edr.84.1639068579148;
        Thu, 09 Dec 2021 08:49:39 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.38
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:38 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 06/36] libsepol: use logging framework in conditional.c
Date:   Thu,  9 Dec 2021 17:48:58 +0100
Message-Id: <20211209164928.87459-7-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209164928.87459-1-cgzones@googlemail.com>
References: <20211105154542.38434-1-cgzones@googlemail.com>
 <20211209164928.87459-1-cgzones@googlemail.com>
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
v2:
   replace INFO calls by WARN since they are reasons of failure
---
 libsepol/src/conditional.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
index 037dc7e2..1edac65d 100644
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
+			WARN(NULL, "security: type rule already exists outside of a conditional.");
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
+		WARN(NULL, "security: conditional expressions uses unknown operator.\n");
 		return 0;
 	}
 
 	if (expr->bool > p->p_bools.nprim) {
-		printf
-		    ("security: conditional expressions uses unknown bool.\n");
+		WARN(NULL, "security: conditional expressions uses unknown bool.\n");
 		return 0;
 	}
 	return 1;
-- 
2.34.1

