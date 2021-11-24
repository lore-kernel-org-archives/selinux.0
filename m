Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10D7C433F5
	for <selinux@archiver.kernel.org>; Wed, 24 Nov 2021 19:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239974AbhKXTLk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Nov 2021 14:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350910AbhKXTLf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Nov 2021 14:11:35 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDF1C06173E
        for <selinux@vger.kernel.org>; Wed, 24 Nov 2021 11:08:25 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r11so14900401edd.9
        for <selinux@vger.kernel.org>; Wed, 24 Nov 2021 11:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DvHzWs666aXqrRw4ZTDs15zTNsMxqXc8bxBiSNAXvkw=;
        b=cRYKfcXNnbSag55+WbuToBVfuHJ6u8Nk2O+4RiLwnKQ6pjZNkB9tcr6yWYbUoo2rsp
         Bz2yWanTkBGNZYFZ+yjSuAuXIctCV5noV7UJHD91D1tqf7ZfF0Qjlh6Zb8ZeA0nT17XJ
         lhyYwfAeq6V9g+VvF3MCNIzq3RiNQoHllbsqy1KSf+/VYQrOwYGQwgtJ2kPCNnw5lqiS
         L34ZB68mwp9dJgXKS0Ip8g61UyNMLKT5A8PNmWIxOg1GzdMsO1ossTGzO5C1HTTasKE6
         f2clOxFuGnFhmWsOg0s89oaulEnnI0a4kHh7fhq3pvqBn0tZoJ/tgUW1cC4uneoRkipJ
         5w1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DvHzWs666aXqrRw4ZTDs15zTNsMxqXc8bxBiSNAXvkw=;
        b=lB1hqds33KPe/WvLUV7u3BGIwVM6rhh3pKp8yg/+XceQa2kOOTD5AHsVkt5BRBbYfU
         X9DMPxfSpk5MBCVC1dSlxg6SFuNcNOECcXiXe4sIHD6xNgdCej9zjJyudNcs3ktFCTGU
         Cp53RsAL5V22Kg8oXsqMRV6RdfYEcOAwSMzUw0OvfmcX+mJaeRfBRcX5j+yxOb7IqyJV
         6narUjXvnAK6BHeNPL/aSp085Si/Ue/8QKdKajkJCBAiwos9VOxpxj43B/InfZt034Uq
         RPu8cPwMIRLBpT+HY1VFtSWpI2Cdi+ChJZnjWYPA+cOUm00ENpFulTBGibIk3lfH+m55
         oHHA==
X-Gm-Message-State: AOAM532LfV2cMk+i4iGvtiIqvMA2xz03vk26YtQh+2CJ5DxTiwEIwgNm
        o/kN2ekSszzUI9xZCuomMMXgSGnKTRYuUg==
X-Google-Smtp-Source: ABdhPJzxgz8RbFV8/S5AggNinhgUHbIZ8OI8UwqGX5klSIcnaVH+ktZ+WhJ6fk+LprfK/ldUCg50AQ==
X-Received: by 2002:a05:6402:354e:: with SMTP id f14mr28405367edd.245.1637780903610;
        Wed, 24 Nov 2021 11:08:23 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-008-186-056.77.8.pool.telefonica.de. [77.8.186.56])
        by smtp.gmail.com with ESMTPSA id p3sm339256ejy.94.2021.11.24.11.08.23
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 11:08:23 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 4/4] libsepol: free ebitmap on end of function
Date:   Wed, 24 Nov 2021 20:08:15 +0100
Message-Id: <20211124190815.12757-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211124190815.12757-1-cgzones@googlemail.com>
References: <20211123190704.14341-1-cgzones@googlemail.com>
 <20211124190815.12757-1-cgzones@googlemail.com>
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
index efa136c8..429e61f5 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -455,6 +455,7 @@ oom:
 exit:
 	ebitmap_destroy(&src_matches);
 	ebitmap_destroy(&tgt_matches);
+	ebitmap_destroy(&self_matches);
 	ebitmap_destroy(&matches);
 	return ret;
 }
-- 
2.34.0

