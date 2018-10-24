Return-Path: <SRS0=klO3=NE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7433C004D3
	for <selinux@archiver.kernel.org>; Wed, 24 Oct 2018 14:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0AF2075D
	for <selinux@archiver.kernel.org>; Wed, 24 Oct 2018 14:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="j5JSgd5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F0AF2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=crunchydata.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbeJXX14 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:27:56 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35215 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeJXX14 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Oct 2018 19:27:56 -0400
Received: by mail-qk1-f193.google.com with SMTP id v68-v6so3486369qka.2
        for <selinux@vger.kernel.org>; Wed, 24 Oct 2018 07:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m2+pcY+nDxEFg9ILtqH9T5G3TLJCVR6cKJhlamGHzUw=;
        b=j5JSgd5jpjTqodqRTQJeCbJ4TwgVoky7uZhChgjKOwdXe8UK2AEDq5MkOMXPnTHOZd
         a6WJ+A2DVtWV3nBtBaq1a3MrAcZjZ7zQJ7VHZLCoLxKsc1/OwDgHn7AGMbRgbyc0QE28
         mnzWVpYPw9tz+hF0qhg7O7sZrEGa8j+elpBfoapxXIg6Dx3DLy6LAPpl6zOcAyqJxdim
         sQtPQKrIgwxcdaCdCk6GI6dzENcesucMKrF19D6Y5ud9TScRcNZyIttoTP02NMcMcFod
         INgz8abYC2D8tUXaq1sUdDwbDwO++4jAGiiZLMJERKhl6PoO2yFJVPtAljY/32rr8oVj
         OU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m2+pcY+nDxEFg9ILtqH9T5G3TLJCVR6cKJhlamGHzUw=;
        b=aAZgY5Oe9Olx/NYe2QUPuqs97TBPEnInFPfyNmR1ViXZ9BLYFFJitwi+kQXqM1BcL1
         AD1ho77sWkcfdUMhOhFcG+iJ8Wn5hLtACXAmKLnGffOJtb0+N3e9qE5I5XChZb+0iO4O
         GbQbv8RdwFlOJGgRpyqyErGU9woKJ4boAjq+4iYboA+J1K3zPWYzufiHRf2LiKMfFiqD
         hPUTxU7KkyLY1Y6dGBaOdT024SGV82OCmK8/iCndtaOD8Af2464szxfAowfE9uZwzGmH
         daaP11rlgGr6zF+sAHdD7rw5E3lRWQOl5MuBJnrzfhi6TS8SLzZJZczZ4vPHjk6qaJLv
         jAAQ==
X-Gm-Message-State: AGRZ1gKPj2TSobfhTXbA+HkiSrJVmSvealrufy9hDrRc+7H1i+SplCMQ
        8bjqFUz19UzlSAkN7G+12sCt4gC2Tno=
X-Google-Smtp-Source: AJdET5eKao9+vXnjmQWC9OhXsWhvEH0FnJ21SBee3i4xKHVKhmZ8OuzEmvEJPFmI0ZyQJqQr2BdMGA==
X-Received: by 2002:aed:2601:: with SMTP id z1-v6mr2775071qtc.123.1540393168805;
        Wed, 24 Oct 2018 07:59:28 -0700 (PDT)
Received: from mls-centos.localdomain (pool-68-134-6-138.bltmmd.fios.verizon.net. [68.134.6.138])
        by smtp.gmail.com with ESMTPSA id k188-v6sm1031410qkb.3.2018.10.24.07.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 07:59:28 -0700 (PDT)
From:   Yuli Khodorkovskiy <yuli.khodorkovskiy@crunchydata.com>
X-Google-Original-From: Yuli Khodorkovskiy <yuli@crunchydata.com>
To:     selinux@vger.kernel.org
Cc:     Joshua Brindle <joshua.brindle@crunchydata.com>
Subject: [PATCH] mcstrans: remove unused getpeercon_raw() call
Date:   Wed, 24 Oct 2018 10:59:15 -0400
Message-Id: <20181024145915.20172-1-yuli@crunchydata.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

There is a call to getpeercon_raw() in mcstransd, but nothing is done
with the context. The purpose of process_request() is to translate a
context and we would like that to succeed even if, for some reason,
getpeercon_raw() fails.

Signed-off-by: Yuli Khodorkovskiy <yuli@crunchydata.com>
Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
---
 mcstrans/src/mcstransd.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mcstrans/src/mcstransd.c b/mcstrans/src/mcstransd.c
index d7fc5dea..abbdea7e 100644
--- a/mcstrans/src/mcstransd.c
+++ b/mcstrans/src/mcstransd.c
@@ -142,13 +142,8 @@ process_request(int fd, uint32_t function, char *data1, char *UNUSED(data2))
 {
 	int32_t result;
 	char *out = NULL;
-	char *peercon = NULL;
 	int ret;
 
-	ret = getpeercon_raw(fd, &peercon);
-	if (ret < 0)
-		return ret;
-
 	/* TODO: Check if MLS clearance (in peercon) dominates the MLS label
 	 * (in the request input).
 	 */
@@ -184,7 +179,6 @@ process_request(int fd, uint32_t function, char *data1, char *UNUSED(data2))
 	}
 
 	free(out);
-	freecon(peercon);
 
 	return ret;
 }
-- 
2.19.0

