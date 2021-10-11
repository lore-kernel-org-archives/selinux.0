Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677ABC433EF
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A01C60E8B
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhJKQ2p (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbhJKQ2l (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:41 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C9DC061570
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:40 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id d9so46038889edh.5
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pLu4mHkYYQc8z3tNS7PIoIR3+Xtut+2aoaCaP2I/Hvw=;
        b=K/jbieJlq/xUIzTZ80qfZu167/Nv8EL9Z1x4cOyFsm2oA2JBBEgiIrI64HmTvEkv6z
         8ErmnfY3/DSJ1FqTww6AGNSXb7j1IrPB4xihDq8qgF4NHZZyRYylW/m8aaJYacDD/aFo
         G2Ig7ib3niFYGZhYbIq9jjgV7eyZYPyJWcdCfJlPDKmgCc+quwlarewhJ6XYHGuX6Jee
         PI+b3WgRbUyX5h8lt0MPm9StjcbIQNiPJQnHHYkLBZ9qADlUSbkFEuvjSccj/l6+NrvE
         NTAosSJCPjL8YhH6VrPZQGgYZ5l1MUV1sQ0Vlm1GsOVAc1AEQ3RGffgmXNlC+llzl6gD
         cT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pLu4mHkYYQc8z3tNS7PIoIR3+Xtut+2aoaCaP2I/Hvw=;
        b=K2BMwwt8NHwuVpt7P9izwQJXnYNbGe8MyCaR8p4L4tFnSM9tDjQbwb7tDU2qT/ocOC
         0mQL3sYo5kL3fj5CTzY6E9UeJWx2vuGB/lTBJ8fqQE7tYnIGvZ7EOuI8l+EqFXgn3ryx
         UA02w0Uz3UAeBelutRM+VznbQQbgdvR9iNHymokT/rFGqgumQlyOxMEkBWabKCnsYuuV
         +620X/4StBT+fMKwjFfqSuV1X2Gyw7t8VvNpdOILoTLlQErTSY+l80eme7fszo/CY+b5
         yCzRrX0jQnB+C46keOnBZSeLST2Znen6JZQss9sUxO/DeuWy7SVEY9kAz1PsBDGv6ZFi
         tlbw==
X-Gm-Message-State: AOAM531RR6f637/ltpcYa5WDs9pq+g6HStt85zhuFaYXJBso4fytUFzc
        v3VoXv7ejf9zWSzTFmNvabFWPBoMxhc=
X-Google-Smtp-Source: ABdhPJxrHsgPupPqBgoTlHSiM8TgWUgxAFAVDvuJIgJ1fiaFZQubbkrsYYaDjBe2UICWBQUQRD/6pw==
X-Received: by 2002:a50:8d85:: with SMTP id r5mr42414947edh.312.1633969599277;
        Mon, 11 Oct 2021 09:26:39 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.38
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:39 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 34/35] libsepol: use correct size for initial string list
Date:   Mon, 11 Oct 2021 18:25:32 +0200
Message-Id: <20211011162533.53404-35-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use the number of categories not levels, which might be zero, for the
string list initial size of categories.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_conf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 68dd2d32..dcdd4252 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -914,7 +914,7 @@ static int write_category_rules_to_conf(FILE *out, struct policydb *pdb)
 	unsigned i, j, num;
 	int rc = 0;
 
-	rc = strs_init(&strs, pdb->p_levels.nprim);
+	rc = strs_init(&strs, pdb->p_cats.nprim);
 	if (rc != 0) {
 		goto exit;
 	}
-- 
2.33.0

