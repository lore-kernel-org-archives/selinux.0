Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E4DC48BCD
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 15:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F836136D
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 15:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhFHQBh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbhFHQBg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Jun 2021 12:01:36 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B452FC0617A6
        for <selinux@vger.kernel.org>; Tue,  8 Jun 2021 08:59:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r7so10720993edv.12
        for <selinux@vger.kernel.org>; Tue, 08 Jun 2021 08:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=w+yWMlseXgD5XDTMV2cty4djn46QT1tcPhKURFHDH8Y=;
        b=Wn//gpbahlOBQGdJ6UfeZ51hnmX37NG14w+FHrWWcpZYRSguIzW7mVqUkSCSKp8e3U
         ZwPSDQnidyOjxtP7v7CP0YRfmvKYtEA1JLj/vJRzcS6zpC6nYh2SSV4XYyiWQU4LLBP0
         Pr9BIiKl11Ur3k0HirklBgQQKjk/RpeFDHdYP7PALwXRbiR6gK047I6bNRW7H74DihkP
         ZM98yNWZNu8kYTfrJGiKtLVqySBNlF7i9ry72/Sotrc9fDmGROJknd4/rphoxng2JCx1
         yL900lttjW76LiE0IuuVscCFNbhx3epEh0S9vACdifwqO7MoYF1Z0+7QRUx0GC+xDJNZ
         dXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w+yWMlseXgD5XDTMV2cty4djn46QT1tcPhKURFHDH8Y=;
        b=krqCBLdHkYv7W9E0fJWgOGPAVQH0QQxPwdMsquSIg/B8umTl6PHSXhqTzdnoMBV0mQ
         bySNec+UDs3UEV7FeXtgV64nH+qIx+5CeW7Eu+u0QcIveg9HHqiTV3AUPsR6X82rLFNA
         TtNssGbolifnQwhl1GXiE3W3pfov9dYmaBCbVqNjVnigHTE52KWaQ/J8fULE2FNGbTec
         Kv8q37peYgsKGqRY5Sv6+xy6tUVlXWyfxJ4Qpcvc7no2RO5RwsP2yh43n6x8rDCA0RCB
         hFb+9seCiQVskSdsnKxYlIXteCcMCv+nZQPJ1RUIwt196ioPggiZy73p/8EKSFkDwB2F
         96bg==
X-Gm-Message-State: AOAM531roJOCo8+gIOr4Ex4yJ+c8lTW6AhivfsH7YHgmDlU+1enU2oHH
        JdRlJYQnfYatJzcZIDi5PmCFb+HXkuY=
X-Google-Smtp-Source: ABdhPJzXjUu8jBuhd3rXZHBPhaM/Zj6GjqYr3Mz0oQ8pASNK1VIlX6SBoPhGP6z9UnO/0AVioP2h4Q==
X-Received: by 2002:a50:9d8d:: with SMTP id w13mr26189090ede.94.1623167969334;
        Tue, 08 Jun 2021 08:59:29 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-183-231.95.112.pool.telefonica.de. [95.112.183.231])
        by smtp.gmail.com with ESMTPSA id n13sm51134ejk.97.2021.06.08.08.59.28
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:59:29 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 18/23] libsepol/cil: drop unnecessary casts
Date:   Tue,  8 Jun 2021 17:59:07 +0200
Message-Id: <20210608155912.32047-19-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608155912.32047-1-cgzones@googlemail.com>
References: <20210608155912.32047-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

`const_hashtab_key_t` is a typedef of `const char *`, so these casts are
not needed.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_strpool.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/libsepol/cil/src/cil_strpool.c b/libsepol/cil/src/cil_strpool.c
index 70bca363..e32ee4e9 100644
--- a/libsepol/cil/src/cil_strpool.c
+++ b/libsepol/cil/src/cil_strpool.c
@@ -47,14 +47,13 @@ static hashtab_t cil_strpool_tab = NULL;
 
 static unsigned int cil_strpool_hash(hashtab_t h, const_hashtab_key_t key)
 {
-	const char *p, *keyp;
+	const char *p;
 	size_t size;
 	unsigned int val;
 
 	val = 0;
-	keyp = (const char*)key;
-	size = strlen(keyp);
-	for (p = keyp; ((size_t) (p - keyp)) < size; p++)
+	size = strlen(key);
+	for (p = key; ((size_t) (p - key)) < size; p++)
 		val =
 		    (val << 4 | (val >> (8 * sizeof(unsigned int) - 4))) ^ (*p);
 	return val & (h->size - 1);
@@ -62,9 +61,7 @@ static unsigned int cil_strpool_hash(hashtab_t h, const_hashtab_key_t key)
 
 static int cil_strpool_compare(hashtab_t h __attribute__ ((unused)), const_hashtab_key_t key1, const_hashtab_key_t key2)
 {
-	const char *keyp1 = (const char*)key1;
-	const char *keyp2 = (const char*)key2;
-	return strcmp(keyp1, keyp2);
+	return strcmp(key1, key2);
 }
 
 char *cil_strpool_add(const char *str)
@@ -73,12 +70,12 @@ char *cil_strpool_add(const char *str)
 
 	pthread_mutex_lock(&cil_strpool_mutex);
 
-	strpool_ref = hashtab_search(cil_strpool_tab, (hashtab_key_t)str);
+	strpool_ref = hashtab_search(cil_strpool_tab, str);
 	if (strpool_ref == NULL) {
 		int rc;
 		strpool_ref = cil_malloc(sizeof(*strpool_ref));
 		strpool_ref->str = cil_strdup(str);
-		rc = hashtab_insert(cil_strpool_tab, (hashtab_key_t)strpool_ref->str, strpool_ref);
+		rc = hashtab_insert(cil_strpool_tab, strpool_ref->str, strpool_ref);
 		if (rc != SEPOL_OK) {
 			pthread_mutex_unlock(&cil_strpool_mutex);
 			cil_log(CIL_ERR, "Failed to allocate memory\n");
-- 
2.32.0

