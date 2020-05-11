Return-Path: <SRS0=Gc5K=6Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFC7C47255
	for <selinux@archiver.kernel.org>; Mon, 11 May 2020 15:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47AF4206F5
	for <selinux@archiver.kernel.org>; Mon, 11 May 2020 15:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlOFA20W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgEKPBi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 May 2020 11:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726438AbgEKPBh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 May 2020 11:01:37 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D16CC061A0C
        for <selinux@vger.kernel.org>; Mon, 11 May 2020 08:01:37 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z90so8133113qtd.10
        for <selinux@vger.kernel.org>; Mon, 11 May 2020 08:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P0qcLYaitITjgbooGekfi5DbQhf81XSpW3k7wEtcCJw=;
        b=KlOFA20WKfBVefDlsHajUsZ1Q2MygBlJ5v901kLNhDjqWPtmzl1XbqFV+rK6oBXHpr
         Cz47LUJtDfzzAFMF5wSxk/qSW2nJFCYyA1jbZZ+5rDFeUkpTzA1vA0rMWBWwqXYl0e3w
         NsvrMUwg3N3bSGC2vOLrjIne6hyGlSFwzBXpx/Tq4KPWZ2kCb254f3vMCfBYB1P9p+SM
         B8HHbzbo7XwCB8vWqX1pqN0CbvEi3YQZ+FYPBAtfzE3ZX2fOcRYvZiE6coP9Lf4LANav
         wa7YNja6gngibxUfCzI57WRKeJLQ6/A+XrJ7aA0Qct04i+vdKhqOU+M+LolziJ5XufLA
         Fizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P0qcLYaitITjgbooGekfi5DbQhf81XSpW3k7wEtcCJw=;
        b=AvkFrUCb3utm+utNkWIuhrRW3gucexMmIdIQRMnDidC8e2nHGPOC5JbicjRo9gZJky
         iPONGAhj2Iw7Ocy6E/ggh9dYx0AoY8JEuYQvLzs1UOqSIvLWPkzIarNt0QfhoUhBJhRX
         DIjZMSECeLABFxL15uiCV0tD3OnNYrymXEfQikPeVApc24YvEYLRlAm/S7Ut2U4PtqNJ
         Eiao0kpsXKVNnHC7qZBdCVeC4rLsg47kBXqxrt48xMc4LgLVyiezCDteicFHV+8KWUfp
         w32N6+rL1wWuTvlfUFboyIrKCYAExWv/9zz/ziQ97OHK2POZAglstGO5hTSObp88KtNg
         siug==
X-Gm-Message-State: AGi0PubXl7zU4/O+VEaBFWBxCW+W0jCVpQoz/hq78a+IYlZnO1dxvCdv
        uo0zy90dwZr2htpHUfEt3os2E08m
X-Google-Smtp-Source: APiQypKwst8OoaBDnVGVjgPKcKjUVwuzVNBkOeQpuyRweusGB74Fm4Rx/pLaXBj0m5RzjBfqWoHVjQ==
X-Received: by 2002:ac8:3713:: with SMTP id o19mr16163354qtb.371.1589209296174;
        Mon, 11 May 2020 08:01:36 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id i24sm3606283qtm.85.2020.05.11.08.01.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2020 08:01:35 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 testsuite] tests/filesystem: fix quotas_test
Date:   Mon, 11 May 2020 11:01:18 -0400
Message-Id: <20200511150118.838-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.23.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

As per the man page, quotactl(2) expects to be passed a pointer to
a 4-byte buffer for Q_GETFMT.  The kernel copies a single u32 value.
On Ubuntu, this was detected as a stack smash when running the test.
Fix the test program.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 includes stdint.h and uses uint32_t for the fmtval variable.

 tests/filesystem/quotas_test.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tests/filesystem/quotas_test.c b/tests/filesystem/quotas_test.c
index 8359811..bca230d 100644
--- a/tests/filesystem/quotas_test.c
+++ b/tests/filesystem/quotas_test.c
@@ -1,3 +1,4 @@
+#include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -33,7 +34,7 @@ int main(int argc, char *argv[])
 	int opt, result, qcmd, save_err, test_id = geteuid();
 	char *context, *src = NULL, *tgt = NULL;
 	bool verbose = false;
-	char fmt_buf[2];
+	uint32_t fmtval;
 
 	while ((opt = getopt(argc, argv, "s:t:v")) != -1) {
 		switch (opt) {
@@ -77,7 +78,7 @@ int main(int argc, char *argv[])
 			printf("User Quota - ON\n");
 
 		qcmd = QCMD(Q_GETFMT, USRQUOTA);
-		result = quotactl(qcmd, src, test_id, fmt_buf);
+		result = quotactl(qcmd, src, test_id, (caddr_t)&fmtval);
 		save_err = errno;
 		if (result < 0) {
 			fprintf(stderr, "quotactl(Q_GETFMT, USRQUOTA) Failed: %s\n",
@@ -85,7 +86,7 @@ int main(int argc, char *argv[])
 			return save_err;
 		}
 		if (verbose)
-			printf("User Format: 0x%x\n", fmt_buf[0]);
+			printf("User Format: 0x%x\n", fmtval);
 
 		qcmd = QCMD(Q_QUOTAOFF, USRQUOTA);
 		result = quotactl(qcmd, src, QFMT_VFS_V0, tgt);
@@ -113,7 +114,7 @@ int main(int argc, char *argv[])
 			printf("Group Quota - ON\n");
 
 		qcmd = QCMD(Q_GETFMT, GRPQUOTA);
-		result = quotactl(qcmd, src, test_id, fmt_buf);
+		result = quotactl(qcmd, src, test_id, (caddr_t)&fmtval);
 		save_err = errno;
 		if (result < 0) {
 			fprintf(stderr, "quotactl(Q_GETFMT, GRPQUOTA) Failed: %s\n",
@@ -121,7 +122,7 @@ int main(int argc, char *argv[])
 			return save_err;
 		}
 		if (verbose)
-			printf("Group Format: 0x%x\n", fmt_buf[0]);
+			printf("Group Format: 0x%x\n", fmtval);
 
 		qcmd = QCMD(Q_QUOTAOFF, GRPQUOTA);
 		result = quotactl(qcmd, src, QFMT_VFS_V0, tgt);
-- 
2.23.3

