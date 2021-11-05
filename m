Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7006C4332F
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0DB461108
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhKEPsx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhKEPsq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:46 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81CAC06120E
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:46:05 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id c8so17814967ede.13
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3w7t+e9GEyPP8ldO763nnFplvtGbJWWrlSrOtODVyRc=;
        b=LDHT2f7WOxaJ7FOw2nYyGNAbBhHfbHpkcFHs9qq71iMZQwh9um+qA0lhqkJq6cFY9Q
         3+hbVWNUKzhQNEQ2fpTVdSY92WFCswwBJm5iYGkCRjylkGXS8XKW3GVM1gjlRuom+pqg
         Y0cB0r3mSki6CiQvOOv+ELZta4CZjcq4tBRFmpk6aInpJRuMlhdjPn3pzwzjEbvI3IK9
         ZENiYxdih7mtkLXFdfIC+/TYAatiOimQ2HAD4GOzstQ50zE3JbKOJOZ0GWLzBc0lSARJ
         QV3XsDqtwZG8OUH+swgBMAfG3zL15RcjZ4RFKrjHgYTsWvMhAHtA6aEk2t01EIbhOqUp
         KKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3w7t+e9GEyPP8ldO763nnFplvtGbJWWrlSrOtODVyRc=;
        b=OkeMmDBBzmqyiklOfXg5mXe6pqDBIbfuYdHhMZkS9ECMdPI02Rnj9E6mrzXRK+ssqH
         7E6z5HOq4928mW/EE3mTFvKDRAoI17S4yGdWGUTzOHrWdQMQ6/9hnCGq54ws7TwPux8i
         m0ZZYW9mMPWsJrbtxdbmAhiXIVuGT4k4mv4woJRGFHwpOuUy3RW9kRL17Bg4bY8YZYbn
         FZMHAFjbEs2uDcyHltpGsEGBk1596eFqPi9GCDgEotwlnjmDkWVNF1cOMziSAOh+QLJO
         KmlrL5zZerIgplv8gska1Te16gm80AlpKkyKYPqBqXp2cSw3f1kn+LgUWhE4nouc+t6C
         Wv3A==
X-Gm-Message-State: AOAM531mBaY+F3IOUrUo3PaOKvEtXc+mTFEpNRpAAkXe1xiVQ5h0oD7z
        KwNPWajZI8WBwkOne8Z/2QfAS12YrmU=
X-Google-Smtp-Source: ABdhPJxcdPYWwuP/wnywhawZPXKnCCM4IEpfpGyVXbl+6hm6Di5aFFak0HKjwNLFQjuByP0Qx/989Q==
X-Received: by 2002:a17:907:7d88:: with SMTP id oz8mr13740231ejc.173.1636127164453;
        Fri, 05 Nov 2021 08:46:04 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.46.03
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:46:04 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 29/36] libsepol: validate type of avtab type rules
Date:   Fri,  5 Nov 2021 16:45:31 +0100
Message-Id: <20211105154542.38434-30-cgzones@googlemail.com>
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

    ==80903==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x6020000005c0 at pc 0x0000005696c8 bp 0x7ffdb11ea560 sp 0x7ffdb11ea558
    READ of size 8 at 0x6020000005c0 thread T0
        #0 0x5696c7 in avtab_node_to_str ./libsepol/src/kernel_to_conf.c:1736:9
        #1 0x569013 in map_avtab_write_helper ./libsepol/src/kernel_to_conf.c:1767:10
        #2 0x5ab837 in avtab_map ./libsepol/src/avtab.c:347:10
        #3 0x561f9a in write_avtab_flavor_to_conf ./libsepol/src/kernel_to_conf.c:1798:7
        #4 0x561f9a in write_avtab_to_conf ./libsepol/src/kernel_to_conf.c:1819:8
        #5 0x55afba in sepol_kernel_policydb_to_conf ./libsepol/src/kernel_to_conf.c:3159:7
        #6 0x55a34f in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:38:9
        #7 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #8 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #9 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #10 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
        #11 0x7f97a83fd7ec in __libc_start_main csu/../csu/libc-start.c:332:16
        #12 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 25c6f0db..57eb2550 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -547,15 +547,22 @@ bad:
 	return -1;
 }
 
-static int validate_avtab_key_wrapper(avtab_key_t *k,  __attribute__ ((unused)) avtab_datum_t *d, void *args)
+static int validate_avtab_key_and_datum(avtab_key_t *k, avtab_datum_t *d, void *args)
 {
 	validate_t *flavors = (validate_t *)args;
-	return validate_avtab_key(k, flavors);
+
+	if (validate_avtab_key(k, flavors))
+		return -1;
+
+	if ((k->specified & AVTAB_TYPE) && validate_value(d->data, &flavors[SYM_TYPES]))
+		return -1;
+
+	return 0;
 }
 
 static int validate_avtab(sepol_handle_t *handle, avtab_t *avtab, validate_t flavors[])
 {
-	if (avtab_map(avtab, validate_avtab_key_wrapper, flavors)) {
+	if (avtab_map(avtab, validate_avtab_key_and_datum, flavors)) {
 		ERR(handle, "Invalid avtab");
 		return -1;
 	}
-- 
2.33.1

