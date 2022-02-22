Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D436C433F5
	for <selinux@archiver.kernel.org>; Tue, 22 Feb 2022 13:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbiBVNvM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Feb 2022 08:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiBVNvL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Feb 2022 08:51:11 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90F315E6C7
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 05:50:44 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id d10so43114766eje.10
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 05:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y856+N83mU1Ncw4HWLC7lwqiQZbljQQAPKvmc0Mv7Sw=;
        b=LE34UvexeeFT4MaveGyCHw8Jxv7P3+C0gmqJYtYRbYKTln7PpZPRzB3sY7dadnmEZN
         ipBs35hkAPspGiUBQa++YrVWvVCkm4GfI3p7Mr0ilG61cAknMRveLgzIprSzeEJBdcZw
         bDITUo7bjdcf+LUzqUTlxbvDH/L7kQPrTXRztUEZcFj4tK1v4CMAyWKlNN1oO0IcpISG
         Agyd8QLfIGZcaiq92+r5t1vLLBTV3jx5CUJjkiF+xjGw/+dDywjav0h4L+7bw3czfcz7
         nJPGKNcdbkm2PmvaSfts/FCr5iEMjp+N1HGs0i8fVZnQGvDFigfE3zAYKdya8pGea9JP
         1prA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y856+N83mU1Ncw4HWLC7lwqiQZbljQQAPKvmc0Mv7Sw=;
        b=XBypugqJcEvluUHUxIFW42OuVx2na7bxN6T84Seta/i9SIRR8IKbKpfl9oNQoBrrSw
         zFFOi8ZXoeXyf7KnzZSJnaUm92zihwICNyT8KlmaCGQiuH/ibkGS8W8dJfNru+e6CsYR
         vx+yax/cIdjwbJZVRKwKZEz+iNaDSMrPIUrA/5ro6OR0/Pc56YcfPpysp2sWsqXCPOEQ
         SBY/7j3LqH/GJl19qRvpkZawW3bcsKer2ue4Z/jk4Keiti0Xcp2FTPCTrVxm0A/0TOP2
         DdiqQJiD6BF6R1tya4eY8dIth5Js/orORrwO7Jb8hSjuzKzOKSJG2Q8N/UAtlu9gnUIe
         TJ7g==
X-Gm-Message-State: AOAM531yvyzQTzOfXmfoTvQtW1KCOXFvDx4CeWy9lEg4L+cYDHuGAlMC
        MKJnJxRYuSBkb19wu0CG32qhOM+H6Mc=
X-Google-Smtp-Source: ABdhPJy5/ICC9J7/m6nckD2t8Fcoyp/lM3/3XA+sYo6SHJeLPNPMuwIJKqD+HBzDlnoZmM6bkKKmEQ==
X-Received: by 2002:a17:906:40b:b0:69f:2625:3f67 with SMTP id d11-20020a170906040b00b0069f26253f67mr17605738eja.632.1645537843346;
        Tue, 22 Feb 2022 05:50:43 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-065-014.77.3.pool.telefonica.de. [77.3.65.14])
        by smtp.gmail.com with ESMTPSA id x6sm9847677edv.109.2022.02.22.05.50.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:50:42 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: validate expressions by evaluating
Date:   Tue, 22 Feb 2022 14:50:37 +0100
Message-Id: <20220222135037.30497-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Evaluate expressions similar to the actual kernel security server such
that invalid expressions, e.g. `t2 == t3` for validatetrans, are
rejected.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 216 +++++++++++++++++++++----------
 1 file changed, 150 insertions(+), 66 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 735c7a33..86d40686 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -223,90 +223,174 @@ bad:
 	return -1;
 }
 
-static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms, constraint_node_t *cons, validate_t flavors[])
+/*
+ * Follow evaluation of expressions to find invalid ones.
+ * Keep in sync with kernel source security/selinux/ss/services.c::constraint_expr_eval()
+ */
+static int validate_expression(sepol_handle_t *handle, constraint_expr_t *e, validate_t flavors[])
 {
-	constraint_expr_t *cexp;
-
-	for (; cons; cons = cons->next) {
-		if (nperms > 0 && cons->permissions == 0)
-			goto bad;
-		if (nperms > 0 && nperms != PERM_SYMTAB_SIZE && cons->permissions >= (UINT32_C(1) << nperms))
-			goto bad;
+	int sp = -1;
 
-		for (cexp = cons->expr; cexp; cexp = cexp->next) {
-			if (cexp->attr & CEXPR_USER) {
-				if (validate_ebitmap(&cexp->names, &flavors[SYM_USERS]))
-					goto bad;
-				if (validate_empty_type_set(cexp->type_names))
-					goto bad;
-			} else if (cexp->attr & CEXPR_ROLE) {
-				if (validate_ebitmap(&cexp->names, &flavors[SYM_ROLES]))
-					goto bad;
-				if (validate_empty_type_set(cexp->type_names))
-					goto bad;
-			} else if (cexp->attr & CEXPR_TYPE) {
-				if (validate_ebitmap(&cexp->names, &flavors[SYM_TYPES]))
-					goto bad;
-				if (validate_type_set(cexp->type_names, &flavors[SYM_TYPES]))
-					goto bad;
-			} else {
-				if (!ebitmap_is_empty(&cexp->names))
-					goto bad;
-				if (validate_empty_type_set(cexp->type_names))
-					goto bad;
-			}
+	for (; e; e = e->next) {
+		/* validate symbols (implied in kernel source) */
+		if (e->attr & CEXPR_USER) {
+			if (validate_ebitmap(&e->names, &flavors[SYM_USERS]))
+				goto bad;
+			if (validate_empty_type_set(e->type_names))
+				goto bad;
+		} else if (e->attr & CEXPR_ROLE) {
+			if (validate_ebitmap(&e->names, &flavors[SYM_ROLES]))
+				goto bad;
+			if (validate_empty_type_set(e->type_names))
+				goto bad;
+		} else if (e->attr & CEXPR_TYPE) {
+			if (validate_ebitmap(&e->names, &flavors[SYM_TYPES]))
+				goto bad;
+			if (validate_type_set(e->type_names, &flavors[SYM_TYPES]))
+				goto bad;
+		} else {
+			if (!ebitmap_is_empty(&e->names))
+				goto bad;
+			if (validate_empty_type_set(e->type_names))
+				goto bad;
+		}
 
-			if (cexp->expr_type == CEXPR_ATTR || cexp->expr_type == CEXPR_NAMES) {
-				switch (cexp->op) {
-				case CEXPR_EQ:
-				case CEXPR_NEQ:
+		switch (e->expr_type) {
+		case CEXPR_NOT:
+			if(sp < 0)
+				goto bad;
+			break;
+		case CEXPR_AND:
+			if(sp < 0)
+				goto bad;
+			sp--;
+			break;
+		case CEXPR_OR:
+			if(sp < 0)
+				goto bad;
+			sp--;
+			break;
+		case CEXPR_ATTR:
+			if (sp == (CEXPR_MAXDEPTH - 1))
+				return 0;
+			switch (e->attr) {
+			case CEXPR_USER:
+				break;
+			case CEXPR_TYPE:
+				break;
+			case CEXPR_ROLE:
+				switch (e->op) {
 				case CEXPR_DOM:
+					++sp;
+					continue;
 				case CEXPR_DOMBY:
+					++sp;
+					continue;
 				case CEXPR_INCOMP:
-					break;
+					++sp;
+					continue;
 				default:
-					goto bad;
-				}
-
-				switch (cexp->attr) {
-				case CEXPR_USER:
-				case CEXPR_USER | CEXPR_TARGET:
-				case CEXPR_USER | CEXPR_XTARGET:
-				case CEXPR_ROLE:
-				case CEXPR_ROLE | CEXPR_TARGET:
-				case CEXPR_ROLE | CEXPR_XTARGET:
-				case CEXPR_TYPE:
-				case CEXPR_TYPE | CEXPR_TARGET:
-				case CEXPR_TYPE | CEXPR_XTARGET:
-				case CEXPR_L1L2:
-				case CEXPR_L1H2:
-				case CEXPR_H1L2:
-				case CEXPR_H1H2:
-				case CEXPR_L1H1:
-				case CEXPR_L2H2:
 					break;
-				default:
-					goto bad;
 				}
-			} else {
-				switch (cexp->expr_type) {
-				case CEXPR_NOT:
-				case CEXPR_AND:
-				case CEXPR_OR:
-					break;
+				break;
+			case CEXPR_L1L2:
+				goto mls_ops;
+			case CEXPR_L1H2:
+				goto mls_ops;
+			case CEXPR_H1L2:
+				goto mls_ops;
+			case CEXPR_H1H2:
+				goto mls_ops;
+			case CEXPR_L1H1:
+				goto mls_ops;
+			case CEXPR_L2H2:
+				goto mls_ops;
+mls_ops:
+				switch (e->op) {
+				case CEXPR_EQ:
+					++sp;
+					continue;
+				case CEXPR_NEQ:
+					++sp;
+					continue;
+				case CEXPR_DOM:
+					++sp;
+					continue;
+				case CEXPR_DOMBY:
+					++sp;
+					continue;
+				case CEXPR_INCOMP:
+					++sp;
+					continue;
 				default:
 					goto bad;
 				}
+				break;
+			default:
+				goto bad;
+			}
 
-				if (cexp->op != 0)
-					goto bad;
+			switch (e->op) {
+			case CEXPR_EQ:
+				++sp;
+				break;
+			case CEXPR_NEQ:
+				++sp;
+				break;
+			default:
+				goto bad;
+			}
+			break;
+		case CEXPR_NAMES:
+			if (sp == (CEXPR_MAXDEPTH-1))
+				return 0;
+			if (e->attr & CEXPR_USER)
+				;
+			else if (e->attr & CEXPR_ROLE)
+				;
+			else if (e->attr & CEXPR_TYPE)
+				;
+			else
+				goto bad;
 
-				if (cexp->attr != 0)
-					goto bad;
+			switch (e->op) {
+			case CEXPR_EQ:
+				++sp;
+				break;
+			case CEXPR_NEQ:
+				++sp;
+				break;
+			default:
+				goto bad;
 			}
+			break;
+		default:
+			goto bad;
 		}
 	}
 
+	if (sp != 0)
+		goto bad;
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid expression");
+	return -1;
+}
+
+static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms, constraint_node_t *cons, validate_t flavors[])
+{
+	for (; cons; cons = cons->next) {
+		if (nperms > 0 && cons->permissions == 0)
+			goto bad;
+		if (nperms > 0 && nperms != PERM_SYMTAB_SIZE && cons->permissions >= (UINT32_C(1) << nperms))
+			goto bad;
+
+		if (validate_expression(handle, cons->expr, flavors))
+			goto bad;
+	}
+
 	return 0;
 
 bad:
-- 
2.35.1

