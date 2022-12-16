Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ADCC4332F
	for <selinux@archiver.kernel.org>; Fri, 16 Dec 2022 17:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiLPRZ0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Dec 2022 12:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiLPRZZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Dec 2022 12:25:25 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC8E70BB7
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 09:25:23 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id 6so1467069vkz.0
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 09:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LNNcWxORnjJcSePomoysyacrLmNVHgNvTRAVoGZJPuM=;
        b=po8vEdiWzYqkWbl7kacZpfy893v3gRAoV9pcEJGUVP/wnv9frxNuyvrN8Jeqk99j9w
         4oFDOiH8Cevg9AkKouMq5m+gDpXRSTbwRpX+i+37Y2pIARZJ0waeF0oOu4hlqZLPMf81
         ncKIFEVzK7ZF2pnbExDrfxOih7kudKGP0qtPew4Pmc4H3VPpmRjziel2Dj3tEzU4fhvm
         3jikSsoex9reFFAepyXQSRPdbwym2xayd1thGbtGI5TflsDvyJrhRg1RKOx7RwXKaGrg
         kScMhFGgbWkRjTTyM9RYLfQlJ0mDd/iIBradbAoVCr+LbRoPMqvCcSPUhP7bl8Tz4nmY
         uqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LNNcWxORnjJcSePomoysyacrLmNVHgNvTRAVoGZJPuM=;
        b=FSv6NmwQp1awUB974tN+BEkGE6nOBysasL/11p4GGEbcUp+OI60oGBB66JBurEJySf
         U5EkR8+hioYKuHWxY9M22X4fk9uhPOpfCJMwmY+rzOg54YSNuKiDCRvMsLkuzRR8qYFN
         Mx1IfJVTMhrExnP7oPXWiOTKbA+H8wb0vhl3kOMXyD7Mp6lyZtzIK318dEOZ5g/YgtGe
         5tsPKC2Ec63m5u5/5IxbDuicwHBNxB7G4OykLdUjja5442eiu1fHnkTDnRPkfwT7TR94
         eOno6+dE6SCvCDZeR913SrM+D0P6jU4rw1YjSFdQYp+00+N9xsS+rQ1St9MEM9wI5ajT
         cQ6g==
X-Gm-Message-State: ANoB5plHPjrUU5Hmvi7TsMvGYIIfly5rgUqRk7F9ILrwcbL5urccxqO8
        c009ZvCgSDThzyGk+2mPZWJokzk3ZE9Rac4=
X-Google-Smtp-Source: AA0mqf7lp0hIOJIssA9VAMc+SuMvepmUwBU+jKSd7ZbSZd5Q2uJQih4PH3qpjyfqhpFo0N9Hv+nFlA==
X-Received: by 2002:a05:6122:2229:b0:3b6:74a9:4da0 with SMTP id bb41-20020a056122222900b003b674a94da0mr27513600vkb.0.1671211522061;
        Fri, 16 Dec 2022 09:25:22 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a29ca00b006f9e103260dsm1868607qkp.91.2022.12.16.09.25.21
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 09:25:21 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] notebook: fix broken sepgsql.googlecode.com URL
Date:   Fri, 16 Dec 2022 12:25:20 -0500
Message-Id: <20221216172520.146814-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

As reported on GH issue #16, the googlecode.com link is no longer
valid, replace it with a working copy.  Thanks to "b4r" for finding
a good URL.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 src/apache_support.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/apache_support.md b/src/apache_support.md
index 48c8293..f53a512 100644
--- a/src/apache_support.md
+++ b/src/apache_support.md
@@ -41,7 +41,7 @@ stack has the following support:
 and Python do have support for libselinux functions in packages: PHP - with
 the *php-pecl-selinux* package, Python - with the *libselinux-python* package.
 
-The "[A secure web application platform powered by SELinux](http://sepgsql.googlecode.com/files/LCA20090120-lapp-selinux.pdf)"
+The "[A secure web application platform powered by SELinux](https://raw.githubusercontent.com/kaigai/slides/master/20090120_LCA2009_LAPP_SELINUX.pdf)"
 document gives a good overview of the LAPP architecture.
 
 ## *mod_selinux* Overview
-- 
2.39.0

