Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D239D36B932
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825689; cv=none; b=dZTDQiHWTnJHhxZopS32zCoatvDmTlR5Bt1da1G8feLqV1cTD8wBK0UJRs+JNsWvceGCYxJMSocWr+Ou+35gQjxsRaBQW+1+MSerK91J/2nNNQqeLdpiilq65IPVtBpdeoSaGWa5figS2dZH8+/gnkncbQAluIZsupdgG9MHXSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825689; c=relaxed/simple;
	bh=/gSCkyTYhvEuARZCar23yqFFvN7UKhioQyqutaeiPAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LZ0n0jgdMf4rgCw8heQofR7Z5ADNFy+dei+6ef0cnsfq7ICKm3o5L8d+1NKKBTKdPxRKdxxPfzjaTsgKoVFGh4wFI6Z0hOjzOK4ezyeOudp4BXz+RsIER99pHcBm9EsB3c1ubaYGI80rlZPnXAO1aMczv2UejNPeMYvdzvfBB04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeOV7bnQ; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeOV7bnQ"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e5c92c389so70548685a.3
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 09:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784825687; x=1785430487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Esv/d8u3DEGfTbhMJWgk/+d4lyOGP5qky7gz5F5w7yM=;
        b=ZeOV7bnQC1fn/GPoFmLUkCMfC0teIBOw1M6CF0b9ue9X2pi5RguQzFdcP+bksOKrR5
         9KqWwerSQNzi4uXM1hQKXhjmgqdeJUE3Y7RyKLxcR+YE668XrVnq5/MMpkqLuJcp8dt+
         0zUePoIIxvvT3dzWWtwa3AjaZu6XjQcevQUfg2xzISMGSwCguyQu83DPV8wI7fT3fD7i
         clZxIM/3okUfx6TEKuFJa56UJocqyYP0tfSH4ro99IAMtMhW2ymLKUcIV6ofeMW20V2d
         zd2UzgZMA+ukMyUsVy/+b37c7fjGvbN/vDbE97n/CHtcBvm7byhmU2bOv2H860Xcc7xx
         XdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784825687; x=1785430487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Esv/d8u3DEGfTbhMJWgk/+d4lyOGP5qky7gz5F5w7yM=;
        b=pV24qhFdRrD0s1NBsUrrGdzSEky64/rvSp0j64/7M86Q7gWZBh8bjrO2P68cs1ZCcu
         RyYP0ss17V/Yb4ELttadZddotS4VvEy/sNavgGk7VWY50KaEYXlSywOD6/r/Cj7ZpPHD
         dEBxmc5iXlhaThUC5cQyX03Rmdy67AV+fsNtFqHZdJA8d1oTTKl4MaDJ08RbLX2Tghn4
         Xkv5/Z6tC8HhdOeLTlAqqB9e9Fx5kTMctUpfd1Ev1VOXuzuEU+w3rGxjDvqpYrt6usot
         PmeGMd0SUyVGMGioOam0QovThn/KWkRnmEUUnXQ2ABCLR1Ja9Cr0Xb87G/OE4uwCMTOb
         Isxg==
X-Gm-Message-State: AOJu0YxbQ67VwgmLgpou3tBBDqSHWSPXz993VC96WAKDu1JYf2fVyWwl
	LQ8Mm6bj3gb8Qgi51WG4peTc2nPqhnIljrVsHT2Zk9Yodp6RQn3D/QZxKj3Jxw==
X-Gm-Gg: AR+sD132NBhQrvErAX/QBiISsp/qHgbyJeiG8tZTU8gCdCTj4LUUaltSibwjk1NZqst
	/UKoBJHtNqe3PGXALNIJ7lVOezJTOck5JEm1DVRmOWCfXuDby4pBmjhF5ZsvJBSvu5voBLb2hG3
	rOrwGip64HWEqVoLKgjct53I6aUz7Gfq5NdMUk3jJU3zQLZCYsAYVpNTScrctQ07+Q/i3IacFlE
	SPUkMSH++Tczl5Vo3Yc1119JOQC78nhn3PAzXKc/UfiJzIn9vUKh9Ngw7fxs+sX5W/SBHcYqUQJ
	41oOo7qxdUSGqFeUKv0tXSUDPgQey2J8VZyLhtPGkzX7LKEq7GYvRz60JwBPusGSP3ly5mftDlm
	YshhQw68h4h1kg3DUEJ92qG3x3VKIbUu+rM/vieCetaZtmoGUtXaOBlBl4RA8L/KjqauzG1tb2M
	3MkcZL5D4V16W2FlMr7sSax0Kb
X-Received: by 2002:a05:620a:258f:b0:92b:67e6:8abc with SMTP id af79cd13be357-93103a59f8amr379549485a.70.1784825686716;
        Thu, 23 Jul 2026 09:54:46 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907baa0ee46sm48639016d6.42.2026.07.23.09.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 09:54:45 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH v2] libsepol: Validate string fields used in various labeling rules
Date: Thu, 23 Jul 2026 12:54:36 -0400
Message-ID: <20260723165436.10978-1-jwcart2@gmail.com>
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
v2: Added another check in validate_genfs() and a check in
     validate_filename_trans_rules

 libsepol/src/policydb_validate.c | 35 +++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index cde0b8d6..e7d79871 100644
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
@@ -1590,9 +1611,11 @@ static int validate_genfs(sepol_handle_t *handle, const policydb_t *p,
 			    validate_value(octx->v.sclass,
 					   &flavors[SYM_CLASSES]))
 				goto bad;
+			if (validate_string_field(octx->u.name))
+				goto bad;
 		}
 
-		if (!genfs->fstype)
+		if (validate_string_field(genfs->fstype))
 			goto bad;
 	}
 
@@ -1728,6 +1751,8 @@ validate_filename_trans_rules(sepol_handle_t *handle,
 			goto bad;
 		if (validate_simpletype(filename_trans->otype, p, flavors))
 			goto bad;
+		if (validate_string_field(filename_trans->name))
+			goto bad;
 
 		/* currently only the RULE_SELF flag can be set */
 		switch (filename_trans->flags) {
-- 
2.55.0

