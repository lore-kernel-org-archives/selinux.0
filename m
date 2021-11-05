Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E26C433FE
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3889561108
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhKEPsj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhKEPsi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:38 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFB4C061714
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:45:58 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id f8so34736506edy.4
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tOFMTZkWBZlTL6IyBaOlzzb3l+DA5t3OGFP//B1ut3k=;
        b=T1YfnoLhERLEa7kq8s2xFCetLiO90abJr9sbTIDNsvmvqDteUGUkGdr6inPw0ByK3J
         DH7lGf5Q1MA3r0I2sqsfkitw0Q59g1UxfG8GG+rbP13509+CEEAtP4pmplX2ft7frXMG
         Ce0ZUb3aFuGjrapneJ0DTO6gJGEFf2MuNdrKKTp6Eop3F0tkOXdlMXahxFUKWcth2sg9
         jMLBVplBV7DelfNsYur3OOiKHlBGbcasJ8ZKH6utl5FXQ+ka5b1H4UuANtIFYyet2hKG
         XLML9CvT5uALFjzuTyE7xy88/WLO8LfZfiy3G9OdktgBByKALfzhLjX6vBr9SRucEytv
         lRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tOFMTZkWBZlTL6IyBaOlzzb3l+DA5t3OGFP//B1ut3k=;
        b=Vp3IR64fI6iv94DfX1svtZipKAQ/Up//v7qbjxoVXQhfuBizEtrGjTrITsnKgGvyrI
         uR3fB2/y+ELUA0ZePhtmI6aSrUsugDS8x+NdDgJq/bgsl6FgdkFq2Yz7YWvTbVmHZjre
         rNg3svg2Dh0nq5OUKqUis2ormJoMqRJpabVpw1hs9sUDw+kStuIDno7B3nUv63QKv2OY
         7cYCX5wAnfEqGAOXtk8Pn49UQk2dWx7j7oJpAzxgdwkQARJJKmgKQTT2RtRRiuKdUPZ2
         Nd8F56S+WvL26ErMUqbXLdxy4zeitjtHU+3ij/EsJpgS8CdxoMc+oHBVrcvsim+s84c4
         Q/FQ==
X-Gm-Message-State: AOAM533T5th9A+ruDMeAfMLv94HuG6RchEGt6+xwwJnSbgv+kHz1wC1Z
        wh6RRXxJ7kdNITzx9gZ/HQkcttEYh/E=
X-Google-Smtp-Source: ABdhPJxO/YjjhaMvORy+na5V72SH5N3CKxWpyHv9QhGQGQD7FifW4E7KQOOmBqImxH9e87KWQp1ZwA==
X-Received: by 2002:aa7:c34d:: with SMTP id j13mr65199052edr.308.1636127157173;
        Fri, 05 Nov 2021 08:45:57 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.45.56
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:45:56 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 19/36] libsepol: do not crash on user gaps
Date:   Fri,  5 Nov 2021 16:45:21 +0100
Message-Id: <20211105154542.38434-20-cgzones@googlemail.com>
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
2.33.1

