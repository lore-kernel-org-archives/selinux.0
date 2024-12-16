Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924331FF7D4;
	Mon, 16 Dec 2024 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367295; cv=none; b=VKm/HguONv6hDqHF6rhFB12AYuE0ArSG7vFNiQfzSBpnP46YAuZpMM9F8vZ3WMwypi3xeJz0tCK4m6rdXJPdN1SpbWfqVqLHcEclbUU4xZ47Nbd9qU8poaJyv865vcAOJmweh+9ZNFPqAIQ9RmhDz6tnUU5IhBJWlKOfx4Rqusg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367295; c=relaxed/simple;
	bh=uAapJO9f5WIp0vG8iHGKY9a5LPw8uhA4byTpuXc1vok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uczna+dDZsOZY9ni7YXptkoviYSOF5qBbI6NgS32bh92XOXm7wHu5SnWZCOb3jVYcdEVmUsXF7nYKHcQbsietSOA0HkCSiSPnP9pr840V6EZN5C0eY55Jtea8w1pHGjEgQQHEBHkVAPvjXUmwcfFHlwdExLvGvqrWEjoXx7y/EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=GhgjcsM1; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="GhgjcsM1"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1734367290;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zWx/z0/7bycu6qAOJH4he8ulyETYX9kiEzi2aLNPf+0=;
	b=GhgjcsM1Aza9bMf/z5P8NDuNta+/E9uY2T39ni5dCktO0xlPQpulRO/esFl+GdWx1szp3t
	Z/1C7LCjNp8UHQubH/cQUu8e4maFM1Cja60N+SF6OFOxfwsk6Hv/g5LXK3f2UjtFbFjyNY
	WCiwZ2+PAmJOXFDuS/22Lo9WDoqUnKd/CydP/jX716dj2gLUiV9S4NpmFx1vo1mG1yxlOx
	dCeeqvhd3GIpnW2qjko9UQX8vDAm+zEJ1omN41Ew7rXZMZC09sQ02ZG5UxdnyhpdHRzd8Z
	xw6Nygx04rPkfrLF6UmNKEHiht7XjT1/Tdupn+I5Siz3tMCuojVf8mqofv9LvQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	=?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [RFC PATCH v2 05/22] selinux: avoid nontransitive comparison
Date: Mon, 16 Dec 2024 17:40:03 +0100
Message-ID: <20241216164055.96267-5-cgoettsche@seltendoof.de>
In-Reply-To: <20241216164055.96267-1-cgoettsche@seltendoof.de>
References: <20241216164055.96267-1-cgoettsche@seltendoof.de>
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

Avoid using nontransitive comparison to prevent unexpected sorting
results due to (well-defined) overflows.
See https://www.qualys.com/2024/01/30/qsort.txt for a related issue in
glibc's qsort(3).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 3ba5506a3fff..eb944582d7a6 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -37,6 +37,8 @@
 #include "mls.h"
 #include "services.h"
 
+#define spaceship_cmp(a, b) (((a) > (b)) - ((a) < (b)))
+
 #ifdef CONFIG_SECURITY_SELINUX_DEBUG
 /* clang-format off */
 static const char *const symtab_name[SYM_NUM] = {
@@ -426,11 +428,11 @@ static int filenametr_cmp(const void *k1, const void *k2)
 	const struct filename_trans_key *ft2 = k2;
 	int v;
 
-	v = ft1->ttype - ft2->ttype;
+	v = spaceship_cmp(ft1->ttype, ft2->ttype);
 	if (v)
 		return v;
 
-	v = ft1->tclass - ft2->tclass;
+	v = spaceship_cmp(ft1->tclass, ft2->tclass);
 	if (v)
 		return v;
 
@@ -461,15 +463,15 @@ static int rangetr_cmp(const void *k1, const void *k2)
 	const struct range_trans *key1 = k1, *key2 = k2;
 	int v;
 
-	v = key1->source_type - key2->source_type;
+	v = spaceship_cmp(key1->source_type, key2->source_type);
 	if (v)
 		return v;
 
-	v = key1->target_type - key2->target_type;
+	v = spaceship_cmp(key1->target_type, key2->target_type);
 	if (v)
 		return v;
 
-	v = key1->target_class - key2->target_class;
+	v = spaceship_cmp(key1->target_class, key2->target_class);
 
 	return v;
 }
@@ -498,15 +500,15 @@ static int role_trans_cmp(const void *k1, const void *k2)
 	const struct role_trans_key *key1 = k1, *key2 = k2;
 	int v;
 
-	v = key1->role - key2->role;
+	v = spaceship_cmp(key1->role, key2->role);
 	if (v)
 		return v;
 
-	v = key1->type - key2->type;
+	v = spaceship_cmp(key1->type, key2->type);
 	if (v)
 		return v;
 
-	return key1->tclass - key2->tclass;
+	return spaceship_cmp(key1->tclass, key2->tclass);
 }
 
 static const struct hashtab_key_params roletr_key_params = {
-- 
2.45.2

