Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7795AC433EF
	for <selinux@archiver.kernel.org>; Thu,  9 Jun 2022 08:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiFIIUR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jun 2022 04:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiFIIUQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jun 2022 04:20:16 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391413A4CC0
        for <selinux@vger.kernel.org>; Thu,  9 Jun 2022 01:20:15 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gl15so32083676ejb.4
        for <selinux@vger.kernel.org>; Thu, 09 Jun 2022 01:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IJj4wFWS9Iy4sZboDWeGP8LlNcqHuxqQxLIhJPBOMRs=;
        b=ee1SG0WB1X7gEmvV6UiUaWOKosmQEhGmi8maUdsEAUpc+HwF2ZHqC22OKTJN0l95cF
         3T+5zAcM5mCvpLHs9G+eL4gn8bYt5xkgTVQ7j+qWeooIoAwzcbXca5Vu2zY27d3QZ+yE
         tbyNGAIUsSOCDs2oZyr1UdaUYIp6DZlEAEm2MgLg/ctx/f64Bjra4VIYK0inVj+KFXzR
         rgbPBBLgxHTWCtFF/5/lvI9eYnlu03k4++yZAqn7ZQpoptQvibqFcxQi8qJLcdkU4ke1
         6qBGUPl2SCdItYljeoCcVRQaig9SxSa5JUjrxWWGgpn0n24GJG/Ws5/RMjO5Xd3X1GwK
         DEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IJj4wFWS9Iy4sZboDWeGP8LlNcqHuxqQxLIhJPBOMRs=;
        b=13kLH5C30N88xtPo2hH3OEynCWKKGcz7mz2SUD02SmEou4d0xzuv9QtACQ8pIGh8Gh
         lOVZavzzCOTqIvsXUGgXr/MKsuPaXizryYPdLsZPxKHwNmoK3uOoEQgWGn7HybhaG4eI
         PSv5g4tk2Xj6txjxlF0aGsVhWTeuv5owjngCT5Q6OEE5Lc5W1pf1yxFPN84+L74+HCbD
         690lxvMIzwSZdfdUF42u+n8pWH50/Cci/iID9UOo/3ePLF0VD2sYguCevd077MbJewZ8
         7DJBvFlctLsEaTxQ/7TDXN1CW/uPw94uOAEzJhgBr8uOBNfUdyruWHyUjJQFbvjMltga
         brvA==
X-Gm-Message-State: AOAM533kIni45MEIUSrNKN4JvuHeElzOLCHINfcJ13/qsllDxrdYO8sR
        VanxFXWc25p0N9UjORHcSF2NabwF5Hs=
X-Google-Smtp-Source: ABdhPJw2b8Kd5JtWIN3bKUh61+s+RygJx8Cn4GtVLIh7Cq3MrStQdNHR1Pe5TnTJ2tiHR63zK/PivQ==
X-Received: by 2002:a17:907:3e99:b0:6fe:f823:ab96 with SMTP id hs25-20020a1709073e9900b006fef823ab96mr35353379ejc.428.1654762813669;
        Thu, 09 Jun 2022 01:20:13 -0700 (PDT)
Received: from dlaptop.localdomain (dynamic-095-112-077-013.95.112.pool.telefonica.de. [95.112.77.13])
        by smtp.gmail.com with ESMTPSA id l6-20020a170906414600b007025015599bsm10278939ejk.214.2022.06.09.01.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 01:20:13 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        bauen1 <j2468h@gmail.com>
Subject: [PATCH v2] libsepol: fix validation of user declarations in non-base modules
Date:   Thu,  9 Jun 2022 10:19:55 +0200
Message-Id: <20220609081955.3887-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607150145.29757-1-cgzones@googlemail.com>
References: <20220607150145.29757-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Users may be declared in non-base modules, which do not get expanded,
leaving the `struct user_datum` members `exp_range` and `exp_dfltlevel`
empty.
Skip validation of the expanded range and level for non-base module
polices.

Reported-by: bauen1 <j2468h@gmail.com>
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
   - update commit description and fix typos
---
 libsepol/src/policydb_validate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index da18282b..99d4eb7f 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -18,7 +18,7 @@ typedef struct validate {
 typedef struct map_arg {
 	validate_t *flavors;
 	sepol_handle_t *handle;
-	int mls;
+	policydb_t *policy;
 } map_arg_t;
 
 static int create_gap_ebitmap(char **val_to_name, uint32_t nprim, ebitmap_t *gaps)
@@ -571,7 +571,7 @@ static int validate_mls_range(mls_range_t *range, validate_t *sens, validate_t *
 	return -1;
 }
 
-static int validate_user_datum(sepol_handle_t *handle, user_datum_t *user, validate_t flavors[], int mls)
+static int validate_user_datum(sepol_handle_t *handle, user_datum_t *user, validate_t flavors[], policydb_t *p)
 {
 	if (validate_value(user->s.value, &flavors[SYM_USERS]))
 		goto bad;
@@ -581,9 +581,9 @@ static int validate_user_datum(sepol_handle_t *handle, user_datum_t *user, valid
 		goto bad;
 	if (validate_mls_semantic_level(&user->dfltlevel, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
 		goto bad;
-	if (mls && validate_mls_range(&user->exp_range, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
+	if (p->mls && p->policy_type != POLICY_MOD && validate_mls_range(&user->exp_range, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
 		goto bad;
-	if (mls && validate_mls_level(&user->exp_dfltlevel, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
+	if (p->mls && p->policy_type != POLICY_MOD && validate_mls_level(&user->exp_dfltlevel, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
 		goto bad;
 	if (user->bounds && validate_value(user->bounds, &flavors[SYM_USERS]))
 		goto bad;
@@ -599,7 +599,7 @@ static int validate_user_datum_wrapper(__attribute__((unused)) hashtab_key_t k,
 {
 	map_arg_t *margs = args;
 
-	return validate_user_datum(margs->handle, d, margs->flavors, margs->mls);
+	return validate_user_datum(margs->handle, d, margs->flavors, margs->policy);
 }
 
 static int validate_bool_datum(sepol_handle_t *handle, cond_bool_datum_t *boolean, validate_t flavors[])
@@ -689,7 +689,7 @@ static int validate_datum(__attribute__ ((unused))hashtab_key_t k, hashtab_datum
 
 static int validate_datum_array_entries(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
 {
-	map_arg_t margs = { flavors, handle, p->mls };
+	map_arg_t margs = { flavors, handle, p };
 
 	if (hashtab_map(p->p_commons.table, validate_common_datum_wrapper, &margs))
 		goto bad;
-- 
2.36.1

