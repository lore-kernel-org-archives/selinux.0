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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A2AC433E0
	for <selinux@archiver.kernel.org>; Sat,  6 Feb 2021 21:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 307C264D99
	for <selinux@archiver.kernel.org>; Sat,  6 Feb 2021 21:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhBFVGL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 6 Feb 2021 16:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBFVGL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 6 Feb 2021 16:06:11 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20FDC06174A
        for <selinux@vger.kernel.org>; Sat,  6 Feb 2021 13:05:30 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id i8so18577724ejc.7
        for <selinux@vger.kernel.org>; Sat, 06 Feb 2021 13:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ro3KoNBDf5RcpE/SlzkdzqJje5AFe0NcvsTf5sCl8z4=;
        b=WcJUR0I4ZwXzrpOwGPfvFJ4vXJRJc5+8y68LDJEtXlELhv5zAbTV/SAbBiEDRjTvvc
         UtB6ZUQ5wIuZIQge3fM9mqNWf9PRUW5oA3bt2JEJ+WP9xWWLSeEdU5etmmTpdx0+7NAM
         HXj6f1v7vxLQZ76oIKdSR8n5a9/1jRUgLiZZItfdg5iUPvzYEDzY2hyk80i8wE5SwDA6
         xrlN2jmOTzhm50LVhFxOwtWr39cvsdTOb1Oc3nAe9gNZWhTGQh8txV7kgdtkszYlyMwP
         5fLqLNcAnjXwwqlw0tJtuwthmVnX37FQN0c8oY0Hu/pR0ZJQeALOXzWCciTKUpZjm5Cq
         hOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ro3KoNBDf5RcpE/SlzkdzqJje5AFe0NcvsTf5sCl8z4=;
        b=N8/OZpmyfIN99uYr+Qx3HP1cSgqXHzBw6pw3spsDZXXHCryT5dsI24xYi0x0z3GBdI
         2EEP+1HpE7MXYwWXopme2m2StCf6QHAvK2nTTNtHzix0ctnEDfJo7I3AdAgDbf82eBbB
         IJUev+StqZRkMOHlstJwiiMzcrsfWKIVkRyhUnEgn1KFmb30h7J41dE3LVl4sVrwtOw8
         AxXU+ZCg9HmwQ60a0bHF5ih54sFVVqhKewdu20PHfqMgPOzeW7O7YgOItPQXdziVc+8t
         8/Z/nPRT06XMbG9yxnx8cV8+EsgRMSxLOoMP4uCvJPIVv1x1SzrEfCtkJRVf0tFFA3N2
         7bdA==
X-Gm-Message-State: AOAM532Pl+88CYn5D98cSSrQ12UPIbkrA6gn+EKlD63+BhbjKRvM9GgX
        FDorDkCKmhJ8CtaQSWEN3zo=
X-Google-Smtp-Source: ABdhPJzsur4DS5RSKoN77LbbtS7csffOhL2k+bEPIhRI5okXIIaEU1e7u0YUPaUDfZSCNJZfEmLJlg==
X-Received: by 2002:a17:906:390c:: with SMTP id f12mr10292699eje.31.1612645529727;
        Sat, 06 Feb 2021 13:05:29 -0800 (PST)
Received: from ?IPv6:2001:a61:340e:e601:8a:719c:9bc1:dcee? ([2001:a61:340e:e601:8a:719c:9bc1:dcee])
        by smtp.gmail.com with ESMTPSA id y8sm5824234edd.97.2021.02.06.13.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Feb 2021 13:05:29 -0800 (PST)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
Subject: [PATCH v2 3/3] secilc/docs: add custom color theme
To:     selinux@vger.kernel.org
Cc:     j2468h@googlemail.com
References: <a8abefda-5c2b-918d-65d9-e21b89e9a2bf@gmail.com>
Message-ID: <3cfe5057-8bfe-4058-a0f2-058ecc480ab9@gmail.com>
Date:   Sat, 6 Feb 2021 22:05:28 +0100
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

