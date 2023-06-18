Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83B4EB64D7
	for <selinux@archiver.kernel.org>; Mon, 19 Jun 2023 02:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjFSCOt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 18 Jun 2023 22:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjFSCOt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 18 Jun 2023 22:14:49 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230391B8
        for <selinux@vger.kernel.org>; Sun, 18 Jun 2023 19:14:48 -0700 (PDT)
Received: from kwepemm600010.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QktZp4jR1zLmjy
        for <selinux@vger.kernel.org>; Mon, 19 Jun 2023 10:12:50 +0800 (CST)
Received: from localhost.localdomain (10.175.104.170) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 19 Jun 2023 10:14:45 +0800
From:   Huaxin Lu <luhuaxin1@huawei.com>
To:     <selinux@vger.kernel.org>
CC:     <shenyining@huawei.com>, <fangxiuning@huawei.com>,
        <zhujianwei7@huawei.com>
Subject: [PATCH] libselinux: fix inconsistent indentation in selinux_check_access
Date:   Mon, 19 Jun 2023 07:45:10 +0800
Message-ID: <20230618234510.118204-1-luhuaxin1@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Function selinux_check_access mixes up the TABs and spaces. Fix it
to keep the consistent coding style.

Signed-off-by: Huaxin Lu <luhuaxin1@huawei.com>
---
 libselinux/src/checkAccess.c | 42 ++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
index 022cd6b..7f0d68f 100644
--- a/libselinux/src/checkAccess.c
+++ b/libselinux/src/checkAccess.c
@@ -41,27 +41,27 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
 
 	(void) selinux_status_updated();
 
-       sclass = string_to_security_class(class);
-       if (sclass == 0) {
-	       rc = errno;
-	       avc_log(SELINUX_ERROR, "Unknown class %s", class);
-	       if (security_deny_unknown() == 0)
-		       return 0;
-	       errno = rc;
-	       return -1;
-       }
-
-       av = string_to_av_perm(sclass, perm);
-       if (av == 0) {
-	       rc = errno;
-	       avc_log(SELINUX_ERROR, "Unknown permission %s for class %s", perm, class);
-	       if (security_deny_unknown() == 0)
-		       return 0;
-	       errno = rc;
-	       return -1;
-       }
-
-       return avc_has_perm (scon_id, tcon_id, sclass, av, NULL, aux);
+	sclass = string_to_security_class(class);
+	if (sclass == 0) {
+		rc = errno;
+		avc_log(SELINUX_ERROR, "Unknown class %s", class);
+		if (security_deny_unknown() == 0)
+			return 0;
+		errno = rc;
+		return -1;
+	}
+
+	av = string_to_av_perm(sclass, perm);
+	if (av == 0) {
+		rc = errno;
+		avc_log(SELINUX_ERROR, "Unknown permission %s for class %s", perm, class);
+		if (security_deny_unknown() == 0)
+			return 0;
+		errno = rc;
+		return -1;
+	}
+
+	return avc_has_perm (scon_id, tcon_id, sclass, av, NULL, aux);
 }
 
 static int selinux_check_passwd_access_internal(access_vector_t requested)
-- 
2.33.0

