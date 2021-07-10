Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E040AC07E95
	for <selinux@archiver.kernel.org>; Sat, 10 Jul 2021 12:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B85BD613C3
	for <selinux@archiver.kernel.org>; Sat, 10 Jul 2021 12:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhGJMM3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 10 Jul 2021 08:12:29 -0400
Received: from forward100o.mail.yandex.net ([37.140.190.180]:48946 "EHLO
        forward100o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232706AbhGJMM2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 10 Jul 2021 08:12:28 -0400
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Jul 2021 08:12:28 EDT
Received: from iva4-b3068118e41e.qloud-c.yandex.net (iva4-b3068118e41e.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:14a6:0:640:b306:8118])
        by forward100o.mail.yandex.net (Yandex) with ESMTP id EB2774AC1E88
        for <selinux@vger.kernel.org>; Sat, 10 Jul 2021 15:03:03 +0300 (MSK)
Received: from iva1-bc1861525829.qloud-c.yandex.net (iva1-bc1861525829.qloud-c.yandex.net [2a02:6b8:c0c:a0e:0:640:bc18:6152])
        by iva4-b3068118e41e.qloud-c.yandex.net (mxback/Yandex) with ESMTP id 40NLsXFKQw-33ICxnEf;
        Sat, 10 Jul 2021 15:03:03 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1625918583;
        bh=Fg05bLZsOOhUt2pGUxpSXVNhsHen0rBZW+S7zNc3ZIc=;
        h=In-Reply-To:References:Date:Subject:To:From:Message-Id;
        b=hxxTC8W5TvgI7oV47Ac+hHBqAcZGEZEmW8H97IpEKB6E8YWruHnMkUFD7BvCeAyp3
         dY5gGgraQDAbcPi27WgMPOFPVUbZfF2Sbtx4QSPKiKj+11siNu9mVQX8qzcVQcPONF
         7AOKlTCwL2dtM3gx4eiGD3QWiPX2G+0+XVo72CYY=
Authentication-Results: iva4-b3068118e41e.qloud-c.yandex.net; dkim=pass header.i=@ya.ru
Received: by iva1-bc1861525829.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id FGY8jxoL3C-33PSM1DV;
        Sat, 10 Jul 2021 15:03:03 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Evgeny Vereshchagin <evvers@ya.ru>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] README: add OSS-Fuzz/CIFuzz badges
Date:   Sat, 10 Jul 2021 12:03:02 +0000
Message-Id: <20210710120302.74862-2-evvers@ya.ru>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210710120302.74862-1-evvers@ya.ru>
References: <20210710120302.74862-1-evvers@ya.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It should make it easier to keep track of what's going on there

Signed-off-by: Evgeny Vereshchagin <evvers@ya.ru>
---
 README.md | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/README.md b/README.md
index 4d33686d..d1338e87 100644
--- a/README.md
+++ b/README.md
@@ -3,6 +3,8 @@ SELinux Userspace
 
 ![SELinux logo](https://github.com/SELinuxProject.png)
 [![Build Status](https://travis-ci.org/SELinuxProject/selinux.svg?branch=master)](https://travis-ci.org/SELinuxProject/selinux)
+[![OSS-Fuzz Status](https://oss-fuzz-build-logs.storage.googleapis.com/badges/selinux.svg)](https://oss-fuzz-build-logs.storage.googleapis.com/index.html#selinux)
+[![CIFuzz Status](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml)
 
 Please submit all bug reports and patches to <selinux@vger.kernel.org>.
 
-- 
2.31.1

