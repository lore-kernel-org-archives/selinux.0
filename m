Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E1023183C
	for <selinux@vger.kernel.org>; Wed, 27 May 2026 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779885273; cv=none; b=F3N2jq78ODkd2jLnoeouun8haUU660g2gNDsQkfX1ny27FNqLWRIu9pI3E8UqWr9xmNqMeiUxbefb8vWIH4bZJsn70x20jGxAF+psNr5+ZR9c8va/TxuSGpHH34QAD2DHg4cwX+Iwh/BFSPaL+RQGawgCLinblIkjfWePSbphV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779885273; c=relaxed/simple;
	bh=tIDQMAynJ+iorvNewSJjrVmaZHsgA5+PK3k0TQVmCtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K2N8/Hqf/FLeKcT1VveJXKR2HfasgF6CaTdKnYVpHFUiAcENwnh0bQZljDpRFFfvxNVQwPvWnFQhtfPngXHWKc8c7UqraQJVBGzCAYIRNokxLsk9c2St+R7qFvGLFZRQSx+xXV8vF1Vb+6TApT74rndlYjD5mJt109detgzyWI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyRWrRsg; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyRWrRsg"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-516e1525aa3so47055141cf.3
        for <selinux@vger.kernel.org>; Wed, 27 May 2026 05:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779885271; x=1780490071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=litnajdF2x2rlrrEy3kUhZ0icX+nDKl3XTLdIAp4YKo=;
        b=CyRWrRsgA7pN+6fmeo/5Axdwhy2bJNY8I8xSCHJiXdNAuzwMohXY57u2o/85NHdWnl
         gdfQhjLWKjGomOLEWaniC4UQttqQRzz82kpG5T9gC3WymybF0YgBoVN/IsnOxwgzUL3l
         9c5ejqwXYRgcnej7kXkcSHhSPJxbxX+QZTC/gd38+GIsYc9OMPZVk0uvtWTGhhlQPbIe
         vXmog9TUZeJUSNTLARid13JtvJV77ToXYosaEvF5C34QT1jkHvbIFXyDYTLE4zvnqkTt
         ik9VEAGZhaHvLW6XSqSyGcdp8RfFPtvpoL7rbFenm6SWAkkN+SbW1rFboSaPI5iSbkpU
         QXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779885271; x=1780490071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=litnajdF2x2rlrrEy3kUhZ0icX+nDKl3XTLdIAp4YKo=;
        b=dP5DPZfcQ5xiq+IM6lHvah0Me0UCLweQUXtv97DcP/E/djWOjNMKpG6zmeqYl8WJsK
         vcWrmNCbXGw4LmHSrZT3HbY1rih+Y96/N1VsWzyk+mYIIbSjD9nSqLeXCkUhIVk9FyHv
         U8ASOShirsBq/Sk+cUrdG64uT3QfOJlq5i2H4nGXsF5x12Mkq/a+0xip4RzZjjNoT/to
         tQfqiu6cWglFZSTSYNVuHT8Bx38v2HTBO1HwXNLhbN+j2OLq540iUsEWW/CxjXqFk7YW
         lEAj00AL4/CGXr0jvUchUbAnYkQJBqtdEmhUzDrDK7thiyef5QOgT/i4kWeRlEjF01dq
         KJ1w==
X-Gm-Message-State: AOJu0Yw8gNwXdxACyHS9nzAlgSVltpr8GbKPl3WctoxZp+2/iWCygXRC
	ncovkFOBEpDIKT2X/EyEQ4tg2rwBDzJajR2OP1CGjxWa0vRDAs1FTw3mzfbjxw==
X-Gm-Gg: Acq92OHz3oi7+l3cX89yQ292XtjJQRENdKLCJypWDY3CjTFNAU8nTSb8DDdP6as/3Jf
	LUj5ey0+qsEA0unfpocSd9hPiQJIQ3tAPJQ/S1jLJkAeYuAw6A2wptAn5rui8WaJwFgoDE4Cq51
	getRVa8iAYoFTDt6qqaGKnFQPo5+FRRr4oeanXks3jziwHtK4NsJAElw0Crbm2pg4gIcwOB7dCO
	l7rj9UgyFPfJPH87X1v1fZPkfwDdKATBlfjfdGq0WBObAavZtppD+uuyWPpFdJvf3oABsKVl+Dy
	w1je83FROPUgRT/SqzwouD7HSaEYU5yZt5KXEcaZSaB15QZAS1ikW2cfXWCvrHovMYsV4/Wj8Lc
	G40BStUVA3d4qQwGt4PmfwSJjgC7KwDmYTmabzJMyoMdyfIqhQIMvZxMWTJF1y+Vs87fNWzguW2
	ISx/zqRqnklirpKTlX7rmaLw7AdQ+rUA+Y6WA/LX5MZBiOqJMC7M0IqAsSLbyhr2UcbHzh4Y4AP
	fI1VCAkfAiwS/YTjNI359rzLT1augMwVLANDg==
X-Received: by 2002:a05:622a:48b:b0:516:e517:6dff with SMTP id d75a77b69052e-516e51770admr221012811cf.1.1779885270083;
        Wed, 27 May 2026 05:34:30 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706a28ddcsm45893951cf.13.2026.05.27.05.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 05:34:29 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] mcstrans: cap maximum category bits
Date: Wed, 27 May 2026 08:34:11 -0400
Message-ID: <20260527123411.26088-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cap the maximum category bits to 1024 by default, overridable by
defining a different MAX_CATS in CFLAGS. Only update mcstrans'
internal maxbit value after successfully setting the bit.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 mcstrans/src/mcstrans.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index 1baf7ba9..daf9b7a6 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -46,6 +46,9 @@
 #define log_debug(fmt, ...) do {} while (0)
 #endif
 
+#ifndef MAX_CATS
+#define MAX_CATS 1024
+#endif
 static unsigned int maxbit=0;
 
 /* Define data structures */
@@ -187,20 +190,24 @@ parse_category(ebitmap_t *e, const char *raw, int allowinverse)
 		}
 		if (sscanf(raw,"c%u", &low) != 1)
 			return -1;
+		if (low > MAX_CATS)
+			return -1;
 		raw += numdigits(low) + 1;
 		if (*raw == '.') {
 			raw++;
 			if (sscanf(raw,"c%u", &high) != 1)
 				return -1;
+			if (high > MAX_CATS)
+				return -1;
 			raw += numdigits(high) + 1;
 		} else {
 			high = low;
 		}
 		while (low <= high) {
-			if (low >= maxbit)
-				maxbit = low + 1;
 			if (ebitmap_set_bit(e, low, inverse ? 0 : 1) < 0)
 				return -1;
+			if (low >= maxbit)
+				maxbit = low + 1;
 			low++;
 		}
 		if (*raw == ',') {
-- 
2.54.0

