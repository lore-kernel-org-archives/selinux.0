Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0712AEFB
	for <selinux@vger.kernel.org>; Sat, 22 Feb 2025 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740245656; cv=none; b=s1Y23WygsiL0akD+wqd3RmuYn8l2BYEPiNfsdL96JBbPK4HprLIjV17WimhBYknqqrC2pIJQqqIf7+cFo3Ofo5Yzy+Nj4lomugsIzE5wWsmVPLPw2mtODfvekneXi8rWCwzStdH/cDVVoUR8JMrMiCTFLznz7hLj6xXa2tONbhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740245656; c=relaxed/simple;
	bh=fXuwtselYbnFmkfFBfDkEuErHtVJkcI66PaUayMh47c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QsZj/NidQrVznadjvNFrM4GDl20D0qipoJsJaMiI7KvbE51fvBpc6HkQkp1IP9fcghunIY+1KyBefIZSdA8mJE4o6xEoiqtsVrLas+aCpDWnZkIe+v7mL2aZunuYLc2UTwU+7hel47crcb2U9KzAxt80rUsdCe5s2Rrm3Gvixyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=MgLNLVEn; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="MgLNLVEn"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740245194;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=OUwDezd1XS672hPuuj2ojpcIf4NlacAIG84GUpfrvhU=;
	b=MgLNLVEnQU5iZv10deofYGPCtr05tlzUjGMvWpJOQBYAIBit2yxo++3EOF8CQO+mFKQ4Y2
	1bjE5RQCqP/cOms24gYfYwTGJYYUGbN+ipW1ocmxUArFtLcOsVlgj+SSTAqMDNtLCKSSBz
	Obuz+ftcPBK9Bzsd5Wg9qnw255wxA1actwbPTxOuwMuTqjBKqQdO1NquDr1WpzD/nN0x7E
	Yu+hDjTG4hDCTKpmj8jz0eJtHKL3LvwwIpnI5cD1zWJVeOs1zd3bCzwgd5EDt3tjuNdg/a
	hwCQdEvCjf2A6NB95TQE8/scNnVz7auXfFHoN0gq1hnmoJSETCqJc4LsASNGDw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] checkpolicy: rework cleanup in define_te_avtab_xperms_helper()
Date: Sat, 22 Feb 2025 18:26:30 +0100
Message-ID: <20250222172631.18683-1-cgoettsche@seltendoof.de>
Reply-To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Clean up the local avrule on error, since its ownership is not
transferred. Also clean up the local ebitmap on error.

Reported-by: oss-fuzz (issue 398356438)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index f19e9f6d..06068556 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1610,7 +1610,8 @@ struct val_to_name {
 
 /* Adds a type, given by its textual name, to a typeset.  If *add is
    0, then add the type to the negative set; otherwise if *add is 1
-   then add it to the positive side. */
+   then add it to the positive side.
+   The identifier `id` is always consumed. */
 static int set_types(type_set_t * set, char *id, int *add, char starallowed)
 {
 	type_datum_t *t;
@@ -2117,18 +2118,17 @@ static int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
 {
 	char *id;
 	class_perm_node_t *perms, *tail = NULL, *cur_perms = NULL;
-	class_datum_t *cladatum;
-	perm_datum_t *perdatum = NULL;
+	const class_datum_t *cladatum;
+	const perm_datum_t *perdatum;
 	ebitmap_t tclasses;
 	ebitmap_node_t *node;
 	avrule_t *avrule;
 	unsigned int i;
-	int add = 1, ret = 0;
+	int add = 1, ret;
 
 	avrule = (avrule_t *) malloc(sizeof(avrule_t));
 	if (!avrule) {
 		yyerror("out of memory");
-		ret = -1;
 		goto out;
 	}
 	avrule_init(avrule);
@@ -2139,14 +2139,13 @@ static int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
 	avrule->xperms = NULL;
 	if (!avrule->source_filename) {
 		yyerror("out of memory");
-		return -1;
+		goto out;
 	}
 
 	while ((id = queue_remove(id_queue))) {
 		if (set_types
 		    (&avrule->stypes, id, &add,
 		     which == AVRULE_XPERMS_NEVERALLOW ? 1 : 0)) {
-			ret = -1;
 			goto out;
 		}
 	}
@@ -2156,13 +2155,11 @@ static int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
 			free(id);
 			if (add == 0 && which != AVRULE_XPERMS_NEVERALLOW) {
 				yyerror("-self is only supported in neverallow and neverallowxperm rules");
-				ret = -1;
 				goto out;
 			}
 			avrule->flags |= (add ? RULE_SELF : RULE_NOTSELF);
 			if ((avrule->flags & RULE_SELF) && (avrule->flags & RULE_NOTSELF)) {
 				yyerror("self and -self are mutual exclusive");
-				ret = -1;
 				goto out;
 			}
 			continue;
@@ -2170,7 +2167,6 @@ static int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
 		if (set_types
 		    (&avrule->ttypes, id, &add,
 		     which == AVRULE_XPERMS_NEVERALLOW ? 1 : 0)) {
-			ret = -1;
 			goto out;
 		}
 	}
@@ -2178,7 +2174,6 @@ static int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
 	if ((avrule->ttypes.flags & TYPE_COMP)) {
 		if (avrule->flags & RULE_NOTSELF) {
 			yyerror("-self is not supported in complements");
-			ret = -1;
 			goto out;
 		}
 		if (avrule->flags & RULE_SELF) {
@@ -2190,7 +2185,7 @@ static int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
 	ebitmap_init(&tclasses);
 	ret = read_classes(&tclasses);
 	if (ret)
-		goto out;
+		goto out2;
 
 	perms = NULL;
 	id = queue_head(id_queue);
@@ -2199,8 +2194,7 @@ static int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
 		    (class_perm_node_t *) malloc(sizeof(class_perm_node_t));
 		if (!cur_perms) {
 			yyerror("out of memory");
-			ret = -1;
-			goto out;
+			goto out2;
 		}
 		class_perm_node_init(cur_perms);
 		cur_perms->tclass = i + 1;
@@ -2238,9 +2232,14 @@ static int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
 
 	avrule->perms = perms;
 	*rule = avrule;
+	return 0;
 
+out2:
+	ebitmap_destroy(&tclasses);
 out:
-	return ret;
+	avrule_destroy(avrule);
+	free(avrule);
+	return -1;
 }
 
 /* index of the u32 containing the permission */
-- 
2.47.2

