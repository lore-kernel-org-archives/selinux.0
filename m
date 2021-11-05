Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40888C433FE
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2797961108
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbhKEPs3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhKEPs2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:28 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D11C061205
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:45:48 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id f8so34733963edy.4
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=loCrjo32Jk9lr8zUymqvOJ9RVBJTv3KKer2FC1y/IlU=;
        b=mVdZYpJjfW7JGSvlSe/zvg5zOEIK50GLfUrnWA2tKDB76gLpTU53TP88p5+TcRQ6rP
         FaLo5WmFUPnTcSJuIJyRc3ZIO3be79L/l4X4DVXCnAhbuakpNi42T6AslhFmjsdRGvty
         j/Pj+DHAHU72XKANpV87ZgKmN30eeZz7sqk8NTbBhp4eGf9XKzA7oNh+1YpXvJt8tb9B
         UpQ1yowxILayIKk7YwSMntPeq8/JTCNoNzGAmWg3nzXRijKJbvsJSmdlYpRoYgiSuPdI
         LHIXWBUva62lYZg8Z9rkEX6xrSkdiRK9FRdDD/1xpNxYIwnDDFfZCWdlJyWG3C7whCnh
         CHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=loCrjo32Jk9lr8zUymqvOJ9RVBJTv3KKer2FC1y/IlU=;
        b=RwuqxKAdWLGFaIPMFn8YAye4LG6I9MgLRsDr3+Y5bxXT/mXzirANgONRgogmMmJ94F
         GPL4FbO4aGrrvWjieeB7QKiqlwFCYP0vZahIS1GAppYPmq6BA8IYwFQ4rUVid1rZFxaQ
         akLamWmakFiVTBDZ37GU6WmL+AUV/L+/BItf77Tn90ArNHuz9EwarbIxs0kbpjLofb0X
         HUWsMd4H92o2xwbck0Xn8GJnUa57a/KS3cD4aHkJmD56QA4sY3MBsPOXcpgzevCUo4AH
         wIJ1kw7bWOxzQHAJpevyy2rLJ1PSVkluZ5mavNmgN1rl+DSfXKtyq1SeH7KZhiW5/vGZ
         wKcw==
X-Gm-Message-State: AOAM531simN6mbjt6EWE3r600j3WWEA2axrctfKNis6/Scn6fdqZg1b+
        ocjKHydD+UqQKEAO5j4sLefoEhNhdNM=
X-Google-Smtp-Source: ABdhPJyrid16nGiVGxhps1LQRhEahJ12mybWIDCstyEVpRGX40+c3+H+4rRMpI/UBYb0g8zNXDuGdQ==
X-Received: by 2002:a17:907:1c15:: with SMTP id nc21mr58812177ejc.510.1636127147069;
        Fri, 05 Nov 2021 08:45:47 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.45.46
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:45:46 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 01/36] cifuzz: enable report-unreproducible-crashes
Date:   Fri,  5 Nov 2021 16:45:03 +0100
Message-Id: <20211105154542.38434-2-cgzones@googlemail.com>
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
2.33.1

