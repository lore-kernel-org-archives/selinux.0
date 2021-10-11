Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D9CC4332F
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 088A860E8B
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhJKQ2h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbhJKQ2d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:33 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D01C06161C
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:32 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i20so53524277edj.10
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BHup1qlMaWZvty1dyVJCc9ZAK6lZDscNovHZ5OLEpxY=;
        b=LXhCppsUdPHpuEoMgptjPR7ch5NeENM0VU5h2PnXmPvzTlrHiAMcltQm/KnjvRHIj4
         QE4Kk3UDjIQzbBsKvysv05Yff4+8lfzt9xmZEzcga+GYXmSDR9rPJkGgxUpxnkDGpNHG
         4BCJR3GFL0mX3cjStAZquLf1E4VYmHbkMhg1BpdlX8kWwp8W+6p+X8pK4xaPU/OWhF4+
         oP3sQ3HnHS+siJ7AZLYqEBXIJUXckoM4klgeofmNAf+3ygzdtn3RPleRubzrT+IEw7yo
         Fkx15HWylKgls4O/5ImUJUvLHTukhiCa8Y+d8tq7PTP44ma+nJaSUzW+jbPRgWBez9J3
         WSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BHup1qlMaWZvty1dyVJCc9ZAK6lZDscNovHZ5OLEpxY=;
        b=Q++V0vqDUlIQ/lQwiddeRyzNcW/sAiPzFBJ043m+bZciFoc5XiTVaT9LKyV4I15rze
         xPRRrgwHKWKY7AL3UUWITx7LP7FFKQHiWEq20n/eJLKqpxFnNld/6xsWCo76NNsrfvjK
         pMaddzANzbUlx3RiF0pZxyb6rdBJIFz2AwXt7uUgDPjWUKQWF8HTyDg2BizXQjmn1Cd6
         90jaXKdK/H6uUjuTFFmNz5If8rsiWkZgXVwqv6rSYJPQUAiaV8THT0Dp9be0MS5+DJHJ
         pvSKqqttDuNZl2bbaiVjSi9LYOo6YmnXfoqFvtYDzhOONlnBELT+5QiTM0GL9STydJ4S
         NRAQ==
X-Gm-Message-State: AOAM531Qrdw4vrlMfOIOMzzz400ELTWf1E9P/lF659QmDeW4bg5JS/QQ
        b/6UL+sHXXVPOma39y+Mf7JB276CK6I=
X-Google-Smtp-Source: ABdhPJz7Bg2gXI3N5sMx1MDj3Mm+TT2/tHifHM4HRj6cahUL1EfTJtVQa77jz0hHyxPtR99QMMkDZA==
X-Received: by 2002:a17:906:3148:: with SMTP id e8mr26916093eje.240.1633969590474;
        Mon, 11 Oct 2021 09:26:30 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.30
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:30 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 17/35] libsepol: validate types
Date:   Mon, 11 Oct 2021 18:25:15 +0200
Message-Id: <20211011162533.53404-18-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Check all types are valid values, especially important for aliases.

    ==9702==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x602000000af8 at pc 0x000000560698 bp 0x7ffcca93b9f0 sp 0x7ffcca93b9e8
    READ of size 8 at 0x602000000af8 thread T0
        #0 0x560697 in write_type_alias_rules_to_conf ./libsepol/src/kernel_to_conf.c:1424:10
        #1 0x55af16 in sepol_kernel_policydb_to_conf ./libsepol/src/kernel_to_conf.c:3131:7
        #2 0x55a34f in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:38:9
        #3 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #4 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #5 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #6 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
        #7 0x7f518b1d57ec in __libc_start_main csu/../csu/libc-start.c:332:16
        #8 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index a6ae728a..c9700399 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -348,6 +348,14 @@ static int validate_level(__attribute__ ((unused))hashtab_key_t k, hashtab_datum
 	return validate_mls_level(level->level, &flavors[SYM_LEVELS], &flavors[SYM_CATS]);
 }
 
+static int validate_datum(__attribute__ ((unused))hashtab_key_t k, hashtab_datum_t d, void *args)
+{
+	symtab_datum_t *s = d;
+	uint32_t *nprim = (uint32_t *)args;
+
+	return !value_isvalid(s->value, *nprim);
+}
+
 static int validate_datum_arrays(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
 {
 	unsigned int i;
@@ -406,6 +414,9 @@ static int validate_datum_arrays(sepol_handle_t *handle, policydb_t *p, validate
 		}
 	}
 
+	if (hashtab_map(p->p_types.table, validate_datum, &flavors[SYM_TYPES]))
+		goto bad;
+
 	if (hashtab_map(p->p_levels.table, validate_level, flavors))
 		goto bad;
 
@@ -707,14 +718,6 @@ bad:
 	return -1;
 }
 
-static int validate_datum(__attribute__ ((unused))hashtab_key_t k, hashtab_datum_t d, void *args)
-{
-	symtab_datum_t *s = d;
-	uint32_t *nprim = (uint32_t *)args;
-
-	return !value_isvalid(s->value, *nprim);
-}
-
 static int validate_symtabs(sepol_handle_t *handle, symtab_t symtabs[], validate_t flavors[])
 {
 	unsigned int i;
-- 
2.33.0

