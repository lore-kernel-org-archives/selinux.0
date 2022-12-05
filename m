Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7146C4321E
	for <selinux@archiver.kernel.org>; Mon,  5 Dec 2022 12:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiLEMJl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 5 Dec 2022 07:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiLEMJk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 5 Dec 2022 07:09:40 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81501B9E
        for <selinux@vger.kernel.org>; Mon,  5 Dec 2022 04:09:39 -0800 (PST)
Received: from dggpeml500008.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NQj4z1Tjkz15N7p
        for <selinux@vger.kernel.org>; Mon,  5 Dec 2022 20:08:51 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 5 Dec
 2022 20:09:37 +0800
From:   Jie Lu <lujie54@huawei.com>
To:     <selinux@vger.kernel.org>
Subject: [PATCH 1/3] libselinux: fix potential NULL reference and memory leak in audit2why
Date:   Mon, 5 Dec 2022 17:36:42 +0800
Message-ID: <20221205093644.703107-1-lujie54@huawei.com>
X-Mailer: git-send-email 2.27.0
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

In audit2why.c add return check for memory allocation. And free every element
in the boollist when function fails.

Signed-off-by: Jie Lu <lujie54@huawei.com>
---
 libselinux/src/audit2why.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index ba1a66eb..742b4ff5 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -55,7 +55,16 @@ static int load_booleans(const sepol_bool_t * boolean,
 			 void *arg __attribute__ ((__unused__)))
 {
 	boollist[boolcnt] = malloc(sizeof(struct boolean_t));
+	if (!boollist[boolcnt]) {
+		PyErr_SetString( PyExc_MemoryError, "Out of memory\n");
+		return -1;
+	}
 	boollist[boolcnt]->name = strdup(sepol_bool_get_name(boolean));
+	if (!boollist[boolcnt]->name) {
+		PyErr_SetString( PyExc_MemoryError, "Out of memory\n");
+		free(boollist[boolcnt]);
+		return -1;
+	}
 	boollist[boolcnt]->active = sepol_bool_get_value(boolean);
 	boolcnt++;
 	return 0;
@@ -149,6 +158,11 @@ static int check_booleans(struct boolean_t **bools)
 
 	if (fcnt > 0) {
 		*bools = calloc(sizeof(struct boolean_t), fcnt + 1);
+		if (!*bools) {
+			PyErr_SetString( PyExc_MemoryError, "Out of memory\n");
+			free(foundlist);
+			return 0;
+		}
 		struct boolean_t *b = *bools;
 		for (i = 0; i < fcnt; i++) {
 			int ctr = foundlist[i];
@@ -278,14 +292,22 @@ static int __policy_init(const char *init_path)
 	return 0;
 
 err:
-	if (boollist)
-		free(boollist);
+	if (boollist) {
+		for (i = 0; i < boolcnt; i++) {
+                        free(boollist[i]->name);
+                        free(boollist[i]);
+                }
+                free(boollist);
+                boollist = NULL;
+                boolcnt = 0;
+	}
 	if (avc){
 		if (avc->handle)
 			sepol_handle_destroy(avc->handle);
 		if (avc->policydb)
 			sepol_policydb_free(avc->policydb);
 		free(avc);
+		avc = NULL;
 	}
 	if (pf)
 		sepol_policy_file_free(pf);
-- 
2.27.0

