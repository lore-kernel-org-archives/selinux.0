Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DE0C4321E
	for <selinux@archiver.kernel.org>; Tue, 29 Nov 2022 14:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbiK2OdU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Nov 2022 09:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbiK2OdH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Nov 2022 09:33:07 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D0E421BD
        for <selinux@vger.kernel.org>; Tue, 29 Nov 2022 06:33:06 -0800 (PST)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NM4YP4DtWzmVJq
        for <selinux@vger.kernel.org>; Tue, 29 Nov 2022 22:32:25 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 22:33:05 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 29 Nov
 2022 22:33:04 +0800
From:   Jie Lu <lujie54@huawei.com>
To:     <selinux@vger.kernel.org>
Subject: [PATCH] libselinux:add check for malloc
Date:   Tue, 29 Nov 2022 20:00:20 +0800
Message-ID: <20221129120020.1915666-1-lujie54@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add return check for regex_data_create() to avoid NULL reference of regex_data

(gdb) bt
 #0  0x00007fbde5caec14 in pthread_mutex_init () from /usr/lib64/libc.so.6
 #1  0x00007fbde5e3a489 in regex_data_create () at regex.c:260
 #2  0x00007fbde5e3a4af in regex_prepare_data (regex=regex@entry=0x7fbde4613770, pattern_string=pattern_string@entry=0x563c6799a820 "^/home$", errordata=errordata@entry=0x7ffeb83fa950) at regex.c:76
 #3  0x00007fbde5e32fe6 in compile_regex (errbuf=0x0, spec=0x7fbde4613748) at label_file.h:407
 #4  lookup_all (key=0x563c679974e5 "/var/log/kadmind.log", type=<optimized out>, partial=partial@entry=false, match_count=match_count@entry=0x0, rec=<optimized out>, rec=<optimized out>)
     at label_file.c:949
 #5  0x00007fbde5e33350 in lookup (rec=<optimized out>, key=<optimized out>, type=<optimized out>) at label_file.c:1092
 #6  0x00007fbde5e31878 in selabel_lookup_common (rec=0x563c67998cc0, translating=1, key=<optimized out>, type=<optimized out>) at label.c:167

Signed-off-by: Jie Lu <lujie54@huawei.com>
---
 libselinux/src/regex.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index 73987d9f..149a7973 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -257,6 +257,9 @@ struct regex_data *regex_data_create(void)
 {
 	struct regex_data *regex_data =
 		(struct regex_data *)calloc(1, sizeof(struct regex_data));
+	if (!regex_data)
+		return NULL;
+
 	__pthread_mutex_init(&regex_data->match_mutex, NULL);
 	return regex_data;
 }
-- 
2.27.0

