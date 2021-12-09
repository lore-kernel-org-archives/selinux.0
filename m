Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6F4C433F5
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbhLIQ4J (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbhLIQ4I (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:56:08 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EF3C061746
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:52:35 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x10so4329730edd.5
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=stlmMJjvrHtRCJHdiaX1ZFWmS16FpcvY39FPSNHD4TY=;
        b=AJvS6XO0QKIKptfitTwnk2K9xK3Qf2V1TkjU3MFlAHQJ8Z9Q1lLzmYRj6eR7DiTR+7
         wysMCKP8cFLurkXYiCGt6kOPAfoKiApelyWwo0v9jU+YcnqsJ2XuldOK9CQJ7SQv2NGj
         RCFUWpoCtnWUFGDe0scTA37rHkZRtyPIwIbV3fXT0iLuvt0maUMBTF7XwzgcgvBKnWRX
         vXcH+ylZ2uAtf0sQqyPRM4UMc2Ru0KjQuwwJmvpCJZvAVyfOhdlPQD3Y2mMI1cA2YDwA
         /8gBuzOHzK6QyDKbemuR5s8EJ/C7T1D33NhKFhNNueR7ZNcg1gVZFyUPVCM1+xZcTO3s
         Q+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=stlmMJjvrHtRCJHdiaX1ZFWmS16FpcvY39FPSNHD4TY=;
        b=lJT2rlXuWhvyF1BzeIdbYuQ2FX/z+ML05vQTJ82mkRIbrpfs1RC006+M7rUJkYvLDs
         HoGengzKTZ0p1fWTigRuhRItlTY3oj+Dflax/3aQzSIVa1fl0hQjIiEuC5VafE9K1T6k
         //zYGoIQ+HaiPJRVXNchC30g95yULMjKZBTPNnzZ365MXCz0yW4S8SReqIXGIZDu1lF7
         r9NtB7sdN3PpmoCkM0raPj5WhKe/RYW3XecrA1f5cmJ3se9Yl+XGaq1hE+jWvTN6lhqP
         B8YSnpiT3hplRedLGHmIVE6YQwADKfIpZ+hdKTPv/5YMtJP3Un2BSbXIwDQCArPOo4Ot
         rTDg==
X-Gm-Message-State: AOAM532LVW7kjTwoRaXYJpjck1Fcejv6ox/clnrFmfJ26Lj9SwOVoOdc
        J/Ssx7UQzjbmbWBrLcSIic2iteEBq18=
X-Google-Smtp-Source: ABdhPJwCw4tQn6X/c6rHxnNwgY0/2WHbcOTW8XF9oPiQwBoE6SUv6dKxQKjONKdg1weFNhLPaBRznw==
X-Received: by 2002:a05:6402:d73:: with SMTP id ec51mr30284274edb.175.1639068591408;
        Thu, 09 Dec 2021 08:49:51 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:51 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 24/36] libsepol: validate expanded user range and level
Date:   Thu,  9 Dec 2021 17:49:16 +0100
Message-Id: <20211209164928.87459-25-cgzones@googlemail.com>
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

Check those contains valid values.

    ==57532==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x603000001178 at pc 0x000000564c04 bp 0x7ffed7a5ad90 sp 0x7ffed7a5ad88
    READ of size 8 at 0x603000001178 thread T0
        #0 0x564c03 in level_to_str ./libsepol/src/kernel_to_conf.c:1901:19
        #1 0x564c03 in range_to_str ./libsepol/src/kernel_to_conf.c:1926:9
        #2 0x564c03 in write_user_decl_rules_to_conf ./libsepol/src/kernel_to_conf.c:2367:12
        #3 0x55b137 in sepol_kernel_policydb_to_conf ./libsepol/src/kernel_to_conf.c:3184:7
        #4 0x55a34f in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:38:9
        #5 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #6 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #7 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #8 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
        #9 0x7f2c2e1a77ec in __libc_start_main csu/../csu/libc-start.c:332:16
        #10 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 03ab4445..adaa3fb2 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -340,7 +340,20 @@ static int validate_level_datum(__attribute__ ((unused)) hashtab_key_t k, hashta
 	return validate_mls_level(level->level, &flavors[SYM_LEVELS], &flavors[SYM_CATS]);
 }
 
-static int validate_user_datum(sepol_handle_t *handle, user_datum_t *user, validate_t flavors[])
+static int validate_mls_range(mls_range_t *range, validate_t *sens, validate_t *cats)
+{
+	if (validate_mls_level(&range->level[0], sens, cats))
+		goto bad;
+	if (validate_mls_level(&range->level[1], sens, cats))
+		goto bad;
+
+	return 0;
+
+	bad:
+	return -1;
+}
+
+static int validate_user_datum(sepol_handle_t *handle, user_datum_t *user, validate_t flavors[], int mls)
 {
 	if (validate_value(user->s.value, &flavors[SYM_USERS]))
 		goto bad;
@@ -350,6 +363,10 @@ static int validate_user_datum(sepol_handle_t *handle, user_datum_t *user, valid
 		goto bad;
 	if (validate_mls_semantic_level(&user->dfltlevel, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
 		goto bad;
+	if (mls && validate_mls_range(&user->exp_range, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
+		goto bad;
+	if (mls && validate_mls_level(&user->exp_dfltlevel, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
+		goto bad;
 	if (user->bounds && validate_value(user->bounds, &flavors[SYM_USERS]))
 		goto bad;
 
@@ -364,7 +381,7 @@ static int validate_user_datum_wrapper(__attribute__((unused)) hashtab_key_t k,
 {
 	map_arg_t *margs = args;
 
-	return validate_user_datum(margs->handle, d, margs->flavors);
+	return validate_user_datum(margs->handle, d, margs->flavors, margs->mls);
 }
 
 static int validate_datum_array_gaps(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
-- 
2.34.1

