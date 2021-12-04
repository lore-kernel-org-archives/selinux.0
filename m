Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3779FC433EF
	for <selinux@archiver.kernel.org>; Sat,  4 Dec 2021 10:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbhLDKi6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 4 Dec 2021 05:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbhLDKi5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 4 Dec 2021 05:38:57 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90A7C061354
        for <selinux@vger.kernel.org>; Sat,  4 Dec 2021 02:35:31 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y12so21586997eda.12
        for <selinux@vger.kernel.org>; Sat, 04 Dec 2021 02:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gkNuQU9ms7EgFT+DKwpoPdhHGJZYoVyol9y2DeXm44k=;
        b=V5O8V9FuPrjEUPaS33aW1KHJ7p2qfzcRvEcldLhaVEPWVmRcUkUKT6CFsERbF0sT2s
         wk7I+uzFbgeBBaI//dWv6LmSoFqS781K2yaStEf/lTQnsgJbVXyd12+e9B8z3QqrHEMT
         J84DggH7ljBeOe9aRCjlEWBycA+6KTA0ntcjVWsV6U/HEr/WnhlV/WixkWM0W9r0pXop
         gicooqWIiO/JvEmA2FkRvLsupzjkQNEBOd0usd28nmSXkq3IuO+Rad9pPBAiBtOFMvPA
         mGb20MhqtVOrv5PcWWPwAe/uWNOwIlUgVjrRRsZTy7DhnUnpBBxajLU/CnyqneWtZUbT
         byYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gkNuQU9ms7EgFT+DKwpoPdhHGJZYoVyol9y2DeXm44k=;
        b=3EhoMzKoQ3id1zTkzFCWuJJK/6foJl2N5f4QQOy8rRgQRKjoIFu41hnbgWD2ck3FFP
         7exS6gYoQvgyQTVyxnxM31+n95rEvvTsbSYUd9IR/y9fhCLo/NV/9A0yefjpmzK3CmhH
         H+l+TimkyIsHZjy2VMqyn7NzumwH/UaSIlUFRc0/Ji3grMvPnHecTOQ60w2vj4386BWG
         Y54oaYawoVZacdq4yJOSI7wV5fZuPNpixxGYm8O3YVC4XGVK+CBm2xPv0awxkPfrANol
         yYJZrowGcWUec/0wKPCwHt5aaNi1FPYqKZFpKLjwBSC4Unm6WfKTAixAwe0aH8yJ01gj
         pnfg==
X-Gm-Message-State: AOAM533LHJ8gBMEjguk2KClfmWK4v7iTn8brhnTw685fAM/VZ2aBDSpx
        /NeMHwYm8N8CzySzTtwo+YTObNG2G+o=
X-Google-Smtp-Source: ABdhPJzC4qQHG+39XbXv0dfxkAWbitjmSIVb0x2eYlxdIh0R/geZjOrxLzqzbELIXK/brYm8tbT+PA==
X-Received: by 2002:a17:907:a426:: with SMTP id sg38mr30738654ejc.392.1638614129508;
        Sat, 04 Dec 2021 02:35:29 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-006-110-042.77.6.pool.telefonica.de. [77.6.110.42])
        by smtp.gmail.com with ESMTPSA id hc16sm3192756ejc.12.2021.12.04.02.35.29
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 02:35:29 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v3 3/5] checkpolicy: add not-self neverallow support
Date:   Sat,  4 Dec 2021 11:35:14 +0100
Message-Id: <20211204103516.17375-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211204103516.17375-1-cgzones@googlemail.com>
References: <20211124190815.12757-1-cgzones@googlemail.com>
 <20211204103516.17375-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add support for using negated or complemented self in the target type of
neverallow rules.

Some refpolicy examples:

    neverallow * ~self:{ capability cap_userns capability2 cap2_userns } *;
    # no violations

    neverallow domain domain:file ~{ append read_file_perms write };

    libsepol.report_failure: neverallow on line 565 of policy/modules/kernel/kernel.te (or line 30300 of policy.conf) violated by allow sysadm_t httpd_bugzilla_script_t:file { create setattr relabelfrom relabelto unlink link rename };
    libsepol.report_failure: neverallow on line 565 of policy/modules/kernel/kernel.te (or line 30300 of policy.conf) violated by allow chromium_t chromium_t:file { create };
    libsepol.report_failure: neverallow on line 564 of policy/modules/kernel/kernel.te (or line 30299 of policy.conf) violated by allow sysadm_t httpd_bugzilla_script_t:dir { create };

    neverallow domain { domain -self }:file ~{ append read_file_perms write };

    libsepol.report_failure: neverallow on line 565 of policy/modules/kernel/kernel.te (or line 30300 of policy.conf) violated by allow sysadm_t httpd_bugzilla_script_t:file { create setattr relabelfrom relabelto unlink link rename };
    libsepol.report_failure: neverallow on line 564 of policy/modules/kernel/kernel.te (or line 30299 of policy.conf) violated by allow sysadm_t httpd_bugzilla_script_t:dir { create };

Using negated self in a complement `~{ domain -self }` is not supported.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

---
v3:
   - mention both neverallow rule types when using -self within an
     unsupported rule type
v2:
   - fix neverallowxperm usage

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 46 ++++++++++++++++++++++++++++++++-----
 checkpolicy/test/dismod.c   |  6 ++++-
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index d3eb6111..e74b1a9a 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -2067,12 +2067,17 @@ static int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
 	while ((id = queue_remove(id_queue))) {
 		if (strcmp(id, "self") == 0) {
 			free(id);
-			if (add == 0) {
-				yyerror("-self is not supported");
+			if (add == 0 && which != AVRULE_XPERMS_NEVERALLOW) {
+				yyerror("-self is only supported in neverallow and neverallowxperm rules");
+				ret = -1;
+				goto out;
+			}
+			avrule->flags |= (add ? RULE_SELF : RULE_NOTSELF);
+			if ((avrule->flags & RULE_SELF) && (avrule->flags & RULE_NOTSELF)) {
+				yyerror("self and -self is not supported");
 				ret = -1;
 				goto out;
 			}
-			avrule->flags |= RULE_SELF;
 			continue;
 		}
 		if (set_types
@@ -2083,6 +2088,18 @@ static int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
 		}
 	}
 
+	if ((avrule->ttypes.flags & TYPE_COMP)) {
+		if (avrule->flags & RULE_NOTSELF) {
+			yyerror("-self is not supported in complements");
+			ret = -1;
+			goto out;
+		}
+		if (avrule->flags & RULE_SELF) {
+			avrule->flags &= ~RULE_SELF;
+			avrule->flags |= RULE_NOTSELF;
+		}
+	}
+
 	ebitmap_init(&tclasses);
 	ret = read_classes(&tclasses);
 	if (ret)
@@ -2528,12 +2545,17 @@ static int define_te_avtab_helper(int which, avrule_t ** rule)
 	while ((id = queue_remove(id_queue))) {
 		if (strcmp(id, "self") == 0) {
 			free(id);
-			if (add == 0) {
-				yyerror("-self is not supported");
+			if (add == 0 && which != AVRULE_NEVERALLOW) {
+				yyerror("-self is only supported in neverallow and neverallowxperm rules");
+				ret = -1;
+				goto out;
+			}
+			avrule->flags |= (add ? RULE_SELF : RULE_NOTSELF);
+			if ((avrule->flags & RULE_SELF) && (avrule->flags & RULE_NOTSELF)) {
+				yyerror("self and -self is not supported");
 				ret = -1;
 				goto out;
 			}
-			avrule->flags |= RULE_SELF;
 			continue;
 		}
 		if (set_types
@@ -2544,6 +2566,18 @@ static int define_te_avtab_helper(int which, avrule_t ** rule)
 		}
 	}
 
+	if ((avrule->ttypes.flags & TYPE_COMP)) {
+		if (avrule->flags & RULE_NOTSELF) {
+			yyerror("-self is not supported in complements");
+			ret = -1;
+			goto out;
+		}
+		if (avrule->flags & RULE_SELF) {
+			avrule->flags &= ~RULE_SELF;
+			avrule->flags |= RULE_NOTSELF;
+		}
+	}
+
 	ebitmap_init(&tclasses);
 	ret = read_classes(&tclasses);
 	if (ret)
diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index ec2a3e9a..a2d74d42 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -124,7 +124,7 @@ static int display_type_set(type_set_t * set, uint32_t flags, policydb_t * polic
 	}
 
 	num_types = 0;
-	if (flags & RULE_SELF) {
+	if (flags & (RULE_SELF | RULE_NOTSELF)) {
 		num_types++;
 	}
 
@@ -169,6 +169,10 @@ static int display_type_set(type_set_t * set, uint32_t flags, policydb_t * polic
 		fprintf(fp, " self");
 	}
 
+	if (flags & RULE_NOTSELF) {
+		fprintf(fp, " -self");
+	}
+
 	if (num_types > 1)
 		fprintf(fp, " }");
 
-- 
2.34.1

