Return-Path: <SRS0=GWJJ=7B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECC3C433DF
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 14:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD46120709
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 14:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iq+7vor9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgESOaE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 May 2020 10:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgESOaE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 May 2020 10:30:04 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BD3C08C5C0
        for <selinux@vger.kernel.org>; Tue, 19 May 2020 07:30:04 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c24so11258348qtw.7
        for <selinux@vger.kernel.org>; Tue, 19 May 2020 07:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4/jnLRDV7cIbH5p2/ejzWRBKLH1W6lQ70OInwAnaOsY=;
        b=Iq+7vor9oKWCFbPRZDZlMe7kOL6ZRhZEzOVmdHaUXov+fjdDxBny6nWRS6tb9s6R/t
         sKnwZrHo6FPqeYPcFYTjX71BMloID48Y3Pcx0l+f8/1zsPnz8sUYzTHOzM9EUplSEUU3
         8Ds68YFDA5c05YZn+CvU3FeHieZ57V8iAL0kG7+LdZnaG8sn7EGEoslPE0DSxxXr0hEz
         Kbk2UvzgA3v5a1mfkrNA60muQQFrWvRHc6dT94+FqihNpQMhHKnCpDrPrDGpYbvvsAAg
         duOl20tJCgWVEiCAE4u0pfoacuflFHnQFLsHqpS3zYvCEyHgZ5MsmP5+gQOz3UemKhrO
         XqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4/jnLRDV7cIbH5p2/ejzWRBKLH1W6lQ70OInwAnaOsY=;
        b=doiE0xT45/jjRdp7MM91nOcVM64SGOaIMfvWyW+dvbB9GlT/C9/vMIMnv9v4ICYmkN
         Sa0lNKU3Ss2UsA2ozrRsogsb48goZFw9mglbWsCsAp5gF3HL8J0H2QRvFGhy79pID+WF
         66daLVS8JUrcDu7j5PtnIT4y7JePLCWz2cczFQUVvkifh6rSSQOnMu7fbwwVC/y2tJSG
         bluG3g83JOpJx8hSL3QSQn0hNf/iqcz0O0MU44Gh3wYK1I+UbXTiLwotiq0OBizCSSXc
         SAsXNiz9opfWjMoGJ1dw4y4ZTnGGArYzuCBI3WkUFrGPUTDTnUgDR//WPlrNqpCoz6H+
         t/tA==
X-Gm-Message-State: AOAM530ss0xswexYNg3utSyg1TkkR+uwVT2AJ4WtJuh1Aa+wGdJ+sRe4
        e1Uu40FxQwMP8oq7LN3ewM19GU5BdQ4=
X-Google-Smtp-Source: ABdhPJy+hjwA6Qpp5o/Ionnhf6LwjxzeSrCQ7EsrSFsQTM96UGzB8vVmfur9lrSslIHYIpfPpRAHtg==
X-Received: by 2002:ac8:c8b:: with SMTP id n11mr23147490qti.49.1589898602919;
        Tue, 19 May 2020 07:30:02 -0700 (PDT)
Received: from localhost.localdomain (pool-71-166-99-106.bltmmd.east.verizon.net. [71.166.99.106])
        by smtp.gmail.com with ESMTPSA id i41sm12693724qte.15.2020.05.19.07.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 07:30:02 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH v2 2/2] libsepol/cil: Return error when identifier declared as both type and attribute
Date:   Tue, 19 May 2020 10:29:46 -0400
Message-Id: <20200519142946.76861-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200519142946.76861-1-jwcart2@gmail.com>
References: <20200519142946.76861-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

CIL allows a type to be redeclared when using the multiple declarations
option ("-m" or "--muliple-decls"), but make it an error for an identifier
to be declared as both a type and an attribute.

Change the error message so that it always gives the location and flavor
of both declarations. The flavors will be the same in all other cases,
but in this case they explain why there is an error even if multiple
declartions are allowed.

Issue reported by: Topi Miettinen <toiwoton@gmail.com>

Fixes: Commit fafe4c212bf6c32c ("libsepol: cil: Add ability to redeclare
       types[attributes]")

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index fcecdc4f..ce2499a1 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -87,7 +87,7 @@ exit:
  * datum, given the new datum and the one already present in a given symtab.
  */
 int cil_is_datum_multiple_decl(__attribute__((unused)) struct cil_symtab_datum *cur,
-                               __attribute__((unused)) struct cil_symtab_datum *old,
+                               struct cil_symtab_datum *old,
                                enum cil_flavor f)
 {
 	int rc = CIL_FALSE;
@@ -95,8 +95,12 @@ int cil_is_datum_multiple_decl(__attribute__((unused)) struct cil_symtab_datum *
 	switch (f) {
 	case CIL_TYPE:
 	case CIL_TYPEATTRIBUTE:
-		/* type and typeattribute statements insert empty datums, ret true */
-		rc = CIL_TRUE;
+		if (!old || f != FLAVOR(old)) {
+			rc = CIL_FALSE;
+		} else {
+			/* type and typeattribute statements insert empty datums */
+			rc = CIL_TRUE;
+		}
 		break;
 	default:
 		break;
@@ -126,19 +130,20 @@ int cil_gen_node(struct cil_db *db, struct cil_tree_node *ast_node, struct cil_s
 	if (symtab != NULL) {
 		rc = cil_symtab_insert(symtab, (hashtab_key_t)key, datum, ast_node);
 		if (rc == SEPOL_EEXIST) {
+			rc = cil_symtab_get_datum(symtab, (hashtab_key_t)key, &prev);
+			if (rc != SEPOL_OK) {
+				cil_log(CIL_ERR, "Re-declaration of %s %s, but previous declaration could not be found\n",cil_node_to_string(ast_node), key);
+				goto exit;
+			}
 			if (!db->multiple_decls ||
-			    cil_symtab_get_datum(symtab, (hashtab_key_t)key, &prev) != SEPOL_OK ||
 			    !cil_is_datum_multiple_decl(datum, prev, nflavor)) {
-
 				/* multiple_decls not ok, ret error */
+				struct cil_tree_node *node = NODE(prev);
 				cil_log(CIL_ERR, "Re-declaration of %s %s\n",
 					cil_node_to_string(ast_node), key);
-				if (cil_symtab_get_datum(symtab, key, &datum) == SEPOL_OK) {
-					if (sflavor == CIL_SYM_BLOCKS) {
-						struct cil_tree_node *node = datum->nodes->head->data;
-						cil_tree_log(node, CIL_ERR, "Previous declaration");
-					}
-				}
+				cil_tree_log(node, CIL_ERR, "Previous declaration of %s",
+					cil_node_to_string(node));
+				rc = SEPOL_ERR;
 				goto exit;
 			}
 			/* multiple_decls is enabled and works for this datum type, add node */
@@ -169,7 +174,7 @@ int cil_gen_node(struct cil_db *db, struct cil_tree_node *ast_node, struct cil_s
 	return SEPOL_OK;
 
 exit:
-	cil_log(CIL_ERR, "Failed to create node\n");
+	cil_log(CIL_INFO, "Failed to create node\n");
 	return rc;
 }
 
-- 
2.25.4

