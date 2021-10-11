Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EACC4332F
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F44660E8B
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhJKQ23 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbhJKQ23 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:29 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FC2C06161C
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w14so18196740edv.11
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KdZ9FDciXkEH9cgD4Fn+Yo18eekBb9pCxyRlHDV5C9s=;
        b=h0OuQn0/d6nvv6cBAdzS/Z85RwWfCxDM8IV8Dvob1qDN2NZuY9ITMvUGCy+iJIjPa7
         VmlbMdC7cijHdDYk666u2oom7oNECff0Iy/PMuCJnyeUKB3aEYdGUJHNFKBipHU8malM
         xbchEaZBE+CiFXXT/TQy/ZdSjQVGCB9H9aBUpawNM3ffNtvvQI21vKTeveRkfkBtBMrx
         BapbhkrCqFgTi66YAzI3ndgqvkYladcA0gqWAc2aiWwp13ZW7Dr+p3DUTFxGUT3GXx3g
         akVnsWhATwwnRhagtZkXNFXWuEZtjvHY4aYTDDQxWA8WrBcUqgibXLJtX1TdG21IHRzP
         aBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KdZ9FDciXkEH9cgD4Fn+Yo18eekBb9pCxyRlHDV5C9s=;
        b=DLycbLUo34R7wdKZYywl8OgoISvnz4UViyvcguzN0Lr8WsxFAt/vr7N5S++GfWJ9V6
         s8HGEwP/pCShIPfmt/TiDHIuc5XtQvCWFBUFW9qULKjf+3UErvbiKs0ZEPx/708EcupB
         A8dViBHniTN6uhleRGVZRLLJyYQlV0Ez2CAyuaXk8JhPlpD7gsXjwH3iTIpt3Nqx57+s
         Nef+ykRMcqj8YWu3yu/an0eBbLvcsOBUvWgL8Gbvm5UrY/VVrXG38TWNrrkQFzqR3Tid
         g6TCNZdzqsoyrAEvXIn/J5/0wDMMtgsK4yDS80LKSpnOhPbCRqYEbXRKHC9nPD2ihua6
         PhBg==
X-Gm-Message-State: AOAM531gL+Z4m0ox6qYsCbOAJjJeeCu+kV6DmqH5trPfWeTzazuCy3VL
        5hm16XrAFVZ19gL9MfTZWqORF5HbRJc=
X-Google-Smtp-Source: ABdhPJyIHBqmYkguYGpBf4puUphCWARSBrcmmhR3cU1Pkw4Gm3d/mgY1b7123YDel7xWRPx3K/EeWA==
X-Received: by 2002:a17:906:4310:: with SMTP id j16mr27028820ejm.48.1633969587223;
        Mon, 11 Oct 2021 09:26:27 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.26
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:26 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 11/35] libsepol: enforce avtab item limit
Date:   Mon, 11 Oct 2021 18:25:09 +0200
Message-Id: <20211011162533.53404-12-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
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
index 93505b20..2a52c69a 100644
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
2.33.0

