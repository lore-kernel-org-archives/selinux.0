Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8D5C07E8D
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjHNNVV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjHNNUv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:20:51 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E0B198C
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:45 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bfcf4c814so578915066b.0
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019244; x=1692624044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZoB2tNmGWecF5SpS2bhjX6gg76W6vta88m4GAWSsu4=;
        b=BWZCmaSuSNglwXhqsaZF619txghlSSwxEWuC4qhQkpE4iRplX2bHW8OKn/6v9ykG0E
         s6E8IfNi4HcAKqIxRme2+g93L9g0G1v+1kfP0ptslr0S8Ic4B1KHRkV1CYyDw+qezPOg
         k9XZPMagF1Rp/k512g5/BRIJyXBMmCAKT/Znw/17Noy6X8uio9aZEBat4PttMo5FoxBr
         ej3UhO5khhPdRelVHDq9qq1SNTFNoog32yEYivHP1/cPnL4DExZrFUOQLHh6N2BAA+Zt
         NaYtGPyocsj3EhOJ0P6E4pmZarAHpyOXKbQ6Vqki22bIqfuKEqlO/H+RESunLghlRP9I
         +EwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019244; x=1692624044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZoB2tNmGWecF5SpS2bhjX6gg76W6vta88m4GAWSsu4=;
        b=lUuAU5iB8J9mJNafLXXijrGwXwLcjNrC48p9rrixym0d25ojpHU8Vk+iw618mywvtV
         HYX15E47EyPAgVoStFg+fGwjMByNMDtlbk+1NgKMlKsZOC2go5XxAp+nVD5++BfpqJaw
         t9DC45doF19trkD53Vfw1aVYByaS4J+Exa/SzP28F6Fx5EopFG/vA7z/LZ9HGKU3EwTU
         Fmh0VdWkYo0+hNw0bMmoUqdHJcIRjr5xyk3UqvOkxlXFYNYdNxAjEx22KfXHo0EsUBf7
         r6pGepIIKzlUg4lQPByON6ZSVOjOrfK58lWP9Tx6ztcZTUYdnq/IggxGC2fy+7+zGdTq
         LqSA==
X-Gm-Message-State: AOJu0YxNWrev8zhHpwdj1oNk22L7sZ2Y0aEM9AHm5Va+tbsYsUl2mH29
        JD8Lrj+y4PcxMmWjeIhwCUp39+dSoiSfkt1Nab0=
X-Google-Smtp-Source: AGHT+IH3wbQSWGcOBwv1/nSCwMZ2k1lGUJh+QpJm7+jZ8JobXuSqzYsUwhvo6VK90OufhlnFYG4vMQ==
X-Received: by 2002:a17:906:31c6:b0:99c:da24:bdb7 with SMTP id f6-20020a17090631c600b0099cda24bdb7mr8127347ejf.71.1692019244066;
        Mon, 14 Aug 2023 06:20:44 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.43
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:43 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 07/27] libselinux: constify selabel_cmp(3) parameters
Date:   Mon, 14 Aug 2023 15:20:05 +0200
Message-Id: <20230814132025.45364-8-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814132025.45364-1-cgzones@googlemail.com>
References: <20230814132025.45364-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Comparing two selabel handles should (and currently does) not modify
them.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/include/selinux/label.h |  4 ++--
 libselinux/src/label.c             |  4 ++--
 libselinux/src/label_file.c        | 22 +++++++++++-----------
 libselinux/src/label_internal.h    |  4 ++--
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
index e8983606..ce189a3a 100644
--- a/libselinux/include/selinux/label.h
+++ b/libselinux/include/selinux/label.h
@@ -153,8 +153,8 @@ enum selabel_cmp_result {
  * if @h1 is identical to @h2, %SELABEL_SUPERSET if @h1 is a superset
  * of @h2, and %SELABEL_INCOMPARABLE if @h1 and @h2 are incomparable.
  */
-extern enum selabel_cmp_result selabel_cmp(struct selabel_handle *h1,
-					   struct selabel_handle *h2);
+extern enum selabel_cmp_result selabel_cmp(const struct selabel_handle *h1,
+					   const struct selabel_handle *h2);
 
 /**
  * selabel_stats - log labeling operation statistics.
diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index a2efa99c..c0f586a2 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -333,8 +333,8 @@ int selabel_lookup_best_match_raw(struct selabel_handle *rec, char **con,
 	return *con ? 0 : -1;
 }
 
-enum selabel_cmp_result selabel_cmp(struct selabel_handle *h1,
-				    struct selabel_handle *h2)
+enum selabel_cmp_result selabel_cmp(const struct selabel_handle *h1,
+				    const struct selabel_handle *h2)
 {
 	if (!h1->func_cmp || h1->func_cmp != h2->func_cmp)
 		return SELABEL_INCOMPARABLE;
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 461abc61..5ac23e1f 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1237,7 +1237,7 @@ out:
 	return lr;
 }
 
-static enum selabel_cmp_result incomp(struct spec *spec1, struct spec *spec2, const char *reason, int i, int j)
+static enum selabel_cmp_result incomp(const struct spec *spec1, const struct spec *spec2, const char *reason, int i, int j)
 {
 	selinux_log(SELINUX_INFO,
 		    "selabel_cmp: mismatched %s on entry %d: (%s, %x, %s) vs entry %d: (%s, %x, %s)\n",
@@ -1247,21 +1247,21 @@ static enum selabel_cmp_result incomp(struct spec *spec1, struct spec *spec2, co
 	return SELABEL_INCOMPARABLE;
 }
 
-static enum selabel_cmp_result cmp(struct selabel_handle *h1,
-				   struct selabel_handle *h2)
+static enum selabel_cmp_result cmp(const struct selabel_handle *h1,
+				   const struct selabel_handle *h2)
 {
-	struct saved_data *data1 = (struct saved_data *)h1->data;
-	struct saved_data *data2 = (struct saved_data *)h2->data;
+	const struct saved_data *data1 = (const struct saved_data *)h1->data;
+	const struct saved_data *data2 = (const struct saved_data *)h2->data;
 	unsigned int i, nspec1 = data1->nspec, j, nspec2 = data2->nspec;
-	struct spec *spec_arr1 = data1->spec_arr, *spec_arr2 = data2->spec_arr;
-	struct stem *stem_arr1 = data1->stem_arr, *stem_arr2 = data2->stem_arr;
+	const struct spec *spec_arr1 = data1->spec_arr, *spec_arr2 = data2->spec_arr;
+	const struct stem *stem_arr1 = data1->stem_arr, *stem_arr2 = data2->stem_arr;
 	bool skipped1 = false, skipped2 = false;
 
 	i = 0;
 	j = 0;
 	while (i < nspec1 && j < nspec2) {
-		struct spec *spec1 = &spec_arr1[i];
-		struct spec *spec2 = &spec_arr2[j];
+		const struct spec *spec1 = &spec_arr1[i];
+		const struct spec *spec2 = &spec_arr2[j];
 
 		/*
 		 * Because sort_specs() moves exact pathnames to the
@@ -1297,8 +1297,8 @@ static enum selabel_cmp_result cmp(struct selabel_handle *h1,
 		if (spec2->stem_id == -1 && spec1->stem_id != -1)
 			return incomp(spec1, spec2, "stem_id", i, j);
 		if (spec1->stem_id != -1 && spec2->stem_id != -1) {
-			struct stem *stem1 = &stem_arr1[spec1->stem_id];
-			struct stem *stem2 = &stem_arr2[spec2->stem_id];
+			const struct stem *stem1 = &stem_arr1[spec1->stem_id];
+			const struct stem *stem2 = &stem_arr2[spec2->stem_id];
 			if (stem1->len != stem2->len ||
 			    strncmp(stem1->buf, stem2->buf, stem1->len))
 				return incomp(spec1, spec2, "stem", i, j);
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 273a630a..bc5a6928 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -98,8 +98,8 @@ struct selabel_handle {
 						    const char *key,
 						    const char **aliases,
 						    int type);
-	enum selabel_cmp_result (*func_cmp)(struct selabel_handle *h1,
-					    struct selabel_handle *h2);
+	enum selabel_cmp_result (*func_cmp)(const struct selabel_handle *h1,
+					    const struct selabel_handle *h2);
 
 	/* supports backend-specific state information */
 	void *data;
-- 
2.40.1

