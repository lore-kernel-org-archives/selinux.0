Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A512BC4332F
	for <selinux@archiver.kernel.org>; Tue, 22 Nov 2022 07:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiKVHx4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Nov 2022 02:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbiKVHxq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Nov 2022 02:53:46 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA6832B96
        for <selinux@vger.kernel.org>; Mon, 21 Nov 2022 23:53:45 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NGbyr5QCmzJnmj
        for <selinux@vger.kernel.org>; Tue, 22 Nov 2022 15:50:28 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 15:53:43 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 22 Nov
 2022 15:53:43 +0800
From:   Jie Lu <lujie54@huawei.com>
To:     <selinux@vger.kernel.org>
Subject: [PATCH v2] libselinux: fix some memory issues in db_init
Date:   Tue, 22 Nov 2022 13:21:10 +0800
Message-ID: <20221122052110.2433833-1-lujie54@huawei.com>
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

1. check the return of strdup to avoid a potential NULL reference.
2. make sure line_buf is freed.

Signed-off-by: Jie Lu <lujie54@huawei.com>
---
 libselinux/src/label_db.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
index 94c05c6d..bd73201c 100644
--- a/libselinux/src/label_db.c
+++ b/libselinux/src/label_db.c
@@ -293,6 +293,11 @@ db_init(const struct selinux_opt *opts, unsigned nopts,
 		return NULL;
 	}
 	rec->spec_file = strdup(path);
+	if (!rec->spec_file) {
+                free(catalog);
+                fclose(filp);
+                return NULL;
+	}
 
 	/*
 	 * Parse for each lines
@@ -322,18 +327,19 @@ db_init(const struct selinux_opt *opts, unsigned nopts,
 		if (process_line(path, line_buf, ++line_num, catalog) < 0)
 			goto out_error;
 	}
-	free(line_buf);
 
 	if (digest_add_specfile(rec->digest, filp, NULL, sb.st_size, path) < 0)
 		goto out_error;
 
 	digest_gen_hash(rec->digest);
 
+	free(line_buf);
 	fclose(filp);
 
 	return catalog;
 
 out_error:
+	free(line_buf);
 	for (i = 0; i < catalog->nspec; i++) {
 		spec_t	       *spec = &catalog->specs[i];
 
-- 
2.27.0

