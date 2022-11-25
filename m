Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBAFC43217
	for <selinux@archiver.kernel.org>; Fri, 25 Nov 2022 15:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiKYPuE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Nov 2022 10:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiKYPuD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Nov 2022 10:50:03 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D0B47336
        for <selinux@vger.kernel.org>; Fri, 25 Nov 2022 07:50:01 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x102so6976034ede.0
        for <selinux@vger.kernel.org>; Fri, 25 Nov 2022 07:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVTuNFpHztIyORdD18oCfjqXBOolqRppRvl8UGbssPU=;
        b=UFpbcLxDXSEx0Trm/zFAQfj1evf9QCtSpbnSHVTUn4yWhA7WGgFGbHxhX5ojmM9mq2
         CFXkTQ35OwbuPFjivKGj5lTBB4aiOdiMh/UnQN3/8EZpg1YIeuFqVsn6JEGt3spwZl6m
         29JriqGrtAjnnbrPnUZOk4i5UL5tlk2sMfrt/1BErHDVX7vISYmLLCu14yc6obSsX2AH
         K6Bs0SyVmUVKcDWMOi6Gf4yQx1t/04Oe3zvtvP+QnL7esTewbyULnRrVU9upPohbumIo
         Yk7zjB1cwNmRHt4xQxA2nKpSFIznNxUUVMFT/7wOgmwZGsA31Zt16SL1xmsiNSWSpax3
         dj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVTuNFpHztIyORdD18oCfjqXBOolqRppRvl8UGbssPU=;
        b=cy1TIncYLHfCjn0+hp8TzVQfyiDkOb5akp9S8+rFFg0NrBsdWAQ9zpJ4mgVMrF9bdD
         FZ4HlRUIaHWJfD1wOFhMDpCF/49YJu2Qz/vJHehvG47D1o5/ROhPjsAJETllbf0vJOP1
         iy5b9K5zsDVDMHB3E1Gd6ihgnTrYGu+rVzPbF0cJWbPJT0rBMRlrfgfLkCp4yQkDFEpR
         F8A5fqyz/NCa74tBiQhTNo79I8OvV2nOlhsOMp0KDvGmnnT5Wp8tKwrWecgQVjybq2Es
         WbA0JGb9kQpqkkLnpULKKqwjBTaJAixXUuBfRCsuc9Gt5lIJju3K86yGKy6sj2JcSlNb
         A6HQ==
X-Gm-Message-State: ANoB5pnzoln6/SCx9WsAeRZ6mLsW6Ipiy8U5EjVLKQryxWYhsnHjgqwZ
        0kBKmaxlWWaqP+Rd6iWM8s70AyTF1wo=
X-Google-Smtp-Source: AA0mqf4djIo/hoIV6Mo8PP2sip1f9+7SbueeKbnWquZiPFvqohP7j8gJIB+nVs5hvc4Sdn2kkCbxFA==
X-Received: by 2002:aa7:dd45:0:b0:45a:3c66:b0e4 with SMTP id o5-20020aa7dd45000000b0045a3c66b0e4mr36524180edw.33.1669391400402;
        Fri, 25 Nov 2022 07:50:00 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-154-194.77.3.pool.telefonica.de. [77.3.154.194])
        by smtp.gmail.com with ESMTPSA id b14-20020a17090630ce00b0078df26efb7dsm1677136ejb.107.2022.11.25.07.49.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 07:50:00 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v4 3/6] checkpolicy: add not-self neverallow support
Date:   Fri, 25 Nov 2022 16:49:49 +0100
Message-Id: <20221125154952.20910-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125154952.20910-1-cgzones@googlemail.com>
References: <20221125154952.20910-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add support for using negated or complemented self in the target type of
neverallow rules.

Some Refpolicy examples:

    neverallow * ~self:{ capability cap_userns capability2 cap2_userns } *;
    neverallow domain { domain -self -dockerc_t }:dir create;
    # no violations

    neverallow domain { domain -dockerc_t }:file ~{ append read_file_perms write };

    libsepol.report_failure: neverallow on line 584 of policy/modules/kernel/kernel.te (or line 31357 of policy.conf) violated by allow sysadm_t httpd_bugzilla_script_t:file { create setattr relabelfrom relabelto unlink link rename };
    libsepol.report_failure: neverallow on line 584 of policy/modules/kernel/kernel.te (or line 31357 of policy.conf) violated by allow spc_t spc_t:file { create };
    libsepol.report_failure: neverallow on line 584 of policy/modules/kernel/kernel.te (or line 31357 of policy.conf) violated by allow container_t container_t:file { create };
    libsepol.report_failure: neverallow on line 584 of policy/modules/kernel/kernel.te (or line 31357 of policy.conf) violated by allow chromium_t chromium_t:file { create };
    libsepol.report_failure: neverallow on line 584 of policy/modules/kernel/kernel.te (or line 31357 of policy.conf) violated by allow spc_user_t spc_user_t:file { create };
    libsepol.report_failure: neverallow on line 582 of policy/modules/kernel/kernel.te (or line 31355 of policy.conf) violated by allow sysadm_t httpd_bugzilla_script_t:dir { create };

    neverallow domain { domain -self -dockerc_t }:file ~{ append read_file_perms write };

    libsepol.report_failure: neverallow on line 583 of policy/modules/kernel/kernel.te (or line 31356 of policy.conf) violated by allow sysadm_t httpd_bugzilla_script_t:file { create setattr relabelfrom relabelto unlink link rename };
    libsepol.report_failure: neverallow on line 582 of policy/modules/kernel/kernel.te (or line 31355 of policy.conf) violated by allow sysadm_t httpd_bugzilla_script_t:dir { create };

Using negated self in a complement, `~{ domain -self }`, is not
supported.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 46 ++++++++++++++++++++++++++++++++-----
 checkpolicy/test/dismod.c   |  6 ++++-
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 41e44631..74f882bb 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -2075,12 +2075,17 @@ static int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
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
+				yyerror("self and -self are mutual exclusive");
 				ret = -1;
 				goto out;
 			}
-			avrule->flags |= RULE_SELF;
 			continue;
 		}
 		if (set_types
@@ -2091,6 +2096,18 @@ static int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
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
@@ -2537,12 +2554,17 @@ static int define_te_avtab_helper(int which, avrule_t ** rule)
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
+				yyerror("self and -self are mutual exclusive");
 				ret = -1;
 				goto out;
 			}
-			avrule->flags |= RULE_SELF;
 			continue;
 		}
 		if (set_types
@@ -2553,6 +2575,18 @@ static int define_te_avtab_helper(int which, avrule_t ** rule)
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
2.38.1

