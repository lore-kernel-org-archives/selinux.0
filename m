Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507E3C433FE
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4012F61108
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhKEPst (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbhKEPsn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:43 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1DFC06120A
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:46:03 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ee33so34759053edb.8
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/QgjYSu1JvpgUvCJeefqojarJQO7cv7F5h+TErWmEHI=;
        b=cJnDpoMPfZA2p7S7/v0M1GfVByNfzxATqrf0GoZEq+/E9D7vdmVLoPmrRI4yVV23ZX
         rXRmYZEOztxYFhLQKcZWXhqO+1AUtjP5Lv1sjqtlqJEU/QNyqibUc8KpXk0ytSmqKQMN
         c86ijiJamIrri2q3tKrqS5koSz85Nf4M4PC+4IozDbb0O/34pcrqC3tWH/7eaLmmDLaL
         BItRVfWzz4Mj6n0cOro8PdBZHP9b1Oyvh9PSCrJxjurJ+LgpOZ/1iLMtvD7GNrgUNVN4
         iG6jromAaOguqlKVyJE2KzGStnzNs6dfo0PYajIay9ZjmuJYJvqELq1SpwJ9uG1viG8J
         /iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/QgjYSu1JvpgUvCJeefqojarJQO7cv7F5h+TErWmEHI=;
        b=1qDBuzkmPR7rxpBmWYSNQlH6LNGqrn7WR34dpWsGCd+/C2oA6wy61RSoschkvjeJ5k
         sK+6XBmqKZAnC7vTesEqqxrvR6DoHTgqAdhNqy8AF0hBaOyedyKj5xRw0Lze11PuPmIJ
         cVcZSC2h9whd2jwWe4JRj+noS4wdZP1FOVzwPy7089s35RsQ2BUhd0VNwWPEFN93D20F
         uSGUwk7hPKVYi8UmJ4kkI/zqIiuaa4xajqvQH/WIzlADF3oynrThJo1IMNlRv0NYCAhw
         fS/MUgI1BH26amsb8VYrLOqupIlHBFfi3glIJIMGt4/lx1ZTV0qxdAEc1x7/35X1EXV5
         Ummg==
X-Gm-Message-State: AOAM530RE3WnThoHLQC56lu2b3q2dG7+4/IhTwVxsMloGjHuz4uXsv7i
        G/zkziwPG0WAsTb+Vxy8TR6pwnaVYoo=
X-Google-Smtp-Source: ABdhPJz9l11NyhuIb4Fd8KvVvKxm1aBd+Y893v3qBFUjHRxsedp0iUlL1BPijSljhBGfR4CrcENwIw==
X-Received: by 2002:a05:6402:2693:: with SMTP id w19mr15400181edd.257.1636127159984;
        Fri, 05 Nov 2021 08:45:59 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.45.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:45:59 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 24/36] libsepol: validate expanded user range and level
Date:   Fri,  5 Nov 2021 16:45:26 +0100
Message-Id: <20211105154542.38434-25-cgzones@googlemail.com>
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

Check those contains valid values.

    ==57532==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x603000001178 at pc 0x000000564c04 bp 0x7ffed7a5ad90 sp 0x7ffed7a5ad88
    READ of size 8 at 0x603000001178 thread T0
        #0 0x564c03 in level_to_str ./libsepol/src/kernel_to_conf.c:1901:19
        #1 0x564c03 in range_to_str ./libsepol/src/kernel_to_conf.c:1926:9
        #2 0x564c03 in write_user_decl_rules_to_conf ./libsepol/src/kernel_to_conf.c:2367:12
        #3 0x55b137 in sepol_kernel_policydb_to_conf ./libsepol/src/kernel_to_conf.c:3184:7
        #4 0x55a34f in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:38:9
        #5 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #6 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #7 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #8 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
        #9 0x7f2c2e1a77ec in __libc_start_main csu/../csu/libc-start.c:332:16
        #10 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 03ab4445..adaa3fb2 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -340,7 +340,20 @@ static int validate_level_datum(__attribute__ ((unused)) hashtab_key_t k, hashta
 	return validate_mls_level(level->level, &flavors[SYM_LEVELS], &flavors[SYM_CATS]);
 }
 
-static int validate_user_datum(sepol_handle_t *handle, user_datum_t *user, validate_t flavors[])
+static int validate_mls_range(mls_range_t *range, validate_t *sens, validate_t *cats)
+{
+	if (validate_mls_level(&range->level[0], sens, cats))
+		goto bad;
+	if (validate_mls_level(&range->level[1], sens, cats))
+		goto bad;
+
+	return 0;
+
+	bad:
+	return -1;
+}
+
+static int validate_user_datum(sepol_handle_t *handle, user_datum_t *user, validate_t flavors[], int mls)
 {
 	if (validate_value(user->s.value, &flavors[SYM_USERS]))
 		goto bad;
@@ -350,6 +363,10 @@ static int validate_user_datum(sepol_handle_t *handle, user_datum_t *user, valid
 		goto bad;
 	if (validate_mls_semantic_level(&user->dfltlevel, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
 		goto bad;
+	if (mls && validate_mls_range(&user->exp_range, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
+		goto bad;
+	if (mls && validate_mls_level(&user->exp_dfltlevel, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
+		goto bad;
 	if (user->bounds && validate_value(user->bounds, &flavors[SYM_USERS]))
 		goto bad;
 
@@ -364,7 +381,7 @@ static int validate_user_datum_wrapper(__attribute__((unused)) hashtab_key_t k,
 {
 	map_arg_t *margs = args;
 
-	return validate_user_datum(margs->handle, d, margs->flavors);
+	return validate_user_datum(margs->handle, d, margs->flavors, margs->mls);
 }
 
 static int validate_datum_array_gaps(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
-- 
2.33.1

