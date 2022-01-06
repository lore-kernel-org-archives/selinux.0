Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A598AC433F5
	for <selinux@archiver.kernel.org>; Thu,  6 Jan 2022 20:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243930AbiAFUnp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Jan 2022 15:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbiAFUno (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Jan 2022 15:43:44 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BE1C061245
        for <selinux@vger.kernel.org>; Thu,  6 Jan 2022 12:43:44 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id c71so2562565edf.6
        for <selinux@vger.kernel.org>; Thu, 06 Jan 2022 12:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cn1zolYGrxU+W8ptlqDLu36n2yg4Bhh8Gdzg4arv01Q=;
        b=qZP+q14dFwOxLkqaIlA/fpx27DzyVLEveXzLJpyO5+L8Rw+qZzUtcCS6/24NMSHElK
         NWrBBN4ZOSTkKqC5q9qe9eyDsn2nWVCMCDHePCJUS3vOdLRhcWQ0XIEFNMagTF9cvfPN
         GGiZW69aU+lYWOPWFo7YTdA4gfRxcImmYZSE+ghzot9x1DFFHo8Elf1YUc6SOyDaaVIN
         pjAT9yrVYKpfOigyxLIVcOHDKy8aCcSuxwIYuVORyscj8mBcO9ZQvHHXNF6i+mEM4p0v
         36o4OCa1N4x7PemQ1Y4i5j902ugKVkwvZ8aIF96JDGx/w07AfgWxReAIQo/MsnZRXgdo
         vX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cn1zolYGrxU+W8ptlqDLu36n2yg4Bhh8Gdzg4arv01Q=;
        b=z1ix75ih0VK2TISemK+/oZSiBExYcyjSp0FvH6TskMz8QGj/j6Rxl2Lh+ucdn5UkdI
         tFrYmD8nfWHSKeSnXpFwh4BWi5ELJZltnxLnyHRZP6v9w+2MNrcmybgbF0pmVXd3pqOM
         +XXkmjh5bISx5bghRWkkoMOKP5wb4y4XsAIDQ9ocJ/D3kqo6vvBWo2NWDu7lgEk2yp7O
         e4Rf2Md6G5jVYe83sCfpS8xh01nSvgGSpnfcwP6rRTnyuOxDzrCr8UpP35YxZJMdi1fd
         XBBN+v2v55w6LEg5vZf9e5/FFAkXFtZiwUFRAiifULSco4suJlcI6AKpOZTRsHW+UMae
         00OA==
X-Gm-Message-State: AOAM533/RCyZ/FW8Zg6zNqmgl6cscz5VaqcKCC5tJEy79ZkeLorfMuh2
        soA2bZ33eirAGaSxrz+40Pj23BCx3+M=
X-Google-Smtp-Source: ABdhPJyOwvXJqg25C3UbU1bvANM+ovuLKSSL1RPmgie2By9fyVNI6T/lmI5cbG2ULyGjJTuy1ZpgkQ==
X-Received: by 2002:a17:906:c111:: with SMTP id do17mr45589723ejc.270.1641501823145;
        Thu, 06 Jan 2022 12:43:43 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-001-024-211.77.1.pool.telefonica.de. [77.1.24.211])
        by smtp.gmail.com with ESMTPSA id c10sm772777ejm.118.2022.01.06.12.43.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 12:43:42 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: check for saturated class name length
Date:   Thu,  6 Jan 2022 21:43:36 +0100
Message-Id: <20220106204336.147180-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Check the from the polciy read length value to guard allocations.

In the fuzzer build the value will also be bounded to avoid oom reports.

    ==143646==ERROR: AddressSanitizer: allocator is out of memory trying to allocate 0xd60000000 bytes
        #0 0x4dac18 in __interceptor_calloc (./out/binpolicy-fuzzer+0x4dac18)
        #1 0x55d388 in scope_index_read ./libsepol/src/policydb.c:3945:7
        #2 0x550097 in avrule_decl_read ./libsepol/src/policydb.c:3984:6
        #3 0x550097 in avrule_block_read ./libsepol/src/policydb.c:4044:8
        #4 0x54b3ac in policydb_read ./libsepol/src/policydb.c:4456:7
        #5 0x518fd9 in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:35:6
        #6 0x43f623 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) (./out/binpolicy-fuzzer+0x43f623)
        #7 0x42910f in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) (./out/binpolicy-fuzzer+0x42910f)
        #8 0x42ee76 in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) (./out/binpolicy-fuzzer+0x42ee76)
        #9 0x458ff2 in main (./out/binpolicy-fuzzer+0x458ff2)
        #10 0x7fd37b7931c9 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16

Found by oss-fuzz (#42909)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 79aba3af..562e044e 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -3937,7 +3937,7 @@ static int scope_index_read(scope_index_t * scope_index,
 	if (rc < 0)
 		return -1;
 	scope_index->class_perms_len = le32_to_cpu(buf[0]);
-	if (scope_index->class_perms_len == 0) {
+	if (zero_or_saturated(scope_index->class_perms_len)) {
 		scope_index->class_perms_map = NULL;
 		return 0;
 	}
-- 
2.34.1

