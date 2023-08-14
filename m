Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D5BC10F1A
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjHNNVV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjHNNVD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:21:03 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01D61736
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:52 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-997c4107d62so576367166b.0
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019251; x=1692624051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEHJ9A5IiHK7rkzOyAH9B21P48m0kTXcW6LRMfoByDU=;
        b=mQF1MSm841AI5i5ZkRLT6zGf9i4bNyQ9LFAY31np+tlTK/ToYAdr8oHbVZJybmyA0F
         Pzh5zOHrzKtF6irgOWesOnvFYdkR/zizQqnWTqH5sbk6QQbpJAUsmFm3mrAoQxpMuGP4
         yLLIkeiV5ulqWcH6Q4Dflc9HfqjKsWE20O08S32v1ks3iKqqvrfIE0mGI2+IoXP8vdN3
         +iwziZQ+NDC3bWVpUWG5Z+a6Mwpi98RjizbKP8S18K3bw187Z4t+cbClVfcLNdzczSxF
         w2IENYK+yh0XYG+kfrPUJE/qqQtUdL+G76oTIjxL/EWfocp6W+RUjEGZisFYDbYErpRO
         91zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019251; x=1692624051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PEHJ9A5IiHK7rkzOyAH9B21P48m0kTXcW6LRMfoByDU=;
        b=DRM4TavWWSr9O/ORdAEW6S0l8TiiEjQCnEPREExzOv8+r9zSmBF9k9FMUfDWBBo/mz
         ia0ZPjg3OHKkJFTGLIudO+vTTg/FwXFVajlZ3ZZ2Wzux8Wkrzow+8LYyW6JKccN1ZTWZ
         F8yE9m854iqEIfFJMtSdEUIJYMSxawOUgvIb8tPTng/95aPEygJAKz9qlM3OYs0qzOlF
         JxfqmaZbLDLhpxIO0OT6sDVp2DEJ5pyH5sk89wM873nMYdlPMO2GbswiwFUS3Eox4TtZ
         A2j7zdjhroJLbmUpsqFYbbxxxu4gO0qLRV1PMhM+IdQxQm8mK5EhIs4Ud30VoFjVje6x
         SA+g==
X-Gm-Message-State: AOJu0YwY4FZNMRoaJuqJyXjWYkuXDTDjB6PQ7ncqynY9Ie34u25DUBJ4
        bP0RpklTH2udRoTLLpe+w+RvcqZX/3y87gHeQvE=
X-Google-Smtp-Source: AGHT+IHIfWZ3XlD6t7RgD95O0vw9Xj/Tfgdv+MfM5tqHlYkBpPfhJMqM8mvC9ludgP5S6dfkklunmQ==
X-Received: by 2002:a17:907:7886:b0:994:54af:e282 with SMTP id ku6-20020a170907788600b0099454afe282mr8738566ejc.10.1692019251173;
        Mon, 14 Aug 2023 06:20:51 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:50 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 19/27] libselinux: avoid unused function
Date:   Mon, 14 Aug 2023 15:20:17 +0200
Message-Id: <20230814132025.45364-20-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814132025.45364-1-cgzones@googlemail.com>
References: <20230814132025.45364-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Define selabel_subs_init() only if its call-sites are enabled.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index f9f4648a..471fd56b 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -674,6 +674,7 @@ static char *selabel_sub(struct selabel_sub *ptr, const char *src)
 	return NULL;
 }
 
+#if !defined(BUILD_HOST) && !defined(ANDROID)
 static int selabel_subs_init(const char *path, struct selabel_digest *digest,
 		       struct selabel_sub **out_subs)
 {
@@ -756,6 +757,7 @@ err:
 	}
 	goto out;
 }
+#endif
 
 static char *selabel_sub_key(struct saved_data *data, const char *key)
 {
-- 
2.40.1

