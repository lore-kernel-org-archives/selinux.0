Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B1B478E5A
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577998; cv=none; b=CWfzEhPD+woDdgdO8m6XegJkBVT3Owcod+a9KxVCXgyLUjO1EE6v1bqRInBFaYp6Uv6cJ7uc5crVjP+0OZPAks4Q+WjubROZQdak56AzFjahSFMB4WjY/SNKW7i+lkqbYkUjQWD9b7xSzgjNLOEpHQAMKl8DTD0wrB5oUIf3mg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577998; c=relaxed/simple;
	bh=KpQ6O/T2oPpW+N54MB5He7TuQRuKu+IEEraIoUbZTPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kDswpVBjpiBif9f737tFi5wpwRd4DCj+WKLrmjnjUv2LGvXvq3pOllH1uLjxjjsPaz1gTTyh9T70QYMJq7xWcWoJFp+4MJ27TSxSPxDBw5LpGbBF8MICA6JNVEQHIl5VrZ/ovx2DqyfAL08MGAaIS/MoMVGfwCkCv4ZTYKhFga0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oGCEiw51; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGCEiw51"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9157b94a07aso103424985a.0
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 05:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780577996; x=1781182796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yyj8CoBBeql47D3d0XJPhKw764+9/q2qDRjH6y1WVx4=;
        b=oGCEiw51cLzVovO30yI5IyYSjE8lnCgysf3DWLdVhyuN4R66jYX0fHINSRZ2sZ/J93
         g5wjEynb59qxnUXmPKljeQ/7TtzVQkOH2e5swsAJpgq1hKrglt3EWgrMkgokCYT/x7Aj
         M4NeCC+51+xnukR/Dv0xBlU00PsxlK6R+UTEpVzs6J4276JwfhuzPXGzooiexZwuFyUD
         5kivniKrIQiWLfJB6Zy3nBylbWMipuTz7LrUCpqa8eFrwTMGIjf7cwCPjqzfCS3fVm35
         /uDHdfpt9oFxjbKgvdXPdaMjjMbb2MF6WAIbCcCxgQ7/XccBgFJfGCFHV6H+YNuk1Ryc
         juJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780577996; x=1781182796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyj8CoBBeql47D3d0XJPhKw764+9/q2qDRjH6y1WVx4=;
        b=IiDGAttreheBSMFqv432Gaq4Z/j2fZ7kQ6q3jynDtSAkqoMt22eM5ZVU8jmkBJpWy1
         W0TJHllwMwHBEOu5KcGWV8o7Dqrr4toIJCYDFL+4qaGBRTnWMgVAWmCcVljZIWAvc820
         ZJ9ML8MsqGawOk3Erkf75yRUBZy95bs3IWyxr/xRUXBT18Iyqr1K4qIT3iFQuy2/uzXI
         RG38lDzdsqs0s4MXGV+pWmhPfprcXsxEYdESiWZxZlge+bDzyBVY7KvnKpMfwttv98yw
         HApiuCWE1e3j65vLisvxUu+SvzuoWQczzwojt1/2mNQfljqckhKPsfqIiW/h04XyBux8
         hBEg==
X-Gm-Message-State: AOJu0Yw2a/eT4/k/KDmQO2Q917KHJR3Z/6OmmLYFS3xBvKX9JiVdsa7P
	DPTNq2jdh6+JaH/e0QtwMe/JRJNEpFUdo/DCMjzKPh+ir++7EGyusMi4BZq16A==
X-Gm-Gg: Acq92OGmzvkyM5sDwhojKWnhy+JNwMWxMwdYZ34GKLazN20gi1/28GsM2GWg4dE6IOI
	/quxvc6FIA1/NQ/0m1mHXHG3SLRuDU26TrSVYn2b0vUVnaPNcZZtjkUX4VodEk6pJmjOdPJO40K
	rfQePaQYDFTgUvxDI0B6LRszEpkEuZuY6q5YTE7k+nZCKkBj5eyLK09OpRL3sZpJMg0OfDW4B5z
	wEQQuc18dpaVQesX9QZmtKj2hhJXZ9FnpJyaW8BNiXbWJzcGabYhcS8V+eqs7Xy3e2rY1R3sKgO
	Q8aHdaNa1GsrYjCvaIIml/BPF8OvKMiSjitrdvebThOxlwSe+j1JMuoStU0fLD1nYatH6puRSvH
	uYCxxh/0U+ME2ivlFgOO8sXgJ6ZmuKnI89J6xLASvvc0K1I61PLuz7bVUy/G8DIubYLowwvkmTA
	VJTmRZPuDryA11C3vjqaXp5edejGmx4DtAvf6guelWI0wX3CNknlXrfnESTvFcSWXlvputKmlys
	Qh2bvIT7yT2/5YBLUyev1jkGvAuQhRhCK2jeg==
X-Received: by 2002:a05:620a:3199:b0:915:7c1a:138f with SMTP id af79cd13be357-9158a6a9f2amr1228916085a.14.1780577996097;
        Thu, 04 Jun 2026 05:59:56 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a37c4e6sm572141185a.26.2026.06.04.05.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:59:55 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: serialize legacy compat_validate() callbacks
Date: Thu,  4 Jun 2026 08:59:40 -0400
Message-ID: <20260604125940.255722-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

selabel_fini() calls compat_validate() per lookup. If a legacy
myinvalidcon or mycanoncon callback is set, e.g. via the
matchpathcon_init_prefix() call by selinux_file_context_verify() or
selinux_lsetfilecon_default(), then the callback is invoked with no
locking and will validate or canonicalize the context on every
lookup. Replicate the logic from selabel_validate() so that we only
perform such validation or canonicalization once and that we do so
with appropriate locking.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/matchpathcon.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 66cbb0dd..2623e5dc 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -43,11 +43,30 @@ int compat_validate(const struct selabel_handle *rec,
 	int rc;
 	char **ctx = &contexts->ctx_raw;
 
-	if (myinvalidcon)
-		rc = myinvalidcon(path, lineno, *ctx);
-	else if (mycanoncon)
-		rc = mycanoncon(path, lineno, ctx);
-	else if (rec->validating) {
+	if (myinvalidcon || mycanoncon) {
+		bool validated =
+			__atomic_load_n(&contexts->validated, __ATOMIC_ACQUIRE);
+		if (validated)
+			return 0;
+
+		__pthread_mutex_lock(&contexts->lock);
+		validated =
+			__atomic_load_n(&contexts->validated, __ATOMIC_ACQUIRE);
+		if (validated) {
+			__pthread_mutex_unlock(&contexts->lock);
+			return 0;
+		}
+
+		if (myinvalidcon)
+			rc = myinvalidcon(path, lineno, *ctx);
+		else
+			rc = mycanoncon(path, lineno, ctx);
+
+		if (rc == 0)
+			__atomic_store_n(&contexts->validated, true,
+					 __ATOMIC_RELEASE);
+		__pthread_mutex_unlock(&contexts->lock);
+	} else if (rec->validating) {
 		rc = selabel_validate(contexts);
 		if (rc < 0) {
 			if (lineno) {
-- 
2.54.0

