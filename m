Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47D8C433FE
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B68E60F58
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhINMwJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 08:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbhINMwI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Sep 2021 08:52:08 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C46DC061574
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 05:50:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id t6so18301848edi.9
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 05:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Rsk95+j2kBdsvDB7iVlc79S0zZ58HTgFew6DTB9SyQ=;
        b=TRlEb2geos3vU9ysoWQSX8+nkMI4q9ySX6bxq764A2dFtCfo/vmrYHE76R63KR1Nm4
         rhp+RIzNduyQrm7ZiyUNmbCP2lsyr3HvK17wMrsyRps9GND/wmMVPdnoAlRTRnH554sA
         Wb9t91UupXKn1eFqtXVvOqcEh9e2FT+W0wsvYDZuOauohx+Jrhw8Xh+cBJs+gclSvhCZ
         0CfDgxrIKamY10q1LuxH6djOyeDMhULDIuOVVk8ZbsqRDv8CAZlFjKbgIrqjxiUwkq+F
         wNTYIZ96Fh0KlRgj+KadP8F6hFq78j8v+IDkc8VWyP1NlOI6eY1AMRglFVDcKeYYoiTo
         dJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Rsk95+j2kBdsvDB7iVlc79S0zZ58HTgFew6DTB9SyQ=;
        b=B/7ux83Ai51045kEctq8O6tgce2fVXL+68+XTa5/jbfTJGpaPSABh+taZToZmgGpu1
         mr5AivjZWKMM+QCRxt3hB71mOh6CyWDl8gG2OXS2+nyUWca7hdVWu72HIA/5RIDIG8pR
         3QdXsEvmgvvcsVfRlhIb+p67CA562UF24RCXB1oYbdtW2sRYbBRv1TVKaNw87EKqBwcf
         +1Wjb6PDzSrxasI9+2mf+2H3wwEHmJ2SyvHlW4A5gXNFbnV5vc74x1F9V0N9BGzrv9VH
         xuMGAE97SyVtjhP4PqgNjWZ68HFjk1Vze/KJuZJkC3pkPGnjjE1PmQNyi86qYGotC4dh
         ETWw==
X-Gm-Message-State: AOAM530QfFsZGRoG2tDlXE5S6bjAPEQwnW92v1HcfXdkFrLAuya/3+wt
        Gp8vA09pdnVeQwxikfMfUO1Ho91QfGM=
X-Google-Smtp-Source: ABdhPJwtEWTPsvCE764nWdvzTf8fmpzr0SvUlys+QZm1bcOmCjSJRFsl/VNtOdFzYWfka4bSIHUsBw==
X-Received: by 2002:aa7:c988:: with SMTP id c8mr12849731edt.105.1631623849933;
        Tue, 14 Sep 2021 05:50:49 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-237-250.77.3.pool.telefonica.de. [77.3.237.250])
        by smtp.gmail.com with ESMTPSA id r8sm5567865eds.39.2021.09.14.05.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 05:50:49 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     liwugang <liwugang@163.com>
Subject: [PATCH 13/13] checkpolicy: free extended permission memory
Date:   Tue, 14 Sep 2021 14:48:28 +0200
Message-Id: <20210914124828.19488-14-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914124828.19488-1-cgzones@googlemail.com>
References: <20210914124828.19488-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

define_te_avtab_xperms_helper() allocates memory for the avrule, while
define_te_avtab_ioctl() does not transfer any ownership of it.
Free the affected memory.

    Direct leak of 272 byte(s) in 2 object(s) allocated from:
        #0 0x49bb8d in __interceptor_malloc (./checkpolicy/checkmodule+0x49bb8d)
        #1 0x4f379c in define_te_avtab_xperms_helper ./checkpolicy/policy_define.c:2047:24
        #2 0x4f379c in define_te_avtab_extended_perms ./checkpolicy/policy_define.c:2469:6
        #3 0x4cf417 in yyparse ./checkpolicy/policy_parse.y:494:30
        #4 0x4eaf35 in read_source_policy ./checkpolicy/parse_util.c:63:6
        #5 0x50cccd in main ./checkpolicy/checkmodule.c:278:7
        #6 0x7fbfa455ce49 in __libc_start_main csu/../csu/libc-start.c:314:16

    Direct leak of 32 byte(s) in 2 object(s) allocated from:
        #0 0x49bb8d in __interceptor_malloc (./checkpolicy/checkmodule+0x49bb8d)
        #1 0x4f4a38 in avrule_sort_ioctls ./checkpolicy/policy_define.c:1844:12
        #2 0x4f4a38 in avrule_ioctl_ranges ./checkpolicy/policy_define.c:2021:6
        #3 0x4f4a38 in define_te_avtab_ioctl ./checkpolicy/policy_define.c:2399:6
        #4 0x4f4a38 in define_te_avtab_extended_perms ./checkpolicy/policy_define.c:2475:7
        #5 0x4cf417 in yyparse ./checkpolicy/policy_parse.y:494:30
        #6 0x4eaf35 in read_source_policy ./checkpolicy/parse_util.c:63:6
        #7 0x50cccd in main ./checkpolicy/checkmodule.c:278:7
        #8 0x7fbfa455ce49 in __libc_start_main csu/../csu/libc-start.c:314:16

Reported-by: liwugang <liwugang@163.com>
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index c71e0571..185d5704 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -2390,7 +2390,7 @@ static int avrule_cpy(avrule_t *dest, const avrule_t *src)
 static int define_te_avtab_ioctl(const avrule_t *avrule_template)
 {
 	avrule_t *avrule;
-	struct av_ioctl_range_list *rangelist;
+	struct av_ioctl_range_list *rangelist, *r;
 	av_extended_perms_t *complete_driver, *partial_driver, *xperms;
 	unsigned int i;
 
@@ -2448,6 +2448,12 @@ done:
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
 
@@ -2456,6 +2462,7 @@ int define_te_avtab_extended_perms(int which)
 	char *id;
 	unsigned int i;
 	avrule_t *avrule_template;
+	int rc = 0;
 
 	if (pass == 1) {
 		for (i = 0; i < 4; i++) {
@@ -2471,15 +2478,17 @@ int define_te_avtab_extended_perms(int which)
 
 	id = queue_remove(id_queue);
 	if (strcmp(id,"ioctl") == 0) {
-		free(id);
-		if (define_te_avtab_ioctl(avrule_template))
-			return -1;
+		rc = define_te_avtab_ioctl(avrule_template);
 	} else {
 		yyerror("only ioctl extended permissions are supported");
-		free(id);
-		return -1;
+		rc = -1;
 	}
-	return 0;
+
+	free(id);
+	avrule_destroy(avrule_template);
+	free(avrule_template);
+
+	return rc;
 }
 
 static int define_te_avtab_helper(int which, avrule_t ** rule)
-- 
2.33.0

