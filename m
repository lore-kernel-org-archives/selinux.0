Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5044457B0
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905776; cv=none; b=OrbNe9ZBiM1hHXs5F5XkKTkUWTjR45p2AOAV150NKGwEhbokJ26IskWfp9nC9osIwPvf1KIoOhDgqx8a88nwIRiMm8IJeoldn/eGaWGri4immJpZuZ0yq1nvlAthJa7oIMJefLeYnBOzFA97ileppqy9m/k3eFHrkYTqedAfa0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905776; c=relaxed/simple;
	bh=BzbHBzkywrBT1GnP7BK/9Y1KfjiAfPt1ByXmF3PfAKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WRf3c+7skfN8iBmvlFOsPh0Dv8XQlKts+5wUJgEgMI+z1ruCIz8pRw+jXr3kIOHOFcpiEHda5LwQ/0J3HnJa2L+PhhYyWoS6ap44FWUX1w5HRmrh5bx3ZyU745tj58WJEem4+9ZP0tGpSzSEcnr8C/NS2FMBckHyji/+PtQTu3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XV2Q4KIs; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XV2Q4KIs"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8efcef23d21so5295896d6.2
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 08:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784905772; x=1785510572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2L1FqDNruLjPbyxni2//ZhUtItWN53T6yG0B6iCxV+s=;
        b=XV2Q4KIszBqc0Kdim9T25SrnRFrLgEbY5O6WrnS22xLbklNg9+A67oBub7QGOFAN8D
         v/ZqSeCUOwU14El42F/2cMQUHWOhuSTt5wKMEPQKhOSXM7joD1KwN98pSirPlqK19BDE
         y8H6L8otjUWwHrcYRgCERq4bbiyVzL2BxIZZS0t3mepYa4OFuG0K7A/4/UKtWJJjxmHX
         KLprwu0l6TCNn96NK82z2chKkU6iJ5MtyBZ5V7hlD8/Hn4msyaTNqOvGEvF7OUoT2oyX
         JbuIdcZNcQyWieNgZoyaB0iLrfTJgpsxyzaGVWvNSFFIkVKtikesO7ny3l87Fsj0XfkA
         U/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905772; x=1785510572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2L1FqDNruLjPbyxni2//ZhUtItWN53T6yG0B6iCxV+s=;
        b=ViIPGUklmBPoOOn0HZTZsxXbGczeDUtgE+5vW07G6+u4zHsez+wudpvGuHErOZWkIZ
         WJMwGx20WH0kdV6ozN2JJ+vMKuOshu7e1IQmutrBmNm5zIFx18AZjqot0ReAe3/4w1Lf
         ze9MJpTaf3zoc3wre05NcdZkatxkvawxtzIrZXDrVxyviLo5/f+hqChiRe81b+Cb2pTo
         ygCdDfra/nmLHjqKpGPvi/a1FgyRgXIDICX58jy5M7BHFKZkRJucVjJZVkK8K3UCdAtq
         wV2+q+vGl6UahmE+k38tePK4AZIW92E88Wphn8luGMZI3JIw+2Aa8VcxEKfmVlupO9f4
         7ZeQ==
X-Gm-Message-State: AOJu0YzCaiimV/iimUDf1bJpEeTGiHmYnsi5G2ghlcmRXsgdX+6DpTok
	H5X5W8mambsvCgCJmQaNordydLZrk90T3s7gBnSllVjto5BrhGEShBODhrh2XA==
X-Gm-Gg: AR+sD122nws96LvhnzlCxaqAtcWZlOVujJqZ8CffHfAkHtHv8GWYd3SIAC2s/JHvMSR
	VaXJ9hrntjSirc54hj31948PEjktst8E/f+Zcw6dzP1HrSViS3eiBhMGOYHZi7uB2ZailubGVTp
	N8QPp1RjbKP2JpiSZu2mimSzKpM7qNfPR2SEi069ABdmEtfCVMr9HB18/TowvaWFb46lRUj6vd1
	jAyC3tkmAEoK6nRJHiJfjF2kZok1ldXJNhovZ0DLC/yy0P1tvjJZwP1go5t91DRdJmhGI2S+TCN
	PF1VAWMPw0kJUe4isIUeNtLVfSDQrcfv/9+BAlrfhBAXELhViUmlJorHz6YBIvr9jbWDKnB+pra
	72HEv6my0PPEq3NY0e4te0qyXEy5YEQwOkBdVV969wO5jTV3IwgLFQLPXIh+uTPMMHN5wwHF1Zg
	3GydDtMuqDJCgzqAFgAMwnqMwB
X-Received: by 2002:a05:620a:c4e:b0:92e:f3ca:2ece with SMTP id af79cd13be357-9310370be2dmr805834185a.54.1784905772343;
        Fri, 24 Jul 2026 08:09:32 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f6a6a157sm670153285a.37.2026.07.24.08.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:09:31 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Fix double free in cil_deny.c
Date: Fri, 24 Jul 2026 11:09:16 -0400
Message-ID: <20260724150916.48989-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function cil_create_attribute_d1_and_not_d2() (let's call this
f1) mallocs an ebitmap named types. This ebitmap is passed to the
function cil_create_and_insert_attribute_and_set() (let's call this
f2) which will create a new typeattribute which has its types field
point to the types ebitmap passed in by f1. If there is an error in
getting a symtab or inserting the new attribute into the symtab,
then cil_destroy_typeattribute() is called during cleanup. This will
free the ebitmap pointed to by the types field. After f2 exits with
an error, f1 will perform cleanup and try to free the types ebitmap
again.

Move the calls to cil_get_symtab() and cil_symtab_insert() to
earlier in f2 to make it easier to clean up in the case of an error.
When cleaning up from an error do the cleanup manually instead of
calling cil_destroy_typeattribute() and do not free the passed in
types ebitmap. Function f1 needs to call ebitmap_destroy() (which
is safe to call more than once on a ebitmap) and free the ebitmap.

Also add ebitmap_destroy() calls to
cil_create_attribute_all_and_not_d() and
cil_create_attribute_d1_and_d2()

Reported-by: oss-fuzz (issue 500754862)
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_deny.c | 44 ++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/libsepol/cil/src/cil_deny.c b/libsepol/cil/src/cil_deny.c
index c81b8beb..dc0f4ae9 100644
--- a/libsepol/cil/src/cil_deny.c
+++ b/libsepol/cil/src/cil_deny.c
@@ -870,7 +870,6 @@ static int cil_create_and_insert_attribute_and_set(struct cil_db *db,
 	struct cil_tree_node *attr_node = NULL;
 	char *name;
 	struct cil_typeattribute *attr = NULL;
-	struct cil_tree_node *attrset_node = NULL;
 	struct cil_typeattributeset *attrset = NULL;
 	symtab_t *symtab = NULL;
 	int rc = SEPOL_ERR;
@@ -880,12 +879,25 @@ static int cil_create_and_insert_attribute_and_set(struct cil_db *db,
 		goto exit;
 	}
 
+	rc = cil_get_symtab(prev->parent, &symtab, CIL_SYM_TYPES);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	cil_typeattribute_init(&attr);
+	attr_node = cil_create_and_insert_node(prev, CIL_TYPEATTRIBUTE, attr);
+
+	rc = cil_symtab_insert(symtab, name, &attr->datum, attr_node);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
 	cil_typeattributeset_init(&attrset);
 	attrset->attr_str = name;
 	attrset->str_expr = str_expr;
 	attrset->datum_expr = datum_expr;
+	cil_create_and_insert_node(attr_node, CIL_TYPEATTRIBUTESET, attrset);
 
-	cil_typeattribute_init(&attr);
 	cil_list_init(&attr->expr_list, CIL_TYPE);
 	cil_list_append(attr->expr_list, CIL_LIST, datum_expr);
 	attr->types = types;
@@ -894,20 +906,6 @@ static int cil_create_and_insert_attribute_and_set(struct cil_db *db,
 			     CIL_FALSE :
 			     CIL_TRUE;
 
-	attr_node = cil_create_and_insert_node(prev, CIL_TYPEATTRIBUTE, attr);
-	attrset_node = cil_create_and_insert_node(
-		attr_node, CIL_TYPEATTRIBUTESET, attrset);
-
-	rc = cil_get_symtab(prev->parent, &symtab, CIL_SYM_TYPES);
-	if (rc != SEPOL_OK) {
-		goto exit;
-	}
-
-	rc = cil_symtab_insert(symtab, name, &attr->datum, attr_node);
-	if (rc != SEPOL_OK) {
-		goto exit;
-	}
-
 	db->num_types_and_attrs++;
 
 	*d = &attr->datum;
@@ -915,15 +913,14 @@ static int cil_create_and_insert_attribute_and_set(struct cil_db *db,
 	return SEPOL_OK;
 
 exit:
+	if (attr) {
+		cil_symtab_datum_destroy(&attr->datum);
+		free(attr);
+	}
 	if (attr_node) {
-		cil_destroy_typeattribute(
-			attr_node->data); // This will not destroy datum_expr
+		prev->next = attr_node->next;
 		free(attr_node);
 	}
-	if (attrset_node) {
-		prev->next = attrset_node->next;
-		free(attrset_node);
-	}
 	return rc;
 }
 
@@ -1038,6 +1035,7 @@ static int cil_create_attribute_all_and_not_d(struct cil_db *db,
 exit:
 	cil_list_destroy(&str_expr, CIL_FALSE);
 	cil_list_destroy(&datum_expr, CIL_FALSE);
+	ebitmap_destroy(types);
 	free(types);
 	return rc;
 }
@@ -1103,6 +1101,7 @@ static int cil_create_attribute_d1_and_not_d2(struct cil_db *db,
 exit:
 	cil_list_destroy(&str_expr, CIL_FALSE);
 	cil_list_destroy(&datum_expr, CIL_FALSE);
+	ebitmap_destroy(types);
 	free(types);
 	return rc;
 }
@@ -1168,6 +1167,7 @@ static int cil_create_attribute_d1_and_d2(struct cil_db *db,
 exit:
 	cil_list_destroy(&str_expr, CIL_FALSE);
 	cil_list_destroy(&datum_expr, CIL_FALSE);
+	ebitmap_destroy(types);
 	free(types);
 	return rc;
 }
-- 
2.55.0

