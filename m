Return-Path: <SRS0=klO3=NE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23FEC004D3
	for <selinux@archiver.kernel.org>; Wed, 24 Oct 2018 15:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1AF207DD
	for <selinux@archiver.kernel.org>; Wed, 24 Oct 2018 15:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="lwRSA2RP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1AF207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=crunchydata.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeJYAED (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Oct 2018 20:04:03 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33701 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbeJYAEC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Oct 2018 20:04:02 -0400
Received: by mail-qt1-f194.google.com with SMTP id p24-v6so100168qtq.0
        for <selinux@vger.kernel.org>; Wed, 24 Oct 2018 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hn+NrB6POArWfl6a+kpQdOAeQ/Ph6IvnxbrhOxnvKfM=;
        b=lwRSA2RPcB8FrWVFnO+Mw3DGoqcpFgIDwKPkcYRgQOq3IU/sEHKlfHFcgCvj75pP/x
         nDWkUcKwyn293SprKBOl1CLqt1axtD7tMiBsAurOmnlTGclxrP1Q/sQK4IptPFosjas1
         3kYgYTpi1v4dqlt3RWjXyv7yS68UXyLP6oP+ZqMLz8FWBPmYA1jnNt5dwHz8fOn0MluV
         oJQsSy5XEZ2W/6YRo4UskGrXm94cCmRPf+YsdfZxK+raoHnJIRgwyPO4V+bTKlvFnjvf
         F7qbvo3x2I+YCyIHF25//R7guTFX4cjoTotwdkfM0I2gloR/KwUx0Mo4RhNTYP7/iMAf
         qjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hn+NrB6POArWfl6a+kpQdOAeQ/Ph6IvnxbrhOxnvKfM=;
        b=fu03fxItujerk3Q8zs6arZthMC+fO4F01iAoN/Z+uBiiLOB5J+uJPuDfZYpPkDyt1g
         FqKMmFUi7vzF6ooOFudPnxKROBkIFmRXAJd6KjS8lQqhzzoXsJoO43IDi5Sqk0tRxdts
         nlguXRIofGMX0AG3nvuizn2gLl27bkHa8i0zj0k0XvsTNWMK1EzmBhqfYlsUu9LisFBz
         6e/6yuO40h/i+++t0h6ZkFrDTsbbQwwxBRbVXFsIP9ApIlb+vHpzbYdY/yDjnoTj5rtW
         O7Li8qyGKa/GuoYWe44AD20j+7IBjPV1IKaBcdeXfkH0UZDk6KSQQ3mKGAAWrNcil2KF
         2p0Q==
X-Gm-Message-State: AGRZ1gLmrcsvrM/9t3mWghpn3OzIGgbpYMXItGtghTO3/xoc0H1pvXoY
        lKjJtZdyYva2USRmTqZXWkFP+xin2Ck=
X-Google-Smtp-Source: AJdET5ds9lijevm9ahpxZKxLo7WDZaRvXVqaS1HTc6lwoqOy74dgJBBosPGzvBoB50V1qbLBn+frcg==
X-Received: by 2002:ac8:1a41:: with SMTP id q1-v6mr2848550qtk.329.1540395328425;
        Wed, 24 Oct 2018 08:35:28 -0700 (PDT)
Received: from mls-centos.localdomain (pool-68-134-6-138.bltmmd.fios.verizon.net. [68.134.6.138])
        by smtp.gmail.com with ESMTPSA id v54-v6sm6254652qtc.81.2018.10.24.08.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 08:35:27 -0700 (PDT)
From:   Yuli Khodorkovskiy <yuli.khodorkovskiy@crunchydata.com>
X-Google-Original-From: Yuli Khodorkovskiy <yuli@crunchydata.com>
To:     selinux@vger.kernel.org
Cc:     Joshua Brindle <joshua.brindle@crunchydata.com>
Subject: [PATCH v2] mcstrans: remove unused getpeercon_raw() call
Date:   Wed, 24 Oct 2018 11:35:19 -0400
Message-Id: <20181024153519.22187-1-yuli@crunchydata.com>
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
 mcstrans/src/mcstransd.c | 10 ----------
 1 file changed, 10 deletions(-)

v2:
- Remove comment about MLS clearance check in peercon

diff --git a/mcstrans/src/mcstransd.c b/mcstrans/src/mcstransd.c
index d7fc5dea..85899493 100644
--- a/mcstrans/src/mcstransd.c
+++ b/mcstrans/src/mcstransd.c
@@ -142,17 +142,8 @@ process_request(int fd, uint32_t function, char *data1, char *UNUSED(data2))
 {
 	int32_t result;
 	char *out = NULL;
-	char *peercon = NULL;
 	int ret;
 
-	ret = getpeercon_raw(fd, &peercon);
-	if (ret < 0)
-		return ret;
-
-	/* TODO: Check if MLS clearance (in peercon) dominates the MLS label
-	 * (in the request input).
-	 */
-  
 	switch (function) {
 	case SETRANS_INIT:
 		result = 0;
@@ -184,7 +175,6 @@ process_request(int fd, uint32_t function, char *data1, char *UNUSED(data2))
 	}
 
 	free(out);
-	freecon(peercon);
 
 	return ret;
 }
-- 
2.19.0

