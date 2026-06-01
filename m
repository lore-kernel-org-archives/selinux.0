Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04033750DC
	for <selinux@vger.kernel.org>; Mon,  1 Jun 2026 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317753; cv=none; b=rJeIwfbUZ8A2rCfG2sy7MJ+t4aUsApMpCNqUM/L3YueN6g+hPdS7kYe0tQ2Nuw5oiESUoYMYJRBSv4E7R9EY+TxXlh5kinUZenPmI8ZkSrFiAR+cNGw81kQUGacVRcf8SGTe8VXxKUUe/vjjCJ589355TZBXNV5szoeKboUpank=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317753; c=relaxed/simple;
	bh=vUw40xASSrQ4zOXivZRSXKFAbnHFjHKmD+CFEyaoDT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sxdkh7lRuxtI7i8H1TpQ4sJM/WvW9fsTrzXk8zBzo+DvTWgj/CFYGy8mImzGQhzCRn7wLSWj4SoTp52AWOvDPUlxLMfXaLFbMNCTB60SfBbRpExQNGrKUA1va/IvD9/ZcYGO/HjiPSlnmDYRF2e6fjsKk9+n8jCGxHaaQCspWVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpsvUmjg; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpsvUmjg"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-914ae4101b4so1305100185a.2
        for <selinux@vger.kernel.org>; Mon, 01 Jun 2026 05:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780317751; x=1780922551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OPO0MyKD9OG3GSJWpwFhqlbGj7yq7hnFh/ilqTu6WcY=;
        b=TpsvUmjgbOJddsrrUgdJ46xbMukuqapSRm+nK8JuUDbV9kqrSyo9IBI6kKp1Vxx6pq
         do7HTLyJqXsFTCuST9ho8QS7bFVGpQbU6xs82td4PUx07Gn2zohLuXA9Hpa0714uVdkm
         OzS9yqU94r81ekUIEFmzRHWlaSMTMZS0MnltnpUGpwd5SKLtdnKzsA6bNRLL/hVhnWy9
         bQoCcY/uC8AL5MiBhHLlFuleP6hv17Tdnoh3VzTGEPDEkWla/mVGxOpoUlaLhnaHJPKq
         kgsik+IVQp7DIkb47gSnMfHiZ25OCxal5YsxflFYS4532/JRJsCr4ogeUWm3SKghbwCV
         g0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780317751; x=1780922551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPO0MyKD9OG3GSJWpwFhqlbGj7yq7hnFh/ilqTu6WcY=;
        b=Kdlo4eI/FuPcfZ5tU5+NZgUYsFT5zDJfDv70Z3h5a4Xi6LsQZfpt80Mh31ElHN74+c
         x1o1Cpm54vrEZzE+Md8ApoePEpIRCZQzEyg8tveUj9yTZIPj/puR0DSJFBI+7Kl0JeLo
         OXmaqi3FFlvUneC9QN2uM2TUZ+MtEY3+e9ZGiT0nWv/n9siJe8pZ29u4N+EOoV/F5l8W
         MTyRXAyFPornBKNogWYx+Kv0gxERO/Bc3Kt3W2QAB0GxASMx1m/BHFpm/ZelDOgAjRCI
         /yqAGemDVUQn84RrrweVwXHJG5/gWAgsSZoqjaBA44JAPhY0LXFsTSAzHNgoC73MByWi
         D0Mw==
X-Gm-Message-State: AOJu0Yy35Y0J2WrH5L0lKCklHYMqIf4iCVygFgW6IlCnTQyo/yeQVBIK
	61edFswHD1fXaJfs90ZrGCuJgyl/BmwiwvAx17PiPL6JBzLMX7brE5Ht95+tJg==
X-Gm-Gg: Acq92OFDBiyjsIGXShdN36xviGhH17qKUT8xRDr+X0Mb0h8SeP211IRCV4dYkfLD6v1
	72TxIRVo+uqk8d11fOP8UccrfNPrxLgQb90x9L2WzEDz120NW+STlXD0gXZuzgwfxurAWKSu9b5
	Acc1oG2SIQX4AkhEwNYUv4umw0DeXWK12NDCNIICp8aaSgTX8JqAyTfE5uwoNOsXRapYDd2kgwg
	hRvwlN2bE50NzRsYcprs4MRQLO2baW6uxXaEXhS09zNe+yu9O6Q/ExGfYmoLSOfyy5i2UHaS3jH
	Y4OjCFVGUBeu3zkFPcWoiPM/sG26n0wwltj1+xPSZ+R8VX+AVkOKCGCZrwXwZgTYYsMiNbN22Ja
	gdKmxi/0hqH5wExHnFeOHiTGP0/wuPiFVZ6e1/RCYzrWE8n6IakVuYX8yTngoQ6e8Yp4roqfgco
	pOQVIunQEqAaFPgdW7RaRLyCqZzPv2mmGkwdpr7siD6gdVwN5JAJC4/IjGy0ASf7XIT4+zfQKjA
	nuQuBTlPBJw2pxBqC+a0wJjLeCY9sit6Qxb5w==
X-Received: by 2002:a05:620a:4510:b0:911:8e3c:f165 with SMTP id af79cd13be357-9153d99ebdbmr1648820385a.19.1780317750898;
        Mon, 01 Jun 2026 05:42:30 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153262f45dsm1015568185a.41.2026.06.01.05.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:42:30 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/2] libselinux: selabel_subs_init(): do not read past terminating NUL byte
Date: Mon,  1 Jun 2026 08:42:09 -0400
Message-ID: <20260601124210.174430-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not read past the terminating NUL byte set by fgets_unlocked().
Also, pass fgets_unlocked() the full buffer size; it only reads
the size less one bytes and writes the NUL byte.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/label_file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index bb866075..88c2c9e1 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1284,7 +1284,7 @@ static int selabel_subs_init(const char *path, struct selabel_digest *digest,
 		return (errno == ENOENT) ? 0 : -1;
 	}
 
-	while (fgets_unlocked(buf, sizeof(buf) - 1, cfg)) {
+	while (fgets_unlocked(buf, sizeof(buf), cfg)) {
 		char *ptr;
 		char *src = buf;
 		char *dst;
@@ -1296,7 +1296,8 @@ static int selabel_subs_init(const char *path, struct selabel_digest *digest,
 		ptr = src;
 		while (*ptr && ! isspace((unsigned char)*ptr))
 			ptr++;
-		*ptr++ = '\0';
+		if (*ptr)
+			*ptr++ = '\0';
 		if (! *src) continue;
 
 		dst = ptr;
-- 
2.54.0

