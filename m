Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A437FC43217
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB8160E8B
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhJKQ2k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbhJKQ2h (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:37 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C9EC06161C
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:37 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w14so18198022edv.11
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yc2fx4Ap1/tkoI87XprMV0RFXJcki7CxCBRfYmH7xak=;
        b=BDzfXNdhgKi3hE/2dwENWzDwZ9SaN+qE9TfOv1nPpvVLVctM+zGn73GPwxQnP7XpFg
         sH3EJnQE+MmnYXtPQDoN8C7jgxqdTIRz01foEhVuFqGbG7fDmCwxhFahLQt05RRW9Txq
         /4n63HcdBMe9Wgad9EiTpa2HsYoT88bPugKSYPQpH44OF090RVj7yl2YusVk5NpCN50H
         HL6Eqi/AzPU9OIWWMM80FKGNBiSAnQ2BD12Gy/c0ZVwqMN3lldGdMEaySKgy80+jEZqW
         STSt3hQpXzvlNEcDhRpOo2rJw7aKc/1cUqHPjYmR3ineQJRR5reaS/w/nSaZ1QKvX+vc
         4sZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yc2fx4Ap1/tkoI87XprMV0RFXJcki7CxCBRfYmH7xak=;
        b=dqFEd5vBsXfDqLmxvn0+GW+yC86/p2CzQyKhU4fV7bcgoz5xAbHYoBZXa1qukZSebx
         EXnsSqHS9J60YxeQmVB30GQeWCXVS5HTCQMFkG01EatNh0Evw4YTsnCCBaECWXqgjvof
         LNRblqv8+47lIVvdN/DfSD9hIKdSaYLXJ9K0eLDllw35IJ+fAZMdovQBgtUq1XhZsD6o
         lHKEUTmZ1rfTQ9vruDv1I1Gadete/8Gl05Cww7rr3NhdRi40tZPTY86I5Ul5Scv9iyVn
         6hfnSzWbkCa7jDEXo/rfn9J3SUT/7ekwxkcE2yMjUKL3cED7M93ATE86ijU7+N1hfqX4
         ZsKw==
X-Gm-Message-State: AOAM533gsNhQcVVmFnMOjbnYGmwvPqCFdlYVHpD2DfVg73JxYD8jqCCJ
        fClaOES4YKX6Jq2ZyoGEKCEpiY7QHCQ=
X-Google-Smtp-Source: ABdhPJyppy9KTgAkOAm3p0Vgh1X8r5Iwn4N1XemPY+5uOHPjDexzx/t/JOXEuWajMPHU6uJLXyTxow==
X-Received: by 2002:a17:906:9a07:: with SMTP id ai7mr26859532ejc.55.1633969595726;
        Mon, 11 Oct 2021 09:26:35 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.35
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:35 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 27/35] libsepol: validate type of avtab type rules
Date:   Mon, 11 Oct 2021 18:25:25 +0200
Message-Id: <20211011162533.53404-28-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
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
 libsepol/src/policydb_validate.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index f0456583..9134e541 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -505,15 +505,22 @@ bad:
 	return -1;
 }
 
-static int validate_avtab_key_wrapper(avtab_key_t *k,  __attribute__ ((unused)) avtab_datum_t *d, void *args)
+static int validate_avtab(avtab_key_t *k, avtab_datum_t *d, void *args)
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
 
-static int validate_avtab(sepol_handle_t *handle, avtab_t *avtab, validate_t flavors[])
+static int validate_avtabs(sepol_handle_t *handle, avtab_t *avtab, validate_t flavors[])
 {
-	if (avtab_map(avtab, validate_avtab_key_wrapper, flavors)) {
+	if (avtab_map(avtab, validate_avtab, flavors)) {
 		ERR(handle, "Invalid avtab");
 		return -1;
 	}
@@ -845,7 +852,7 @@ int validate_policydb(sepol_handle_t *handle, policydb_t *p)
 		goto bad;
 
 	if (p->policy_type == POLICY_KERN) {
-		if (validate_avtab(handle, &p->te_avtab, flavors))
+		if (validate_avtabs(handle, &p->te_avtab, flavors))
 			goto bad;
 		if (p->policyvers >= POLICYDB_VERSION_BOOL)
 			if (validate_cond_list(handle, p->cond_list, flavors))
-- 
2.33.0

