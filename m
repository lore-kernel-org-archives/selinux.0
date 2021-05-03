Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B720C433ED
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1D3961244
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhECRy4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 13:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhECRyv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 13:54:51 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4B9C061761
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 10:53:58 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b17so4292580ede.0
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 10:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PR3K+awGkRMcy1+IeKglsEg2qWTUDuhLCNwgWilDMRo=;
        b=as827ohyJWAofLh5pe4iYSU38rzdLO2L5p611+Xmrgvc8WI7MsA8QMoBQVcer4BRnd
         hVAtcoEYCqdmayayFO3rF2ef7coNXTZook/U0EkvjXUt+5IG3WYk+NsQz3531QqBCqCW
         7Uzt+HUVYn6CJkl+bu8RTSUAUBxkvt4xS3f/Iu0ixI176+f0rRdiLG9szsuY3/orvs1a
         HRgbbZF8hlKqXGHkd63JDldKk6HMSA5GD/aDaCN+N1DCEARP+CfANYhg2iwQYlNiGzKg
         tGwDt7IKwX/pKRPxFFIYtwrjoeSPrtjaT9rB9xhawF4aomFStpazmW+WHaVJSYc8lm7P
         nTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PR3K+awGkRMcy1+IeKglsEg2qWTUDuhLCNwgWilDMRo=;
        b=R8GoNOdTAOp5TQ+oiPbFLD7TaM0YUCvI4iKrPvekdfEYXPAXBi+avc1NEah7jImfUY
         irWOFriDj865qTjtTPU9jwsFS5ycCoWOVipv79j6FERNxOr8pkUJ8fRRMkR35ln1F/Tr
         3xiSV3crO6AjO3q3iCmrXUXVPvSrxaeUL/kfTFVccSeWp2HzRhStQJjmu580lazpCb/t
         nh1jlOiejlz5YhxZOadH1KTwroWhIQaIctH1x5oglE65tjGuCjWUyS2ctzcXIj4Z+ADM
         fQHOQ7bQIBNW9vC6rBlYa9G1W2RLoZf5AJdBjgtOgQnchm88j34ZZgF89Uh/7O6FDHYC
         zFgQ==
X-Gm-Message-State: AOAM533coioeGF1PHaPA6P0u1kUwmYPAQMUrqcF+mfJKAy7fj1Vu7xBQ
        kcm2jPkguClA8BcikHRlRleYb3wD29THyA==
X-Google-Smtp-Source: ABdhPJzIRefKrDGAZ4+gKHC56cpAZEEzWygUnQy9ZyYKTtjGB4DYUYQVg/Y0TX5fglfsTjAGVRzydg==
X-Received: by 2002:aa7:dc10:: with SMTP id b16mr21791318edu.258.1620064436726;
        Mon, 03 May 2021 10:53:56 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-172-037.77.0.pool.telefonica.de. [77.0.172.37])
        by smtp.gmail.com with ESMTPSA id b17sm1830165edr.80.2021.05.03.10.53.56
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:53:56 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 03/25] libselinux: label_common(): do not discard const qualifier
Date:   Mon,  3 May 2021 19:53:28 +0200
Message-Id: <20210503175350.55954-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503175350.55954-1-cgzones@googlemail.com>
References: <20210503175350.55954-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

As the const qualifier is discarded in label_common(), do not return a
const qualified pointer pointer from the local function `lookup_all()`.

label_file.c: In function ‘lookup_common’:
label_file.c:994:24: warning: cast discards ‘const’ qualifier from pointer target type [-Wcast-qual]
  994 |  struct spec *result = (struct spec*)matches[0];
      |                        ^

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_file.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 726394ca..4d4e3a76 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -845,7 +845,7 @@ static void closef(struct selabel_handle *rec)
 // Finds all the matches of |key| in the given context. Returns the result in
 // the allocated array and updates the match count. If match_count is NULL,
 // stops early once the 1st match is found.
-static const struct spec **lookup_all(struct selabel_handle *rec,
+static struct spec **lookup_all(struct selabel_handle *rec,
                                       const char *key,
                                       int type,
                                       bool partial,
@@ -861,7 +861,7 @@ static const struct spec **lookup_all(struct selabel_handle *rec,
 	unsigned int sofar = 0;
 	char *sub = NULL;
 
-	const struct spec **result = NULL;
+	struct spec **result = NULL;
 	if (match_count) {
 		*match_count = 0;
 		result = calloc(data->nspec, sizeof(struct spec*));
@@ -987,11 +987,11 @@ static struct spec *lookup_common(struct selabel_handle *rec,
                                   const char *key,
                                   int type,
                                   bool partial) {
-	const struct spec **matches = lookup_all(rec, key, type, partial, NULL);
+	struct spec **matches = lookup_all(rec, key, type, partial, NULL);
 	if (!matches) {
 		return NULL;
 	}
-	struct spec *result = (struct spec*)matches[0];
+	struct spec *result = matches[0];
 	free(matches);
 	return result;
 }
@@ -1054,7 +1054,7 @@ static bool hash_all_partial_matches(struct selabel_handle *rec, const char *key
 	assert(digest);
 
 	size_t total_matches;
-	const struct spec **matches = lookup_all(rec, key, 0, true, &total_matches);
+	struct spec **matches = lookup_all(rec, key, 0, true, &total_matches);
 	if (!matches) {
 		return false;
 	}
-- 
2.31.1

