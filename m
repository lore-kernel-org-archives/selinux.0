Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2661376BEA
	for <selinux@vger.kernel.org>; Wed,  3 Dec 2025 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779553; cv=none; b=O2eHeSWiVTFgsdeOtzg5FxKNmgetWHno1O86A2hFWlMMft6os205nXEdmNs25Zhkwqhah/KNOS50ljCDqyyECR4HqE9tWiVe6JxvIav6RgZEL8unh1+tS6GiyfuP4jAZ1V+8roNIpQfeVdhA7L7P5rtzMNbB90UdBrbi4q8vmCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779553; c=relaxed/simple;
	bh=GjFe7L6yy+TvfAwheju5QSPHeWndkHoS3r0/xSIuUx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhWLhBfH2RHvHiuoRMKDY5zEBR+IJvlxLh5TZ0O5kLosO+V38cK+CSJwHJlcRXrJzNjSqguuiskzZSpfdT8VmZ3pBKmcpqxsyBvS2d5wYPCMWjKLH5Scp3HyBBer0Bw9XiznvYXHgfP1m8t4S3C1Sv4YDBoCwIAqx3CPzZzhCKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnNXR8Gd; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnNXR8Gd"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b21fc25ae1so658599485a.1
        for <selinux@vger.kernel.org>; Wed, 03 Dec 2025 08:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764779550; x=1765384350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVzaAyJvhGMcBfiSytha9Bx0/ThVF6tyKDID5OUWJO4=;
        b=BnNXR8GdnZktnzJlt0NCtPEXnJDsDnYfN90PcWGvqCQz/OuEoWXuf1CMucniwfWf7H
         hRO/bIIxmyar39k7ARpaD3hb9rqbGni6Dkv98O2U5Vf0KwH9OCumU578c0WOHGLHLbIO
         YBB1EdGxDLPdOe+I9WrooYJOBfopJd4Cl+LKN6HgBVlR/x2evi+r72HAx9KMbr6oAuee
         acV/1NxxInm+bIDyxzZRJO29Rjq3F/h858VmCn0s2o4DvatL/zFDwjP5QzcvaZOkK3sM
         bpZtbnGorVUEZP2x8GzEcV1B/xSnWitYho8Pl41gSN20kbdUomB3qWLleaeW2GY3FVPc
         scXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764779550; x=1765384350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kVzaAyJvhGMcBfiSytha9Bx0/ThVF6tyKDID5OUWJO4=;
        b=Y1HyPFvbVLNCGxoZj6vba84Vf2Jdu6sBqiCt3LWmzo9EQ5U5ce+npcPsgOkGT0yXRH
         BvVLOgQ/ADH46dSCyn5Zz5wHPpDFx5hwKQ6Y5KZQXcyUCj7pCS4falmrK4AxaaFMHt9y
         5MPJWyuVo+Ev1mGA2Ns0M/Yl3/ZSxXOkOMSp5Rhslo/uv/Cvf6wAO6Qwd1yDJ+1YpAIe
         xS4eWLR18USxNAn2GVFTFqqdWAN2rnJb3zMuVX2slvxN7WVBRjDZfb5I69YpaX/oVANd
         rekgUJjURkC5Owc3x3+aTVHdEsoOgebEE3v17IDSOa+DxY+CRUSWu93JL2a6mtDwCeCP
         MzfQ==
X-Gm-Message-State: AOJu0YxVmmt4w2NKfPbzbx+Z01xAKU+IzquoIOcTvabmVXyawMY6YzKw
	yr2tvESK18RjcTq2PcYdy/xzcd7VLOlJMhVtUqyHZe9Vjkf5SZ/IqNNXxS6pVg==
X-Gm-Gg: ASbGncuE0qh+k0rykKbah96sMyAtN9VAimVCuIs1e7a69hLMkdekQN9Q8fmM/SF6WpJ
	SWdXcL4NVZ9QZhi7cSk4tNY/RXKspIRKYHVTQpReLwL+NzV7npd/DuIIAmq5tTGWthVF69ni8QJ
	Saqgw1g3RmqbvslEIcQMACZyxHJykYtglMJxvVXzwr0jOjb98og/HSA3XDebzU9LhLpWOWoJxNp
	tQxb2Lj83tUB0I5TR612H9NZiNPV3Ele7mFSwNTXGVhV9wTvnHtIcIIWaJ1sVOcASwt7WU6vwlm
	JqBa4+RFLWNCTiC5zDfEFgLcMaVpTj7w0bgl0ba7abAZWeO2+Oe2Wnn51a2x2ZJIG8jTyoPmOWA
	dzcs0PjXrze4V+r627bZeXv5PZscyA/UZkLWlVu5CYec4jkeBbJTiEx95NwdWRLRJNrueZdodY+
	zmgxkDMMAQtnufN9JIx6I=
X-Google-Smtp-Source: AGHT+IGRkpzH5NCGc4OOZR5fWmiIPEE69O/6MGSltfyFDj3DdFi0oyXMoJP7r5oZwGiCNJvGp5prvA==
X-Received: by 2002:a05:620a:711c:b0:893:31da:1028 with SMTP id af79cd13be357-8b5e725fbffmr381239285a.90.1764779550271;
        Wed, 03 Dec 2025 08:32:30 -0800 (PST)
Received: from fedora ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1cad4esm1333399485a.45.2025.12.03.08.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 08:32:29 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/6] Provide a better error message for implicit role and user bounds
Date: Wed,  3 Dec 2025 11:32:14 -0500
Message-ID: <20251203163218.54939-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251203163218.54939-1-jwcart2@gmail.com>
References: <20251203163218.54939-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implicit role and user bounds requires the role and its parent to
be in the same scope. The current error message says that the parent
does not exist, but, in fact, the parent could exist in a different
scope.

Instead, have the error message say that the parent was not found
in the same scope.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 checkpolicy/module_compiler.c | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index efbcfa7d..4b2f98d8 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -207,8 +207,7 @@ int declare_symbol(uint32_t symbol_type,
 	return ret;
 }
 
-static int role_implicit_bounds(hashtab_t roles_tab,
-				char *role_id, role_datum_t *role)
+static int role_implicit_bounds(hashtab_t roles_tab, char *role_id, role_datum_t *role)
 {
 	role_datum_t *bounds;
 	char *bounds_id, *delim;
@@ -226,21 +225,13 @@ static int role_implicit_bounds(hashtab_t roles_tab,
 
 	bounds = hashtab_search(roles_tab, bounds_id);
 	if (!bounds) {
-		yyerror2("role %s doesn't exist, is implicit bounds of %s",
-			 bounds_id, role_id);
+		yyerror2("Implicit role bounds declared (%s), but the parent (%s) was not found in the same scope", role_id, bounds_id);
 		free(bounds_id);
 		return -1;
 	}
 
-	if (!role->bounds)
-		role->bounds = bounds->s.value;
-	else if (role->bounds != bounds->s.value) {
-		yyerror2("role %s has inconsistent bounds %s/%s",
-			 role_id, bounds_id,
-			 policydbp->p_role_val_to_name[role->bounds - 1]);
-		free(bounds_id);
-		return -1;
-	}
+	role->bounds = bounds->s.value;
+
 	free(bounds_id);
 
 	return 0;
@@ -456,8 +447,7 @@ type_datum_t *declare_type(unsigned char primary, unsigned char isattr)
 	return type;
 }
 
-static int user_implicit_bounds(hashtab_t users_tab,
-				char *user_id, user_datum_t *user)
+static int user_implicit_bounds(hashtab_t users_tab, char *user_id, user_datum_t *user)
 {
 	user_datum_t *bounds;
 	char *bounds_id, *delim;
@@ -475,21 +465,13 @@ static int user_implicit_bounds(hashtab_t users_tab,
 
 	bounds = hashtab_search(users_tab, bounds_id);
 	if (!bounds) {
-		yyerror2("user %s doesn't exist, is implicit bounds of %s",
-			 bounds_id, user_id);
+		yyerror2("Implicit user bounds declared (%s), but the parent (%s) was not found in the same scope", user_id, bounds_id);
 		free(bounds_id);
 		return -1;
 	}
 
-	if (!user->bounds)
-		user->bounds = bounds->s.value;
-	else if (user->bounds != bounds->s.value) {
-		yyerror2("user %s has inconsistent bounds %s/%s",
-			 user_id, bounds_id,
-			 policydbp->p_role_val_to_name[user->bounds - 1]);
-		free(bounds_id);
-		return -1;
-	}
+	user->bounds = bounds->s.value;
+
 	free(bounds_id);
 
 	return 0;
-- 
2.50.0

