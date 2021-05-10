Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3B1C41538
	for <selinux@archiver.kernel.org>; Mon, 10 May 2021 11:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C40A61108
	for <selinux@archiver.kernel.org>; Mon, 10 May 2021 11:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhEJLWT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 May 2021 07:22:19 -0400
Received: from m12-12.163.com ([220.181.12.12]:42560 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234673AbhEJLFP (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 10 May 2021 07:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=t3DdB1X/hJYHrSUY2b
        tJvf6c/WLMsfB7TwGWIpSDb+M=; b=kW4xx/RPC8EYo7QoSZi+42uCjLkIA6iWnR
        jiYS2kyHQcLJa79ncCUsUR94svogx5dhpK0g5P0aXoBz9dSbYI++zrkq0B80gVbd
        uVbr7B74F55s8+/baUHZm2oyTnjBGd7h6pwAjXes1MqYmBTHWL5JPc2zujeACdRM
        PcU4TiZQA=
Received: from mi-OptiPlex-9020.mioffice.cn (unknown [113.50.48.195])
        by smtp8 (Coremail) with SMTP id DMCowAAX9bkcE5lg+klMDQ--.28741S2;
        Mon, 10 May 2021 19:04:08 +0800 (CST)
From:   liwugang <liwugang@163.com>
To:     selinux@vger.kernel.org
Cc:     liwugang <liwugang@163.com>
Subject: [PATCH] checkpolicy: fix the leak memory when uses xperms
Date:   Mon, 10 May 2021 19:03:54 +0800
Message-Id: <20210510110354.3585-1-liwugang@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DMCowAAX9bkcE5lg+klMDQ--.28741S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFy3Kw48Jw13KF1UurWDCFg_yoW5tFy8pr
        srKrZ7AryUWrWfXrn7Ww4jvr4S93yqkw48GFyxAw47AFy8Zw18WayDAryYyF4rWF95Aa93
        tFn8Xa1UWaykJFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziy89_UUUUU=
X-Originating-IP: [113.50.48.195]
X-CM-SenderInfo: 5olz3wxdqjqiywtou0bp/xtbBRgiOs13l-lWCsQAAsT
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In the define_te_avtab_ioctl function:
1. the parameter avrule_template has been copies to
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

Signed-off-by: liwugang <liwugang@163.com>
---
 checkpolicy/policy_define.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 16234f31..04064af2 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -2400,7 +2400,7 @@ int avrule_cpy(avrule_t *dest, avrule_t *src)
 int define_te_avtab_ioctl(avrule_t *avrule_template)
 {
 	avrule_t *avrule;
-	struct av_ioctl_range_list *rangelist;
+	struct av_ioctl_range_list *rangelist, *r, *r2;
 	av_extended_perms_t *complete_driver, *partial_driver, *xperms;
 	unsigned int i;
 
@@ -2458,6 +2458,13 @@ done:
 	if (partial_driver)
 		free(partial_driver);
 
+	r = rangelist;
+	while (r != NULL) {
+		r2 = r;
+		r = r->next;
+		free(r2);
+	}
+
 	return 0;
 }
 
@@ -2484,6 +2491,8 @@ int define_te_avtab_extended_perms(int which)
 		free(id);
 		if (define_te_avtab_ioctl(avrule_template))
 			return -1;
+		avrule_destroy(avrule_template);
+		free(avrule_template);
 	} else {
 		yyerror("only ioctl extended permissions are supported");
 		free(id);
-- 
2.17.1


