Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2399EC433F5
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05B1861108
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhKEPsb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbhKEPsb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:31 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7275BC061714
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:45:51 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w1so34803245edd.10
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Foaq3q3y0h6prOQRaT8fTuHYMx7CtZpIoNIw69ai3ew=;
        b=Njf1y6UrK1MUt4SZxBwiJKfDq0EwLoGBFgk3jT23AW4kun7LM2DgYQcN6Qe3albaDW
         wWWxBY04PmQwvQJfo7gOxYX3qzeYnOwXf7aUDyAD7X469ObkOHGFZ8B2iD7Wi+7RMpLD
         rOBo7hmwUOGyMOdRR8GHoAifot+DH1bvXjxk7Z1lb5tTnNsotjbWE29WwsUhGqGaF+Vo
         rNO1i1YejZ13iQoLjyIccTcmALsID+MYV+B2qpnecvDJEAUDo8yJ/TmVpDb7MwJ3ePP4
         dcL2swfvlbJw0dvHqR9N1LV2YBCtlP7Q5Byp0sfM6uvoeTVng3cJpTiNEEsqLa/mVz0I
         KMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Foaq3q3y0h6prOQRaT8fTuHYMx7CtZpIoNIw69ai3ew=;
        b=6gGW9MObFyJoMmfwbEWzwMoc27ANsNK0BoEHQojrILysLPTAIwWfD3XN2VbYORmfPu
         D6MB9ezoeuG0FgA9f9hqblgUkJBQJwR/ULOLGRPSn8OKa5jGUyN8TowP5TyiOhdjuKvN
         N6Z5Cg+VoLwcFF+ANyKbiEyvXF6YMg4For1uc8MT+ppb/47eN6B0jBsEhSric2+Ika27
         OFrC2jNIZka6bIjOn08xvHWQ5jI5iM0Le0oefcP2Ai7gEkW1JudgbZv+l3mS9FV0daWt
         Z8AfypcP3V88bNVStyj/iW6EDbpIbqAsxtG/ct9uif2HLBDracwfHb0kic1Sq92aZ4YK
         0oHQ==
X-Gm-Message-State: AOAM532z8LFOAcULa/Vd6ulolSOiyI9J3ga1hbUWSsBfX9L8xZSBM+zZ
        WZ96H9dptl9pynYAmPRekMSN6ETaGaI=
X-Google-Smtp-Source: ABdhPJyQ1eh8qfi5//YwUVwwQEPk4PkIhyFJQGD2gqLlI3DxRkstc+sKP/h4KO25W8i45cch6Z+G6Q==
X-Received: by 2002:a05:6402:3588:: with SMTP id y8mr24171514edc.328.1636127149816;
        Fri, 05 Nov 2021 08:45:49 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.45.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:45:49 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 06/36] libsepol: use logging framework in conditional.c
Date:   Fri,  5 Nov 2021 16:45:08 +0100
Message-Id: <20211105154542.38434-7-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105154542.38434-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
 <20211105154542.38434-1-cgzones@googlemail.com>
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
2.33.1

