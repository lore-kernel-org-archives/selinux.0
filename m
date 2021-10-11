Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D7BC433FE
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F4060EE5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhJKQ2Y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbhJKQ2X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:23 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE3FC06161C
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:23 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y12so57077914eda.4
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eLGqKUjK5nSjB1Rtz/tWvBO4jtl/hk0LYWvknVN6Q7A=;
        b=VaGA4P1WTnxrdkdc4Yf6EhbRM61NT0xTMPYUCsJ4QyskZkOvBOF7P2V0OZu6sRJ1Zy
         ILMzdYw7dvyeBEezfuqp7aJ6kvD9MxBFj5RK5mUEtvIokudXbj2dR97JxGFQIL0lnGu5
         7lSoSonQtCqPjG8LXliqG13SwLVbWEhLEizlC4oRPijEnuQEdm8H1N8TwzxOXDUObBqg
         Zv9hSOI8WB+ZzMPIiy7osEhXLSt9RsKIoX1Em8Ev1DBUZdQ+cQhucRULnVW/XpfPuTIr
         oOMw8HMltruWnygPdxb4TXPUwSdt5hJ/WP4m5KdibiMzL7r5kqUJakRT/MjrfeQmJWmY
         yR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eLGqKUjK5nSjB1Rtz/tWvBO4jtl/hk0LYWvknVN6Q7A=;
        b=oRjpnOvgfIkoDKKo2RVsts5JZAXvfP4haNwqADUKFF/y7HhGxMJOLv/3vz8+pdfDKI
         WaXMb2YDNnpsr5v4az8Q1MlW+siZyrnXzDDGsnUGDyE8j2H5JUGDyNfHWIR1VO5S2er2
         MVN3bRbYgVesOYKi5y0W4aYg1XgwcZb2jX5APRyZs2W6nh2H08ovceEk+w+jJ1xQ/4AG
         58RchoYdkKo1sqH/rMOY1re5RQB8SlbhyXT+/9RDbJMI0AtHVdXtfQWDl6+JT+WNTgyG
         FB+q6L7Sxkv4DdJnklhuGIwEsisjryWEL3xZKFG9el/u6fToI0RP8Grtg7mu8lZXBWvo
         dAxA==
X-Gm-Message-State: AOAM531tj/+6HHqXP7aArqC+z92OS6BArtnMfCKVOZsc2jQLOo/nyF8M
        9E6CmUtb2TrPCOnLux4QykgeIV3EWcU=
X-Google-Smtp-Source: ABdhPJwWLxlUjhN30GKhS3SvwZ8UOnVn5PJz0SbeZnMdyfExI86D5Ah91OKaVdt3a/DCST+le32FAg==
X-Received: by 2002:a17:906:608e:: with SMTP id t14mr26408141ejj.441.1633969582309;
        Mon, 11 Oct 2021 09:26:22 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.21
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:22 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 02/35] cifuzz: use the default runtime of 600 seconds
Date:   Mon, 11 Oct 2021 18:25:00 +0200
Message-Id: <20211011162533.53404-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The default runtime for CIFuzz is 600 seconds; use it.

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
2.33.0

