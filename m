Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830D2C63777
	for <selinux@archiver.kernel.org>; Mon, 16 Nov 2020 22:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 338B5223BF
	for <selinux@archiver.kernel.org>; Mon, 16 Nov 2020 22:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T11iL6XV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgKPWHY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Nov 2020 17:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgKPWHY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Nov 2020 17:07:24 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A560C0613CF
        for <selinux@vger.kernel.org>; Mon, 16 Nov 2020 14:07:24 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id v143so18632575qkb.2
        for <selinux@vger.kernel.org>; Mon, 16 Nov 2020 14:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eJkMYichODDcRS+T2opQB0Cs8rhS7yzs4z9iIfOKdsw=;
        b=T11iL6XV6vECgZ8+kb8GxaO+ATyY4VWFwlRBHHKFUHJT7Ryw7n8ikJYUOMiDH0rgwP
         rKl7Sqw7TzvpFT0zj0HrPnq4jUFbawu16A21KJojMf0Ofhn/+H1R1a8Qv2nejeHmpBF7
         mJDy/+Ij1I/nHqMyibzp6ePSlnWMSZWp/f0O5fbrYX4KoPIJtMjPHkKIhwwBqbMbcU7B
         XyIbzS4TTe0EDUCIHiMCCuzIlgfbRQzstv26H3dMvV2KK9A6M9O7C62PmO7D6e626/+d
         +yWsMb73LXK2fNIZG3owMSRfVieO/tSM9uhq7uZ/QYY1IpRJdnqp/43hhWfgoOAxfOue
         nncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eJkMYichODDcRS+T2opQB0Cs8rhS7yzs4z9iIfOKdsw=;
        b=C5m1tL8T+icKcXVOzb9Q3RsQdsoRkB6WI0qnL2Y5LIj6Pbz5i3D7WDS/0YgAuCsb7s
         DaCx4Rc4B53JMIjuI7mB41cM1rMRWLQxR5V5+WDd0j9UYDAhSmgm6bt3yfq92CfExsUt
         68+MCg9dZDrQSFKvMhC38QBqYjTsmX6LFEuAmBIbBaChUqvUoagqKSeDPkN6s7a64pqA
         ucRoFsrux0p4ctbJB+0CNpEMe0hSgGv9tl5pkCMw+/05o+s90sWjFh4w/tBcPFJ8TCtk
         ymCNurmOfU8hbQcwlW7ibMyoVBjMiNgAJj2mP7MvAQ66Xe4LdrOiLtdocTbQ3CJzU8pB
         2ygA==
X-Gm-Message-State: AOAM5300VmAcOBQ3edisNkHlsVF34dPUWwmP4/KfWl4iOt3dM/2HXcro
        b/nhcEgYR5IHG8yJhROGk7iSGBzt7uw=
X-Google-Smtp-Source: ABdhPJzcHWQ26PX9FRdeAgosXjLh5WZfUrlJgnBQ2vAx1jwVpFFA16fNiGvN6zIAYMfF/GTfibqorQ==
X-Received: by 2002:a05:620a:148d:: with SMTP id w13mr15945025qkj.299.1605564443549;
        Mon, 16 Nov 2020 14:07:23 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id q11sm12653330qtp.47.2020.11.16.14.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 14:07:23 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 6/6] libspepol/cil: Use the macro FLAVOR() whenever possible
Date:   Mon, 16 Nov 2020 17:07:02 -0500
Message-Id: <20201116220702.174765-7-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201116220702.174765-1-jwcart2@gmail.com>
References: <20201116220702.174765-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In cil_symtab.h, the macro FLAVOR() is defined. It refers to the
flavor of the first node in the list of nodes that declare the datum.
(The flavors of every node should be the same.) While the macro was
used in many places, it was not used everywhere that it could be.

Change all the remaining places to use FLAVOR().

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_find.c        | 8 ++++----
 libsepol/cil/src/cil_post.c        | 2 +-
 libsepol/cil/src/cil_resolve_ast.c | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/libsepol/cil/src/cil_find.c b/libsepol/cil/src/cil_find.c
index c182406e..638b675d 100644
--- a/libsepol/cil/src/cil_find.c
+++ b/libsepol/cil/src/cil_find.c
@@ -44,8 +44,8 @@ struct cil_args_find {
 
 static int cil_type_match_any(struct cil_symtab_datum *d1, struct cil_symtab_datum *d2)
 {
-	enum cil_flavor f1 = ((struct cil_tree_node*)d1->nodes->head->data)->flavor;
-	enum cil_flavor f2 = ((struct cil_tree_node*)d2->nodes->head->data)->flavor;
+	enum cil_flavor f1 = FLAVOR(d1);
+	enum cil_flavor f2 = FLAVOR(d2);
 
 	if (f1 != CIL_TYPEATTRIBUTE && f2 != CIL_TYPEATTRIBUTE) {
 		struct cil_type *t1 = (struct cil_type *)d1;
@@ -81,8 +81,8 @@ static int cil_type_match_any(struct cil_symtab_datum *d1, struct cil_symtab_dat
 static int cil_type_matches(ebitmap_t *matches, struct cil_symtab_datum *d1, struct cil_symtab_datum *d2)
 {
 	int rc = SEPOL_OK;
-	enum cil_flavor f1 = ((struct cil_tree_node*)d1->nodes->head->data)->flavor;
-	enum cil_flavor f2 = ((struct cil_tree_node*)d2->nodes->head->data)->flavor;
+	enum cil_flavor f1 = FLAVOR(d1);
+	enum cil_flavor f2 = FLAVOR(d2);
 
 	if (f1 != CIL_TYPEATTRIBUTE && f2 != CIL_TYPEATTRIBUTE) {
 		struct cil_type *t1 = (struct cil_type *)d1;
diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index a0cadfde..37a44415 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -1482,7 +1482,7 @@ static void __mark_neverallow_attrs(struct cil_list *expr_list)
 
 	cil_list_for_each(curr, expr_list) {
 		if (curr->flavor == CIL_DATUM) {
-			if (NODE(curr->data)->flavor == CIL_TYPEATTRIBUTE) {
+			if (FLAVOR(curr->data) == CIL_TYPEATTRIBUTE) {
 				struct cil_typeattribute *attr = curr->data;
 				if (strstr(DATUM(attr)->name, TYPEATTR_INFIX)) {
 					__mark_neverallow_attrs(attr->expr_list);
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 060bc0d0..f6deb100 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -505,7 +505,7 @@ int cil_resolve_aliasactual(struct cil_tree_node *current, void *extra_args, enu
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
-	if (NODE(alias_datum)->flavor != alias_flavor) {
+	if (FLAVOR(alias_datum) != alias_flavor) {
 		cil_log(CIL_ERR, "%s is not an alias\n",alias_datum->name);
 		rc = SEPOL_ERR;
 		goto exit;
@@ -516,7 +516,7 @@ int cil_resolve_aliasactual(struct cil_tree_node *current, void *extra_args, enu
 		goto exit;
 	}
 
-	if (NODE(actual_datum)->flavor != flavor && NODE(actual_datum)->flavor != alias_flavor) {
+	if (FLAVOR(actual_datum) != flavor && FLAVOR(actual_datum) != alias_flavor) {
 		cil_log(CIL_ERR, "%s is a %s, but aliases a %s\n", alias_datum->name, cil_node_to_string(NODE(alias_datum)), cil_node_to_string(NODE(actual_datum)));
 		rc = SEPOL_ERR;
 		goto exit;
@@ -2573,7 +2573,7 @@ int cil_resolve_bounds(struct cil_tree_node *current, void *extra_args, enum cil
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
-	if (NODE(parent_datum)->flavor == attr_flavor) {
+	if (FLAVOR(parent_datum) == attr_flavor) {
 		cil_log(CIL_ERR, "Bounds parent %s is an attribute\n", bounds->parent_str);
 		rc = SEPOL_ERR;
 		goto exit;
@@ -2584,7 +2584,7 @@ int cil_resolve_bounds(struct cil_tree_node *current, void *extra_args, enum cil
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
-	if (NODE(child_datum)->flavor == attr_flavor) {
+	if (FLAVOR(child_datum) == attr_flavor) {
 		cil_log(CIL_ERR, "Bounds child %s is an attribute\n", bounds->child_str);
 		rc = SEPOL_ERR;
 		goto exit;
-- 
2.25.4

