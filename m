Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599FDC4332F
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4171360EE5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhJKQ20 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbhJKQ2Z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:25 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8A5C061570
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a25so54087426edx.8
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+jacl8Al8Q58H+wLtpDSJ9c94xGremV+a4pxFon+T1Y=;
        b=QsgY4LKgclzOCvaI847Yq7FGnrAtBgv+cj+N/3lTM1ym5uurRsotyZm0NZeQ2VXt59
         2FniJgIwWpcQsVs1l3y2eJpv4MYlUxqN5wAUZSd2GC2BSmRXCXF9sVsq9J7qvn+BegMK
         LjsHlIwADpneEfXGOq9/+eA7/dw2tnHbgNS05ZZLgwfFkhzahBqniy1MvFhXt/LMlfAy
         h8A5cH6wCY6kS9NQfPzwqfplhwXKrKadrrb2S2MnIufbQD+FB2ejBrisGbBN/HTYW6Jl
         0v4mio4r5WtmAF+oaOxFP7LCHl5HVWU27HIXtL2lZA+BalN1y1NMvH/t/h5O5FiBDDxj
         0Luw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+jacl8Al8Q58H+wLtpDSJ9c94xGremV+a4pxFon+T1Y=;
        b=AfRM5raNBW1E7rQKwh27Ap++sE2n+3CDIHPgrtRCv13pHbSn8YR0kF2vaoo7j9MDsr
         XNusAu5dNaYumijw35BZVNkRbeHs91iKkmTujjOesTd0G1uPskn3jqtHdcuIxO3mo6ok
         sk1Q5VF+ErbGw9Z/15Jp3JTTlef25qnATVdFniM8cF/wUJ1wnzakIHdTdwiI6mkQq41K
         V+2IknnYUnwASu5DyV62ezIrvFqNtN25J3hlo19Rm54FRg330WeIxzM6qQWDwl/Nhl7E
         jsb5Ms0l6ifgmj+ZtoFIMcnkm6doAQJ2NvzollwRuBbZSw2Azpa3rpcTElsc7MjdKVMd
         MAUg==
X-Gm-Message-State: AOAM531gY//5FSdOyR+hpzuwNyK5wMw6SDAC3c6A8/W+F/qg7LEtLwjK
        dZ4Ssl19sO9dzADAfvdiTFeqVVi550M=
X-Google-Smtp-Source: ABdhPJzQcUzZkEkBWnvjVTb4f8nZW4EYn7sHmhYieo9ucCwiYKCZuEkZeOP8uhYk2sDfKH/WvjXPKw==
X-Received: by 2002:a17:906:26c4:: with SMTP id u4mr25515248ejc.511.1633969583846;
        Mon, 11 Oct 2021 09:26:23 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.23
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:23 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 05/35] libsepol/fuzz: limit element sizes for fuzzing
Date:   Mon, 11 Oct 2021 18:25:03 +0200
Message-Id: <20211011162533.53404-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Limit the maximum length of read sizes, like string length of module
version and name or keys and number of symtab entries.  This avoids the
fuzzer to report oom events for huge allocations (it also improves the
number of executions per seconds of the fuzzer).

This change only affects the fuzzer build.

    ==15211== ERROR: libFuzzer: out-of-memory (malloc(3115956666))
       To change the out-of-memory limit use -rss_limit_mb=<N>

        #0 0x52dc61 in __sanitizer_print_stack_trace (./out/binpolicy-fuzzer+0x52dc61)
        #1 0x475618 in fuzzer::PrintStackTrace() fuzzer.o
        #2 0x458855 in fuzzer::Fuzzer::HandleMalloc(unsigned long) fuzzer.o
        #3 0x45876a in fuzzer::MallocHook(void const volatile*, unsigned long) fuzzer.o
        #4 0x534557 in __sanitizer::RunMallocHooks(void const*, unsigned long) (./out/binpolicy-fuzzer+0x534557)
        #5 0x4aa7d7 in __asan::Allocator::Allocate(unsigned long, unsigned long, __sanitizer::BufferedStackTrace*, __asan::AllocType, bool) (./out/binpolicy-fuzzer+0x4aa7d7)
        #6 0x4aa143 in __asan::asan_malloc(unsigned long, __sanitizer::BufferedStackTrace*) (./out/binpolicy-fuzzer+0x4aa143)
        #7 0x5259cb in malloc (./out/binpolicy-fuzzer+0x5259cb)
        #8 0x59d307 in str_read ./libsepol/src/services.c:1746:8
        #9 0x585b97 in perm_read ./libsepol/src/policydb.c:2063:5
        #10 0x581f8a in common_read ./libsepol/src/policydb.c:2119:7
        #11 0x576681 in policydb_read ./libsepol/src/policydb.c:4417:8
        #12 0x55a214 in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:26:6
        #13 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #14 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #15 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #16 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
        #17 0x7fe1ec88a7ec in __libc_start_main csu/../csu/libc-start.c:332:16
        #18 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

    ==13584== ERROR: libFuzzer: out-of-memory (malloc(2560137369))
       To change the out-of-memory limit use -rss_limit_mb=<N>

        #0 0x52dc61 in __sanitizer_print_stack_trace (./out/binpolicy-fuzzer+0x52dc61)
        #1 0x475618 in fuzzer::PrintStackTrace() fuzzer.o
        #2 0x458855 in fuzzer::Fuzzer::HandleMalloc(unsigned long) fuzzer.o
        #3 0x45876a in fuzzer::MallocHook(void const volatile*, unsigned long) fuzzer.o
        #4 0x534557 in __sanitizer::RunMallocHooks(void const*, unsigned long) (./out/binpolicy-fuzzer+0x534557)
        #5 0x4aa7d7 in __asan::Allocator::Allocate(unsigned long, unsigned long, __sanitizer::BufferedStackTrace*, __asan::AllocType, bool) (./out/binpolicy-fuzzer+0x4aa7d7)
        #6 0x4aa143 in __asan::asan_malloc(unsigned long, __sanitizer::BufferedStackTrace*) (./out/binpolicy-fuzzer+0x4aa143)
        #7 0x5259cb in malloc (./out/binpolicy-fuzzer+0x5259cb)
        #8 0x581cc4 in common_read ./libsepol/src/policydb.c:2108:8
        #9 0x576681 in policydb_read ./libsepol/src/policydb.c:4409:8
        #10 0x55a214 in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:26:6
        #11 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #12 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #13 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #14 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
        #15 0x7fa6431787ec in __libc_start_main csu/../csu/libc-start.c:332:16
        #16 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

    ==12683== ERROR: libFuzzer: out-of-memory (malloc(2526451450))
       To change the out-of-memory limit use -rss_limit_mb=<N>

        #0 0x52dc61 in __sanitizer_print_stack_trace (./out/binpolicy-fuzzer+0x52dc61)
        #1 0x475618 in fuzzer::PrintStackTrace() fuzzer.o
        #2 0x458855 in fuzzer::Fuzzer::HandleMalloc(unsigned long) fuzzer.o
        #3 0x45876a in fuzzer::MallocHook(void const volatile*, unsigned long) fuzzer.o
        #4 0x534557 in __sanitizer::RunMallocHooks(void const*, unsigned long) (./out/binpolicy-fuzzer+0x534557)
        #5 0x4aa7d7 in __asan::Allocator::Allocate(unsigned long, unsigned long, __sanitizer::BufferedStackTrace*, __asan::AllocType, bool) (./out/binpolicy-fuzzer+0x4aa7d7)
        #6 0x4aa143 in __asan::asan_malloc(unsigned long, __sanitizer::BufferedStackTrace*) (./out/binpolicy-fuzzer+0x4aa143)
        #7 0x5259cb in malloc (./out/binpolicy-fuzzer+0x5259cb)
        #8 0x575f8a in policydb_read ./libsepol/src/policydb.c:4356:18
        #9 0x55a214 in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:26:6
        #10 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #11 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #12 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #13 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
        #14 0x7fa737b377ec in __libc_start_main csu/../csu/libc-start.c:332:16
        #15 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/private.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/private.h b/libsepol/src/private.h
index 71287282..6146f59f 100644
--- a/libsepol/src/private.h
+++ b/libsepol/src/private.h
@@ -44,7 +44,12 @@
 
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof((x)[0]))
 
-#define is_saturated(x) (x == (typeof(x))-1)
+#ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
+# define is_saturated(x) (x == (typeof(x))-1 || (x) > (1U << 16))
+#else
+# define is_saturated(x) (x == (typeof(x))-1)
+#endif
+
 #define zero_or_saturated(x) ((x == 0) || is_saturated(x))
 
 #define spaceship_cmp(a, b) (((a) > (b)) - ((a) < (b)))
-- 
2.33.0

