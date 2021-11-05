Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C66C433EF
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F05B61245
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbhKEPsd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbhKEPsd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:33 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9666DC061205
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:45:53 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ee33so34756739edb.8
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=03ijkIPa37XtPTKt2qx3E0ByYddbAWLXbWkCvX19zTw=;
        b=Z9t99ovUWE4anP0URbPz5iv6AxPKUee9s7l0YhAyraDd++Hi+PcoJ+XAaYnEnTkhZu
         8PVILVd7NTcF6+hmM/9G0a7VafJ+AnW3UqKPUigf1YPmYIcaHSCMOUW2uhW3RtvDWPZF
         96PPd9bIU/SGqtsmVCyroYg/0yvPYzUXrKDQAIuQZZ8GqDJ2Zwjt387JO45/hISVai/W
         NRk6ZtfwLklehCvvn261YGJHaUIZyXzY2j2xjanTqK4y0alu7Ze0bw63koEOCiUHQ0tk
         kHNnL+i300goItiAClM0MEuhaCJ8TPF/AmvWXC4/wRtOenCgerbwq6jVET9kGWetaoyE
         joMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=03ijkIPa37XtPTKt2qx3E0ByYddbAWLXbWkCvX19zTw=;
        b=HzUN2S2rhLiZaGXiK8+HkMRJ89AsBeI2XilD/1097HoYu5ohfawLz0gy62RJo+z3RZ
         YvWj+YtFPUACD32dG0ROgBbrNKgolzjB7nfL5hH/hXjOrpuG1viCgtNj/MWAkEv/mhNj
         llTS5kWr5b96of3qah403ol7p24zzM2f67cejlMVs824XhwF/UZx+vbP+xwFmodLiKuc
         1gAdcGgjPebUxT01i+aJSM9oDLA2Ls8K9Lh9UN6t5AjVRi4LgEve/4my+TaLYGNszdPu
         siI4M4H0h0uRjNM2Ucf6xcxhyGblPRugOrAZSNgmiTF20SJZf3rHHNtV7K/FS2WEEdm1
         4CwA==
X-Gm-Message-State: AOAM533svbCmOEo1ePpOk12Fo5O6EwKIBOEy75Mlb9Ff5jRUWUPE/r/X
        WVSEC+E1gNiKZzIYecpzzt9AWCEV6Ds=
X-Google-Smtp-Source: ABdhPJwBVnJViZTrV7cGmCrD9jUOLH0lbylvShjybHSni6ZC+xTtgMK+gEHA+7CneH9uaOGIhcvMcg==
X-Received: by 2002:aa7:cb86:: with SMTP id r6mr77550719edt.236.1636127152179;
        Fri, 05 Nov 2021 08:45:52 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.45.51
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:45:51 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 10/36] libsepol: add checks for read sizes
Date:   Fri,  5 Nov 2021 16:45:12 +0100
Message-Id: <20211105154542.38434-11-cgzones@googlemail.com>
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

Add checks for invalid read sizes from a binary policy to guard
allocations.

The common and class permission counts needs to be limited more strict
otherwise a too high count of common or class permissions can lead to
permission values with a too high value, which can lead to overflows
in shift operations.

In the fuzzer build the value will also be bounded to avoid oom reports.

    ==29857== ERROR: libFuzzer: out-of-memory (malloc(17179868160))
       To change the out-of-memory limit use -rss_limit_mb=<N>

        #0 0x52dc61 in __sanitizer_print_stack_trace (./out/binpolicy-fuzzer+0x52dc61)
        #1 0x475618 in fuzzer::PrintStackTrace() fuzzer.o
        #2 0x458855 in fuzzer::Fuzzer::HandleMalloc(unsigned long) fuzzer.o
        #3 0x45876a in fuzzer::MallocHook(void const volatile*, unsigned long) fuzzer.o
        #4 0x534557 in __sanitizer::RunMallocHooks(void const*, unsigned long) (./out/binpolicy-fuzzer+0x534557)
        #5 0x4aa7d7 in __asan::Allocator::Allocate(unsigned long, unsigned long, __sanitizer::BufferedStackTrace*, __asan::AllocType, bool) (./out/binpolicy-fuzzer+0x4aa7d7)
        #6 0x4aa143 in __asan::asan_malloc(unsigned long, __sanitizer::BufferedStackTrace*) (./out/binpolicy-fuzzer+0x4aa143)
        #7 0x5259cb in malloc (./out/binpolicy-fuzzer+0x5259cb)
        #8 0x580b5d in mallocarray ./libsepol/src/./private.h:93:9
        #9 0x57c2ed in scope_read ./libsepol/src/policydb.c:4120:7
        #10 0x576b0d in policydb_read ./libsepol/src/policydb.c:4462:9
        #11 0x55a214 in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:26:6
        #12 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #13 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #14 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #15 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
        #16 0x7ffad6e107ec in __libc_start_main csu/../csu/libc-start.c:332:16
        #17 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

    ==19462== ERROR: libFuzzer: out-of-memory (malloc(18253611008))
       To change the out-of-memory limit use -rss_limit_mb=<N>

        #0 0x52dc61 in __sanitizer_print_stack_trace (./out/binpolicy-fuzzer+0x52dc61)
        #1 0x475618 in fuzzer::PrintStackTrace() fuzzer.o
        #2 0x458855 in fuzzer::Fuzzer::HandleMalloc(unsigned long) fuzzer.o
        #3 0x45876a in fuzzer::MallocHook(void const volatile*, unsigned long) fuzzer.o
        #4 0x534557 in __sanitizer::RunMallocHooks(void const*, unsigned long) (./out/binpolicy-fuzzer+0x534557)
        #5 0x4aa7d7 in __asan::Allocator::Allocate(unsigned long, unsigned long, __sanitizer::BufferedStackTrace*, __asan::AllocType, bool) (./out/binpolicy-fuzzer+0x4aa7d7)
        #6 0x4aa999 in __asan::asan_calloc(unsigned long, unsigned long, __sanitizer::BufferedStackTrace*) (./out/binpolicy-fuzzer+0x4aa999)
        #7 0x525b63 in __interceptor_calloc (./out/binpolicy-fuzzer+0x525b63)
        #8 0x570938 in policydb_index_others ./libsepol/src/policydb.c:1245:6
        #9 0x5771f3 in policydb_read ./src/policydb.c:4481:6
        #10 0x55a214 in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:26:6
        #11 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #12 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #13 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #14 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
        #15 0x7f4d933157ec in __libc_start_main csu/../csu/libc-start.c:332:16
        #16 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index dcea1807..1408405d 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2103,6 +2103,8 @@ static int common_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
 	if (symtab_init(&comdatum->permissions, PERM_SYMTAB_SIZE))
 		goto bad;
 	comdatum->permissions.nprim = le32_to_cpu(buf[2]);
+	if (comdatum->permissions.nprim > 32)
+		goto bad;
 	nel = le32_to_cpu(buf[3]);
 
 	key = malloc(len + 1);
@@ -2251,6 +2253,8 @@ static int class_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
 	if (symtab_init(&cladatum->permissions, PERM_SYMTAB_SIZE))
 		goto bad;
 	cladatum->permissions.nprim = le32_to_cpu(buf[3]);
+	if (cladatum->permissions.nprim > 32)
+		goto bad;
 	nel = le32_to_cpu(buf[4]);
 
 	ncons = le32_to_cpu(buf[5]);
@@ -3980,6 +3984,8 @@ static int avrule_decl_read(policydb_t * p, avrule_decl_t * decl,
 		if (rc < 0) 
 			return -1;
 		nprim = le32_to_cpu(buf[0]);
+		if (is_saturated(nprim))
+			return -1;
 		nel = le32_to_cpu(buf[1]);
 		for (j = 0; j < nel; j++) {
 			if (read_f[i] (p, decl->symtab[i].table, fp)) {
@@ -4106,7 +4112,7 @@ static int scope_read(policydb_t * p, int symnum, struct policy_file *fp)
 		goto cleanup;
 	scope->scope = le32_to_cpu(buf[0]);
 	scope->decl_ids_len = le32_to_cpu(buf[1]);
-	if (scope->decl_ids_len == 0) {
+	if (zero_or_saturated(scope->decl_ids_len)) {
 		ERR(fp->handle, "invalid scope with no declaration");
 		goto cleanup;
 	}
@@ -4396,6 +4402,8 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 		if (rc < 0)
 			goto bad;
 		nprim = le32_to_cpu(buf[0]);
+		if (is_saturated(nprim))
+			goto bad;
 		nel = le32_to_cpu(buf[1]);
 		if (nel && !nprim) {
 			ERR(fp->handle, "unexpected items in symbol table with no symbol");
-- 
2.33.1

