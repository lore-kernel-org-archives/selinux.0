Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46D11C84BB
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782149761; cv=none; b=XByBCx2cYhejLr8g9ZpREPVD2AeBF2c3X7OgDuuEx1R+8/5mg5nHbDxMI7X6HhQKxSAfZ3b6GjpkNQiBLiwBUXYKcO+pbe+gRfDQIxdC0EsBGzmMTrIAIcIbwxbO/BsIbizziLAq1f2xQFwiYg1kBUa3cuuItR5hBvGRoF5J61k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782149761; c=relaxed/simple;
	bh=+9sYJkhlCXH/SqPSippqPrnCYTAxo7TPgyoozW2m7X4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FyWdckMpG/Fs9OnNmXkkkb/KUs+s8gKsOjuShFHA0YBYPgt1XqaWS+xcniQxpS+0fJh4cfkzGNQJMEEbq2i/Vt89+TQXq2g3n/xJjMjfzt6TyUpGr90jEI7t0Gja8S2PSAYLnpjj+xesLVk3uHw9AoDU0m/qk/Zn+NCZmPaakaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLWii/ba; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLWii/ba"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92120eb916aso292908785a.1
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 10:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782149760; x=1782754560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLFpzkeJYbDmoGQsmcB4Q1ma6VJEJv02WSM1m26GMVo=;
        b=JLWii/ba93ZChWlbpIwmfEYWdtNtkdyOCwVgQp5Ztc/p3bgE85NE/i4tNk+vvrQnU4
         E25B++l3H3HMXdZuMapaNt7rVgHF+xk316fsBNKgGPQxaw81URPH2/EKZATa+kWa2FKt
         oHWDSUHnepgJwcxZwovLpm6+Jqo//HjpAqgL2RIW1zCLgdDK7NFdWQ5ULc1472UAWNFJ
         SgBpnnqgvGisSNhir4lGmW4spYn40TmqAy9gGqXTn6/2O7o5sDjTK9eHnkALpELDdEX5
         gfbvDsvJBWRHin+iOiXTIUhz5eYIy/Z4X3XYIt37X137rHleKWq09QSXXAqCe/DVvWej
         WDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782149760; x=1782754560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qLFpzkeJYbDmoGQsmcB4Q1ma6VJEJv02WSM1m26GMVo=;
        b=QIgLUyzYbE9R/1qg/GC/b1OKkFcSH3sWhFZiugg4xxpN0igZP4IQSzUfzmcxai21b5
         TadFKx4XHvh1vPS5eH02i88h9CULrMXL+L7EWpmHWfeDUOuGRTeevCNt73LNhu1ipuFi
         OM4JaQiR+cURv6/9p0m4oa6uVrobtlpqVZ3M4rbFH0ntq+nUgDCv7rB+BhsA7nfvuIwT
         mUi+D5nW30Cc/ljFfpfnqPlH4vdx2cusJ29yr/sA2gz5sNev1cU9z6FLUDzYuMcvnfOy
         363wUlb6fkh2UwzlIJLMiQpa8neV8p7dcZk3dqeAtMvpzabniiXT2Co93C/xXfJHKPo7
         6Q/Q==
X-Gm-Message-State: AOJu0YxyFWLkdNUj0gP51rQDob6Xfp1lieab+ZKUXjuGeWjDzJimoAxV
	dWhzdSLBMn2osi1T/7N6POxWtnX9AiqJWNmNeTk0TNRXrNsvNXljKbjrhxKQHw==
X-Gm-Gg: AfdE7cmUIAElEbMA1AHGcXyvnkh329o23nsuB4QcDj5Fr5jDI4PgthIdkVL8S0RVumo
	qyWXqn+H36njdSMbj4AbcMz4iehFOadtjcqUNmlR4brpbk4bcXk+yU16TxKL7llPrbFOpta8pNo
	ZfhcQG8rbEaPWYUUOJ84dlM2Vj7T8xlGJvaLon1V6T5rfPYzoLy92ZCvCeqdzlh91tXUDg9qhY3
	4dnOrbdVtiNvwUV3JD8L5HhnYb22QgqgQN8lEdYZtf2Z0pYhljQo5SZ0wg/QHf55Bw3VFO9XJ1L
	y3Fka1IaOAEQFfwDzsa63ngJIF23J10411EHXS5tP5HvOiZItwO3SL54BIBIlp/ApyGmTH+vwRK
	E4Zw1rQ0tFC0ZgIbuw4vhDBHXnMNIpfeiKsK+/wwO/x++ViSMEcHbShcLvo0gbvRacQ0A+pPQQz
	CGQ2p+Iq1N5OR52rq4Stpp0JfpQLfr7MbNMwc=
X-Received: by 2002:a05:620a:19a3:b0:920:7d3f:2d86 with SMTP id af79cd13be357-92091789626mr2286906885a.57.1782149759468;
        Mon, 22 Jun 2026 10:35:59 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fd39188csm34813485a.6.2026.06.22.10.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 10:35:58 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/6 v3] libsepol/cil: Add overflow checks for circular reference checks
Date: Mon, 22 Jun 2026 13:35:38 -0400
Message-ID: <20260622173541.174998-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622173541.174998-1-jwcart2@gmail.com>
References: <20260622173541.174998-1-jwcart2@gmail.com>
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
v3: Use the __builtin_mul_overflow() family of functions
    Split out cil_stack fixes to a new patch

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
index eb732e44..240f3b23 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -975,8 +975,11 @@ static int __cil_verify_user_pre_eval(struct cil_tree_node *node)
 			}
 
 			if (steps == limit) {
+				if (__builtin_smul_overflow(limit, 2, &limit)) {
+					cil_log(CIL_ERR, "Overflow");
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
+				cil_log(CIL_ERR, "Overflow");
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
+				cil_log(CIL_ERR, "Overflow");
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
+				cil_log(CIL_ERR, "Overflow");
+				goto exit;
+			}
 			steps = 1;
-			limit *= 2;
 			orig = cur;
 		}
 	}
-- 
2.54.0

