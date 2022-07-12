Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C048CCA483
	for <selinux@archiver.kernel.org>; Tue, 12 Jul 2022 16:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbiGLQJS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Jul 2022 12:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbiGLQJJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Jul 2022 12:09:09 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FE02625
        for <selinux@vger.kernel.org>; Tue, 12 Jul 2022 09:09:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id fd6so10713311edb.5
        for <selinux@vger.kernel.org>; Tue, 12 Jul 2022 09:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CAWUvuH2vtDhqU49owxtq8l4iLBUVe5BvEM74A+7J58=;
        b=ihzDE9ZDUa8Rv4WAGGJAZHJP/X2olFgES+L0/REfLv0Yfo4azjSCIKwexv5VbzqXpw
         7Fk507AELQz15VFcJEQq3D99DbiuxPTMWaOK/lC3lJKs8x0goosXuMbhsKfNMREJ648A
         Q8S3yNSDEr2heQeDDiUcczkCYxgpCc2O9EujazCasQHbZU/zEUpjiyHtRQPtftYAWRv9
         WeiQtQKBm0h6ARK8kW65HyIKAjUL4MdmEe2pSIgy4YpOpIn8EtqWiy4M0EqjTRn0H05d
         db7jIl5FyHxlsvyFozRgY+ENIZsUgV32pZHYsf2zHuarLNfVRE+gPx2W/2toeAcahRMQ
         0aWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CAWUvuH2vtDhqU49owxtq8l4iLBUVe5BvEM74A+7J58=;
        b=v1hCSPbUGuFGew3WqEGq1lm/sEpL6b1V0ACdtiPg3mLPU3ODyMh1YjL1SQnmkDAp1y
         NWVWQjpEwNLIABNeDO9xCkEELdQ23K+LX44StNj7UkSFFwha1vTcray5IbHfvO6BgO6M
         W+gp8UEqGx6PN7Z5oY8Ko3xDUZGWjQC1oCI7UF9rJb0JHTmdIpgRdDo9GPTgrlzqTG+K
         giUD7xsPio857U3YuHMYrczruMkwBxpLCMr3aW+w5OjiUb6BRxTXaPVBQKXbwFtFXqqw
         LwVFQ/hx0yCBwxqz0d3FSUjliVjOt28Jl0gFE2SCYATtCEdUWP+2KJ0g0KMC6xAVlcju
         QQVw==
X-Gm-Message-State: AJIora9ulhUczzLDDqVO2AYRCsHoAtkazn4xB7lJgm8H4roSVhiGNaVI
        A3CLHB9Doyz2it1vClDGLVeWdb98ZkoLZw==
X-Google-Smtp-Source: AGRyM1ur4U/tMvTNIEa5TIdQkRMwx8ddFqT6R2nxqo5rH5JHiaI6yGKZ7WGfb83OVNUob9kLxw7JYQ==
X-Received: by 2002:a05:6402:909:b0:435:a8b:5232 with SMTP id g9-20020a056402090900b004350a8b5232mr32659034edz.240.1657642147114;
        Tue, 12 Jul 2022 09:09:07 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-190-079.77.10.pool.telefonica.de. [77.10.190.79])
        by smtp.gmail.com with ESMTPSA id p13-20020a17090653cd00b006fed85c1a8fsm3887127ejo.202.2022.07.12.09.09.06
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:09:06 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 6/7] libsepol: optimize ebitmap_xor
Date:   Tue, 12 Jul 2022 18:08:57 +0200
Message-Id: <20220712160858.22677-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220712160858.22677-1-cgzones@googlemail.com>
References: <20220712160858.22677-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Iterate on nodes instead of single bits to save node resolution for each
single bit.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/ebitmap.c | 49 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
index c3d706e9..e0541abb 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -116,14 +116,51 @@ int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2)
 
 int ebitmap_xor(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2)
 {
-	unsigned int i, length = max(ebitmap_length(e1), ebitmap_length(e2));
+	const ebitmap_node_t *n1, *n2;
+	ebitmap_node_t *new, *prev = NULL;
+	uint32_t startbit;
+	MAPTYPE map;
+
 	ebitmap_init(dst);
-	for (i=0; i < length; i++) {
-		int val = ebitmap_get_bit(e1, i) ^ ebitmap_get_bit(e2, i);
-		int rc = ebitmap_set_bit(dst, i, val);
-		if (rc < 0)
-			return rc;
+
+	n1 = e1->node;
+	n2 = e2->node;
+	while (n1 || n2) {
+		if (n1 && n2 && n1->startbit == n2->startbit) {
+			startbit = n1->startbit;
+			map = n1->map ^ n2->map;
+			n1 = n1->next;
+			n2 = n2->next;
+		} else if (!n2 || (n1 && n1->startbit < n2->startbit)) {
+			startbit = n1->startbit;
+			map = n1->map;
+			n1 = n1->next;
+		} else {
+			startbit = n2->startbit;
+			map = n2->map;
+			n2 = n2->next;
+		}
+
+		if (map != 0) {
+			new = malloc(sizeof(ebitmap_node_t));
+			if (!new) {
+				ebitmap_destroy(dst);
+				return -ENOMEM;
+			}
+			new->startbit = startbit;
+			new->map = map;
+			new->next = NULL;
+			if (prev)
+				prev->next = new;
+			else
+				dst->node = new;
+			prev = new;
+		}
 	}
+
+	if (prev)
+		dst->highbit = prev->startbit + MAPSIZE;
+
 	return 0;
 }
 
-- 
2.36.1

