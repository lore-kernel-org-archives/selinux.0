Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50B8C433EF
	for <selinux@archiver.kernel.org>; Thu, 23 Dec 2021 18:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240310AbhLWSuN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Dec 2021 13:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbhLWSuN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Dec 2021 13:50:13 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00D6C061401
        for <selinux@vger.kernel.org>; Thu, 23 Dec 2021 10:50:12 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x15so24926930edv.1
        for <selinux@vger.kernel.org>; Thu, 23 Dec 2021 10:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nJrbKdWyRVDt9XY0bp0UKEvW3rHSlbhGumU90WlzwWI=;
        b=Di7KcHklwWsAMscHYX7P43KVuIQ/oxqsnd1MxuVhI3OF/ay/fU6X4zBf9jRfoRHKPE
         BVP7lUUb1HZ9CzFsa6vBYgw7MWBIDSaZr+HubUboC1rdWkrO4Rw/DMfnYT9H42RknrVS
         gzZSEqywvjcMNSUMRm0bLno+ugJRKRLOmBf1Tr8xZesh4QmQW5gEnDDUd2PebK+a03B5
         OxBq6YpcYcPx8+fHR1wh/v3/ShH3h5z3BckQfbVydm555GYAgaPUqG527oF9t7q/jWSD
         L2nlmtWslfz1iQloNyNf7gq9/FcLPxA2lnoT2rEvRBJibwCSYkdWCnX2DIlm2jxar2ff
         KCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nJrbKdWyRVDt9XY0bp0UKEvW3rHSlbhGumU90WlzwWI=;
        b=RNBgNmLItCFwjRpPHuvxkxQVPMsG1tV3y8X4lO0y0tV2aCiUnCkkjojZyyRPovVtSU
         zWGxKlYtF2YItzFoDcT2wqwK2IqwbrfprRHB/B4nBynb1GEhTPIvsZbjlYp932cxGwRJ
         VgU9weAyHUVLjv3zifd0xNGJKet8gDEh0Py33/YCI4cF6TEWpm42DwRIpGiU0SQeDr+7
         js6wkEiSFxxVZsSA5wzBsWQehuBS1r30kHm1gBpruw+Qc9H3HFho4tYhe24VYmxZYhZG
         Ge5YsqxiBAzmQVi2WlxECHY1oNcJV/7kGrumElg99ZYF9RRaA/I3BAwaa77EHF1Ewoc6
         vSBQ==
X-Gm-Message-State: AOAM532Nknj122mgblJqHuVW0Ul6Ny7XZGwf5h6roHy0fnOk7m9t/zA+
        l0uZeehZ6A9PS1BEMciSIPALBLvXQdxtrA==
X-Google-Smtp-Source: ABdhPJywIOmdg3fJLjajGLZ30jufprw8CjFeuqlOGaqxJYMLThJPFYK5JPjZ2wNBt/hY8sWAkhkotg==
X-Received: by 2002:a17:907:7f05:: with SMTP id qf5mr2860964ejc.597.1640285410559;
        Thu, 23 Dec 2021 10:50:10 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-008-107-221.77.8.pool.telefonica.de. [77.8.107.221])
        by smtp.gmail.com with ESMTPSA id p5sm1980328ejo.53.2021.12.23.10.50.09
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 10:50:10 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: handle type gaps when optimizing
Date:   Thu, 23 Dec 2021 19:50:04 +0100
Message-Id: <20211223185004.77862-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

For policy versions between 20 and 23 the type_val_to_struct array might
contain gaps. Skip those gaps to avoid NULL pointer dereferences:

    ==1250==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000008 (pc 0x00000058560b bp 0x7ffdca60c110 sp 0x7ffdca60bfc0 T0)
    ==1250==The signal is caused by a READ memory access.
    ==1250==Hint: address points to the zero page.
        #0 0x58560b in build_type_map selinux/libsepol/src/optimize.c:107:33
        #1 0x58560b in policydb_optimize selinux/libsepol/src/optimize.c:441:13
        #2 0x55e63e in LLVMFuzzerTestOneInput selinux/libsepol/fuzz/binpolicy-fuzzer.c:42:10
        #3 0x455283 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) cxa_noexception.cpp:0
        #4 0x440ec2 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerDriver.cpp:324:6
        #5 0x44671c in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) cxa_noexception.cpp:0
        #6 0x46f522 in main /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerMain.cpp:20:10
        #7 0x7f9c160d00b2 in __libc_start_main /build/glibc-eX1tMB/glibc-2.31/csu/libc-start.c:308:16
        #8 0x41f67d in _start

Found by oss-fuzz (#42697)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/optimize.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
index 8a048702..678d22bd 100644
--- a/libsepol/src/optimize.c
+++ b/libsepol/src/optimize.c
@@ -104,6 +104,10 @@ static struct type_vec *build_type_map(const policydb_t *p)
 		if (type_vec_init(&map[i]))
 			goto err;
 
+		/* Gap in types for policy versions between 20 and 23 */
+		if (!p->type_val_to_struct[i])
+			continue;
+
 		if (p->type_val_to_struct[i]->flavor != TYPE_ATTRIB) {
 			ebitmap_for_each_positive_bit(&p->type_attr_map[i],
 						      n, k) {
@@ -114,11 +118,17 @@ static struct type_vec *build_type_map(const policydb_t *p)
 			ebitmap_t *types_i = &p->attr_type_map[i];
 
 			for (k = 0; k < p->p_types.nprim; k++) {
-				ebitmap_t *types_k = &p->attr_type_map[k];
+				ebitmap_t *types_k;
+
+				/* Gap in types for policy versions between 20 and 23 */
+				if (!p->type_val_to_struct[k])
+					continue;
 
 				if (p->type_val_to_struct[k]->flavor != TYPE_ATTRIB)
 					continue;
 
+				types_k = &p->attr_type_map[k];
+
 				if (ebitmap_contains(types_k, types_i)) {
 					if (type_vec_append(&map[i], k))
 						goto err;
-- 
2.34.1

