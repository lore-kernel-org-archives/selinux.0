Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C280C433EF
	for <selinux@archiver.kernel.org>; Wed, 13 Jul 2022 14:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiGMOL4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Jul 2022 10:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiGMOLz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Jul 2022 10:11:55 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591EB326FF
        for <selinux@vger.kernel.org>; Wed, 13 Jul 2022 07:11:54 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id b11so20050690eju.10
        for <selinux@vger.kernel.org>; Wed, 13 Jul 2022 07:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3aVSf916MDtcF5XRj5uEjp8oDwGTilyw0x4YsS+vi2Y=;
        b=iVqqRCSFk6Ey/YUe153Q4orL8POzhHdVaGdB4KGbxpXvZiwJ4s4SrvUh8MUS5XyksN
         bMCxyGXzFQlSDJ2+Zrb3twFBhvGC8g7KFYdZUWSBIqeWzUKjwqu/dtKAhibg4sMKJypL
         UBbq9WoAVJ+eBQeLwHq8Y29m1+tWSkTYpeACU28Y+Ln8+1/xi+iRaWCClYT78+Y4E1P+
         05GNx13ayaI8nq8YTE4g0i03MmBwNQZ6x0zrKXj2WXwj8cGU0X2t3WgK94eJ6l3KUFiP
         oMR+sroZy4moCmP3gatDgqNR4QizZVWpXBWgRas8HcgK2fn/Kgf1vruGHKewD6wkN5be
         jaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3aVSf916MDtcF5XRj5uEjp8oDwGTilyw0x4YsS+vi2Y=;
        b=nKCyrSjyvFEprFAznYoCkbD2Hi+IY1e5g8wCPQLznsPApKQM3RTi9HmxmpDHRaZ+JH
         UeFZSb3ObVCeKai4mBLoAeb5bcg+BYs0KxWcWUwWXedfbNv8gghav4GERbk49Fn9zEH4
         E6V9xgMdjnF6UMXP+XsjYtgJtqMv/y8hD5890pxVSraQYKRM6+exD0gThLAA6VQh34Sf
         nwqCQBb7VW8/x32IgrI2O293TWKN5c/xJw6EuYMbmhNCP60JYtjlnThDMxa+AbD5QMlx
         ILaSTy4gYEaj9dTUSERHrEQOFiTTr++u8iX3Lpyj3t/2NLajFAUQL5OgWHLnfEUTgoZ3
         CPVw==
X-Gm-Message-State: AJIora8XIsIMlwHVeDiVxBwzcAtIJTbXb8tx7gOmAMdNk0BbDbLGJp+q
        YSvmeQG24e8pwTbKAU3VtEcs7VKwNO3QKA==
X-Google-Smtp-Source: AGRyM1sEmoRUdw6ZYGAxjzmqqFU6wkkFbMx7ifw4MgdQ6LTPVFvk+dIs2HVZzqxBV8VwRDyytofqmQ==
X-Received: by 2002:a17:907:2d2b:b0:72b:546a:bd03 with SMTP id gs43-20020a1709072d2b00b0072b546abd03mr3954384ejc.149.1657721512845;
        Wed, 13 Jul 2022 07:11:52 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-083-213.95.116.pool.telefonica.de. [95.116.83.213])
        by smtp.gmail.com with ESMTPSA id j21-20020aa7c415000000b0043589eba83bsm8010570edq.58.2022.07.13.07.11.52
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 07:11:52 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/5] libsepol: support const avtab_t pointer in avtab_map()
Date:   Wed, 13 Jul 2022 16:11:45 +0200
Message-Id: <20220713141148.35524-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713141148.35524-1-cgzones@googlemail.com>
References: <20220713141148.35524-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The access vector table itself is not modified in avtab_map() thus
support passing a const pointer.

Logically the content might be changed by the passed callback, but C
does not support transitive const-ness well, and C also does not support
function overloading, e.g. like for strchr(3).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/include/sepol/policydb/avtab.h | 2 +-
 libsepol/src/avtab.c                    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/include/sepol/policydb/avtab.h
index 10ecde9a..e4c48576 100644
--- a/libsepol/include/sepol/policydb/avtab.h
+++ b/libsepol/include/sepol/policydb/avtab.h
@@ -112,7 +112,7 @@ extern avtab_datum_t *avtab_search(avtab_t * h, avtab_key_t * k);
 
 extern void avtab_destroy(avtab_t * h);
 
-extern int avtab_map(avtab_t * h,
+extern int avtab_map(const avtab_t * h,
 		     int (*apply) (avtab_key_t * k,
 				   avtab_datum_t * d, void *args), void *args);
 
diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 7920b60a..82fec783 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -330,7 +330,7 @@ void avtab_destroy(avtab_t * h)
 	h->mask = 0;
 }
 
-int avtab_map(avtab_t * h,
+int avtab_map(const avtab_t * h,
 	      int (*apply) (avtab_key_t * k,
 			    avtab_datum_t * d, void *args), void *args)
 {
-- 
2.36.1

