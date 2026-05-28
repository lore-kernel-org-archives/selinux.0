Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2404625CC57
	for <selinux@vger.kernel.org>; Thu, 28 May 2026 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779986386; cv=none; b=S9AU6uVQj/pkfRemVjG07S+kKKd/ifpTrvrAISkqfyG+5sw86PecnVpYwuVer9oE+Qd3oNS3KIlB3CvnsWFF0xcRynWa8o22I7SLRkY84uRDQuHeBM1V9FplfisB1fsL7eRvhUkCeB7c2Rv1wyY0GBv91aC+46XTqaHuocXkjlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779986386; c=relaxed/simple;
	bh=hQfmRh+LJJ/hz6seuPU31CWfSW0gBM5v2Rz0oK1dnZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oa8+3ZLjQH5ETYjeU/3Gq6tnypC+c1e5qV7XGVzee0ZSjlZshkXTdFH9XJC6iXfCBpAlVs5FajynCXsKkcsQ1aAQ8jbcwO6EBM524DiqfZj2qe9rNg5Q8KwQd/zDaXYOsrxoVQ2qYmg44cKAyOT/E4zyVGVCbwZ9qDhP6ab8j9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk; spf=pass smtp.mailfrom=posteo.uk; dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b=qJuOqEIo; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b="qJuOqEIo"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 1A5DA240101
	for <selinux@vger.kernel.org>; Thu, 28 May 2026 18:39:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.uk; s=2017;
	t=1779986382; bh=g3Ec2mq2A8uBFHRKdg94P9AZtz7sb3eBKREAYyK2RyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=qJuOqEIooTIPr6vO6lNDoCOG68dNM3FdOeY2az+bpLSRwJD+WKeX9ap//YONHrdhk
	 oiELYeYbfTounh05jUIzAyFkDptb3HpMGA5LTi7bUQU1JVkUhCttNZUGti5KeglXts
	 670U5jt52BCRc4aV7F7bJwFZDL/BO/HQX/fV99scJfvQDGFrGCj0gsk7V327lkkD2h
	 AAxjoE1SAblq3vK8XwwijlXrDJEiqR/f2Fj2bu3jC4sT8Lxp2H0fcwUPMagur35r/w
	 pounMMCZFmiKLNQE4GOQW7V1nE+oV3okmQgkeiG/1aoAlrH015v8gdB9mpNpAQuZUV
	 EYQ6F25QYipMg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gRBzK4vqcz6twQ;
	Thu, 28 May 2026 18:39:41 +0200 (CEST)
From: Rahul Sandhu <nvraxn@posteo.uk>
To: selinux@vger.kernel.org
Cc: Rahul Sandhu <nvraxn@posteo.uk>
Subject: [PATCH] libsepol: check the number of elements in the avtab
Date: Thu, 28 May 2026 16:39:41 +0000
Message-ID: <20260528163930.418992-2-nvraxn@posteo.uk>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3668; i=nvraxn@posteo.uk; h=from:subject; bh=hQfmRh+LJJ/hz6seuPU31CWfSW0gBM5v2Rz0oK1dnZU=; b=owGbwMvMwCmc0Xus8aefgg/jabUkhiyJ/EP1R198Wd2pL3F/0YtAIZa2B6YHQ3fd+hnN/eiR4 ddkTsaZHRtZGIQ5GSzFFFn272O7UfJ07u+jT153wMxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6 hkCGjhEDF6cATPXZ/YwNc35t/i80K7hK3GSrxMJ7FnFVx28VX/owX/tQwawpQelVMT/4245cSCq JLDc2PRxqdjmIseHpfI7n2ubv59VJRtha3Z8kqql58+z6q1enRig94jRe1LfbiveN0KS+rYLdUt aLPjIsMwMA
X-Developer-Key: i=nvraxn@posteo.uk; a=openpgp; fpr=BFBE06D874E59DFBC5E4EB88688DC681F94E204C
Content-Transfer-Encoding: 8bit

Instead of counting each time we semantically see an AV rule, check the
number of elements in the access vector table. AV rules may collapse to
nothing, for example:

(class foo (bar baz))
(classorder (foo))

(allow t self (foo (not (bar baz))))

Previously, the compiler would incorrectly count the above rule as one
AV rule, when in reality it collapses down to nothing as no permissions
are actually granted.

Signed-off-by: Rahul Sandhu <nvraxn@posteo.uk>
---
 libsepol/cil/src/cil_binary.c | 6 ++++++
 libsepol/cil/src/cil_post.c   | 8 --------
 libsepol/cil/src/cil_verify.c | 6 ------
 libsepol/cil/src/cil_verify.h | 1 -
 4 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 74ec3cd5..dca1937a 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -5468,6 +5468,12 @@ int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *p
 		goto exit;
 	}
 
+	if (pdb->te_avtab.nel == 0) {
+		cil_log(CIL_ERR, "Policy must include at least one avrule\n");
+		rc = SEPOL_ERR;
+		goto exit;
+	}
+
 	rc = SEPOL_OK;
 
 exit:
diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index 2b6dad73..fa59d337 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -2506,7 +2506,6 @@ exit:
 static int cil_post_verify(struct cil_db *db)
 {
 	int rc = SEPOL_ERR;
-	int avrule_cnt = 0;
 	int handleunknown = -1;
 	int mls = -1;
 	int nseuserdflt = 0;
@@ -2518,7 +2517,6 @@ static int cil_post_verify(struct cil_db *db)
 
 	extra_args.db = db;
 	extra_args.csymtab = &csymtab;
-	extra_args.avrule_cnt = &avrule_cnt;
 	extra_args.handleunknown = &handleunknown;
 	extra_args.mls = &mls;
 	extra_args.nseuserdflt = &nseuserdflt;
@@ -2548,12 +2546,6 @@ static int cil_post_verify(struct cil_db *db)
 		}
 	}
 
-	if (avrule_cnt == 0) {
-		cil_log(CIL_ERR, "Policy must include at least one avrule\n");
-		rc = SEPOL_ERR;
-		goto exit;
-	}
-
 	if (nseuserdflt > 1) {
 		cil_log(CIL_ERR, "Policy cannot contain more than one selinuxuserdefault, found: %d\n", nseuserdflt);
 		rc = SEPOL_ERR;
diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 9654d71d..d3c4fd81 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -1621,7 +1621,6 @@ exit:
 int __cil_verify_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args)
 {
 	int rc = SEPOL_ERR;
-	int *avrule_cnt = 0;
 	int *handleunknown;
 	int *mls;
 	int *nseuserdflt = 0;
@@ -1635,7 +1634,6 @@ int __cil_verify_helper(struct cil_tree_node *node, uint32_t *finished, void *ex
 	}
 
 	db = args->db;
-	avrule_cnt = args->avrule_cnt;
 	handleunknown = args->handleunknown;
 	mls = args->mls;
 	nseuserdflt = args->nseuserdflt;
@@ -1671,10 +1669,6 @@ int __cil_verify_helper(struct cil_tree_node *node, uint32_t *finished, void *ex
 		case CIL_TYPE:
 			rc = __cil_verify_type(node);
 			break;
-		case CIL_AVRULE:
-			(*avrule_cnt)++;
-			rc = SEPOL_OK;
-			break;
 		case CIL_HANDLEUNKNOWN:
 			if (*handleunknown != -1) {
 				cil_log(CIL_ERR, "Policy can not have more than one handleunknown\n");
diff --git a/libsepol/cil/src/cil_verify.h b/libsepol/cil/src/cil_verify.h
index daa2f80a..f86d07ed 100644
--- a/libsepol/cil/src/cil_verify.h
+++ b/libsepol/cil/src/cil_verify.h
@@ -49,7 +49,6 @@ enum cil_syntax {
 struct cil_args_verify {
 	struct cil_db *db;
 	struct cil_complex_symtab *csymtab;
-	int *avrule_cnt;
 	int *handleunknown;
 	int *mls;
 	int *nseuserdflt;
-- 
2.54.0

