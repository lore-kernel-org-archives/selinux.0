Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFBEC433F5
	for <selinux@archiver.kernel.org>; Tue, 22 Feb 2022 18:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbiBVSMX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Feb 2022 13:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbiBVSMV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Feb 2022 13:12:21 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88244EF73
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 10:11:54 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id w3so38958437edu.8
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 10:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iFa7ceI5l19RPjQ5NMqoVES6f40N5jK1q17rCcbx9+M=;
        b=IkYnzyGlYofbbdqD4uPuHKnnW2qxaQTmLze61aSRcAKS1dhMqYe7F8K7e/Yy6jYlXP
         EYHnru8LbxXZX1D3HFJDJYbKFXBv+vMRxza/MYO9/TRa9521AEVkMgHJEm634u82WQUW
         4ir2mgaSZdn5dxbTFgvx06l7Af7U849HzOMB+QRi0zHLv8KnQeld4ZTxdpzd3PlSVINJ
         bgaCByYySL1oOhc9cQt03vmrbOCjZaWMCXMoFlaLcKk9XZOxqQghYTHNwED7pZQ53LY7
         otuLVvo+AmybKwsRnzSm61cq1lGdY5Yf6mMKLhncRA6SEr93ma2WrSn0i5eAP5bXjBUf
         lJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iFa7ceI5l19RPjQ5NMqoVES6f40N5jK1q17rCcbx9+M=;
        b=pSZgcbwJ+afiHG7V9EaphYTc4yPS+PctyKy1z/x0hmPIFqriaeYRmDKYICBXZ1ytE4
         1ypLe0BAWRNVNsb+5qXkPWdmxAK+ruXMTYPSV4p3SZC0Qov1hEiWq2JyyOVQ53FqTeoo
         EKVnNXCpvOtc0aMWvPTCr54pzb0v5OcDj99nmv9LWKjUNYlshqP2n2GWdyEBRcsZ40rT
         hnH6/j1aXVy4PV60VDJKEHoXVdisG6noW/DQW6Zy1wsGbTCmwkaw5Y1NxsU65Iv08pLA
         69g+FmUaecYh4TysFC1b2Ysr2j7Pvw+E8fKU6xoM1+YNF2PFWQu5cokV+JdZdu/nfFWW
         /7yg==
X-Gm-Message-State: AOAM532sXnEQYyIqvfW9gXZwjGEqWRYpK9/vLQc+1RzYJM1hkHHAHe80
        SvyEMaMNf7ckvyKnQDxTH4W2oEpmp/g=
X-Google-Smtp-Source: ABdhPJxLcyoh2bogOAHPS4cgH8K8A+E5/XMD4u2KnCVktVBJrXz90i3zpXajOdXQSrcVWBQ1jbDu/Q==
X-Received: by 2002:a05:6402:5207:b0:412:806b:6424 with SMTP id s7-20020a056402520700b00412806b6424mr27501021edd.131.1645553513361;
        Tue, 22 Feb 2022 10:11:53 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-065-014.77.3.pool.telefonica.de. [77.3.65.14])
        by smtp.gmail.com with ESMTPSA id y1sm6538529eju.29.2022.02.22.10.11.52
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:11:52 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2] libsepol: validate expressions by evaluating
Date:   Tue, 22 Feb 2022 19:11:48 +0100
Message-Id: <20220222181148.54329-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222135037.30497-1-cgzones@googlemail.com>
References: <20220222135037.30497-1-cgzones@googlemail.com>
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
v2:
    reject third task context in normal constraints
---
 libsepol/src/policydb_validate.c | 226 ++++++++++++++++++++++---------
 1 file changed, 159 insertions(+), 67 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 735c7a33..3b0ea0e1 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -223,90 +223,182 @@ bad:
 	return -1;
 }
 
-static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms, constraint_node_t *cons, validate_t flavors[])
+/*
+ * Follow evaluation of expressions to find invalid ones.
+ * Keep in sync with kernel source security/selinux/ss/services.c::constraint_expr_eval()
+ */
+static int validate_expression(sepol_handle_t *handle, constraint_expr_t *e, int validatetrans, validate_t flavors[])
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
+			if (e->attr & CEXPR_TARGET)
+				;
+			else if (e->attr & CEXPR_XTARGET) {
+				if (!validatetrans)
 					goto bad;
+			}
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
+static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms, constraint_node_t *cons, int validatetrans, validate_t flavors[])
+{
+	for (; cons; cons = cons->next) {
+		if (validatetrans && cons->permissions != 0)
+			goto bad;
+		if (!validatetrans && cons->permissions == 0)
+			goto bad;
+		if (!validatetrans && nperms != PERM_SYMTAB_SIZE && cons->permissions >= (UINT32_C(1) << nperms))
+			goto bad;
+
+		if (validate_expression(handle, cons->expr, validatetrans, flavors))
+			goto bad;
+	}
+
 	return 0;
 
 bad:
@@ -320,9 +412,9 @@ static int validate_class_datum(sepol_handle_t *handle, class_datum_t *class, va
 		goto bad;
 	if (class->permissions.nprim > PERM_SYMTAB_SIZE)
 		goto bad;
-	if (validate_constraint_nodes(handle, class->permissions.nprim, class->constraints, flavors))
+	if (validate_constraint_nodes(handle, class->permissions.nprim, class->constraints, 0, flavors))
 		goto bad;
-	if (validate_constraint_nodes(handle, 0, class->validatetrans, flavors))
+	if (validate_constraint_nodes(handle, class->permissions.nprim, class->validatetrans, 1, flavors))
 		goto bad;
 
 	switch (class->default_user) {
-- 
2.35.1

