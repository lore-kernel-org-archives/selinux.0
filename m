Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD13C433F5
	for <selinux@archiver.kernel.org>; Thu, 23 Dec 2021 17:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349466AbhLWRZz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Dec 2021 12:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbhLWRZy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Dec 2021 12:25:54 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D67C061401
        for <selinux@vger.kernel.org>; Thu, 23 Dec 2021 09:25:54 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id q14so16386283edi.3
        for <selinux@vger.kernel.org>; Thu, 23 Dec 2021 09:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TeqXChMaxp2FFG+ite1K7DDloC4o+My78G8xhRM9qH4=;
        b=T8QOm8W2wVkdLLmQY7yv25dZgMGYfgS1+b8+xgWtme/dRHNLgxVRsF5BoujVeuOjnT
         4qJaHAd1YtsUekeLB2KIeLCesKgdChbqn9CQyEhuBKBJfKi4ogBEA3bHSojuCz0Thsuz
         AwBnyM1x8HHFuQSFp4f4YdqwvoQtQwtx4/fy32RG3sN2m9tbE3s4dhJYpXMXGYmyVoJy
         h99jq956wjHBc/3CBusnEpwZgoNoINCmgA3CBDb9B4eBxXVMuKr3HKJDFjIO8rl+WlAk
         xBp4rHb0mwLG4oKTaNFg5vHPk3lcuA0KQ3MbzsXimU0ifhswYo/JETqkd8iG/vE4Cmh/
         /sig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TeqXChMaxp2FFG+ite1K7DDloC4o+My78G8xhRM9qH4=;
        b=mQ4O63oK/tlnexSOZD/RizLwboRwrd22fDUH0hqV7HngWan1bzx1mGudHRb31eNeyG
         JU5CKiFU0rKoQoGBzvg75/f9VYaiBj16QokmzQ6/9aDMB/ppI72MRYFY0m4mmwZh6rcU
         GI/yNpmcrB88FRh3Rfb2DGtivDzwV6MOMp4vllRXi+KoNNCaqdT9KXdOpBNos6aNpdNN
         6AkskP3nPYeJ4SlsxN3THQv817wcWKJ0au+7bQ8z5tBWL4Hj5KDvsnfZ0niAjJBEgdnO
         QSpWyKLLyItgrv2OFUi+1XkedWtBljvmpQg+Nbqe7yEy+lUmI0a1EpluGTmgMDjdx9u6
         yaIA==
X-Gm-Message-State: AOAM531EDdGDJT3Fdl15o0eeaX5h4/Xau9UKg4dEvRe7t6oSuJVrl7gk
        AfLbU9vXM/RokqkdmomghrUjeXDzXVq6wQ==
X-Google-Smtp-Source: ABdhPJzjLsTDvOr6hq7Oz5qF/oisT97mQYVikEn3Zp2BLa5fhJYihJXYpU6R9ZQOsgTaCmBT8XEsRQ==
X-Received: by 2002:a17:907:6ea1:: with SMTP id sh33mr2592647ejc.131.1640280353017;
        Thu, 23 Dec 2021 09:25:53 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-008-107-221.77.8.pool.telefonica.de. [77.8.107.221])
        by smtp.gmail.com with ESMTPSA id qp24sm1901062ejb.84.2021.12.23.09.25.52
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 09:25:52 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: check for valid sensitivity before lookup
Date:   Thu, 23 Dec 2021 18:25:04 +0100
Message-Id: <20211223172504.56610-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Check the sensitivity is valid and thus the lookup in the name array
`p_sens_val_to_name` is valid.

Found by oss-fuzz (#42729, #42730, #42741)

    ==54784==The signal is caused by a READ memory access.
        #0 0x5a10f3 in mls_semantic_level_expand ./selinux/libsepol/src/expand.c:934:11
        #1 0x53839e in policydb_user_cache ./selinux/libsepol/src/policydb.c:972:7
        #2 0x5c6325 in hashtab_map ./selinux/libsepol/src/hashtab.c:236:10
        #3 0x5392e9 in policydb_index_others ./selinux/libsepol/src/policydb.c:1274:6
        #4 0x53f90a in policydb_read ./selinux/libsepol/src/policydb.c:4496:6
        #5 0x50c679 in LLVMFuzzerTestOneInput ./selinux/libsepol/fuzz/binpolicy-fuzzer.c:35:6
        #6 0x4409e3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) (./selinux/out/binpolicy-fuzzer+0x4409e3)
        #7 0x4295bf in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) (./selinux/out/binpolicy-fuzzer+0x4295bf)
        #8 0x42f850 in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) (./selinux/out/binpolicy-fuzzer+0x42f850)
        #9 0x45b6d2 in main (./selinux/out/binpolicy-fuzzer+0x45b6d2)
        #10 0x7f059fcd71c9 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
        #11 0x7f059fcd7277 in __libc_start_main csu/../csu/libc-start.c:409:3
        #12 0x423900 in _start (./out/binpolicy-fuzzer+0x423900)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/expand.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 8a7259a0..db43d860 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -929,6 +929,10 @@ int mls_semantic_level_expand(mls_semantic_level_t * sl, mls_level_t * l,
 	if (!sl->sens)
 		return 0;
 
+	/* Invalid sensitivity */
+	if (sl->sens > p->p_levels.nprim)
+		return -1;
+
 	l->sens = sl->sens;
 	levdatum = (level_datum_t *) hashtab_search(p->p_levels.table,
 						    p->p_sens_val_to_name[l->sens - 1]);
-- 
2.34.1

