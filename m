Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09814C433F5
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhLIQz5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241356AbhLIQz4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:55:56 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99478C0617A1
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:52:22 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x10so4328020edd.5
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=56ERkEPPB0NDyae5UcCDF97OxHrlRxY7HkGnvnU0+ww=;
        b=gnlcSgMThv+tO2awNYgkMReYqKgYscnVlvElAU9WCesehQn4utdUfTqY4fdtw5O7QJ
         4wPfcnv1HlUmH96wg4p5XB8l+kg8/ZWo6L51qX1yjdzxvfEtgERCuL+9Su3O4xSQDJ8w
         /eSeAqnTCQsos4Bflv+3k9kBiVLc2nlC8LWDDHJ43fELp1a9bttCgu4m7soSHpSuZpfn
         YdPgCkfkD33YNhKqp92q5cSDCOieSNabu6xnsA2uOhVefT8V+5YyD/fGIn72WtmpROcx
         6NCEU4Bh5jR9qj15rGoivl+MsjohmCCOCY6c1jzlm+RbZ9uOyLZA7k/zpUlE0GbpSBH1
         gt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=56ERkEPPB0NDyae5UcCDF97OxHrlRxY7HkGnvnU0+ww=;
        b=jFBzslsXf7FAI103i3mH77T6RjI9kMXfvU7JyBmtrgBbA0Wel2QeaFI5ESAWpZa9HC
         vBEnmPnWankEDQsWAsFO8FPrRocJEYlDpZAOL0tu+6pNSSqanYlfc1AXF+cmIZVDzLzT
         21pNH1zNkveNhdiQGjImvBZANGGhfHSmh1S0pb50HP9Y5twjHb5chJPTCycB0LkFrZlh
         noLUzTB067LgkT9DWg1vlCtOxGGfk1t09A3dtL95/TqmgP84JKG5DLHv3EYsDhIFKz3g
         gdhhFPUPglX0hmudWqYRfARuTwtYtje+IKtXV5dZmz8rdsBzPQ4nhyBMA/e/WT1SSbql
         XDeg==
X-Gm-Message-State: AOAM533Rn4uljz5Pdt+wY5kK2ceKDx3IX1jKSNhrL92KLtqgXBBY5aub
        rKEDb7iTLQPSIf0qBU8IOyB5kz8dz5Y=
X-Google-Smtp-Source: ABdhPJybHNPkE+4ORsh1JXrlad926wD4yIMFdlDCC4l2dLYIaojxrKKl7RP+7S9LpO+r601bTj+i3A==
X-Received: by 2002:a05:6402:2210:: with SMTP id cq16mr30870883edb.32.1639068578511;
        Thu, 09 Dec 2021 08:49:38 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.37
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:38 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 05/36] libsepol/fuzz: limit element sizes for fuzzing
Date:   Thu,  9 Dec 2021 17:48:57 +0100
Message-Id: <20211209164928.87459-6-cgzones@googlemail.com>
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
2.34.1

