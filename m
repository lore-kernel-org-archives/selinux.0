Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D16C433F5
	for <selinux@archiver.kernel.org>; Thu, 25 Nov 2021 19:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350659AbhKYTag (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 25 Nov 2021 14:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236789AbhKYT2g (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 25 Nov 2021 14:28:36 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F66AC06175E
        for <selinux@vger.kernel.org>; Thu, 25 Nov 2021 11:24:56 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id r11so29524743edd.9
        for <selinux@vger.kernel.org>; Thu, 25 Nov 2021 11:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HI84eHIS+4tyPlr0soyNeYzf+TTUlIxmkh7gUIuUQt0=;
        b=A0/Jk4kf1HrtecuYdFdUAVK5aP1N4eGL0/Yn5PKTiGSWm6xi9MIerUdeo8wgq7sMWX
         79khQYnTNT/iX9F8PTwcJ8LZzDYLgN8qZ6284F9Y5oySuQKeKilaiVkcHX2zY+dOtnU4
         TZ182cb4G2RJE3+Jo8QVNuhGnh8Pm6L5MHM7ckjA9ZUfX20hNxJUFWc0uOYoqhOFFLpP
         9MDfiNousrKoZXxMrM8gxEfQwgEd43qdEs6BIhd9ByrMkLI3uwfU7oF8M6SysY8O992l
         f2mI+fKrEopCCozOcF778rseZIrrYu5fzZfGTPs8xSRxjPttrEvTMjpLuDoYtrQpOTxW
         3O9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HI84eHIS+4tyPlr0soyNeYzf+TTUlIxmkh7gUIuUQt0=;
        b=pzEqAcCr7A8gfuYfGEadnJPV4pfWTqJmUdcGO2PbevrGbEYmjyExaOyz3jSHFk+rGn
         uc0a5ARhg2s8Gc1HMj4kr9cLyb11q1xe+tdLUVTI3LznmvsYzgPrMKUe8CY5SsPxwn+L
         sIo9RVPEN4JVzSHEAbHgppbuSUSLNxGBKRWh7Ggl2kGsQ9PYYftit8zkzOKVYXsWUO6D
         H/JDTZ00rAk8AL4nwG8BZtWhblh/SLa6a++o6q1uRtN44rRl3Du5hBuJ5cmRfbT5MLHa
         PmGjCCY+hYO88sX1ngwPumus4Wg9Bt3P1qAbwG4XwMAzu3XbIm1KTCOQSXM788d/QsCN
         h/Dw==
X-Gm-Message-State: AOAM531TmVYOU+OIHTuieeUWYr42S3QoD1arYQlE8OVEVZA/qbweQaFt
        B1dYWSzbfARtVPklJT9JP2ATL3lfThATsNpY
X-Google-Smtp-Source: ABdhPJxgmqFE1iveUlHtidAFir7cjA2mt/stiRE2hUUeFpzrdYzpZipZhajVAryDhaYMoRaVOiwDGA==
X-Received: by 2002:a17:907:7213:: with SMTP id dr19mr33886601ejc.157.1637868294769;
        Thu, 25 Nov 2021 11:24:54 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-112-150-062.95.112.pool.telefonica.de. [95.112.150.62])
        by smtp.gmail.com with ESMTPSA id r11sm2831490edd.70.2021.11.25.11.24.54
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 11:24:54 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: free ebitmap on end of function
Date:   Thu, 25 Nov 2021 20:24:47 +0100
Message-Id: <20211125192447.190954-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/assertion.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index dd2749a0..8abb5adb 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -441,6 +441,7 @@ oom:
 exit:
 	ebitmap_destroy(&src_matches);
 	ebitmap_destroy(&tgt_matches);
+	ebitmap_destroy(&self_matches);
 	ebitmap_destroy(&matches);
 	return ret;
 }
-- 
2.34.0

