Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB38C433DF
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A5022078D
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="uj69UXiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgHXNTQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgHXNTB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 09:19:01 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF694C061574
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 06:18:59 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id oz20so6912624ejb.5
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 06:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6q5XKoaQZAkstNVrR2O1cS6kbEUSS03/ZJ5oenvzs2k=;
        b=uj69UXiGByywxIzxGaDuOkTHG2AfCZclTPIIIp48hcaF6iHucDz9ySpqCGIOhn5x1K
         +tU7fiWvSY3euWIE/pujq2VVSU3uvm4ERhfsXnCJYesoHQND+JSmbvZ149FhyjHBlAQa
         8h3lnp07gGCs42ujqYfsLeZAOFs/PubZzo4952+MY4P2QVFtNNVKjrumlyr81O47btA/
         n6EZTWs31KAz3W7jNh53qeoMUFPBgyTuqDH9euZ4F2aL6YY/oOjyNeaV70fxHJXNQbT6
         oysoBvOa/NUW/NyyoPbIAAQfxI9U8ukTb+lXmDCzn/pfuFJEm/Nz+3avyu5Pdspt6MWY
         ZoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6q5XKoaQZAkstNVrR2O1cS6kbEUSS03/ZJ5oenvzs2k=;
        b=Ba1jL97l2bFRSad0bQlGSY18CVrFEBe5zxRb7WEkypWm45eb2mp7p5ae5lXs6ydUx9
         U/pjkKumdekTikbL6cypcoj2XOYWUTQyq9jC1lop1ZKhVspqi2fPk25/+q6M7RDvi5eJ
         ieenKV4O8FktmKECqfkn3wPQT7BGq2rUe3MVW3IboanulRkQUTeiQWYc6NRcPiJs9X4d
         p0i1dlyDBjncLboFQL8vi6X23KKJsRVAQYkSbEFZTdpvq2mHEygxI9GKC047h6W2so40
         UocD110H0WUBuIEOIcdEbQwt5UBhltYpJZWIjAw+Oxpz4bf5MrhFXOraCGd5eUr7HQ8W
         DlMQ==
X-Gm-Message-State: AOAM532IzftTOUC16JqFiGgS2LDrqVj7aw0IORPtc/WiSacvWnejLar1
        K7WREcPFLddVliuVtYd5T3q2FO+r0s0=
X-Google-Smtp-Source: ABdhPJyXzXcL028T5CYW5McCSluUKjVqHAV62m51V3Vk+YEUEUBFhFWuUf+O5QBvgi3ikxuXAM/L1A==
X-Received: by 2002:a17:907:aa2:: with SMTP id bz2mr5363242ejc.521.1598275136899;
        Mon, 24 Aug 2020 06:18:56 -0700 (PDT)
Received: from debianHome.localdomain (x4d01ad51.dyn.telefonica.de. [77.1.173.81])
        by smtp.gmail.com with ESMTPSA id p3sm9369834edx.75.2020.08.24.06.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 06:18:56 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Mike Palmiotto <mike.palmiotto@crunchydata.com>
Subject: [PATCH 2/3] libselinux: safely access shared memory in selinux_status_updated()
Date:   Mon, 24 Aug 2020 15:18:40 +0200
Message-Id: <20200824131841.55687-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824131841.55687-1-cgzones@googlemail.com>
References: <20200824131841.55687-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/sestatus.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
index 925e6079..62a864b1 100644
--- a/libselinux/src/sestatus.c
+++ b/libselinux/src/sestatus.c
@@ -99,7 +99,9 @@ static inline uint32_t read_sequence(struct selinux_status_t *status)
 int selinux_status_updated(void)
 {
 	uint32_t	curr_seqno;
-	int		result = 0;
+	uint32_t	tmp_seqno;
+	uint32_t	enforcing;
+	uint32_t	policyload;
 
 	if (selinux_status == NULL) {
 		errno = EINVAL;
@@ -125,21 +127,28 @@ int selinux_status_updated(void)
 	if (last_seqno & 0x0001)
 		last_seqno = curr_seqno;
 
-	if (last_seqno != curr_seqno)
-	{
-		if (avc_enforcing != (int) selinux_status->enforcing) {
-			if (avc_process_setenforce(selinux_status->enforcing) < 0)
-				return -1;
-		}
-		if (last_policyload != selinux_status->policyload) {
-			if (avc_process_policyload(selinux_status->policyload) < 0)
-				return -1;
-			last_policyload = selinux_status->policyload;
-		}
-		last_seqno = curr_seqno;
-		result = 1;
+	if (last_seqno == curr_seqno)
+		return 0;
+
+	do {
+		enforcing = selinux_status->enforcing;
+		policyload = selinux_status->policyload;
+		tmp_seqno = curr_seqno;
+		curr_seqno = read_sequence(selinux_status);
+	} while (tmp_seqno != curr_seqno);
+
+	if (avc_enforcing != (int) enforcing) {
+		if (avc_process_setenforce(enforcing) < 0)
+			return -1;
 	}
-	return result;
+	if (last_policyload != policyload) {
+		if (avc_process_policyload(policyload) < 0)
+			return -1;
+		last_policyload = policyload;
+	}
+	last_seqno = curr_seqno;
+
+	return 1;
 }
 
 /*
-- 
2.28.0

