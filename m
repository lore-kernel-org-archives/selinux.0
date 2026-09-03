Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D9F473C8C
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435403; cv=none; b=YLLfgCZaSqQvhaTtrk4FKMhVZ3hEXmISqilwtLdHNb9qDkIfPAh1SxsU0gGk4HvvA7c7aBxbhrBP+/jNYGUAtmTb24LZZV0gwSwOhxE6dtGvzumwew0P2XGnsAFc+UYaxRbi9unEz7HWrHzAvTjx6pRgnmXXVXm6axEmxFVtC4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435403; c=relaxed/simple;
	bh=uzj8fh1u3+o55iGWNeLvvtMSLSwpAzuDP6OumWmYHBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3+3xPJ6KPkhsPCBn+FSc/buLU1vmoRohQOC+Bqfpqmrlf+o0/ir/imjHoIuIm76v+WDvE9pAQueKR/Yhzznkve0lppJG7wdZOaGXeIwmu1NdhncBKbzAXkKwbwQSuze85h5c4mbCaqSECHvy2AN3nuxEBAFQYHJ+0YlYICleTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=qS9wGMbD; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="qS9wGMbD"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1788435387;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cn6HXQwaHeCDmfvQ6gXSEd0Wv7OhnzWjbV4GEj3quSk=;
	b=qS9wGMbDucEMir7WGpf1n2t2J9b1ygMVijinYXhcaEUdvJAk1v7A+OAEynlisXMHkpLqbD
	F9CrLOtnEeLepHHU2/qOM1jA5TW6kWqtaRwzYeZXYo5R28rEyrPVRx4zFQDwTXqMpHNydN
	QQqEB+wLGphwV+EkrEYN518+q17g0No6m5snaC8fdIJ7xAoicV2LHAcvdrpK7srYdFM5wV
	VAz2FVdWeP+70qmn4pRA7PianP2jc6SoYF7hQnC+jXlzRZxbIwxzgf1Ty8KoWLS2H89+NO
	G+axAbblBMM3YhYI+pNqKA+Zw6Q0/PbiOHFj57oZ5yv9FPRhasw1x2OaUtWNNg==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/5] selinux: reject duplicate symbol values during policy load
Date: Thu,  3 Sep 2026 13:35:38 +0200
Message-ID: <20260903113538.72942-5-cgoettsche@seltendoof.de>
In-Reply-To: <20260903113538.72942-1-cgoettsche@seltendoof.de>
References: <20260903113538.72942-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

The symbol index functions assign unconditionally, so two symbols that
share a value silently overwrite each other and leave another value with
no entry.
Reject a value whose slot is already populated, for commons, classes,
roles, types, users, sensitivities and categories;
booleans already have their own "declared but not defined" check.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 4342258cb148..3451a0295cc2 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -560,6 +560,9 @@ static int common_index(void *key, void *datum, void *datap)
 	if (!comdatum->value || comdatum->value > p->p_commons.nprim)
 		return -EINVAL;
 
+	if (p->sym_val_to_name[SYM_COMMONS][comdatum->value - 1])
+		return -EINVAL;
+
 	p->sym_val_to_name[SYM_COMMONS][comdatum->value - 1] = key;
 
 	return 0;
@@ -575,6 +578,9 @@ static int class_index(void *key, void *datum, void *datap)
 	if (!cladatum->value || cladatum->value > p->p_classes.nprim)
 		return -EINVAL;
 
+	if (p->class_val_to_struct[cladatum->value - 1])
+		return -EINVAL;
+
 	p->sym_val_to_name[SYM_CLASSES][cladatum->value - 1] = key;
 	p->class_val_to_struct[cladatum->value - 1] = cladatum;
 	return 0;
@@ -591,6 +597,9 @@ static int role_index(void *key, void *datum, void *datap)
 	    role->bounds > p->p_roles.nprim)
 		return -EINVAL;
 
+	if (p->role_val_to_struct[role->value - 1])
+		return -EINVAL;
+
 	p->sym_val_to_name[SYM_ROLES][role->value - 1] = key;
 	p->role_val_to_struct[role->value - 1] = role;
 	return 0;
@@ -613,6 +622,8 @@ static int type_index(void *key, void *datum, void *datap)
 	}
 
 	if (typdatum->primary) {
+		if (p->type_val_to_struct[typdatum->value - 1])
+			return -EINVAL;
 		p->sym_val_to_name[SYM_TYPES][typdatum->value - 1] = key;
 		p->type_val_to_struct[typdatum->value - 1] = typdatum;
 	}
@@ -631,6 +642,9 @@ static int user_index(void *key, void *datum, void *datap)
 	    usrdatum->bounds > p->p_users.nprim)
 		return -EINVAL;
 
+	if (p->user_val_to_struct[usrdatum->value - 1])
+		return -EINVAL;
+
 	p->sym_val_to_name[SYM_USERS][usrdatum->value - 1] = key;
 	p->user_val_to_struct[usrdatum->value - 1] = usrdatum;
 	return 0;
@@ -647,8 +661,11 @@ static int sens_index(void *key, void *datum, void *datap)
 	if (!levdatum->level.sens || levdatum->level.sens > p->p_levels.nprim)
 		return -EINVAL;
 
-	if (!levdatum->isalias)
+	if (!levdatum->isalias) {
+		if (p->sym_val_to_name[SYM_LEVELS][levdatum->level.sens - 1])
+			return -EINVAL;
 		p->sym_val_to_name[SYM_LEVELS][levdatum->level.sens - 1] = key;
+	}
 
 	return 0;
 }
@@ -664,8 +681,11 @@ static int cat_index(void *key, void *datum, void *datap)
 	if (!catdatum->value || catdatum->value > p->p_cats.nprim)
 		return -EINVAL;
 
-	if (!catdatum->isalias)
+	if (!catdatum->isalias) {
+		if (p->sym_val_to_name[SYM_CATS][catdatum->value - 1])
+			return -EINVAL;
 		p->sym_val_to_name[SYM_CATS][catdatum->value - 1] = key;
+	}
 
 	return 0;
 }
-- 
2.55.0

