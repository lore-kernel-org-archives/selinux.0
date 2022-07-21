Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D40CCA489
	for <selinux@archiver.kernel.org>; Thu, 21 Jul 2022 15:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiGUPYy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiGUPYw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Jul 2022 11:24:52 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3A27D7BC
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 08:24:51 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t3so2649193edd.0
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 08:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3aVSf916MDtcF5XRj5uEjp8oDwGTilyw0x4YsS+vi2Y=;
        b=IJujrP4rHkJu8eQHnhgNjszkYxvHU3xJWw8N/ZLnLsWdL94rjFhx3w6dXpdaV3GYae
         5htMHZhT1Ty1R8ByvCSiSWsC6yUcxgzXLUExb3v47MeWBCGHTt70wIFvHMIPNVfUUOT6
         ffFNBdLDYWLAjx/g1PJ10//OQZ7y3D6dQFHcymPTK1p3VIwgdSEvBPqgUREz8mGcV+2A
         Ag89zlo5ILitWa7bGt/+4EzlzGwkHi1miHUAQViykz6CKYvb792L12CcZqvwM04mXboa
         7AEZDk2TQ3ti/5hHvh7k+g9Z1BB3HlIf0xVxlNXLojQGHsC4kLGbvHYjt8lYZPZdbUiE
         DHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3aVSf916MDtcF5XRj5uEjp8oDwGTilyw0x4YsS+vi2Y=;
        b=qRwNQYX1DjBul/L0Z1CzEKHNMwyjjjZo9fcwCzmoEOdflo2k0yGJiIPKdQlCtTwXX+
         D7gSz29EF8aseTNzBlY5/d6i71ZvTVnL4fyP+3QJNpN0WEuh5rzkevsLt01VSQob6yYU
         Oz0k8ZktiuYXvTbvdH4We99txFtLTFRalWfhT5HXNdeBJMOyosUKRWMYUfgSjl+mzRD9
         MZG02acCngdbanGX95R7AUsbySHs/d6zehpj8UetV/97il5ICa7PistTArb8KLC6+Cva
         0M8/aobZxpx4AkpotJJN8mjbnGYDzjxTBsLlZoa9nnw3sTe7AFAWQQMfgoxBO2fforJO
         8D0g==
X-Gm-Message-State: AJIora/cmDbb6lgRsOBwcdHoDoNpLrsHXztNsonYCHY9Ttaul5jWEv+Z
        A6azEwEnDhkNyswKfA9nQ7deYzBt2T1LYg==
X-Google-Smtp-Source: AGRyM1vOj/qA2quTWTSf3luXgblDLGKIuBcdzYino62t6sWaY2hy18ggkDfGiLQpo6ItFg1Lhps8sQ==
X-Received: by 2002:a05:6402:2696:b0:43a:de29:96ca with SMTP id w22-20020a056402269600b0043ade2996camr58720809edd.250.1658417090046;
        Thu, 21 Jul 2022 08:24:50 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-209-027.77.0.pool.telefonica.de. [77.0.209.27])
        by smtp.gmail.com with ESMTPSA id d18-20020a056402079200b0043a253973aasm1163486edy.10.2022.07.21.08.24.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 08:24:49 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 2/5] libsepol: support const avtab_t pointer in avtab_map()
Date:   Thu, 21 Jul 2022 17:24:41 +0200
Message-Id: <20220721152444.31690-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721152444.31690-1-cgzones@googlemail.com>
References: <20220721152444.31690-1-cgzones@googlemail.com>
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

