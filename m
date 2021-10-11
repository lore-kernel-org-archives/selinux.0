Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423A1C433F5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F7F560EE5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhJKQ2n (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhJKQ2k (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:40 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9A1C061570
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:40 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g8so70007485edt.7
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AvGFnDSP4huMwwlGfEPMr9vrEcQGsJVBfOizJMkBNL8=;
        b=lvgexPQVhYJFZz8v1cU98hx3QELU264CMNVs0DTaQ1OXTGKzYCDqHDUDM2ow2FSQ0e
         hbtOYKNXaCm8LEFy+l/6PVZOam9pqYlF+hsr4MUE+cUjfWxBO+3jgkDxoP1uyQGPYfYK
         D8n4YrKVcXokwrI3SYZ5ZfgHnN0bk1XG/ebSiUtxYr9PZPGOvb581me0TX20kQRFwm0/
         lp4I4zi84QaSmaGaCeSQPfMQ54d1isciPdurK3/ab7TidTQ7yEXvduK5d4lNQBU4oMUq
         Tf6NBd8FyJR9FN8OYBpoDYG/sWkqEJNJCGRvw1cBEqmRe3CqFdPnOK64kj+TZIB/EEgW
         e9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AvGFnDSP4huMwwlGfEPMr9vrEcQGsJVBfOizJMkBNL8=;
        b=2suBCqou/pLGW5pw9A/Y8EXlPXbHQd/wBk62cTobubG/V26T1eAdHhvueKVYSBNJpX
         zMl8xP5/XlnJh//f0O4JDjcWSvvWjwCktIYZTVYZKlReCMQWkzypC60qxg1tum1AbKuC
         2hJjzC9ZCE2giw6l7UaIpDbBpd5TIwAL+kgCSOz1VJ9g3yoBRfUzMaVUbZq2Vz2Fcj/c
         PXKVuIKf9P36Gu/pswUwuuJsehpQFVgoZRj5TcGXmMZN3ckpcH9AdRabrvXdgR5Oskd8
         WHz+3zvHkcNY9xxljOSLMy+jKEAinQLBd1Nt3O7MpuOz0+5F0h4vdDBD0t1OluKOFXll
         hceQ==
X-Gm-Message-State: AOAM533B36FzjKpgPvqVGcLlXwZHYAvnQqbg2PCv1mgwcDHupfKyivwS
        KFWzmV+UYhdLkd8IsVbokkn1WbJzKGo=
X-Google-Smtp-Source: ABdhPJyZpbmRyEPldMfXOwwSbHiuttExoWXQJxvQwX38ehFr7gHUi9OJI079f+qZuHZcoHu6EtUbmw==
X-Received: by 2002:a05:6402:1b8a:: with SMTP id cc10mr42142798edb.313.1633969598775;
        Mon, 11 Oct 2021 09:26:38 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.38
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:38 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 33/35] libsepol: validate categories
Date:   Mon, 11 Oct 2021 18:25:31 +0200
Message-Id: <20211011162533.53404-34-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
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
 libsepol/src/policydb_validate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 860f9647..063bde18 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -465,6 +465,9 @@ static int validate_datum_arrays(sepol_handle_t *handle, policydb_t *p, validate
 	if (hashtab_map(p->p_levels.table, validate_level, flavors))
 		goto bad;
 
+	if (hashtab_map(p->p_cats.table, validate_datum, &flavors[SYM_CATS]))
+		goto bad;
+
 	return 0;
 
 bad:
-- 
2.33.0

