Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8ADEB64DC
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 18:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjGRStb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 14:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjGRSt3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 14:49:29 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7341710A
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 11:49:28 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fbc0314a7bso9935331e87.2
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 11:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689706167; x=1692298167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+u7giXfaMwciqklgaEuK1kZB1bo2xsdZNzX5RIc2iC0=;
        b=rSh9Wn5+2lpQUjKxRb/GjsXrhA6M2tlBFUDSJ7bRpu0XdpLvFC7HiZHW9H87NQq0G6
         ECjjtUlfS+LufYkfgj5mk3+WRM4TPKdSaOFs0Z6c6F3o2ZxK6Jtcs1Zlu7GxCUnbhNK/
         mvcrQcWFRD4w4Yug2e9irYKGtsDyCJT3gRxwN56YSrsSPegDsHadsdkd8FydSTFKAIf0
         DxW43sPy1Qp60WgoZJuhe7wcJDzx7E7iHuVLjlMxWfE7IRC0476aQ4WQx3/xB1+zdgPF
         zlXzfY7shmqo0J/HroPo3qxmzgpmW90B3HK+aPsX9o2YO/BobxP8eIDVebNFYXcAfBe4
         cpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689706167; x=1692298167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+u7giXfaMwciqklgaEuK1kZB1bo2xsdZNzX5RIc2iC0=;
        b=eHBsVYuH8NW2ymyY1iCOE3doDsISK2qFwA7/BJllAMamIeuHwqimRZBkby51jBdEnn
         QVVR2qCRsNuRIamlmr87TjOmsu7HVzpaQYaxIkj8EeQ8p8OxITVSIif3/2PPu/8L/CZr
         VJXtF3zqb+MkOxZ1a0TomHmHJG3aQPWDJRXWttY70NdG3XolONKHdwMwfBBmc64IQUbv
         M4Lzjj33n57z/SuairyKeausmJmS7uUhjVBBbGzmoine9EMoWpA0viI7w/CAV4vSA4Ae
         1AJDv1vT5LatXRFPJw9hQv7EPg7P6USQcZICNbOAXYufLQo4G91xG/Yls/jMhQDxmYnI
         1ptg==
X-Gm-Message-State: ABy/qLb4RTtX4CFRaaC93xRPWo4f4zuQZejuIQQcAgzwuZJ25tayE45+
        0P8xcTZmuZH350xMfukGkUdqbTJq0vHAGA==
X-Google-Smtp-Source: APBJJlHUqpWFqj/8imJ+cxDeCrV4+wiZC0Qls9fMFKNWtcqAh1v0eghVFwfIhQtuU9ke5kHjkHc8AA==
X-Received: by 2002:a05:6512:3b1f:b0:4f7:6775:2a66 with SMTP id f31-20020a0565123b1f00b004f767752a66mr12903546lfv.53.1689706166330;
        Tue, 18 Jul 2023 11:49:26 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-119-136-221.95.119.pool.telefonica.de. [95.119.136.221])
        by smtp.gmail.com with ESMTPSA id c17-20020a056402121100b0051e1660a34esm1603758edw.51.2023.07.18.11.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 11:49:25 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>
Subject: [PATCH 1/3] selinux: introduce SECURITY_SELINUX_DEBUG configuration
Date:   Tue, 18 Jul 2023 20:49:19 +0200
Message-Id: <20230718184921.112786-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The policy database code contains several debug output statements
related to hashtable utilization.  Those are guarded by the macro
DEBUG_HASHES, which is neither documented nor set anywhere.

Introduce a new Kconfig configuration guarding this and potential
other future debugging related code.  Disable the setting by default.

Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
This already uses the de-branded naming scheme, as proposed by
Stephen.
---
 security/selinux/Kconfig       | 9 +++++++++
 security/selinux/ss/policydb.c | 8 ++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 95a186ec0fcb..9e5be5cc6215 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -68,3 +68,12 @@ config SECURITY_SELINUX_SID2STR_CACHE_SIZE
 	  conversion.  Setting this option to 0 disables the cache completely.
 
 	  If unsure, keep the default value.
+
+config SECURITY_SELINUX_DEBUG
+	bool "SELinux kernel debugging support"
+	depends on SECURITY_SELINUX
+	default n
+	help
+	  This enables debugging code designed to help SELinux kernel developers,
+	  unless you know what this does in the kernel code you should leave this
+	  disabled.
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index cfe77ef24ee2..cc478f3f4778 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -41,7 +41,7 @@
 #include "mls.h"
 #include "services.h"
 
-#ifdef DEBUG_HASHES
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG
 static const char *const symtab_name[SYM_NUM] = {
 	"common prefixes",
 	"classes",
@@ -678,7 +678,7 @@ static int (*const index_f[SYM_NUM]) (void *key, void *datum, void *datap) = {
 	cat_index,
 };
 
-#ifdef DEBUG_HASHES
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG
 static void hash_eval(struct hashtab *h, const char *hash_name)
 {
 	struct hashtab_info info;
@@ -701,7 +701,7 @@ static void symtab_hash_eval(struct symtab *s)
 static inline void hash_eval(struct hashtab *h, const char *hash_name)
 {
 }
-#endif
+#endif /* CONFIG_SECURITY_SELINUX_DEBUG */
 
 /*
  * Define the other val_to_name and val_to_struct arrays
@@ -725,7 +725,7 @@ static int policydb_index(struct policydb *p)
 	pr_debug("SELinux:  %d classes, %d rules\n",
 		 p->p_classes.nprim, p->te_avtab.nel);
 
-#ifdef DEBUG_HASHES
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG
 	avtab_hash_eval(&p->te_avtab, "rules");
 	symtab_hash_eval(p->symtab);
 #endif
-- 
2.40.1

