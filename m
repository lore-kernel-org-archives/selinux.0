Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C5CC433EF
	for <selinux@archiver.kernel.org>; Mon, 31 Jan 2022 10:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239567AbiAaK4z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Jan 2022 05:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239344AbiAaK4y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Jan 2022 05:56:54 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B0EC061714
        for <selinux@vger.kernel.org>; Mon, 31 Jan 2022 02:56:54 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id p12so25973668edq.9
        for <selinux@vger.kernel.org>; Mon, 31 Jan 2022 02:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uQJNbGwsQ4KY4NX6IrYpU2I5oDgXwHU37Wewcrz4mWE=;
        b=oucdsO2bOd8+8SHD21Em+CEtqTvuABmz0QVfbXPM6s+Jcem6xqo1MK+L4MMu5qMUsI
         yN3onEhf72OmIO2QoTPD/DsJ4vnqp3rjaUMCGVpkGv+D8b0YdemxrEbIWWNLpv0soym/
         e2RkNZRdkZOTcJp4rO0/Y9BTx9XhRM5ZZkaIXx0EtnUH8mxw2lvADL3Sq7US7dpwlGkU
         m2HNM4qfozmrA2qyhyICRIJnB3LjcVdGe4aKSOefA7IFH8GCA5RU9wj+TrJbL6ATRaQc
         Ufm+gkXIOrzc/v1JOHLVqLBCC0+lF/m26JuvnDNDvlwAfQEqj4miBhdLqQhhx80eA/IA
         u4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uQJNbGwsQ4KY4NX6IrYpU2I5oDgXwHU37Wewcrz4mWE=;
        b=2QMjsVwUYa3zCy5CkXRcDlEEftEfSnOLq+u+1S/51lN73xpRJQbR2cR9cPKDIGDQ5F
         yE4BQ3HCM1tGA3iEcIfVqHIoFBC6scApHtxsawbJtWkDwCCSL1cGYn9xSp5vlaNMvZjh
         x6ufr1kf49xlTsRbiknlriGg5u5cRx4p/ttB3wTqFDMQ8s/DSJL1NhtNAFMWaWAIGHLY
         /fPch6FrQKZTqDeW0k/n1Xhy9POpwZzp1Pl/IH0yefSwl7KnzK6aczPBnHy1Bg88xPji
         RaQpXhA+uEDevZ1Z+vVNZkdAXC3h1ig+zyrGuxivRGOXC3VcE1h/R1u2GwHNfFpG+aZ7
         eTiA==
X-Gm-Message-State: AOAM5316zS/3lKkGcEOAAJEhPYDb6FA6xd8S2vRd68TQDEHfIy2E4Zrg
        bL+kXI+bVAMBPrD0POfzUJxj+s7g/PA=
X-Google-Smtp-Source: ABdhPJwF17Jc9113VVWy0EXvEEX3TwZiVWkmWH4opXInLT5Lea7YsxmyYJmzNTKXAl4Uih8Ji3YVig==
X-Received: by 2002:a05:6402:1356:: with SMTP id y22mr20140809edw.50.1643626613075;
        Mon, 31 Jan 2022 02:56:53 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-124-082.77.3.pool.telefonica.de. [77.3.124.82])
        by smtp.gmail.com with ESMTPSA id fv33sm4137115ejc.207.2022.01.31.02.56.52
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 02:56:52 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: do not add gaps to string list
Date:   Mon, 31 Jan 2022 11:56:08 +0100
Message-Id: <20220131105608.31380-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When converting an ebitmap into a string list, skip potential gaps in
ebitmap_to_strs(). All converting functions like strs_to_str(),
strs_write_each() and strs_write_each_indented() do already skip NULL
elements, but sorting such a list will lead to a NULL dereference.

    #0 0x432ce5 in strcmp /src/llvm-project/compiler-rt/lib/sanitizer_common/sanitizer_common_interceptors.inc:462:25
    #1 0x4f4893 in strs_cmp selinux/libsepol/src/kernel_to_common.c:258:9
    #2 0x47b74b in qsort_r /src/llvm-project/compiler-rt/lib/sanitizer_common/sanitizer_common_interceptors.inc:9994:7
    #3 0x4f481d in strs_sort selinux/libsepol/src/kernel_to_common.c:266:2
    #4 0x4fe781 in attrmap_to_str selinux/libsepol/src/kernel_to_conf.c:1560:2
    #5 0x4fe781 in write_type_attribute_sets_to_conf selinux/libsepol/src/kernel_to_conf.c:1599:11
    #6 0x4f8098 in sepol_kernel_policydb_to_conf selinux/libsepol/src/kernel_to_conf.c:3182:7
    #7 0x4e0277 in LLVMFuzzerTestOneInput selinux/libsepol/fuzz/binpolicy-fuzzer.c:50:9
    #8 0x4d613b in main
    #9 0x7fa2d50260b2 in __libc_start_main /build/glibc-eX1tMB/glibc-2.31/csu/libc-start.c:308:16
    #10 0x41d4ed in _start

Found by oss-fuzz (#44170)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index 9f5400c9..dc9e689e 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -366,6 +366,9 @@ int ebitmap_to_strs(struct ebitmap *map, struct strs *strs, char **val_to_name)
 	int rc;
 
 	ebitmap_for_each_positive_bit(map, node, i) {
+		if (!val_to_name[i])
+			continue;
+
 		rc = strs_add(strs, val_to_name[i]);
 		if (rc != 0) {
 			return -1;
-- 
2.34.1

