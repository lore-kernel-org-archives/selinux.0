Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0DEC072A2
	for <selinux@archiver.kernel.org>; Thu, 16 Nov 2023 02:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjKPCEJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Nov 2023 21:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPCEI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Nov 2023 21:04:08 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AFC19E
        for <selinux@vger.kernel.org>; Wed, 15 Nov 2023 18:04:04 -0800 (PST)
Received: from kwepemm000010.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SW3B53pY7zMn0r
        for <selinux@vger.kernel.org>; Thu, 16 Nov 2023 09:59:25 +0800 (CST)
Received: from localhost.localdomain (10.175.104.170) by
 kwepemm000010.china.huawei.com (7.193.23.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 16 Nov 2023 10:04:01 +0800
From:   <luhuaxin1@huawei.com>
To:     <selinux@vger.kernel.org>
CC:     <fangxiuning@huawei.com>, <zhujianwei7@huawei.com>,
        <shenyining@huawei.com>, Huaxin Lu <luhuaxin1@huawei.com>
Subject: [PATCH v2] libsepol: add check for category value before printing
Date:   Thu, 16 Nov 2023 07:32:07 +0800
Message-ID: <20231115233207.51845-1-luhuaxin1@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000010.china.huawei.com (7.193.23.169)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Huaxin Lu <luhuaxin1@huawei.com>

In mls_semantic_level_expand(), there is a explicitly determine
whether category is 0, which may cause an potential integer
overflow in error branch.

Signed-off-by: Huaxin Lu <luhuaxin1@huawei.com>
---
 libsepol/src/expand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index ee5f9185..9ed22bfd 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -945,8 +945,8 @@ int mls_semantic_level_expand(mls_semantic_level_t * sl, mls_level_t * l,
 	for (cat = sl->cat; cat; cat = cat->next) {
 		if (!cat->low || cat->low > cat->high) {
 			ERR(h, "Category range is not valid %s.%s",
-			    p->p_cat_val_to_name[cat->low - 1],
-			    p->p_cat_val_to_name[cat->high - 1]);
+			    cat->low > 0 ? p->p_cat_val_to_name[cat->low - 1] : "Invalid",
+			    cat->high > 0 ? p->p_cat_val_to_name[cat->high - 1] : "Invalid");
 			return -1;
 		}
 		for (i = cat->low - 1; i < cat->high; i++) {
-- 
2.33.0

