Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67118482FF;
	Sun, 11 May 2025 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746985154; cv=none; b=mI6K1Yd/zUc3N1Rbs50K7PJVhAUtod4OwCJKGOZtvToCuojVZqpsrJigvvc+OYzlvBU0f3d2JWyeitRg3/d8iOqAhtyNbPLPeTY7rqC73HSO0mTxpGQpLqwhGn4yidsfS7hHbsssnVUlW0bavUK+XulKQku4nQt4KERsxrBvsFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746985154; c=relaxed/simple;
	bh=rEjUtfu7K6jhAd6mynsfwhXtI77Hs9LzZroBcH2KefM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SIRXSoyocJzgQYMN8cOR0teXsq5xjA6sh/k7q4emphchTpcFSQNF9fTFxWBWtiytLnD9/RzheFKbCCLyb6JZX1eZj9Uw4hiSxtmqLpY3T6eA4eRilz0QkKSxMHOzPZXJlwugDCd5AXWb0f4YiSQgSIktRKtMVHR8PLzgEEc+sX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=WjHjIAGb; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="WjHjIAGb"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1746984661;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=mkVC4MfGufb30zICByRypu/2WLJbw98VLc1Myk8zgOI=;
	b=WjHjIAGb/FDY3owDSYsAvQyvgc8Vu+cEHGtZ7o5BisuzVe++BLTcETpQ7UyoGuljnVT826
	jYgdipP0XJOiivDr+wsT4mefYvQSFvjvbszC7gR13LcNwNJXdCs5J/BAqAEcu2b5lNbiIx
	UvYmNGN3mZY+HKF5ys185C0++8vQPEzcNQBr6aOwkAqNPYltTsVFPMhOi5M5EMEndZNWfP
	LJfnRYZ8nLFarB5TJbxu8ZHYdACTdHjXhNdJrICTnTblS9vBtNEWD4WjZOcdeeaiTDuKS6
	KkEliv3MefxmLcGSuF6O7vF9tlClH8+rOQP48r2IBzO9K8/fWNoUsjjMlQ97qQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/14] selinux: avoid nontransitive comparison
Date: Sun, 11 May 2025 19:30:01 +0200
Message-ID: <20250511173055.406906-1-cgoettsche@seltendoof.de>
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
v3: rename macro to cmp_int()
---
 security/selinux/ss/policydb.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 9ea971943713..dc701a7f8652 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -37,6 +37,8 @@
 #include "mls.h"
 #include "services.h"
 
+#define cmp_int(a, b) (((a) > (b)) - ((a) < (b)))
+
 #ifdef CONFIG_SECURITY_SELINUX_DEBUG
 /* clang-format off */
 static const char *const symtab_name[SYM_NUM] = {
@@ -424,11 +426,11 @@ static int filenametr_cmp(const void *k1, const void *k2)
 	const struct filename_trans_key *ft2 = k2;
 	int v;
 
-	v = ft1->ttype - ft2->ttype;
+	v = cmp_int(ft1->ttype, ft2->ttype);
 	if (v)
 		return v;
 
-	v = ft1->tclass - ft2->tclass;
+	v = cmp_int(ft1->tclass, ft2->tclass);
 	if (v)
 		return v;
 
@@ -459,15 +461,15 @@ static int rangetr_cmp(const void *k1, const void *k2)
 	const struct range_trans *key1 = k1, *key2 = k2;
 	int v;
 
-	v = key1->source_type - key2->source_type;
+	v = cmp_int(key1->source_type, key2->source_type);
 	if (v)
 		return v;
 
-	v = key1->target_type - key2->target_type;
+	v = cmp_int(key1->target_type, key2->target_type);
 	if (v)
 		return v;
 
-	v = key1->target_class - key2->target_class;
+	v = cmp_int(key1->target_class, key2->target_class);
 
 	return v;
 }
@@ -496,15 +498,15 @@ static int role_trans_cmp(const void *k1, const void *k2)
 	const struct role_trans_key *key1 = k1, *key2 = k2;
 	int v;
 
-	v = key1->role - key2->role;
+	v = cmp_int(key1->role, key2->role);
 	if (v)
 		return v;
 
-	v = key1->type - key2->type;
+	v = cmp_int(key1->type, key2->type);
 	if (v)
 		return v;
 
-	return key1->tclass - key2->tclass;
+	return cmp_int(key1->tclass, key2->tclass);
 }
 
 static const struct hashtab_key_params roletr_key_params = {
-- 
2.49.0

