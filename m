Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BBCEB64D9
	for <selinux@archiver.kernel.org>; Thu,  6 Jul 2023 13:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjGFNwd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Jul 2023 09:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjGFNw3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Jul 2023 09:52:29 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74831996
        for <selinux@vger.kernel.org>; Thu,  6 Jul 2023 06:52:27 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51d89664272so1074175a12.1
        for <selinux@vger.kernel.org>; Thu, 06 Jul 2023 06:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688651546; x=1691243546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KCwgolCTPz4ikINXaVw+8FyyemVfUC86fa6HX/zS6tM=;
        b=a6fqispVaSecgisR/l2f1GIDhogrZlRIKBtEvRnejqXBpmHIlTJMvqWxKyOGm6zPkR
         GYUs+aJA29SeN7MVfkJrLyAtOCce55K/pX/h45yk50XBaIvbBGZz3eIRzIJOP4kC5+ZG
         O4gBDTE0r1LoKcdIwTZp63n4p9A4TUMVZvbL36y07jWBOWW/aNOtDKqSKEpv3lXdzBmI
         yQqgKRkhHlxjqMfGjnYxUogBs1BG/rkhOcsrPmdIGjwLgLgDSytzYof5cYSFEKteUltS
         mIprnFRit9dRiw+uOBZKzut/38Vx1g242ZgpY8QOHk9HGgMcxbHHkNSHEiSP6gPlqaif
         1RXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688651546; x=1691243546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KCwgolCTPz4ikINXaVw+8FyyemVfUC86fa6HX/zS6tM=;
        b=Gd65evDA4f1WAOVG/7Up7FItiqH3s3LIHEooZbnYol/f5qpgJOLQCnA0wIu4IRyjpx
         UxN3ff6ajmK6OnuqJ4Vwe/b16vic8QLqr6RBUe5TEz/2xJgMQ2EILk/EO4eiFE5zfwe0
         6+mPI19xES6+oAfTqw9Dnam27ciuSbyyb4cnvGebreUd00X4HYa8zbaMOEiO+eBvCXxR
         v1tWfHMR1lTzTD9X1KreE/NgW0qMI/O1+0owCvpIJ8MR992V00DDIz8bdun+vdUAkn2u
         a4uHON66B3LnMtTqsps+9ZYvI5SeqKAprdqVM+QLVTCKzjavQRAJHOx15kojcpRdCw+t
         go3A==
X-Gm-Message-State: ABy/qLajJYD3/PGI2ebY6yPRG87C4LegvN58r7fXT1CogqPmy/ACOl8K
        Fwq6MxUTz493ic9RPhHS9gZgpmOhadysWruT
X-Google-Smtp-Source: APBJJlG8mBpeZ973A3JB8/tVMOqT8CJAm3EQaiYHlUWcVyuSkU5OgjAfpqem+7qsmzECdVqkA5GSjQ==
X-Received: by 2002:aa7:c484:0:b0:51d:e7b5:547d with SMTP id m4-20020aa7c484000000b0051de7b5547dmr1776344edq.34.1688651546145;
        Thu, 06 Jul 2023 06:52:26 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id f7-20020a056402068700b0051e24284fc8sm801860edy.12.2023.07.06.06.52.24
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:52:24 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: free initial sid names
Date:   Thu,  6 Jul 2023 15:52:21 +0200
Message-Id: <20230706135221.43544-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit 55b75a2c ("libsepol: stop translating deprecated intial SIDs to
strings") dropped several names of obsolete initial sids ans replaced
them with NULL.  This leads to their printable string being dynamically
allocated but not free'd.
Instead of keeping track of which name was allocated dynamically and
which not, allocate all on the heap, which simplifies the later cleanup.

While on it also free the name in case of a strs_add_at_index() failure.

Reported-by: oss-fuzz (issue 60271)
Fixes: 55b75a2c ("libsepol: stop translating deprecated intial SIDs to strings")

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_cil.c  | 18 ++++++++----------
 libsepol/src/kernel_to_conf.c | 16 +++++++---------
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index a3d8d139..8fcc385d 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -569,18 +569,19 @@ static int write_sids_to_cil(FILE *out, const char *const *sid_to_str,
 	for (isid = isids; isid != NULL; isid = isid->next) {
 		i = isid->sid[0];
 		if (i < num_sids && sid_to_str[i]) {
-			sid = (char *)sid_to_str[i];
+			sid = strdup(sid_to_str[i]);
 		} else {
 			snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
 			sid = strdup(unknown);
-			if (!sid) {
-				ERR(NULL, "Out of memory");
-				rc = -1;
-				goto exit;
-			}
+		}
+		if (!sid) {
+			ERR(NULL, "Out of memory");
+			rc = -1;
+			goto exit;
 		}
 		rc = strs_add_at_index(strs, sid, i);
 		if (rc != 0) {
+			free(sid);
 			goto exit;
 		}
 	}
@@ -611,10 +612,7 @@ static int write_sids_to_cil(FILE *out, const char *const *sid_to_str,
 	sepol_printf(out, "))\n");
 
 exit:
-	for (i=num_sids; i<strs_num_items(strs); i++) {
-		sid = strs_read_at_index(strs, i);
-		free(sid);
-	}
+	strs_free_all(strs);
 	strs_destroy(&strs);
 	if (rc != 0) {
 		ERR(NULL, "Error writing sid rules to CIL");
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 0710572d..b0ae16d9 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -466,17 +466,18 @@ static int write_sids_to_conf(FILE *out, const char *const *sid_to_str,
 	for (isid = isids; isid != NULL; isid = isid->next) {
 		i = isid->sid[0];
 		if (i < num_sids && sid_to_str[i]) {
-			sid = (char *)sid_to_str[i];
+			sid = strdup(sid_to_str[i]);
 		} else {
 			snprintf(unknown, sizeof(unknown), "%s%u", "UNKNOWN", i);
 			sid = strdup(unknown);
-			if (!sid) {
-				rc = -1;
-				goto exit;
-			}
+		}
+		if (!sid) {
+			rc = -1;
+			goto exit;
 		}
 		rc = strs_add_at_index(strs, sid, i);
 		if (rc != 0) {
+			free(sid);
 			goto exit;
 		}
 	}
@@ -490,10 +491,7 @@ static int write_sids_to_conf(FILE *out, const char *const *sid_to_str,
 	}
 
 exit:
-	for (i=num_sids; i<strs_num_items(strs); i++) {
-		sid = strs_read_at_index(strs, i);
-		free(sid);
-	}
+	strs_free_all(strs);
 	strs_destroy(&strs);
 	if (rc != 0) {
 		ERR(NULL, "Error writing sid rules to policy.conf");
-- 
2.40.1

