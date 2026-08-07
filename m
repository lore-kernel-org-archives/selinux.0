Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB24435200B
	for <selinux@vger.kernel.org>; Fri,  7 Aug 2026 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786130058; cv=none; b=MQi0N9mDD58BZLdH+ISML7CstYVziuXi47D8fxU42pVHQ++HiX1ZBPEU8j9dxof1eKhy5lSH2xzVe3K+0pIVWF59bY92Uk0VOYL64Qb0iTxxsDMr0E5sarBv4wC1qIzHbaacg2yuuBVtgYhRrj5FFwXOxBr7c2mPq1jBAu3JVzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786130058; c=relaxed/simple;
	bh=oGbwC2rDmpzYEbA3saSyPK1DUnfKPNf8M2N0myBP78A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fyWlFva9Zr0Z4tZAFfo1s2PqMlk1D9Nu2LNQrBzq5QsgztWHU3g1l0Kl+6mEvuivkC+orSl8uGXyBWT26P09bAHjkCGwA2/Y9KpxxT7fXZxZWz6sgWLRAob86Giz75sBYJ8YpSfbZdNbWrms1hWs2AWr0hyGBgjV9MpQFFuzP+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbgN2CYS; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbgN2CYS"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e53581361so206723485a.1
        for <selinux@vger.kernel.org>; Fri, 07 Aug 2026 12:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786130056; x=1786734856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BiVDN7KFw3Pe0TDIP//WTFERnC5G1R8hTO2CN1gFzhw=;
        b=GbgN2CYSHtCg0/nOZBHcwM61svtR6a7wph98N9hSaN+kUIKL323GEmCDSuZlHenH8l
         koeksDqu3DJI87xBS7QHvbwAUlm/08hRrQvmuLZI6dl0ksB2/7QUYaVeMbXV5o8qXvfC
         +kwSellybf3IjUrmQpQ7vwQHsq9+9xSAUCSqKwfawTjK9/5N7Hhib09oGRvyEQ6nsSAb
         mro+xIGfQRRLuxTK4pJ4s52IjCkCntO5ozeA2BBv8x5d9AFj9w0oOkn1mYGsLiHxUz9B
         IITdSlyMciAtY2CmFRWjAmJwvG7BmTg0l+GVr8XpR6gQnfbjJLFj2NqEagi98Re6B+FX
         JY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786130056; x=1786734856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BiVDN7KFw3Pe0TDIP//WTFERnC5G1R8hTO2CN1gFzhw=;
        b=DyIa5uJaJVGiN5rpOWrPTVKLzWcLE+fRHqcb53yrcWkpYDooWurL3p5OvV0bciXJ2t
         jh4w3tvuymNKkQ9kI0zljzRbccAIm23JGUXiJSUPF10lLJyoiUiRKuMwZWppJJOAzAxI
         AOwZLbYmXxdbCeT4rIgOKH8xPZW2+3o++ucToLtSuzQwJwhCXlOvM2W6XEo4ps98VN0b
         Kvvd2oNGcN1sFxf8YV/eevydLlyDMKhHWyovJoOd7t6hzp7qsvFMfd6zWOFd8P+e/CTY
         rRL1v0fD+CgP2sXJc+pxEUWQot7+pYvSyE+raNC3foXXyfFpet0SP2JhkjXdgXYXSQY7
         BPWQ==
X-Gm-Message-State: AOJu0Yw3iHzHGbnC/tACMv0h0XvuSGCF5uqg3DcTEh/hjpEDoVZaH0HU
	GpyXKRphdalOSbuKgK2ew66stXJ/Q4sjkJYASJ8e42vNyPuyWBXlA4OFZpsvUg==
X-Gm-Gg: AR+sD13UTRif9JhIkhRUUZ+evox+8BdrXBrbf4PLUr8BEYT+WqkYW/efSTvkyO+gjcy
	PtjCb84Dyj6Xc4f7UXqVqHwl5+RqlX06qTGTEvhLHt57NDDfXxb9jaxG887QQ/vQVYLdVsJFVZw
	NDNeZm05vOssvkaCjGQY8duQocg71A93j6H9c0ZCX4srFTztunYTfsGNQ3IHFo2JjItEdoI+Oqx
	P3g4F8n9h/Wr0LofsF2fZIZXz1+nMXunbIrfA49QwL+lmZKVZzqdK8P7aMHOL0LR4RqKYDPDk9E
	I1ycFycfE4d92yAUMO25goflZT8Jb6lkpMLGF6ocLWwJLxd9qPTcA2z8LK5RsKSt1bhkq3JupR3
	bWRtC/rXvcr7YG49QiQLCprw8HwwSxD6uAPrrazNUKJxY++rLJY5yKx/uB2XmfSLl027I/sBDyh
	scyftdtVzdzTZsjlbKvKyfRpRZdDWTJa8oW0pKCyZ8vCwU9Sg9qvMqovmBd3VgrmuO0g3eG8OC6
	EVIfsMoFEICzfMDY3Y0KVQLcmZ0tXlgQmiVlZ3+NNzCFYFMO5u/HpcNf/LyF6d/
X-Received: by 2002:a05:620a:3188:b0:915:9a39:1d68 with SMTP id af79cd13be357-93648faf86amr2349642185a.5.1786130055595;
        Fri, 07 Aug 2026 12:14:15 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e226895sm216920685a.23.2026.08.07.12.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 12:14:15 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] selinux: tighten policydb_context_isvalid() checks
Date: Fri,  7 Aug 2026 15:13:43 -0400
Message-ID: <20260807191342.19500-2-stephen.smalley.work@gmail.com>
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
arrays are populated. The now-redundant NULL guards on role and
usrdatum in the OBJECT_R_VAL block can then be dropped.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 fixes a typo in the patch description.

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

