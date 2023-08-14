Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBAAC25B5C
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjHNNVZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjHNNU5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:20:57 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF5512D
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:48 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99d6d5054bcso796447066b.1
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019247; x=1692624047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qE3ABhVnQhCHOxyYzH8zSMrW/8rvEczqQ6pQab+oN9Q=;
        b=TI6Ia8qHdzH50ekJRoPl/2//CSmA8C4rh+Zrq5zMHYBuHyI3uFuo8m11YvXs8Tl+XC
         hSUok8GkEa+uv/75XXOagNRDVL6tgI7RT5LCqqQLbUfJZGRWa340Hd05jfN2FJrEdbrU
         MgWlXH3heLTCxnSOvCzq1nrJZLj2yrF6oKyCyCyrAEko8HOHZeRg81uWtkSyFqR5Nefg
         1tcNW8/d3uQIkN2Ry+VYyKGRfV87ndJIh21ZvvPSnNdNEXoVDt8JjGHRjSnDGFgMpF70
         eAuLablkCniaKbCBqUxPpCNVYHzKa7S9SauWwIJj+jNMP0CYsQ1DvnlJp4w9I3A1gHx2
         GK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019247; x=1692624047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qE3ABhVnQhCHOxyYzH8zSMrW/8rvEczqQ6pQab+oN9Q=;
        b=Gy7wdiy4TClMlOlJ4vxsgAB0Iut8vzgjVhCEB2cUXtGKR04DQzxHs55pODX1h4hdcC
         IZFILj1oHx663Y2KKzlNZx8l6kFZ0AzQdIPLTkMo7WQMyR8F560CnBKHq6TRRFCPX1s8
         NX/kGDDpEMOKS/4haAXtkMjN+95t7QUmowWL+hXi5audrOk/WQLpUJkNyQGDfUfr49G+
         pFswgHGOBRi3+pPDXjWW31mj5qyZ6nFq1Bq3Vu5TwxLALVkp5aTsh1LzK1mTC/hBQOnt
         XBxFy66mKxZVhYCMyHArra7tMMZoHr6fCehRIVW7nyVjfznAVduIAOgIbbX1YmKVvNHQ
         9OsA==
X-Gm-Message-State: AOJu0YwBWOwbb8ClirivhmyJ+X5WLvvX3LrGs2XzL/M431keCt8aIWfk
        09JmSselKEKbrrzdX3z+DKhaQzUuh5xp114VjKo=
X-Google-Smtp-Source: AGHT+IGzP3SdIbSVKrtYDIAlCIt4ib4QysDU4hw71srKx7SPxVGrE2gDzwFN3peAAtgx/hHQ75OWMQ==
X-Received: by 2002:a17:907:9623:b0:98e:1c4b:10e2 with SMTP id gb35-20020a170907962300b0098e1c4b10e2mr15145124ejc.20.1692019246863;
        Mon, 14 Aug 2023 06:20:46 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.46
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:46 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 12/27] libselinux: avoid regex serialization truncations
Date:   Mon, 14 Aug 2023 15:20:10 +0200
Message-Id: <20230814132025.45364-13-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814132025.45364-1-cgzones@googlemail.com>
References: <20230814132025.45364-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Check (for the probably impossible) case the serialized data is longer
than the compiled fcontext format supports.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/regex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index 16df6790..88d82fed 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -176,7 +176,7 @@ int regex_writef(struct regex_data *regex, FILE *fp, int do_write_precompregex)
 		/* encode the pattern for serialization */
 		rc = pcre2_serialize_encode((const pcre2_code **)&regex->regex,
 					    1, &bytes, &serialized_size, NULL);
-		if (rc != 1) {
+		if (rc != 1 || serialized_size >= UINT32_MAX) {
 			rc = -1;
 			goto out;
 		}
-- 
2.40.1

