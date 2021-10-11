Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31279C4332F
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CFAB60EE5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhJKQ2j (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbhJKQ2g (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:36 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D452C061749
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:35 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g10so69242331edj.1
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=j90EYZcqqF1wB5E7bK0Mtcxhi5SeIjBfNkP6EzOzIAo=;
        b=PHwJWgXUQ3koI7r3BcBSa8Yk67dt01368xSwDl4MZI+iJ0mS0Xz/VtpMD437UHuMDu
         2uE9iKbd02UzuVyAMhetRwW5lAICuJknUnXqjnw9H5kWBi7koXQ22Qi07dudlShLoUbW
         X1Vq/tp78CXn4o2nSOJFQy+a4hhxmWqWfHrG4XXzr0Bytml0PfG8DAlLDMWsxdiMs2gY
         x9xbsNvTEM4MiVQH+NkZfLAUOioYbvbVO7/vNIthfBLWQUmyM6WxYYOncleix2XseeUv
         nAGSZ2dERj5ldfemycGV7NIuMyB9SLqVpn/kS473lhHnPx4y+hediRopBCuXcEpHqp0G
         qQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j90EYZcqqF1wB5E7bK0Mtcxhi5SeIjBfNkP6EzOzIAo=;
        b=ToK+QbFzU1U83FfPYUHcn5ks40gcckV+CGeT1bpx+q/QqJD/Bw2b1noqBKomMsS40G
         XvIaGMd2FeKDjEAoW83jV1dgYyRzdAh0uvsTJ4YD9KC6AQi0dwRAqzJFm2RoTRdpYQSz
         FDRsOrmMt8RR+9uJLaIkt1IgKbXXIlgorOot2ko8PmPEWtC7VFEvWBA0N5GOy9DMYCPa
         q0KqPKa9UgmANcDrlenSQhaQGHGNd9E3lvbh1R524GAZ7AfiBxaZLaunIfOZi9lLKv/7
         oYNuq20lXMEjy8qBkzveWL9sgMssMPLeNSUcqIsolbdOsek15+0hTPBwf4mQQE7VMDeQ
         ZMVg==
X-Gm-Message-State: AOAM531x15jw8JE4VeTEbYNKt0DZg6ln655f6O1EilW9vpych9TFpvQ4
        9gorpnokXm+Fr8za+8qy4f/RQmj7Ihk=
X-Google-Smtp-Source: ABdhPJzwu4yJZtosl4Xa9SmvlbZNpgNX8yN2BX3iBE3sR/Jbtu4MMj1L5apPsx3ChIKgIdC1EdxDfA==
X-Received: by 2002:a17:907:7803:: with SMTP id la3mr27559960ejc.235.1633969593639;
        Mon, 11 Oct 2021 09:26:33 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.33
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:33 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 23/35] libsepol: resolve log message mismatch
Date:   Mon, 11 Oct 2021 18:25:21 +0200
Message-Id: <20211011162533.53404-24-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 7ec0675c..fa128794 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -229,7 +229,7 @@ static int validate_role_datum(sepol_handle_t *handle, role_datum_t *role, valid
 	return 0;
 
 bad:
-	ERR(handle, "Invalid class datum");
+	ERR(handle, "Invalid role datum");
 	return -1;
 }
 
-- 
2.33.0

