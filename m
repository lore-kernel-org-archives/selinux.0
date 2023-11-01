Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655EBC4167D
	for <selinux@archiver.kernel.org>; Wed,  1 Nov 2023 16:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344130AbjKAQim (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Nov 2023 12:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344200AbjKAQik (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Nov 2023 12:38:40 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542BC119
        for <selinux@vger.kernel.org>; Wed,  1 Nov 2023 09:38:35 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5094727fa67so27694e87.3
        for <selinux@vger.kernel.org>; Wed, 01 Nov 2023 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1698856713; x=1699461513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MvB5GTFv9yaEX00MVskrhNJZC9Z66fAa3nJW1huXJU0=;
        b=YhowgKhTk+gQ/erVld7BOSTyaFwcBhn8pWCJy2tGFhWbqm+R9rm9kJbjQOa3FOjjwU
         ARkWosFROdvVnReASItYWRuSFa03YjsnTEn6MWiacUcGr+Vclq/+Tv54j5RQ2F27cbzr
         pwr1mMOfLfFBAePh0JCEITsUKVjm2e2xwtfk4xk4nTxw5ZP4CzSxyhy91v3a/ATBKCbA
         +q08GwSkzSRXtPOnNCZiBcYqA4adUjhXefM7jGiWjjjksx8q0DihhedPJKu/3ARCycIY
         zcKZH6cMcIUQBTkW04fcbsYmClix7urgEUawyRiiRGi2ucG9pOBuZ6eL4Q5t9i6Ck4qY
         5r/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698856713; x=1699461513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MvB5GTFv9yaEX00MVskrhNJZC9Z66fAa3nJW1huXJU0=;
        b=r8m9Xfm5WEUDlA/ocijM8lg4A9vtTreI6q72gFOhhWznMcISHUUfDe6lOiCo+N0cXZ
         ytod3LfGmjw/BfZ28s/ZcSo6xESImCoBMmADA/KkAkAlrSEH3k1/jk5Yhtx/57vMvkDo
         l+HvV+sZ5FMxEMyBQNAMQkbFciTrpQCEVET6yRAhVOeYS0cgzuvZCZmy3tTW1hPlGli0
         F5hpx3xaUw49PkFHo/nF84GLUnKwKEUtomn3WTdeYwjHHQ1n5m+Kc8nkcyaMb5AJHQJk
         11aM7iKDYpcmwFOmJwqFAHPvHHc1aRg1S6tXdyvygHrJbUz4GenhJJk6f5HLaUasI3Yl
         /Lqw==
X-Gm-Message-State: AOJu0Yx8Clpi9miN3ZcdEGIqXpC+dz+PBzO+7G+85YhLYf3hd/xAPr+5
        hNef9dcTN5cL0/g9fuT/lStOyikjuus=
X-Google-Smtp-Source: AGHT+IHLpQYZhFPAryVjD7vq8KtcW437ebqmhmzDW6zUsp1dB6C+IWHyGsJb5BGBeTqYkSAsofyzrQ==
X-Received: by 2002:a19:6d1b:0:b0:507:95ea:1e72 with SMTP id i27-20020a196d1b000000b0050795ea1e72mr10600937lfc.22.1698856713279;
        Wed, 01 Nov 2023 09:38:33 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-116-163-023.95.116.pool.telefonica.de. [95.116.163.23])
        by smtp.gmail.com with ESMTPSA id j8-20020a50ed08000000b0053eb9af1e15sm1245939eds.77.2023.11.01.09.38.32
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 09:38:33 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/3] libsepol: validate constraint depth
Date:   Wed,  1 Nov 2023 17:38:29 +0100
Message-ID: <20231101163830.177769-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231101163830.177769-1-cgzones@googlemail.com>
References: <20231101163830.177769-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ensure constraint expressions are complete and do not exceed the
supported depth limit.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index d214bf09..c6a66fb3 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -228,6 +228,7 @@ bad:
 static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms, const constraint_node_t *cons, validate_t flavors[])
 {
 	const constraint_expr_t *cexp;
+	int depth;
 
 	for (; cons; cons = cons->next) {
 		if (nperms == 0 && cons->permissions != 0)
@@ -240,8 +241,14 @@ static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms
 		if (!cons->expr)
 			goto bad;
 
+		depth = -1;
+
 		for (cexp = cons->expr; cexp; cexp = cexp->next) {
 			if (cexp->expr_type == CEXPR_NAMES) {
+				if (depth >= (CEXPR_MAXDEPTH - 1))
+					goto bad;
+				depth++;
+
 				if (cexp->attr & CEXPR_XTARGET && nperms != 0)
 					goto bad;
 				if (!(cexp->attr & CEXPR_TYPE)) {
@@ -282,6 +289,10 @@ static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms
 					goto bad;
 				}
 			} else if (cexp->expr_type == CEXPR_ATTR) {
+				if (depth >= (CEXPR_MAXDEPTH - 1))
+					goto bad;
+				depth++;
+
 				if (!ebitmap_is_empty(&cexp->names))
 					goto bad;
 				if (validate_empty_type_set(cexp->type_names))
@@ -318,8 +329,14 @@ static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms
 			} else {
 				switch (cexp->expr_type) {
 				case CEXPR_NOT:
+					if (depth < 0)
+						goto bad;
+					break;
 				case CEXPR_AND:
 				case CEXPR_OR:
+					if (depth < 1)
+						goto bad;
+					depth--;
 					break;
 				default:
 					goto bad;
@@ -335,6 +352,9 @@ static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms
 					goto bad;
 			}
 		}
+
+		if (depth != 0)
+			goto bad;
 	}
 
 	return 0;
-- 
2.42.0

