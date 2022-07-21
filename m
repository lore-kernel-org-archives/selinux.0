Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B325AC43334
	for <selinux@archiver.kernel.org>; Thu, 21 Jul 2022 15:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiGUPY4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiGUPYy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Jul 2022 11:24:54 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADA47A513
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 08:24:52 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id m13so2595550edc.5
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 08:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jtpsEukWOarPt296N7+qifAxvTIycvYQfJwreC7OguE=;
        b=CfT7nTDBCkF/Iat4aAxthPHf+3t3g+REqiy5KrpJgxgCRjxzrTi+vUDIwfg9A7qCSK
         nU9qTxQy8leUvXHHOIGeOMGblLXsAn5bNJ61GUffxd+sGIjS/0PMt+i2zuOin6Mpweat
         N0raWMOLZ9S4vqq7v9Dkgu2ij2jzyPr+kawMpYm3BLF9UDrn81vAynklx1JL6UYPE7qV
         cnAtps5KugRgxl+zHPD4g7zP0lYoEqgc3nPtSSRyxh+vjOn8E3tYNZhFrWnnSoM9cgb9
         Tgh1MXaKqxPe0o9tZon0CgMMHv67F8M91cbn2SU0pkERqL2LytMfa8885/5M2V3WVSqm
         6Pzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jtpsEukWOarPt296N7+qifAxvTIycvYQfJwreC7OguE=;
        b=exuy9Sr11pUh6D/MnqcYAUBAQVfM1ZZ6P8oh+qI/FeC5URbaaH+8UHwiTY5Nh4EQei
         KPE5zR2G3W3P/JAsFrMI2q/ocZodnWwXYMAtDhCVpFnkEnQu/vKKzANewGhZzz9pXVb+
         u6gsaQgzx8DerazQGfE8ZXnSwaceT92NTrtRvGaI1KpU33twC4gQVUwidGt0YNkhJrGL
         RXExknkxjdfDHW7a0ZNoEHMEwdO/AaqyzNairHvikxR9IsPY6bpoiBRDd3nT2YwNrDaD
         SBj4Xr4jDWoliKqdM4n0gpj0lXBSyN9BhS3npcv+AS6WLpfzRmnIjqvQQP3d6IMfXFJu
         9KzQ==
X-Gm-Message-State: AJIora/4tE7FFW361HUUGjECSuvUfEEaCA1/99q2Ff9zRgh8IgoVKQgR
        xK2LytB9BKU0lo8tTlmniuiya4oy7pwz2Q==
X-Google-Smtp-Source: AGRyM1ut52OtudPHC9AyHFptYlrFl/hkcmHRJWZW38d1+9+EZMpoQIkIsPH2EMHwqWwq/l5IgkSXoQ==
X-Received: by 2002:a05:6402:51cb:b0:43a:e94c:a841 with SMTP id r11-20020a05640251cb00b0043ae94ca841mr57939086edd.212.1658417091387;
        Thu, 21 Jul 2022 08:24:51 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-209-027.77.0.pool.telefonica.de. [77.0.209.27])
        by smtp.gmail.com with ESMTPSA id d18-20020a056402079200b0043a253973aasm1163486edy.10.2022.07.21.08.24.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 08:24:50 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 4/5] libsepol: rename parameter name
Date:   Thu, 21 Jul 2022 17:24:43 +0200
Message-Id: <20220721152444.31690-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721152444.31690-1-cgzones@googlemail.com>
References: <20220721152444.31690-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Do not use `bool` as a parameter name, for future C version support.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index a567c411..0f399771 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -862,7 +862,7 @@ bad:
 	return -1;
 }
 
-static int validate_bool_id_array(sepol_handle_t *handle, const uint32_t bool_ids[], unsigned int nbools, const validate_t *bool)
+static int validate_bool_id_array(sepol_handle_t *handle, const uint32_t bool_ids[], unsigned int nbools, const validate_t *boolean)
 {
 	unsigned int i;
 
@@ -870,7 +870,7 @@ static int validate_bool_id_array(sepol_handle_t *handle, const uint32_t bool_id
 		goto bad;
 
 	for (i=0; i < nbools; i++) {
-		if (validate_value(bool_ids[i], bool))
+		if (validate_value(bool_ids[i], boolean))
 			goto bad;
 	}
 
@@ -881,14 +881,14 @@ bad:
 	return -1;
 }
 
-static int validate_cond_expr(sepol_handle_t *handle, const struct cond_expr *expr, const validate_t *bool)
+static int validate_cond_expr(sepol_handle_t *handle, const struct cond_expr *expr, const validate_t *boolean)
 {
 	int depth = -1;
 
 	for (; expr; expr = expr->next) {
 		switch(expr->expr_type) {
 		case COND_BOOL:
-			if (validate_value(expr->bool, bool))
+			if (validate_value(expr->bool, boolean))
 				goto bad;
 			if (depth == (COND_EXPR_MAXDEPTH - 1))
 				goto bad;
-- 
2.36.1

