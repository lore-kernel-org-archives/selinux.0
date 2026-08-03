Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E483A838A
	for <selinux@vger.kernel.org>; Mon,  3 Aug 2026 19:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787031; cv=none; b=lPmjbHUOIxw5z4JWNhGFxMnjurXkhTKIXXBQ3PADPlztBB4Ys5VF268Ao4Vq4AsMy/SvLPMD9EvRsDIlxhLBMVqlNA9aoM8B0hMSd8kxlRpAHJ+X6RAw/YyUaVjLWfJYNj1gLmmvULh6gLJ0/LGGnvrWk+KjMYASde7d539LIjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787031; c=relaxed/simple;
	bh=gE0cfp0pBi+wnlwITgBcPdGfuCh2vR0EovSYfLFFsGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S1uJpoTqOzbQ1hxHlde7AUqBpgBWKmvmEsReNWvC5WHdJKBqDhrkqwapfIXSLcDqxLTAuJg0mlPxJbs94drcCERgYQ4hkhRHa3Lylr0BdLbcXU2D+oQxTCG+/OR3tnb4emkG/VSO1GSnyiZOqL/GQArWjSNgTVUJHuHm/vJ3IfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVOMEO32; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVOMEO32"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92ed3993c1eso195014685a.1
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 12:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785787029; x=1786391829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NFygcJKd41P6ExJ8vK1TN54NRsJP2WoXgmov1Jz/pGc=;
        b=KVOMEO324DvXJSuY/m4qyb4eCDKslEPj1EvSDjZDFONdpeXh2WnO3aOMjYUld2UXXi
         KFosnai9ecZ3t15E58Fu7Y4PIXgZgP6YY1CaL8zqw9YKD1K1565xRIkw2qtrWcosAQ76
         BbLYjL4Dqnvro9qKte4Rlsz7isSLQzPQ59GpTMFVEbRfmSnx6rLcSKf68KxCXcoG1H1v
         60fqIDOGOVdeeOZ4fS44H+gvuS2c8vmP03EbYf5VuaIyXDUG0FfvtAgWZJdUjeXVF+qq
         1lX1Xg2JeJrQCwciD2guh95n5P8sMp6hoVt6W/gd/mYjmD4Ak4iWZz2zgCIlytrb/D2q
         Xr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785787029; x=1786391829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NFygcJKd41P6ExJ8vK1TN54NRsJP2WoXgmov1Jz/pGc=;
        b=J138KWDW8Ui7KKFQ/ifZ2Q2DT6I2G6zcR55rxeD1bWHFFbDmgd72YLC7AGHTFP6WLc
         0CoU2asmli3EPu07hplwWcssvPdFubJZqUf/ZM3Ha9OnH9azAnsMg5QTfzWQ0DKXXEeh
         Iqinhi8GxD+sISd298TW7Z8KsVmod5f+Eq7zFBNnNvV40SLKzTm1pn5vHy8+K6Imw/aX
         vsPFr681eSUZ2j6+T6FA8GjsgqEtlxSYlwJcWGiXF5qbVGoPwTtgnV2c5p9SnMRCjBn6
         1ccCfzsx8pHbGoMG2zUttD1ArQ7oVL9uAvYSNUwc7bHLv78bk/07wUn9qTeoWUvbvFi2
         M4zQ==
X-Gm-Message-State: AOJu0YwKIx3CI8KJo6Onti25tjyuY3rRj12moBx5AGV8JHy4Zj2e+TmG
	NHBXSiUzsjXjzrcPeJO9fiRyCcltvAIZJASiwq81k3lABbY4gAsWLsjurzINbg==
X-Gm-Gg: AR+sD11Du8wR9OQ+jEJ0mdIKs7ckn7j54+rjH0KI3tCMLl88S4mMM9Y7SYJJ38dgTIk
	BemJ/45dtNsVeh6/5PslRENAIvjVUb78bog5tLUn1mrEXEnmEsLSP9VjQdY0Sf61UGMGK8gCsxm
	n3sdMKSWTnD5Z1I/p3mj0PpnX/3FbbgQLSOl2tt+R76WXYnRbtNoIhUOle/nIabEI1u0TIwMh/8
	ItUOZor1sCHmQRXooSAiGFalXaq8emIph992sq9ym+iL5+xsHh75p9ogzXL379SlIfCvta7Ss9f
	VCak/lf8/S0F5/tJxjO+E3rawJY+DKdX8mTUaXz/e4xXBRBX3Dsc/WlmhOvydCWyYuIwCvsSR1A
	Km1BNtTc06oMmgoXjTjkjaN++Acuo4OscDTd32OfBn3lPxTtceDbqW3WJ/vBNhiVBHX3oxevv2Z
	T73dlIE6CMtykB5lM0eT9wgLTTdwyZxEAl2E/mYn8rQnANnGEOR9hwqdLWe0XGrL/qXH38SMolj
	vXqGxcPBgQwyqR626aBhUezZBWmvtEKIsB3a8SWlS6GoXvbo+n08ozwG7jYzLIX
X-Received: by 2002:a05:620a:72cc:10b0:92a:a400:df70 with SMTP id af79cd13be357-934a0acd4ecmr1674527085a.47.1785787028809;
        Mon, 03 Aug 2026 12:57:08 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349bc6d810sm746941985a.21.2026.08.03.12.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 12:57:08 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsepol: log an error if we hit the max depth for __evaluate_classperms_list()
Date: Mon,  3 Aug 2026 15:56:51 -0400
Message-ID: <20260803195652.49116-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a cil_log() statement so that we do not fail silently if we hit
the max depth. While we are here, introduce a #define for the max
depth and use it, and fix the comparison so that we fail immediately
when the depth has already reached the limit.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/cil/src/cil_post.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index 183b0d49..35c14fae 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -49,6 +49,8 @@
 #include "cil_symtab.h"
 #include "cil_deny.h"
 
+#define MAX_CLASSPERMS_DEPTH (32)
+
 #define GEN_REQUIRE_ATTR \
 	"cil_gen_require" /* Also in libsepol/src/module_to_cil.c */
 #define TYPEATTR_INFIX "_typeattr_" /* Also in libsepol/src/module_to_cil.c */
@@ -2296,8 +2298,11 @@ static int __evaluate_classperms_list(struct cil_list *classperms,
 	int rc = SEPOL_ERR;
 	struct cil_list_item *curr;
 
-	if (depth > 32)
+	if (depth >= MAX_CLASSPERMS_DEPTH) {
+		cil_log(CIL_ERR, "Exceeded max classperms depth (%u)",
+			MAX_CLASSPERMS_DEPTH);
 		return SEPOL_ERR;
+	}
 
 	cil_list_for_each(curr, classperms) {
 		if (curr->flavor == CIL_CLASSPERMS) {
-- 
2.55.0

