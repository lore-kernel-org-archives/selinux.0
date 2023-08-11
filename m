Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F70C001DE
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 16:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjHKQ15 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbjHKQ1z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 12:27:55 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DDA273E
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:53 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bfcf4c814so300199866b.0
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691771272; x=1692376072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZoB2tNmGWecF5SpS2bhjX6gg76W6vta88m4GAWSsu4=;
        b=j3U7h9gQIvhLKqtLJvrvE66D1oNI8SxObBUdb197mZiJ8hhiq7+DXM1yI7d0Vbg58N
         Uax7M8iqbd8OkyMhRBwBovV2f2qJUZ3ISx+H2It0uGjRZpZS94+12Y1Cqje2LliUvO+q
         GnPZ/Aa2ry3L6vIz/q1Xp+MMd8VqjtXso2GUNzTRA3xyNs1iIgulgisyQO7PViXQ5Ia8
         PZVgDWqhTQzzud1WC/Jt/q0rMV7V6HrcLRjNrrEATQI4iNJzyfQkR3zBbHsJ2jF/Xjg/
         RB5ovUpJsItPo2yjJVJTwhya7WTFJFRtEWSQWL0O72/3/2bSqbUY+yPjfJ8sT5Peo9jj
         Vn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771272; x=1692376072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZoB2tNmGWecF5SpS2bhjX6gg76W6vta88m4GAWSsu4=;
        b=LqCcwqoIXU/HSei3iugQFduLY0o2V+WmAvBmoviCP0Z8p7Bn99X0T1GD+F85g2Aavf
         NCCBomjimb8yrhjcOiQSlIBGKW7IYhJ6j5sKbmtGLKZU+R5VMFSItsyUM8erfG+vGGLj
         OomGby+gvmKR8kXCb9BADGSb6Bp1QHaZhR1Ie7HP/QheNR60L0EHn+4pY5T9mo6ajr73
         IlwifNSmAE+4vDgHFL47OxoSs3iIfb4zJMbjX62AwuVgV+HH9LWOvfizVGFQlwWNIyW/
         XmaEcFBpWgi/In9n1gYKNEmQCm43mPWIYsqWBIbhx3dlaD5McKvR2/Yx7RruN3UAiskg
         KwxQ==
X-Gm-Message-State: AOJu0YzFCe2LZeoxytGv+OkAtTngN/4uGZ0jIc3v2ofv7jGblSYi+xsK
        cfo9rdy7m8klAzyxqQVcl+6if++6nnHBmg==
X-Google-Smtp-Source: AGHT+IG36Gmr01Pv1FjTnS7aMPDnpTecoXtGRlxNKgjEtvN/tNvA9I2bJYY9GzGNsfKN4QTWr67g8Q==
X-Received: by 2002:a17:906:10da:b0:99b:c985:cf7e with SMTP id v26-20020a17090610da00b0099bc985cf7emr2481165ejv.54.1691771271862;
        Fri, 11 Aug 2023 09:27:51 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-174-226.77.0.pool.telefonica.de. [77.0.174.226])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906b20900b00992afee724bsm2408807ejz.76.2023.08.11.09.27.51
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:27:51 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 07/24] libselinux: constify selabel_cmp(3) parameters
Date:   Fri, 11 Aug 2023 18:27:14 +0200
Message-Id: <20230811162731.50697-8-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811162731.50697-1-cgzones@googlemail.com>
References: <20230811162731.50697-1-cgzones@googlemail.com>
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

