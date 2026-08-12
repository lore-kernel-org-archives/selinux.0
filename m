Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D514476690
	for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550330; cv=none; b=qBo9U+b6D/HQ7zGBrOUHAL5nze5DnNnr5UHQpz3GGoOl51+YAWAwZ8CR20vUQaT8TObjK032ZIXVbTv4iqB5qtr0rpQA0bIxGqmrbhVTvytv/L/NZxDrMcrTUm1z/nhf8cTkIfv2re/Xv8Bv9ASpF9uTjwei/1Ftj4XaZ+Bs2Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550330; c=relaxed/simple;
	bh=u7KhGzyfc8hYs+r2qtiN0hdpKgRTX1g3iJlL1fBhc5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HZPBsU2zPw8kWFjkat9g9ck7BT2HyVyKKoJ90EQFWr/8Xxr3qqrum3ecem/VL5ts2mOR2VOWKt5xAjKBMk+VQAHjTjRf5pdatzJpYALE3n0MVH2w+kUBlzIF6aanHfkmMh72vrsPkvqZq54e5CNoquhjxR68uAwlwUs0gjfeZXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1zuO0Dn; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1zuO0Dn"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-9349ad9c857so133492085a.1
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 08:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786550325; x=1787155125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=McjP3DyfO1J2rwl71wT6YjCiOE6AOUt+6I5gH6jcWIc=;
        b=D1zuO0DnP50JDoy3sikl9jXIDONaWwXQTOVNjVFZbKeW1AbcYnkGmGx5IElMe2Qdi0
         8gy8iunukNfSXF+tcwKudtjiSHJiMRubJnA835IylUdOKy2R45GlQOU149biL4sKuUBf
         XLtzCB4SWJxPqoWgNH/iAmAkQr4nRuTmB5lpIcvVueLxto+BUl6GruYJTKiZl0im2rKu
         Il4ya8DVlHMM8xEPiI8rfOXJ/luZlQrIW8mXWVn19gqAzarTmP1y6p0gLS503OgY+TaO
         GUQQ4ZDxXtLz/qGYxlSd62dZnx4ViJHStCQ36Q/w9zEwyvAhlNudyatfC0tJCUIGib8v
         nFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786550325; x=1787155125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=McjP3DyfO1J2rwl71wT6YjCiOE6AOUt+6I5gH6jcWIc=;
        b=Pp+SaIfTBNivPuH4NpqdIfbYIxa9diXO2K83m4TM4e4LLRI9wijams0olN3VWxVxMZ
         /DyMIxpJljY+/YOAS/3gHbUtWmVDgC6RaFv16v3xvkZ73pgyazlWny20sN6X4XovWRa2
         4K74K5WKR8pGzwymRciLNpSxPQw6uTuTebdo0gap+KFhoL1i2Im3OGaqmi5tbAyy/VNl
         29d5W80aAyffH/+8FD7wWAxibq37RBAfF3G1Zt5g26JXuV0Wz0xbq/qJgoXua0axy8Ag
         d1qMd+nvqOX4rhvKDUadtCyOb5Pq2C/dgKIYIgs6rlXuF/gomQgIgxYrSVj/MLoFMopX
         7HGA==
X-Gm-Message-State: AOJu0YzoXJ07FrJnTSNkUKFnFG2pIhREQwO92dTPc7DXI+rxlXeRRLMg
	+dl25DkK2BFEq9JWvSOc0SPi48Woe3NvqG9lV95nBI88SQm29yGttLqXUctdag==
X-Gm-Gg: AR+sD11bSumyBVO8hsuRYvAvOhtgPtMTozcKePUMsOifvCr8sYlajWPrYrXWriKrZui
	QzHSbm89lK1umIICaLs+9nLbaLaJnSHriCADXlxyr5rBV3KwKWAbesQwaquOGPk0djQI6nExVGv
	Ae20UhzIutBrg8BUz0W8jzTuy7wPex8kn9urQocohGnwRmOs23buYu3n5k9ipTsjAnkT4gJkX2j
	dirjau2tjuorIuu5IZpB7CjnKrUIdhJXJGe6kKm25hhSJDKLyjauBLIJczEuI0lsSI0pWtej0px
	4FBhGWOAXqUylWglE5qp8q97blInHiuFPq/UmWYrXs+l5q6JM3gKwXOHOhPsMF5wPVRA0+Pciu8
	5q2L0Qsdol5HKgyG/BJvpNLs6G7A40WddzhnS35jnA1G8gCLYYGuTleNpio20z+GyZNEzStux1U
	CF2aTPg+0ewjtC7/DrL61jYqnlLn9sJl5EKJT5FNMbevSGdWLnYlz6CDsJawL8+wXX3MeLLU2aW
	9w8kmMCqSI=
X-Received: by 2002:a05:620a:1994:b0:92e:4799:a808 with SMTP id af79cd13be357-936b3d97196mr497290885a.40.1786550325135;
        Wed, 12 Aug 2026 08:58:45 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936b5dd67b0sm161729785a.1.2026.08.12.08.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 08:58:44 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Free context on genfscon wildcard error in kernel_to_*
Date: Wed, 12 Aug 2026 11:58:31 -0400
Message-ID: <20260812155831.16467-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A policy with the policy capability genfs_seclabel_wildcard should
have all of its genfscon paths end with "*" (which is added for
backwards compatibility when compiling the policy). When converting
a kernel policy to CIL or a policy.conf, an error occurs if the
genfscon path does not end with "*". On this error path the context
is not freed in either kernel_to_cil or kernel_to_conf.

Free the context when exiting with an error for a genfscon path not
ending with a "*" when required.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/kernel_to_cil.c  | 1 +
 libsepol/src/kernel_to_conf.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index f64eb896..f274d597 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -2964,6 +2964,7 @@ static int write_genfscon_rules_to_cil(FILE *out, struct policydb *pdb)
 				    name[name_len - 1] != '*') {
 					ERR(NULL,
 					    "genfscon path must end with '*' when genfs_seclabel_wildcard");
+					free(ctx);
 					rc = -1;
 					goto exit;
 				}
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 9bfe5b38..c6e8fadd 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -2825,6 +2825,7 @@ static int write_genfscon_rules_to_conf(FILE *out, struct policydb *pdb)
 				    name[name_len - 1] != '*') {
 					ERR(NULL,
 					    "genfscon path must end with '*' when genfs_seclabel_wildcard");
+					free(ctx);
 					rc = -1;
 					goto exit;
 				}
-- 
2.55.0

