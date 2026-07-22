Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2718442B07
	for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784742368; cv=none; b=RGe3p2E1LwqXdJflg0e26T/nvgU+I6veZr7BXtVD2htDQhoTUb83cnU37EkXUfo6k8m1TAPMaeTQ6Jc8RVyFdJcA2oioRlZYD6y5mu47C9SyBWaDjR3sjBbjwALvQA9B0XaPhJNqffavacQU0FHB/QzVyPzl4ZVPQrkWqmgY7U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784742368; c=relaxed/simple;
	bh=LWHhTO1CJnLidSil1Gov62kNsr8peMdXulUy8ClPO7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YaWaNRdUiYnf60X6oyt28c/hUtYPkfk7k1ZRHDfgr1EagIL26FPdEskonaxnxnIH260jHi9vXIQjyf3LWTzsPVqGjd1fLa0Tb6Ps8XDFeO5ButCBLQbMC0tjHFCuNAl/eq/5m0IiGBjO+KJAsBoNweEE/J41vGI539TWrhmdLfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bh1hWJXN; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bh1hWJXN"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8ff20870ac7so104671246d6.1
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 10:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784742362; x=1785347162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lPKgl5Kv1esM4sKHyWGh7U+0v96ZcqDHHZemaL1tz3A=;
        b=Bh1hWJXNOMt8i1xKM+6rRqmlmh8y+ypdwC8IB5xXwfpRHQ9qDYl1d9etskqx3eDn+H
         WvQZ2MHfKh55tOSWwZ1ZWW5idCgI/ScLBhsMgxKjGI+2k6kMjT2hGj0CUkmFKCcOz6n7
         O3MupHkwcLyVDNrHpYwfSn/9w1tDqR2V0yEmnirmVFJE3IPtER3EW/jpwdstllp4nAgX
         bqeq28oPoT6k3zh+DIq+3yeztxY35C+hHy98Kavt9864xlABKtDOejyy/qfQ1i6xGDA/
         1clTdbd2mX40d9CFvrTann5mDtwkQS0Y+Pl1+wgvQvnlgE8rwJ2rC5L7G54Q/l9qlpxZ
         4aMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784742362; x=1785347162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lPKgl5Kv1esM4sKHyWGh7U+0v96ZcqDHHZemaL1tz3A=;
        b=sG+0p8aprKn5C6t8rt3QJ5ZPv6Nd6qL+a3D7Hm7dbOjoMwSq+i5GQX96723m7ttcm+
         odpWm29E+1wX3cFnzJtmPkVK9N0CHRLSKeVB5jD0Eh1Ag55X5iMTUfMR+fWx8yqPxKOq
         isUwMQjbnI/T8P8CWRC0SmqIblXgOJ98/YlEjhsu6573PLxxPZBGXWPH/YaK6a6bO/xV
         dseIHBDACgKU46mJvQo6evsf7X+j08GxOFSx5OLMizN8bY5cpXWQscmgHN2gJKvkUkrQ
         mpLdkeP4/DJoQ8Re0nxUMS0iw5Sq4OSsSPCnXbjk+G7Hy0A2k9fM11Y9EueR1+7G3Sko
         7JBA==
X-Gm-Message-State: AOJu0YyD7EP6BHHcgMQ41vwBsBiK6p30RoYtbQ+NI5RjtSymtmcwWwOL
	tPpOMteLu7Hh2kZoXEH6Zid7AW/V4cx41Koz2Yw1bF+8fgyVz2LBXrNTt0e1ig==
X-Gm-Gg: AR+sD11qx4PtfQqH0JX8e647ibYQs4BCl0dtTtcGju8lB/jcE4QDHESgJTFiif4NUJk
	lLzquitW5FR41KXHpXPwEYd0QYvJuh98WV6+LffsMQVQEv4EsFTxP6Rw2Gzweu0/AEzreRMqst9
	RURl83fTMu2AOCSO8NYziMk63SC2kavK1hgoN1hqV5h8a/oC/Dg5lb3g1wknwIK1l4H6G4vULJz
	+FgORGTXfUEwcZnlwshZHqm9IgbtKa0ZZE3csgmzy3cv29nOtFKH8mPQwTD+GNDira1bgNH6e3e
	ouNcHhSu6km3126RlOAHeX9GuQGvnIqMTaKEZ3e7SRTz7uMt7GrnpV6SMciZBygxPtPMnmtkt6Y
	8rP/IS1zrqrGLEOb4HP6uG/Y71JQDA9CPB0Ic8QUGhs/qe4ppJ9v5mba2oD5nETpyYVa/ck8cmG
	+/w92L9Lgs+VmIgr+qdqeRxuWQ
X-Received: by 2002:ad4:5d42:0:b0:8ef:a9ed:5e9b with SMTP id 6a1803df08f44-90778518b27mr255778856d6.55.1784742362222;
        Wed, 22 Jul 2026 10:46:02 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907baa0b7a0sm25587116d6.36.2026.07.22.10.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 10:46:01 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/2] libsepol: Validate more access vector permissions
Date: Wed, 22 Jul 2026 13:45:50 -0400
Message-ID: <20260722174551.100020-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 8c64e5bb6fe7 ("libsepol: validate access vector
permissions") added a check that at least one permission of an
access vector is valid. Add a macro to simplify the check and
add a check for av rules in conditional blocks.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/policydb_validate.c | 36 +++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index cde0b8d6..166e20a5 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -11,9 +11,15 @@
 
 #define bool_xor(a, b) (!(a) != !(b))
 #define bool_xnor(a, b) (!bool_xor(a, b))
+
+/*
+ * Check that at least one permission bit is valid.
+ * Older compilers might set invalid bits for the wildcard permission.
+ */
 #define PERMISSION_MASK(nprim)                          \
 	((nprim) == PERM_SYMTAB_SIZE ? (~UINT32_C(0)) : \
 				       ((UINT32_C(1) << (nprim)) - 1))
+#define NO_VALID_PERMS(av, nprim) (!((av) & PERMISSION_MASK(nprim)))
 
 typedef struct validate {
 	uint32_t nprim;
@@ -265,10 +271,8 @@ static int validate_constraint_nodes(sepol_handle_t *handle, uint32_t nperms,
 	for (; cons; cons = cons->next) {
 		if (is_validatetrans && cons->permissions != 0)
 			goto bad;
-		if (!is_validatetrans && cons->permissions == 0)
-			goto bad;
-		if (!is_validatetrans && nperms != PERM_SYMTAB_SIZE &&
-		    cons->permissions >= (UINT32_C(1) << nperms))
+		if (!is_validatetrans &&
+		    NO_VALID_PERMS(cons->permissions, nperms))
 			goto bad;
 
 		if (!cons->expr)
@@ -1091,11 +1095,7 @@ static int validate_access_vector(sepol_handle_t *handle, const policydb_t *p,
 {
 	const class_datum_t *cladatum = p->class_val_to_struct[tclass - 1];
 
-	/*
-	 * Check that at least one permission bit is valid.
-	 * Older compilers might set invalid bits for the wildcard permission.
-	 */
-	if (!(av & PERMISSION_MASK(cladatum->permissions.nprim)))
+	if (NO_VALID_PERMS(av, cladatum->permissions.nprim))
 		goto bad;
 
 	return 0;
@@ -1214,12 +1214,24 @@ static int validate_avrules(sepol_handle_t *handle, const avrule_t *avrule,
 
 		for (classperm = avrule->perms; classperm;
 		     classperm = classperm->next) {
+			class_datum_t *cladatum;
 			if (validate_value(classperm->tclass,
 					   &flavors[SYM_CLASSES]))
 				goto bad;
-			if ((avrule->specified & AVRULE_TYPE) &&
-			    validate_simpletype(classperm->data, p, flavors))
-				goto bad;
+			cladatum =
+				p->class_val_to_struct[classperm->tclass - 1];
+			if (avrule->specified & AVRULE_AV) {
+				if (NO_VALID_PERMS(
+					    classperm->data,
+					    cladatum->permissions.nprim)) {
+					goto bad;
+				}
+			} else if (avrule->specified & AVRULE_TYPE) {
+				if (validate_simpletype(classperm->data, p,
+							flavors)) {
+					goto bad;
+				}
+			}
 		}
 
 		if (avrule->specified & AVRULE_XPERMS) {
-- 
2.55.0

