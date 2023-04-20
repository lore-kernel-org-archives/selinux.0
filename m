Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC6DC77B73
	for <selinux@archiver.kernel.org>; Thu, 20 Apr 2023 15:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjDTPgI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Apr 2023 11:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjDTPgH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Apr 2023 11:36:07 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B02E30DE
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:36:05 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5058181d58dso1080465a12.1
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682004963; x=1684596963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLgg58iZrqaUL10CAl0vSIZZU8GGdUV6c6k4QWCTsns=;
        b=ob56HfdJR9ElXYXNba7ti8Nxtlfnb/BVaS2n2AgTPXtPA1sK6XT3HO+YD+dR74uGix
         QV8g81LrPJY4fcrFxYi4rL9pvIkm8dvXJn8PQOxCMVUO1BUPDuYRKc8FMzgy6Fa8SDiB
         CNjnVQrlxTS0qtOP3LULZuYim2MtXpDuJXLv5IVLgxb8z9IC+HHxb2ffWod2sX194q5K
         lhUNZxQU7tCiiNf1jGHmVtJ0RIkpi7Twm1qHdZYfEaQAznBapT+x+2RnbsUXNK0QCOl1
         JuU4PXh9G3zdheWuvWnfpGznYZsK4a2Vd7dijIcINKJ7BZ0K2YF13Ay3zqsjSIYMLg2p
         cKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682004963; x=1684596963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLgg58iZrqaUL10CAl0vSIZZU8GGdUV6c6k4QWCTsns=;
        b=RAjGR3nAlxMpqZ/Xs7MONHxYPdqEB4Dit3GkeV1623fDjDuUvlv+PLFiwKlg4cYdA3
         xavdcO9J2jNEv0+9XY/ZP4lxGEJQIkcuD6Wd6RuUIurO/L7Ok6s+ptNXLPpxFG7qaROC
         3kwdpwfAE7fy0KghwFmntVDAqYiHhIkuBs07oSJGupRnIYLgyo5bwRyqxtVS2yc1UUbu
         eeRQC/bQRWmqvHvdvOFOuDeQm3B98xqfHsNy8+2zgjkmP4PDR4Wy26WD1sCaMUWwSKc9
         IM1IDuHbVT/MqkJRjbEOHsrOjS9vx3VDDSK5PHRw7ZUwgQOhAeS9YRlplv7WLs4vGW75
         XEww==
X-Gm-Message-State: AAQBX9cC9D7nU1pBpOTK18smDNH2QJtWGiva5ZReALRDVEV9bsPZyUXC
        c5S1Bza1sBYJTL0eEBDKXcmB+qnlzD8=
X-Google-Smtp-Source: AKy350ZT4oncWLXsKwm+LR5Jo+MvhOGntxIt2rwVx4na9OIabxNAslXNNCLbkVwx4N13jbn3Z2zVvQ==
X-Received: by 2002:aa7:c502:0:b0:504:adc2:80da with SMTP id o2-20020aa7c502000000b00504adc280damr1732672edq.18.1682004963463;
        Thu, 20 Apr 2023 08:36:03 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-119-201-251.95.119.pool.telefonica.de. [95.119.201.251])
        by smtp.gmail.com with ESMTPSA id r22-20020aa7cb96000000b0050696c2d2f6sm853013edt.88.2023.04.20.08.36.03
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 08:36:03 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 2/6] checkpolicy: update cond_expr_t struct member name
Date:   Thu, 20 Apr 2023 17:35:52 +0200
Message-Id: <20230420153556.32115-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230420153556.32115-1-cgzones@googlemail.com>
References: <20230420153556.32115-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The previous commit changed the member `bool` to `boolean` of the
libsepol type `cond_expr_t` for C23 compatibility.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
   update commit description
---
 checkpolicy/checkpolicy.c   | 2 +-
 checkpolicy/policy_define.c | 2 +-
 checkpolicy/test/dismod.c   | 2 +-
 checkpolicy/test/dispol.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 48c31261..b0c36807 100644
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
index f277e600..d4e376ad 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -4159,7 +4159,7 @@ cond_expr_t *define_cond_expr(uint32_t expr_type, void *arg1, void *arg2)
 			free(id);
 			return NULL;
 		}
-		expr->bool = bool_var->s.value;
+		expr->boolean = bool_var->s.value;
 		free(id);
 		return expr;
 	default:
diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index a2d74d42..bda8d4e9 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -404,7 +404,7 @@ static void display_expr(policydb_t * p, cond_expr_t * exp, FILE * fp)
 		switch (cur->expr_type) {
 		case COND_BOOL:
 			fprintf(fp, "%s ",
-				p->p_bool_val_to_name[cur->bool - 1]);
+				p->p_bool_val_to_name[cur->boolean - 1]);
 			break;
 		case COND_NOT:
 			fprintf(fp, "! ");
diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index 36a3362c..6561366d 100644
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
2.40.0

