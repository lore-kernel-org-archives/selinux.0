Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2489CC433FE
	for <selinux@archiver.kernel.org>; Fri, 12 Nov 2021 15:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 044DB60273
	for <selinux@archiver.kernel.org>; Fri, 12 Nov 2021 15:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhKLPpB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Nov 2021 10:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbhKLPpA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Nov 2021 10:45:00 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C714C061766
        for <selinux@vger.kernel.org>; Fri, 12 Nov 2021 07:42:09 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id v11so39384216edc.9
        for <selinux@vger.kernel.org>; Fri, 12 Nov 2021 07:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qBVYVTKeINuYfURZkoIS5asExrr2DTxM1QXEJbOD4c0=;
        b=CQ6YfIc+2MzVVdKQmRFiCdsbPSQwEmH20zOnDpGR5BZPQs9OCOGu9dUDwtUuXb+4o6
         Ed75fIamyD5oILcLTGuxaiG2/9qUNf5nDUCu1pK+3OY+G3DUjTHI4+Bnw5dcDxAFbwcf
         3TrtdPc9xd3xAkoUs6gFPrQeJHzUIkKejjKNpD1DXUp+5nHYO8yG8mpPiFw11ci8fHqq
         GP+yECat23gq1VRIQoLMCVSlp9QIfR5fA12IuESv5xeCaw2C/ZVgyxXN0EAn0v4kgACU
         aKf6Yx/8AyKXUJznsGJkOL4GI3sB17xDxPiBtNFTXnJuiOKYpT27clndSgokUiLVS8AW
         QJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qBVYVTKeINuYfURZkoIS5asExrr2DTxM1QXEJbOD4c0=;
        b=WhYOqnGduHjcv1dpNEo40+JHhmtX4bFpv3+uIDBXoWr428TOLfnNeRzHj9BokmPi11
         7D1TnMShAbnTZPrI7TYE88c62LlioMzEQ4Zr329UYVPsNy00n/dS/AMSffXx74dkd5ox
         z/hNAq3uGwrEutNWSw3pVPtZ4atUgWNFjQjtWqNSUNWD5UhsaFQdaCQbJFiF7iocMsxw
         BmJ6ZgeEoQ+bYm+uRgbI+wDKrGULQsL5iiKmiL07WJPxrqi6XDM8mXOFtwhqAXC2heI5
         BmMpeS4OxK3rLyq4mTR3Wm7HKDEBZPCfwMA4h3pDOks5PcZtbOz7XNDMAHoKgTjYNZGm
         /lTQ==
X-Gm-Message-State: AOAM532DBz7cmCS5usfwozGaDCOYktqn3FYNWxftFhqk0aCbesRfT21W
        Je14RWcHi7+k+h2/oAQQw4td6MF3AC0=
X-Google-Smtp-Source: ABdhPJyYVgWnQOElkW20IVT6aQkUCK942/qdsIQCznr2kkPOz7IP2Ha94hhe6UiCiZsVbDGxCCbQpw==
X-Received: by 2002:a17:907:a426:: with SMTP id sg38mr20548653ejc.392.1636731727876;
        Fri, 12 Nov 2021 07:42:07 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-000-195-130.77.0.pool.telefonica.de. [77.0.195.130])
        by smtp.gmail.com with ESMTPSA id m9sm2628914eje.102.2021.11.12.07.42.07
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 07:42:07 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 03/12] policycoreutils: use string literal as format strings
Date:   Fri, 12 Nov 2021 16:41:52 +0100
Message-Id: <20211112154201.78217-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211112154201.78217-1-cgzones@googlemail.com>
References: <20211112154201.78217-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use string literal as format string so that compilers can validate the
count and types of the inherent arguments.

    sestatus.c: In function ‘printf_tab’:
    sestatus.c:175:16: error: format not a string literal, argument types not checked [-Werror=format-nonliteral]
      175 |         printf(buf, outp);
          |                ^~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/sestatus/sestatus.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestatus/sestatus.c
index ceee0d52..538c73bc 100644
--- a/policycoreutils/sestatus/sestatus.c
+++ b/policycoreutils/sestatus/sestatus.c
@@ -170,9 +170,7 @@ void load_checks(char *pc[], int *npc, char *fc[], int *nfc)
 
 void printf_tab(const char *outp)
 {
-	char buf[20];
-	snprintf(buf, sizeof(buf), "%%-%us", COL);
-	printf(buf, outp);
+	printf("%-*s", COL, outp);
 
 }
 
-- 
2.33.1

