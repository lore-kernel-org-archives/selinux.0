Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9623AC433EF
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8329B61108
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhKEPsb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbhKEPsa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:30 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1903C061205
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:45:50 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id o8so34460477edc.3
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7zZ2sY8MXY2OU2S1M7ftEV47o21MUPiJptBUNbT3vQw=;
        b=SsJGj5q1lgWENnf4NPYMDGbpZlWDz1Gfv7pfsXJmdwSS4umvZsVYq2lgEs1wFr+Vq3
         WwQtFLNPlE9Az6ddclx7ZkWmli8BT8gCrSQ8TLDto8AOJhThAu7pD1Hp6wIKn2MEqJ7a
         IckWAfVnPaRILrTO+IckE2c47wtBinqbevAfsox+gz/ZOEKHvcmJijqPtgYK0T4A1tYV
         KG7dv+V4T+LLrsTdrP+2q6+JF0G4QgUAfJ958gMTE0lGY/PxJNVm1gdlzw5XAiuGV5Y0
         zwS/QGTGXjL6mTvaMg9N0ciw4C90QJVzhzoPi5vv6daK3JkrtN+0q5zPSs8Sw+EOUfbO
         WBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zZ2sY8MXY2OU2S1M7ftEV47o21MUPiJptBUNbT3vQw=;
        b=gAh4Fc59Orhxc5KOXveTtHPdq5o4aqyrwH4cJOqMjMTvDUN5V4kjFRdnJaFRE5kRpj
         iR2xG3A1atQM2Ny6AB5gU1VaLodewTrlMhU3PJn1gXXS0qJH9vTxZslnDtrnofuW2afm
         o3+90fy2gXdXQkrJcBVCgR5jo/Hprd0XpwY04OxxbJYWtOs/hF+7njmBENdViKH9H4Y3
         Dh0EqQVIRL781VmFtZBZgJuang9QrKoOeBDxW7BlfCCwqNYo6UjhnvzizSAiOsr90EMH
         q+Mhmsz94TNr3s+Oesedbk5CSF6i9GDx52/LdNZqi0CxRdJW6+01An4Dwl+xsfekYOsj
         TVEw==
X-Gm-Message-State: AOAM532RHLAivFJq+J002UD+aPkvA/h0qlglp+pD3zPfb0I+IknR1o77
        oQJE4UXG52qiQcGqUaudGit7FyOZi5o=
X-Google-Smtp-Source: ABdhPJwqurMLkQ2R7sQHDxW4KVj1ntaKRJp+EHyk9K/EeIXDMLl6gNGuwqgX3LNYRy03PZn6FI93EA==
X-Received: by 2002:a50:d78c:: with SMTP id w12mr79652471edi.147.1636127149276;
        Fri, 05 Nov 2021 08:45:49 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.45.48
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:45:48 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 05/36] libsepol/fuzz: limit element sizes for fuzzing
Date:   Fri,  5 Nov 2021 16:45:07 +0100
Message-Id: <20211105154542.38434-6-cgzones@googlemail.com>
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
2.33.1

