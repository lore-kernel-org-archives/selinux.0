Return-Path: <SRS0=qBB/=XL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6181AC49ED7
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 20:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354EC206C2
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 20:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="xgT3om87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403811AbfIPUad (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Sep 2019 16:30:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43354 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730543AbfIPUad (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Sep 2019 16:30:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id c3so1485765qtv.10
        for <selinux@vger.kernel.org>; Mon, 16 Sep 2019 13:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TcjS+uGbc8hrSyqGiZ8oMpan1A8jnmMdICDKTgGAJrI=;
        b=xgT3om87BLgOyxv7wVl3o9veJzZT8xHW9sO/Ap1IflKLk2qzfa907hEUuqObrLt67J
         42uyJgXHD09vLoGd0dqbP3J8ot2Pq3ZG2dXAg0vw1m8Tcxi9Zl1oN8GYIv2NjM7K2Gao
         W+I3YsGlfiKCua/aSZUaKmM+ENsrG56b0S2Ftc3wxg1MrkMsrYIxwZxZ0e/QxPUT34z8
         nVHTJqO9OCaA5gnZEdi3QKZjxJUJSnqZcwsxNcrESbUivUUMneoMMxFmDi4Xwek5ptwu
         Pvf5xj5fiiLRgi5vJyNrzQ9t8ob7ETwS6Uh7IFo44fufnvt5RbR7SUu12HOYV7Ck7Fdj
         WPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TcjS+uGbc8hrSyqGiZ8oMpan1A8jnmMdICDKTgGAJrI=;
        b=eDuVu3n/s7P8EVYYIVxwV3VnEZ7hgEw7xJ/m3nhLXT110ve9ybVtiRLpWj5c4MNTIB
         PaloomR6iaz/PlY55tfzrNyaNtCLx+yHK/D0RP73t7iCxZovFvP60crUt491KG7SP0Kh
         hQNLfggZOHyTOl4h6fBDh3LMl7S6OB6vU3N6Flk5kkktlOscPZUle8x2hMUWxmlf5bDo
         aTYS+abaSiIvYn0IgCsfJOg99vsybJdSftQRiQ/PlPuc3Hyv0mPx0hdxMrpVXh8AKoiO
         KpaOusRjhGKmujxlvuC47z8Lu+x/dxWR+7U4oZ+xzneDh3v797zobf5z3bJ+cyb70/Q6
         dviw==
X-Gm-Message-State: APjAAAVL1HO64GcY0MM914r3Ih2u00/YEOJKXRQ1cnnB2wpiXpT0nItq
        a/36X+r+nZJWEN+DLOFWLXrVZKhcc7ZXFw==
X-Google-Smtp-Source: APXvYqwbc3SAHSHCD7KzrApY90usZE+OJjzhSQv7haHDWP2zR5LPwmCpb/pei6V3uVJTtzgqizpIOA==
X-Received: by 2002:a0c:e089:: with SMTP id l9mr130297qvk.117.1568665830656;
        Mon, 16 Sep 2019 13:30:30 -0700 (PDT)
Received: from localhost.localdomain (c-69-250-100-181.hsd1.md.comcast.net. [69.250.100.181])
        by smtp.gmail.com with ESMTPSA id 54sm46924qts.75.2019.09.16.13.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:30:29 -0700 (PDT)
From:   Mike Palmiotto <mike.palmiotto@crunchydata.com>
To:     selinux@vger.kernel.org
Cc:     sds@tycho.nsa.gov, Mike Palmiotto <mike.palmiotto@crunchydata.com>
Subject: [PATCH v2] libselinux: fix string conversion of unknown perms
Date:   Mon, 16 Sep 2019 16:30:15 -0400
Message-Id: <20190916203015.19474-1-mike.palmiotto@crunchydata.com>
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
 libselinux/src/stringrep.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
index ad29f76d..b9bf3ee6 100644
--- a/libselinux/src/stringrep.c
+++ b/libselinux/src/stringrep.c
@@ -268,7 +268,7 @@ const char *security_av_perm_to_string(security_class_t tclass,
 
 int security_av_string(security_class_t tclass, access_vector_t av, char **res)
 {
-	unsigned int i = 0;
+	unsigned int i;
 	size_t len = 5;
 	access_vector_t tmp = av;
 	int rc = 0;
@@ -276,19 +276,12 @@ int security_av_string(security_class_t tclass, access_vector_t av, char **res)
 	char *ptr;
 
 	/* first pass computes the required length */
-	while (tmp) {
+	for (i = 0; tmp; tmp >>= 1, i++) {
 		if (tmp & 1) {
 			str = security_av_perm_to_string(tclass, av & (1<<i));
 			if (str)
 				len += strlen(str) + 1;
-			else {
-				rc = -1;
-				errno = EINVAL;
-				goto out;
-			}
 		}
-		tmp >>= 1;
-		i++;
 	}
 
 	*res = malloc(len);
@@ -298,7 +291,6 @@ int security_av_string(security_class_t tclass, access_vector_t av, char **res)
 	}
 
 	/* second pass constructs the string */
-	i = 0;
 	tmp = av;
 	ptr = *res;
 
@@ -308,12 +300,12 @@ int security_av_string(security_class_t tclass, access_vector_t av, char **res)
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
+			if (str)
+				ptr += sprintf(ptr, "%s ", str);
+		}
 	}
 	sprintf(ptr, "}");
 out:
-- 
2.21.0

