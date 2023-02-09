Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0041DC636D7
	for <selinux@archiver.kernel.org>; Thu,  9 Feb 2023 11:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjBILy6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Feb 2023 06:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBILy1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Feb 2023 06:54:27 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B148EC6B
        for <selinux@vger.kernel.org>; Thu,  9 Feb 2023 03:43:03 -0800 (PST)
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PCFKv6fjfzRrxr
        for <selinux@vger.kernel.org>; Thu,  9 Feb 2023 19:40:35 +0800 (CST)
Received: from Linux-SUSE12SP5.huawei.com (10.67.136.158) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 9 Feb 2023 19:43:00 +0800
From:   wanghuizhao <wanghuizhao1@huawei.com>
To:     <selinux@vger.kernel.org>, <nixiaoming@huawei.com>,
        <tengfei22@huawei.com>, <luohaizheng@huawei.com>,
        <leisure.wang@huawei.com>, <dongxinhua@huawei.com>
CC:     <wuquanming@huawei.com>, <chenjingwen6@huawei.com>,
        <douzhaolei@huawei.com>, <hushijie3@huawei.com>,
        <jiangyangyang@huawei.com>, <laiyuanyuan.lai@huawei.com>,
        <luozhoujian1@huawei.com>, <wangxu72@huawei.com>,
        <wanqian10@huawei.com>, <weiyuchen3@huawei.com>,
        <wangfangpeng1@huawei.com>, <young.liuyang@huawei.com>,
        <zengweilin@huawei.com>, <wangle6@huawei.com>
Subject: [PATCH 2/2] libselinux: performance optimization for duplicate detection
Date:   Thu, 9 Feb 2023 19:42:53 +0800
Message-ID: <20230209114253.120485-3-wanghuizhao1@huawei.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20230209114253.120485-1-wanghuizhao1@huawei.com>
References: <20230209114253.120485-1-wanghuizhao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.136.158]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500007.china.huawei.com (7.221.188.207)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When semodule -i some.pp to install a module package, duplicate items are
detected for the module. The detection function is nodups_specs in
libselinux/src/label_file.c. The algorithm complexity of implementing
this function is O(N^2). In scenarios where N is very large, the efficiency
is very low.

To solve this problem, I propose to use the hash table to detect duplicates.
The algorithm complexity of new implementing is O(N). The execution efficiency
will be greatly improved.

Comparison between the execution time of the nodups_specs function.

Old double-layer loop implementation O(N^2):

semodule -i myapp1.pp
nodups_specs data->nspec: 5002
nodups_specs start: 11785.242s
nodups_specs end:   11785.588s
nodups_specs consumes:  0.346s

semodule -i myapp2.pp
nodups_specs data->nspec: 10002
nodups_specs start: 11804.280s
nodups_specs end:   11806.546s
nodups_specs consumes:  2.266s

semodule -i myapp3.pp
nodups_specs data->nspec: 20002
nodups_specs start: 11819.106s
nodups_specs end:   11830.892s
nodups_specs consumes: 11.786s

New hash table implementation O(N):

semodule -i myapp1.pp
nodups_specs data->nspec: 5002
nodups_specs start: 11785.588s
nodups_specs end:   11785.590s
nodups_specs consumes:  0.002s

semodule -i myapp2.pp
nodups_specs data->nspec: 10002
nodups_specs start: 11806.546s
nodups_specs end:   11806.552s
nodups_specs consumes:  0.006s

semodule -i myapp3.pp
nodups_specs data->nspec: 20002
nodups_specs start: 11830.892s
nodups_specs end:   11830.905s
nodups_specs consumes:  0.013s

Signed-off-by: wanghuizhao <wanghuizhao1@huawei.com>
---
 libselinux/src/label_file.c | 112 ++++++++++++++++++++++++++++++++++----------
 libselinux/src/label_file.h |   5 ++
 2 files changed, 93 insertions(+), 24 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 74ae9b9f..e4a85043 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -19,6 +19,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 
+#include "hashtab.h"
 #include "callbacks.h"
 #include "label_internal.h"
 #include "label_file.h"
@@ -57,40 +58,103 @@ static int find_stem_from_file(struct saved_data *data, const char *key)
 }
 
 /*
+ * hash calculation and key comparison of hash table
+ */
+
+static unsigned int symhash(hashtab_t h, const_hashtab_key_t key)
+{
+	const struct chkdups_key *k = (const struct chkdups_key *)key;
+	const char *p = NULL;
+	size_t size;
+	unsigned int val = 0;
+
+	size = strlen(k->regex);
+	for (p = k->regex; ((size_t) (p - k->regex)) < size; p++)
+		val =
+			(val << 4 | (val >> (8 * sizeof(unsigned int) - 4)) +
+			k->mode) ^ (*p);
+	return val % h->size;
+}
+
+static int symcmp(hashtab_t h
+		  __attribute__ ((unused)), const_hashtab_key_t key1,
+		  const_hashtab_key_t key2)
+{
+	const struct chkdups_key *a = (const struct chkdups_key *)key1;
+	const struct chkdups_key *b = (const struct chkdups_key *)key2;
+
+	return strcmp(a->regex, b->regex) || (a->mode && b->mode && a->mode != b->mode);
+}
+
+/*
  * Warn about duplicate specifications.
  */
 static int nodups_specs(struct saved_data *data, const char *path)
 {
-	int rc = 0;
-	unsigned int ii, jj;
+	int rc = 0, ret = 0;
+	unsigned int ii;
 	struct spec *curr_spec, *spec_arr = data->spec_arr;
+	struct chkdups_key *new = NULL;
+	unsigned int hashtab_len = (data->nspec / 10) ? data->nspec / 10 : 1;
+	hashtab_ptr_t cur, temp;
 
+	hashtab_t hash_table = hashtab_create(symhash, symcmp, data->nspec);
+	if (hash_table == NULL) {
+		rc = -1;
+		COMPAT_LOG(SELINUX_ERROR, "%s: hashtab create failed.\n", path);
+		return rc;
+	}
 	for (ii = 0; ii < data->nspec; ii++) {
-		curr_spec = &spec_arr[ii];
-		for (jj = ii + 1; jj < data->nspec; jj++) {
-			if ((!strcmp(spec_arr[jj].regex_str,
-				curr_spec->regex_str))
-			    && (!spec_arr[jj].mode || !curr_spec->mode
-				|| spec_arr[jj].mode == curr_spec->mode)) {
-				rc = -1;
-				errno = EINVAL;
-				if (strcmp(spec_arr[jj].lr.ctx_raw,
-					    curr_spec->lr.ctx_raw)) {
-					COMPAT_LOG
-						(SELINUX_ERROR,
-						 "%s: Multiple different specifications for %s  (%s and %s).\n",
-						 path, curr_spec->regex_str,
-						 spec_arr[jj].lr.ctx_raw,
-						 curr_spec->lr.ctx_raw);
-				} else {
-					COMPAT_LOG
-						(SELINUX_ERROR,
-						 "%s: Multiple same specifications for %s.\n",
-						 path, curr_spec->regex_str);
-				}
+		new = (struct chkdups_key *)malloc(sizeof(struct chkdups_key));
+		new->regex = spec_arr[ii].regex_str;
+		new->mode = spec_arr[ii].mode;
+		ret = hashtab_insert(hash_table, (hashtab_key_t)new, &spec_arr[ii]);
+		if (ret == HASHTAB_SUCCESS)
+			continue;
+		if (ret == HASHTAB_PRESENT) {
+			curr_spec =
+				(struct spec *)hashtab_search(hash_table, (hashtab_key_t)new);
+			rc = -1;
+			errno = EINVAL;
+			if (strcmp(spec_arr[ii].lr.ctx_raw, curr_spec->lr.ctx_raw)) {
+				COMPAT_LOG
+					(SELINUX_ERROR,
+					 "%s: Multiple different specifications for %s  (%s and %s).\n",
+					 path, curr_spec->regex_str,
+					 spec_arr[ii].lr.ctx_raw,
+					 curr_spec->lr.ctx_raw);
+			} else {
+				COMPAT_LOG
+					(SELINUX_ERROR,
+					 "%s: Multiple same specifications for %s.\n",
+					 path, curr_spec->regex_str);
 			}
 		}
+		if (ret == HASHTAB_OVERFLOW) {
+			rc = -1;
+			COMPAT_LOG
+				(SELINUX_ERROR,
+				"%s: hashtab happen memory error.\n",
+				path);
+			break;
+		}
+	}
+
+	for (ii = 0; ii < hashtab_len; ii++) {
+		cur = hash_table->htable[ii];
+		while (cur != NULL) {
+			temp = cur;
+			cur = cur->next;
+			free(temp->key);
+			free(temp);
+		}
+		hash_table->htable[ii] = NULL;
 	}
+
+	free(hash_table->htable);
+	hash_table->htable = NULL;
+	free(hash_table);
+
 	return rc;
 }
 
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 190bc175..ad79319e 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -35,6 +35,11 @@
 /* Required selinux_restorecon and selabel_get_digests_all_partial_matches() */
 #define RESTORECON_PARTIAL_MATCH_DIGEST  "security.sehash"
 
+struct chkdups_key {
+	char *regex;
+	unsigned int mode;
+};
+
 struct selabel_sub {
 	char *src;
 	int slen;
-- 
2.12.3

