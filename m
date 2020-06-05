Return-Path: <SRS0=iV3B=7S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90899C433DF
	for <selinux@archiver.kernel.org>; Fri,  5 Jun 2020 14:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CCE3206DB
	for <selinux@archiver.kernel.org>; Fri,  5 Jun 2020 14:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dKUD1Tm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgFEOtX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbgFEOtX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Jun 2020 10:49:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB2EC08C5C2
        for <selinux@vger.kernel.org>; Fri,  5 Jun 2020 07:49:21 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id mb16so10428429ejb.4
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2020 07:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0uRZr4ngNSpxUwCPZhlJWfnPlMIUReEsaEr0h/H/sLQ=;
        b=dKUD1Tm39t3mUzW4OglCqXMDTfPXG4hNVd3geMPLC8qaxC5A/SojWaL8blw0N3sudO
         HmCEaT6Jvti6uuneioVv0lWXRxIbnkF5Sw4PObxwo5lu3of32Mj1yy5KnVQsWEMtlHa1
         6Ad+9Ia0ud0d3a2tbT9BC/G9xKhm2BUxY3O4Z5iEwmArv8+vygIvOLnfwbBsmcMN9tB5
         meKLrlG/0Jvw62ymzrylTKVP58Mv3wn3mJ4c8XFHAbwBOp2vGt/gVBaFsdE24zQXFv8h
         t9ARKf1Clay0j43q4q5okt2zxys9M4NqSQq2KTylQC0p4mHBsxftDst9fWW5mnkdKFXL
         r2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0uRZr4ngNSpxUwCPZhlJWfnPlMIUReEsaEr0h/H/sLQ=;
        b=R4Ag4jXQe0eBMFzSE4A+RlechDkKm/ceXaEN4jpMKfD1KqeJ0Gk75JUxehgyObqv+L
         KwDvB3pDUmfGnPOzBJCagVaejbHTSJbcfVWWSTIm0Uf+3dm1yi+ynottBfXNRqi4gbmC
         mJQonuoSPVkYglAHOlnJ5mMF0DbkpN6mx7jLcv8zH+juIOMg0KpxKuQyPQKdJsYZLkZ3
         9ViylffjxN2g1a61C7piCtdwSI2f8IE7KFtuewhzDtGPELBrdy2vi2UTfjCNEzRIJqOk
         HfL6pDTbNGcw3EpabWpUDYgxQ3V4tcH4fN5QgWGGrbnRJpYios2eHv+BZ5bWekx4JT6C
         VEXQ==
X-Gm-Message-State: AOAM532u30MOJWgzQC2sj5yS1kTH7Jqz3gFxdQ/oGwXIuqXhLJ/NkVeA
        FlW6J7ajRnWwOFQEzCe3cCerTOtj
X-Google-Smtp-Source: ABdhPJzuI4zjw1/fwvcKQocbe7I9i2Rj+TniLbDJSdyfG+INd83ksmVg1ZSx4F5eEuHntGVFPV1FFg==
X-Received: by 2002:a17:906:1dce:: with SMTP id v14mr8981774ejh.46.1591368560326;
        Fri, 05 Jun 2020 07:49:20 -0700 (PDT)
Received: from debianHome.localdomain (x5f70b03c.dyn.telefonica.de. [95.112.176.60])
        by smtp.gmail.com with ESMTPSA id a9sm5060948edr.23.2020.06.05.07.49.19
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 07:49:19 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 2/3] refparser: add missing newline after error message
Date:   Fri,  5 Jun 2020 16:49:11 +0200
Message-Id: <20200605144912.22522-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200605144912.22522-1-cgzones@googlemail.com>
References: <20200528125128.26915-1-cgzones@googlemail.com>
 <20200605144912.22522-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3: no changes

 python/sepolgen/src/sepolgen/refparser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/src/sepolgen/refparser.py
index f3e0ae87..9f850990 100644
--- a/python/sepolgen/src/sepolgen/refparser.py
+++ b/python/sepolgen/src/sepolgen/refparser.py
@@ -1148,6 +1148,6 @@ def parse_headers(root, output=None, expand=True, debug=False):
             status.step()
 
     if len(failures):
-        o("failed to parse some headers: %s" % ", ".join(failures))
+        o("failed to parse some headers: %s\n" % ", ".join(failures))
 
     return headers
-- 
2.27.0

