Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F25036B90C
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784917763; cv=none; b=m4wzrzQHQG215pdIytx5HbjXkiBwsBX/NQ+Egbc42PCp5KH2mCqUP6BtKFfTo0jcoizcq2atnICsZWrhNoJjXgfAWRuML250WUEoG9ktWRTQc4Z61tfTXT6j1ohha8E4uQGZqbK+WtUX/HbqGs5sb8GwmWR1+rY5vCs01K5of/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784917763; c=relaxed/simple;
	bh=i1BAe1CcxEuo+nkfGoUiRTlYWafb8k0oF/gircVjipg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qcf8N9lbwIfhJ++ZhKRbAN/rlNgXmgvoyZmHGsQ9ltcDnIICdzqUFzm7UC9pEbKtKt0bleH/s8ZWn26OvMWtdmAGQ0xVwrcrbzpR9XhqvkSsHGUr4nVutEcbtVE30FTOb/pvKUGSSx0gxijlBZQOZ0CiqHIjNfhVavXk2LmI4sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGXzJMmW; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGXzJMmW"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ff20870ac7so6888236d6.1
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 11:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784917760; x=1785522560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ha2R3BceyIc2R0jhxptsLkT4WXFi98WEMigXc02pveU=;
        b=UGXzJMmWTGc0rIol6GFPV+zlf/fmgbHOmf9NFhdG0YDgvEfu49cNw/PM1wbUt367LB
         9L8/bT225k3X+izQN7976k5sky4ZrIZPlrzOJHKAc0cE1UePhaHzz3+Y2hUvv3f84wNl
         rIrPJZI3w177AycGFk0TDudNTI8cRKaJQ+a4EecB/FniwYbpnK5XTogRgYNc0Pzke+8S
         dteVlt2SOVrhB1UQP07GolBOc7ObNRnfi4C+5S6bBu+ih1tGd515ljX61ArT1YDEVRtc
         d9UWlu7+39SvYX4qAsKjj3ByjekA51qzsYHj7JLfn9rStSuJcocSouG5911tr901ppn/
         pxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784917760; x=1785522560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ha2R3BceyIc2R0jhxptsLkT4WXFi98WEMigXc02pveU=;
        b=SeeMUa7ThVyqatm25NcE+z7uH7CxWLUB07MInkiJNQ5QHzD5hRzie8W4Zk15lX06iP
         dJPGwO8lHIhj9d/3rIsA1+630rhBTf7AXs3z48gc1s5B1DY8d6/ls1JkG/lV7w3x9pns
         bmcY33e1UIyfw73ds+9nMzyy2oi2cCluo6kz7udnxfEu/1g66IE2TynnoOrSdNKAbmCl
         odn5RvdoqRd/ctR9rh2tRtgpdxpun5pCjc0KRVzDUWG7EApDiVkuFFqQAwqNbzhppAoF
         tpWmcoukEgB88pxJm6GeVkIdNUERveeR93YHk3RlBPXpuKSEFwECFXZr2dNfqEX37pZn
         lz3w==
X-Gm-Message-State: AOJu0YyIIPmtgLlcE+tTCWEVQkV1xbyMABRTcqh5d1yd3sPCq7QDUvZd
	4rTaPmDRfV7K519kemFT3W8idCIrb0tny8jI9gcFpAcz9gl+feXsVipuPawdvw==
X-Gm-Gg: AR+sD10h/oHL3uXS9PwyIQlnsAlh4nm8WCl7oMf+RGu4j48yVqHuQGlEvuLZcV0vsJv
	/THelrKU7PuapCQxM9UVAaQOOUXRzE7AiyfvgeqbLR/yFW1q3AXI3SkAryPvU6R1bvsyntpxBIu
	EjlWDIcH1R6DqJCa/ImC3dav+/cWkEYx2HfelBMInOtwg5JhzHI/wJS15ka+5kMO5KaGD3HKKCk
	N4l2samUX14zpwMmpyrfAOYKpsHFxV2hPu8fOOhO+tOaVhLh6ouiUiF5JC+uLzaOb3smr692CTC
	Od14cIcMeczjzPBVuBePkee3OIi2TX6MaaMXSQ6QAwd8/i1Gd898Uvc0X2OM1h4TnI082ykBHFC
	ctdsJxGETLCNDTwWBSD8kN8aL6JfQnMbWzQQ94V1rsCYf/fiwIRRtqHNdmbHebIdRGcTIE/9msG
	TVoTvlGi9AyKIHY/BVj0hyR9+f
X-Received: by 2002:a05:6214:2305:b0:8fd:6e32:1aa5 with SMTP id 6a1803df08f44-907ca69a0b1mr91842106d6.63.1784917760394;
        Fri, 24 Jul 2026 11:29:20 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e871e226sm3765026d6.47.2026.07.24.11.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 11:29:19 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/2 v3] libsepol: Validate more access vector permissions
Date: Fri, 24 Jul 2026 14:29:07 -0400
Message-ID: <20260724182908.97023-1-jwcart2@gmail.com>
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
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v3: No changes

 libsepol/src/policydb_validate.c | 36 +++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index e7d79871..1d8e0870 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -12,9 +12,15 @@
 
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
@@ -283,10 +289,8 @@ static int validate_constraint_nodes(sepol_handle_t *handle, uint32_t nperms,
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
@@ -1109,11 +1113,7 @@ static int validate_access_vector(sepol_handle_t *handle, const policydb_t *p,
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
@@ -1232,12 +1232,24 @@ static int validate_avrules(sepol_handle_t *handle, const avrule_t *avrule,
 
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

