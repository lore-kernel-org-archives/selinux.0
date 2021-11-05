Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F707C433F5
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66E5761108
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhKEPs3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbhKEPs2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:28 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10305C06120A
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:45:49 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c8so17811387ede.13
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jVaB6lNKmvp5u9IjljUK2ceDUgI9bQzcsD+/kI8WaMk=;
        b=SVOwhPookGBqfA6cBGM65pJyA2NuX1j9JsApnvqKNPaPUQOLMISfyAioSQy9/gjuG4
         HmDVakor6ulifxCC/X7A2e+sEeYwTr4GeST10jiQNThnRvmMUHFED9y/s8uF5CR76G+9
         li0tSuWBRyBfeiFJ4lFyeyNxZSWtIwoQhsVCIWwoPlGF0Dm4MKFswX48D9M3elEDuR1Q
         tOj9iJSlaMNA5V1ufwJCAcVd+x9w3KhOQwd3QpYjOxQ8ZV85YWMB0sTn+UaiM60XhZak
         llhmB1aKiBtx7g6VYjYxSX2XguTZfn/Yaws6NdkZNrymKZfahIXhkYeVkpKRGjpsNHOk
         74pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jVaB6lNKmvp5u9IjljUK2ceDUgI9bQzcsD+/kI8WaMk=;
        b=gqBTDvmZufSd2CxlmqPAfc8ly2bnW4CQP2OV9KwSFLMcnu05T8v0LW54NGMfCKMCpy
         MaHrRuXChHlHOSi4z2m6PIlygMtfifpKXICtWLAwaml+EPQ5/60whj/i2s3LZbQe6X23
         naDHCQMeNbPdz1/mEaeD+TPOcayjmolj1CFK2N87hmCBawrbZmSi6P+eQu5AdwS0jlpV
         MmUlvT5/nsbsTmWAwpE7FdNEiSOvEAyEWG42XZI9Lv5/tGDINdOXL5RzEBMtWhFBNM+u
         JNNGXLpZ5udcFd9kqA4AGUvovGwK7Ir+7huv2evkb/DiWOOc1QRy55mJ6aJCGy1Ro6nU
         TFBA==
X-Gm-Message-State: AOAM531zOVSti/Or2TpVU9qXdo2JnOcdZNl+NscDOu1u42jhJ3mPsEIY
        nLyNSpZeoEApfKdLTvN64wzR5X2G3UY=
X-Google-Smtp-Source: ABdhPJx54NCzmBtBn4eQ/4CXDpTkzW6cL0Yat1MIde5azHfzUjpDZfhT7fz6xbPVvVlc+rAW1/NLAg==
X-Received: by 2002:a17:907:9803:: with SMTP id ji3mr69728732ejc.286.1636127147564;
        Fri, 05 Nov 2021 08:45:47 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.45.47
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:45:47 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 02/36] cifuzz: use the default runtime of 600 seconds
Date:   Fri,  5 Nov 2021 16:45:04 +0100
Message-Id: <20211105154542.38434-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105154542.38434-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
 <20211105154542.38434-1-cgzones@googlemail.com>
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
2.33.1

