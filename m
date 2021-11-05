Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0DCC433FE
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19F7761183
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhKEPsz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbhKEPst (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:49 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0033C06120B
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:46:08 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c8so17815424ede.13
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TUlCeo2ndy15KZjUrKbJDXWsVa9xRreKhVZbeV9c6B4=;
        b=ptisX0dE4bf4Vux3mzI8+IAf7ARgdKCOjOKr5mSrNbEPzLxJG6S8TFcrqmb2lw4EpQ
         bOe95qEQp/qFkBwq1DLrc43i8S1trCWXxOcaBeHyZqKUE5oiCtpbFyejzfU0CcCQLblJ
         hkYf8VZBIUxpeBSBItz8LSWMDvQjQjg/Qkvkqg/4lT9CNAK9RINqVWNyMCds4DiBqRQq
         eAIPLDAfkiRA2irzXg+5fBwyB9CTzbE/EbLlQE+aiFCOdaMDcjxVAYMadsAKcPGMyxr2
         8VM2JlveaukbS0PZpJlvfnkDE3ajMk0Zy0ihp6HTQcZqrF1wx5UCJDLlxTaOuABZLtRK
         3N+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TUlCeo2ndy15KZjUrKbJDXWsVa9xRreKhVZbeV9c6B4=;
        b=39qR5IBDN5QEHfFjgMErHPMvz00c3A0ncIy7XejpstCyUo3kF2Owz7D9o5y+XZLhqX
         VJoFEpvinkLHpMW3Ni/v273Yg3g14JaaXvff4KramnDWG0v7TV1yY12WqjSitXbaoAOk
         cvKdM/TGAbR8boznFXGqsAoMOayFGhwkoixGC+GE67LAmaXC8CFaVub3fK8BO0ZXk3jZ
         FJ/9+SJtAbDZX+9pELXvcj6fmmQG0Rr5vDpZl1hV3l1Qs6PcHsMpb4bKM5/rOd1wWf7V
         vVoN7IrxL23Iuw54ddwqKfg03U+TRZTzHHjmm79RWZIvyXSI0LqvCADRBqyGmKcndb3P
         3NNw==
X-Gm-Message-State: AOAM531JXz65NHk6Kqz5a2YoyQnQDF6EgTvaHfMs2RMF+uKhXFjv30r/
        3ziSrZELvv0wGeALPCafjtVMhmGCxQQ=
X-Google-Smtp-Source: ABdhPJwBT4VBtdADioAszkvzG8c/H0gkXso1VPkJl43RYYOdkw/fElRpJI4jdORuFlr0HsD9zZgVTQ==
X-Received: by 2002:a17:906:1112:: with SMTP id h18mr4249915eja.50.1636127167305;
        Fri, 05 Nov 2021 08:46:07 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.46.06
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:46:07 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 34/36] libsepol: validate categories
Date:   Fri,  5 Nov 2021 16:45:36 +0100
Message-Id: <20211105154542.38434-35-cgzones@googlemail.com>
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

Check all categories have valid values, especially important for
aliases.

        ==7888==ERROR: AddressSanitizer: SEGV on unknown address 0x602000400710 (pc 0x00000055debc bp 0x7ffe0ff2a9d0 sp 0x7ffe0ff2a8e0 T0)
        ==7888==The signal is caused by a READ memory access.
        #0 0x55debc in write_category_rules_to_conf ./libsepol/src/kernel_to_conf.c:946:9
        #1 0x55debc in write_mls_rules_to_conf ./libsepol/src/kernel_to_conf.c:1137:7
        #2 0x55adb1 in sepol_kernel_policydb_to_conf ./libsepol/src/kernel_to_conf.c:3106:7
        #3 0x55a34f in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:37:9
        #4 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #5 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #6 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #7 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
        #8 0x7fe80ccaf7ec in __libc_start_main csu/../csu/libc-start.c:332:16
        #9 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 27f25132..9b18ac68 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -485,6 +485,14 @@ bad:
 	return -1;
 }
 
+static int validate_datum(__attribute__ ((unused))hashtab_key_t k, hashtab_datum_t d, void *args)
+{
+	symtab_datum_t *s = d;
+	uint32_t *nprim = (uint32_t *)args;
+
+	return !value_isvalid(s->value, *nprim);
+}
+
 static int validate_datum_array_entries(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
 {
 	map_arg_t margs = { flavors, handle, p->mls };
@@ -507,6 +515,9 @@ static int validate_datum_array_entries(sepol_handle_t *handle, policydb_t *p, v
 	if (p->mls && hashtab_map(p->p_levels.table, validate_level_datum, flavors))
 		goto bad;
 
+	if (hashtab_map(p->p_cats.table, validate_datum, &flavors[SYM_CATS]))
+		goto bad;
+
 	return 0;
 
 bad:
@@ -903,14 +914,6 @@ bad:
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
2.33.1

