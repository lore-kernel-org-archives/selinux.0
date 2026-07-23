Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E46437F006
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 19:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784834301; cv=none; b=u0fgvD0Tx9M4r+iQxjmZ2c0qLXsuRrMjq7mAcD41J35Gq9yqIYQshg56sQixpMVQdOnmIm3PvUJWWkKCLZgLKX7o25Fct98ijKrzDw6DAr7RxIBJhqK34HD+RCleZFV2fy2Xw5rwfdCJ7pQXEjhDq8mgcxjIY/YdLSucCQBbRZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784834301; c=relaxed/simple;
	bh=DntOQqOR+LfdATNU87wI2FFqon/zPVovr6MeJNHeEk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p/hRs8N1BHGyBZGTnbDAe40eRCA9CXwHVX5N18uKrjlu+lMl3doSQhDU+hjgNvWq2zMeS81qpI6vyhQcSixsw19d78y1aldcsMfljNP6i5JJ+33xE3P7H+NMwfQJ4kKMXa0yMuTTJuLUxQQnZFz02XBCEZHATWvqOxMM4yd3e5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHssGk0R; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHssGk0R"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e5c92c389so82610785a.3
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 12:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784834299; x=1785439099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1YzE768RC9BYDCNGfw7KUtsGf7IIi7pClbSgOfHv1xQ=;
        b=bHssGk0RltabTq9r1wk1JInsLsnKjdnz67UolR4/MNbC/p6tQ4oSZaQ7GjbJ8rH9Ue
         ynFAAwrFH8wCrBLX3mRpnF8aq+KonjoBWKvcEqnL+ovA4NG8ISCXtbuVACJG+i3dCvhm
         DEtF9cCvE2xovb3JawapQlQGrGMvSvL1BbNr9i0lzruVKW1G7NidPtybogwAIIElvtxU
         5JaxR7n2BNRdNX0/ms2wl9h+2vHRvaHtgmosbnAXG5K68BmR5g1EuQ61Zsk+QOJcSWkV
         Jy1aPgBl+MCss0v2sxwznSVc4FPrk89ia5bR6ShSzNSNEfgmkR+kbEAriAylvEobTeUs
         sJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784834299; x=1785439099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1YzE768RC9BYDCNGfw7KUtsGf7IIi7pClbSgOfHv1xQ=;
        b=T0Xl4lRAY4JIi7pihmOnDvUIELZQ2LxPjZiWixhKOxSjENIcvRn2Ye9Yx6tRB0ILyF
         cKv54x6nmF1giHjuJzl8eEKkBNQjBPdoueeC/mIlrKV7eHMz6SbinD0BtpEoAPLU74TF
         4EG9H1ZDLhRiGspTL2slJo48hgLW68lFqsyFAEbTiw5XotKcr8CW4LnYtKHHLFSAC6kr
         /kwmnGZb0BlWsHJQPWMSeiixPNoLx6VFW5A8A3UkzmJWk+Mcdl3LylQ2iQQIfDHXnPeC
         obqZsjYCoF7bOQt73Dc6U6OTZI7C87XuhII1IR2eu9SyTKRWq8wVqbpvUKw4vrXM/NCa
         0G8g==
X-Gm-Message-State: AOJu0YzQhNtTDQP2lRnzURPC6IPL07fctc9wEMhkF2SZlK4DTnaDXdLt
	bFA3MjsWYRC/tXkSDratSm4Gr3untL120zEQphWWoMK2E1l9vcYKw4KOrWgSVQ==
X-Gm-Gg: AR+sD10P8aPCPEM824P3QYMb17+933OgHeiV7MW6BCXnSIDnPiuC8BikOFJbcZQY4uv
	Ceh9160B7eE/SNW7/cU+WKbgk4m9SbGvrJJlHcoeeVIHhfX+dmpnNvF6M8nnsnuACpjK0MWOvc+
	d3lYz89zYgaMkRK5wYVvUVPhOBgsBBr20uXAlq2HroGdAhBfFBMhMLqYwoKtgBL50JPQYF/tSxc
	yAoyK9MwfNaf1n9CwvN/QjWlxjZZYfQLm6xcI3fTv+sU1t/pxLrzF1ECGdPtLV/gQtQKnO53YlM
	9NrQNySqDN0cONKylQqAIVsTbs6jW5rmFEavhuVhZAIYBYSn33r/sCbonxVzd1b1sUCSs5tfK/T
	KqOwAkaxDdIORNuGDNAqRyBCvk1XZqHvzDeI/bfNLYPNN6Jeca7A4qOUrt0GF3dMQ+BHu4BLqs0
	5LR2iay3ETitKS8e1iof/PyiIh
X-Received: by 2002:a05:620a:470e:b0:92e:5c0b:a6a0 with SMTP id af79cd13be357-9310389253dmr494257485a.26.1784834299245;
        Thu, 23 Jul 2026 12:18:19 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f6a7f937sm480017285a.40.2026.07.23.12.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:18:18 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/2 v2] libsepol: Validate more access vector permissions
Date: Thu, 23 Jul 2026 15:18:04 -0400
Message-ID: <20260723191805.28568-1-jwcart2@gmail.com>
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
v2: No changes

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

