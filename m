Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9903FC433FE
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241014AbhLIQ4C (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241361AbhLIQz6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:55:58 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E65C061746
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:52:24 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id r25so21071582edq.7
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Kmz/hM8L/FCDEwk+gpm5Na9cTojqkPoX7csANTjH09A=;
        b=IYJuYW/ieR+cxjHoVc1NlXS4G4Nq9zj4qmJFyFF1z/+rHFtbhFZvpOry76pEnM9W4i
         w3EMao39sWk6tbhpw8gITLM2X+osyvk6Vx7BHkbcT6O9cUDQ/Iv7YC0PZbUMQN253Qv5
         vRLKRbHyBZn26vbTwefvjwPwNYyexpw+Es0ad2zBcDc6YP8iyWUJJaHzLcZdBAZtvrzy
         2i3HqNxerU75fgb+kyW91VnM23NOIUt4vYlVHodj7okiuTwbt+xpOL3jF4mPb0MAKjHL
         d5gpll+z5A7yBX3tJb2KvE4t+Vf0cMpSi2+bPUGU5y0y9xE774UMaYL6XhUsdIS2E8Yl
         4kog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kmz/hM8L/FCDEwk+gpm5Na9cTojqkPoX7csANTjH09A=;
        b=J5jcYO5Yh7wAxpYesB/okGAP+Q4zL3vG0PdQNuZYZuceCBCfqHKF9iXg8a4qS+R2eF
         0csVVU8v7Sb1AcXVDWit8zEXalXWmRlnmLE6OEQeCdFDI2KIHfqfIM7vJOw0evv5odkp
         hHyMidO5K96uVzAGAUmdNz34ijdmG+3sW6ICDYZQuCFgfpAyyLTWCPsTkQvlpiYv0bJP
         hVdLib36UDZBrdJpRb+S4+4bc3J6PRYxyWYeeWftr7kpmT9+uNIcEhEL7Gvf3wrM+zQ4
         i5Zk4a25ilO5zymGo1e1BtOSBlowCNSYV56OHeeDHKkzVfmi+xyqi+QmAhOrQ1FEIxjZ
         hc6A==
X-Gm-Message-State: AOAM531xxg+I7JE/ACmP6KdhqtbXb184ZmYV7g9vwGlLDvWkrNXDqZwI
        g/5MXc6n7u1QufAt0YvLhPBAMqFhSeg=
X-Google-Smtp-Source: ABdhPJxSt6kuNuIZC1EQWHMkWkoSwv2+iuJdRFztzCaaT663Yb4RuWVG0A81qqu/jRCEj01EtQU5ww==
X-Received: by 2002:a05:6402:27cf:: with SMTP id c15mr26153053ede.128.1639068582779;
        Thu, 09 Dec 2021 08:49:42 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:42 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 11/36] libsepol: enforce avtab item limit
Date:   Thu,  9 Dec 2021 17:49:03 +0100
Message-Id: <20211209164928.87459-12-cgzones@googlemail.com>
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
v3:
   take zero based numbering of variable items into account
---
 libsepol/src/avtab.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 46e1e75d..e9b17664 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -503,6 +503,12 @@ int avtab_read_item(struct policy_file *fp, uint32_t vers, avtab_t * a,
 
 		for (i = 0; i < ARRAY_SIZE(spec_order); i++) {
 			if (val & spec_order[i]) {
+				if (items >= items2) {
+					ERR(fp->handle,
+					    "entry has too many items (%d/%d)",
+					    items + /* zero based numbered */ 1, items2);
+					return -1;
+				}
 				key.specified = spec_order[i] | enabled;
 				datum.data = le32_to_cpu(buf32[items++]);
 				rc = insertf(a, &key, &datum, p);
-- 
2.34.1

