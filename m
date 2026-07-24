Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E3338947F
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921327; cv=none; b=VW/bkBfBYLcx6aIU42Up94fNioJG4qtUFz339ke7EkqLi5yx0P380H/yQROqrnw0ejvNJdr334xoF91f1G/tSe+M7+O8f0vD2eSZo9wJPn8fAs1hmHSTRihxsxK7hE55fsC/nN3Gc7SkjLwvBJhghy7ONyDmrYpsSrszy8vCV5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921327; c=relaxed/simple;
	bh=ESru2QQB6UgD1UKNfTEjMi49d1YNzaS2MY8t4ww2s/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fZUdyEmeAWiHT+cJwRtQ7CGNVcvsxcskKVBquPkYdrmHUam6E46Xh+SLkrRdr6dSZHGhOXE9jN+Uyz6AKViB0f0dgcQTVlsSaU0jhvfCjRrgifocUIrD6MqqDTdAW9KkdSyOPAg8TAbHfEm6TmDiPR2uZgHxp4G1Vpaw04grUFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThLDXufz; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThLDXufz"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9305a2121a1so73300885a.2
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 12:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784921325; x=1785526125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D8mbx/Qyo4pZdJy63KfVAJH4xcGIS2BraTYRAoBLbgk=;
        b=ThLDXufzPdvkBhld9O5TLkwpz9dQmLZgSbyHvIMbvtVp4MVBymfHeWwVWgbovIk4Y3
         TRT24AWiRIQ/SKUMwnmUg8ofr6QGUeQ51PsJURiCK5U/763iszXxC/zjC1ZiPEmay42/
         6cJgi0+sLgDniOMiYtBDJLDFlmr8LDvSrSEQggJdu9bFL0IeKcP/ouuT+7My1M4mrOdk
         1oo47ePuQ0VOJlQlOCN0baqieQuTdOYBpb7U2Q0h29mP+PJVX0J6GlJKmxl0zQNrFmQR
         FXrr/Zh6SlpmrQJ9N5z7yu9AcrpNGcgDkGreuNatJr9Hq/jHZlzD98LOkAZFjoI5DHWy
         Km+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784921325; x=1785526125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D8mbx/Qyo4pZdJy63KfVAJH4xcGIS2BraTYRAoBLbgk=;
        b=l/eURztrPJCKqn7V9VDu7sBNue/zPIyAbtpW/hXPX6HQPIsdBTmX4znqIBsPJEtOU8
         cUNRR5B2rfPn1ZN+c8f4X4zkzMQj1jzv18gCp7Gr7b4CCUUnAWZEzFjmp7Xbonp1XJ4X
         Fr6xe3OoCuWoXoxCq6g/+GQ+ilpZ00YeQQalpT72NobwvzUxI4TnuP2GT7PFjSrv3BPy
         2FfRy73SNMb73lLQaa2aC/UddkYDC0N5Il60QlcfrdP4NLn3XC+QlS8/lkeW9PTHcLfj
         zYbaNLqnqE1U/sTt2scC0lxeGiX6gN+bU1VaJXh65lUJKXZV3hVHb6qvqX+3jXKddGkR
         VaTA==
X-Gm-Message-State: AOJu0YydYdwWt0k0HEAMMIjirARSUU4wVkXHOp5CjVnbPb1DTE5QJzHH
	RehRVl7i8xq3iBJme18M7qampDkabMf2DUR4mVaHir1wHQp/eWiTDg98SnX4rg==
X-Gm-Gg: AR+sD120p4rQchfI62CYU5/KvyZm4uxkM0DVyiaRsJo/fYd0REXGpqi4xL1ydgQKvth
	2Pr9Eis9+YQS3MGvd1NPQp2bpu6JPNSdnQB7dZGZJWFUEt6RvqNDp//TmGpmoy3iKcmQt9akP4o
	ufUFVrqpHiyqjqg2gUUmWUS0PD1RzuSEKwFtchyI9bMDE46yOniJOkJ//V8Vv08qSybU11+FalW
	DaMh6OfTaDplIwYKgfdkeOvVKPhC73nP1wXkygIUcO30kzM909xHzIjRLBSxYwlDTVfJoDgxS18
	qukbFuV7vDdp5ZSFRLfAjEKBcveELWQO4O/IfRQHBvZjj8w6HxaZFgXtTSJbeQzEFDe4ilNsnx6
	5M+17JKu26mdNo6rx8yaholexeggXRRfvvn7boeFBLw/79fqiewfYLyvd0AokSqVuHsQECfaTpG
	VxbnVnuZT4P0nACy72ocCWp8V8
X-Received: by 2002:a05:620a:711b:b0:92c:103d:63dd with SMTP id af79cd13be357-93103a73a3fmr875977285a.39.1784921324733;
        Fri, 24 Jul 2026 12:28:44 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f6a88b88sm714770385a.42.2026.07.24.12.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:28:44 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Add overflow checks when linking file and netfilter contexts
Date: Fri, 24 Jul 2026 15:28:30 -0400
Message-ID: <20260724192831.106384-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use __builtin_add_overflow() when calculating the total length
of all the file and netfilter contexts.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/module.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/module.c b/libsepol/src/module.c
index 5fcf5870..8aaa693d 100644
--- a/libsepol/src/module.c
+++ b/libsepol/src/module.c
@@ -249,7 +249,8 @@ static int link_file_contexts(sepol_module_package_t *base,
 
 	fc_len = base->file_contexts_len;
 	for (i = 0; i < num_modules; i++) {
-		fc_len += modules[i]->file_contexts_len;
+		if (__builtin_add_overflow(fc_len, modules[i]->file_contexts_len, &fc_len))
+			return -1;
 	}
 
 	if ((s = (char *)realloc(base->file_contexts, fc_len)) == NULL) {
@@ -281,7 +282,8 @@ static int link_netfilter_contexts(sepol_module_package_t *base,
 
 	base_nc_len = base->netfilter_contexts_len;
 	for (i = 0; i < num_modules; i++) {
-		base_nc_len += modules[i]->netfilter_contexts_len;
+		if (__builtin_add_overflow(base_nc_len, modules[i]->netfilter_contexts_len, &base_nc_len))
+			return -1;
 	}
 
 	if ((base_context = (char *)realloc(base->netfilter_contexts,
-- 
2.55.0

