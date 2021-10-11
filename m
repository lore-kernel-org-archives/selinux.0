Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965FAC433FE
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DE5660EE5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhJKQ23 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbhJKQ22 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:28 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2081BC061570
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:28 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id p13so70634934edw.0
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NDqMxV/B48TTsPy+yvgHR7q9vo4w9I0W5krJ+UsYWYQ=;
        b=jFQZton+TJu3/bMZ88UNO5qoe4ALVVvD5ADfVfZobbOqKscTiyDw30uh3NIDfIumHx
         5frurmP9L8QVFPg/d49OUbVtdLHQeirURBu8tY2EoO57WZTQnRii/oDEQ1quXgE0zl6J
         uX813hkMXxzdksiquRj1Brn4DuTY5oWM1xv6JAhXGgxFmCA9i34B31zsyqkB/Gyn7hqF
         F3H4IF9jGJLQ/LpbXCFTomtQ21FITFbJoTvtVZcC89LRZ7QoK+kwGWCird+ohV+zhpXI
         nNwsnF64b9HmWzowb7nXICcq9mb94GcKrI+lR97z1Klu4DUr576KPhJWe8CCjVFzKtU+
         cltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NDqMxV/B48TTsPy+yvgHR7q9vo4w9I0W5krJ+UsYWYQ=;
        b=7AaDWz+VuUYjEH4czH8KD5rlxl1VgEqjyDjLF6ESidL6uIQh2VPS7WZNrIec16kAxL
         RoN/qi4owUUYUTXu0L11/4ziRomDHn4kXWM/DNkcLPvn99DgBWExyrRkmW78c28tQqfH
         RGNAGCt1VRML5G0IiLjee0CxbQPzNEiQXKEox7m/gTJ4EwQ4f3W81r9+55WowjRBD8YA
         U9BR5QzpNcm7o6I8TvmFbN4+mDefjpvL7M6zdGRenjT0PHDrX2L4TmQiMcbe8TT/KV9P
         mzgqHrGwb4yoV2C9XIfjzsOHcSIA5YtJH2AdW4rSYgVt9CRmOe8i3WjwsbL9Dav3/Pc0
         dQWA==
X-Gm-Message-State: AOAM533XhbVYNGfrwpCXPTLmEhtdlFn8tHaJ7/ztib11qyDJyl4Amljw
        e17ouJuzYLqo4e96c+6wFPBFVDZdtWg=
X-Google-Smtp-Source: ABdhPJzuOJEtQjaKxDaWr8yepGNjbOKaRIBmtYp625dLQyRp7LJ2YzItAXDdhi1x/6wdTcBqDj+HkA==
X-Received: by 2002:a17:906:1f95:: with SMTP id t21mr25814317ejr.234.1633969586685;
        Mon, 11 Oct 2021 09:26:26 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.26
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:26 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 10/35] libsepol: add checks for read sizes
Date:   Mon, 11 Oct 2021 18:25:08 +0200
Message-Id: <20211011162533.53404-11-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add checks for invalid read sizes from a binary policy to guard
allocations.

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
index 46fb4893..70b503e1 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2103,6 +2103,8 @@ static int common_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
 	if (symtab_init(&comdatum->permissions, PERM_SYMTAB_SIZE))
 		goto bad;
 	comdatum->permissions.nprim = le32_to_cpu(buf[2]);
+	if (is_saturated(comdatum->permissions.nprim))
+		goto bad;
 	nel = le32_to_cpu(buf[3]);
 
 	key = malloc(len + 1);
@@ -2251,6 +2253,8 @@ static int class_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
 	if (symtab_init(&cladatum->permissions, PERM_SYMTAB_SIZE))
 		goto bad;
 	cladatum->permissions.nprim = le32_to_cpu(buf[3]);
+	if (is_saturated(cladatum->permissions.nprim))
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
2.33.0

