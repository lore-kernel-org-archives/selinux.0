Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742DCC433FE
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CB4B60E8B
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhJKQ2h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhJKQ2d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:33 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE575C061570
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:32 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w19so10007481edd.2
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BNFD+9F+vwUX0f0XeuxfAEZE3pvmAnh9lkEzT9ib510=;
        b=joQM9wJmIGHO/Y431REqgkR5EVxDcMKIkAp8zKqB6edZCh26i4Pn2v23AWhS1bo273
         zQjkTRiEexDHdnoddofW8wdFVNA6TpYcPMfGPuUmxVH2MxKP2igWz71OGxnrX/RpaaWC
         7xJqAAEtpMVefbOK/NyHnHF68AVkofmTgbt033pPwmNzqK2bchvyuBQ6mXpiMbx9CaSA
         z2d1Xd5BcouQp0Vy5JefAk1VR31gsOToclrEm4+9rpIGhZspw95Hws7vLwgb7L0Lovog
         oClfoM3TKiJbZp24KqlVgZFIaLsF9NVIAi9HgxCuzQZeGjHj9Up2TZfg2t8qy2TemzE7
         AOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BNFD+9F+vwUX0f0XeuxfAEZE3pvmAnh9lkEzT9ib510=;
        b=NF9UbiH7OHDkXuoyEtyQRBjo/u69KpWhM9/9HvWnweS2WuEYc6bGMfmiDjU7Fwra8R
         nrsMilOyV6X4TlXuvVNhIuZ5FWq19f/L0hrm8QVNVs1MJVrZOKXBzM6Vxgtz9uPE+J6D
         CS1WODDFMF/28MAK/fGkQ0q6bezBuIhdPhodMVJRz/Y3WM1Ko6fdmv2b9hJ90i1NiROy
         zEVJkHrjKcOeOgh5pF/32/qqRRPm0LscrRoPizNgX3nUcri4fqUy4XT8GxJdbeADL6zD
         ohXpcd0fozDTn+RFEUr4jlxYV3DdLzg7kuT9QnJjZ/3+Ozhxa1CgVhqHuXf0P4f2tObu
         8mhg==
X-Gm-Message-State: AOAM530N53VVd7SCfrZMOw4wnqW/gO8n+1jkraDQwBqD/i1y3ehVGnFN
        eGCMOxEo3ifThqoALh42sck7CJHZ5ps=
X-Google-Smtp-Source: ABdhPJyIj2RdMYhBZUeJS/pWPFxGT1iIrHzZQ4axUuaYqS0YB0JvsZnV2RTFffWx3YSXTuC+pIWx2A==
X-Received: by 2002:a17:906:84e:: with SMTP id f14mr26796119ejd.105.1633969591489;
        Mon, 11 Oct 2021 09:26:31 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.31
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:31 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 19/35] libsepol: reject abnormal huge sid ids
Date:   Mon, 11 Oct 2021 18:25:17 +0200
Message-Id: <20211011162533.53404-20-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
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
index 5e8b4a3f..51fbd7c8 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2921,6 +2921,8 @@ static int ocontext_read_xen(const struct policydb_compat_info *info,
 				if (rc < 0)
 					return -1;
 				c->sid[0] = le32_to_cpu(buf[0]);
+				if (is_saturated(c->sid[0]))
+					return -1;
 				if (context_read_and_validate
 				    (&c->context[0], p, fp))
 					return -1;
@@ -3032,6 +3034,8 @@ static int ocontext_read_selinux(const struct policydb_compat_info *info,
 				if (rc < 0)
 					return -1;
 				c->sid[0] = le32_to_cpu(buf[0]);
+				if (is_saturated(c->sid[0]))
+					return -1;
 				if (context_read_and_validate
 				    (&c->context[0], p, fp))
 					return -1;
-- 
2.33.0

