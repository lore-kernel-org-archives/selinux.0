Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E690FC433EF
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D319860E8B
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbhJKQ2l (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhJKQ2i (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:38 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF82C061749
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:37 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g10so69242854edj.1
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kEBfmT9jgU+Aqy1jYOZ17mJBPMg0AKJ6tM/dwyfLLyg=;
        b=jmuTyZToOSdlzcbvhuN8asqNffRdy7faocnYDluR745g2F/Wti18iIjghmkIjBk/r1
         oXoCm7/e/67KRKxBk3fSeKC/YvdrImYQn9qHJkuhxEbCNWaJZiOKkmWkrOq4RF5PVSic
         1IR5pTGcvOxS4NcHTzwUGzBF/j05QOUAQ3dlGnxuBuYM/dZI7S/xZDBKSmbqQ1ETerfd
         mq9tJw7X3107WQkKSQNsHgpL9/U9PokxfNp9pqEC3fkIzv7mP3ZKDETLuEfaYCcVeC+N
         tQU83Z7gIsoQ8Icq9cyCrwiY3dAtsMBaxd1XFdwM7KsKHaORf2rsE37Mv2XslMKTh8Gj
         Vj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kEBfmT9jgU+Aqy1jYOZ17mJBPMg0AKJ6tM/dwyfLLyg=;
        b=UMb1D+umHuglQSL4abKaNj06bBbpI8xWX4y1O/udFVhiRLA2RAS1MyIvd9qnZAcLq0
         lB7MT2Yg0NH9nqpbeXImUx7CnOGlCzoi4Ka/v9uyb8If+Rw+uial76LmGnZmY7/RcTu+
         nPNvTVYWGgD668XocwIIKZIxTYNyuGcVI1TaqM1UPPewgsHCxXv7onZsYTmW1U8yb/bS
         efE9LwPFrf6LB9iiu2yrKVTWFb8rh/tnmu2Zuuur9FQMYUWjOrv2fG7gJ3ZsI6HJmWqn
         ahWKRA6gRsrbRMsSqCHN5JvZnyGxZtrqB8yo05lpsizfq+Zyu25VNDb+434n/hEYKuMV
         pC9g==
X-Gm-Message-State: AOAM532rGpGbcn5LcVUe/dcX2lvuiGpj4WkEaO6kpp7tULSPotqFu91r
        Cwq3MEz3LHEDOO7PzNY3T2PGEnn5lJ4=
X-Google-Smtp-Source: ABdhPJwDXTKOzum+EPBaYjDXu7lj73TXxuIGBAOC4Bol/XnNeS/g3JeUlzHedMvMNbgfB3lPVfEPhg==
X-Received: by 2002:a50:d4cd:: with SMTP id e13mr42108470edj.29.1633969596224;
        Mon, 11 Oct 2021 09:26:36 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.35
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:35 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 28/35] libsepol: validate ocontexts
Date:   Mon, 11 Oct 2021 18:25:26 +0200
Message-Id: <20211011162533.53404-29-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

    ==91274==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000000 (pc 0x7f60b0afe8c6 bp 0x7ffd42edc990 sp 0x7ffd42edc148 T0)
    ==91274==The signal is caused by a READ memory access.
    ==91274==Hint: address points to the zero page.
        #0 0x7f60b0afe8c6  string/../sysdeps/x86_64/multiarch/../strlen.S:120
        #1 0x4bd128 in __interceptor_strlen (./out/binpolicy-fuzzer+0x4bd128)
        #2 0x5eb387 in create_str_helper ./libsepol/src/kernel_to_common.c:69:10
        #3 0x5eb11e in create_str ./libsepol/src/kernel_to_common.c:99:8
        #4 0x56ad7b in context_to_str ./libsepol/src/kernel_to_conf.c:2408:9
        #5 0x56a717 in write_sid_context_rules_to_conf ./libsepol/src/kernel_to_conf.c:2441:9
        #6 0x55b26c in write_selinux_isid_rules_to_conf ./libsepol/src/kernel_to_conf.c:2476:9
        #7 0x55b26c in sepol_kernel_policydb_to_conf ./libsepol/src/kernel_to_conf.c:3206:8
        #8 0x55a34f in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:38:9
        #9 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #10 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #11 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #12 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
        #13 0x7f60b0a887ec in __libc_start_main csu/../csu/libc-start.c:332:16
        #14 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 37 ++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 9134e541..5c06e6f4 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -677,6 +677,41 @@ static int validate_filename_trans_hashtab(sepol_handle_t *handle, hashtab_t fil
 	return 0;
 }
 
+static int validate_context(context_struct_t *con, validate_t flavors[], int mls)
+{
+	if (validate_value(con->user, &flavors[SYM_USERS]))
+		return -1;
+	if (validate_value(con->role, &flavors[SYM_ROLES]))
+		return -1;
+	if (validate_value(con->type, &flavors[SYM_TYPES]))
+		return -1;
+	if (mls && validate_mls_range(&con->range, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
+		return -1;
+
+	return 0;
+}
+
+static int validate_ocontexts(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
+{
+	ocontext_t *octx;
+	unsigned int i;
+
+	for (i = 0; i < OCON_NUM; i++) {
+		for (octx = p->ocontexts[i]; octx; octx = octx->next) {
+			if (validate_context(&octx->context[0], flavors, p->mls))
+				goto bad;
+			if ((i == OCON_FS || i == OCON_NETIF) && validate_context(&octx->context[1], flavors, p->mls))
+				goto bad;
+		}
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid ocontext");
+	return -1;
+}
+
 /*
  * Functions to validate a module policydb
  */
@@ -861,6 +896,8 @@ int validate_policydb(sepol_handle_t *handle, policydb_t *p)
 			goto bad;
 		if (validate_role_allows(handle, p->role_allow, flavors))
 			goto bad;
+		if (validate_ocontexts(handle, p, flavors))
+			goto bad;
 		if (p->policyvers >= POLICYDB_VERSION_FILENAME_TRANS)
 			if (validate_filename_trans_hashtab(handle, p->filename_trans, flavors))
 				goto bad;
-- 
2.33.0

