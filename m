Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C81FC43217
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8767760EE5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhJKQ2i (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbhJKQ2e (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:34 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141D7C061745
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:34 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r18so70104662edv.12
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=va5+10Ouy3lto9yBcETjc5kuae+zwr1wmlUfqCuLosA=;
        b=O6Dbj9NPRyjY802AfOVwuieFJvv6rosufoQoLlHs1/XSSy2bLNQ8aqxa2NOOg3oL4b
         EzPFY1sjLPSW73ip+UILO6uRU4GyII576w8mgVWWdJaxsKgYAcvViUyh/6QjFviE/GbT
         7u/5MZaKMghHVwezUmHrhFiXnMgZ743HGXqNYFosbOxDZK0TJIogc8SX6ToNm8GOta8H
         YwO0BNb6AT3UkgmCN8KFC3HJoVXUxJgmFLg7OB1zvnkVBg9QhVlyibWKMfBvetUXeWBn
         SblFW9p+Y/NFCmSPw9m7W+n1B6jE3Ta1UCEm/5Qh9vVlsTBpLjFE53iMeKVKppY1OdE0
         lKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=va5+10Ouy3lto9yBcETjc5kuae+zwr1wmlUfqCuLosA=;
        b=plRu+r0FfHtk5v+cszE60sBdJ47HOeyHRQY+17SFDUNjVRgnwhzcknWg/1r5kTFuk4
         Us16lcTQWlLy3MXumAQQ/VxvVXi3jPfoB/LM5eQ9y6HA4pvPpRinXYkD+T2V6mcsNVvs
         6jAhXhjBiqxgN/6Izp91w+AYiqAzG7nEKmdAbJc5Eb5NyvOolgHMvigj2yQO+v4Y/f4F
         xr8oVzb8vtwwHmQL5VrxduZiYsr74/z3/aRl46gXynJJyBNy+ElYURx5hsDfnnUsqlGs
         cyqLwvlXTcJDAdf/GG8VqH9rQtIw0fX+9nJjSODJTai0cLilI/Acn1QsCcASQEADtUsu
         /3Sw==
X-Gm-Message-State: AOAM533Ln3HFR0lEFkby+s5dTI/Bjqu3eA1e/ML0tZjF7xSlOcjoJC/F
        iV0vHTR/74rEoay36khiapoay4cqB2o=
X-Google-Smtp-Source: ABdhPJym1wNyvVRO7aF7RUCkdU07h3AvFeBwQ6NBRF9ARaUmq5y8B6T2HjSLhSwIL8H3NlQpYp8Bdg==
X-Received: by 2002:a17:907:3352:: with SMTP id yr18mr26401824ejb.32.1633969592549;
        Mon, 11 Oct 2021 09:26:32 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.32
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:32 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 21/35] libsepol: do not crash on user gaps
Date:   Mon, 11 Oct 2021 18:25:19 +0200
Message-Id: <20211011162533.53404-22-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Handle gaps in the user table while printing a policy configuration.

    ==24424==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000000 (pc 0x0000004bdc55 bp 0x7ffc8790b810 sp 0x7ffc8790afb0 T0)
    ==24424==The signal is caused by a READ memory access.
    ==24424==Hint: address points to the zero page.
        #0 0x4bdc55 in __interceptor_strcmp (./out/binpolicy-fuzzer+0x4bdc55)
        #1 0x5ebdf6 in strs_cmp ./libsepol/src/kernel_to_common.c:253:9
        #2 0x505669 in __interceptor_qsort (./out/binpolicy-fuzzer+0x505669)
        #3 0x5ebd84 in strs_sort ./libsepol/src/kernel_to_common.c:261:2
        #4 0x564550 in write_user_decl_rules_to_conf ./libsepol/src/kernel_to_conf.c:2333:2
        #5 0x55b137 in sepol_kernel_policydb_to_conf ./libsepol/src/kernel_to_conf.c:3190:7
        #6 0x55a34f in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:38:9
        #7 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #8 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #9 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #10 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
        #11 0x7f530128d7ec in __libc_start_main csu/../csu/libc-start.c:332:16
        #12 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_cil.c  | 1 +
 libsepol/src/kernel_to_conf.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index bb167647..d9dc3f73 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -2392,6 +2392,7 @@ static int write_user_decl_rules_to_cil(FILE *out, struct policydb *pdb)
 	}
 
 	for (i=0; i < pdb->p_users.nprim; i++) {
+		if (!pdb->p_user_val_to_name[i]) continue;
 		rc = strs_add(strs, pdb->p_user_val_to_name[i]);
 		if (rc != 0) {
 			goto exit;
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index b2a42606..68dd2d32 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -2324,6 +2324,7 @@ static int write_user_decl_rules_to_conf(FILE *out, struct policydb *pdb)
 	}
 
 	for (i=0; i < pdb->p_users.nprim; i++) {
+		if (!pdb->p_user_val_to_name[i]) continue;
 		rc = strs_add(strs, pdb->p_user_val_to_name[i]);
 		if (rc != 0) {
 			goto exit;
-- 
2.33.0

