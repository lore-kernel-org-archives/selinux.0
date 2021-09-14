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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA61C4332F
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A81F60F58
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbhINMwG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 08:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbhINMwF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Sep 2021 08:52:05 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C54C061762
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 05:50:47 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c21so11863957edj.0
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 05:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0xnftEX/8RMO9TxboJnoJJLRnQz2F3DsGIplRYkbz2Y=;
        b=WgHfigpVvCEAtlMpD4wlvUjNmDFRkzTcCUdMnny6T9OFOVI5evoswvhmAJw0CHsymA
         L6LaMLtNB9HJbkIlH3h+a68c6MrfwyRdx0fGS0lj1+bm22Wj//n4Lr7Z0ndz11Zn/KUr
         0CfS69dhSUebuBpa9Xl9zn5cfsJKDAio/qs4fY/7wOB0slBbmYv+Tu/D7uANHD9qy7tU
         VMDdMSBTbIC0UivyAD8Xv6AccIxBfEVj6mcTBtrBd5IQp2gPHOslD0ifiwur+tuf3PqA
         RzfZ4Bn8hhFpiGubK2rd7FddoECJdWLAqrXsuv60lrlSpSTN4+AIcxerABl9o9P2/61w
         3wFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0xnftEX/8RMO9TxboJnoJJLRnQz2F3DsGIplRYkbz2Y=;
        b=TPuT7p+WG8FrGKdzjIojicEIDY9aj2HuX6ibCxNb5D3cddqAHPlWo4gyJ0yKU00BEJ
         hTqDzouQRe0snjXf2EBUuErm65zS8QBP0Yrka+DbNYilwuaUO/gVgyS/zboXkCw2cOAO
         A//u8KXqlk9vzhzU1rO08u/u3pStAWlMyjMUT9jHUxAxV2Xjx64nrIjO2rVDhihaTinw
         ZK56fmPIkRG+PBu4LXe85KY/2jO0bPb/wBuIBwZYL9hmRGygrwbIXZCbHsF/3omWtbA3
         hE5beFroH5P/OI1tJeHQiLbKZ696GgWxnwcV0QQ4hUhlloH4ZQoeOalAAIp/n5ii7VHE
         iFJA==
X-Gm-Message-State: AOAM531Cffh9RJ7plV4g/wWDbmMaAlMwSG9AgzjsziWzir96nVSTZO1n
        uF8ZQ9EyDfx0FTRa2HxFqZTB1jgjVRU=
X-Google-Smtp-Source: ABdhPJwkpKq+qPFt0rrRG1ADouKCEybT9VU8nDYoZ4SHfl2A7wTUm/+7cVkkR3aQosCyAWBOoTeAbA==
X-Received: by 2002:a05:6402:150a:: with SMTP id f10mr19132375edw.318.1631623846542;
        Tue, 14 Sep 2021 05:50:46 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-237-250.77.3.pool.telefonica.de. [77.3.237.250])
        by smtp.gmail.com with ESMTPSA id r8sm5567865eds.39.2021.09.14.05.50.46
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 05:50:46 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 07/13] checkpolicy: mark file local functions in policy_define static
Date:   Tue, 14 Sep 2021 14:48:22 +0200
Message-Id: <20210914124828.19488-8-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914124828.19488-1-cgzones@googlemail.com>
References: <20210914124828.19488-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Also remove the unused function `avrule_ioctl_freeranges()`.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 45 ++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 28 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 7e7801d3..11707700 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1605,7 +1605,7 @@ static int set_types(type_set_t * set, char *id, int *add, char starallowed)
 	return -1;
 }
 
-int define_compute_type_helper(int which, avrule_t ** rule)
+static int define_compute_type_helper(int which, avrule_t ** rule)
 {
 	char *id;
 	type_datum_t *datum;
@@ -1832,7 +1832,7 @@ struct av_ioctl_range_list {
 	struct av_ioctl_range_list *next;
 };
 
-int avrule_sort_ioctls(struct av_ioctl_range_list **rangehead)
+static int avrule_sort_ioctls(struct av_ioctl_range_list **rangehead)
 {
 	struct av_ioctl_range_list *r, *r2, *sorted, *sortedhead = NULL;
 
@@ -1880,7 +1880,7 @@ error:
 	return -1;
 }
 
-int avrule_merge_ioctls(struct av_ioctl_range_list **rangehead)
+static int avrule_merge_ioctls(struct av_ioctl_range_list **rangehead)
 {
 	struct av_ioctl_range_list *r, *tmp;
 	r = *rangehead;
@@ -1900,7 +1900,7 @@ int avrule_merge_ioctls(struct av_ioctl_range_list **rangehead)
 	return 0;
 }
 
-int avrule_read_ioctls(struct av_ioctl_range_list **rangehead)
+static int avrule_read_ioctls(struct av_ioctl_range_list **rangehead)
 {
 	char *id;
 	struct av_ioctl_range_list *rnew, *r = NULL;
@@ -1953,7 +1953,7 @@ error:
 }
 
 /* flip to included ranges */
-int avrule_omit_ioctls(struct av_ioctl_range_list **rangehead)
+static int avrule_omit_ioctls(struct av_ioctl_range_list **rangehead)
 {
 	struct av_ioctl_range_list *rnew, *r, *newhead, *r2;
 
@@ -2001,7 +2001,7 @@ error:
 	return -1;
 }
 
-int avrule_ioctl_ranges(struct av_ioctl_range_list **rangelist)
+static int avrule_ioctl_ranges(struct av_ioctl_range_list **rangelist)
 {
 	struct av_ioctl_range_list *rangehead;
 	uint8_t omit;
@@ -2029,7 +2029,7 @@ int avrule_ioctl_ranges(struct av_ioctl_range_list **rangelist)
 	return 0;
 }
 
-int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
+static int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
 {
 	char *id;
 	class_perm_node_t *perms, *tail = NULL, *cur_perms = NULL;
@@ -2150,7 +2150,7 @@ out:
 #define XPERM_LOW(x) ((x) << 5)
 /* high value for this u32 */
 #define XPERM_HIGH(x) ((((x) + 1) << 5) - 1)
-void avrule_xperm_setrangebits(uint16_t low, uint16_t high,
+static void avrule_xperm_setrangebits(uint16_t low, uint16_t high,
 				av_extended_perms_t *xperms)
 {
 	unsigned int i;
@@ -2172,7 +2172,7 @@ void avrule_xperm_setrangebits(uint16_t low, uint16_t high,
 	}
 }
 
-int avrule_xperms_used(const av_extended_perms_t *xperms)
+static int avrule_xperms_used(const av_extended_perms_t *xperms)
 {
 	unsigned int i;
 
@@ -2192,7 +2192,7 @@ int avrule_xperms_used(const av_extended_perms_t *xperms)
 #define IOC_DRIV(x) ((x) >> 8)
 #define IOC_FUNC(x) ((x) & 0xff)
 #define IOC_CMD(driver, func) (((driver) << 8) + (func))
-int avrule_ioctl_partialdriver(struct av_ioctl_range_list *rangelist,
+static int avrule_ioctl_partialdriver(struct av_ioctl_range_list *rangelist,
 				av_extended_perms_t *complete_driver,
 				av_extended_perms_t **extended_perms)
 {
@@ -2231,7 +2231,7 @@ int avrule_ioctl_partialdriver(struct av_ioctl_range_list *rangelist,
 
 }
 
-int avrule_ioctl_completedriver(struct av_ioctl_range_list *rangelist,
+static int avrule_ioctl_completedriver(struct av_ioctl_range_list *rangelist,
 			av_extended_perms_t **extended_perms)
 {
 	struct av_ioctl_range_list *r;
@@ -2273,7 +2273,7 @@ int avrule_ioctl_completedriver(struct av_ioctl_range_list *rangelist,
 	return 0;
 }
 
-int avrule_ioctl_func(struct av_ioctl_range_list *rangelist,
+static int avrule_ioctl_func(struct av_ioctl_range_list *rangelist,
 		av_extended_perms_t **extended_perms, unsigned int driver)
 {
 	struct av_ioctl_range_list *r;
@@ -2323,18 +2323,7 @@ int avrule_ioctl_func(struct av_ioctl_range_list *rangelist,
 	return 0;
 }
 
-void avrule_ioctl_freeranges(struct av_ioctl_range_list *rangelist)
-{
-	struct av_ioctl_range_list *r, *tmp;
-	r = rangelist;
-	while (r) {
-		tmp = r;
-		r = r->next;
-		free(tmp);
-	}
-}
-
-unsigned int xperms_for_each_bit(unsigned int *bit, av_extended_perms_t *xperms)
+static unsigned int xperms_for_each_bit(unsigned int *bit, av_extended_perms_t *xperms)
 {
 	unsigned int i;
 	for (i = *bit; i < sizeof(xperms->perms)*8; i++) {
@@ -2347,7 +2336,7 @@ unsigned int xperms_for_each_bit(unsigned int *bit, av_extended_perms_t *xperms)
 	return 0;
 }
 
-int avrule_cpy(avrule_t *dest, const avrule_t *src)
+static int avrule_cpy(avrule_t *dest, const avrule_t *src)
 {
 	class_perm_node_t *src_perms;
 	class_perm_node_t *dest_perms, *dest_tail;
@@ -2395,7 +2384,7 @@ int avrule_cpy(avrule_t *dest, const avrule_t *src)
 	return 0;
 }
 
-int define_te_avtab_ioctl(const avrule_t *avrule_template)
+static int define_te_avtab_ioctl(const avrule_t *avrule_template)
 {
 	avrule_t *avrule;
 	struct av_ioctl_range_list *rangelist;
@@ -2490,7 +2479,7 @@ int define_te_avtab_extended_perms(int which)
 	return 0;
 }
 
-int define_te_avtab_helper(int which, avrule_t ** rule)
+static int define_te_avtab_helper(int which, avrule_t ** rule)
 {
 	char *id;
 	class_datum_t *cladatum;
@@ -5470,7 +5459,7 @@ int define_fs_use(int behavior)
 	return 0;
 }
 
-int define_genfs_context_helper(char *fstype, int has_type)
+static int define_genfs_context_helper(char *fstype, int has_type)
 {
 	struct genfs *genfs_p, *genfs, *newgenfs;
 	ocontext_t *newc, *c, *head, *p;
-- 
2.33.0

