Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C3CC433DF
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 15:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB6D20782
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 15:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="C9E1EROz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgHYPcT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgHYPcR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 11:32:17 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21850C061574
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 08:32:17 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id bs17so11626710edb.1
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 08:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z9SUdoRD9jobQqSxgzaFWXTZzsdd7t5n/dTM7Sq+oKk=;
        b=C9E1EROzKVxo+r4+snCXVhHNeRl2c6GUfsktW+aN41uxasfOIg6cP+WsFmocI84pGZ
         Iy8VYs8OcL1aJSz0Ue00B5CjokoLqt/AdSFBPJPRgSK+YnkM0EDtiBPInAmOCxWuyDgz
         3/GhG+gmmZTi8iglfSe0fvJIkZyYe4L7Fuhi/w3+Q8nXN/Tojw8I6bvGh01AYmFno6lE
         UhExe6IIZ9ZMThZjyDnTHnMmaweP3t1vRfirQ7yQWL4LZDX6jdpFlhtIpTQIIYAN3+6R
         FBLA8KYsWAU3WtakV9o5sDW9Ba3fIl3bRBEft5nZ3DDSssUib47Lj+3+aEMvI+FBKvMb
         SL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z9SUdoRD9jobQqSxgzaFWXTZzsdd7t5n/dTM7Sq+oKk=;
        b=uOoYrL9VCpQ9VaENU5uvDdXMCLt+PKdOEZKlBn+V5Z6xk8x6DO0UyOqRdP/57JiXJY
         QOgdMsvuH27ensXhK3VYQ9RvAJ1eHIZr2CCeW701fXy5gqjEUB1Tew0QXUv4no4sY42T
         iOVt7M5hYWnacsIHyJKZjyG4VvOPFKpCHXHQizJlDx4EST4e+LiGXnL7Xg5hwhdgtdmc
         iHtQwxLELpPYBDQgt+jFCYMRa1WusQr6c+X7AqWYKuerHnibhWVEmc6zNCogR52o+YP7
         3OlkAFptShOu9l35pmzdRTF4FInF3OT9pwCDagy23WntMaJN04mF8h5DiDY87UGf2Rit
         z/ew==
X-Gm-Message-State: AOAM5302DpSqwgTIEp9jeDGzCVBXs1XJc4RM3Dpky1xZk+P2OdFop3bO
        /i3YKywrEtH9x1iDeJAOVsEQv6OXPiA=
X-Google-Smtp-Source: ABdhPJxc/DJtBVcu5Endy2gFMJKyi/BsHTS1vrbYmC38wbBTfMNlWs2lz8nVAIKV3sXmorTu6qkzow==
X-Received: by 2002:aa7:dd05:: with SMTP id i5mr11034927edv.324.1598369535376;
        Tue, 25 Aug 2020 08:32:15 -0700 (PDT)
Received: from debianHome.localdomain (x5f74352c.dyn.telefonica.de. [95.116.53.44])
        by smtp.gmail.com with ESMTPSA id v4sm14029167eje.39.2020.08.25.08.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 08:32:14 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Mike Palmiotto <mike.palmiotto@crunchydata.com>
Subject: [PATCH v2 1/2] libselinux: safely access shared memory in selinux_status_updated()
Date:   Tue, 25 Aug 2020 17:32:04 +0200
Message-Id: <20200825153205.224136-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825153205.224136-1-cgzones@googlemail.com>
References: <20200824131841.55687-1-cgzones@googlemail.com>
 <20200825153205.224136-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Access the shared nenory safe in regard to consistent view of the SELinux
kernel status page - not in regard to thread-safety.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/sestatus.c | 40 ++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
index 814e86ee..ca2d3bbf 100644
--- a/libselinux/src/sestatus.c
+++ b/libselinux/src/sestatus.c
@@ -91,7 +91,9 @@ static inline uint32_t read_sequence(struct selinux_status_t *status)
 int selinux_status_updated(void)
 {
 	uint32_t	curr_seqno;
-	int		result = 0;
+	uint32_t	tmp_seqno;
+	uint32_t	enforcing;
+	uint32_t	policyload;
 
 	if (selinux_status == NULL) {
 		errno = EINVAL;
@@ -117,21 +119,29 @@ int selinux_status_updated(void)
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
+	/* sequence must not be changed during references */
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
+	}
+	if (last_policyload != policyload) {
+		if (avc_process_policyload(policyload) < 0)
+			return -1;
+		last_policyload = policyload;
 	}
-	return result;
+	last_seqno = curr_seqno;
+
+	return 1;
 }
 
 /*
-- 
2.28.0

