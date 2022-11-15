Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2AAC433FE
	for <selinux@archiver.kernel.org>; Tue, 15 Nov 2022 14:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiKOOiL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Nov 2022 09:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiKOOiK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Nov 2022 09:38:10 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB9C140DB
        for <selinux@vger.kernel.org>; Tue, 15 Nov 2022 06:38:08 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NBTKs1dp7zHvsy
        for <selinux@vger.kernel.org>; Tue, 15 Nov 2022 22:37:37 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 22:38:07 +0800
Received: from huawei.com (10.175.104.170) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 15 Nov
 2022 22:38:06 +0800
From:   Jie Lu <lujie54@huawei.com>
To:     <selinux@vger.kernel.org>
Subject: [PATCH] libselinux: fix memory leaks on the audit2why module init
Date:   Tue, 15 Nov 2022 20:05:45 +0800
Message-ID: <20221115120545.2650881-1-lujie54@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Jie Lu <lujie54@huawei.com>
---
 libselinux/src/audit2why.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index 44a9a341..ba1a66eb 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -191,7 +191,7 @@ static PyObject *finish(PyObject *self __attribute__((unused)), PyObject *args)
 
 static int __policy_init(const char *init_path)
 {
-	FILE *fp;
+	FILE *fp = NULL;
 	const char *curpolicy;
 	char errormsg[PATH_MAX+1024+20];
 	struct sepol_policy_file *pf = NULL;
@@ -235,18 +235,17 @@ static int __policy_init(const char *init_path)
 		snprintf(errormsg, sizeof(errormsg), 
 			 "policydb_init failed: %m\n");
 		PyErr_SetString( PyExc_RuntimeError, errormsg);
-		fclose(fp);
-		return 1;
+		goto err;
 	}
 	sepol_policy_file_set_fp(pf, fp);	
 	if (sepol_policydb_read(avc->policydb, pf)) {
 		snprintf(errormsg, sizeof(errormsg), 
 			 "invalid binary policy %s\n", curpolicy);
 		PyErr_SetString( PyExc_ValueError, errormsg);
-		fclose(fp);
-		return 1;
+		goto err;
 	}
 	fclose(fp);
+	fp = NULL;
 	sepol_set_policydb(&avc->policydb->p);
 	avc->handle = sepol_handle_create();
 	/* Turn off messages */
@@ -256,13 +255,13 @@ static int __policy_init(const char *init_path)
 			      avc->policydb, &cnt);
 	if (rc < 0) {
 		PyErr_SetString( PyExc_RuntimeError, "unable to get bool count\n");
-		return 1;
+		goto err;
 	}
 
 	boollist = calloc(cnt, sizeof(*boollist));
 	if (!boollist) {
 		PyErr_SetString( PyExc_MemoryError, "Out of memory\n");
-		return 1;
+		goto err;
 	}
 
 	sepol_bool_iterate(avc->handle, avc->policydb,
@@ -273,11 +272,26 @@ static int __policy_init(const char *init_path)
 	rc = sepol_sidtab_init(&sidtab);
 	if (rc < 0) {
 		PyErr_SetString( PyExc_RuntimeError, "unable to init sidtab\n");
-		free(boollist);
-		return 1;
+		goto err;
 	}
 	sepol_set_sidtab(&sidtab);
 	return 0;
+
+err:
+	if (boollist)
+		free(boollist);
+	if (avc){
+		if (avc->handle)
+			sepol_handle_destroy(avc->handle);
+		if (avc->policydb)
+			sepol_policydb_free(avc->policydb);
+		free(avc);
+	}
+	if (pf)
+		sepol_policy_file_free(pf);
+	if (fp)
+		fclose(fp);
+	return 1;
 }
 
 static PyObject *init(PyObject *self __attribute__((unused)), PyObject *args) {
-- 
2.27.0

