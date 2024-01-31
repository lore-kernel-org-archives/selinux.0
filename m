Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FCE3770D
	for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706533; cv=none; b=M4S4t+5oGpVJTvNglKdSektnLgY20MPFUwYHbQyBCQHAFvM5n/Tzfci4r6WI7AHr7MCYJrBsvns4C/M0WX9DR9GWLI5GZyh8QZxiYfreYwOv/AtHHIvp3d7kMiQHJWzqCuLQFVeVFpUHTRlgXyo4bYmO1PUbswUkrpLX2hJrDOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706533; c=relaxed/simple;
	bh=Rko/Z9f9+8RoY7GaIKD/Ck/VhvpzZ3Q3vSoY2camtso=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=npBbNFoAMEXrwWnQCq1jmSaZe6VvDqlKNi6wOSlTm/cdwZcvmoZo7HDb8rXg0teql6h1YmRTl2l/QlaSqa9DsuUqs++EegrLfZqP4WLL5OSX0deVxQEnanmgTgaVGP/cDLrDuSrQ8pKoS7y70pSReFUhFICZtVi2XCHgHqjlMkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=fPx5w8K+; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fPx5w8K+"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so5421210a12.1
        for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 05:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706706529; x=1707311329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ToK4XXgZ5kkZunydINKtvzubqHvkuDujxfP8g7u1RoU=;
        b=fPx5w8K+uH9fGg8bG/54nPoEi+CD6l6vkcNizXbTcK3XplUEbz+CiTsOErAwqI04gN
         Vj0fLbsI19JNHBfd37PfWj86kcOgqsJjavBG66qYmcSPLbgx9igXFVXi9zixojbdrflJ
         mL+52qFGcZedYZnaX08IXlRjT99uuTUIJGR5NA9v2ueJxAlZdl91SOaz0pxOKyRfNndK
         DBoP/9gUjrr7hhkus2Auz8iT0YPtStYHUGhEmOHKEvHEJpXgHzKeJlLdsAMRgXDWBVZv
         weG6XEQx6PfgaiCtvsSPaiI+9+2aU6HfAQ+4phgsmgmcjo8mkAonyp8970WEBYB89CU/
         Qp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706706529; x=1707311329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToK4XXgZ5kkZunydINKtvzubqHvkuDujxfP8g7u1RoU=;
        b=CPuIn3qTAZ15lAPZbKpf+9zqBXM3EIqNgx7csRhrzH8+Cj+2vRzvQsECYhdMjJylh5
         NsCnuZfR4bBtEAt5OWuZx2vb4M7hxXn/uoKmZpHf1O5hHQahchWjl0Qo2wzeJv8J10Xz
         QJCOB7X4+JhrwThVKFS6VYTU5fHZQyfhyJH0Puavg0gAvyrxcrcqKDf7vl4iPbwmXJFh
         IgnIkvd/PEu3VmB67nX7yenz6g9uhd2lFv6KTg+w+qSAdmQ15nPc1SWwufN+EczSIyON
         pkXKSwBHV4nN3/a7b2i+qD1iYNFo8jnNc/hy919BSS1Uu3NtmvMw14oodPyc8uP7rTAa
         r6SQ==
X-Gm-Message-State: AOJu0YzwAoyCdh8ddiIH+bIPAonFoE/VrKY1VYV6CNEP/5PSI8/j09/R
	eQSeG1KpRh24Sds8/4lbReK2hyAMU/l8cW7zfNaTiSsa58BUtp09u1x8Yek7
X-Google-Smtp-Source: AGHT+IHaJdPWXzYR47nqrh7f/Yby3JbpiQN1Rh0WXirrrG5yLoUqcP1IP8E8/vSHlXsHbSAzZC3Fgg==
X-Received: by 2002:a17:906:1152:b0:a31:1c94:3431 with SMTP id i18-20020a170906115200b00a311c943431mr1070341eja.46.1706706529554;
        Wed, 31 Jan 2024 05:08:49 -0800 (PST)
Received: from ddev.DebianHome (dynamic-078-050-045-093.78.50.pool.telefonica.de. [78.50.45.93])
        by smtp.gmail.com with ESMTPSA id p14-20020a170906784e00b00a365c673251sm890351ejm.216.2024.01.31.05.08.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:08:49 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [RFC PATCH v2 4/9] libselinux: add unique id to sidtab entries
Date: Wed, 31 Jan 2024 14:08:30 +0100
Message-ID: <20240131130840.48155-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131130840.48155-1-cgzones@googlemail.com>
References: <20240131130840.48155-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Reinterpret the currently unused - and always initialized to 1 - member
refcnt of the struct security_id to hold a unique number identifying
the sidtab entry.  This identifier can be used instead of the full
context string within other data structures to minimize memory usage.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  add patch
---
 libselinux/include/selinux/avc.h | 2 +-
 libselinux/src/avc_sidtab.c      | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/libselinux/include/selinux/avc.h b/libselinux/include/selinux/avc.h
index 4bbd2382..361c5611 100644
--- a/libselinux/include/selinux/avc.h
+++ b/libselinux/include/selinux/avc.h
@@ -20,7 +20,7 @@ extern "C" {
  */
 struct security_id {
 	char * ctx;
-	unsigned int refcnt;
+	unsigned int id;
 };
 typedef struct security_id *security_id_t;
 
diff --git a/libselinux/src/avc_sidtab.c b/libselinux/src/avc_sidtab.c
index fce5bddf..9475dcb0 100644
--- a/libselinux/src/avc_sidtab.c
+++ b/libselinux/src/avc_sidtab.c
@@ -4,6 +4,7 @@
  * Author : Eamon Walsh, <ewalsh@epoch.ncsc.mil>
  */
 #include <errno.h>
+#include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
@@ -50,6 +51,11 @@ int sidtab_insert(struct sidtab *s, const char * ctx)
 	struct sidtab_node *newnode;
 	char * newctx;
 
+	if (s->nel >= UINT_MAX - 1) {
+		rc = -1;
+		goto out;
+	}
+
 	newnode = (struct sidtab_node *)avc_malloc(sizeof(*newnode));
 	if (!newnode) {
 		rc = -1;
@@ -65,9 +71,8 @@ int sidtab_insert(struct sidtab *s, const char * ctx)
 	hvalue = sidtab_hash(newctx);
 	newnode->next = s->htable[hvalue];
 	newnode->sid_s.ctx = newctx;
-	newnode->sid_s.refcnt = 1;	/* unused */
+	newnode->sid_s.id = ++s->nel;
 	s->htable[hvalue] = newnode;
-	s->nel++;
       out:
 	return rc;
 }
-- 
2.43.0

