Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45512C433FE
	for <selinux@archiver.kernel.org>; Wed, 24 Nov 2021 19:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbhKXTLi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Nov 2021 14:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350906AbhKXTLe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Nov 2021 14:11:34 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A487BC061574
        for <selinux@vger.kernel.org>; Wed, 24 Nov 2021 11:08:24 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x15so14924540edv.1
        for <selinux@vger.kernel.org>; Wed, 24 Nov 2021 11:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OSjelv+XERb3ttiEo/h/qavc/aMITk3pWcNy9/KGD+I=;
        b=pLS+nBk1eel++JAoMJnfeAPYSm90ym/sOKyqwTThGHemlaVJHH/Hwcz995ueDo8o9H
         7mReG3e14DsLJeloeUUFk7BNSIhvh9Ws4zbCHlFu+DoIoyGt/+t20lp6CMXspuYt8N4t
         H9/1EXWfgko51j8sVEMNSSQMvYfaOPwDDuE1sV/TajHnIn9bvfb12q2GsrAmd6UcJiXl
         KJK8+v/LDaSHfa9zBtDFgXWzvFknnbake0mjjS1otyztqTa5aaNJXgE1q1fdwjAkKV/z
         8HDRK3zIp625/mRGridrVFB4cFdYOlu5uJc/t8fz+mUrR3+JCD/xRKlQsiBdHHS53NZM
         HRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OSjelv+XERb3ttiEo/h/qavc/aMITk3pWcNy9/KGD+I=;
        b=5fupBUUOpBFrO+3oDOlvrIQX6Cx7lWuc3Y2Hyv1tr05IiGZ6HzisuzoMQ9CXw2Q/2b
         Zix0KBVXX2c8CzqEu4WCYKE9Su1w5T0na0KJiA9wgRa2E+w4e7864tAp0+0Tp4qUJ7lo
         xOD3fsQ7VEZpt5LbOGFb2ue8xUThhAZ8L32DHkCwKH4YycfpltoLYIM5jzTsR42vO060
         WZqBRPChnjvsKwPvhUrH9DEHySc3yZRLtFCw0xydCMpEc1c/UJ0Kx7hotK0dTaSviZC4
         Yf9lTgE8ATkRmEHbxb13GCOieXjUkmL1h0ROL/QRtFbTc05gB4Hb1dt8MO0wOw5pKNv3
         ZX3g==
X-Gm-Message-State: AOAM5304Ou23xNJv+n3xVG8BSuss+N+OD3ly+lDrSq07n0CZ0xGbRjuB
        3nxbcrWZcKkism+KcwOAZiVPadzgpNh/Wg==
X-Google-Smtp-Source: ABdhPJzNA/tAM+zW1Z0kxXRdZOiNbyVLKegX1toqjiqfWTG1wEP207D/s3Xo67icWh0DvayFr89fcw==
X-Received: by 2002:a17:907:b17:: with SMTP id h23mr23683177ejl.80.1637780903117;
        Wed, 24 Nov 2021 11:08:23 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-008-186-056.77.8.pool.telefonica.de. [77.8.186.56])
        by smtp.gmail.com with ESMTPSA id p3sm339256ejy.94.2021.11.24.11.08.22
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 11:08:22 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 3/4] checkpolicy: add not-self neverallow support
Date:   Wed, 24 Nov 2021 20:08:14 +0100
Message-Id: <20211124190815.12757-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211124190815.12757-1-cgzones@googlemail.com>
References: <20211123190704.14341-1-cgzones@googlemail.com>
 <20211124190815.12757-1-cgzones@googlemail.com>
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
v2:
   - fix neverallowxperm usage
---
 checkpolicy/policy_define.c | 46 ++++++++++++++++++++++++++++++++-----
 checkpolicy/test/dismod.c   |  6 ++++-
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index d3eb6111..f27a6f33 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -2067,12 +2067,17 @@ static int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
 	while ((id = queue_remove(id_queue))) {
 		if (strcmp(id, "self") == 0) {
 			free(id);
-			if (add == 0) {
-				yyerror("-self is not supported");
+			if (add == 0 && which != AVRULE_XPERMS_NEVERALLOW) {
+				yyerror("-self is only supported in neverallowxperm rules");
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
+				yyerror("-self is only supported in neverallow rules");
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
2.34.0

