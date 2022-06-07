Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C38ECCA47C
	for <selinux@archiver.kernel.org>; Tue,  7 Jun 2022 18:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348412AbiFGSCo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jun 2022 14:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350112AbiFGSAp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jun 2022 14:00:45 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9167A14A277
        for <selinux@vger.kernel.org>; Tue,  7 Jun 2022 10:42:39 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w27so23910000edl.7
        for <selinux@vger.kernel.org>; Tue, 07 Jun 2022 10:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7RprGD3soSy15qJKhHDNPOfEjD7FiVem1qNpjraJSgU=;
        b=odGBmlSnXn4h1N1JjgYe19mypHda+jIqPffyu5zsVoGysjkJxbDdCLJh8PMpQbgPAg
         py76kM5sZNPbDVyciRX9Xv0/tV/4gOErbuMazvbHvJQ0N3Aqx/rafDROJ/Tke0ShQHJu
         wi4qwQj2RKgahTkQlGN51HVfd2V+PewPxNQmO2U+Ru40D7cy/AY4619erHpGNOGSJKOg
         //g3kbplQ0xctMnpPyhh3Q0JTJUrZESDpIJNv0C6kWuvFiMWfLVKz0VbPkwPvUIpNIGg
         T5INn6ERpwM5vVEd8XXwxsQL0pnIIViS3ITYOa3a59ZjX/4QnMQqVVf8D27s48NCdm+v
         aRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7RprGD3soSy15qJKhHDNPOfEjD7FiVem1qNpjraJSgU=;
        b=ZH0uJvqRKs3cG+MSdI0bjsl10A03nQSyRSC94OD1aLtUreqh+Ht5YFjQ+HsyF+vN2p
         T8EDY3Cl4qMSej6mfLDMzdG1srW4vuZ73zbTOK75Dyip+wg6rdEgTqDDbSq2sjTu1an4
         05LBjVv5UKAjEYo10BPl0FT9l37rs4Fb3AfqPQc8Ks3sjwmhLJhvGTYMqEM0qzcbv2UQ
         HcaZK+VN/lEW8BlBpmNt7idTSp/aVRvFmUo/f6oNxmbZ+7cknsV2S7Fx88laMAsiNExc
         p5uByUbuyhM2Bj8KfZQ6MpGGiKoQ7+wN2dhXYG8oMJY31YyzaXcbQEq75LSpizdfj5y0
         jcsQ==
X-Gm-Message-State: AOAM531z3fPuzzU9CpN/w7GXIPm7eXwiL2TFgJCqj0cndPHp20uHzgLg
        OuzTVu8fvr8FQk7t3b7Qn63o0YomvsU=
X-Google-Smtp-Source: ABdhPJyG/REZOaF9BxyfNdW6sUxM1pzjt6BI69bgc/BmwMa4vGADrhD90fG0VbatPBVnYDL2NLIPkw==
X-Received: by 2002:a05:6402:14c1:b0:42d:d6f1:ac3d with SMTP id f1-20020a05640214c100b0042dd6f1ac3dmr34259848edx.223.1654623757322;
        Tue, 07 Jun 2022 10:42:37 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-054-039.77.8.pool.telefonica.de. [77.8.54.39])
        by smtp.gmail.com with ESMTPSA id o9-20020a170906600900b006fec8e5b8a9sm7962591ejj.152.2022.06.07.10.42.36
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 10:42:36 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 2/3] libsepol: validate initial SIDs
Date:   Tue,  7 Jun 2022 19:41:44 +0200
Message-Id: <20220607174145.51330-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607174145.51330-1-cgzones@googlemail.com>
References: <20220607174145.51330-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index da18282b..fcd3154a 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1,6 +1,7 @@
 
 #include <sepol/policydb/conditional.h>
 #include <sepol/policydb/ebitmap.h>
+#include <sepol/policydb/initialsids.h>
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/services.h>
 
@@ -1041,6 +1042,10 @@ static int validate_ocontexts(sepol_handle_t *handle, policydb_t *p, validate_t
 
 			if (p->target_platform == SEPOL_TARGET_SELINUX) {
 				switch (i) {
+				case OCON_ISID:
+					if (octx->sid[0] < 1 || octx->sid[0] >= SELINUX_SID_SZ)
+						goto bad;
+					break;
 				case OCON_FS:
 				case OCON_NETIF:
 					if (validate_context(&octx->context[1], flavors, p->mls))
@@ -1057,6 +1062,14 @@ static int validate_ocontexts(sepol_handle_t *handle, policydb_t *p, validate_t
 					}
 				}
 			}
+			if (p->target_platform == SEPOL_TARGET_XEN) {
+				switch (i) {
+				case OCON_XEN_ISID:
+					if (octx->sid[0] < 1 || octx->sid[0] >= XEN_SID_SZ)
+						goto bad;
+					break;
+				}
+			}
 		}
 	}
 
-- 
2.36.1

