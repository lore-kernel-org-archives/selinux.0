Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D06C4332F
	for <selinux@archiver.kernel.org>; Tue, 23 Nov 2021 19:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhKWTKZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 14:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbhKWTKZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 14:10:25 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD06C061574
        for <selinux@vger.kernel.org>; Tue, 23 Nov 2021 11:07:17 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id l25so79495845eda.11
        for <selinux@vger.kernel.org>; Tue, 23 Nov 2021 11:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cKw3WPbPPuIF/Kj5aGah+9PPq5SwBakWIoDCIzkUXHU=;
        b=Y5OkN+/mVAaPmeTxy+gFhZV6VMjg1kqubhJn7+1KXaem8wllCFtwqfhWlYluT24TAo
         UUmVh9FP748jP+J/Y3+P+A8mGjGmWYMpLle5m5ujuZb1DyNRFt6vDHwv5rPv5EKDf3LA
         0WHXsWRj5n/oA5U01U/Xm9Mw+otHHAGlsxYHwJOJmV2HhCc+M8lU0jK2S30bncqbsBFt
         uA6cnLdpR5r4zbd27PNvb5fj4Se2aSD7qKJfO4HCVGLIf/dCg1Uyp3HMPuC4trHSxlJr
         0cWSF4CjHeclPJdUE6ncYQ6lRtQe/qkgNCAZ06IDnKf311TIGVJWEyIOG4tFGleZY9so
         o0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cKw3WPbPPuIF/Kj5aGah+9PPq5SwBakWIoDCIzkUXHU=;
        b=NZ07ED2W2+rj2Ts6vsEPZocDPfuMIvcN2EX6Bd7TAMv4URw3KuEoiPnj1oBZ0B0piG
         8IEHFnHPSL/x1gGP8QShMGV6w53/q6VI600bUz2ZkxyIbnsgVTR1m45aXjcnUG3LoPRr
         Ntpt+LwmZzGZIqkB395pkREGgdBAHaeBshBqcDUJx9Nu3YqrkO83q++6zhdw0P3Iexi3
         kLyzOpxK6kskzNztc05QS0eUCoHANMNLMR32fgWsUWdLvepLsd3NoC5tdYyVNLmP2UjR
         qz2oNb/PWTxNp6lns72RMEXRAKS3CTHrpMdv5fbGOdBgXC+jxg7JEfm6QG7YBJhO+Tza
         tfoQ==
X-Gm-Message-State: AOAM533FWvlcgwnM6YWBqmWRra07KpHDgGUaKrMedXGQp+85Bu/VvPNG
        E54aqlbUvke+GayqBy34WdaOsXbAKgc=
X-Google-Smtp-Source: ABdhPJx0ZnJXOcW+kOPvZ8CDIXpl0pSyPUFUIEr/0jGtfkI15FTHAKALtB5sUx0pss2EJGe8YBZM2w==
X-Received: by 2002:a05:6402:40c7:: with SMTP id z7mr13471696edb.255.1637694435660;
        Tue, 23 Nov 2021 11:07:15 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-112-244-006.95.112.pool.telefonica.de. [95.112.244.6])
        by smtp.gmail.com with ESMTPSA id e16sm7093326edz.18.2021.11.23.11.07.15
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 11:07:15 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 3/3] checkpolicy: add not-self neverallow support
Date:   Tue, 23 Nov 2021 20:07:04 +0100
Message-Id: <20211123190704.14341-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123190704.14341-1-cgzones@googlemail.com>
References: <20211123190704.14341-1-cgzones@googlemail.com>
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
 checkpolicy/policy_define.c | 46 ++++++++++++++++++++++++++++++++-----
 checkpolicy/test/dismod.c   |  6 ++++-
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index d3eb6111..662b35e7 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -2067,12 +2067,17 @@ static int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
 	while ((id = queue_remove(id_queue))) {
 		if (strcmp(id, "self") == 0) {
 			free(id);
-			if (add == 0) {
-				yyerror("-self is not supported");
+			if (add == 0 && which != AVRULE_NEVERALLOW) {
+				yyerror("-self is only supported in neverallowx rules");
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

