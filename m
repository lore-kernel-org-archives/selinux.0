Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A32BCCA479
	for <selinux@archiver.kernel.org>; Wed, 13 Jul 2022 14:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiGMOL4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Jul 2022 10:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiGMOLz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Jul 2022 10:11:55 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71DB326FB
        for <selinux@vger.kernel.org>; Wed, 13 Jul 2022 07:11:53 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id t1so4339946ejd.12
        for <selinux@vger.kernel.org>; Wed, 13 Jul 2022 07:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D23e2evORQwQTl87LF+PFyms/PEiOJ7GNcQ7WjcFOI8=;
        b=P6XXEJj0O5L/KZX3RZvyozz6oG7Ns0Nb/6zuTEcIfWj77Q/v/Na4rc8VHutkcGo3/7
         EQF+J7hC49j1FWR+r2XJBpEZwc5/27A6b1vLzTkkndeuAuohSz50MTbDMyKozgqX4qb8
         yuT3PbyEiQBKZfKXvhZ/9klQb5PyiDLjlnCYPK8AyocXzfKjjt++F/4Z03bMve+/PTF3
         ezaL8xpOXTheJRNNWQ/Twyx1EDxLYBS3b/3FanP/Lnkw5l/6xgtkNtBQar1BXGoa1vas
         ptVH70CiWRWufXZNcjchOVmzI2VeeH4VXyacsHpb8329qwQ2phfSispm4rIURi5tIvtB
         +YTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D23e2evORQwQTl87LF+PFyms/PEiOJ7GNcQ7WjcFOI8=;
        b=ff5mdEac9kBbDIOygwaobwN3ORtGNJrmQ0r6DrJgNYo6vaKi02ML3wlkd82FTzx0ST
         vmGyhcOwn4raG0zNZWUW6ZXOLGFMMYlmPya+lPxaQQWIseDS1EzVW6xverJ3//5TNzW2
         lZk0Dx8pFE1PNmHd/hH9AICkC7v5fONc5bMzz7gTOM6Xk2l+0by2l01oOT7QHMKbJDw9
         nz6jgIFQoMd6vFZfAfFSzxM/eI2hjWGkvMOpE5BY2x1V4w1QnYHLv4HjM8OQ/0JnLdXE
         rTBsLdUP6lsnLNP1L57eqsU9UMw9G46RaVYfZyx4c+VDSnWG0e6PgxJ+w2l4AmGzBB6v
         U3kA==
X-Gm-Message-State: AJIora8ufSO0W5f/dy0ijNJb+n17BXe26CEYQaOZrX4S3qJVlZYrVdY9
        asPNh90iSi53hYUZdomrF07K6Bhu4gIx2Q==
X-Google-Smtp-Source: AGRyM1syhW3QdyiPfegNvtidcoXdNX4JzMrOepEdkcroUEOvBepb947nqNDZQEv1GaBzcvO0raTzEw==
X-Received: by 2002:a17:907:2856:b0:72b:54bd:40eb with SMTP id el22-20020a170907285600b0072b54bd40ebmr3599588ejc.542.1657721512283;
        Wed, 13 Jul 2022 07:11:52 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-083-213.95.116.pool.telefonica.de. [95.116.83.213])
        by smtp.gmail.com with ESMTPSA id j21-20020aa7c415000000b0043589eba83bsm8010570edq.58.2022.07.13.07.11.51
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 07:11:51 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/5] libsepol: rename validate_policydb to policydb_validate
Date:   Wed, 13 Jul 2022 16:11:44 +0200
Message-Id: <20220713141148.35524-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Most global functions operating on a policy database use policydb as
prefix.

Since this function is not exported there should not be any external
use.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb.c          | 2 +-
 libsepol/src/policydb_validate.c | 2 +-
 libsepol/src/policydb_validate.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index fc260eb6..8a65df05 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -4570,7 +4570,7 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 		}
 	}
 
-	if (validate_policydb(fp->handle, p))
+	if (policydb_validate(fp->handle, p))
 		goto bad;
 
 	return POLICYDB_SUCCESS;
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 99d4eb7f..e1dad236 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1330,7 +1330,7 @@ static void validate_array_destroy(validate_t flavors[])
 /*
  * Validate policydb
  */
-int validate_policydb(sepol_handle_t *handle, policydb_t *p)
+int policydb_validate(sepol_handle_t *handle, policydb_t *p)
 {
 	validate_t flavors[SYM_NUM] = {};
 
diff --git a/libsepol/src/policydb_validate.h b/libsepol/src/policydb_validate.h
index d9f7229b..b7f9f191 100644
--- a/libsepol/src/policydb_validate.h
+++ b/libsepol/src/policydb_validate.h
@@ -4,4 +4,4 @@
 #include <sepol/policydb/policydb.h>
 
 int value_isvalid(uint32_t value, uint32_t nprim);
-int validate_policydb(sepol_handle_t *handle, policydb_t *p);
+int policydb_validate(sepol_handle_t *handle, policydb_t *p);
-- 
2.36.1

