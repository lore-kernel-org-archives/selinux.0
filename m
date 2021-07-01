Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA00C11F64
	for <selinux@archiver.kernel.org>; Thu,  1 Jul 2021 18:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7372261402
	for <selinux@archiver.kernel.org>; Thu,  1 Jul 2021 18:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhGASlM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Jul 2021 14:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhGASlM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Jul 2021 14:41:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7193EC061762
        for <selinux@vger.kernel.org>; Thu,  1 Jul 2021 11:38:41 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id o5so12031559ejy.7
        for <selinux@vger.kernel.org>; Thu, 01 Jul 2021 11:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sPIG4k7cOyndmIWVgzxhUQRlIWAHqAGVoByesTbVwaM=;
        b=TlX7jgpI3WdSUXmhNWyF8+Embz1OuvwOA9ajHWVUrMp0c/rBBk5cIJ88Y6NkAqim+Z
         0dML9sr3OPYm6WZJIBQ1H8jqrlkMpWKbX7OL/G5aMk/hCbKXk5aSxv8l9tibsk3Yf6cY
         LsfxBKjH57lGHSg0HXe0cRe6dYmyurKZWbpkqef/yuM7+BIth9dBSEeLlwYI6qLNx24t
         aQja/kcqf4nPUrQ5iirfyBzMENwLsM01SSC046aySf36lgYPXwIzuqnZON2zKUB/Y49B
         iVdMdjOUToJe85lZ9q1cUaLOg4qeNbnivsSB75f0xw178VwcZJQtVW53v+S9JmfkzTiW
         ihEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sPIG4k7cOyndmIWVgzxhUQRlIWAHqAGVoByesTbVwaM=;
        b=WGwmwQ7WmtouOG630ePqtowZ7YITadbde+reMf3KX9v6tbmmnjMghUa5QEWkYBrcMd
         RaGtrBihSRFF8YthCYBn3gTfKP3Md5fBod3YzRc4Fz4vW+imQp+Rx7lk23OXrRgnG94+
         Z+82ZrueXnYNqGtOS4mBtcnQjXfFM70Fxvk+77XsJTMzig/W5Xk0wAaT1JbZUNs9WPfH
         7xnPTMUxWve3wmql0EQmmVYks9eHB03t8TACKEBXdeQUDoepKH/aZMMaWcpmYIPiGlBy
         b21Ud7Jfg/GlreL4VtwFlSsA1k3CJA5nhu/5LnseZVSOGOGHkpp1FiKPyhmy5Oax7CQl
         8xHg==
X-Gm-Message-State: AOAM5311V9JgMzN+ltcgkQmH7YufN62NELBvoS+p49tgJtAUXihOlWIW
        7wtV172Kj+eq8GN13bKLxkM8qq7aS5I=
X-Google-Smtp-Source: ABdhPJw8wdn7YPs89Vq9/wT8NzhtVrwKfbzsyYiy0VyiEDQvHgEH/LNd7B0quSR1ENU4lAr28GmjRg==
X-Received: by 2002:a17:906:28d5:: with SMTP id p21mr1394587ejd.358.1625164719777;
        Thu, 01 Jul 2021 11:38:39 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-006-223-136.77.6.pool.telefonica.de. [77.6.223.136])
        by smtp.gmail.com with ESMTPSA id gl26sm217532ejb.72.2021.07.01.11.38.39
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 11:38:39 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2] libsepol: avoid unsigned integer overflow
Date:   Thu,  1 Jul 2021 20:38:33 +0200
Message-Id: <20210701183833.146592-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210701183430.145934-1-cgzones@googlemail.com>
References: <20210701183430.145934-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Unsigned integer overflow is well-defined and not undefined behavior.
But it is still useful to enable undefined behavior sanitizer checks on
unsigned arithmetic to detect possible issues on counters or variables
with similar purpose.

Use a spaceship operator like comparison instead of subtraction.

Modern compilers will generate a single comparison instruction instead
of actually perform the subtraction.

    policydb.c:851:24: runtime error: unsigned integer overflow: 801 - 929 cannot be represented in type 'unsigned int'

This is similar to 1537ea84.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index ef2217c2..5ee78b4c 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -843,15 +843,15 @@ static int rangetr_cmp(hashtab_t h __attribute__ ((unused)),
 	const struct range_trans *key2 = (const struct range_trans *)k2;
 	int v;
 
-	v = key1->source_type - key2->source_type;
+	v = (key1->source_type > key2->source_type) - (key1->source_type < key2->source_type);
 	if (v)
 		return v;
 
-	v = key1->target_type - key2->target_type;
+	v = (key1->target_type > key2->target_type) - (key1->target_type < key2->target_type);
 	if (v)
 		return v;
 
-	v = key1->target_class - key2->target_class;
+	v = (key1->target_class > key2->target_class) - (key1->target_class < key2->target_class);
 
 	return v;
 }
-- 
2.32.0

