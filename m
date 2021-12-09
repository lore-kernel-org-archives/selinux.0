Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2B2C433FE
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbhLIQzg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236251AbhLIQzf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:55:35 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11F8C0617A1
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:52:01 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id e3so21818982edu.4
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Oc3znJHUCEvujx6hfd1xEOQVqetFzLJCTBaljK2iw/A=;
        b=T/gsNImGeOx//m0aCyO3BWkNe/mIHFAvh2ZxpnIEYKuhewpgTSFBgjlYp9EIJFNAuF
         i0yWyCZ4xtxvjeYGdFjAMlmvOF1s1AwwAtpMjX5z6+neuqLr45k7UGFV4O8ylVDz7mr6
         QaR9+dPDIew+9Q0JHOKXorjnN+e2kwa5M95S4nXG50iKTIfJweGDCHTNVDOkVKVBHxL6
         nt4aIJTDugRsHbxDc6XK2apIvXnXR0FJUfmDwiYr2BjL86rjj9Co6B7RgiPstaAZ9spm
         XiZgFUfrRQFLorgFJcJtmxquBQndwlUFuI0t+RHTi9v3vdi1Bir48wPD35mocoIM40kC
         msog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oc3znJHUCEvujx6hfd1xEOQVqetFzLJCTBaljK2iw/A=;
        b=46JKkRcLk6ha/IS0Zlw1ZW61a0oVmwgQ2uzkPMgq2o8vGGz734d8HKuRv2qSicUIxn
         A7yC/dZPabpZrVcn8jL40uvC4YrZl3v70KNT/OhNi3EljT6DucwBEiRROWawdCDu2hk4
         qsZs456hyw/t/yGeOk6ZuvEs9HmK9b8wCavsuuxU0m6xjkTEeMz4LcDv8FM1sfjRNsr5
         87F9xbgma2lesnxUI8KLX0K+lD95JusNwXRzP7hl3d2PlQ55sgAb291wVQS9KuzZQn5H
         JhuhSMeskb51iUW308bLa9vY7rG32an4zpGQW8vjSzjr7CnGLl7+Tk8yuWzf7nQJz88F
         o8Fw==
X-Gm-Message-State: AOAM533hlkc1ZpkKywzprPMPGVukI8w3yhiFHWfnaWkbQcl1CArxTlrG
        bsJPzFHMS+PMZTIBY1+Lp/WKTs/ngHQ=
X-Google-Smtp-Source: ABdhPJzaKS/JA5a74Z9Wh3HCRNhG41jo4X5rPn6lzkEnNBxoqGAU9M/SOccPT4XWxR3sruKaoQ3D7g==
X-Received: by 2002:a17:906:c14b:: with SMTP id dp11mr16964579ejc.294.1639068576305;
        Thu, 09 Dec 2021 08:49:36 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.35
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:35 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 01/36] cifuzz: enable report-unreproducible-crashes
Date:   Thu,  9 Dec 2021 17:48:53 +0100
Message-Id: <20211209164928.87459-2-cgzones@googlemail.com>
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

Fail and report unreproducible fuzzing crashes and leaks. Such failures
are probably related to some global state not properly reset in the
fuzzer and can cause OSS-Fuzz to report flaky issues.

Suggested-by: Evgeny Vereshchagin
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 .github/workflows/cifuzz.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.github/workflows/cifuzz.yml b/.github/workflows/cifuzz.yml
index 5c2233a2..b28eb71a 100644
--- a/.github/workflows/cifuzz.yml
+++ b/.github/workflows/cifuzz.yml
@@ -30,6 +30,7 @@ jobs:
           oss-fuzz-project-name: 'selinux'
           fuzz-seconds: 180
           dry-run: false
+          report-unreproducible-crashes: true
           sanitizer: ${{ matrix.sanitizer }}
       - name: Upload Crash
         uses: actions/upload-artifact@v1
-- 
2.34.1

