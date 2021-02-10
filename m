Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0830EC433E0
	for <selinux@archiver.kernel.org>; Wed, 10 Feb 2021 16:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D08B764D79
	for <selinux@archiver.kernel.org>; Wed, 10 Feb 2021 16:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhBJQAZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Feb 2021 11:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbhBJQAR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Feb 2021 11:00:17 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BEBC061788
        for <selinux@vger.kernel.org>; Wed, 10 Feb 2021 07:59:34 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id hs11so5153277ejc.1
        for <selinux@vger.kernel.org>; Wed, 10 Feb 2021 07:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1vnGcYMXGo1+WFlsKptwAINmv7vVJYCOEKYbCyY4M3c=;
        b=SvRokLe/gdZ66eGCV0DWNshLVHxiiqNRUcjJs3McmRHA6iy2KdXSucEdRscKuz1/OQ
         foci4PVSc9y4EbeifxUEcgLYJmB7NU4bMXwEVpDIMhxnjAFzM7M8R5IkHmPeNm2yC87d
         H6hJDBKSB/B5k0KDOs4VEH7buitD9puVHWBBvpUv3MindD4sfJhNwhkrQ+pCIHrqwLT+
         Vi08afVncDiekE1N5BvFMao1WOMO5vq9FhKYMqh8VeRlvwIMroK5GRDv7E4JUe/6LD7p
         cZk8eulO2FueSd4g3TqPoM8I4FItHeQkH0+uc2HGuylekClph0WVU24fgx+6MCGfdHom
         ZZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1vnGcYMXGo1+WFlsKptwAINmv7vVJYCOEKYbCyY4M3c=;
        b=dNZ2Gu25jHdbIHvS9hEfKiX4uvBrAohHZEVIxldjGB9O3zvDNTc1ubLIqxwhoOibLO
         uvg9GaAPKo/cLG1qyjxf1pcKQvgjnvf+IC8xI8I2ipanLVelZHwTvPI/RDLBK7J8ebOq
         6HWx+tLHZg+rKypOP6AE+HdoyxvO4Y8AEFVFMmOlMjqjzsSQr6GmoabPO6/ZMfh4SLKm
         BajuEr78WozbNS5CIE/pTAoOA+IE6EEJUJ9QXlkq0pxASj2zqlVV0Jvah3v9ouXtFbPk
         z3E4+oAa3r3WcWNhEpOccdMRbpfPJYIyRHA14zgfBee7ZpmgoEdnkTFzgHo9WViezBjJ
         tPMQ==
X-Gm-Message-State: AOAM533bsn/H8h6QWeQSplI3QGLOnTjiBzyDVfkFBEynt2zh/QyOAL5/
        z696ZPhy5nZI3112ZPp+B/M=
X-Google-Smtp-Source: ABdhPJzXvaaaIHRc+1O0EefMefTm6VOBlX+5hBo4FDgzIer75AtHn7dsIliFjWeE/1GZ5jfhxRru4w==
X-Received: by 2002:a17:907:1629:: with SMTP id hb41mr3428234ejc.197.1612972773008;
        Wed, 10 Feb 2021 07:59:33 -0800 (PST)
Received: from ?IPv6:2001:a61:340e:e601:8a:719c:9bc1:dcee? ([2001:a61:340e:e601:8a:719c:9bc1:dcee])
        by smtp.gmail.com with ESMTPSA id y1sm1384951edq.26.2021.02.10.07.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 07:59:32 -0800 (PST)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
Subject: [PATCH v3 3/3] secilc/docs: add custom color theme
To:     selinux@vger.kernel.org
Cc:     j2468h@googlemail.com
References: <a8abefda-5c2b-918d-65d9-e21b89e9a2bf@gmail.com>
Message-ID: <acce2531-a70b-0df6-e258-d152e5b03bcf@gmail.com>
Date:   Wed, 10 Feb 2021 16:59:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <a8abefda-5c2b-918d-65d9-e21b89e9a2bf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since the default pandoc themes either don't highlight everything or
don't fit the black/white color style of the html / pdf I've created my
own.

Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>
---

v3:
    No changes.

 secilc/docs/Makefile    |  2 +-
 secilc/docs/theme.theme | 59 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 secilc/docs/theme.theme

diff --git a/secilc/docs/Makefile b/secilc/docs/Makefile
index a91bcde0..a03ebeed 100644
--- a/secilc/docs/Makefile
+++ b/secilc/docs/Makefile
@@ -28,7 +28,7 @@ FILE_LIST ?= cil_introduction.md \

 PANDOC_FILE_LIST = $(addprefix $(TMPDIR)/,$(FILE_LIST))

-PANDOC_HIGHLIGHT_STYLE="pygments"
+PANDOC_HIGHLIGHT_STYLE="theme.theme"

 PDF_OUT=CIL_Reference_Guide.pdf
 HTML_OUT=CIL_Reference_Guide.html
diff --git a/secilc/docs/theme.theme b/secilc/docs/theme.theme
new file mode 100644
index 00000000..5ffa9a65
--- /dev/null
+++ b/secilc/docs/theme.theme
@@ -0,0 +1,59 @@
+{
+    "text-color": null,
+    "background-color": null,
+    "line-number-color": null,
+    "line-number-background-color": null,
+    "text-styles": {
+        "String": {
+            "text-color": "#049b0a",
+            "background-color": null,
+            "bold": false,
+            "italic": false,
+            "underline": false
+        },
+        "SpecialChar": {
+            "text-color": "#049b0a",
+            "background-color": null,
+            "bold": false,
+            "italic": false,
+            "underline": false
+        },
+
+        "Function": {
+            "text-color": "#ff9358",
+            "background-color": null,
+            "bold": true,
+            "italic": false,
+            "underline": false
+        },
+
+        "Operator": {
+            "text-color": "#43a8ed",
+            "background-color": null,
+            "bold": true,
+            "italic": false,
+            "underline": false
+        },
+        "BuiltIn": {
+            "text-color": "#ff6dd3",
+            "background-color": null,
+            "bold": true,
+            "italic": false,
+            "underline": false
+        },
+        "Comment": {
+            "text-color": "#bc7a00",
+            "background-color": null,
+            "bold": false,
+            "italic": true,
+            "underline": false
+        },
+        "Keyword": {
+            "text-color": "#28648e",
+            "background-color": null,
+            "bold": true,
+            "italic": false,
+            "underline": false
+        }
+    }
+}
--
2.30.0

