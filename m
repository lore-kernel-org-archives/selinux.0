Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0CE35AC3C
	for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784748174; cv=none; b=jAWvmgfQEqzr+dyjij2vHDqnD+TUO4sQVx1ROLY67G77AkBqNwBSqqYgwQ/+vC8hFjIuvXZig83NyuqElIcmddz2ufFwtZeU68fHmdaUPUonXJsQpOPqREMNEeBafiDUTrBNq35zW38w9QXqrHKN/BSpaib0TePCCiUNtSADBew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784748174; c=relaxed/simple;
	bh=1KlhKvTlAe1NPUsROKeOPy+zcmNXdoFw92B7r5hHtLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iKyuwvyieR0k5R7NhsW8OjxcTbePVkIgYnjTN5hHIeZVJmJy/K/12ZHJtBzB25BSxAUSUn+oqBhaVzdWUsltPHx31IHxiaV5A749OgOE7cexwwDmQQn3b/dRqP2K0oAswFdwCbj+ihp2aj1dcasnykgApKftomKDKSm2a2N7F7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEl+wHqi; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEl+wHqi"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5276d598b96so13710031cf.3
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 12:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784748166; x=1785352966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8YgKCQflW+YPOPECiDNhc54hxd+82dX6svQcpbNBmb0=;
        b=PEl+wHqiXpZ4JdZAbTIS6dZYTPuC+XRaRkpehvhjrBDmqgi7AREVnGFPnYOdV2CIZb
         T/Zf4lCELCHgCQaZesGLQtHva+wkYVqmlM8Yb2xRBhqZIXX28cHWWpWqDbHOqI49aGr+
         V1qTUjov1H8Pb/2bWgANf7w9hz03JWK5Y0pQk7PLZ9c0jsqEKtVbk2Nf5+V+CmYXSY5c
         9qqf7+bR4JIhJ/URFIN5FP01WEK5JWpOR1/Y9QNZz+2vrgzT3ZtNR5lBj3aVL2DHzK5e
         YBLAT5smC3zuo4pE8AWkt1dqiXZBNeNjU0cTBzMtwIW81xquYHd37LZydv0vc+bDbMwO
         f1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784748166; x=1785352966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8YgKCQflW+YPOPECiDNhc54hxd+82dX6svQcpbNBmb0=;
        b=KqoGxtofG9xKDQUnH2oli0VmBQ1sE7gdX33BDhuoksfzlf6HQ8x5K19bk9b2J+Eo9z
         hZ7So48k/9RiZUnn3FVZOLd5g10NBaWV7c3T/G2pOku3g9qTCA9MCQ2F1CAEiL7PCJv+
         k2X6AbwoItWNSLZojyfO962VGCHfTedT3zbO0QI+K9Bs6nQeE2hwB9mnIJzioGRBIwK7
         I6WPiong8V+2+ApT6ctAfnHi2kCzW8lit7EHD6o9WsJn/+Xn6eNvr783KQ8J4l3gMieu
         gFKUpJ4JamcCEKnMxYV7aD3OqAL79gnt8LoWEqF4JhjOHvp40d7IkmaJYsvOEyZxn8n2
         kFIQ==
X-Gm-Message-State: AOJu0YzLYRHKzJxx6DUdV1kltRTWJRHjUdpk/1G8n9hGVtOCYO3Iyvm9
	F/dROzsoil/sOD7Ti/MipAvYPIc+ppgAmJx4ZjaMNOfdSXvHQ8/NgAqGxxSmSQ==
X-Gm-Gg: AR+sD13ibaDDTdlr7PoDJzO3LN32ljxqZjWY/085F7VDiU/lZSSIalbTBnG5WmbTXFJ
	BLviUeIgLCqTCbtGisQRso3ubzw239Z/qwYXbTwxbEZxR1dE+gdfI/Znu/1JkGfUWzLQuOMJLwm
	ZQIr9L1a1LlkUtfvQHPMF3L+fSWbAC3ejdf4olvRVpfeRVpc+gI0L67sTBrmmKvkc2yaGX6WFeX
	g6LDd4+K1lAHupeRJp4hR4+uknQ3PUdPJ/D7FQEod47IGv0j/8RoThoXoNKK8YZUiIWJHQLdpuE
	LiTOeeZb7pH0ojr4A6sRIw6cblgLeOf3yTmJkqJPISaA09YMohXcHnYWSeEMNqyEekYLiWWKASl
	2jdPPTLQSdTAVmF3McZLfo6aDmpGo5mxcE3UpVmXqitt5FETvbDGRwxgfeo2t2T0rVhvnIBv8TP
	ILMcjni2Ndrbfd+5sO4DRg+p8xlUeB/g/mgHM=
X-Received: by 2002:ac8:5751:0:b0:51c:1c73:5943 with SMTP id d75a77b69052e-5213c6ee211mr239377301cf.23.1784748165885;
        Wed, 22 Jul 2026 12:22:45 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d1032f5esm21335171cf.12.2026.07.22.12.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 12:22:45 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Validate string fields used in various labeling rules
Date: Wed, 22 Jul 2026 15:22:30 -0400
Message-ID: <20260722192230.127626-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Filename transitions and the ocontexts fs, netif, fs_use,
ibendport, Xen devicetree, and genfs use strings in a name or type
field used to identify what to label.

Check that these strings do not contain any control characters to
protect against maliciously crafted policies.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/policydb_validate.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index cde0b8d6..13ed6460 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1,4 +1,5 @@
 
+#include <ctype.h>
 #include <sepol/policydb/conditional.h>
 #include <sepol/policydb/ebitmap.h>
 #include <sepol/policydb/polcaps.h>
@@ -129,6 +130,23 @@ bad:
 	return -1;
 }
 
+static int validate_string_field(const char *s)
+{
+	if (!s || !*s)
+		goto bad;
+
+	while (*s) {
+		if (iscntrl((unsigned char)*s))
+			goto bad;
+		s++;
+	}
+
+	return 0;
+
+bad:
+	return -1;  
+}
+
 static int validate_ebitmap(const ebitmap_t *map, const validate_t *flavor)
 {
 	if (ebitmap_length(map) > 0 &&
@@ -1436,6 +1454,8 @@ static int validate_filename_trans(hashtab_key_t k, hashtab_datum_t d,
 		goto bad;
 	if (validate_value(ftk->tclass, &flavors[SYM_CLASSES]))
 		goto bad;
+	if (validate_string_field(ftk->name))
+		goto bad;
 	if (!ftd)
 		goto bad;
 	for (; ftd; ftd = ftd->next) {
@@ -1505,7 +1525,7 @@ static int validate_ocontexts(sepol_handle_t *handle, const policydb_t *p,
 					if (validate_context(&octx->context[1],
 							     flavors, p->mls))
 						goto bad;
-					if (!octx->u.name)
+					if (validate_string_field(octx->u.name))
 						goto bad;
 					break;
 				case OCON_PORT:
@@ -1522,7 +1542,7 @@ static int validate_ocontexts(sepol_handle_t *handle, const policydb_t *p,
 					default:
 						goto bad;
 					}
-					if (!octx->u.name)
+					if (validate_string_field(octx->u.name))
 						goto bad;
 					break;
 				case OCON_IBPKEY:
@@ -1533,7 +1553,8 @@ static int validate_ocontexts(sepol_handle_t *handle, const policydb_t *p,
 				case OCON_IBENDPORT:
 					if (octx->u.ibendport.port == 0)
 						goto bad;
-					if (!octx->u.ibendport.dev_name)
+					if (validate_string_field(
+						    octx->u.ibendport.dev_name))
 						goto bad;
 					break;
 				}
@@ -1560,7 +1581,7 @@ static int validate_ocontexts(sepol_handle_t *handle, const policydb_t *p,
 						goto bad;
 					break;
 				case OCON_XEN_DEVICETREE:
-					if (!octx->u.name)
+					if (validate_string_field(octx->u.name))
 						goto bad;
 					break;
 				}
@@ -1592,7 +1613,7 @@ static int validate_genfs(sepol_handle_t *handle, const policydb_t *p,
 				goto bad;
 		}
 
-		if (!genfs->fstype)
+		if (validate_string_field(genfs->fstype))
 			goto bad;
 	}
 
-- 
2.55.0

