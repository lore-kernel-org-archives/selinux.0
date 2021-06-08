Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47027C47082
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 19:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32C0C61287
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 19:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbhFHTpD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jun 2021 15:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238842AbhFHTpA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Jun 2021 15:45:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D931C061144
        for <selinux@vger.kernel.org>; Tue,  8 Jun 2021 12:39:11 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r11so25829567edt.13
        for <selinux@vger.kernel.org>; Tue, 08 Jun 2021 12:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MeJtOttEGbvkXRUnuqX9sYb7oWRBE07e1sYTOqWSDYI=;
        b=dsGUySTuL9u9Su3DYZY6cqPZd56pGt167gVqIsKb9MnJ4TOxyo/UiFoLcbAbuN7dFq
         jPxC64GOdPbHBCSSGBBgI0T+GwLen0j/7871sXrf8Hu7DaW/njFGzk7x4zm3H/jLIrHa
         ItaF3LWqKeT+zivodM93QqF97JSy1sdxr5mkVbyl3CgYmNnBXcEAZocV6eptkioF8Xk5
         q5uW1c9Ifg0XWIHLxbVzug4qikdbcKDslEytkzLYbtJXutDujWyEBF3aw0duf36l/mmq
         BTce+pBo1Q2D717ZG4O1y/FoyIndKbtecad6UyHxLwLJqlJzQgF02VRaHYb2M0aJilPO
         Ecpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MeJtOttEGbvkXRUnuqX9sYb7oWRBE07e1sYTOqWSDYI=;
        b=UivCnq4rCkBILubGh0IQhM+qhBHsivWL4oKgVldBRG5F9ZczX8hvBYSqvlbqirdEBG
         NlSrgQjLTjn4qjqi8aRJSWJ/rbhPL9t4Kmi5gaavpFnSEW11q6WDCfkHqx13LNfW3Gni
         sQkfcl4Z2X2+/EIyDbsNWDnO1yARksgflXFGl5kSmyhR3RQEk3vDfI60AtVMX9j3XZ4S
         CJrlUWplQp3zt+0YPUj0WXC1BxqUuQIFeQtRtl8DQm6hM7LaLMcvas5kC7zc/m473EPq
         uvC+oGtFsviHMHHDByKhOR84vMzbxqz0VAKjpsQp1iJk+2C9ephyYY4KdHaISmxglvzs
         Ayfg==
X-Gm-Message-State: AOAM533iADuqOn/gTzlcK0d+qUsDhVVOChwzCtjUpuuqKgcF7KEy7aRo
        wj8iE+XRmXPl+UQ9XPp7EwvXRTU2FrE=
X-Google-Smtp-Source: ABdhPJxJ3LzRpXXoFNm3/MQ5QjkRcvTmbI88rHiJFi6ZJlceH/bZxL8q06km1CvHORaSjjbt5kJH4Q==
X-Received: by 2002:a50:9b06:: with SMTP id o6mr27445354edi.284.1623181149721;
        Tue, 08 Jun 2021 12:39:09 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-183-231.95.112.pool.telefonica.de. [95.112.183.231])
        by smtp.gmail.com with ESMTPSA id v23sm262560eds.25.2021.06.08.12.39.09
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 12:39:09 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: quote paths in CIL conversion
Date:   Tue,  8 Jun 2021 21:39:02 +0200
Message-Id: <20210608193902.55060-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When generating CIL policy from kernel or module policy quote paths,
which are allowed to contain spaces, in the statements `genfscon` and
`devicetreecon`.

Reported by LuK1337 while building policy for Android via IRC.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_cil.c | 4 ++--
 libsepol/src/module_to_cil.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 989aacde..30a27bf5 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -2654,7 +2654,7 @@ static int write_genfscon_rules_to_cil(FILE *out, struct policydb *pdb)
 				goto exit;
 			}
 
-			rc = strs_create_and_add(strs, "(genfscon %s %s %s)", 3,
+			rc = strs_create_and_add(strs, "(genfscon %s \"%s\" %s)", 3,
 						 fstype, name, ctx);
 			free(ctx);
 			if (rc != 0) {
@@ -3115,7 +3115,7 @@ static int write_xen_devicetree_rules_to_cil(FILE *out, struct policydb *pdb)
 			goto exit;
 		}
 
-		sepol_printf(out, "(devicetreecon %s %s)\n", name, ctx);
+		sepol_printf(out, "(devicetreecon \"%s\" %s)\n", name, ctx);
 
 		free(ctx);
 	}
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 496693f4..19c7c65c 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2963,7 +2963,7 @@ static int genfscon_to_cil(struct policydb *pdb)
 
 	for (genfs = pdb->genfs; genfs != NULL; genfs = genfs->next) {
 		for (ocon = genfs->head; ocon != NULL; ocon = ocon->next) {
-			cil_printf("(genfscon %s %s ", genfs->fstype, ocon->u.name);
+			cil_printf("(genfscon %s \"%s\" ", genfs->fstype, ocon->u.name);
 			context_to_cil(pdb, &ocon->context[0]);
 			cil_printf(")\n");
 		}
-- 
2.32.0

