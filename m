Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA7AE82CC9
	for <selinux@archiver.kernel.org>; Wed, 27 Sep 2023 19:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjI0TAj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjI0TAh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Sep 2023 15:00:37 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D17DD
        for <selinux@vger.kernel.org>; Wed, 27 Sep 2023 12:00:35 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4195035800fso25277061cf.3
        for <selinux@vger.kernel.org>; Wed, 27 Sep 2023 12:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695841234; x=1696446034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJO0m+8iKQxEZwtk6dxhpSYe+SeAY3A6m3DZ5W4ZgpI=;
        b=ZYzr/W9eDNOY94G2kxXLTRbawGDJL9h95S4EaGp4GG9Gj4xpbvJjbE4l1+r704FrRf
         qiiLpVqdyTNKuNv+ehUNwBN+OSwYOa1wEva+X2OHXVr9qUdSCr/Qv9AvwgSToaEffeoX
         xWfqauQ3HqsLBveAmSqlyv9cYfucCEYTtOXBqCTuL+uaAltkoqSbd2SVYyyLc0+3lNJI
         oHhuetz5gcyGU3qaB8kkonR/wtWVsOscK1rVuKAA5ZgPB8dcS3MeTG43t2rXvEiiuc2z
         95ONNYaJCJUAKd+rLf4xqhP9s/mhGHah0fBD8HL9NqAYw6OxDR0s+1kcs4nietHHS9FT
         nEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695841234; x=1696446034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJO0m+8iKQxEZwtk6dxhpSYe+SeAY3A6m3DZ5W4ZgpI=;
        b=anWsTedMP7M4Ah3d7mPlzfp0I4YH2PRI9LnqRFi4OD0Nx8Pp0ibRI4K2SxRX97EoLL
         hTKOBZ0CyTxvTa3WqKKk0909mBNcKMKmwEXqL06DyIN0QdLIZXH7Pmf60Cqm6Vb6yDBw
         oWV9qB0LoVcl1o6/p1RySsDS2mjtIGMsjvGNMzSRT2oJVqnIQ4zCXFsBEaRuDBWc8Ciz
         1SVoy6kD5skngx2QS7znnA2YqvL8Anf2UWMqO774kTducCEtff1XpEwRgk+DbSiYxxU1
         U+pkYekMYjnvv9iwcbe213MtdaBrOj0XFqaXxJv3UmPGKbI5eKHPPqTJh0tHmzL6b+2V
         KQhQ==
X-Gm-Message-State: AOJu0YyeScJZrtl5Wbqqpv8D2Aqn6Izdh1JzhyGTKYzJh8X3LGiIbpvc
        rxUMgJRtzvH7slSA+ejajrrUfPbFNAc=
X-Google-Smtp-Source: AGHT+IGaWLr88tcXEBR5RATqgCFsjPy3uRf4YP4hhdy32OkTslEXfvy5jAT4PPwGx594usnmxvsJ4A==
X-Received: by 2002:a05:622a:cc:b0:419:5bd1:6533 with SMTP id p12-20020a05622a00cc00b004195bd16533mr3717161qtw.36.1695841233945;
        Wed, 27 Sep 2023 12:00:33 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id fp6-20020a05622a508600b004181aa90b46sm2415167qtb.89.2023.09.27.12.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:00:33 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 9/9] libsepol/cil: Give warning for name that has different flavor
Date:   Wed, 27 Sep 2023 15:00:21 -0400
Message-ID: <20230927190021.1164278-10-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927190021.1164278-1-jwcart2@gmail.com>
References: <20230927190021.1164278-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

While still giving an error if there is a declaration with the
same flavor and name as a macro parameter, now give a warning in
the case where there is a declaration with the same name as a
macro parameter, but with a different flavor.

Example/
  (macro m1 ((string ARG1))
    (type ARG1)
    (allow ARG1 ARG1 (CLASS (PERM)))
    (typetransition t1a t1b CLASS ARG1 t1c)
  )
  (call m1 (foo))

  This will result in the following equivalent code:
  (type ARG1)
  (allow ARG1 ARG1 (CLASS (PERM)))
  (typetransition t1a t1b CLASS "foo" t1c)

  With the warning (if using "-v"), "Declaration of type ARG1 has
  same name as a macro parameter with a different flavor"

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_verify.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 45bf4689..0c6d50a1 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -405,10 +405,12 @@ int cil_verify_decl_does_not_shadow_macro_parameter(struct cil_macro *macro, str
 	if (param_list != NULL) {
 		cil_list_for_each(item, param_list) {
 			struct cil_param *param = item->data;
-			if (param->flavor == node->flavor) {
-				if (param->str == name) {
-					cil_log(CIL_ERR, "%s %s shadows a macro parameter in macro declaration\n", cil_node_to_string(node), name);
+			if (param->str == name) {
+				if (param->flavor == node->flavor) {
+					cil_log(CIL_ERR, "Declaration of %s %s shadows a macro parameter with the same flavor\n", cil_node_to_string(node), name);
 					return SEPOL_ERR;
+				} else {
+					cil_log(CIL_WARN, "Declaration of %s %s has same name as a macro parameter with a different flavor\n", cil_node_to_string(node), name);
 				}
 			}
 		}
-- 
2.41.0

