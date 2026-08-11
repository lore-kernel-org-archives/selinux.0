Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5751F2D8DB5
	for <selinux@vger.kernel.org>; Tue, 11 Aug 2026 04:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786422553; cv=none; b=h6XvQ0IXR1RHLHc15t5H74vIcfUDlAsvaZUQd9mHS60F9M2KLlAP1IuX86161Gh6Hi09+rKqwDikUdF56K8nGr8yCd9gCAwAiLgouhv3W2LU3xE2Pk2GwMG+k5bJnT1oBJ3wr5uBWwHhs6wzVhBpMI0uZhBYl0xjKLhUQ6FssyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786422553; c=relaxed/simple;
	bh=6wUy37t/EgDqWMQgDdEbhrVY4tz8+8yiZgRSkom5wio=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sHo0u5HBL5kXqTg+HHYxnj9Q2TjrzosKm1jeqomDHbslSoyaLYe24svx4k4F9AwHGV39bgvG4cV+gGfH6mapNIIgifdSp4rOGJCO7p3I3osWtnFEBgMyoV6BUxO+e2AtxxUpfNCAAuAME8OCNN4JJYQ9FAvux2Di6Hp+dKhvWYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=izCiieIj; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="izCiieIj"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb5cc1e13f8so3402260a12.3
        for <selinux@vger.kernel.org>; Mon, 10 Aug 2026 21:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786422552; x=1787027352; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YmoqU6UuZFOTiP0DPrSz2XpHoi8weWj3VZvCTRvGLXo=;
        b=izCiieIj9sz02g35T+5vBdhlpinFcyLmN1PUU+VFzGhUuO3BzgOYuWc5ELRsQEDDdI
         l7JldjwQq7H9HZifmcmN17Irr80kJnz5yayWADzKm22Sx//dArQsdkdVTrDYaoT/+c4I
         8srFEoijBg0MFyBQa3CffkMvooK58YxSfmfum++/1I6H3IBWI0m7ISDqUXzOXqJ8DPT2
         dhsS+F9PPxMuSOPrMMeewIlzBh/l+S7/qOCtDzYCicfqJs/rJlX/6mliwv1x+fkym012
         /aA7RGR502/H+wuZobDOngkwbSPnFltE2etXmkhTnubVv9/Q3eIu4hK6g4PTWnjUSkv6
         q1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786422552; x=1787027352;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YmoqU6UuZFOTiP0DPrSz2XpHoi8weWj3VZvCTRvGLXo=;
        b=WrAhj3cpn8k1U1XoZ/p2KWcYDCm32qI+nS5aVVRV/FxZTrfIL8z70Vi/EMsGbL0ylo
         r4+wAKmgFivBz/ghH9ffqsvp75JoXeIq8UTPdvsNl010M/Me8NOHqApRtEc0JaLx8djm
         7PTYDsVLWZa5iP0GXnKwjz5HmSyRmwTnOhnmgwdPAhbYCRUOc3UwJ3zhowwL7BQ6Mv9A
         Wdn3gIc/wz+sdLayx+AnuOrjgVkEbNPMyumPp/cDI2f2cKbd8Kn88XmUzsX7PYWxEsU9
         N17rhWUIJAH8JCte3n6siWlT216H3xf77p5+JMngBlcHTeTm12rujNm2jD4uT4J7nsJX
         Xrbg==
X-Forwarded-Encrypted: i=1; AHgh+Ro10RTQ2Nx5kWyGWAQA3BnSxG+8lhQ4jSIuHy3+ZOt0DZ7QEtXrJKT07Po7+FcUrisl1dt8Vef3@vger.kernel.org
X-Gm-Message-State: AOJu0YxQMKmjUXEeQ+fKPuvAUsA/EkZPJOSQIWYNutZIlCvhkXAs4NfC
	1rNQovo7SNmb9n1v6l1op8m70hs1QXi7yxFZwRCUQz8In9Q1SzBi/d+Q7+RIEgdZOCrG9dmqEo6
	x0w==
X-Received: from dlam17-n1.prod.google.com ([2002:a05:701b:2091:10b0:13b:2d46:494d])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:15cf:b0:3b4:8880:2089
 with SMTP id adf61e73a8af0-3cc2b9472b9mr1118239637.16.1786422551434; Mon, 10
 Aug 2026 21:29:11 -0700 (PDT)
Date: Tue, 11 Aug 2026 14:29:07 +1000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260811042908.3803430-1-tweek@google.com>
Subject: [PATCH] libsepol/cil: Output culprit rules from binary policy when
 CIL AST match fails
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: James Carter <jwcart2@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Inseob Kim <inseob@google.com>, selinux@vger.kernel.org, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Commit d8507429f15c ("secilc: Add program that checks CIL neverallows
against a binary policy") added secilcheck to validate neverallows against
a binary policy.

When a violation occurs, secilcheck attempts to locate matching allow
rules in the CIL AST. However, since the CIL AST in secilcheck only
contains neverallow rules and declarations (not allow rules),
cil_find_matching_avrule_in_ast() returns an empty set, resulting in no
culprit allow rules being printed.

Fall back to calling report_assertion_failures() to output the culprit
allow rules from the binary policydb when no matching rules are found in
the CIL AST.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 libsepol/cil/src/cil_binary.c              | 16 +++++++++++++---
 libsepol/include/sepol/policydb/policydb.h |  2 ++
 libsepol/src/assertion.c                   |  4 ++--
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 7ec3e781..e99405b4 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -5563,7 +5563,9 @@ static void __cil_print_rule(const char *pad, const c=
har *kind,
 }
=20
 static int __cil_print_neverallow_failure(const struct cil_db *db,
-					  struct cil_tree_node *node)
+					  policydb_t *pdb,
+					  struct cil_tree_node *node,
+					  const avrule_t *rule)
 {
 	int rc;
 	struct cil_list_item *i2;
@@ -5609,6 +5611,12 @@ static int __cil_print_neverallow_failure(const stru=
ct cil_db *db,
 	cil_list_for_each(i2, matching) {
 		num_matching++;
 	}
+	if (num_matching =3D=3D 0 && pdb !=3D NULL && rule !=3D NULL) {
+		int res =3D report_assertion_failures(NULL, pdb, rule);
+		if (res < 0) {
+			rc =3D res;
+		}
+	}
 	cil_list_for_each(i2, matching) {
 		n2 =3D i2->data;
 		r2 =3D n2->data;
@@ -5683,7 +5691,8 @@ static int cil_check_neverallow(const struct cil_db *=
db, policydb_t *pdb,
 		rc =3D check_assertion(pdb, rule);
 		if (rc =3D=3D CIL_TRUE) {
 			*violation =3D CIL_TRUE;
-			rc =3D __cil_print_neverallow_failure(db, node);
+			rc =3D __cil_print_neverallow_failure(db, pdb, node,
+							    rule);
 			if (rc !=3D SEPOL_OK) {
 				goto exit;
 			}
@@ -5708,7 +5717,8 @@ static int cil_check_neverallow(const struct cil_db *=
db, policydb_t *pdb,
 			rc =3D check_assertion(pdb, rule);
 			if (rc =3D=3D CIL_TRUE) {
 				*violation =3D CIL_TRUE;
-				rc =3D __cil_print_neverallow_failure(db, node);
+				rc =3D __cil_print_neverallow_failure(db, pdb,
+								    node, rule);
 				if (rc !=3D SEPOL_OK) {
 					goto exit;
 				}
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/=
sepol/policydb/policydb.h
index a1b5e99b..cf14e26a 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -714,6 +714,8 @@ extern void cat_datum_destroy(cat_datum_t *x);
 extern int check_assertion(policydb_t *p, const avrule_t *avrule);
 extern int check_assertions(sepol_handle_t *handle, policydb_t *p,
 			    const avrule_t *avrules);
+extern int report_assertion_failures(sepol_handle_t *handle, policydb_t *p=
,
+				     const avrule_t *narule);
=20
 extern int symtab_insert(policydb_t *x, uint32_t sym, hashtab_key_t key,
 			 hashtab_datum_t datum, uint32_t scope,
diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 8f829e7d..94172e5a 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -504,8 +504,8 @@ exit:
 	return rc;
 }
=20
-static int report_assertion_failures(sepol_handle_t *handle, policydb_t *p=
,
-				     const avrule_t *narule)
+int report_assertion_failures(sepol_handle_t *handle, policydb_t *p,
+			      const avrule_t *narule)
 {
 	int rc;
 	struct avtab_match_args args =3D {
--=20
2.55.0.679.g6767b8d81c-goog

