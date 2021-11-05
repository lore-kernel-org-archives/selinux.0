Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D02C4332F
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B4D61108
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbhKEPsh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbhKEPsg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:36 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F1DC061714
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:45:56 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id o8so34461776edc.3
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=im29GQAtjl6g06dN5pbm15MHMTbK+nnLnI9vapPf2vo=;
        b=JxyZLiNodR25Kf7knmmpKmBaAE/wFsW1NO2+lzZ/35htX2/6smuyM7GUE0GUQEWcaw
         HBw+oV7NxxHYMa/A8Hlz4HcST2FOpA/jJstycqYzbMn7khwpTHYkWUbA0ByuGIqoDqKo
         PumsljVhNpNbGwazRgtUEwLb87GAgE9GtgouQiZZqXrdWRFp8BBWk/X5SmVVAuAvKzf3
         E+Cx1GiVQ6B01RNnjvQt8c1nR7B1XlV7U+BJA6kIhwY/Ep1HEsNYhHjwS7nHix6SyJ2+
         qaP4DBSwOwB7FH54LaW4PfwZqTazmBl+R1Eh14MzGS7/OhURszpUwKCiTrZdbj7bTV6H
         /zwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=im29GQAtjl6g06dN5pbm15MHMTbK+nnLnI9vapPf2vo=;
        b=sr59IJmh7ltwf44OnnKbJKjTTX1h6CrEX6qrxcKiAunNbsqcG1PlANIdVj40NMmGSF
         bd4guw4yjEf8armwoJJ/TBeAvPK79qbWcO9DTgqvEUu4hW98DSS7OGH+3YcWgiKh64mO
         KM3jMOvZXeGIoyVHMhn4D/MMo+RtS49JVXejnLbInrxaSjXJA94iCqg/a4WA4LzDY8JV
         fHNEe1lPgf4JEbg+omOMwqpKAHGyJDXqq48pEhICojr9lgtEVe0bB9tnhihAOslCRVNU
         j1tlHxyErwAUCNHjylkgt3CinORIq2o/cDDe20nAOPE/hOUxEnP7Af6eYWU1QI9rO/7G
         +54A==
X-Gm-Message-State: AOAM532NE2OLfm7bJU3T6wfaKShGhyXg842QukSKINDzx2WKPr8wG9c+
        ntZGhYzncDG3qH9pXMWAUhS6thigKxo=
X-Google-Smtp-Source: ABdhPJyyy5sS5NElTQ7S2Cm4t90e5ulKAIKM1UoWmA9T2DleBbl7x/+U473AJdlXXeFjiQtFkhW3YQ==
X-Received: by 2002:a17:907:8a20:: with SMTP id sc32mr46672451ejc.65.1636127154831;
        Fri, 05 Nov 2021 08:45:54 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.45.54
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:45:54 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 15/36] libsepol: zero member before potential dereference
Date:   Fri,  5 Nov 2021 16:45:17 +0100
Message-Id: <20211105154542.38434-16-cgzones@googlemail.com>
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

The `next` member might be checked against NULL and dereferenced before
it gets assigned, due to jumps from failure gotos to the cleanup
section.

    ==31017==ERROR: AddressSanitizer: SEGV on unknown address (pc 0x000000579654 bp 0x7ffd3a07d110 sp 0x7ffd3a07d000 T0)
    ==31017==The signal is caused by a READ memory access.
    ==31017==Hint: this fault was caused by a dereference of a high value address (see register values below).  Disassemble the provided pc to learn which register was used.
        #0 0x579654 in filename_trans_read_one ./libsepol/src/policydb.c:2874:55
        #1 0x579654 in filename_trans_read ./libsepol/src/policydb.c:2902:9
        #2 0x5771b7 in policydb_read ./libsepol/src/policydb.c:4509:7
        #3 0x55a1f5 in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:24:6
        #4 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #5 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #6 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #7 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
        #8 0x7f2a4e7f97ec in __libc_start_main csu/../csu/libc-start.c:332:16
        #9 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index ab303ce6..c4dc3387 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2780,6 +2780,7 @@ static int filename_trans_read_one(policydb_t *p, struct policy_file *fp)
 		if (!datum)
 			goto err;
 
+		datum->next = NULL;
 		*dst = datum;
 
 		/* ebitmap_read() will at least init the bitmap */
@@ -2797,7 +2798,6 @@ static int filename_trans_read_one(policydb_t *p, struct policy_file *fp)
 
 		dst = &datum->next;
 	}
-	*dst = NULL;
 
 	if (ndatum > 1 && filename_trans_check_datum(first))
 		goto err;
-- 
2.33.1

