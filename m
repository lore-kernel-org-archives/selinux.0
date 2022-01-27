Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34251C433F5
	for <selinux@archiver.kernel.org>; Thu, 27 Jan 2022 13:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241542AbiA0NHq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jan 2022 08:07:46 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:53708 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241593AbiA0NHq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jan 2022 08:07:46 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DDCC3218B8
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 13:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643288864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YdCzPeYWmPETgnnd3YuL72i4NyU4AVGoeFiGtQl9V1Y=;
        b=K0ZHmbQvgQ/C/PZOkRkRkKZLCcHfsWkszuSoq53B+5vYP4+dX6VgE3JNAQaRUYVV1K5WW0
        LY1oSsC3/+3jxiBYbvDINnxFNHF/6mcPIixqGh+lc6NpHJL/QJ4AlFQRoHACi/ubcAcNqE
        4A71iQqLCudM6PNSWlDrUVBIpRfZUmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643288864;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YdCzPeYWmPETgnnd3YuL72i4NyU4AVGoeFiGtQl9V1Y=;
        b=AwatpBC0RNDQqtGm6+ANLRfq1GLk8I+UYOE5+/gsB0wIWv+CAVZXyG5J9QwEUg1cHlpYZc
        8ESngf256/HtUjDg==
Received: from localhost.localdomain (unknown [10.163.42.222])
        by relay2.suse.de (Postfix) with ESMTP id C6BF1A3B81;
        Thu, 27 Jan 2022 13:07:44 +0000 (UTC)
From:   Johannes Segitz <jsegitz@suse.de>
To:     selinux@vger.kernel.org
Cc:     Johannes Segitz <jsegitz@suse.de>
Subject: [PATCH] libselinux: Prevent cached context giving wrong results
Date:   Thu, 27 Jan 2022 14:07:41 +0100
Message-Id: <20220127130741.31940-1-jsegitz@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The procattr cache doesn't work properly in all cases. This fixes the issue at
the cost of not using the cache as soon as a pid is specified.

In most use cases this will never occur, but it's still a small security issue,
since this incorrect information might lead to incorrect access decisions.

Signed-off-by: Johannes Segitz <jsegitz@suse.de>
---
 libselinux/src/procattr.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
index 142fbf3a..4ca8337a 100644
--- a/libselinux/src/procattr.c
+++ b/libselinux/src/procattr.c
@@ -148,7 +148,7 @@ static int getprocattrcon_raw(char ** context,
 			return -1;
 	}
 
-	if (prev_context && prev_context != UNSET) {
+	if (pid == 0 && prev_context && prev_context != UNSET) {
 		*context = strdup(prev_context);
 		if (!(*context)) {
 			return -1;
@@ -242,9 +242,9 @@ static int setprocattrcon_raw(const char * context,
 			return -1;
 	}
 
-	if (!context && !*prev_context)
+	if (pid == 0 && !context && !*prev_context)
 		return 0;
-	if (context && *prev_context && *prev_context != UNSET
+	if (pid == 0 && context && *prev_context && *prev_context != UNSET
 	    && !strcmp(context, *prev_context))
 		return 0;
 
@@ -272,9 +272,11 @@ out:
 		free(context2);
 		return -1;
 	} else {
-		if (*prev_context != UNSET)
-			free(*prev_context);
-		*prev_context = context2;
+		if (pid == 0) {
+			if (*prev_context != UNSET)
+				free(*prev_context);
+			*prev_context = context2;
+		}
 		return 0;
 	}
 }
-- 
2.31.1

