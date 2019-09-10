Return-Path: <SRS0=Wrvk=XF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E4CC49ED9
	for <selinux@archiver.kernel.org>; Tue, 10 Sep 2019 19:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DDC21479
	for <selinux@archiver.kernel.org>; Tue, 10 Sep 2019 19:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="0DURIV/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfIJTx5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Sep 2019 15:53:57 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42291 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbfIJTx5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Sep 2019 15:53:57 -0400
Received: by mail-qk1-f193.google.com with SMTP id f13so18321631qkm.9
        for <selinux@vger.kernel.org>; Tue, 10 Sep 2019 12:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5bB7ct1Ha8IVWF8kk4mdmwUis8cZZC7VEpfu3PLZuI0=;
        b=0DURIV/EeitpnMzKzm8QWb2SoN8+4TN3q6brmBGvddBbgs6dCjo3JbIoYI4vi01UqL
         sPqR9eHarqJVMC7ChVhp9DuaTyj0Xj621NzdRdb4dWCLheptsQAjnKA8sjXPCFzpPnpb
         y/yMAN5ozL5VZJvFgoBPQ37h1FMk5fAAj126Bnl/9/VirxElnKkDOXSKiKe3VF/4J6c2
         bR4xNbDlHMVpH3rrhnNNvnLzpL4ENcrxQ3z4ZzNJxtOok9wliMX8+11lFZcjbBrPxjoU
         txbz7oC9s2ODp2hk1fr3iuQjZAhCZXmS1rE3GVv3Dx3fsFpwcJFO+FItt4Par5Rf27uT
         MzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5bB7ct1Ha8IVWF8kk4mdmwUis8cZZC7VEpfu3PLZuI0=;
        b=a972ZnqfKb/+VIq0xfDKme+2O2xZ0diHmkcpaSKoesqmkdhn7J0sFNc0rVG1mzGWIx
         a7BVLsxnFNRZ2cPjC73+yXt8ZF2emRgIdN0LadSV/No2jLuQXJ/7ABVKb8y7p/1hfxcr
         +5eG/WG49RmeMWiAwIHD2slliniHCo8KpcQTjCUToaP8Jc0RJZXah+n64PCvHVlPUkYk
         i0jBhkD0/r/pnSAE5atHnsRsQNIm1+0aEgBguExu11TAII8Y7iEQRZVnZ+sB3BY++sIw
         fGgme2NQjdxGWYVnN7PcMTxWFIf/cZkx+Qj+k0HkiUFb9kLXizvzWdewzOP37UiSI4m/
         emmw==
X-Gm-Message-State: APjAAAX6uzt0QOQVl3AhSxrOJ032scUc42gJQCAkRLAd7JuZV+HqXddb
        ImX5f+5zIRlKHB3TQ9bbvt6Ggv2wxwRrsw==
X-Google-Smtp-Source: APXvYqzWjNp7soUI8tj8+PUQNqRwuHpzSzJQoQdFZyh3vVWg3S/OiIgXSWh/4F5i2qa4IcScxtr2yw==
X-Received: by 2002:a37:8b46:: with SMTP id n67mr31910091qkd.36.1568145236052;
        Tue, 10 Sep 2019 12:53:56 -0700 (PDT)
Received: from localhost.localdomain (c-69-250-100-181.hsd1.md.comcast.net. [69.250.100.181])
        by smtp.gmail.com with ESMTPSA id x55sm12216476qta.74.2019.09.10.12.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 12:53:55 -0700 (PDT)
From:   Mike Palmiotto <mike.palmiotto@crunchydata.com>
To:     selinux@vger.kernel.org
Cc:     Mike Palmiotto <mike.palmiotto@crunchydata.com>
Subject: [PATCH] libselinux: fix string conversion of unknown perms
Date:   Tue, 10 Sep 2019 15:53:53 -0400
Message-Id: <20190910195353.973-1-mike.palmiotto@crunchydata.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit c19395d72295f5e69275d98df5db22dfdf214b6c fixed some handling of unknown
classes/permissions, but missed the case where an unknown permission is loaded
and then subsequently logged, either via denial or auditallow. If a permission
set has some valid values mixed with unknown values, say `{ read write foo }`,
a check on `{ read write foo }` would fail to log the entire set.

To fix this, skip over the bad permissions/classes when expanding them to
strings. The unknowns should be logged during `selinux_set_mapping`, so
there is no need for further logging of the actual unknown permissions.

Signed-off-by: Mike Palmiotto <mike.palmiotto@crunchydata.com>
---
 libselinux/src/stringrep.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
index ad29f76d..85579422 100644
--- a/libselinux/src/stringrep.c
+++ b/libselinux/src/stringrep.c
@@ -276,19 +276,15 @@ int security_av_string(security_class_t tclass, access_vector_t av, char **res)
 	char *ptr;
 
 	/* first pass computes the required length */
-	while (tmp) {
+	for (i = 0; tmp; tmp >>= 1, i++) {
 		if (tmp & 1) {
 			str = security_av_perm_to_string(tclass, av & (1<<i));
-			if (str)
-				len += strlen(str) + 1;
-			else {
-				rc = -1;
-				errno = EINVAL;
-				goto out;
+			if (!str) {
+				continue;
 			}
+
+			len += strlen(str) + 1;
 		}
-		tmp >>= 1;
-		i++;
 	}
 
 	*res = malloc(len);
@@ -298,7 +294,6 @@ int security_av_string(security_class_t tclass, access_vector_t av, char **res)
 	}
 
 	/* second pass constructs the string */
-	i = 0;
 	tmp = av;
 	ptr = *res;
 
@@ -308,12 +303,13 @@ int security_av_string(security_class_t tclass, access_vector_t av, char **res)
 	}
 
 	ptr += sprintf(ptr, "{ ");
-	while (tmp) {
-		if (tmp & 1)
-			ptr += sprintf(ptr, "%s ", security_av_perm_to_string(
-					       tclass, av & (1<<i)));
-		tmp >>= 1;
-		i++;
+	for (i = 0; tmp; tmp >>= 1, i++) {
+		if (tmp & 1) {
+			str = security_av_perm_to_string(tclass, av & (1<<i));
+			if (str) {
+				ptr += sprintf(ptr, "%s ", str);
+			}
+		}
 	}
 	sprintf(ptr, "}");
 out:
-- 
2.21.0

