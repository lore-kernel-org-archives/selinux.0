Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9578C43217
	for <selinux@archiver.kernel.org>; Fri, 12 Nov 2021 15:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2AA560296
	for <selinux@archiver.kernel.org>; Fri, 12 Nov 2021 15:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbhKLPpF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Nov 2021 10:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbhKLPpF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Nov 2021 10:45:05 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F30C061767
        for <selinux@vger.kernel.org>; Fri, 12 Nov 2021 07:42:14 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v11so39385175edc.9
        for <selinux@vger.kernel.org>; Fri, 12 Nov 2021 07:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2SA3ilvrGlPBPDogl9TVQzXjHfAI8JK4B2c5Fk7b0Rs=;
        b=KxxgAC+CswL7ijNrxhcJEdJXDiZuk0/oK4aCAtU4WbeOT00n+/DrI0KeOyOpygl+sT
         SmPFPw7DdxIwPEhl2gUGzQtXFkJref2mbHVRxZN8mW0WAWP4ud0UEajnHkQQM8QugIoa
         vie5P4DR+vqBvxDm5YgjjyH8oq5CMOgFNlZeQE+gUtSaBmg/sEiRTae3YjaJv3OEDKjc
         4pz5rfGSvW6KoKqQXGdt8jFkayJmEn/jlWlm6XjRumuSo7i2G9c1VFe2QZg6ZXPEoH1B
         Jgxe9sFF9XbkZHGNv1Rbb4DkfOj2yV1o7hMR2uWuTHB6iRVvxN10aB+Ruo7m73DrymeA
         E3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2SA3ilvrGlPBPDogl9TVQzXjHfAI8JK4B2c5Fk7b0Rs=;
        b=E1xyRLR8unFY6Kq2MVIPSmsCCjYwPaYrmYclx4XgVu7XKJXaIHtiNFNW4QJFiWLEmE
         ZRWcwY+GtkbdIZqRw4ClGgjxWB7s5VpQLP0H4so3GzJGrJTXIt6Ict/3uah9sH3Hf/iP
         1VirC7vlicpvEXKQUYKC7EDzSwrEqxyLbS0GIUs8h42or8ACOONutsze6bMi5o9C9ASg
         XxpzHcxwR8kf2TlKDmq0qv6hynxUBgBcxzc3r0liNVkZf7wWY2RLLd6MbGQEsKOJ5Ubw
         9Trwl1ywnvpjEZJ9stZwVB/yovVTL/aunrIOwT3g3Fh5cIXPoVPIhoE/MNu67Tun62KZ
         NgCA==
X-Gm-Message-State: AOAM530yaOK1izgwPiLrtKOZKcWcpM2u3k8xuMKx4BuW5tgb3caJSNIw
        xh0NHIEBPStETr0UUNXkHwgEkPwxPh8=
X-Google-Smtp-Source: ABdhPJzXDtjQumQdmkE/w6ixL8jPXmYr6XJSl/+6hRCnA3h3csXx/+IGNHLeLuj4c2tN25eDzIAlUQ==
X-Received: by 2002:a17:906:fcd9:: with SMTP id qx25mr21220294ejb.326.1636731733077;
        Fri, 12 Nov 2021 07:42:13 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-000-195-130.77.0.pool.telefonica.de. [77.0.195.130])
        by smtp.gmail.com with ESMTPSA id m9sm2628914eje.102.2021.11.12.07.42.12
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 07:42:12 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 12/12] libsemanage: add extern prototype for legacy function
Date:   Fri, 12 Nov 2021 16:42:01 +0100
Message-Id: <20211112154201.78217-12-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211112154201.78217-1-cgzones@googlemail.com>
References: <20211112154201.78217-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

    modules.c:171:13: warning: no previous prototype for ‘semanage_module_get_version’ [-Wmissing-prototypes]
      171 | const char *semanage_module_get_version(semanage_module_info_t * modinfo
          |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/modules.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
index b6dd456c..c98df4dd 100644
--- a/libsemanage/src/modules.c
+++ b/libsemanage/src/modules.c
@@ -168,6 +168,7 @@ const char *semanage_module_get_name(semanage_module_info_t * modinfo)
 /* Legacy function that remains to preserve ABI
  * compatibility.
  */
+extern const char *semanage_module_get_version(semanage_module_info_t *);
 const char *semanage_module_get_version(semanage_module_info_t * modinfo
 				__attribute__ ((unused)))
 {
-- 
2.33.1

