Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D71390601
	for <selinux@vger.kernel.org>; Tue, 11 Aug 2026 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461440; cv=none; b=QdTO3rUrGK4bT/IDxFY9vlz7N5YSRVLzB2w/lv3SjhRqYJuoBkRCOtyQI2chVOJwHPOzd9IO/QvfSgkdQaym8BNI1cLIbQKIJiL7QtnYabNxRD0uuP963OP2wT8SR9/5l28gcKnynqbuHTQwggdCy49pboCzb1W4eUQE/FCxzok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461440; c=relaxed/simple;
	bh=0OBK7gJIlOZU4M9OCEqDy4b5gdaeWobzQc6SHvmyZnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LXybVJia4IYA98JMdZopfsvWSNlUFrGRbIwDek2txWU5d+w8oIrM0FKiDxADwI7VU/nfC5/6ny8WKI4SrWzeOnUYrE7Xy8oWMs3LQBmw2qeuOU4l0fjPplHJmesmtRj4vi4AZNrIljI5ZQhsZbBi32PCHHTxvuEIfSy1Qzvs3OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZ4BiwPN; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZ4BiwPN"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5218927884fso195491cf.3
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2026 08:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786461438; x=1787066238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RN/hHxtQGu4pJqCBzFsST5baybZXZ66F3UYKINvlmOU=;
        b=dZ4BiwPNQMEyPlUOFe0EtGh0yU86pnGXyN4W30m9r8mcG7IxwtZNs2hMoAcR1/00Pp
         m/jd7g/WRF4DFoyj7yJwhgTOFMNTwmuNz1Aed4lQJxkDorRrieD+P1hUHN/XDGinoxz9
         MH4XlJ09rL6hn72OuEthIiEKg8k2uzn/RwmwDFODwcqL8lZQtDSuO+3gqfmDR8QeEdqt
         jQ9tyCLriiyw3OqhGTUz0ud2armXJHMxlLBMnTUowj17aVm1ZIP1wNYbgU0v7Sm6SJmM
         uVPOtNa9FJiluYzTNw1cH4j3DgKp/uQxgwXDKH1WTvMqYsRxKimnkpO1rez3LyET1yLe
         b7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786461438; x=1787066238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RN/hHxtQGu4pJqCBzFsST5baybZXZ66F3UYKINvlmOU=;
        b=iCPVMyWJwAcCtxg4EXnvh3bl1cYOiSIhmvluVqSwxzUH7Gv+UquPiX9qPQ01lIC+DG
         zdvIAaSvGAKAph3cOaf+92zBwDS8gvqtXYmwEYxVM5V1+rDJNPBFEvE8/J7SUB3C2tem
         19SbaAXGoSJwlb6ZsP2CC+wpw5gt5cvR/LHfytTE1IbYeJ25b0fRGxSge4UiYXpp+QiX
         Ll0YwexJl5llx/UtXiiV8m7rlBIyUOwR+etPvHQezqcLQyZbUMl2kgmnrJyjearj6wj4
         9o2fVNX9MVtkj62unIcG4b2dfS1X+9/rhEkBKAMbM10UHNKn9NZd3LG2vxkOi/uH40Ec
         7xuQ==
X-Gm-Message-State: AOJu0YzIAo3YqOLxraDI530Kad0wiA0d61dp2eYJLfeMx1Q+BMwbyoZx
	jkSTgps3dlzsLUDjnLyU3OcyNms2bmn54d20jOxJwpAg83xp54t+UhU39/6Rzg==
X-Gm-Gg: AR+sD13r9JqkdbW00u6x2y8U0Fra1B09O+JnaCRKqMdfnmcDWnGOhv8d6uNLKlG9f8o
	yPYDVx3bJlSWX3G0BUJ+z5ktqR1xOTDNYFfxhYmrU5rIFYq1xZeQD486OzcSr+RjPgrQOHyxImP
	M+bkMSezRJzE9ka/U9lKbFNChhsq/aG1a7jH65D+fqXvwY2pxEBT3XiklK+M55ztYHnVUNXAY3t
	jYEByhj1SRC0ZO8xdnMmI5kNhd6gQwW1+9K3LVqOofpuEjP/hob1KVwyuS/J+/2vGjKmrKng4wM
	ttbtN6lRjZ08r5Mz5vfpCwI9M6eV4Q2dlFv/X0709mYwUgpS22wgZjt6dsWEjpimhTuDCUmZtD0
	ro59wyLBrzilDpDgljLA998IvrV67Z70fiZW/HonHUTeY4bHoQstpfOjtmwAcV7OwvB2lypBQDd
	2bmTL8gm2bnF6S0HIeaRV5DqdL7zcsL4gVEFsYlgXmBYkVBAh4d2hITkuRmnDyBOpD1Y9UcCI2Q
	AoELT8p+Ls=
X-Received: by 2002:a05:622a:995:b0:51c:404:af7a with SMTP id d75a77b69052e-52d58638b35mr37570471cf.31.1786461438154;
        Tue, 11 Aug 2026 08:17:18 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d578f7d54sm13669111cf.5.2026.08.11.08.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:17:17 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/2] libsepol: Improve the validation of type aliases
Date: Tue, 11 Aug 2026 11:17:05 -0400
Message-ID: <20260811151705.109129-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811151705.109129-1-jwcart2@gmail.com>
References: <20260811151705.109129-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A maliciously crafted binary policy could have a type alias that
refers to an attribute or that ultimately refers back to itself
in a loop.

Validate that type aliases ultimately refer to a primary type
and not to an attribute or themselves.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/policydb_validate.c | 72 +++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 25 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 5687c82b..5178a2b4 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -13,6 +13,8 @@
 #define bool_xor(a, b) (!(a) != !(b))
 #define bool_xnor(a, b) (!bool_xor(a, b))
 
+#define MAX_ALIAS_REPEATS 32
+
 /*
  * Check that at least one permission bit is valid.
  * Older compilers might set invalid bits for the wildcard permission.
@@ -660,19 +662,23 @@ static int validate_type_datum(sepol_handle_t *handle, const type_datum_t *type,
 {
 	if (validate_value(type->s.value, &flavors[SYM_TYPES]))
 		goto bad;
-	if (type->primary && validate_value(type->primary, &flavors[SYM_TYPES]))
+
+	switch (type->flags) {
+	case 0:
+	case TYPE_FLAGS_NEVERAUDIT:
+	case TYPE_FLAGS_PERMISSIVE:
+	case TYPE_FLAGS_NEVERAUDIT | TYPE_FLAGS_PERMISSIVE:
+	case TYPE_FLAGS_EXPAND_ATTR_TRUE:
+	case TYPE_FLAGS_EXPAND_ATTR_FALSE:
+	case TYPE_FLAGS_EXPAND_ATTR:
+		break;
+	default:
 		goto bad;
+	}
 
-	switch (type->flavor) {
-	case TYPE_TYPE:
-	case TYPE_ALIAS:
-		if (!ebitmap_is_empty(&type->types))
-			goto bad;
-		if (type->bounds &&
-		    validate_simpletype(type->bounds, p, flavors))
+	if (type->flavor == TYPE_ATTRIB) {
+		if (type->primary != 1)
 			goto bad;
-		break;
-	case TYPE_ATTRIB:
 		if (p->policy_type == POLICY_KERN) {
 			if (!ebitmap_is_empty(&type->types))
 				goto bad;
@@ -683,21 +689,37 @@ static int validate_type_datum(sepol_handle_t *handle, const type_datum_t *type,
 		}
 		if (type->bounds)
 			goto bad;
-		break;
-	default:
-		goto bad;
-	}
-
-	switch (type->flags) {
-	case 0:
-	case TYPE_FLAGS_NEVERAUDIT:
-	case TYPE_FLAGS_PERMISSIVE:
-	case TYPE_FLAGS_NEVERAUDIT | TYPE_FLAGS_PERMISSIVE:
-	case TYPE_FLAGS_EXPAND_ATTR_TRUE:
-	case TYPE_FLAGS_EXPAND_ATTR_FALSE:
-	case TYPE_FLAGS_EXPAND_ATTR:
-		break;
-	default:
+	} else if ((type->flavor == TYPE_TYPE) ||
+		   (type->flavor == TYPE_ALIAS)) {
+		if (!ebitmap_is_empty(&type->types))
+			goto bad;
+		if (type->bounds &&
+		    validate_simpletype(type->bounds, p, flavors))
+			goto bad;
+		if ((type->flavor == TYPE_TYPE) && type->primary) {
+			if (type->primary > 1)
+				goto bad;
+		} else {
+			const type_datum_t *t = type;
+			uint32_t v;
+			int repeats = 0;
+			while ((t->flavor == TYPE_ALIAS) || (t->primary == 0)) {
+				if (repeats >= MAX_ALIAS_REPEATS)
+					break;
+				v = (t->primary) ? t->primary : t->s.value;
+				if (validate_value(v, &flavors[SYM_TYPES]))
+					break;
+				t = p->type_val_to_struct[v - 1];
+				if (t == type)
+					break;
+				repeats++;
+			}
+			if ((t->flavor != TYPE_TYPE) || (t->primary != 1)) {
+				ERR(handle, "Alias validation failed");
+				goto bad;
+			}
+		}
+	} else {
 		goto bad;
 	}
 
-- 
2.55.0

