Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3511C433EF
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbhLIQ43 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbhLIQ42 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:56:28 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E939C061746
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:52:55 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y12so21044526eda.12
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=frlviyJXFNx5SKoj1wdqZpP6jId7QYPzL0wI+Qm7ytc=;
        b=IDPhyIUSihfqhRQx6rw/4OYHgPiMchby9pen/+cCxxdPr/cVECC7o/67CeAkis3mS4
         QdnPkv7k9zE9ai+QkR4jhEvVneNAQFBWYpbPaVhSF9NnFxqL6t4iTPyfUes8lgDMHBcX
         xx1ecqkt+MzfBzs5AvRnmtyAiftiPQxnSFkeNI7UINoKLcdxj1vZoWkA2ckV/iv9VH6G
         sLW17ITsXlDJg1ojJyYmtLqI33dPkqNOCJIZkuUX+lavtj45tQdXxbirKka+sIISXUad
         6EAKnurWJ94VMB//ZtvRV8KUnzq1TetZWq3IpeYG0EvQqyLqyg7YHDeDkWgaaqVGDFXT
         su4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=frlviyJXFNx5SKoj1wdqZpP6jId7QYPzL0wI+Qm7ytc=;
        b=IEzipMsL22Vhh1Cw0Yo0iP/goAAklAxUkv0bmAjKYibe+6zSDu5JFmeUss48H3Oq44
         /86qcwHuW7dUP/9NyKzmQ+6cZ/1KZ96cud2WKpCpctvDIdGlj/c6CuIc1UVRvAbIvLdg
         wa8Y97HWUGBIycrQ2CRV3xTOl7AqQELnS1f9FHDUk1EHBGiJyiE76LMrCgIgqpsvETKU
         OFSQ3GlpY0Dctq/LTrPy/mgPSl26XwGdrXn68ecmwEJ5c/zazaPRbQs1AObkMy50gXBG
         t+hWQtz5Tge9ijldMKNXHMFsv+jEuT58uvjIRKEStdaN2G76boSGHuT6JNoGhmkh+9TJ
         3x2g==
X-Gm-Message-State: AOAM533m5yr6wIg+CoKC7M+E+JfzPx43FHLN1da+z4mz6Z64lf/4lQ0a
        mZpblT6zC8P2ZAwjMNrB42KSoc1/kDA=
X-Google-Smtp-Source: ABdhPJw2nJMrP3XGJr4TOXsBd9pOBh0Cm9uWaZTzO7ki1xi5SPoOuMi9MGIK3D1LJf+8DqIuH1kFtw==
X-Received: by 2002:aa7:dc14:: with SMTP id b20mr30383067edu.133.1639068584134;
        Thu, 09 Dec 2021 08:49:44 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.43
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:43 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 13/36] libsepol: reject abnormal huge sid ids
Date:   Thu,  9 Dec 2021 17:49:05 +0100
Message-Id: <20211209164928.87459-14-cgzones@googlemail.com>
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
index 0b2edf51..a3d34d30 100644
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
2.34.1

