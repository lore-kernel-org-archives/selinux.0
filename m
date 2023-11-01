Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807C6C4332F
	for <selinux@archiver.kernel.org>; Wed,  1 Nov 2023 16:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343951AbjKAQil (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Nov 2023 12:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344048AbjKAQik (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Nov 2023 12:38:40 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B84111
        for <selinux@vger.kernel.org>; Wed,  1 Nov 2023 09:38:34 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so12160352a12.1
        for <selinux@vger.kernel.org>; Wed, 01 Nov 2023 09:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1698856713; x=1699461513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3tx2QOnzAxBCHzl4Tm9cho3HgpSgaUw+gqI0Kv9GR60=;
        b=dZVNojZ2G1ozwgrPS7Rd/DC2VO8l4MPNURgk5rP7B1mJfc2SxfuYGdTw7O+LshuIUN
         ae0ZtOshpBpY3ph3lpWWWcYW34yhTnyKXG/pflftozUyfV1zW+4WBBf6GP637bBaKwt7
         98y94ebBRHk87UxMQxhto+yO5WiE7hT7y+liFjEfN7CoAmj0CsxMvs0LQ9e7eJaeub6y
         2AiEDm6+dz4eDZTRBcO9kSyGHYjxG6MxMZc5SpLa3dS9B06cAdSdwJMUXwOs2FYm4vP0
         YAIm1FQhZjkyTa+FyImX35muCJ2i95IQJ8mWJzoJKHTKWl8nUwSt8Y7IHVA/sdXVD5hn
         9wwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698856713; x=1699461513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3tx2QOnzAxBCHzl4Tm9cho3HgpSgaUw+gqI0Kv9GR60=;
        b=XM0ly9eIFDY0dYgozBCSV7boHLh9vD8ETDSBqRYFw5hGHJwWYWgtjvcH2TjodhSgjV
         pxyd1EhmtGfzMTHiAdLTE6XULA3NJPq3r7xpdilr3KoC07M9oAh7Nb+Z4RdI+z6bn9XN
         OO7zHq3Z9gLKxMWT8dYWD4D2X5nu4+L4Y8TDxQXHdSgvMSA5a2RJgH4KzYKzM2qLDqqE
         6yIQEuEydtPuLk4Mg+RpobqjRtAVwvSriWQ8bTVUps2AtsteZz2HBEHfcEOgqr1uFMU3
         y3bmDBKXt/y5qt3hkv4Od0PJ5RpYpKMeWb4KWYzOfYltWmn2GB5QdiAeYqu/XPQLUI/b
         2KMQ==
X-Gm-Message-State: AOJu0Yxlb6Aky3WZdeeFvTq7a5VSj9fISYbKeqyhkPHyGYmC6712nJiJ
        WyK+GAoGBI9W1p2LwyHJLRpSnDYKQkI=
X-Google-Smtp-Source: AGHT+IHoRuULoCxFyJvk7IdIYN8biMJPFNyh9DXKJtbAhYbXpricpeHnAjfCoVpy1lED5dOJKiymYw==
X-Received: by 2002:a50:8e58:0:b0:543:3df8:cc95 with SMTP id 24-20020a508e58000000b005433df8cc95mr6761445edx.9.1698856712765;
        Wed, 01 Nov 2023 09:38:32 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-116-163-023.95.116.pool.telefonica.de. [95.116.163.23])
        by smtp.gmail.com with ESMTPSA id j8-20020a50ed08000000b0053eb9af1e15sm1245939eds.77.2023.11.01.09.38.32
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 09:38:32 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/3] libsepol: validate default type of transition is not an attribute
Date:   Wed,  1 Nov 2023 17:38:28 +0100
Message-ID: <20231101163830.177769-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The default type of a type transition must be a regular type, not an
attribute.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 892a0ffd..d214bf09 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1105,7 +1105,7 @@ static int validate_filename_trans(hashtab_key_t k, hashtab_datum_t d, void *arg
 	for (; ftd; ftd = ftd->next) {
 		if (validate_ebitmap(&ftd->stypes, &flavors[SYM_TYPES]))
 			goto bad;
-		if (validate_value(ftd->otype, &flavors[SYM_TYPES]))
+		if (validate_simpletype(ftd->otype, &flavors[SYM_TYPES]))
 			goto bad;
 	}
 
-- 
2.42.0

