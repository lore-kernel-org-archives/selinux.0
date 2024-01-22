Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004483D0C6
	for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931724; cv=none; b=E16Os9CXwGKijUUO8q2Gz9qiTRrC79GailTdQ7qW241ze+91+s26lmNRIxMFyJybIe3ojD2S0MT5NOROmE4Y4n9sZrMVRxmYNl8udRAGs7Lu2Ot0ItKPSZZUrT+/x5+0r66tlJ/ytxkCoklopNhK5heoOiPghNr8BCplX6H1Vd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931724; c=relaxed/simple;
	bh=xis82JxSbpHr5AwIbSzLHs1dhNB92/ZKLEB8AqfYbIs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lP4mosabvR7rmDl4hY7fKGo2AjVnhSkqYZosOfcF2OO5CIVZteTxyTUOPIk4regVN6W9rV+tXATbG9pUW2vzRHp3IciN+GS34vnVbav9IR8uGzr6T5BRCuvK6Yfxmo6d8alxZqo8d80KbExeuMBVw36I/nmPysscl9PnRdbJmzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=AZ+usy53; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AZ+usy53"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a30359b97a8so122744166b.0
        for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 05:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705931721; x=1706536521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=usisRrEekDUKiINe7XGJ8beXSoJXiTApo333FaxAAJM=;
        b=AZ+usy53uiNP9nkTNnqJm7ePRqcy2qZJfXTKvy468+cayNOf3UpMAGn+ue2KtUwX2x
         ppHlXrzI3d72dBAnU7Qv5Wvq+lYTMp7gITjjYMz0FnwIEGZ2x8EVmpYDyguvIYw22d+M
         gWbrsvilZPGb+6UebB5F28W3uY9Pnd77tsd52ELtcT+VKN3BGeHjykx8GcNW+thDQS5K
         gWzFoUPQn4mvlTz3EAxxfhMQM5Nyfpk4jbUPepaU8Xo1EHsK4pRJ4RIdCS1MoN4b7t4f
         h65LIz3ybENx+BAde3eLalQLTizuknp7HPVP0WbXncKXBkak8ZuATKdezhkYvuFVd6E5
         /aBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705931721; x=1706536521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usisRrEekDUKiINe7XGJ8beXSoJXiTApo333FaxAAJM=;
        b=UZxKLmxNQwsxiXDzotrpFR3ALG09t2Exo6q1uZ38xJ+V67nc7paCR7mP9QdrMtOujF
         KAiddewk6Y85jqxzzwVIWhP9gzMrkr6MAc38iXRwNMTm633U8+vt84odTy3P9NlM5smt
         GOMKJ9hDNa3tR7dbQ+UdufntrAYWIb+r4JO+4KMVMcHdAI/b30M9YnED1B68XnInp8xh
         ZmVGowbRbnB2OKXM5IMOMTTTvHXRIrQSHDZMMGnrPEz0bAA0p5B4SFtl8Wmi5w0bJbko
         RW4N4bGBywwzu3KiboGcIMf4L0U5lt2DPVIHr2rDVZvccfcj9R93BhCNG92dae3WdIiM
         MQOA==
X-Gm-Message-State: AOJu0Yw1SXhTf547AcwFJzj9n9OGpIh5LFn1/pAbo0fVzuGvsD0Cearb
	WJg1hImaA/IGaIZVWfFsmGNuBzrsBtiF2q0Ul7Emo21CK3PmJmuEAECk+W2a
X-Google-Smtp-Source: AGHT+IGSXA1mGf2M0VX87P+5+v+CLBYvdlH3DAXCWZkIyBn6J8gInfRW4xREcGNjx7byf8w+2VL07Q==
X-Received: by 2002:a17:907:c00f:b0:a27:4bbe:5ddc with SMTP id ss15-20020a170907c00f00b00a274bbe5ddcmr2623922ejc.19.1705931721250;
        Mon, 22 Jan 2024 05:55:21 -0800 (PST)
Received: from ddev.DebianHome (dynamic-077-003-088-202.77.3.pool.telefonica.de. [77.3.88.202])
        by smtp.gmail.com with ESMTPSA id i16-20020a1709061cd000b00a28825e0a2bsm13340284ejh.22.2024.01.22.05.55.20
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 05:55:20 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 14/15] checkpolicy: avoid assigning garbage values
Date: Mon, 22 Jan 2024 14:55:06 +0100
Message-ID: <20240122135507.63506-14-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122135507.63506-1-cgzones@googlemail.com>
References: <20240122135507.63506-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Only assign the computed value on success, since it is not set by
declare_symbol() on failure.

Reported by GCC:

    module_compiler.c: In function 'create_role':
    module_compiler.c:287:24: warning: use of uninitialized value 'value' [CWE-457] [-Wanalyzer-use-of-uninitialized-value]
      287 |         datum->s.value = value;
          |         ~~~~~~~~~~~~~~~^~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/module_compiler.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index 464897cc..6ff91b8f 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -284,9 +284,8 @@ static int create_role(uint32_t scope, unsigned char isattr, role_datum_t **role
 		ret = require_symbol(SYM_ROLES, id, datum, &value, &value);
 	}
 
-	datum->s.value = value;
-
 	if (ret == 0) {
+		datum->s.value = value;
 		*role = datum;
 		*key = strdup(id);
 		if (*key == NULL) {
@@ -303,6 +302,7 @@ static int create_role(uint32_t scope, unsigned char isattr, role_datum_t **role
 			free(datum);
 			return -1;
 		}
+		datum->s.value = value;
 		*role = datum;
 		*key = id;
 	} else {
@@ -529,9 +529,8 @@ static int create_user(uint32_t scope, user_datum_t **user, char **key)
 		ret = require_symbol(SYM_USERS, id, datum, &value, &value);
 	}
 
-	datum->s.value = value;
-
 	if (ret == 0) {
+		datum->s.value = value;
 		*user = datum;
 		*key = strdup(id);
 		if (*key == NULL) {
@@ -539,6 +538,7 @@ static int create_user(uint32_t scope, user_datum_t **user, char **key)
 			return -1;
 		}
 	} else if (ret == 1) {
+		datum->s.value = value;
 		*user = datum;
 		*key = id;
 	} else {
-- 
2.43.0

