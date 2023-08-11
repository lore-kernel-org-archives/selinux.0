Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DF0C04E69
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 16:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjHKQ2D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbjHKQ2B (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 12:28:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1AB18F
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:28:00 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9936b3d0286so310133866b.0
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691771279; x=1692376079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mqA1dkTKcJtEnCLqpqWsbIPplUanIX8ARuR1xEPmv0=;
        b=D8qjz0UNYnjevk9U2AX+D6Fcgkw7m6bRMdJfNnUYawPI8xU6otfB39cFQMLOtPINKG
         ZkIuCHO1eRS2uCm3rWlqg18jYKEgExWiQAi+uRGfxq44BPDXM6turNBwuRa8Q3dU77fA
         sposKNTRX+JY7gyIP2TvNxYcZEuniyhHtZ6rWQo7FvLZIznO4zcFfEFWS/sZNq/6q2Z3
         QmAGkVpXbv+bNg4cKF/vDn5EoMA3/Dh9j5dgIg46T4OMHSM0zBjto5Y5pmuH8pQ/OPWM
         ccMmAy0kGCqT9louOtC/O7WfmLpNB49PWGTo3OxETLoQgRzdipBzoVvps5siz8vq21la
         sShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771279; x=1692376079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mqA1dkTKcJtEnCLqpqWsbIPplUanIX8ARuR1xEPmv0=;
        b=gynKQL1aCfhMSUrrdITIngvwYIh1U5gxbwN1buRGVKBRMJs1P90DI2dbc4ilZ50ort
         RtZWwL85wBcZJ+kHxSwMHm08XC/i0TFfy/Suu8USMJfWIxbzZcc88MorfcO1OY/xS4iW
         MT1oWzD/7TWp90J1pD5DIyHNwIxrjAvp6CivwKfGxdJjSTl66C4uqHC5pPxkT4RcY4DW
         spJggWBVwuLKZlHXijTfR4MQ3p+GtjkwA+ScfXwHvljMZiWhFxHuv+pSg2Y3i4RKmWfS
         utQPJmItlEwFf/PUZAomBxEQSQ8gFVXM1PwbrX9+3rsZ0I2ufNeNADp35Q+LGq6tdoZS
         40ew==
X-Gm-Message-State: AOJu0Yxd6uMkat+9HbRQ9lyhPxqmYfrbEODs1OYNrwbDS2Xy1eRhFsGT
        8l0WYBHD67soDfvIHipNVW7W+g0VOQJ4hw==
X-Google-Smtp-Source: AGHT+IEGdIowK40F/95pzzsaM1KB0E2SEemCgZQylIe6tbbw1CXcorhzg4JYmiwlWRAFBn8vnQwNlQ==
X-Received: by 2002:a17:906:9be2:b0:99b:c1af:17ea with SMTP id de34-20020a1709069be200b0099bc1af17eamr2286153ejc.15.1691771279140;
        Fri, 11 Aug 2023 09:27:59 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-174-226.77.0.pool.telefonica.de. [77.0.174.226])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906b20900b00992afee724bsm2408807ejz.76.2023.08.11.09.27.58
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:27:58 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 21/24] libselinux: simplify internal selabel_validate prototype
Date:   Fri, 11 Aug 2023 18:27:28 +0200
Message-Id: <20230811162731.50697-22-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811162731.50697-1-cgzones@googlemail.com>
References: <20230811162731.50697-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Move the check whether to validate or not to the caller, to avoid all
having to carry the complete selabel_handle around.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label.c                  | 5 ++---
 libselinux/src/label_backends_android.c | 2 +-
 libselinux/src/label_file.c             | 2 +-
 libselinux/src/label_internal.h         | 3 +--
 libselinux/src/matchpathcon.c           | 7 ++++---
 5 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 9a972f79..1ea9bdcd 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -119,12 +119,11 @@ static inline int selabel_is_validate_set(const struct selinux_opt *opts,
 	return 0;
 }
 
-int selabel_validate(const struct selabel_handle *rec,
-		     struct selabel_lookup_rec *contexts)
+int selabel_validate(struct selabel_lookup_rec *contexts)
 {
 	int rc = 0;
 
-	if (!rec->validating || contexts->validated)
+	if (contexts->validated)
 		goto out;
 
 	rc = selinux_validate(&contexts->ctx_raw);
diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/label_backends_android.c
index 6494f3cd..cd3875fc 100644
--- a/libselinux/src/label_backends_android.c
+++ b/libselinux/src/label_backends_android.c
@@ -126,7 +126,7 @@ static int process_line(struct selabel_handle *rec,
 		spec_arr[nspec].lr.ctx_raw = context;
 
 		if (rec->validating) {
-			if (selabel_validate(rec, &spec_arr[nspec].lr) < 0) {
+			if (selabel_validate(&spec_arr[nspec].lr) < 0) {
 				selinux_log(SELINUX_ERROR,
 					    "%s:  line %u has invalid context %s\n",
 					    path, lineno, spec_arr[nspec].lr.ctx_raw);
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index a5677411..64b58d42 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -404,7 +404,7 @@ end_arch_check:
 		spec->lr.ctx_raw = str_buf;
 
 		if (strcmp(spec->lr.ctx_raw, "<<none>>") && rec->validating) {
-			if (selabel_validate(rec, &spec->lr) < 0) {
+			if (selabel_validate(&spec->lr) < 0) {
 				selinux_log(SELINUX_ERROR,
 					    "%s: context %s is invalid\n",
 					    path, spec->lr.ctx_raw);
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index bc5a6928..ea60cd9a 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -118,8 +118,7 @@ struct selabel_handle {
  * Validation function
  */
 extern int
-selabel_validate(const struct selabel_handle *rec,
-		 struct selabel_lookup_rec *contexts) ;
+selabel_validate(struct selabel_lookup_rec *contexts);
 
 /*
  * Compatibility support
diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 971ace62..4ed25ce9 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -46,8 +46,8 @@ int compat_validate(const struct selabel_handle *rec,
 		rc = myinvalidcon(path, lineno, *ctx);
 	else if (mycanoncon)
 		rc = mycanoncon(path, lineno, ctx);
-	else {
-		rc = selabel_validate(rec, contexts);
+	else if (rec->validating) {
+		rc = selabel_validate(contexts);
 		if (rc < 0) {
 			if (lineno) {
 				COMPAT_LOG(SELINUX_WARNING,
@@ -58,7 +58,8 @@ int compat_validate(const struct selabel_handle *rec,
 					    "%s: has invalid context %s\n", path, *ctx);
 			}
 		}
-	}
+	} else
+		rc = 0;
 
 	return rc ? -1 : 0;
 }
-- 
2.40.1

