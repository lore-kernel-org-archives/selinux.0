Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7583AC433EF
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbhLIQyy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbhLIQyy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:54:54 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CA4C061746
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:51:20 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x15so21953588edv.1
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Dt1Evq91akr68arcCNxx+ZiMHVKLkU4ZfPXM5NAeNBM=;
        b=NEtx3PH7cV0Ft1Gru0MqNjzszFxu8JxnuQo9XhOr/QSyYXUzlbEIE75KIg7klP7vOm
         uL1OIDc25n78xcQEsldwTpJlWcA0jp1XF8Xqb1pFvo5ZKXo+nv429E81Tiu1VHYvwUWa
         7tgx72EEaju+oV90/SjrTsPsebnfe6zdhJeRZ5j5n9CXz8e0CKbZRr8irwky2XMt0Baj
         nZ6LtSrT7rid8B22ldRFHFLyh/NmMW9dWQG7Kt2QQkaF8Yd5RBKZIFzGMYO2oO9RnvZZ
         oCyTnYsf34Re/CyCaqg0a+k7mnf4HboednqYWQbKdOQO97P3clkP6qzZSCg8MLjiyYoY
         GZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dt1Evq91akr68arcCNxx+ZiMHVKLkU4ZfPXM5NAeNBM=;
        b=rJItTTlDtQDVtfLorYzeouAAH0URsNtVeTk+C/yIdzHe/0WxRBH0Rn+IfSgOWVllrD
         Rv+fh0XzbFLgG3OmxrpQXtaHR/HlWhHWwEWHhEJIbmx3nmUQNyiSauEMQiYQLWBE5/8Z
         xBvXbmfvDk+e/13xIzr+0kbTULwhnXwMYo6XoVCldAJalitclLp6CHSw1sl2Ker9MuKH
         QvnGG7eLNDcgwvR/mV/1GjYgCNsHYallze/1URsi9oxYv4UM80DUhiY/I15Qj88pS7x/
         5BqI35qJGVfdaEnhJ9WlTQywIGs9rJ0GV0BTSlUlOYQviTC+d/kw8vOjwI2EV6ZeSgCA
         Ja/g==
X-Gm-Message-State: AOAM530ou2TmnIgXlQY7YNMxS5iHC2dMbqOcEM6A0xAKjSsD4Oy02v9h
        A6L3qtdLEdJJy6XKu5gJBFy39R0vZJc=
X-Google-Smtp-Source: ABdhPJwm0B1Nm2pat1VacWgc0qH7O5YCmjh3+BCkkfdL/dJ2Ss3cneLkgLhEDrO2mwkHb4iqOXg+QQ==
X-Received: by 2002:a50:a6ca:: with SMTP id f10mr30157998edc.81.1639068582216;
        Thu, 09 Dec 2021 08:49:42 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.41
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:41 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 10/36] libsepol: add checks for read sizes
Date:   Thu,  9 Dec 2021 17:49:02 +0100
Message-Id: <20211209164928.87459-11-cgzones@googlemail.com>
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
v3:
   - use PERM_SYMTAB_SIZE instead of bare 32 as limit
---
 libsepol/src/policydb.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index dcea1807..0b2edf51 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2103,6 +2103,8 @@ static int common_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
 	if (symtab_init(&comdatum->permissions, PERM_SYMTAB_SIZE))
 		goto bad;
 	comdatum->permissions.nprim = le32_to_cpu(buf[2]);
+	if (comdatum->permissions.nprim > PERM_SYMTAB_SIZE)
+		goto bad;
 	nel = le32_to_cpu(buf[3]);
 
 	key = malloc(len + 1);
@@ -2251,6 +2253,8 @@ static int class_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
 	if (symtab_init(&cladatum->permissions, PERM_SYMTAB_SIZE))
 		goto bad;
 	cladatum->permissions.nprim = le32_to_cpu(buf[3]);
+	if (cladatum->permissions.nprim > PERM_SYMTAB_SIZE)
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
2.34.1

