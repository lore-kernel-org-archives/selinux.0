Return-Path: <SRS0=JPc9=QH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A1BC169C4
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 13:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD979218D3
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 13:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387416AbfAaNWj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:22:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733302AbfAaNWj (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 31 Jan 2019 08:22:39 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 73B989D51C
        for <selinux@vger.kernel.org>; Thu, 31 Jan 2019 13:22:39 +0000 (UTC)
Received: from workstation.redhat.com (unknown [10.40.205.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB9AB60BF7;
        Thu, 31 Jan 2019 13:22:38 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH 3/3] libsemanage: Fix USE_AFTER_FREE defects reported by coverity scan
Date:   Thu, 31 Jan 2019 14:22:26 +0100
Message-Id: <20190131132226.19030-3-plautrba@redhat.com>
In-Reply-To: <20190131132226.19030-1-plautrba@redhat.com>
References: <20190131132226.19030-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 31 Jan 2019 13:22:39 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libsemanage/src/direct_api.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index c58961be..8e4d116d 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1028,7 +1028,7 @@ static int semanage_direct_write_langext(semanage_handle_t *sh,
 
 	fp = NULL;
 
-	ret = 0;
+	return 0;
 
 cleanup:
 	if (fp != NULL) fclose(fp);
@@ -2177,7 +2177,6 @@ cleanup:
 	semanage_module_info_destroy(sh, modinfo);
 	free(modinfo);
 
-	if (fp != NULL) fclose(fp);
 	return status;
 }
 
@@ -2342,16 +2341,6 @@ static int semanage_direct_get_module_info(semanage_handle_t *sh,
 	free(tmp);
 	tmp = NULL;
 
-	if (fclose(fp) != 0) {
-		ERR(sh,
-		    "Unable to close %s module lang ext file.",
-		    (*modinfo)->name);
-		status = -1;
-		goto cleanup;
-	}
-
-	fp = NULL;
-
 	/* lookup enabled/disabled status */
 	ret = semanage_module_get_path(sh,
 				       *modinfo,
@@ -2395,7 +2384,13 @@ cleanup:
 		free(modinfos);
 	}
 
-	if (fp != NULL) fclose(fp);
+	if (fp != NULL && fclose(fp) != 0) {
+		ERR(sh,
+		    "Unable to close %s module lang ext file.",
+		    (*modinfo)->name);
+		status = -1;
+	}
+
 	return status;
 }
 
-- 
2.20.1

