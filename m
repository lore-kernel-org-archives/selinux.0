Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FAEC433EF
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbhLIQzJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbhLIQzI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:55:08 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E51C061746
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:51:34 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id o20so21701253eds.10
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fNb1TvcUD2aDc/iSCEfcSHcpWweiw/5MjB5LTKFUIX8=;
        b=gfzHJRlDPtkggaWW+J0zxSfk4dvtkoEiS5wRP7MWgrkUjtnoldzT7JCx5dbDUiyf5x
         Xfd6YM9t8XaSenicoMiZHmpAokbDzIOYXAFe2Lrkx58TbxGnuonaW4K0vbNdufD2erOz
         kyKKBln0x9oUlE9J5QJzOARhDIer83i+KblV1tC1m68iQA7REHAumz80WfhDf83cn+XT
         1owDMJ4Nu3t9cLFW53Ry2hYE0IkIt0JoaWlIdipW0ZQ8KS91FnRh8VBk22mYft7ZcQUy
         aZqOAfUg1SQ/tkkkdGitMdwpa2y0lN7eiIYt6KU2gcgRIYGph8MqNWEtpM9Yf0e9aomn
         tvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fNb1TvcUD2aDc/iSCEfcSHcpWweiw/5MjB5LTKFUIX8=;
        b=q778uJKbieTgYZbbUFRyyQMDauq8snPySEi+8zvR4++ONpEF5sNLGihlt+mSQQIB4u
         +uLdq5H7nxhAjr6yaV2g1ku/2GYnPHHWG3Atkofj2Auko3qQ5cJ0DbQi/o27Rv2G15B2
         /c30E8G2IE8ex9KGeP6jt/hdGe7NzRNpE724/NhdS937f3jKZJhsOw+RDMDsw8Q8QNH2
         pK5X/BmMiEavfXEPfZIw3z4mLnoHZd59GHOw/1avlN9rMhmOE3hCH9qk25HX4QFfjquz
         6zt4lZqG5v48SGP0UCuXSpuAQ4W5EKViKB0E7Ru16GalmtSdcIxow+T1dhdsWR6zHMA4
         1JbA==
X-Gm-Message-State: AOAM532iTKf0oftATPxKGbijOhBzTb3LIcIkqFcLveKEnCm/3i+HAhyw
        6xiV9qTo6gGbKvQzZU92+tekRrUDveA=
X-Google-Smtp-Source: ABdhPJzRUOLACYdd2L5qEkyNM6gqfqYiAY0+MjfMNEZ1FFpjjHsjn4dVNnmZev0B2JhLFgBhM0eLCA==
X-Received: by 2002:a17:906:730f:: with SMTP id di15mr16973533ejc.22.1639068576852;
        Thu, 09 Dec 2021 08:49:36 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.36
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:36 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 02/36] cifuzz: use the default runtime of 600 seconds
Date:   Thu,  9 Dec 2021 17:48:54 +0100
Message-Id: <20211209164928.87459-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209164928.87459-1-cgzones@googlemail.com>
References: <20211105154542.38434-1-cgzones@googlemail.com>
 <20211209164928.87459-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The default runtime for CIFuzz[1] is 600 seconds; use it.

Since GitHub pull-requests are not the main contribution workflow the
number of runs should be manageable.

[1]: https://google.github.io/oss-fuzz/getting-started/continuous-integration/

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 .github/workflows/cifuzz.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/cifuzz.yml b/.github/workflows/cifuzz.yml
index b28eb71a..92523db4 100644
--- a/.github/workflows/cifuzz.yml
+++ b/.github/workflows/cifuzz.yml
@@ -28,7 +28,7 @@ jobs:
         uses: google/oss-fuzz/infra/cifuzz/actions/run_fuzzers@master
         with:
           oss-fuzz-project-name: 'selinux'
-          fuzz-seconds: 180
+          fuzz-seconds: 600
           dry-run: false
           report-unreproducible-crashes: true
           sanitizer: ${{ matrix.sanitizer }}
-- 
2.34.1

