Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD38C04FE1
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 16:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjHKQ17 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjHKQ16 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 12:27:58 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF4C2D70
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:57 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-523643207dbso2758770a12.3
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691771276; x=1692376076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bHFpfdLtFfPwthV9DSwBs7yA5Vq97jyRJJfLzhZ2AVo=;
        b=X/B1T9b/OVLIyTrIq1JNRCoxRPtC0ENIHe4n7cHcYusfCSzjGvS+9bGo2GAr+lcRsE
         Gy1lhbzez7fBL95EbtYo9Q9bKYxQvkosQfmV+PKxoSZxlVdISiK6qqts7MsAP50EhX/M
         aWlveM+s5ux9YwG+Ae8PM4BeI86A9vAxXNEKfTqjhUcsww4kXHr01x+DzHFor42hPgYI
         ZWwP/RYoXJWy4IwHEmmE57GF2eIbl1c2xtbZ/BrzVMAIcEx4cIVdkDGetd0OTpeiMCjm
         5zxPuyOGTfgQb6gO1ax+efc4r56NkOkf5LMPKzl9vFIKzznsDtqTBtzwMvCUPPkP5t/q
         w8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771276; x=1692376076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHFpfdLtFfPwthV9DSwBs7yA5Vq97jyRJJfLzhZ2AVo=;
        b=UYSLVJr5u5+eVQSfS22+HpPkZYBtAnaKJUem0aptXZeuZMKRpTQAXtWq/PP3gTA0lc
         33W8nUGHT5Uc2oWQNzj7LaA1CRXj64/snTRgGGvcuUzI3IzdjY6GsZ44Yh9Hr56aAVua
         4Tgijc11AeXyy83wpoRzj1RF7taeSxFDUb+vZMspStajnVzjN2qr3mYpzQ/picsroGvZ
         4rfPbfQJKfbzNJ2yTmHfT+oxDFDewZV8s4y0MvBRR9cvk0kd1/8lkRKaJTRX4XO6WHS3
         r4fw4RBrV0iCKZ+E+xzavluZoMVs4k3eYoqQpm4szYsuIrUxe0vfLnWtjNjGphucjUja
         4l/Q==
X-Gm-Message-State: AOJu0YzJqnZ3qBt+CqdY433Ytzq8s0Y8a0YfbqTTtIeW7quKveMDtW+b
        7TTbcZkqUuTIyOuQdJTPumMFERGJjaSDDw==
X-Google-Smtp-Source: AGHT+IGK6xYnyVUhnTnIDG3z8go45mZiiVpXld3AMKNz/A2lPgE6uaigwpXXBsb/lP5A19MLwY5I6w==
X-Received: by 2002:a17:906:105c:b0:994:542c:8718 with SMTP id j28-20020a170906105c00b00994542c8718mr2241118ejj.76.1691771275668;
        Fri, 11 Aug 2023 09:27:55 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-174-226.77.0.pool.telefonica.de. [77.0.174.226])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906b20900b00992afee724bsm2408807ejz.76.2023.08.11.09.27.55
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:27:55 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 14/24] libselinux: parameter simplifications
Date:   Fri, 11 Aug 2023 18:27:21 +0200
Message-Id: <20230811162731.50697-15-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811162731.50697-1-cgzones@googlemail.com>
References: <20230811162731.50697-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use bool where applicable.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index c0f586a2..9a972f79 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -137,9 +137,9 @@ out:
 }
 
 /* Public API helpers */
-static int selabel_fini(struct selabel_handle *rec,
+static int selabel_fini(const struct selabel_handle *rec,
 			    struct selabel_lookup_rec *lr,
-			    int translating)
+			    bool translating)
 {
 	if (compat_validate(rec, lr, rec->spec_file, lr->lineno))
 		return -1;
@@ -152,7 +152,7 @@ static int selabel_fini(struct selabel_handle *rec,
 }
 
 static struct selabel_lookup_rec *
-selabel_lookup_common(struct selabel_handle *rec, int translating,
+selabel_lookup_common(struct selabel_handle *rec, bool translating,
 		      const char *key, int type)
 {
 	struct selabel_lookup_rec *lr;
@@ -173,7 +173,7 @@ selabel_lookup_common(struct selabel_handle *rec, int translating,
 }
 
 static struct selabel_lookup_rec *
-selabel_lookup_bm_common(struct selabel_handle *rec, int translating,
+selabel_lookup_bm_common(struct selabel_handle *rec, bool translating,
 		      const char *key, int type, const char **aliases)
 {
 	struct selabel_lookup_rec *lr;
@@ -239,7 +239,7 @@ int selabel_lookup(struct selabel_handle *rec, char **con,
 {
 	struct selabel_lookup_rec *lr;
 
-	lr = selabel_lookup_common(rec, 1, key, type);
+	lr = selabel_lookup_common(rec, true, key, type);
 	if (!lr)
 		return -1;
 
@@ -252,7 +252,7 @@ int selabel_lookup_raw(struct selabel_handle *rec, char **con,
 {
 	struct selabel_lookup_rec *lr;
 
-	lr = selabel_lookup_common(rec, 0, key, type);
+	lr = selabel_lookup_common(rec, false, key, type);
 	if (!lr)
 		return -1;
 
@@ -307,7 +307,7 @@ int selabel_lookup_best_match(struct selabel_handle *rec, char **con,
 		return -1;
 	}
 
-	lr = selabel_lookup_bm_common(rec, 1, key, type, aliases);
+	lr = selabel_lookup_bm_common(rec, true, key, type, aliases);
 	if (!lr)
 		return -1;
 
@@ -325,7 +325,7 @@ int selabel_lookup_best_match_raw(struct selabel_handle *rec, char **con,
 		return -1;
 	}
 
-	lr = selabel_lookup_bm_common(rec, 0, key, type, aliases);
+	lr = selabel_lookup_bm_common(rec, false, key, type, aliases);
 	if (!lr)
 		return -1;
 
-- 
2.40.1

