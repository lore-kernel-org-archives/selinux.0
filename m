Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F6FC4332F
	for <selinux@archiver.kernel.org>; Mon, 21 Nov 2022 15:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiKUPKu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Nov 2022 10:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiKUPK1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Nov 2022 10:10:27 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2855613EBC
        for <selinux@vger.kernel.org>; Mon, 21 Nov 2022 07:02:21 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NG9b42fMfzRpQw
        for <selinux@vger.kernel.org>; Mon, 21 Nov 2022 23:01:52 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 23:02:19 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 21 Nov
 2022 23:02:19 +0800
From:   Jie Lu <lujie54@huawei.com>
To:     <selinux@vger.kernel.org>
Subject: [PATCH] libselinux: fix some memory issues in db_init
Date:   Mon, 21 Nov 2022 20:29:47 +0800
Message-ID: <20221121122947.2079109-1-lujie54@huawei.com>
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

In db_init()
add the interpretation of the return value of strdup()
fix line_buf memory leak if process_line() < 0
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

