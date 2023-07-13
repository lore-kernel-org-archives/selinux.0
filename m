Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D800EB64DD
	for <selinux@archiver.kernel.org>; Thu, 13 Jul 2023 09:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjGMJG4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Jul 2023 05:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbjGMJGK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Jul 2023 05:06:10 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE81359F
        for <selinux@vger.kernel.org>; Thu, 13 Jul 2023 02:05:21 -0700 (PDT)
Received: from kwepemm600010.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R1pZz73x4z18Lrt
        for <selinux@vger.kernel.org>; Thu, 13 Jul 2023 17:04:43 +0800 (CST)
Received: from localhost.localdomain (10.175.104.170) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 17:05:19 +0800
From:   Huaxin Lu <luhuaxin1@huawei.com>
To:     <selinux@vger.kernel.org>
CC:     <shenyining@huawei.com>, <fangxiuning@huawei.com>,
        <zhujianwei7@huawei.com>
Subject: [PATCH] secilc: add check for malloc in secilc
Date:   Thu, 13 Jul 2023 14:35:04 +0800
Message-ID: <20230713063504.161485-1-luhuaxin1@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Check the return value of malloc() to avoid null pointer reference.

Signed-off-by: Huaxin Lu <luhuaxin1@huawei.com>
---
 secilc/secil2conf.c | 6 ++++++
 secilc/secil2tree.c | 6 ++++++
 secilc/secilc.c     | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/secilc/secil2conf.c b/secilc/secil2conf.c
index c49522e..bf050f3 100644
--- a/secilc/secil2conf.c
+++ b/secilc/secil2conf.c
@@ -152,6 +152,12 @@ int main(int argc, char *argv[])
 		file_size = filedata.st_size;
 
 		buffer = malloc(file_size);
+		if (!buffer) {
+			fprintf(stderr, "Out of memory\n");
+			rc = SEPOL_ERR;
+			goto exit;
+		}
+
 		rc = fread(buffer, file_size, 1, file);
 		if (rc != 1) {
 			fprintf(stderr, "Failure reading file: %s\n", argv[i]);
diff --git a/secilc/secil2tree.c b/secilc/secil2tree.c
index e5cdf6b..d04566d 100644
--- a/secilc/secil2tree.c
+++ b/secilc/secil2tree.c
@@ -158,6 +158,12 @@ int main(int argc, char *argv[])
 		file_size = filedata.st_size;
 
 		buffer = malloc(file_size);
+		if (!buffer) {
+			fprintf(stderr, "Out of memory\n");
+			rc = SEPOL_ERR;
+			goto exit;
+		}
+
 		rc = fread(buffer, file_size, 1, file);
 		if (rc != 1) {
 			fprintf(stderr, "Failure reading file: %s\n", argv[i]);
diff --git a/secilc/secilc.c b/secilc/secilc.c
index 80d3583..f3102ca 100644
--- a/secilc/secilc.c
+++ b/secilc/secilc.c
@@ -286,6 +286,12 @@ int main(int argc, char *argv[])
 		}
 
 		buffer = malloc(file_size);
+		if (!buffer) {
+			fprintf(stderr, "Out of memory\n");
+			rc = SEPOL_ERR;
+			goto exit;
+		}
+
 		rc = fread(buffer, file_size, 1, file);
 		if (rc != 1) {
 			fprintf(stderr, "Failure reading file: %s\n", argv[i]);
-- 
2.33.0

