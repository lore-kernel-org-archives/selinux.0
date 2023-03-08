Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3790C64EC4
	for <selinux@archiver.kernel.org>; Wed,  8 Mar 2023 09:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCHJxf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Mar 2023 04:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjCHJxT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Mar 2023 04:53:19 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9F8559F1
        for <selinux@vger.kernel.org>; Wed,  8 Mar 2023 01:53:17 -0800 (PST)
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PWngS5FMKzKmbL;
        Wed,  8 Mar 2023 17:53:08 +0800 (CST)
Received: from Linux-SUSE12SP5.huawei.com (10.67.136.158) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 17:53:15 +0800
From:   wanghuizhao <wanghuizhao1@huawei.com>
To:     <selinux@vger.kernel.org>
CC:     <cgzones@googlemail.com>, <lautrbach@redhat.com>,
        <jwcart2@gmail.com>, <jason@perfinion.com>,
        <weiyuchen3@huawei.com>, <wanghuizhao1@huawei.com>
Subject: [PATCH v3 2/3] libselinux: adapting hashtab to libselinux
Date:   Wed, 8 Mar 2023 17:53:07 +0800
Message-ID: <20230308095308.60661-3-wanghuizhao1@huawei.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20230308095308.60661-1-wanghuizhao1@huawei.com>
References: <20230308095308.60661-1-wanghuizhao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.136.158]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500007.china.huawei.com (7.221.188.207)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

To adapt to the scenarios of libselinux, this patch does three things:

1. Add a new function hashtab_destroy_key. This function is used to
   reclaim memory using the customized key destruction method.

2. Changed the macro definition to _SELINUX_HASHTAB_H_.

3. Add a function declaration to the header file.

Signed-off-by: wanghuizhao <wanghuizhao1@huawei.com>
---
 libselinux/src/hashtab.c | 26 ++++++++++++++++++++++++++
 libselinux/src/hashtab.h |  6 ++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/hashtab.c b/libselinux/src/hashtab.c
index 26d4f4c7..c415ad0d 100644
--- a/libselinux/src/hashtab.c
+++ b/libselinux/src/hashtab.c
@@ -156,6 +156,32 @@ void hashtab_destroy(hashtab_t h)
 	free(h);
 }
 
+void hashtab_destroy_key(hashtab_t h,
+		int (*destroy_key) (hashtab_key_t k))
+{
+	unsigned int i;
+	hashtab_ptr_t cur, temp;
+
+	if (!h)
+		return;
+
+	for (i = 0; i < h->size; i++) {
+		cur = h->htable[i];
+		while (cur != NULL) {
+			temp = cur;
+			cur = cur->next;
+			destroy_key(temp->key);
+			free(temp);
+		}
+		h->htable[i] = NULL;
+	}
+
+	free(h->htable);
+	h->htable = NULL;
+
+	free(h);
+}
+
 int hashtab_map(hashtab_t h,
 		int (*apply) (hashtab_key_t k,
 			      hashtab_datum_t d, void *args), void *args)
diff --git a/libselinux/src/hashtab.h b/libselinux/src/hashtab.h
index 78471269..9d2b593b 100644
--- a/libselinux/src/hashtab.h
+++ b/libselinux/src/hashtab.h
@@ -11,8 +11,8 @@
  * provided by the creator of the table.
  */
 
-#ifndef _NEWROLE_HASHTAB_H_
-#define _NEWROLE_HASHTAB_H_
+#ifndef _SELINUX_HASHTAB_H_
+#define _SELINUX_HASHTAB_H_
 
 #include <stdint.h>
 #include <errno.h>
@@ -93,6 +93,8 @@ extern hashtab_datum_t hashtab_search(hashtab_t h, const_hashtab_key_t k);
    Destroys the specified hash table.
  */
 extern void hashtab_destroy(hashtab_t h);
+extern void hashtab_destroy_key(hashtab_t h,
+			int (*destroy_key) (hashtab_key_t k));
 
 /*
    Applies the specified apply function to (key,datum,args)
-- 
2.12.3

