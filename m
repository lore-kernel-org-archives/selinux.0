Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70E8C4321E
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA36261183
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhKEPsf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbhKEPsf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:35 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B04C061714
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:45:54 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b15so15222599edd.7
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=E3uhquq8thBUgDTs6GsBKpcBitVfPLdjYHlKjwigYZM=;
        b=MJSx4VFNQ2bSV2X5FN1zfrXC82+AHuPZN3mpnSRzyoctyO9H38vbPqnWO0ZdN7+sbY
         K/GVGh/CFLy29DJsDtQzCq+Apo59/CWeCVBO59fHx6FQIg97Ohaedo03Q0qyBX0C9QD/
         kHia+uuMCgXWoDvPZIucN4UfA5P4ojmNDMphm9ZdPoa4Ag+7r88b7MvZGfTnUKjaBvjn
         gy5s7wtqYEX3S31VgzPSIKnfJ7d+zq+Z1BWwiOabx0hAj8co4efsfZgUK9uNsG6iF2HD
         J6RMdOlMiYJCiqdzSvTDjLtW7QU/3DdmtAblYnL5EpmaplQt3ucBnJIpY/Sb0hn5N6ei
         cxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E3uhquq8thBUgDTs6GsBKpcBitVfPLdjYHlKjwigYZM=;
        b=EhpKlDYi4ZgCpMofyel7hyxF7FgbzEzWkjj9k3Kkk/Af5M8P/Yp1bZRr7reMIqwBza
         cg/5hXnRLDuBVNC1kcsr3V6Yz52SEDRuUD5wZFb10FKogI7IZvCCL1+ZQM4ggPowaEAl
         tNyxPBLUuoXe/HyS1gZgyvq+ymL+o8xnV+LLG1YOR/GIbgOsjc5ufwwGlXFPe6o8Seaw
         t9vHben6ZvwKqMUMz5Z0xEDuRzDA746md4YSzk7ieuSWkxTT+MvZrAtByonpc8jGFzkr
         MPxFDdwiWUOdlpoZ06a+B6Z05IvwYM1b35pSt1yakAog33+IgJLO4Fn56GHwSGJCpvUF
         V8TQ==
X-Gm-Message-State: AOAM533inKsXR7rHMGFmpgBgG/hZ0QkzpSBou7oefoaxMUKmOTeCrljz
        k3KdS04DekR5LLSBsvC3viH6yZJV+FE=
X-Google-Smtp-Source: ABdhPJxrLThmAqYAzLIFAeAhdF/EhJo5j3453bTgQW6Nywih2Uur/oUM4ch+xSrW9Fr3Ni5F5c9k7g==
X-Received: by 2002:aa7:d7cb:: with SMTP id e11mr43164711eds.295.1636127152735;
        Fri, 05 Nov 2021 08:45:52 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.45.52
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:45:52 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 11/36] libsepol: enforce avtab item limit
Date:   Fri,  5 Nov 2021 16:45:13 +0100
Message-Id: <20211105154542.38434-12-cgzones@googlemail.com>
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

Check the current item count does not exceed the maximum allowed to
avoid stack overflows.

    ==33660==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7fa64b8fc070 at pc 0x0000005acba0 bp 0x7ffc1f0b2870 sp 0x7ffc1f0b2868
    READ of size 4 at 0x7fa64b8fc070 thread T0
        #0 0x5acb9f in avtab_read_item ./libsepol/src/avtab.c:507:18
        #1 0x5acec4 in avtab_read ./libsepol/src/avtab.c:611:8
        #2 0x576ae3 in policydb_read ./libsepol/src/policydb.c:4433:7
        #3 0x55a1fe in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:24:6
        #4 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #5 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #6 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #7 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
        #8 0x7fa64cc867ec in __libc_start_main csu/../csu/libc-start.c:332:16
        #9 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

    Address 0x7fa64b8fc070 is located in stack of thread T0 at offset 112 in frame
        #0 0x5aabdf in avtab_read_item ./libsepol/src/avtab.c:437

      This frame has 6 object(s):
        [32, 33) 'buf8' (line 438)
        [48, 56) 'buf16' (line 439)
        [80, 112) 'buf32' (line 440) <== Memory access at offset 112 overflows this variable
        [144, 152) 'key' (line 441)
        [176, 192) 'datum' (line 442)
        [208, 244) 'xperms' (line 443)
    HINT: this may be a false positive if your program uses some custom stack unwind mechanism, swapcontext or vfork
          (longjmp and C++ exceptions *are* supported)
    SUMMARY: AddressSanitizer: stack-buffer-overflow ./libsepol/src/avtab.c:507:18 in avtab_read_item
    Shadow bytes around the buggy address:
      0x0ff5497177b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
      0x0ff5497177c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
      0x0ff5497177d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
      0x0ff5497177e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
      0x0ff5497177f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    =>0x0ff549717800: f1 f1 f1 f1 01 f2 00 f2 f2 f2 00 00 00 00[f2]f2
      0x0ff549717810: f2 f2 00 f2 f2 f2 00 00 f2 f2 00 00 00 00 04 f3
      0x0ff549717820: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
      0x0ff549717830: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
      0x0ff549717840: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
      0x0ff549717850: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    Shadow byte legend (one shadow byte represents 8 application bytes):
      Addressable:           00
      Partially addressable: 01 02 03 04 05 06 07
      Heap left redzone:       fa
      Freed heap region:       fd
      Stack left redzone:      f1
      Stack mid redzone:       f2
      Stack right redzone:     f3
      Stack after return:      f5
      Stack use after scope:   f8
      Global redzone:          f9
      Global init order:       f6
      Poisoned by user:        f7
      Container overflow:      fc
      Array cookie:            ac
      Intra object redzone:    bb
      ASan internal:           fe
      Left alloca redzone:     ca
      Right alloca redzone:    cb
    ==33660==ABORTING

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/avtab.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 46e1e75d..64aab683 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -503,6 +503,12 @@ int avtab_read_item(struct policy_file *fp, uint32_t vers, avtab_t * a,
 
 		for (i = 0; i < ARRAY_SIZE(spec_order); i++) {
 			if (val & spec_order[i]) {
+				if (items > items2) {
+					ERR(fp->handle,
+					    "entry has too many items (%d/%d)",
+					    items, items2);
+					return -1;
+				}
 				key.specified = spec_order[i] | enabled;
 				datum.data = le32_to_cpu(buf32[items++]);
 				rc = insertf(a, &key, &datum, p);
-- 
2.33.1

