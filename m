Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D16C433EF
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C52C60E8B
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhJKQ2X (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbhJKQ2X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:23 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D39FC061570
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:23 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id a25so54087124edx.8
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AX5qh+ur3qJAl3DtWyHZtpg/G37EwbOeU+AeMnO9V0o=;
        b=pnOd0iVbfnT8nhNQs9vBRuzGaJ3FrU7uD2qrFOijhj30Sw1QD+l+6aKFigJ6dVQORR
         xlxKaVps4fjqSmqDuhS08E5KgChDQ2Ju8zt95gFpP6aNM9cCxe6lB3e+MhAftMdv/suk
         1S28MmTQALbSUW5k8TUeZ5/qAjjwon/tH5hdOJGRCIG7x/aIe1PN0ZLdnd1ezQeNo1yf
         AxAv6Uj2i/yIPa8t1VHAPzkV2bKXBXLPkjBUBk79ZildkpB9BPlcBZXM6ce1Cq87+XyW
         GiiWyJndlfRISSavXTvl9OoWeR6uvJMJ85HHjXLu0N2afpRlf17IlShOtI1PSPDiMv0u
         1S0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AX5qh+ur3qJAl3DtWyHZtpg/G37EwbOeU+AeMnO9V0o=;
        b=gY6ktqYidUkDOYs9wuGo62j1xyA1s0UQbuGWPNET+bqW5ookErATD1/tzTUIbBZjM5
         MVj1jV8eQkCQ/3xytARhyPK4mNm14CpuE5e0IAybkBvqxt/KkbGqMmgze/YnyubzVfN0
         Tf2btyvwsqFP+QXDfcNCKQUtGJ0ecukT6vwEcLZVzJIjZQK4+xZ+H1JNeylN8QH074LL
         vgrNb8SkqeN/KnkQOAqg9bNMj6QS5h6jBA/rKIH5h0RaSX0Vw0KR781pQaHJkVBE2eAq
         53k2Pc9pJ35GnC3kWRPmcwdQxF1p4abWVAP0SEMdHvbrneagl2GLVbLt+uP2YPuz5dQR
         krow==
X-Gm-Message-State: AOAM530DjQYSMo78gZgQGM/4ok61bUMM8AnBs/4V87pYKf61pIKaEIi1
        wYtgkhcOEbM1uhEBNsdNbjMVIWoV1e0=
X-Google-Smtp-Source: ABdhPJyhnF/VpKlPkuH47BsqxMpDnJWFaO26J75XkalgE4l3rU6aVmcaQbxA0ss/IN9YiG1ADc5yfA==
X-Received: by 2002:a05:6402:2805:: with SMTP id h5mr38363456ede.169.1633969581824;
        Mon, 11 Oct 2021 09:26:21 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.21
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:21 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 01/35] cifuzz: enable report-unreproducible-crashes
Date:   Mon, 11 Oct 2021 18:24:59 +0200
Message-Id: <20211011162533.53404-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
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
2.33.0

