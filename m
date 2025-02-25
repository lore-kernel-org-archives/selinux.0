Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA42A26981F
	for <selinux@vger.kernel.org>; Tue, 25 Feb 2025 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494012; cv=none; b=JFDnKtFE+RwcbhIqYJRQQPq0xVxFC5ftK2dPyPyVvDwLHAMzWfqp33V1C8p1DRQMcoGR/H+ihzIhz6mzY+yDWVHwoZdAXRVuk9vS2pMYV2T1VyEQDmD0q0WcmExoX4Uhi9tff7HjWqGUe3dPnmSJy2qAfOIg0bRaIClrWMSkpkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494012; c=relaxed/simple;
	bh=2xcXVcUoDYMp7Ndhn3kTsu0e/mQaCRuDERA7e8hYAkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=urwXWhfXIMfa71mWbQ3ehdEdsLjjE/OyEXVOsjp3n7IXjdr4jrs/CZ5qXKcHVRh8b5pJzsIfYRVip/817nue0f2TahvB0eCMg/4L/dW8Pwt7R0gG4nRLJxPTO4XEJkk+K95jCMkyAxqqFxBPLFwR0v9YUR5kkb+C8m+Gbo97zr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=d/cqonnz; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="d/cqonnz"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740494000;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QRojapvmBR5COPIkXxQy+PwjhG7/LlwGYyzCTKSRQto=;
	b=d/cqonnz8oVEfyDTdGvjPymV5Xhj92JmcS6GdFnXtoCIo84dI7Qwyn8UXhGkrlTuISk8ef
	B3ic+hhaP3SbdV1qXpnMAYkuhNqxmdbeEHn8ylzhHCjhB3KG0SE4ISf7kg+v0JtrFIqodw
	P0qag/pQkeRsDAs9OOsw51KwjJwTutFDinY5E/M4/an1Hq6CdIh+zQuFSBvEHdy66gaHV8
	bP7G4bQcj2oUV5x3bQLReWrAyhsaKxbD1Mu316EMihwnPZXYTHFM/9P8Yc/2Vomu3T8z8Y
	wG2OddC4l+Df6BS/Le0RkXv6K6tElsiYfJYa/pWG8tVEcCluucopS5r6ShFkFQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 3/3] checkpolicy: perform cleanup on error in define_filename_trans()
Date: Tue, 25 Feb 2025 15:33:11 +0100
Message-ID: <20250225143312.47755-2-cgoettsche@seltendoof.de>
In-Reply-To: <20250225143312.47755-1-cgoettsche@seltendoof.de>
References: <20250225143312.47755-1-cgoettsche@seltendoof.de>
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

Cleanup the local resources in define_filename_trans() in error paths.

Reported-by: oss-fuzz (issue 398879931)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 18654d00..b3cfc64d 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -3182,10 +3182,10 @@ static int set_roles(role_set_t * set, char *id)
 int define_role_trans(int class_specified)
 {
 	char *id;
-	role_datum_t *role;
+	const role_datum_t *role;
 	role_set_t roles;
 	type_set_t types;
-	class_datum_t *cladatum;
+	const class_datum_t *cladatum;
 	ebitmap_t e_types, e_roles, e_classes;
 	ebitmap_node_t *tnode, *rnode, *cnode;
 	struct role_trans *tr = NULL;
@@ -3214,29 +3214,29 @@ int define_role_trans(int class_specified)
 
 	while ((id = queue_remove(id_queue))) {
 		if (set_roles(&roles, id))
-			return -1;
+			goto bad;
 	}
 	add = 1;
 	while ((id = queue_remove(id_queue))) {
 		if (set_types(&types, id, &add, 0))
-			return -1;
+			goto bad;
 	}
 
 	if (class_specified) {
 		if (read_classes(&e_classes))
-			return -1;
+			goto bad;
 	} else {
 		cladatum = hashtab_search(policydbp->p_classes.table,
 					  "process");
 		if (!cladatum) {
 			yyerror2("could not find process class for "
 				 "legacy role_transition statement");
-			return -1;
+			goto bad;
 		}
 
 		if (ebitmap_set_bit(&e_classes, cladatum->s.value - 1, TRUE)) {
 			yyerror("out of memory");
-			return -1;
+			goto bad;
 		}
 	}
 
@@ -3292,7 +3292,7 @@ int define_role_trans(int class_specified)
 				tr = malloc(sizeof(struct role_trans));
 				if (!tr) {
 					yyerror("out of memory");
-					return -1;
+					goto bad;
 				}
 				memset(tr, 0, sizeof(struct role_trans));
 				tr->role = i + 1;
@@ -3308,7 +3308,7 @@ int define_role_trans(int class_specified)
 	rule = malloc(sizeof(struct role_trans_rule));
 	if (!rule) {
 		yyerror("out of memory");
-		return -1;
+		goto bad;
 	}
 	memset(rule, 0, sizeof(struct role_trans_rule));
 	rule->roles = roles;
@@ -3324,6 +3324,11 @@ int define_role_trans(int class_specified)
 	return 0;
 
       bad:
+	role_set_destroy(&roles);
+	type_set_destroy(&types);
+	ebitmap_destroy(&e_roles);
+	ebitmap_destroy(&e_types);
+	ebitmap_destroy(&e_classes);
 	return -1;
 }
 
-- 
2.47.2

