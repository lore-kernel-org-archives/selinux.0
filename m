Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560D7C07E8A
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjHNNVR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjHNNU6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:20:58 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A317BE7D
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:49 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-997c4107d62so576360666b.0
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019248; x=1692624048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bHFpfdLtFfPwthV9DSwBs7yA5Vq97jyRJJfLzhZ2AVo=;
        b=HfjG5eHRUZPNWLIZLORLx8q7JY2QXY0XpDBipLF24CNraXM7DzrdjfxmDWJpXkjYwW
         KJPKG9kDSSNij1HPs9CoDI8RLF8xp5wA9D9Xmr5yrqOcfqrPHbfDOqK/lBDKEpk7wvTc
         Qu66cs7ag/AQku1KZ23WvmKa2kv3Xtb9U9C8WGwDtrGJJMus+Eo6tzliv2NgJ9pLvwE2
         krtG3NNfVlwxbjHTYjP3FyN9gNWrQXBPNJAi9EObBjN72mkm1M73kUd5kgwNaI9JVqvX
         7yjzRo0utVYa8s+jRsE9RczqXz53+BgDP9fVOEj/uEl1h7UOcwcmoMswQVcg7JKk1+0J
         K8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019248; x=1692624048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHFpfdLtFfPwthV9DSwBs7yA5Vq97jyRJJfLzhZ2AVo=;
        b=PbUKtpDGmEhI/eKUpDfXrY3HVgLHRdAnmZi2hox5bxKIam7uR2QtlrywX/etl81tqD
         t6eHIm5Cbyslcq6x1ItQ3GtD89NkGvJS5FBqqjBIKd5b3GzMDb4g+y7ptCnPGNv02mao
         ekpjOpDGrhf3oHkAbDHa9z8K2J0EOqHD1qOBW91rhRL7PJi7U+C5FErse/1vRjMtXdDB
         xdAbNFyIG+n6CxHZsOXlQH9V8ybjUnc4Haa5FCKZQGMU+kPXF6JDY4aACCr3xonKD7Zn
         qJVXxhtk0ow8RAbNAvzu+0SvQgflqm1m8lNiK7E2NV6ooxLYVby8lL5+jymNvBUtwqyi
         M+/w==
X-Gm-Message-State: AOJu0YxTtKPfwbpSargTyftd2oG6NnEpms+3KlGQ/QvxbOwMjjxRjAs5
        IX3++UWgIJeK+krqInqCZaIGMGGxCAxP4Ir1aS8=
X-Google-Smtp-Source: AGHT+IGO79YrtR+HvcPGbuFJFVqy+yz1/iJFtECMd9kamcYCwycW5IKOtMGbEr4MHiFo3cUuIBEehQ==
X-Received: by 2002:a17:906:3013:b0:991:d05c:f065 with SMTP id 19-20020a170906301300b00991d05cf065mr8673456ejz.52.1692019248063;
        Mon, 14 Aug 2023 06:20:48 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.47
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:47 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 14/27] libselinux: parameter simplifications
Date:   Mon, 14 Aug 2023 15:20:12 +0200
Message-Id: <20230814132025.45364-15-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814132025.45364-1-cgzones@googlemail.com>
References: <20230814132025.45364-1-cgzones@googlemail.com>
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

