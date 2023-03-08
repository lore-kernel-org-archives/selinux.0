Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5441BC64EC4
	for <selinux@archiver.kernel.org>; Wed,  8 Mar 2023 09:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjCHJxj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Mar 2023 04:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCHJxV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Mar 2023 04:53:21 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A38580DA
        for <selinux@vger.kernel.org>; Wed,  8 Mar 2023 01:53:18 -0800 (PST)
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PWnfj6TP4zrS1t;
        Wed,  8 Mar 2023 17:52:29 +0800 (CST)
Received: from Linux-SUSE12SP5.huawei.com (10.67.136.158) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 17:53:15 +0800
From:   wanghuizhao <wanghuizhao1@huawei.com>
To:     <selinux@vger.kernel.org>
CC:     <cgzones@googlemail.com>, <lautrbach@redhat.com>,
        <jwcart2@gmail.com>, <jason@perfinion.com>,
        <weiyuchen3@huawei.com>, <wanghuizhao1@huawei.com>
Subject: [PATCH v3 3/3] libselinux: performance optimization for duplicate detection
Date:   Wed, 8 Mar 2023 17:53:08 +0800
Message-ID: <20230308095308.60661-4-wanghuizhao1@huawei.com>
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

When semodule -i some.pp to install a module package, duplicate items are
detected for the module. The detection function is nodups_specs in
libselinux/src/label_file.c. The algorithm complexity of implementing
this function is O(M*(N^2)). M is a symbol related to the length of a string.
N indicates the number of data->nspec. In scenarios where N is very large, the
efficiency is very low.

To solve this problem, I propose to use the hash table to detect duplicates.
The algorithm complexity of new implementing is O(M*N). The execution
efficiency will be greatly improved.

Comparison between the execution time of the nodups_specs function.

Old double-layer loop implementation O(M*(N^2)):

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

New hash table implementation O(M*N):

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
 libselinux/src/label_file.c | 120 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 96 insertions(+), 24 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 74ae9b9f..d489c1f7 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -19,10 +19,19 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 
+#include "hashtab.h"
 #include "callbacks.h"
 #include "label_internal.h"
 #include "label_file.h"
 
+/* controls the shrink multiple of the hashtab length */
+#define SHRINK_MULTIS 1
+
+struct chkdups_key {
+	char *regex;
+	unsigned int mode;
+};
+
 /*
  * Internals, mostly moved over from matchpathcon.c
  */
@@ -57,40 +66,103 @@ static int find_stem_from_file(struct saved_data *data, const char *key)
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
+			((val << 4) | (val >> (8 * sizeof(unsigned int) - 4))) ^ (*p);
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
+static int destroy_chkdups_key(hashtab_key_t key)
+{
+	free(key);
+
+	return 0;
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
+	unsigned int hashtab_len = (data->nspec / SHRINK_MULTIS) ? data->nspec / SHRINK_MULTIS : 1;
 
+	hashtab_t hash_table = hashtab_create(symhash, symcmp, hashtab_len);
+	if (!hash_table) {
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
+		if (!new) {
+			rc = -1;
+			hashtab_destroy_key(hash_table, destroy_chkdups_key);
+			COMPAT_LOG(SELINUX_ERROR, "%s: hashtab key create failed.\n", path);
+			return rc;
+		}
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
+			free(new);
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
+			free(new);
+			COMPAT_LOG
+				(SELINUX_ERROR,
+				"%s: hashtab happen memory error.\n",
+				path);
+			break;
+		}
 	}
+
+	hashtab_destroy_key(hash_table, destroy_chkdups_key);
+
 	return rc;
 }
 
-- 
2.12.3

