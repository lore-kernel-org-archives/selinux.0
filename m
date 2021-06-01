Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDEAC47080
	for <selinux@archiver.kernel.org>; Tue,  1 Jun 2021 15:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D7EC60FF3
	for <selinux@archiver.kernel.org>; Tue,  1 Jun 2021 15:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbhFAPUs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Jun 2021 11:20:48 -0400
Received: from m12-12.163.com ([220.181.12.12]:42251 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234130AbhFAPUs (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 1 Jun 2021 11:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=zf8zf
        CBOvIxpgIaJQjG0wL59lqrv2OLMERFTLosB7BU=; b=k9bb5ym+CWbiPAcaHkiTb
        Lu/RnyKfRQVodhXfuaE+otZYCh0q6/O8TFMVhNZWIBqzpJpMdrDme4Cp3VyYSXJR
        Yw4yKfaAs5d3k2M6djlJCHq5DTfYljYM2qrOmZsSH5XUJkSqf/7TylTFn0LtYAXc
        YZvOOmW+E3Q2h2MqdUMiYw=
Received: from localhost.localdomain (unknown [106.120.30.49])
        by smtp8 (Coremail) with SMTP id DMCowACXWTLRT7ZgzxnxHQ--.7891S4;
        Tue, 01 Jun 2021 23:18:54 +0800 (CST)
From:   liwugang <liwugang@163.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, cgzones@googlemail.com,
        liwugang <liwugang@163.com>
Subject: [PATCH v2] checkpolicy: fix the leak memory when uses xperms
Date:   Tue,  1 Jun 2021 23:17:05 +0800
Message-Id: <20210601151704.2688389-1-liwugang@163.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87o8crcljy.fsf@redhat.com>
References: <87o8crcljy.fsf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowACXWTLRT7ZgzxnxHQ--.7891S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFy3Kw48Jw13KF1UurWDCFg_yoW5Kry7pr
        srGrZ7AryUWrWfXrn7Ww4jvrySg3yqkw48WryxAa17AFy8Zw18Wa98Ar1YyF4rWFn5Aa9a
        yFn8Xa1UWaykJFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U1rWwUUUUU=
X-Originating-IP: [106.120.30.49]
X-CM-SenderInfo: 5olz3wxdqjqiywtou0bp/1tbiLR6ks1SImRbW9AAAsV
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In the define_te_avtab_ioctl function:
1. the parameter avrule_template has been copied to
new elements which added to avrule list through
the function avrule_cpy, so it should free avrule_template.
2. And for rangelist, it does not free the allocated memory.

The memory leak can by found by using memory sanitizer:
=================================================================
==20021==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 10336 byte(s) in 76 object(s) allocated from:
    #0 0x7f8f96d9cb50 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xdeb50)
    #1 0x55c2e9447fb3 in define_te_avtab_xperms_helper /mnt/sources/tools/selinux/checkpolicy/policy_define.c:2046
    #2 0x55c2e944a6ca in define_te_avtab_extended_perms /mnt/sources/tools/selinux/checkpolicy/policy_define.c:2479
    #3 0x55c2e943126b in yyparse /mnt/sources/tools/selinux/checkpolicy/policy_parse.y:494
    #4 0x55c2e9440221 in read_source_policy /mnt/sources/tools/selinux/checkpolicy/parse_util.c:64
    #5 0x55c2e945a3df in main /mnt/sources/tools/selinux/checkpolicy/checkpolicy.c:619
    #6 0x7f8f968eeb96 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x21b96)

Direct leak of 240 byte(s) in 15 object(s) allocated from:
    #0 0x7f8f96d9cb50 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xdeb50)
    #1 0x55c2e9446cd9 in avrule_sort_ioctls /mnt/sources/tools/selinux/checkpolicy/policy_define.c:1846
    #2 0x55c2e9447d8f in avrule_ioctl_ranges /mnt/sources/tools/selinux/checkpolicy/policy_define.c:2020
    #3 0x55c2e944a0de in define_te_avtab_ioctl /mnt/sources/tools/selinux/checkpolicy/policy_define.c:2409
    #4 0x55c2e944a744 in define_te_avtab_extended_perms /mnt/sources/tools/selinux/checkpolicy/policy_define.c:2485
    #5 0x55c2e94312bf in yyparse /mnt/sources/tools/selinux/checkpolicy/policy_parse.y:503
    #6 0x55c2e9440221 in read_source_policy /mnt/sources/tools/selinux/checkpolicy/parse_util.c:64
    #7 0x55c2e945a3df in main /mnt/sources/tools/selinux/checkpolicy/checkpolicy.c:619
    #8 0x7f8f968eeb96 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x21b96)

Tested-By: Christian Göttsche <cgzones@googlemail.com>
Signed-off-by: liwugang <liwugang@163.com>
---
 checkpolicy/policy_define.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 16234f31..52105d3a 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -2400,7 +2400,7 @@ int avrule_cpy(avrule_t *dest, avrule_t *src)
 int define_te_avtab_ioctl(avrule_t *avrule_template)
 {
 	avrule_t *avrule;
-	struct av_ioctl_range_list *rangelist;
+	struct av_ioctl_range_list *rangelist, *r;
 	av_extended_perms_t *complete_driver, *partial_driver, *xperms;
 	unsigned int i;
 
@@ -2458,6 +2458,12 @@ done:
 	if (partial_driver)
 		free(partial_driver);
 
+	while (rangelist != NULL) {
+		r = rangelist;
+		rangelist = rangelist->next;
+		free(r);
+	}
+
 	return 0;
 }
 
@@ -2484,6 +2490,8 @@ int define_te_avtab_extended_perms(int which)
 		free(id);
 		if (define_te_avtab_ioctl(avrule_template))
 			return -1;
+		avrule_destroy(avrule_template);
+		free(avrule_template);
 	} else {
 		yyerror("only ioctl extended permissions are supported");
 		free(id);
-- 
2.30.2


