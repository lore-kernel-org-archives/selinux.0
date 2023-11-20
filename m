Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9C2C2BB3F
	for <selinux@archiver.kernel.org>; Mon, 20 Nov 2023 15:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbjKTPrq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Nov 2023 10:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjKTPrp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Nov 2023 10:47:45 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51FCA7
        for <selinux@vger.kernel.org>; Mon, 20 Nov 2023 07:47:41 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-548ce28fd23so1171654a12.3
        for <selinux@vger.kernel.org>; Mon, 20 Nov 2023 07:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1700495260; x=1701100060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ib5iZGg5ipmLiN5XE1FFh7cgxKXEVyV56x4s3UJQKE8=;
        b=HLlgwUW7Y40ZFWab4AiQglmRCnDZvdnDIOjvY0nTQ0DnUkYt8UQRVEw6TLqdWW/BcC
         ncUiP+2a/ubiUYFsK9Gy0NjyMhXpWvyGjjRQlgcP+KAeZzpTKIPFpDWmtchfEhbc8NUZ
         1ROYIltgEoQNRmYSZqCStSDDIcrziZUctdrri243q0YevmNbgbI8JaUEmP+Jk3HLkJs3
         aR/NTV+HQELRKqEvtbPHb5GqzUVAKkeb9S4w2/pOCrQ4axulZep1UXiPVdsU4xCv+fLb
         eqEuMO8R9UpT6faCb9ErK4HnVYMsxOIrFVmaFynhNFVS8gYeajLQOFVgF/H6d4cVd8Sk
         b/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700495260; x=1701100060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ib5iZGg5ipmLiN5XE1FFh7cgxKXEVyV56x4s3UJQKE8=;
        b=jxvhDzGlqavMpX96jZFkVNoP+TbWG6UMDVc/nyxlLAnFUuvs1dXZ2+u5kR04kf9/pk
         1PyDptpjowsCehD+s2JrCe390KzKUaz23MAE8sWpio+7Bwz1ATxO2TH4CgjxkPBJ2DR+
         Xz8NW36u5+VsPyfqVTyJTsgqps3M8OtQp+lwdb3TUq0yDcHb/V0dPNRXgwq+NJIFlzp/
         Nouo3jrwrxEb6hqLZU+k1g89KfXA2562rLNuO9k3K0uyRqF+wgVkhKmpyGWsUsRt8U/t
         jP293K25gyzZu2/z8qFCR5JP6eQAAyfhR2zpe7X3R8h9mPSQzLQSuKbSTrzaybULTzl0
         0z9g==
X-Gm-Message-State: AOJu0YyOj+7zXZ6M9pvMMZUWQtcLN8gAH9ormoMBQ65g3uCH4zxzAVrR
        G6vii5D8bD7QzUp5URMtzDAi0E+2geSSA7Jn
X-Google-Smtp-Source: AGHT+IGeJAwvgJHc/nheULhchfw+FaNVgeB1eF8hKDeJJNfR+1EqIQUBGpprFdqAVp7ZRUTqFjpptg==
X-Received: by 2002:a05:6402:202a:b0:543:7115:eb15 with SMTP id ay10-20020a056402202a00b005437115eb15mr5849810edb.20.1700495260053;
        Mon, 20 Nov 2023 07:47:40 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-010-118-211.77.10.pool.telefonica.de. [77.10.118.211])
        by smtp.gmail.com with ESMTPSA id p1-20020aa7cc81000000b0052ff9bae873sm3660008edt.5.2023.11.20.07.47.39
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 07:47:39 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 1/2] libsepol: avoid fixed sized format buffer for xperms
Date:   Mon, 20 Nov 2023 16:47:34 +0100
Message-ID: <20231120154735.450915-1-cgzones@googlemail.com>
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
v2:
   reset in_range on retry
---
 libsepol/src/kernel_to_cil.c | 43 +++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 8fcc385d..8ec79749 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1633,19 +1633,27 @@ static char *xperms_to_str(avtab_extended_perms_t *xperms)
 	uint16_t low_bit;
 	uint16_t low_value;
 	unsigned int bit;
-	unsigned int in_range = 0;
-	static char xpermsbuf[2048];
-	char *p;
-	int len, remaining;
-
-	p = xpermsbuf;
-	remaining = sizeof(xpermsbuf);
+	unsigned int in_range;
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
+	in_range = 0;
 	for (bit = 0; bit < sizeof(xperms->perms)*8; bit++) {
 		len = 0;
 
@@ -1682,22 +1690,26 @@ static char *xperms_to_str(avtab_extended_perms_t *xperms)
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
@@ -1769,6 +1781,7 @@ static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_dat
 
 		rule = create_str("(%s %s %s (%s %s (%s)))", 6,
 				  flavor, src, tgt, "ioctl", class, perms);
+		free(perms);
 	} else {
 		new = pdb->p_type_val_to_name[data - 1];
 
-- 
2.42.0

