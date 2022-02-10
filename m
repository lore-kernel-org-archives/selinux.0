Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476A3C433F5
	for <selinux@archiver.kernel.org>; Thu, 10 Feb 2022 18:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiBJSwl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Feb 2022 13:52:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243255AbiBJSwk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Feb 2022 13:52:40 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A371F28
        for <selinux@vger.kernel.org>; Thu, 10 Feb 2022 10:52:41 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id e7so13456759ejn.13
        for <selinux@vger.kernel.org>; Thu, 10 Feb 2022 10:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=46c/pBBVAt5wIgF80hVXdkR6N98zzl+fl7ohI4vU8/Q=;
        b=T0s+cYDZKFvqFxz9JVRVKKCtVmvShej7m/TRVUYPYgJ1pfhmlyd+ULEa62HAvEtKIK
         2U8X3hPSz2wDOGzYShaAOvCBrQjM70j8KuIqvpj1hZmPkvxHYHKwloeVRqFkmXyji0iv
         BvRBuZ91TC9ajTbEQJIemsSLPagjkoyEzuBc5IvchBZWl9C/1S6ZVieTsECsgZweJul1
         hc0T+ySis1zoXU7TOnn8dqRo74n3GCRVMeAh1KuGRP7debRTjU/bNuCOFa24FKX6EZL4
         aj69pVcAdUyBJykn6EqZ+9JROYoHNNhHzt2LpJSGdCwziqynFyG1LcFSs29/TEJ4MdIS
         0jHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=46c/pBBVAt5wIgF80hVXdkR6N98zzl+fl7ohI4vU8/Q=;
        b=22wTf0FFf6+hp5mr8e19ZSLU6F8hDN76o+JarObEp8ZEuroj8jiJUEoqG1H9WnAHAR
         NSZwi858906B7p7pG1ca9Tg9DjcELhenCEAyMSwPXKJun94yK0XicCiotOkj59e2+u6t
         Prj57Iw+M/8pHLsErd2hoigFkFkjoJR8X58FSz1GWkrLySRGKtL38UWPaUO1paMuq9Br
         l3tgP410qzETTuv/DVsFgw4vmD4KY2hrLj3EyAwzIBbRqHYnE9T3CMy+Qs3Z8M9xfjmK
         MukiHc7+CwnSJVO/91FakwoEVGl22rpcMXvA1ItexSOAxd5IV70zPnHiHHe4vbeXGKVs
         AGvQ==
X-Gm-Message-State: AOAM53206PLAMStYcZSAJyZcsFHUt4vRxTE5kDheKZXo1sL/keBoCgDn
        ZJp6Y3veiqjfiVWTbeXVPtoxUX+VuB4=
X-Google-Smtp-Source: ABdhPJx+yWy0xOv2ikd4DsLfWb4F2AVD5bFYk3xv22VaXCs5B6I1A3ERmDI8uEnKbtipYJ0zpCD3Wg==
X-Received: by 2002:a17:906:7289:: with SMTP id b9mr7583110ejl.171.1644519159936;
        Thu, 10 Feb 2022 10:52:39 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-000-131-054.77.0.pool.telefonica.de. [77.0.131.54])
        by smtp.gmail.com with ESMTPSA id gi15sm4666070ejc.139.2022.02.10.10.52.39
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 10:52:39 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/3] libsepol: more strict constraint validation
Date:   Thu, 10 Feb 2022 19:52:33 +0100
Message-Id: <20220210185234.41362-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220210185234.41362-1-cgzones@googlemail.com>
References: <20220210185234.41362-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Check the permission bitset in normal constraints is not empty and has
no invalid bits set.

Check the names and type_names members are empty in case they are not
used.

Check the operator and attribute type are not set for simple expression
types.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 43 +++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 0650f4d1..41822e61 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -130,6 +130,21 @@ bad:
 	return -1;
 }
 
+static int validate_empty_type_set(type_set_t *type_set)
+{
+	if (!ebitmap_is_empty(&type_set->types))
+		goto bad;
+	if (!ebitmap_is_empty(&type_set->negset))
+		goto bad;
+	if (type_set->flags != 0)
+		goto bad;
+
+	return 0;
+
+bad:
+	return -1;
+}
+
 static int validate_role_set(role_set_t *role_set, validate_t *role)
 {
 	if (validate_ebitmap(&role_set->roles, role))
@@ -176,23 +191,37 @@ bad:
 	return -1;
 }
 
-static int validate_constraint_nodes(sepol_handle_t *handle, constraint_node_t *cons, validate_t flavors[])
+static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms, constraint_node_t *cons, validate_t flavors[])
 {
 	constraint_expr_t *cexp;
 
 	for (; cons; cons = cons->next) {
+		if (nperms > 0 && cons->permissions == 0)
+			goto bad;
+		if (nperms > 0 && nperms != PERM_SYMTAB_SIZE && cons->permissions >= (UINT32_C(1) << nperms))
+			goto bad;
+
 		for (cexp = cons->expr; cexp; cexp = cexp->next) {
 			if (cexp->attr & CEXPR_USER) {
 				if (validate_ebitmap(&cexp->names, &flavors[SYM_USERS]))
 					goto bad;
+				if (validate_empty_type_set(cexp->type_names))
+					goto bad;
 			} else if (cexp->attr & CEXPR_ROLE) {
 				if (validate_ebitmap(&cexp->names, &flavors[SYM_ROLES]))
 					goto bad;
+				if (validate_empty_type_set(cexp->type_names))
+					goto bad;
 			} else if (cexp->attr & CEXPR_TYPE) {
 				if (validate_ebitmap(&cexp->names, &flavors[SYM_TYPES]))
 					goto bad;
 				if (validate_type_set(cexp->type_names, &flavors[SYM_TYPES]))
 					goto bad;
+			} else {
+				if (!ebitmap_is_empty(&cexp->names))
+					goto bad;
+				if (validate_empty_type_set(cexp->type_names))
+					goto bad;
 			}
 
 			if (cexp->expr_type == CEXPR_ATTR || cexp->expr_type == CEXPR_NAMES) {
@@ -236,6 +265,12 @@ static int validate_constraint_nodes(sepol_handle_t *handle, constraint_node_t *
 				default:
 					goto bad;
 				}
+
+				if (cexp->op != 0)
+					goto bad;
+
+				if (cexp->attr != 0)
+					goto bad;
 			}
 		}
 	}
@@ -251,11 +286,11 @@ static int validate_class_datum(sepol_handle_t *handle, class_datum_t *class, va
 {
 	if (validate_value(class->s.value, &flavors[SYM_CLASSES]))
 		goto bad;
-	if (validate_constraint_nodes(handle, class->constraints, flavors))
+	if (class->permissions.nprim > PERM_SYMTAB_SIZE)
 		goto bad;
-	if (validate_constraint_nodes(handle, class->validatetrans, flavors))
+	if (validate_constraint_nodes(handle, class->permissions.nprim, class->constraints, flavors))
 		goto bad;
-	if (class->permissions.nprim > PERM_SYMTAB_SIZE)
+	if (validate_constraint_nodes(handle, 0, class->validatetrans, flavors))
 		goto bad;
 
 	switch (class->default_user) {
-- 
2.34.1

