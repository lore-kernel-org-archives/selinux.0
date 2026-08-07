Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96FD30BF6B
	for <selinux@vger.kernel.org>; Fri,  7 Aug 2026 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122356; cv=none; b=BZH6MXQucQ5AeV0lIZfJjAfgY9K72BQK8KdoOJhIB5+3A/ITaE0S1DcWBnH4UnG5bRrQ8CyHfmLA4IHC5UTa4ReQfLhVA+UzBWIndmnnu3SdpXz56K//2WurAKj2TOv9CmG9B2vxN1kVkOauDtCYD8dAx3mVYB6svGcXglMuXhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122356; c=relaxed/simple;
	bh=8rC/8KiwXw/Ms9ZyMjbQhXyapIMFbcHgVtz3hjEFSJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LRNUOuX47bnAGrCu6h1YHI59616ty7YyQ7DqOJI+YvMp4l3bIYI0c+rV4HYm3KOyMnFdwt38SVcQIReE/6MVNsEC2qAxZ3fbJbQkQWVTq7Nee0yo6uudNDN651Kj51Tp8UAJyNiJfwvdPexOr6PAKslfkkHAEkmIAt0QCtBtx14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IETDX0EX; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IETDX0EX"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e5c9211d2so286943485a.1
        for <selinux@vger.kernel.org>; Fri, 07 Aug 2026 10:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786122353; x=1786727153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VrR36WP9HWDHcOcJcuD7DLAr3SZvdnEorgEgxJpaoUY=;
        b=IETDX0EXw3oKUT+Zy3WBz0bPWWajDRPAYL0rz4LDBcmGK2aXeslHvbP2AKc+ztKpYK
         Jzx865g1pKEdFrpKrVdFexV4UbGGURquLtptUp/CbgtVQrEX2vQ0eKia7vtP4M49CRC1
         mZchhQAgRQ6ThoxFoY1uouc840qsyqStXpKEpyGUdEKTYB9XYgOrPwZg02/r2uAm6W9L
         TcZfn5V7eszfdCLumvmReLiOt3QJP7EUulzAMmZb+XwPkhycbEoteok24iSrzsoPpA3d
         JFbgIeBZ2gFXR9r5cV8e+GK8emfCHqLG6jQGdf6bk9BzttbhN7G5lRya9tU2Yny5nscq
         icXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786122353; x=1786727153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VrR36WP9HWDHcOcJcuD7DLAr3SZvdnEorgEgxJpaoUY=;
        b=raqqk3Dz3LjYdaDJ+kP7qL7E1zrPAmAE5y0MjiRYE1n4bo8k+H8UXKAhQBn16DtISx
         a/dNGdxVL7pdA4AZQGLPFFSAAEU1ijN7IZqveDZD3pADrigSif+0i313axNbem7/9Dsh
         vmrQdDpjxHX9DITlISvSUmE5fBJNKWhhCM9w9GL/HhVbXWsydYXWpEOoFD56+m92rVuk
         dzIiy63q0q2raxe0L0Q4n5FWCgEfEqIWwzxY2kgfRTaxXD8rwLjrogInUWYogeiouLnN
         A8L7OAbptGuJbdCIcKvFDrtvfuaTKmd5HjjvX+V3lDoOC6mWKyPlHJ0lPQS1OwOFMVDt
         d/3g==
X-Gm-Message-State: AOJu0YxKLjIk0QqPtrDjEckrRNMt02y5mlloF4YPpl9YYl6rv+899wae
	rWxnUTzNQgs4gdXR6xDDGSXkiVrZot5zcTcWbBc4uH9Lg3OF+uefUBwNM4sbpg==
X-Gm-Gg: AR+sD1221aNVNs9fjk5GLYUCGxLAFPYFz7DDLLpHNDPHOP3SZMOn51LQ58oTWAyfMAY
	UP9hv30gyUU8UxDaF7IXiKoML04+KNQ7DxpAX/c6RHgHDnoXqfc9RwmvXgdIcZh+tDHR/cVA9zg
	xmOV8LExmV5PcvUAmjBGA2SwKqOmbC8AjrGnfUkbgLUkqDiJAFcAmnSBUjPk13qbhH09QygYv1b
	0nR54HXqd5pM1gQNhDqhBsHDFeklBpkO3OElbfSFt32D7VKNqMjFpME5tu9ff9XY4Fi719ZwQ7y
	4d9SNuOjNIBOadLWIB8Q3tCLNElEQRDRHfXCj7dCEK63bbtbM233W7w2yDe+EzOuF6IaubW++0l
	IyBnnpAXZ+JXpJcK2VihhEUgaASPS89vZ0TXFXF4nGfSOLzMOIYEmj+G2CoT5150lf9OevKMrjf
	N4mAPhhNxLd9lKkqxdHKkILAQ4iQZr6qxJ8o+pLocVLv6H8WtIdBsnRPFmnwjQJJFS4b0pWFwqL
	t9eVHsWZVlUoLbse6S78Ix7MKc3VYi98nehmS7BJJsMCCTKQOSxuBzJuS/gMB/tvchtOT1lOAk=
X-Received: by 2002:a05:620a:a713:b0:934:7ffc:7f90 with SMTP id af79cd13be357-9367991a162mr172834785a.36.1786122353473;
        Fri, 07 Aug 2026 10:05:53 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e03aeb8sm191364385a.4.2026.08.07.10.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 10:05:53 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux: tighten policydb_context_isvalid() checks
Date: Fri,  7 Aug 2026 13:05:41 -0400
Message-ID: <20260807170541.11895-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

policydb_context_isvalid() bounds each of user, role, and type but
does not require the value to be defined. A crafted policy can declare
more identifiers that it defines, so an initial SID or ocontext
context whose type is not defined can be inserted into the sidtab and
later reach type_attribute_bounds_av() from
context_struct_compute_av(), thereby reaching the
BUG_ON(!type_val_to_struct[type - 1]). A user with no datum can reach
context_struct_to_string() and thereby trigger strlen(NULL). The user
and role datums are already NULL-checked further down but only when
role is not OBJECT_R_VAL, so an object context can carry an undefined
value through.

Use policydb_{role,user,type}_isvalid(), which check both the range
and that the value has a name, in place of the inline range checks.
The name and datum arrays are populated by *_index(), so a value with
a name also has a datum. This runs after policydb_index(), so the
arrays are populated. The now-redundant NULL guars on role and
usrdatum in the OBJECT_R_VAL block can then be dropped.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/ss/policydb.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index c4a81bd31e05..3beb3bd60e0f 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -995,13 +995,13 @@ bool policydb_context_isvalid(const struct policydb *p, const struct context *c)
 	const struct role_datum *role;
 	const struct user_datum *usrdatum;
 
-	if (!c->role || c->role > p->p_roles.nprim)
+	if (!policydb_role_isvalid(p, c->role))
 		return false;
 
-	if (!c->user || c->user > p->p_users.nprim)
+	if (!policydb_user_isvalid(p, c->user))
 		return false;
 
-	if (!c->type || c->type > p->p_types.nprim)
+	if (!policydb_simpletype_isvalid(p, c->type))
 		return false;
 
 	if (c->role != OBJECT_R_VAL) {
@@ -1009,7 +1009,7 @@ bool policydb_context_isvalid(const struct policydb *p, const struct context *c)
 		 * Role must be authorized for the type.
 		 */
 		role = p->role_val_to_struct[c->role - 1];
-		if (!role || !ebitmap_get_bit(&role->types, c->type - 1))
+		if (!ebitmap_get_bit(&role->types, c->type - 1))
 			/* role may not be associated with type */
 			return false;
 
@@ -1017,9 +1017,6 @@ bool policydb_context_isvalid(const struct policydb *p, const struct context *c)
 		 * User must be authorized for the role.
 		 */
 		usrdatum = p->user_val_to_struct[c->user - 1];
-		if (!usrdatum)
-			return false;
-
 		if (!ebitmap_get_bit(&usrdatum->roles, c->role - 1))
 			/* user may not be associated with role */
 			return false;
-- 
2.55.0

