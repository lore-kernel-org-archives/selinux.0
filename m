Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA1CC433F5
	for <selinux@archiver.kernel.org>; Thu,  3 Mar 2022 21:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiCCVsu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Mar 2022 16:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiCCVst (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Mar 2022 16:48:49 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FC9EDF0C
        for <selinux@vger.kernel.org>; Thu,  3 Mar 2022 13:48:02 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id d3so5218770qvb.5
        for <selinux@vger.kernel.org>; Thu, 03 Mar 2022 13:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FrArwC+L7riqOwYSJEN1JhuzBm8LWEjx6z0TSxG5JRk=;
        b=MZ33JB8Db2S2A6ip+hL0zwtVCG3viWmK0VbC+B5DERxW3vB4ItxRoTNi1HkuD38uLT
         Y9XBpz63osx5BnI3E766xvao57rHKwOinkWBkO77faSmHde39kOjqO9sD3DbGWlghIcx
         gKgsF2iKVr/+EzycZly6/D+N3nmsHPhpjU6hX8SpvyjLjTVmJ5tG1QFjixLBEIxC1g/0
         1624W9aIVraCYua8O0yzLC+jQNbn4K+td0VN6Lz5vKWMlhOkOdE/UsCVaWKBs62EEwBr
         rqg6sdnV0xdhGlUSZ08ACvS1xBjjyqSJ3Zbn6QCc1T6vNnVtdXZw/VxqhVYhFmtl+q7F
         337Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FrArwC+L7riqOwYSJEN1JhuzBm8LWEjx6z0TSxG5JRk=;
        b=cFBV8/FCHNPsfEsd153qGLSgSHdblNLoz4Abk9v86XK1osUGxo4FuaLzOseL/ToFnh
         Zc3al+mJnHVDLKzq8BUz0tBcxvo/Lpj0M8HM7mhdpUxlCUQjt4guFm/WJebu9BjxFgFd
         0eWBSrQPngnGL1UAKUIKdopS2Hm2t9WwBErSYY38dg8cqVB+wDXy0pR6gZm/7j+ISJVR
         ZbqIHlC3aUAmZXWzzUyWOMz8VxFCIlkbETYglZ9jdq1vzahKmXqD2A5HKRPcqeRJuNO0
         G/qXtfP9m9WTWbaR0YIwyfQ08C9yVzxvMuKh+Xn7SCnqHkEsuspFBa/491PRs9q2yoOc
         tjYA==
X-Gm-Message-State: AOAM532UV9B/XtOkygK4waeMg+ZOEutLtSPNSgbjv/oIx94Z2uQmIurG
        HZKsh+1cfmKirs6OLjJwWaJmNeSqqdo=
X-Google-Smtp-Source: ABdhPJzHC2Zg8pFV4aA3RPs6X5juVot2lmxA9OzH65hD4JbkK/aoeUo31igICcCjDMFcrqBfO5R5EA==
X-Received: by 2002:ad4:5caf:0:b0:435:37ed:aa18 with SMTP id q15-20020ad45caf000000b0043537edaa18mr3126930qvh.50.1646344081903;
        Thu, 03 Mar 2022 13:48:01 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id m10-20020a05622a054a00b002e049ff99f2sm1024838qtx.7.2022.03.03.13.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 13:48:01 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Do a more thorough validation of constraints
Date:   Thu,  3 Mar 2022 16:47:50 -0500
Message-Id: <20220303214750.566685-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When validating a policydb, do a more thorough validation of the
constraints.
 - No permissions if it is a (mls)validatetrans.
 - Only mlsvalidatetrans can use u3, r3, and t3.
 - Expressions not involving types should have an empty type set.
 - Only "==" and "!=" are allowed when there are names.
 - If names are not used in an expression then both the names bitmap
   and the type set should be empty.
 - Only roles and mls expressions can used "dom", "domby", and "incomp".
 - An mls expression cannot use names.
 - If the expression is "not", "and", or "or", then the names bitmap
   and the type set should be empty.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/policydb_validate.c | 69 ++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 22 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 735c7a33..2c69f201 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -228,41 +228,69 @@ static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms
 	constraint_expr_t *cexp;
 
 	for (; cons; cons = cons->next) {
+		if (nperms == 0 && cons->permissions != 0)
+			goto bad;
 		if (nperms > 0 && cons->permissions == 0)
 			goto bad;
 		if (nperms > 0 && nperms != PERM_SYMTAB_SIZE && cons->permissions >= (UINT32_C(1) << nperms))
 			goto bad;
 
 		for (cexp = cons->expr; cexp; cexp = cexp->next) {
-			if (cexp->attr & CEXPR_USER) {
-				if (validate_ebitmap(&cexp->names, &flavors[SYM_USERS]))
-					goto bad;
-				if (validate_empty_type_set(cexp->type_names))
-					goto bad;
-			} else if (cexp->attr & CEXPR_ROLE) {
-				if (validate_ebitmap(&cexp->names, &flavors[SYM_ROLES]))
+			if (cexp->expr_type == CEXPR_NAMES) {
+				if (cexp->attr & CEXPR_XTARGET && nperms != 0)
 					goto bad;
-				if (validate_empty_type_set(cexp->type_names))
-					goto bad;
-			} else if (cexp->attr & CEXPR_TYPE) {
-				if (validate_ebitmap(&cexp->names, &flavors[SYM_TYPES]))
+				if (!(cexp->attr & CEXPR_TYPE)) {
+					if (validate_empty_type_set(cexp->type_names))
+						goto bad;
+				}
+
+				switch (cexp->op) {
+				case CEXPR_EQ:
+				case CEXPR_NEQ:
+					break;
+				default:
 					goto bad;
-				if (validate_type_set(cexp->type_names, &flavors[SYM_TYPES]))
+				}
+
+				switch (cexp->attr) {
+				case CEXPR_USER:
+				case CEXPR_USER | CEXPR_TARGET:
+				case CEXPR_USER | CEXPR_XTARGET:
+					if (validate_ebitmap(&cexp->names, &flavors[SYM_USERS]))
+						goto bad;
+					break;
+				case CEXPR_ROLE:
+				case CEXPR_ROLE | CEXPR_TARGET:
+				case CEXPR_ROLE | CEXPR_XTARGET:
+					if (validate_ebitmap(&cexp->names, &flavors[SYM_ROLES]))
+						goto bad;
+					break;
+				case CEXPR_TYPE:
+				case CEXPR_TYPE | CEXPR_TARGET:
+				case CEXPR_TYPE | CEXPR_XTARGET:
+					if (validate_ebitmap(&cexp->names, &flavors[SYM_TYPES]))
+						goto bad;
+					if (validate_type_set(cexp->type_names, &flavors[SYM_TYPES]))
+						goto bad;
+					break;
+				default:
 					goto bad;
-			} else {
+				}
+			} else if (cexp->expr_type == CEXPR_ATTR) {
 				if (!ebitmap_is_empty(&cexp->names))
 					goto bad;
 				if (validate_empty_type_set(cexp->type_names))
 					goto bad;
-			}
 
-			if (cexp->expr_type == CEXPR_ATTR || cexp->expr_type == CEXPR_NAMES) {
 				switch (cexp->op) {
 				case CEXPR_EQ:
 				case CEXPR_NEQ:
+					break;
 				case CEXPR_DOM:
 				case CEXPR_DOMBY:
 				case CEXPR_INCOMP:
+					if ((cexp->attr & CEXPR_USER) || (cexp->attr & CEXPR_TYPE))
+						goto bad;
 					break;
 				default:
 					goto bad;
@@ -270,14 +298,8 @@ static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms
 
 				switch (cexp->attr) {
 				case CEXPR_USER:
-				case CEXPR_USER | CEXPR_TARGET:
-				case CEXPR_USER | CEXPR_XTARGET:
 				case CEXPR_ROLE:
-				case CEXPR_ROLE | CEXPR_TARGET:
-				case CEXPR_ROLE | CEXPR_XTARGET:
 				case CEXPR_TYPE:
-				case CEXPR_TYPE | CEXPR_TARGET:
-				case CEXPR_TYPE | CEXPR_XTARGET:
 				case CEXPR_L1L2:
 				case CEXPR_L1H2:
 				case CEXPR_H1L2:
@@ -300,9 +322,12 @@ static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms
 
 				if (cexp->op != 0)
 					goto bad;
-
 				if (cexp->attr != 0)
 					goto bad;
+				if (!ebitmap_is_empty(&cexp->names))
+					goto bad;
+				if (validate_empty_type_set(cexp->type_names))
+					goto bad;
 			}
 		}
 	}
-- 
2.34.1

