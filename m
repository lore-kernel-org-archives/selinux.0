Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56E822FDE9
	for <selinux@vger.kernel.org>; Wed, 15 Jan 2025 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736946821; cv=none; b=CKLdWZH3l7jlwICpacRda87H0kY7RnubnUSyJb3eldIpMHg2YJrjaQphEm5UEjWgsLGS0MO8/G8EQ0rUW/My5WFPkKDiOGsi0w3oHOSrkcmxLwwz3TY8s1vMkiUDcX+mSZJ6wSb+h8TJKsSX2MIsXqoB2rAqF6589bI2vziEW94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736946821; c=relaxed/simple;
	bh=msUnJofL5TIYQWzWqHulrkf9ajd4L74ldEN9U2j7CfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDn2xTPlMsr9XAITai0RE2HGW748LSgyq6/2xFOARlLKcy9/FPBRDW9pNyPeUhvscJQ6Mz/2cbd3Y3jTtWKhzYuK2SLf7+bY3SSeDIm1g1XZ/ErEOjRBVvXVySaA75QbtOVdVg4y/ZdjnKWyVerZcKtG3fD+IqBlKiBoktxM7f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=B2z4Mo22; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="B2z4Mo22"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1736946815;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OiyOVG3+LJozwyZY6mYExEqeEsI9QvK6gcZnqAPKZNs=;
	b=B2z4Mo22bh+ym9xfEqakLTIx1lqpd8PSz9DG/Y/K9A5FhN43bdt8O90CTXhhh3ZrIfZeNY
	LOQTuc5iOLTWiu94p4xkS9exzVaafIKxRczGZ4fbI3Kv7B5PsHTVlq14rcBGSzb98qQqR1
	d140bWhG8IUOn8sszO5x1zFHtgzlhMAatIgnrj6aZJXmIsxx+bcVWjs/goQxgLZ2smTQpx
	lYtFA+NReOWmyepNE+XbNhTgo+t6KreUitJUL5ghYbpdGb/fpHxz4YXvTdic+0c1fOdlBx
	VGvDrLQmcWkd1ZOQAa/PR06A/7n4o/PwdRVdF5O6PCfWJadyVS2bZMsnlxrefw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 4/5] checkpolicy: do not consume unmatched identifiers
Date: Wed, 15 Jan 2025 14:13:27 +0100
Message-ID: <20250115131329.132477-3-cgoettsche@seltendoof.de>
In-Reply-To: <20250115131329.132477-1-cgoettsche@seltendoof.de>
References: <20250115131329.132477-1-cgoettsche@seltendoof.de>
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

Avoid consuming identifiers during pass 1 in functions that do not parse
them during pass 2. This currently works due to the subsequent
parse_security_context(NULL) call.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 275ef5fe..a056be67 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -4850,7 +4850,6 @@ int define_fs_context(unsigned int major, unsigned int minor)
 int define_pirq_context(unsigned int pirq)
 {
 	ocontext_t *newc, *c, *l, *head;
-	char *id;
 
 	if (policydbp->target_platform != SEPOL_TARGET_XEN) {
 		yyerror("pirqcon not supported for target");
@@ -4858,8 +4857,6 @@ int define_pirq_context(unsigned int pirq)
 	}
 
 	if (pass == 1) {
-		id = (char *) queue_remove(id_queue);
-		free(id);
 		parse_security_context(NULL);
 		return 0;
 	}
@@ -4904,7 +4901,6 @@ bad:
 int define_iomem_context(uint64_t low, uint64_t high)
 {
 	ocontext_t *newc, *c, *l, *head;
-	char *id;
 
 	if (policydbp->target_platform != SEPOL_TARGET_XEN) {
 		yyerror("iomemcon not supported for target");
@@ -4912,8 +4908,6 @@ int define_iomem_context(uint64_t low, uint64_t high)
 	}
 
 	if (pass == 1) {
-		id = (char *)queue_remove(id_queue);
-		free(id);
 		parse_security_context(NULL);
 		return 0;
 	}
@@ -4968,7 +4962,6 @@ bad:
 int define_ioport_context(unsigned long low, unsigned long high)
 {
 	ocontext_t *newc, *c, *l, *head;
-	char *id;
 
 	if (policydbp->target_platform != SEPOL_TARGET_XEN) {
 		yyerror("ioportcon not supported for target");
@@ -4976,8 +4969,6 @@ int define_ioport_context(unsigned long low, unsigned long high)
 	}
 
 	if (pass == 1) {
-		id = (char *)queue_remove(id_queue);
-		free(id);
 		parse_security_context(NULL);
 		return 0;
 	}
@@ -5032,7 +5023,6 @@ bad:
 int define_pcidevice_context(unsigned long device)
 {
 	ocontext_t *newc, *c, *l, *head;
-	char *id;
 
 	if (policydbp->target_platform != SEPOL_TARGET_XEN) {
 		yyerror("pcidevicecon not supported for target");
@@ -5040,8 +5030,6 @@ int define_pcidevice_context(unsigned long device)
 	}
 
 	if (pass == 1) {
-		id = (char *) queue_remove(id_queue);
-		free(id);
 		parse_security_context(NULL);
 		return 0;
 	}
@@ -5845,7 +5833,6 @@ int define_ipv6_cidr_node_context(void)
 	}
 
 	if (pass == 1) {
-		free(queue_remove(id_queue));
 		free(queue_remove(id_queue));
 		parse_security_context(NULL);
 		return 0;
-- 
2.47.1

