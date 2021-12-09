Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B983C433FE
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhLIQ40 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbhLIQ40 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:56:26 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B66C061746
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:52:52 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id t5so21315057edd.0
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=myk2fagbRYo56h35dbUdYxa5cd9Ca3ACjL3X2gVcXws=;
        b=RLjBy8IqDas2j41HKrTQ1dQStYw2m4VdgY6Tz2qsimhW5pZO3rD3rFm6vKaEIg1Fn+
         TYxakuoSEgPzKCZVxRfGi3FTrx9oRxxbsn2vfvP5OnYppn44PthtX0feuZftI0T12qu7
         Q1lxGyK7vNb4fY1WbCA65IZsvXc6oQqZt6LRVge+fiQ1boP3s8a9btDO9HfuycTBWRK9
         WipFb1fq2SFKurkxaYOgBSE8KVuPZ9hfpBrDjEt/DzlSkeA3wvRTdRe+RAYrM0gQUn6b
         ld+srAABwRWs9ccuwl8vqEebY0aLdas2pFxllLDztlG7ElFd/WPs3+sKmqqFcKbHBbuZ
         w4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=myk2fagbRYo56h35dbUdYxa5cd9Ca3ACjL3X2gVcXws=;
        b=sNZpj0jKSAZgIuKtvIbS4JS2E3WMBpN03GP/9LG/ZSUzuMIZ1ki2/76Lqtjl1z2cye
         jiUiOuYPAjlwnBIV5JOM5woYhFPAYN0A9wpXY3KrgYsjsDfFqakrFoTfrL6TDDRwiart
         NhWItAdre5+JUjXs1Ii4kB79yBbEfGx4xty1BuCkrUfJXwPRnAbFl5NsFkx0UJiQkijP
         8L9rvGvvzfcljgb/bgeEkbaSqo2LYe3BuKsp2ow+HyTq3rPTeZDGyQbRboMrgWp6R7Aj
         sofkI/jHa0PHKb88ZEj9B9fVMsaw4osOCsupUvFwILzJcwpOAOCu4MZ3w8ALkB291j8p
         paQw==
X-Gm-Message-State: AOAM5310AkJE0DaeeWbF4izZW1rPTe5vFSo95o3+Y1P9SrxWuL7uBnRR
        71mfoyohwXmxRnLxZWzmHss2rWoBKn8=
X-Google-Smtp-Source: ABdhPJyrurt4WbgY+BF4R3GCcogG6Z4GkgGfBeCOef9OWeLupuLGI7Hqo21xS+MKSCZWwF0V+ULucw==
X-Received: by 2002:a05:6402:1c01:: with SMTP id ck1mr30337669edb.262.1639068588134;
        Thu, 09 Dec 2021 08:49:48 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.47
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:47 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 19/36] libsepol: do not crash on user gaps
Date:   Thu,  9 Dec 2021 17:49:11 +0100
Message-Id: <20211209164928.87459-20-cgzones@googlemail.com>
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
index d9afdda6..26868f2d 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -2397,6 +2397,7 @@ static int write_user_decl_rules_to_cil(FILE *out, struct policydb *pdb)
 	}
 
 	for (i=0; i < pdb->p_users.nprim; i++) {
+		if (!pdb->p_user_val_to_name[i]) continue;
 		rc = strs_add(strs, pdb->p_user_val_to_name[i]);
 		if (rc != 0) {
 			goto exit;
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 92a342d1..b2ad4e02 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -2327,6 +2327,7 @@ static int write_user_decl_rules_to_conf(FILE *out, struct policydb *pdb)
 	}
 
 	for (i=0; i < pdb->p_users.nprim; i++) {
+		if (!pdb->p_user_val_to_name[i]) continue;
 		rc = strs_add(strs, pdb->p_user_val_to_name[i]);
 		if (rc != 0) {
 			goto exit;
-- 
2.34.1

