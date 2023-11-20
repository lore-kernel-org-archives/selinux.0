Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0617BC2BB3F
	for <selinux@archiver.kernel.org>; Mon, 20 Nov 2023 14:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbjKTOcR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Nov 2023 09:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbjKTOcQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Nov 2023 09:32:16 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60C5CA
        for <selinux@vger.kernel.org>; Mon, 20 Nov 2023 06:32:11 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a002562bd8bso90630266b.0
        for <selinux@vger.kernel.org>; Mon, 20 Nov 2023 06:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1700490730; x=1701095530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NR/7/zW6aJdcBEr3tVRgqvS+D6XhjSX6wby+hcLZHso=;
        b=JN4Tb/fjLq1AskmTf7FOspVIbHU0L9a9Hr2VITCAK98VLd/0FFb2Gwv4RnyG1zcnjs
         NCE362vJd5HRKGTNkxDZJ9kFDdnYg6CtR0NiQav8coZoWrtZXU2r3Zgctrzo/1LDbGOi
         RMJTnyXR6Rk7H+L7myz6Hxexe+aPGsZPkcd1qDsVftxcGvDSwDWl02O2HUFQQj5Ptn9h
         eXz+Ap/UW7NTR4WT+WXblx9mYq9bhpBHsZHX0t9VdBJtH2PrUJpLgMcE6NsUdZUXC+KI
         JAKUH3FmaSZQABNM/6V1YlCheKamQPZ56FLyJRvvdEbqtpxbUP4uZxM9DoL+rwWcH8di
         /KXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700490730; x=1701095530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NR/7/zW6aJdcBEr3tVRgqvS+D6XhjSX6wby+hcLZHso=;
        b=jDtNVkFK5ultmWQK8qUa4SawGpM8ttBlVfGlZD+/BeE1HwrB2sLHaRuKCIK4V95umY
         kaBk5JDNCZ56A1Z9AYisqf951gbvtu/FVNFmN7ZwKI+AtdPDS0RsN24F9H4LXUvi+sLj
         ATipx3OpfjVDyHhdfO14H5ttKbtmsU21qEBFgMhnTg3YDMldch6zh0EJEoA7ajMCQPv0
         CJx6OX2K1MCW0ps/BNZXMFJMpwGKch4Lg0iyPARHm2WayMeGXJ6RoVbQ8wy+u4m2/BlA
         p8+8MS0BiSEP8j6ouyc29sDOrIRSVJe6RYmDsAYIM0YbPxAyUeD4lmY5IwsBgJp0JQ0P
         WL1w==
X-Gm-Message-State: AOJu0YyOZxsJE4stte9UHTMv0C3px2j5Z2+gOaIXFcluLbuo6DrnmjHb
        YsYE1/sLCnnIMSpTg+hyYACQ2hxQwzsOiLPP
X-Google-Smtp-Source: AGHT+IGNb30l3akvtkhFznVzdQQytyUbazw1ptSRkUi+q8/hPiClHr5eCxOUSfKVqJtxTWtUSdaPPw==
X-Received: by 2002:a17:906:21a:b0:9fa:7c87:b10a with SMTP id 26-20020a170906021a00b009fa7c87b10amr2056499ejd.10.1700490730078;
        Mon, 20 Nov 2023 06:32:10 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-010-118-211.77.10.pool.telefonica.de. [77.10.118.211])
        by smtp.gmail.com with ESMTPSA id b4-20020aa7c904000000b00548a2d1737bsm1632282edt.35.2023.11.20.06.32.09
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 06:32:09 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] libsepol: avoid fixed sized format buffer for xperms
Date:   Mon, 20 Nov 2023 15:31:44 +0100
Message-ID: <20231120143145.28831-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

An extended access vector rule can consist of many individual ranges of
permissions.  Use a dynamically growing sized buffer for formatting such
rules instead of a static buffer to avoid write failures due to
truncations.

Reported-by: oss-fuzz (issue 64316)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_cil.c | 40 +++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 8fcc385d..c50828df 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1634,18 +1634,25 @@ static char *xperms_to_str(avtab_extended_perms_t *xperms)
 	uint16_t low_value;
 	unsigned int bit;
 	unsigned int in_range = 0;
-	static char xpermsbuf[2048];
-	char *p;
-	int len, remaining;
-
-	p = xpermsbuf;
-	remaining = sizeof(xpermsbuf);
+	char *buffer = NULL, *p;
+	int len;
+	size_t remaining, size = 128;
 
 	if ((xperms->specified != AVTAB_XPERMS_IOCTLFUNCTION)
 		&& (xperms->specified != AVTAB_XPERMS_IOCTLDRIVER)) {
 		return NULL;
 	}
 
+retry:
+	size *= 2;
+	if (size == 0)
+		goto err;
+	p = realloc(buffer, size);
+	if (!p)
+		goto err;
+	buffer = p;
+	remaining = size;
+
 	for (bit = 0; bit < sizeof(xperms->perms)*8; bit++) {
 		len = 0;
 
@@ -1682,22 +1689,26 @@ static char *xperms_to_str(avtab_extended_perms_t *xperms)
 			}
 
 		}
-		if (len < 0 || len >= remaining) {
-			return NULL;
-		}
+		if (len < 0)
+			goto err;
+		if ((size_t)len >= remaining)
+			goto retry;
 		p += len;
 		remaining -= len;
 	}
 
-	if (remaining < 2) {
-		return NULL;
-	}
+	if (remaining < 2)
+		goto retry;
 
-	xpermsbuf[0] = '(';
+	buffer[0] = '(';
 	*p++ = ')';
 	*p = '\0';
 
-	return xpermsbuf;
+	return buffer;
+
+err:
+	free(buffer);
+	return NULL;
 }
 
 static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_datum_t *datum)
@@ -1769,6 +1780,7 @@ static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_dat
 
 		rule = create_str("(%s %s %s (%s %s (%s)))", 6,
 				  flavor, src, tgt, "ioctl", class, perms);
+		free(perms);
 	} else {
 		new = pdb->p_type_val_to_name[data - 1];
 
-- 
2.42.0

