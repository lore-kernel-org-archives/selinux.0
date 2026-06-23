Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E28E21255A
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229792; cv=none; b=DTfaqEclNZeLQLeO/9U9Uf0DVgnwDSd8GzN2Dzouv+uA81omJSqVh3Q6a/nE0s+fmb1jbghlosMdtD9TqEjLC/P4o1GSQQxijHSChsCAUrPnvYollsJqRXdf+jJR2ewObypR5rdBkkxQu1SAZtdOIj8OmVigqAUun4ztGcYnDaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229792; c=relaxed/simple;
	bh=wdl4NQTPpLkNmlqYLG9yXDOehqB0EPGdR5M2+84ZXKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJrS6jZhxk1u3yAqOAhx+k0IZvlIFes/m3eAB5Pqq6O6IOIRtpaUwMFulJu5E1aJNQ2qK+c6XlN4U4GflgTh1juAv0+Iqs1FuIVmk9N9Saaub8xP6qdKSjNHVyPmLouy0BA3EpjPs8muUaNvT06WMd/HogqJ2HbPlaZuwJLHxHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMSBlqYc; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMSBlqYc"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8df26121c88so699366d6.0
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 08:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782229790; x=1782834590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08cpIMSJawx0PU70UuqinDwm7w0LFgCHACcGel/J0ns=;
        b=hMSBlqYcwAYayp/e4cHILwdYpZNaA052mRAx60+tF/R4MaQkUV+xYoabjqsEIuiueG
         MjWYlnFHQm5y+OUS9aYn9AxzZJxWFb3yW7vAmyFr/K+zR2mQhUtkYju7b4NevRx1It6j
         /LJJ0i2xYTWhBYyMIrq70DPCsRG52UwodMploWman2+dW7CnXDqOyWKJOUiYQJ1ruG0Q
         F91Xx2Td3eKOBm9MzmbvrZWtTVZ7xsC73y5bgUTs7hF9gCnqUKFfJQw2RrLiYuY1nxkR
         u0OtGH0FKpwkaVTmo638RcnMYYp0jydng8i7NlMX1/MM4ND7UnOWkXnW6A4lSmJSGAby
         Jd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782229790; x=1782834590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=08cpIMSJawx0PU70UuqinDwm7w0LFgCHACcGel/J0ns=;
        b=BfbyJ5Mu5aMsKdhvy/mf9TkDtvCR+a6c5tCLEWcax1NC+2AEH7BOj9EFzI42isnd9O
         gX0KiS+I6YmUPU0ie93U2Xk63F1OayeW6lEmN0psDlxccLbhX0Jf2LbhyQ/3HeULIApa
         zxM1YCe7oA5Wc3zgOzkP9Wl9gnLKHzrFwCzI010G089EPsmH8ah5Np3Cg1cPSJvSXRAa
         GvwBIdc7QuXitAH+t/8trt5cGswwvKQGw0I3TyltHbB339KuheasCPmlzIctpiSU4ODo
         1mpoh3LOcfqMf1lB+skmxjbg1B4urFSDl1SGGWr9SfbWECyovaL/+hChvycboPGix9Zp
         9QyQ==
X-Gm-Message-State: AOJu0YzEe4TEE2BkCkN3ysEjCHlXdaQ4FH3A6Jayd6mA68qBFonJ2r8+
	/GalbE8/cXxMFRNeOdsdTFmaZgqT2lelOGeK2zr3I/Bu8/3EcwYx85NuD+spNw==
X-Gm-Gg: AfdE7clmYPgRRUkh+rvkwxdb9PwzR+vwe1ysA3js76evgr1M6fsR/iI/hVrROGfVe6a
	Xml1yLKhQxxZkYnyh4ivD/W15nViNyW426M/y5BdkKJ4Ceo/xiVtaqnZL/GEXJ2K/AFwdrhJkmE
	W4GxUUi4a0vUYPDhzDvUkSdUV2bcvJ8bfD0273EXAOLTwkcsS4uh2+qUMJtoEk2SMginnp57DCf
	cwAgVkhW9aHpuacy16cNG9k+RnvCOMrfBwQ2LOWmMs7R6kOux3wLN/pvhOBlDrk4j3ziicUKoXr
	HuRaE1M5MHX5WeQAyHLngRHWdWdxDwOnVev3UH3cMhsMdzOENuUnIqEk/7LeKq4HDHBc1lf0K1f
	i7SnmnMDo6Et8PRCpGy+/XxlSIfO3U2fQf3blxo2kg0+r+AylLyIoQ14w2FHVVD+i8fi7evxTlv
	sMtUndM8Ea4mpTWMCBn7suKGTPGU0HSAIWJYMn+k3OehR02Q==
X-Received: by 2002:a05:6214:6104:b0:8dd:2138:5e6f with SMTP id 6a1803df08f44-8de3b440d78mr279394776d6.2.1782229790132;
        Tue, 23 Jun 2026 08:49:50 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f0164fasm128197266d6.8.2026.06.23.08.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 08:49:49 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/6 v4] libsepol/cil: Add overflow checks for circular reference checks
Date: Tue, 23 Jun 2026 11:49:34 -0400
Message-ID: <20260623154937.16913-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623154937.16913-1-jwcart2@gmail.com>
References: <20260623154937.16913-1-jwcart2@gmail.com>
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

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v4: Add '\n" for cil_log() messages

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

