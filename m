Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F04C433F5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D33B660EE5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhJKQ2j (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbhJKQ2g (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:36 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEF1C061762
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:35 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w14so18197755edv.11
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5y0Drt15itF2C/GZnjFvFERiJrniCQG2zJxSpdTv2As=;
        b=PNs+UAExMsz+aCvo9zlVBwgIxuAhChZMabFVi6jsLMxS/298rLZjG1S6GRg6g3+QEY
         zYC1ZLpGPErzyvGxFve45lyGR3/Y+AvoE3lBy7jJ0jwBSOKaK5bJC6MuITs9xGuw+EK5
         Fo7pxvTOqkTVANrWj4AkuFD4KApBapIG7rEYp1N3cFA+85/8IHB3v2zIrAT7jAb/xwg4
         4pdlnXWXllA7Lu/bCX3CDSRmxdJhNHmAEUxD6SUt904pVvTE1XdZ1xNuu0LIXty42DgE
         xR7Z2hSJM9pcdZ8cssaXQNbX2aynqaC7xYQDAngQiV278+DQn+83rZmBmmisO5EvMivQ
         l07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5y0Drt15itF2C/GZnjFvFERiJrniCQG2zJxSpdTv2As=;
        b=r52Db/WIjAUMBhaWy1V8bA/JHli/Up944y/1i42AOmAwDPBDa28nMPhu0j/NOmCh4b
         1HBhvB4geDMdnTW4Y8mGgoRHJ0maIPTMEyWuojVg8Q7LljNS3ql1vG4/e/d19steKk8b
         /P1LVVaTlOcsQiy67lZY9fiBy6Fg2j9sPoqar2Mm/OmPuuOpznscsfmcpCDcEN0ermBo
         TMu7r0w7ivhck/eiOR7Az3KA5/mIv6QOZTRflawnoGzr3G6D/lEyfKXuAfRswJb8kpkr
         5V9c5aOqOxDCGmP4dbJNmyWr+wN2LKH7YWp5bi1ku4h1f0xMAxvSAUkNldsySBQknsjZ
         PEoQ==
X-Gm-Message-State: AOAM532GgUtRxuy5Q4edLtf2p7qSdPeCcaKOiYtoNUWMwlfq/lKOyBge
        V1E2oNe49YP3bqau98Ae0hY/P16Ycec=
X-Google-Smtp-Source: ABdhPJyuVqF6gNG00NIomRfN2rTsqVSh95AkTPyEX117M2qsQf+HlV07sEbamx02tr9uDOB3ALELww==
X-Received: by 2002:a05:6402:51d0:: with SMTP id r16mr43166287edd.353.1633969594129;
        Mon, 11 Oct 2021 09:26:34 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.33
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:33 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 24/35] libsepol: zero member before potential dereference
Date:   Mon, 11 Oct 2021 18:25:22 +0200
Message-Id: <20211011162533.53404-25-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The `next` member might be checked against NULL and dereferenced before
it gets assigned, due to jumps from failure gotos to the cleanup
section.

    ==31017==ERROR: AddressSanitizer: SEGV on unknown address (pc 0x000000579654 bp 0x7ffd3a07d110 sp 0x7ffd3a07d000 T0)
    ==31017==The signal is caused by a READ memory access.
    ==31017==Hint: this fault was caused by a dereference of a high value address (see register values below).  Disassemble the provided pc to learn which register was used.
        #0 0x579654 in filename_trans_read_one ./libsepol/src/policydb.c:2874:55
        #1 0x579654 in filename_trans_read ./libsepol/src/policydb.c:2902:9
        #2 0x5771b7 in policydb_read ./libsepol/src/policydb.c:4509:7
        #3 0x55a1f5 in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:24:6
        #4 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #5 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #6 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #7 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
        #8 0x7f2a4e7f97ec in __libc_start_main csu/../csu/libc-start.c:332:16
        #9 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 51fbd7c8..d246918b 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2815,6 +2815,7 @@ static int filename_trans_read_one(policydb_t *p, struct policy_file *fp)
 		if (!datum)
 			goto err;
 
+		datum->next = NULL;
 		*dst = datum;
 
 		/* ebitmap_read() will at least init the bitmap */
@@ -2832,7 +2833,6 @@ static int filename_trans_read_one(policydb_t *p, struct policy_file *fp)
 
 		dst = &datum->next;
 	}
-	*dst = NULL;
 
 	if (ndatum > 1 && filename_trans_check_datum(first))
 		goto err;
-- 
2.33.0

