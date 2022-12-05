Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464A5C4708C
	for <selinux@archiver.kernel.org>; Mon,  5 Dec 2022 12:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiLEMJm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 5 Dec 2022 07:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiLEMJl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 5 Dec 2022 07:09:41 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D8410A9
        for <selinux@vger.kernel.org>; Mon,  5 Dec 2022 04:09:39 -0800 (PST)
Received: from dggpeml500008.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NQj4z590Lz15N81
        for <selinux@vger.kernel.org>; Mon,  5 Dec 2022 20:08:51 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 5 Dec
 2022 20:09:38 +0800
From:   Jie Lu <lujie54@huawei.com>
To:     <selinux@vger.kernel.org>
Subject: [PATCH 3/3] policycoreutils: fix potential NULL reference in load_checks
Date:   Mon, 5 Dec 2022 17:36:44 +0800
Message-ID: <20221205093644.703107-3-lujie54@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221205093644.703107-1-lujie54@huawei.com>
References: <20221205093644.703107-1-lujie54@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In load_checks(), add return check for malloc() to avoid NULL reference.

Signed-off-by: Jie Lu <lujie54@huawei.com>
---
 policycoreutils/sestatus/sestatus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestatus/sestatus.c
index 7dcc9944..6c95828e 100644
--- a/policycoreutils/sestatus/sestatus.c
+++ b/policycoreutils/sestatus/sestatus.c
@@ -140,6 +140,8 @@ static void load_checks(char *pc[], int *npc, char *fc[], int *nfc)
 					pc[*npc] =
 					    (char *)malloc((buf_len) *
 							   sizeof(char));
+					if (!pc[*npc])
+						break;
 					memcpy(pc[*npc], bufp, buf_len);
 					(*npc)++;
 					bufp = NULL;
@@ -150,6 +152,8 @@ static void load_checks(char *pc[], int *npc, char *fc[], int *nfc)
 					fc[*nfc] =
 					    (char *)malloc((buf_len) *
 							   sizeof(char));
+					if (!fc[*nfc])
+						break;
 					memcpy(fc[*nfc], bufp, buf_len);
 					(*nfc)++;
 					bufp = NULL;
-- 
2.27.0

