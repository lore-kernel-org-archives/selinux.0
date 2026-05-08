Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B985733A029
	for <selinux@vger.kernel.org>; Fri,  8 May 2026 12:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778242438; cv=none; b=mHqh5Nf4jl6FuQ472lVFOAkcVkt3VSdWH9DbO0PVrhBOcJDfUCv8HoinWB3/8EdJ+OLJdt2ivkGjVDhLQIzpIAb2g/DON2Akxt3H6jWLT5TzRJ4bijQjbPfZFFYQNiD92ZIHvhG8nUlwdIgvX0ryCEejJhFpNCJp4fRmA5FUruE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778242438; c=relaxed/simple;
	bh=tG9okbunzSEmi+Og9Q3a5a36TL2Qjp2a4WJtEGrleFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwW3zOY2lwjttchCMU/PwS+t2T5NCmeBW7Twod6YLmfnGU2UBiVcS6oSsmWaiBEyDfu1es/ZZpxyU55tdT3uhHUSLBVNrykwEnczWMAhOaDxD0xlz10cZbC7oZG8KhPVchS348N3/ytFa8znRnJXXOrB0StadKZ2mr68kNBmUmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=l2cHcMPf; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="l2cHcMPf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wqKfWGD1FAS29MI8BOR1Oau3xdGFDQapQdXdWJlCyio=; b=l2cHcMPfq7rxttnDVHssSlzoaJ
	gX5ArHbVxhdaa9KoVTTlejUbKzKk/92OFK4w2l6SkjONNoBg7UYNfIU/uuKag6sIHu2lQSXMzoMQe
	qu9RtGIWkR5Vc0HX1VJtUMyQzO3JoJAgsrkw/OQdd2q1Kqu5l1uu980gvJZk796TYwBQ2dro4R5BL
	McrKLeeu6a+bBvPA6fHtpbP/EpRTxr85zwrn597mnoRR739CME+r6lJyDzlF8IiSpPeUH4WbeO4dq
	KSlsRcZ0qDlhAJzdeWIiFIOtn4PlWZiYkDeqkVgoUH27/lfY6PFpJTFViZ1evB3Opicc5X04FTru0
	85Vmz0eQ==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11426 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wLK5b-0000000BmhC-1WBr;
	Fri, 08 May 2026 15:13:54 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH 4/4] checkpolicy: remove unneeded malloc() casts
Date: Fri,  8 May 2026 15:13:27 +0300
Message-ID: <20260508121327.91410-5-kalevi@kolttonen.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508121327.91410-1-kalevi@kolttonen.fi>
References: <20260508121327.91410-1-kalevi@kolttonen.fi>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud35.hostingpalvelu.fi
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kolttonen.fi
X-Get-Message-Sender-Via: cloud35.hostingpalvelu.fi: authenticated_id: kalevi@kolttonen.fi
X-Authenticated-Sender: cloud35.hostingpalvelu.fi: kalevi@kolttonen.fi
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
---
 checkpolicy/policy_define.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 755a8428..0a553a1f 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -786,7 +786,7 @@ int define_sens(void)
 		yyerror2("sensitivity identifier %s may not contain periods", id);
 		goto bad;
 	}
-	level = (mls_level_t *) malloc(sizeof(mls_level_t));
+	level = malloc(sizeof(mls_level_t));
 	if (!level) {
 		yyerror("out of memory");
 		goto bad;
@@ -795,7 +795,7 @@ int define_sens(void)
 	level->sens = 0;	/* actual value set in define_dominance */
 	ebitmap_init(&level->cat);	/* actual value set in define_level */
 
-	datum = (level_datum_t *) malloc(sizeof(level_datum_t));
+	datum = malloc(sizeof(level_datum_t));
 	if (!datum) {
 		yyerror("out of memory");
 		goto bad;
@@ -839,7 +839,7 @@ int define_sens(void)
 			free(id);
 			return -1;
 		}
-		aliasdatum = (level_datum_t *) malloc(sizeof(level_datum_t));
+		aliasdatum = malloc(sizeof(level_datum_t));
 		if (!aliasdatum) {
 			yyerror("out of memory");
 			free(id);
@@ -976,7 +976,7 @@ int define_category(void)
 		yyerror2("category identifier %s may not contain periods", id);
 		goto bad;
 	}
-	datum = (cat_datum_t *) malloc(sizeof(cat_datum_t));
+	datum = malloc(sizeof(cat_datum_t));
 	if (!datum) {
 		yyerror("out of memory");
 		goto bad;
@@ -1019,7 +1019,7 @@ int define_category(void)
 			free(id);
 			return -1;
 		}
-		aliasdatum = (cat_datum_t *) malloc(sizeof(cat_datum_t));
+		aliasdatum = malloc(sizeof(cat_datum_t));
 		if (!aliasdatum) {
 			yyerror("out of memory");
 			free(id);
@@ -1091,7 +1091,7 @@ static int clone_level(hashtab_key_t key __attribute__ ((unused)), hashtab_datum
 			levdatum->notdefined = FALSE;
 			return 0;
 		}
-		newlevel = (mls_level_t *) malloc(sizeof(mls_level_t));
+		newlevel = malloc(sizeof(mls_level_t));
 		if (!newlevel)
 			return -1;
 		if (mls_level_cpy(newlevel, level)) {
@@ -2167,7 +2167,7 @@ static int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
 	unsigned int i;
 	int add = 1, ret;
 
-	avrule = (avrule_t *) malloc(sizeof(avrule_t));
+	avrule = malloc(sizeof(avrule_t));
 	if (!avrule) {
 		yyerror("out of memory");
 		goto out;
@@ -2231,8 +2231,7 @@ static int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
 	perms = NULL;
 	id = queue_head(id_queue);
 	ebitmap_for_each_positive_bit(&tclasses, node, i) {
-		cur_perms =
-		    (class_perm_node_t *) malloc(sizeof(class_perm_node_t));
+		cur_perms = malloc(sizeof(class_perm_node_t));
 		if (!cur_perms) {
 			yyerror("out of memory");
 			goto out2;
@@ -2779,7 +2778,7 @@ static int define_te_avtab_helper(int which, avrule_t ** rule)
 
 	ebitmap_init(&tclasses);
 
-	avrule = (avrule_t *) malloc(sizeof(avrule_t));
+	avrule = malloc(sizeof(avrule_t));
 	if (!avrule) {
 		yyerror("memory error");
 		ret = -1;
@@ -2848,8 +2847,7 @@ static int define_te_avtab_helper(int which, avrule_t ** rule)
 
 	perms = NULL;
 	ebitmap_for_each_positive_bit(&tclasses, node, i) {
-		cur_perms =
-		    (class_perm_node_t *) malloc(sizeof(class_perm_node_t));
+		cur_perms = malloc(sizeof(class_perm_node_t));
 		if (!cur_perms) {
 			yyerror("out of memory");
 			ret = -1;
@@ -4390,7 +4388,7 @@ static int mls_semantic_cats_merge(mls_semantic_cat_t ** dst,
 	mls_semantic_cat_t *new;
 
 	while (src) {
-		new = (mls_semantic_cat_t *) malloc(sizeof(mls_semantic_cat_t));
+		new = malloc(sizeof(mls_semantic_cat_t));
 		if (!new)
 			return -1;
 
@@ -4467,7 +4465,7 @@ static int parse_semantic_categories(char *id, level_datum_t * levdatum __attrib
 		range_start = range_end = cdatum->s.value;
 	}
 
-	newcat = (mls_semantic_cat_t *) malloc(sizeof(mls_semantic_cat_t));
+	newcat = malloc(sizeof(mls_semantic_cat_t));
 	if (!newcat) {
 		yyerror("out of memory");
 		return -1;
@@ -4859,7 +4857,7 @@ int define_fs_context(unsigned int major, unsigned int minor)
 		return -1;
 	}
 
-	newc->u.name = (char *)malloc(6);
+	newc->u.name = malloc(6);
 	if (!newc->u.name) {
 		yyerror("out of memory");
 		free(newc);
-- 
2.54.0

