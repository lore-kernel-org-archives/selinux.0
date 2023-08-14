Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5E8C19F4F
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjHNNVX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjHNNVF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:21:05 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB791984
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:54 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99cdb0fd093so593597066b.1
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019252; x=1692624052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mqA1dkTKcJtEnCLqpqWsbIPplUanIX8ARuR1xEPmv0=;
        b=qLDZpTstKv+o2jZUATf/OhpCb/lDxktg1sUg2dTLP7weFkbPjmR0Fj6tQ49XlkjLYh
         Mz7/k1D2quY2AQ57BaH8Pv02Nfu3aIYqsLQKmTSewxP5IAtYjK8HrC0D8T8+40uQkAZo
         h8PPN9vxRKv7NC2vHAl/Jz1UVUA8H9QqOaawUYKoE8UzTqDDEZrtHP2XUQuxqyUGNSZ3
         b2AABaxkHkeiN7ljo+uIdfp1NpRbt+weQOSR3xx/9lyKtRNTc7jd+ZCgLXQtvHl1WKBm
         FqIwP8OvKTiSCbFlkrzYDZEuYem49SuLE3mAuisTRNW5/8AC7gh0FpD5f6bVKWH/5NF+
         5gEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019252; x=1692624052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mqA1dkTKcJtEnCLqpqWsbIPplUanIX8ARuR1xEPmv0=;
        b=NkGT/r8f0zbwMGHKsLUDKBPm+WS9MIiB6tWaYpbG2tm8CpIIX8ZLXlzBDsCoRYSSuL
         a0w0XYVpCp0vebdk22zpakgVhZWCob5Qbp9RIUWakldjfX/QcJWuZCt+1xL2Ks/zc1Wa
         9IC0RY31t1RbqUXiOY39uKDqDtuJfULmaHYWdITZP0Fqdv2drxK83/ZMrpfmglEX+ATi
         YAwXw1FNseKjy/gE0be0H8w2NgHc5Sc2x50zgbx1N05DFbe4NhjV6BeS2tYf+E0c1qMl
         9SAaICUrRAIRStPJX2xahlZXH8mhJhc+aDBqPUhnYA4dcT047GENVdm47/Lgf1MgZ1Yq
         qvoA==
X-Gm-Message-State: AOJu0Yw3hzPXo0WKsjWsCAbUSIYN5mwYvmgksC737nBnlWNlcLFMYdVD
        9ssBkqUxgzEkilbw2rydTCob9ojGsOM6rYxl8r8=
X-Google-Smtp-Source: AGHT+IGHNfAydA5NFTx+nTIIXZKBYmA62hL/PHX7DvKLUBV/X/q7otULy30xZ+feEBQyGHfhk1f/Jg==
X-Received: by 2002:a17:907:1de9:b0:992:5135:4112 with SMTP id og41-20020a1709071de900b0099251354112mr7375171ejc.32.1692019252365;
        Mon, 14 Aug 2023 06:20:52 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.51
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:52 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 21/27] libselinux: simplify internal selabel_validate prototype
Date:   Mon, 14 Aug 2023 15:20:19 +0200
Message-Id: <20230814132025.45364-22-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814132025.45364-1-cgzones@googlemail.com>
References: <20230814132025.45364-1-cgzones@googlemail.com>
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

