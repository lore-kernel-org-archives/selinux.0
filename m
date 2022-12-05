Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47CEC47089
	for <selinux@archiver.kernel.org>; Mon,  5 Dec 2022 12:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiLEMJn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 5 Dec 2022 07:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbiLEMJl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 5 Dec 2022 07:09:41 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD80960ED
        for <selinux@vger.kernel.org>; Mon,  5 Dec 2022 04:09:39 -0800 (PST)
Received: from dggpeml500008.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NQj4y4vVSzmWMV
        for <selinux@vger.kernel.org>; Mon,  5 Dec 2022 20:08:50 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 5 Dec
 2022 20:09:37 +0800
From:   Jie Lu <lujie54@huawei.com>
To:     <selinux@vger.kernel.org>
Subject: [PATCH 2/3] libsepol: fix potential memory leak in common_copy_callback
Date:   Mon, 5 Dec 2022 17:36:43 +0800
Message-ID: <20221205093644.703107-2-lujie54@huawei.com>
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

In common_copy_callback(), destroy new_common->permissions when the function fails.

Signed-off-by: Jie Lu <lujie54@huawei.com>
---
 libsepol/src/expand.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 8d19850e..b44cfd4f 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -297,6 +297,7 @@ static int common_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 			   (hashtab_datum_t) new_common);
 	if (ret) {
 		ERR(state->handle, "hashtab overflow");
+		symtab_destroy(&new_common->permissions);
 		free(new_common);
 		free(new_id);
 		return -1;
-- 
2.27.0

