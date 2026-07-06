Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181BE39EF1F
	for <selinux@vger.kernel.org>; Mon,  6 Jul 2026 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348742; cv=none; b=IAISL5N2YDrA1cjlsy3b5UhT/QECBvsSPAbBREwfSL/Y5MQhLAgUGO/LzdcJFT3UaVe8verjSLconvsD9vEOqCoAYoPAgjN6Xal50AcmaKFgX+njDZwoKAUwIsl655v2xnq6/FcfS5m4rGYpjIzi1qmFbR9NfQSaxi3fCvz9KWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348742; c=relaxed/simple;
	bh=SPp/lu19eANKy47fEJN2jO534eEBrJIV1Io1eEud6+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UF1lqW09XCjzqCCDmsEwnmC8g2TFoqHEDOU+Do9SmEFCo+3e8Tjnd8hpeR5iWH4f+rQ74FAbIBPnLx0Eff/wTfP58phc1AbO2gFIW+d/Uwiqu9FPWG4Uhffx2eMEiKae1QBR6GtNIBPPyA6/mufWOifnz/m81RnrrcLxy8DA444=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+KfSPBX; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+KfSPBX"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51bfa429aa6so21566041cf.0
        for <selinux@vger.kernel.org>; Mon, 06 Jul 2026 07:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783348740; x=1783953540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxqnEl8UJDDNpNFUFa1Vnp2tm+reVNrheGlNh01sFok=;
        b=i+KfSPBXV88bALcME24+abvGtYqdIbPAWv3dVkaoMch9+lq/A9KZHtpa0OxUHsnbi+
         bg51t2psF+ehq/MoZ++t0p0stfNDvxH533utT8tVYgNoQ0tWd7iAnRbDTK3oRigkkdrc
         KRvkxaAhwD8eMVAdgkLqLcL5pJFS4GVNEEux+JxLqOu0yHE+YeK3WGU21osDhlHrSLAi
         WnNM+f+PSwBkqvGgApdpm8w0cO7ms0TrIqw/BbV8j+QqswBqVNwJymVC7ZP/QHOaN0ns
         EdHFYdt9NYawewHf4RiOLe+HEes/utr8g0jKaed8rku6k1d/UMHyXijdh0DHfE7MJC41
         wjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348740; x=1783953540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BxqnEl8UJDDNpNFUFa1Vnp2tm+reVNrheGlNh01sFok=;
        b=bNmhrfI9cjftga9GKNKh2Hbq9RoNrh5djq8EgMzLAPBXSnc1WwpS2uiBf7/tJ58q5D
         WpnSjTm7kUy8rXEZQjzpmLVDszjHI4HLDfa8RaYxh6SXC9nVCIjAlwmYZEzZQvZFFIRP
         cm6CvREZwWLTfqx8jW1PCXhKqDw5a02eU7uFhTaQpYa8ozsTwWG0QaCmpSixzhZR+mMd
         sJoX3aXrL6vyC+Lc+7Ys+B3AOOmGF0H/4wAYVSc30hEheuGpTsBpzKZ+EY5Ux1FoW3tq
         pYEsltXKgUHcZQm9ywR3xybpyeYYwB4dT7tm3uqNAsGKi8CGm/NXV9rb97a+f547tG4P
         JfQg==
X-Gm-Message-State: AOJu0Yy2Kdn7Y+YZkm9LezgohX3YO1sFoxSGDsrQ+U+IRVxVaHYMcplv
	0lWW5soA1xvzbA5jBd6SguIKzPAgye2bkC/KDF7sq4ZD+e6aZA3UF5koemvwow==
X-Gm-Gg: AfdE7ckVJO5qQ5hLnMkDF6HkOU0mKFvSH6yDAfe6gPuHRNuos+yD+ChySYZ6kja4bYK
	GaVrogRmeZ+iJEByXHUyUTVpzSJu/AJYtBskiHrp/U9v4telPTNnr6zVKcWl4M/I/gg2zbLqP/V
	pmcpCFKZO2O2Ok52PXsmWl42uGX29zAIg0HOdRzMa9FJ2msNNMqG2FJNRDbwehTFSGfz8rbRi9G
	RuJDeo0sK/jdbOU9U1LeI3Fzd6Ngx5lCB3O6QqU5IC1MbdbbEhzVYFSUu22OGpYbbSqSm29Dtlv
	J0pZwIlA/fJ9P0ke2xlCMa7zBBeRrhgIssOOakFA/YMdB5TQjcV5ePdQESuA5rW6bz6A0OnoTGl
	HhOqYu/uaONXibjXJcWLukOBAHCLwfbW12X2yxEOXR4HDCqzAoHjPejKupHPOiZUFb6hbcXYa25
	0uIgeU+oIb7zXM4kKQRLorHnVG9ebpv1QM9KU=
X-Received: by 2002:ac8:5dc9:0:b0:51c:a9a:b0f8 with SMTP id d75a77b69052e-51c74054e41mr11657891cf.29.1783348739940;
        Mon, 06 Jul 2026 07:38:59 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41b19a66sm89839431cf.7.2026.07.06.07.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:38:59 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/6 v7] libsepol/cil: Add overflow checks for circular reference checks
Date: Mon,  6 Jul 2026 10:38:41 -0400
Message-ID: <20260706143844.25956-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706143844.25956-1-jwcart2@gmail.com>
References: <20260706143844.25956-1-jwcart2@gmail.com>
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
v7: No changes

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
2.55.0

