Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF53C4332F
	for <selinux@archiver.kernel.org>; Wed, 19 Jan 2022 16:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356162AbiASQfd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jan 2022 11:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356161AbiASQfc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jan 2022 11:35:32 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7871CC061574
        for <selinux@vger.kernel.org>; Wed, 19 Jan 2022 08:35:32 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id bc19so2940840qvb.11
        for <selinux@vger.kernel.org>; Wed, 19 Jan 2022 08:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YoIdsSrchlPX32ISbUioAfsNks9SXdmtHkHK7rdI3xw=;
        b=f65555o+C8hixpsBaB3AI2AdFJyLbu9m91WblgM4j4GE6HH+MoOQb9SLOsutTAzyFE
         LvDyb2ZyytANwZrGOVlrxanYD+JQc6Wrc3DQU1A1NV5hQhiqvPWu8Y0Eg2MmkaqOxY8z
         taOr/CPjkLriK4G1iCHOYWear/kVfnZHRdLdYouCc1nlVlamEl/16wgpD3RwQVTmdPOe
         lMxUxzBe37nSld6NmtO1YFoZU9BN6xIem1pLBN1VGAUmiGGgvkzCYRX/x9s63N6Y8FGY
         ztOUQvIquGVzcCPsCh/pwWWOIvUUdwgmH4Zgc2l5M7xr7noLvJv1z6BdenibHz3yHJhf
         bMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YoIdsSrchlPX32ISbUioAfsNks9SXdmtHkHK7rdI3xw=;
        b=tR6tCGbeMEKSXKpQQYsR5QeA3oGh+9Bop9ftH7BeHPv+XzXxO9pjAmiaE1htYVkYph
         s0F3mR62zNe3gvx7wTU/kwFQmNkbMkICQysd+ZJv3zGf1ZeIcv4dyM2sUVYxhQkqMy7e
         pOm1+msne1OBkfxQHis1FZDQG129XTew8Gbwn71zKmjdneucrOKUdZfynzHvZMhKCesk
         s455vcg98RjjF3ha16C13/kVoAvuIVpyg6wEORlmOCBDrl93c/8FaO7eCQW4r8iNTGCq
         QDo61wn/Jr2P0GXneYnkWOGJVOYUOPYDeEQ4rQTKElcG2AeSnN/XjEO+uCcmgqPVRll9
         ZkmA==
X-Gm-Message-State: AOAM530yw8NT7ClMWMUyJbddbSZx3BAqy/AwN+4Aa2kHTyO/q3gWKD0y
        mzcSOSeo0BlxSst8lJ+ZD4Fac5ZJwpY=
X-Google-Smtp-Source: ABdhPJypfSkw9oJGlenpZON5C79rPVj+9TG90aOKSoeN2gE2Ol3Ox7o5gj2aCspcOpaqEEO86hRKDQ==
X-Received: by 2002:ac8:7dc7:: with SMTP id c7mr14809709qte.83.1642610131488;
        Wed, 19 Jan 2022 08:35:31 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id b200sm127231qkc.50.2022.01.19.08.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 08:35:31 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     j2468h@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/4 v2] libsepol/cil: Limit the neverallow violations reported
Date:   Wed, 19 Jan 2022 11:35:17 -0500
Message-Id: <20220119163518.93780-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220119163518.93780-1-jwcart2@gmail.com>
References: <20220119163518.93780-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When there is a neverallow violation, a search is made for all of
the rules that violate the neverallow. The violating rules as well
as their parents are written out to make it easier to find these
rules.

If there is a lot of rules that violate a neverallow, then this
amount of reporting is too much. Instead, only print out the first
four rules (with their parents) that match the violated neverallow
rule along with the total number of rules that violate the
neverallow at the default log level. Report all the violations when
at a higher verbosity level.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_binary.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index b7da8241..8b64b37a 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -4640,6 +4640,9 @@ static int __cil_print_neverallow_failure(const struct cil_db *db, struct cil_tr
 	char *neverallow_str;
 	char *allow_str;
 	enum cil_flavor avrule_flavor;
+	int num_matching = 0;
+	int count_matching = 0;
+	enum cil_log_level log_level = cil_get_log_level();
 
 	target.rule_kind = CIL_AVRULE_ALLOWED;
 	target.is_extended = cil_rule->is_extended;
@@ -4666,11 +4669,19 @@ static int __cil_print_neverallow_failure(const struct cil_db *db, struct cil_tr
 		goto exit;
 	}
 
+	cil_list_for_each(i2, matching) {
+		num_matching++;
+	}
 	cil_list_for_each(i2, matching) {
 		n2 = i2->data;
 		r2 = n2->data;
 		__cil_print_parents("    ", n2);
 		__cil_print_rule("      ", allow_str, r2);
+		count_matching++;
+		if (count_matching >= 4 && num_matching > 4 && log_level == CIL_ERR) {
+			cil_log(CIL_ERR, "    Only first 4 of %d matching rules shown (use \"-v\" to show all)\n", num_matching);
+			break;
+		}
 	}
 	cil_log(CIL_ERR,"\n");
 	cil_list_destroy(&matching, CIL_FALSE);
-- 
2.31.1

