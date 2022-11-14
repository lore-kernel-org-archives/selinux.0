Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51975C433FE
	for <selinux@archiver.kernel.org>; Mon, 14 Nov 2022 20:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbiKNULG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Nov 2022 15:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237518AbiKNUKv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Nov 2022 15:10:51 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711AF1D649
        for <selinux@vger.kernel.org>; Mon, 14 Nov 2022 12:10:50 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id f7so18941625edc.6
        for <selinux@vger.kernel.org>; Mon, 14 Nov 2022 12:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GbEaiuHOg89TOj36PvnjmKIN/U1WC+yt3QoCnJWruPI=;
        b=Xh+lzuS6XN7FkchfO9J2tZ51sctVqNK+gFJ6ZvEf0yAuLEJobnBHnedBeub+E1ZEdh
         Tg0zEH5YFI+PN9E1SM6huBzVG2NhdHwQKPWOehc45SnQejOd38uzG9YQPoe2Mg2TsZy4
         U008y2xqAmTP8+bIkvTVIvjfRlJ3kf97MzKwGge9+sjp0Qolwp6WJyNvnaQBN1LaE/nB
         VOWP3KrERGLI0sheu3wo4nWiEvhACkX6eN+5RYp4KciUUpSRaI9qVLCbDOuEoErJK2ky
         kWxDYYKwoepVQ3dYLZQoIQAeVYsd4RDWISdBGmxrNDO3CJYKitRsprbl76Y0NjaWhM3a
         bojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbEaiuHOg89TOj36PvnjmKIN/U1WC+yt3QoCnJWruPI=;
        b=ejv15plGqRKsAZhXJYXwgBaZ59R9bTVLeM/2WigJnpbbMRzWzybkd0wdRZAyZ5YD5e
         lZC/MVIIr9W9lkQVPVq0KcZxBrcuGhHI0arSwf0g7FIOdBwO82eN2sVoKk2Y92dpV4Bh
         xKcVA1PSHtGLfY9M/gwQ2milqDSCKZHYfyigw+vDV+MlUSTJ5IGVWcCkyFzzAQQ/ZP67
         6b9wv4192Dt13YHEAR3lfQPZ4bBXD2rn9FrYR21NNJ9mMni2rghgfgLSibuoh4yvP2H9
         OHyjK3NIJipSTI/fqKA1T2/braPHZ6mNKby6JPI71Zu9NOZRaO8YIIgffcBWicP5UiPj
         KB5Q==
X-Gm-Message-State: ANoB5pmMuatyzVlzX81Xhz6eOszdS8CbLfaWwBIWoaFXD/boW9ulygc2
        H/e2LX8cnV9JQBK6/HG6vYNV/rtXsF8=
X-Google-Smtp-Source: AA0mqf63/YHyUVq+kLwZEtrdawVjik5OUpcsycXYGTaAhY6iuup8URvPQdaj44XHbAdhz8687j8Mgg==
X-Received: by 2002:a05:6402:43ce:b0:461:5d0a:78e1 with SMTP id p14-20020a05640243ce00b004615d0a78e1mr12504119edc.425.1668456648939;
        Mon, 14 Nov 2022 12:10:48 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-090-138.77.3.pool.telefonica.de. [77.3.90.138])
        by smtp.gmail.com with ESMTPSA id cb13-20020a170906a44d00b007abafe43c3bsm4558377ejb.86.2022.11.14.12.10.48
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 12:10:48 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 2/6] checkpolicy: update cond_expr_t struct member name
Date:   Mon, 14 Nov 2022 21:10:38 +0100
Message-Id: <20221114201042.17773-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114201042.17773-1-cgzones@googlemail.com>
References: <20221114201042.17773-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/checkpolicy.c   | 2 +-
 checkpolicy/policy_define.c | 2 +-
 checkpolicy/test/dismod.c   | 2 +-
 checkpolicy/test/dispol.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 926ce72c..a1406e7b 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -313,7 +313,7 @@ static void display_expr(const cond_expr_t * exp)
 		switch (cur->expr_type) {
 		case COND_BOOL:
 			printf("%s ",
-			       policydbp->p_bool_val_to_name[cur->bool - 1]);
+			       policydbp->p_bool_val_to_name[cur->boolean - 1]);
 			break;
 		case COND_NOT:
 			printf("! ");
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 54bb304b..4ff730be 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -4126,7 +4126,7 @@ cond_expr_t *define_cond_expr(uint32_t expr_type, void *arg1, void *arg2)
 			free(id);
 			return NULL;
 		}
-		expr->bool = bool_var->s.value;
+		expr->boolean = bool_var->s.value;
 		free(id);
 		return expr;
 	default:
diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index ec2a3e9a..51b68433 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -400,7 +400,7 @@ static void display_expr(policydb_t * p, cond_expr_t * exp, FILE * fp)
 		switch (cur->expr_type) {
 		case COND_BOOL:
 			fprintf(fp, "%s ",
-				p->p_bool_val_to_name[cur->bool - 1]);
+				p->p_bool_val_to_name[cur->boolean - 1]);
 			break;
 		case COND_NOT:
 			fprintf(fp, "! ");
diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index 8ddefb04..c396bef7 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -197,7 +197,7 @@ static void display_expr(policydb_t * p, cond_expr_t * exp, FILE * fp)
 		switch (cur->expr_type) {
 		case COND_BOOL:
 			fprintf(fp, "%s ",
-				p->p_bool_val_to_name[cur->bool - 1]);
+				p->p_bool_val_to_name[cur->boolean - 1]);
 			break;
 		case COND_NOT:
 			fprintf(fp, "! ");
-- 
2.38.1

