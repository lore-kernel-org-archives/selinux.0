Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE21C433EF
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9771D61245
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbhKEPsm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbhKEPsl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:41 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49155C061205
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:46:01 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id f4so34276502edx.12
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yHys3UiPKnhYsikWE9Oxx2ureNYyUBVxBSmN52aKrY0=;
        b=q4ySG158+j1ZbER37u0JISnjewSQqEqsTdnTmMRuoa7O9+WUyYYtl37fC4CH3OMX8I
         +1McFDFsgFoSrH1FsS4AM1NtY/+lamhi1ZlpDqHXGhr94sK/xlJ6UqR0x4Fa0Ol4pPd1
         wrNdxeYRbiuENouXTnlPgxEJl2+hbIe3VP2yjlIhaloelRoTfIYEvJLv2t3OrP9sKOuF
         UdpwGxKfptrFLwOt8UilH5xGONJuXSm1vJyUFMGchMvsNGJa4x4Wr7pByLkwQM5DTLX6
         qY0XYPVOBto4ICBmPGy5HtePQD/hRwEZvN+b3BHy6xfBfuTV19vTH1MhRVzhLSzS0SEw
         stTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yHys3UiPKnhYsikWE9Oxx2ureNYyUBVxBSmN52aKrY0=;
        b=HdRgndB8IrT/kWdliwZWBYYWGOP4/MMsvltf9Cbf23XTCdW0d4P644IY2CquuuX1CX
         FDWSDlpxPlsX9e1NtSGAWG5YB1cFi/UJkjwBQ3Tu/CtGwmAFT3CAPwkA+ppvqLYmF7Vq
         VovsJKoV9ahE43il4HvebN4iR+ejMCiTq1y2+rCgWdWQbZnQaJ2WrdE1rALzXaVFiqB1
         7L8VAVdsI92/3FTWuvz+sxmWW8kGD505/+xs2MDFAyeVc6J91+I0ObjSuZ0Ns8h3ituB
         h6wTZhHcpIO0uKcesRD8oFNtGOi5e/u5qKTq6H2z9B/7+jwt7az0b/XmSteVuVs4qP/g
         ddEA==
X-Gm-Message-State: AOAM533NqmnTWMZVxg2VG4MXl4z/33cGEcC/Is1JpzUV26FPM6UJ8KOj
        Mrp7HpokU0jEbBEWzuWdYpNFgOqR/Ow=
X-Google-Smtp-Source: ABdhPJy0fESnjVrkE0Xam6qjehINy3wNlOOJAje5TzAKdDy3qnOz7dS8gz1EXEY7iH+oSNe26jroCg==
X-Received: by 2002:a17:907:97cc:: with SMTP id js12mr4372018ejc.175.1636127159324;
        Fri, 05 Nov 2021 08:45:59 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.45.58
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:45:59 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 23/36] libsepol: validate MLS levels
Date:   Fri,  5 Nov 2021 16:45:25 +0100
Message-Id: <20211105154542.38434-24-cgzones@googlemail.com>
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

Validate the level map of the policy to ensure no level refers to a non
existent category.

READ of size 8 at 0x602000000c58 thread T0
    #0 0x568d2c in cats_ebitmap_len ./libsepol/src/kernel_to_conf.c:1003:14
    #1 0x568d2c in cats_ebitmap_to_str ./libsepol/src/kernel_to_conf.c:1038:19
    #2 0x55e371 in write_level_rules_to_conf ./libsepol/src/kernel_to_conf.c:1106:11
    #3 0x55e371 in write_mls_rules_to_conf ./libsepol/src/kernel_to_conf.c:1140:7
    #4 0x55adb1 in sepol_kernel_policydb_to_conf ./libsepol/src/kernel_to_conf.c:3103:7
    #5 0x55a34f in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:38:9
    #6 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
    #7 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
    #8 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
    #9 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
    #10 0x7f741d0d67ec in __libc_start_main csu/../csu/libc-start.c:332:16
    #11 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index d4dfab5c..03ab4445 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -319,6 +319,27 @@ bad:
 	return -1;
 }
 
+static int validate_mls_level(mls_level_t *level, validate_t *sens, validate_t *cats)
+{
+	if (validate_value(level->sens, sens))
+		goto bad;
+	if (validate_ebitmap(&level->cat, cats))
+		goto bad;
+
+	return 0;
+
+	bad:
+	return -1;
+}
+
+static int validate_level_datum(__attribute__ ((unused)) hashtab_key_t k, hashtab_datum_t d, void *args)
+{
+	level_datum_t *level = d;
+	validate_t *flavors = args;
+
+	return validate_mls_level(level->level, &flavors[SYM_LEVELS], &flavors[SYM_CATS]);
+}
+
 static int validate_user_datum(sepol_handle_t *handle, user_datum_t *user, validate_t flavors[])
 {
 	if (validate_value(user->s.value, &flavors[SYM_USERS]))
@@ -399,6 +420,9 @@ static int validate_datum_array_entries(sepol_handle_t *handle, policydb_t *p, v
 	if (hashtab_map(p->p_users.table, validate_user_datum_wrapper, &margs))
 		goto bad;
 
+	if (p->mls && hashtab_map(p->p_levels.table, validate_level_datum, flavors))
+		goto bad;
+
 	return 0;
 
 bad:
-- 
2.33.1

