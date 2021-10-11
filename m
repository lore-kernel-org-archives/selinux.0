Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B4CC43219
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC68560E8B
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhJKQ2i (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbhJKQ2f (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:35 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B180C061570
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:34 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i20so53524654edj.10
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Dgevm551HvTqam31mONyJqFn16TI6hX8bq0US910bjE=;
        b=FI4RPZWhSuY2iYZkTzP6OVnOd8aMPrm7OpZGPy03dPbE3I/tNJI0bJZSleGTkJ3ah9
         SBhtOHMJT9z/712sEwlvt5Ejl9DN3rPrsvnJTO6/QsVpGUZKLeZbpZttnIGaXwKtFenR
         si5jUHIERnc1Eje0Zz04BCa85vWkuu8MDGMMr5bYu+MKcFaSd0+CPbwF+P8RZ05SDqCI
         NNcolxapw1cWmKueVAb4izp3CFV/eDIAdlHuredWF6RUS/qpGg1YyjGhnH6bEAJPqKjU
         R7pp3RYGBZpR75f3tbH6U7kpveBF7YYDbKHJFuuAiqigkstifD3YJuV3GscUb0i4fpe8
         1FWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dgevm551HvTqam31mONyJqFn16TI6hX8bq0US910bjE=;
        b=8KnPgw9CMzAD8pHnhal9mwE4crOipJq1fgPfNF9CBRTXP1kp5CYFflR93Djlz2eHs+
         FKbmpC3WjcVu8C2HwCXaOq+w7PF4CHSkssE9Rxzztt0xXZOSbAft8lrfXwsCwZihsIvy
         pUJtVe3XqnUKWlPJ869aW3sTSeym5T3xoZRZ/g1aSfcY0ulj/FGg/uo9d/rry40TMWqA
         X2eDV20MUkRvittxeKG3Lk+hrjt6hIRTZ5aPe8Z9eS9vdGpL95K66t3Kq1hGlsr79nWR
         kPucHf8heevj2AZI6OhkapkYiKrtJdpFwnT2kMS4b0oOgpyuzYCpQR+8FTzcNTZPrWFn
         3NRQ==
X-Gm-Message-State: AOAM5316wT4qzk2N2jjZ1YQw1OPFdkqGJAR5/M1tEG0zOmtXSi/GPks1
        JcMvHWrSMM6AB3czpl7JRBbMWFGJWyc=
X-Google-Smtp-Source: ABdhPJztMLIzUc0SjwtU/K1cw1s+Dv1dq4zPQi1XZzN8Z0ypOjItJ1Jwiw1BpxJBz0v6LwiD0MLtMw==
X-Received: by 2002:a17:906:d1d6:: with SMTP id bs22mr27042485ejb.554.1633969593101;
        Mon, 11 Oct 2021 09:26:33 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.32
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:32 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 22/35] libsepol: validate permission count of classes
Date:   Mon, 11 Oct 2021 18:25:20 +0200
Message-Id: <20211011162533.53404-23-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Check a class has not more than the supported 32 permissions.

    ==28413==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000000 (pc 0x7f74ec3341a3 bp 0x7ffd0b7e5030 sp 0x7ffd0b7e47e8 T0)
    ==28413==The signal is caused by a READ memory access.
    ==28413==Hint: address points to the zero page.
        #0 0x7f74ec3341a3  string/../sysdeps/x86_64/multiarch/../strchr.S:32
        #1 0x4bfc78 in strchr (./out/binpolicy-fuzzer+0x4bfc78)
        #2 0x55b7f2 in class_constraint_rules_to_strs ./libsepol/src/kernel_to_conf.c:288:7
        #3 0x55b7f2 in constraint_rules_to_strs ./libsepol/src/kernel_to_conf.c:364:9
        #4 0x55ac80 in sepol_kernel_policydb_to_conf ./libsepol/src/kernel_to_conf.c:3071:7
        #5 0x55a34f in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:38:9
        #6 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #7 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #8 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #9 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
        #10 0x7f74ec2be7ec in __libc_start_main csu/../csu/libc-start.c:332:16
        #11 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index c9700399..7ec0675c 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -203,6 +203,8 @@ static int validate_class_datum(sepol_handle_t *handle, class_datum_t *class, va
 		goto bad;
 	if (validate_constraint_nodes(handle, class->validatetrans, flavors))
 		goto bad;
+	if (class->permissions.nprim > PERM_SYMTAB_SIZE)
+		goto bad;
 
 	return 0;
 
-- 
2.33.0

