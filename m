Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A20242D9B
	for <selinux@vger.kernel.org>; Wed, 27 May 2026 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779902100; cv=none; b=b8mDhFcqcpL916z5TI8SVPpNFokNRwZEvIYtQhLU2VopbC10tyuXBZGuMWXLQU//o9hxgNYdxPEftJrBVJM5xSZxPuIfGyiIQ2lsjeMdbig1orSpeoICb3LVh6z1/NwaN3SldidUimt2JRIxGeduP9YXuBSwadJZWyWRjAqpPUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779902100; c=relaxed/simple;
	bh=Z5SrVGTAECUwNA3vdRTCPMRBGhPvX/KD2ja5k4Jz1j0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gFGz1A3zG5ySCzSnmrQWadz95769nCVj8wGN5DqIiNRzuwsJxbMEjvr8Gy4ZtcOpjjW507LMRxQ4VmLbCrGMUBVK+IYeFtdPu/xVbJZuf5//xqz+e3fBDsVnYxipX1QDd9y0Tk063bfwNgKrUfvuS9bhASHFmjqrLUl1sndaS2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjsgON9v; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjsgON9v"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-911dfc86903so1384487585a.3
        for <selinux@vger.kernel.org>; Wed, 27 May 2026 10:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779902098; x=1780506898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rUnx7R7UMIPFwnMcxHVE4eh9Ru29mkfRC0LMuXm2d70=;
        b=CjsgON9vnwlq+Z8xir5n1eCiJIkrshVbDeunFU6+r2jIWjKxlP+ATfsg6NOMfD4QaH
         s49v1R9rXnyxDqWskYFUZ67EYPNSSO8Lq3w2kLna4nNBmPngWYxvLAUV8hizO/H1DBZS
         9GUemoWaDO6daXou/kT7PJ80Ealtqe5JeA2Qzn1eZ5JBCfVE6vKyInIZiyqn7ry2Pr2y
         0Eg2PjR8LZXmEkwF2/xB2CTzg5f+Q1YRuft+BgopAWCsLRlFU5YdqZT9J3ktDHjXPlsZ
         Her7WckpUO3Sd601B3rWqCZ+HbjuC8D2499MEiVmoQnvFyJjixPx6MILJEBWi3M7MwvR
         6KHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779902098; x=1780506898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUnx7R7UMIPFwnMcxHVE4eh9Ru29mkfRC0LMuXm2d70=;
        b=eRGZLxdRqr6FWrs7dIjOBc2oKhJbPqJntCOTqiBVjYP+E6QZFZ38cP9q5bBSALPSfk
         JSBvKhJVJHuDVt5ug8J+z4gFvrPnpMew0+nhfqBUuog6Md5wzc5ObN9WH2o/eGK4Yrqk
         dY0FDp3NdoqxFqu3DPLgY4Edde1BpJpe+M8GAglIuK3Ele+4c5ah4DQ3XQWCJ0uSKSpA
         R8U124m577JpCD0cz1EhA7wQQ6wyHSjXQ2o10+fmrUzY4YSYKfoL5uCd4gVVFQxtOFP3
         E9ZR/ClGhkN8Ft24glygJ5kSp8NB80zl7tl3YwwodGiJZwx60mey9PcQCV83YQBGmywj
         7f9g==
X-Gm-Message-State: AOJu0YyLcqEQZv3MpJqj2wnhFTvh1z1LOQDAQ/odHcf0+0ikVFXIb5Zo
	SvUDuw9v8mAVgqNXlFiAlBQl6+2HCUUHbRWW/naIKpQuLDAldmD+/g3xKCh50Q==
X-Gm-Gg: Acq92OGKKI8FQTmz0duv7FhEiQdSr2usQqebLTexA/pOCSB87ehkc4UF9/aYr8Hm2et
	o/Zm7r60HGUhppw7x31G/iQwSe59WBUC69G1tt1/L26eDJHJcldKk47IWej8My6ICQF/FxkRPu0
	KKmYlldRplwwpQv3M6x4DQt2IbsdcZJ0/E/OJqX37O6IMJAAWCmvl5yw+GSSunetkbbAn19P4Xo
	0v22uSPu7Z3dbmYelyAAURvrhEO9Kka4kHCo268+sDOVo6GRXERD/0Nmd3iAAOJ+By6Pntwe2vS
	0nlQjB9EP1ElcAyaHLydIers3PnP/vFxWs0+lboosFnNs9epTr4NpcWF4ZSxo3XReZVQv2mL2m9
	SGs6YGDftL+8ejxEbiLYGOw04PMA/I8bg9xUSTwXOIuqJ8s0SUPUPXXjRfTv+TVQ54fq1XbZX5i
	6SFyGT49bs10vPc7BmSRs7pi33XAYEIsVfxdqKDrQ17s3eA5b0iEPvp/sc8hoR8S1I5YJxts+8b
	O1iY8ENZsuDSCyI4lFo2gUz0tjgSD2NI10huxPr0qe3nqAV
X-Received: by 2002:a05:620a:6304:10b0:914:c100:6a0b with SMTP id af79cd13be357-914c10071bdmr2247753385a.16.1779902097888;
        Wed, 27 May 2026 10:14:57 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9150af8487dsm173586085a.3.2026.05.27.10.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:14:57 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] mcstrans: only update maxbit for categories read from config
Date: Wed, 27 May 2026 13:14:38 -0400
Message-ID: <20260527171438.29181-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

maxbit was intended to float to the highest category used by
the setrans.conf configuration. It should never be modified
as a result of a client-provided raw context.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 mcstrans/src/mcstrans.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index 5056f86e..ee99a19e 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -17,6 +17,7 @@
 #include <values.h>
 #include <unistd.h>
 #include <fcntl.h>
+#include <stdbool.h>
 #include <stdlib.h>
 #include <string.h>
 #include <stdio.h>
@@ -178,7 +179,8 @@ numdigits(unsigned int n)
 }
 
 static int
-parse_category(ebitmap_t *e, const char *raw, int allowinverse)
+parse_category(ebitmap_t *e, const char *raw, bool allowinverse,
+	       bool fromconfig)
 {
 	int inverse = 0;
 	unsigned int low, high;
@@ -192,6 +194,8 @@ parse_category(ebitmap_t *e, const char *raw, int allowinverse)
 			return -1;
 		if (low > MAX_CATS)
 			return -1;
+		if (!fromconfig && low > maxbit)
+			return -1;
 		raw += numdigits(low) + 1;
 		if (*raw == '.') {
 			raw++;
@@ -199,6 +203,8 @@ parse_category(ebitmap_t *e, const char *raw, int allowinverse)
 				return -1;
 			if (high > MAX_CATS)
 				return -1;
+			if (!fromconfig && high > maxbit)
+				return -1;
 			raw += numdigits(high) + 1;
 		} else {
 			high = low;
@@ -206,7 +212,7 @@ parse_category(ebitmap_t *e, const char *raw, int allowinverse)
 		while (low <= high) {
 			if (ebitmap_set_bit(e, low, inverse ? 0 : 1) < 0)
 				return -1;
-			if (low >= maxbit)
+			if (fromconfig && low >= maxbit)
 				maxbit = low + 1;
 			low++;
 		}
@@ -225,14 +231,14 @@ parse_ebitmap(ebitmap_t *e, ebitmap_t *def, const char *raw) {
 	int rc = ebitmap_cpy(e, def);
 	if (rc < 0)
 		return rc;
-	rc = parse_category(e, raw, 1);
+	rc = parse_category(e, raw, true, true);
 	if (rc < 0)
 		return rc;
 	return 0;
 }
 
 static mls_level_t *
-parse_raw(const char *raw) {
+parse_raw(const char *raw, bool fromconfig) {
 	mls_level_t *mls = calloc(1, sizeof(mls_level_t));
 	if (!mls)
 		return NULL;
@@ -241,7 +247,7 @@ parse_raw(const char *raw) {
 	raw += numdigits(mls->sens) + 1;
 	if (*raw == ':') {
 		raw++;
-		if (parse_category(&mls->cat, raw, 0) < 0)
+		if (parse_category(&mls->cat, raw, false, fromconfig) < 0)
 			goto err;
 	} else if (*raw != '\0') {
 		goto err;
@@ -615,7 +621,7 @@ destroy_cat_constraint(cat_constraint_t **list, cat_constraint_t *constraint) {
 
 static int
 add_base_classification(domain_t *domain, char *raw, char *trans) {
-	mls_level_t *level = parse_raw(raw);
+	mls_level_t *level = parse_raw(raw, true);
 	if (level) {
 		base_classification_t **i;
 		base_classification_t *base_classification = calloc(1, sizeof(base_classification_t));
@@ -1434,7 +1440,7 @@ compute_trans_from_raw(const char *level, domain_t *domain) {
 	if (!level)
 		goto err;
 	
-	l = parse_raw(level);
+	l = parse_raw(level, false);
 	if (!l)
 		goto err;
 	log_debug(" compute_trans_from_raw raw = %s\n", level);
-- 
2.54.0

