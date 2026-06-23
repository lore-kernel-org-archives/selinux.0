Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF4A38D3F9
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237008; cv=none; b=G3A26eoZQ0BXlRwXhnC3i8GaUy+eTALspeOjZDTDjVVGa8BYTAwYCDESGx28x7ow6SJ4KYYXQVdW6C/ElRwPiIo6dS2pkaJVa/LT4uRP0bc92p+YquObEBHaWLNRZacNHcXndDNKkq4jaGiSWF5ywp3UssW2WgtkMV+FzQLHudw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237008; c=relaxed/simple;
	bh=9itEDtKe2xi0B9/rw+fGsrKIpMClfuVrW9sf64xYq10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XrRg8znSgfydRFm4ChzZU1YA3LQr8ZeKUgoxf3Ic8WiMT5cp9obKB+uois8zmw0CMpUtiQ6hqRfGK8xkQSQ8Y6TLNnUyrNDXoQuHC7AGMIU0B4PkBLzBh3wBfA3Guho0QimLxSZMKseTshy/R2nMy0vlWY+7NmPH/xtY1kduWIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e741uWvR; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e741uWvR"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-91587626ae1so4244885a.3
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 10:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237006; x=1782841806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1ZL1V2Az2gOL9s4HdeFyQtWQEp60vwBb+AVbR/yuP4=;
        b=e741uWvRH2rbHOCDWW06LmmzKG1fPaRloo8C9KHk5eOdcgikS/Lnkl1t8fPXmPFOWi
         /wV9irz5XPSJ5VbXxIJrOjCQHrWU/f8d/cVL+eecwYfOyP7Tahz7rBDh04XvIt1IqLIW
         srJliXQ5+2N7M9DgPCiXxNI5ZxBV3/eyjrkuxLfHZc1+moPwk3U2ee5s/h2EAiBZpl8a
         H6MIX7hIfnJLBjAAlF0OAUbaSFzVOfM4mQIr4bNGhBIQel7b/jPOrMPB/aCU90QiSmFr
         FJuBjyL8K8PEd8lFm/Ksvy9xamoHsH6Pnjc45VHZQlUCOfw/Ae0Az+FoZSlraZ+jdp/Y
         LSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237006; x=1782841806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N1ZL1V2Az2gOL9s4HdeFyQtWQEp60vwBb+AVbR/yuP4=;
        b=sHgpg0u3FZGp8II5Opn85NU2EYw0xzMy8udDVc1FV6gVNVX98xFJF1kUFNXIPgC47R
         CrA3+G/mlSFz+myvdmWcBJfsB4PGxB4XNgWQ0NKvnTwH6klGwmP99RtlHdPOwDjQtUiA
         1+67J+og0qkUVF+rpCdLrqK+dHwv8CeO9/Ro9XtF52QLSC+ImfPTdGKdywCbdnRlOJ8a
         O6jUbl8z3QqFEerbp4lQzp8q63D4KdNf0W0JhpzVZfYumxC87zhdhCKJbqaCUw5UDz+/
         OkZUGXqXhjNi6f5/kIB/iMZohGBe5SM4QrOz4XAkfxiXBLWyA1JoOdfHPOLILrSV3m7D
         FhGQ==
X-Gm-Message-State: AOJu0Yz8ouPZ3TbjRCNV3kfu5drhgJRQHelxECrudByPhZPwmiBdas1Y
	P/jbwjMfBA87bCIGbesOt+lc/kPRbkSojVs/hve7oDya8fd4TtPbufPi56uBMg==
X-Gm-Gg: AfdE7ckpRXqekO8Mu7sZxpHmU7Q6TchGB63vWjG2HO4Gq6Dn4tg3ihLRR96QVYdrKsM
	wffUm1VgMuya6AZrYGTnEEr0xmY63jr52duM0x4IBPAtmR/t1KvyPEl73dZXqQO1pRhONckUTNy
	Fyip2QeUbh0CfEiVcoGiN/cLRvESDd0vUt3JN5UtdG2o7yZRQeA1X6yjZLZGceNJCaYNYtpmQ2l
	jb+xsjpSFFQKQLD2CL8isL5o+j+GG45vLNVZ2ju5mis2KPTgrRY0kcvZSExCfrMhCUX8Ad7s9sS
	FNcPsVuHer2iNiGKHO2V+3r1p+wBhasXMyLa4l9Ui0li13uYu+Z2DJfOvF1u1btVuEo2GaFY+2/
	eC/6YO6FSQZxigBlT7HM6K9NxwQHdaQHUtV9MAbXbpXTWSqcsZhM63aU1clvR0Kvrc5Cxrlvwfy
	Ng+yyrO8oyJydXbNUjh5xRH7wmmEfq2yaFHrM=
X-Received: by 2002:a05:620a:19a6:b0:916:1806:302d with SMTP id af79cd13be357-927851e25c8mr1564485a.58.1782237006303;
        Tue, 23 Jun 2026 10:50:06 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df826927cesm130109646d6.41.2026.06.23.10.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:05 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/6 v5] libsepol/cil: Add overflow checks for circular reference checks
Date: Tue, 23 Jun 2026 13:49:48 -0400
Message-ID: <20260623174951.22074-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623174951.22074-1-jwcart2@gmail.com>
References: <20260623174951.22074-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When resolving aliases a check is made for circular references.
Similar checks for circular references are made for user, role,
and type bounds and for class permissions (class mappings and
class permission sets make circular references possible).

These checks use the common idiom of using "limit *= 2", but
there is no check for overflow.

Use the __builtin_mul_overflow() family of functions that will
do the multiplication while checking for overflow.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
v5: No changes

 libsepol/cil/src/cil_resolve_ast.c |  5 ++++-
 libsepol/cil/src/cil_verify.c      | 20 ++++++++++++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index bdbb871a..a805ca17 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -652,8 +652,11 @@ static int cil_resolve_alias_to_actual(struct cil_tree_node *current,
 		}
 
 		if (steps == limit) {
+			if (__builtin_smul_overflow(limit, 2, &limit)) {
+				cil_tree_log(current, CIL_ERR, "Overflow");
+				return SEPOL_ERR;
+			}
 			steps = 0;
-			limit *= 2;
 			a2 = a1;
 		}
 	}
diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index eb732e44..699cdccf 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -975,8 +975,11 @@ static int __cil_verify_user_pre_eval(struct cil_tree_node *node)
 			}
 
 			if (steps == limit) {
+				if (__builtin_smul_overflow(limit, 2, &limit)) {
+					cil_log(CIL_ERR, "Overflow\n");
+					goto exit;
+				}
 				steps = 0;
-				limit *= 2;
 				u1 = u2;
 			}
 
@@ -1028,8 +1031,11 @@ static int __cil_verify_role(struct cil_tree_node *node)
 		}
 
 		if (steps == limit) {
+			if (__builtin_smul_overflow(limit, 2, &limit)) {
+				cil_log(CIL_ERR, "Overflow\n");
+				goto exit;
+			}
 			steps = 0;
-			limit *= 2;
 			r1 = r2;
 		}
 
@@ -1060,8 +1066,11 @@ static int __cil_verify_type(struct cil_tree_node *node)
 		}
 
 		if (steps == limit) {
+			if (__builtin_smul_overflow(limit, 2, &limit)) {
+				cil_log(CIL_ERR, "Overflow\n");
+				goto exit;
+			}
 			steps = 0;
-			limit *= 2;
 			t1 = t2;
 		}
 
@@ -2112,8 +2121,11 @@ static int __cil_verify_classperms(struct cil_list *classperms,
 	} else {
 		steps++;
 		if (steps > limit) {
+			if (__builtin_umul_overflow(limit, 2, &limit)) {
+				cil_log(CIL_ERR, "Overflow\n");
+				goto exit;
+			}
 			steps = 1;
-			limit *= 2;
 			orig = cur;
 		}
 	}
-- 
2.54.0

