Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C29C4167D
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B62561108
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbhKEPsg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbhKEPsf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:35 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BD4C06120A
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:45:55 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w1so34804184edd.10
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vlov0LulgLDNUpIUA0bDaG76wcaDMb58JrD1xP/Bwb8=;
        b=ctPXIxrO6lACn95AdssbrjbO1zHmxouD2ZBivs4TSXUrukideVr3oXfGXwOE2nqVO0
         ib+e6+ktNHiE6GouXGefwcIPBgj2pbQgkt6wVMOlOOpAAiS2k3l/+opBoMtzMfjmdB6G
         ugKFCaAGEaOFQGxzmNiTsc4UfqvuPNheIdqAM2mrCHHDFbWaeIHBrpfeHE1eWblN2KNM
         R8scO6+GevcOuereGB29K+YaD9DhcaYMTTQxzK2fE/e0iRrMEqlPY2KD7xIHR7QM7l3N
         KmewnvDcn25+18ZQUsy5dKzSIGflAq2e795oRHmHIncqKkvIpcQKbRA1r3hEyYbCSemw
         8mgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vlov0LulgLDNUpIUA0bDaG76wcaDMb58JrD1xP/Bwb8=;
        b=Efwa4BV6lnysNLY9nmtRtVEOBXiHhrGpOv/SBTudllJaU99q22POE9dVWMRujYA5Mw
         e/ZIGCkycaqUNaE3vvQaIwHoTE/AxsykKAnOMRWi5es+WNXn7bEN528gCyA4qSxCO4n4
         eAPOZ+DkxmO+upAZl0qEU7Glkg7DOA6q/g1h+8gnlMrv8ITXC3esMNLfijfQ4x5gBSPn
         F+Nt7w6LJHe/cvlV81lI45HO1GeXQgd8SQYn5aeEsECpYTzINGXUkgHN7dWmPu07gQyE
         YhezNg4VfLmWDgwjt2ZX07oYWjC5hhgt6nqzOz7F9SeYf/L7BzNLZcUOCNevLk4o6TSI
         AY9w==
X-Gm-Message-State: AOAM531N/ZkGgYhCp2mdsqB/kJZ2pVJ3Fw1pyHt3GVbC2vOos/bWkLB3
        KAXZc8alzb1PPYN5hdiN0T9bkSQYPu0=
X-Google-Smtp-Source: ABdhPJzBhC4IDgpIlDF9TNUNZI2PgL3Z87byd9oismNtXXdKlSNd1hVHJqDDKmQgpvs7v4EZcZ5jPw==
X-Received: by 2002:a50:bf48:: with SMTP id g8mr80217800edk.10.1636127153813;
        Fri, 05 Nov 2021 08:45:53 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.45.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:45:53 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 13/36] libsepol: reject abnormal huge sid ids
Date:   Fri,  5 Nov 2021 16:45:15 +0100
Message-Id: <20211105154542.38434-14-cgzones@googlemail.com>
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

Check if the sid value is saturated to guard dependent allocations.

    ==19967== ERROR: libFuzzer: out-of-memory (malloc(7784628224))
        #0 0x52dc61 in __sanitizer_print_stack_trace (./out/binpolicy-fuzzer+0x52dc61)
        #1 0x475618 in fuzzer::PrintStackTrace() fuzzer.o
        #2 0x458855 in fuzzer::Fuzzer::HandleMalloc(unsigned long) fuzzer.o
        #3 0x45876a in fuzzer::MallocHook(void const volatile*, unsigned long) fuzzer.o
        #4 0x534557 in __sanitizer::RunMallocHooks(void const*, unsigned long) (./out/binpolicy-fuzzer+0x534557)
        #5 0x4aa7d7 in __asan::Allocator::Allocate(unsigned long, unsigned long, __sanitizer::BufferedStackTrace*, __asan::AllocType, bool) (./out/binpolicy-fuzzer+0x4aa7d7)
        #6 0x4aabe3 in __asan::Allocator::Reallocate(void*, unsigned long, __sanitizer::BufferedStackTrace*) (./out/binpolicy-fuzzer+0x4aabe3)
        #7 0x4aaa32 in __asan::asan_reallocarray(void*, unsigned long, unsigned long, __sanitizer::BufferedStackTrace*) (./out/binpolicy-fuzzer+0x4aaa32)
        #8 0x525f8e in __interceptor_reallocarray (./out/binpolicy-fuzzer+0x525f8e)
        #9 0x5ebad3 in strs_add_at_index ./libsepol/src/kernel_to_common.c:224:9
        #10 0x5680eb in write_sids_to_conf ./libsepol/src/kernel_to_conf.c:466:8
        #11 0x55c1c0 in write_sid_decl_rules_to_conf ./libsepol/src/kernel_to_conf.c:498:8
        #12 0x55ad36 in sepol_kernel_policydb_to_conf ./libsepol/src/kernel_to_conf.c:3083:7
        #13 0x55a34f in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:38:9
        #14 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #15 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #16 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #17 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
        #18 0x7f085ac657ec in __libc_start_main csu/../csu/libc-start.c:332:16
        #19 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 1408405d..1868af5b 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2883,6 +2883,8 @@ static int ocontext_read_xen(const struct policydb_compat_info *info,
 				if (rc < 0)
 					return -1;
 				c->sid[0] = le32_to_cpu(buf[0]);
+				if (is_saturated(c->sid[0]))
+					return -1;
 				if (context_read_and_validate
 				    (&c->context[0], p, fp))
 					return -1;
@@ -2994,6 +2996,8 @@ static int ocontext_read_selinux(const struct policydb_compat_info *info,
 				if (rc < 0)
 					return -1;
 				c->sid[0] = le32_to_cpu(buf[0]);
+				if (is_saturated(c->sid[0]))
+					return -1;
 				if (context_read_and_validate
 				    (&c->context[0], p, fp))
 					return -1;
-- 
2.33.1

