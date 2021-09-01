Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DBCC4320A
	for <selinux@archiver.kernel.org>; Wed,  1 Sep 2021 20:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16A526101B
	for <selinux@archiver.kernel.org>; Wed,  1 Sep 2021 20:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhIAUn5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Sep 2021 16:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbhIAUn4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Sep 2021 16:43:56 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D21C061757
        for <selinux@vger.kernel.org>; Wed,  1 Sep 2021 13:42:59 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id g11so642534qvd.2
        for <selinux@vger.kernel.org>; Wed, 01 Sep 2021 13:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/NjZwsYCiHGjuSDMshk1Clj4cS/+ywxfVtoDuut/2LI=;
        b=cpiV2HH371nYWGKNgAVrKgojJwurYlnBNK1l6FwlUw23wBiorWCJppQHz/IE8az5nY
         LZ4UNHhCZCLFl23FSctpsWNnNuJMKXL/0LBLLKFe2muKbdOgc3ncg5VYaq4F8fEAXiYe
         8K7zahTAyMkPEgsa5GiUNMTbV7IgyC3mRvdBtxEH6PbOjHBp4Di6v17eCsHKnlw/Xyov
         DLVXeb0ZgO/d/AGPOvxDFe8aydUG/kDYTxM7X0Rc+4xLPZ/j0MTHZc3TdB8/wLUjIb+1
         8i9mgJk/hs7PB/tT506D60gVG7f+oTDGZD1+LLcTin30HjcjZpBVSn13qAn4gnPppWPx
         vksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/NjZwsYCiHGjuSDMshk1Clj4cS/+ywxfVtoDuut/2LI=;
        b=s8SS+EPDJX9ocA4UVn+XLfWiCUVf9SWxh8IFG/8XReK6C/VMclp76HY37Qkv9BRfKa
         9x6LVU0jaI5r2WZJkqabWEdKoEVXSfWSqloVg1r9AC8E1uHZE2/XKQD075Ajvyme9z+y
         dC5012Zr18b2LaruD1ansBX+WHPQihjwylMDKeMhxYqq+yyhPdMTGZkz99Qd/ryOqOhq
         IU2OU4QgmCTrNpDVJ+tiLOUw7fHBSRlvmgnGfBhhTJ7B46GbCxSBcGnKsOZ1a9l4OBRE
         oWi0csrYbAszfziO2UZoYig/ZIGoC+C0CBwzIauCKUUmMzldqwsq20A5JT07O03pU4CJ
         XFiQ==
X-Gm-Message-State: AOAM532C0qtSjG+brOsBOLM7f5VonIbfgFP4aV9fz6MrrwKZrgPQOuGR
        vblogxodKM0sYsEgnLTBtmHQ4a0PnSs=
X-Google-Smtp-Source: ABdhPJwq7zvxwZuXm828SQDC923HQtZbSluyHhcD4Lee4Qpob+98xKy+N7dfbBJXTFEt4bcllLsDhg==
X-Received: by 2002:a0c:d6cd:: with SMTP id l13mr1791737qvi.24.1630528978680;
        Wed, 01 Sep 2021 13:42:58 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id x23sm500098qkn.29.2021.09.01.13.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 13:42:58 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/3 v2] libsepol/cil: Fix syntax checking in __cil_verify_syntax()
Date:   Wed,  1 Sep 2021 16:42:52 -0400
Message-Id: <20210901204252.635570-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901204252.635570-1-jwcart2@gmail.com>
References: <20210901204252.635570-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The function __cil_verify_syntax() is used to check the syntax of
CIL rules (and a few other common things like contexts and class
permissions). It does not correctly check the syntax combination
"CIL_SYN_STRING | CIL_SYN_N_LISTS, CIL_SYN_N_LISTS | CIL_SYN_END".
This should mean either a string followed by any number of lists
or any number of lists followed by the end of the rule. Instead,
while allowing the correct syntax, it allows any number of lists
followed by a string followed by any number of more lists followed
by the end of the rule and, also, any number of lists followed by a
string followed by the end of the rule.

Refactor the function to make it clearer to follow and so that once
checking begins for CIL_SYN_N_LISTS or CIL_SYN_N_STRINGS, then only
strings or lists are allowed until the end of the rule is found. In
addition, always check for CIL_SYN_END at the end.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: Put parenthesis around bitwise operations.
    Using size_t for len and i as changed by patch 2.

 libsepol/cil/src/cil_verify.c | 71 ++++++++++++-----------------------
 1 file changed, 23 insertions(+), 48 deletions(-)

diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 6438ceba..5502c4d5 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -146,68 +146,43 @@ exit:
 
 int __cil_verify_syntax(struct cil_tree_node *parse_current, enum cil_syntax s[], size_t len)
 {
-	int rc = SEPOL_ERR;
-	int num_extras = 0;
 	struct cil_tree_node *c = parse_current;
 	size_t i = 0;
-	while (i < len) {
-		if ((s[i] & CIL_SYN_END) && c == NULL) {
-			break;
-		}
 
-		if (s[i] & CIL_SYN_N_LISTS || s[i] & CIL_SYN_N_STRINGS) {
-			if (c == NULL) {
-				if (num_extras > 0) {
-					i++;
-					continue;
+	while (i < len && c != NULL) {
+		if ((s[i] & CIL_SYN_STRING) && c->data != NULL && c->cl_head == NULL) {
+			c = c->next;
+			i++;
+		} else if ((s[i] & CIL_SYN_LIST) && c->data == NULL && c->cl_head != NULL) {
+			c = c->next;
+			i++;
+		} else if ((s[i] & CIL_SYN_EMPTY_LIST) && c->data == NULL && c->cl_head == NULL) {
+			c = c->next;
+			i++;
+		} else if ((s[i] & CIL_SYN_N_LISTS) || (s[i] & CIL_SYN_N_STRINGS)) {
+			while (c != NULL) {
+				if ((s[i] & CIL_SYN_N_LISTS) && c->data == NULL && c->cl_head != NULL) {
+					c = c->next;
+				} else if ((s[i] & CIL_SYN_N_STRINGS) && c->data != NULL && c->cl_head == NULL) {
+					c = c->next;
 				} else {
 					goto exit;
 				}
-			} else if ((s[i] & CIL_SYN_N_LISTS) && (c->data == NULL && c->cl_head != NULL)) {
-				c = c->next;
-				num_extras++;
-				continue;
-			} else if ((s[i] & CIL_SYN_N_STRINGS) && (c->data != NULL && c->cl_head == NULL)) {
-				c = c->next;
-				num_extras++;
-				continue;
 			}
-		}
-
-		if (c == NULL) {
+			i++;
+			break; /* Only CIL_SYN_END allowed after these */
+		} else {
 			goto exit;
 		}
+	}
 
-		if (s[i] & CIL_SYN_STRING) {
-			if (c->data != NULL && c->cl_head == NULL) {
-				c = c->next;
-				i++;
-				continue;
-			}
-		}
-
-		if (s[i] & CIL_SYN_LIST) {
-			if (c->data == NULL && c->cl_head != NULL) {
-				c = c->next;
-				i++;
-				continue;
-			}
-		}
-
-		if (s[i] & CIL_SYN_EMPTY_LIST) {
-			if (c->data == NULL && c->cl_head == NULL) {
-				c = c->next;
-				i++;
-				continue;
-			}
-		}
-		goto exit;
+	if (i < len && (s[i] & CIL_SYN_END) && c == NULL) {
+		return SEPOL_OK;
 	}
-	return SEPOL_OK;
 
 exit:
 	cil_log(CIL_ERR, "Invalid syntax\n");
-	return rc;
+	return SEPOL_ERR;
 }
 
 int cil_verify_expr_syntax(struct cil_tree_node *current, enum cil_flavor op, enum cil_flavor expr_flavor)
-- 
2.31.1

