Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4623C8C72
	for <selinux@vger.kernel.org>; Wed, 24 Jun 2026 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311778; cv=none; b=TV6DkmPft69hE71zVHPDqElstFwntbt66EdGv8XRULVUt7V26MimR75fby2rpm4pQJASbC4mSRTv+LQGbNLHC3VwV3n9F428Y6Q0cY6VoTT2nZP/yVwce+ZefYY5tpu7J7zLKIeN3uSoZ/pETiAB6WoDUGWU8rV4BZHhJ7q1eS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311778; c=relaxed/simple;
	bh=C1+jG8dG3uBWoyv0j+QQuhkdstTmlu16npkSFm8QYQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avafNTIYgYeS0dcdnbbVriokCNjtpQsX+VoG+/1v6ZplwML+BJKHqiiZgYEUxp2JAgmWYmPjzm8ouP1K41j75mxNpLQEQK9t0wRwAbu8cBtYtk7NjQYamkIRVpCd0aczev1L5JUfj7xu5kGAjgwiHAAtC6HsRIUc0jvju1FitD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaAxdS1D; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaAxdS1D"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-517863a2edfso7212401cf.1
        for <selinux@vger.kernel.org>; Wed, 24 Jun 2026 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782311774; x=1782916574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOSPASlcVr1rugrYIkqDjv3dMTDQza1To3J1fCLHy1k=;
        b=GaAxdS1DEDhN03mATNlWwTBhgiaN1fynoVc4L9WO3y5TquC8sGHkyOj48cli+plepy
         YBDr61ZTO8SewPAhACBLFjjDKP6IxJGDNN1FJNnO5e7tlpl4cWP9MC3s6crQNw2SHArY
         ZmHzNkrsD5Z6vEMwNxqhqdlxdDIXlLMk0bi85yh6d0EPUgtIrK6hphGO46ZJZt7NtWbI
         A8/41XkZnDN/OOr4TwcH3xWwdpLIxBt31mvq7lUjW6j9KpXdgiostcHtYyg6Q754AK08
         Hzjs9JwtpI31z5HI/wOhSywfhi1XyDuvOf+jre4jtWyT1Q/ABRmLIwgEkKIXuX15ZdgL
         ghOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782311774; x=1782916574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kOSPASlcVr1rugrYIkqDjv3dMTDQza1To3J1fCLHy1k=;
        b=sIyAUtYYZqkaXZu6n2sGdtlSJR6Uj6aUcvKQq5kJjdAa3EghvDCJSwwydowEgXWr/j
         Ur/iV+7/K7EVN3/voWFua9T8TzXPFkyrKy3kLtg5i5cM4PC5VPwoDiRgyvdcWM2DS469
         l0Svuxo5ROspbw3XvABhC5iNHoT+a1I1Cu6IjwUv1XknE58/kbzrg7TVcEM+z3VIh0ZO
         +4aiB9/LxDYz0hH/Sf33ca7qf4NC7Lo/IKmo/SFtyyiLclSlMM+cjOdiddTonE/iuAWv
         JkbUSQ/U6T3+epqRuDCS0m4S8DVXyg6j0aAAwpxw85+EeaL5c6PhmBGNOliwFDxztmU4
         zfBg==
X-Gm-Message-State: AOJu0YyJm8lcGdD75bD2kWRy6OjrW4a5hKuMm+X8fmTnuRwqyY/WWMyp
	qVzRlN/Gwp2jm7vHiioHcbsxmZkdLRla3ySykS6RRgDULhfvkZhlqwsZciMwGQ==
X-Gm-Gg: AfdE7clY2vSPI73yxdic6s1giOcHoL6yqpcP5VdJzeZZF5C0L0l7BPlBvITu2GQ2/0z
	L/VyesaZB99zcPyT5iUG+iPrPD9DUXVryzogh7w4g9R27tj9ghGnx+/QBfSU1pdk50bvB//MT/B
	MDPHIIVs0jp/7thO8wn5eGErEJAkFJC+88XtzCVBs5frMuNwpj2pXoFxEkMYXu4qCnVTy8fpl8X
	zPQ9L7oMhyVBA4bGCHYhbNfd72JiY1q2m5eBfgEmYa0sQpKkzWKibEel+H/2GOA74GNECQENSJb
	YY6n+DIFmc/1jBtq4w48UWcaYrro78mO/XKaOqOr2fjmkn85AGR0d2ju8jZZAhjtafbUsThjAcx
	DYH23mPLE/CkSWwlYD/m/G7aCxYbSdSuzBRThzEg5b47NNGTQG37tHgOq56IK9m2lGuD1HHa101
	I2GVw5QgICixzLFaROkyHwwbecUn6uKHA3J6k=
X-Received: by 2002:ac8:5ace:0:b0:517:8bca:abfc with SMTP id d75a77b69052e-51a0671d1a1mr298800181cf.18.1782311773490;
        Wed, 24 Jun 2026 07:36:13 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51afc29csm48721611cf.27.2026.06.24.07.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:36:13 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/6 v6] libsepol/cil: Add overflow checks for circular reference checks
Date: Wed, 24 Jun 2026 10:35:57 -0400
Message-ID: <20260624143600.11282-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624143600.11282-1-jwcart2@gmail.com>
References: <20260624143600.11282-1-jwcart2@gmail.com>
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
v6: No changes

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

