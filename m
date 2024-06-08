Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82641C13D
	for <selinux@vger.kernel.org>; Sat,  8 Jun 2024 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717867360; cv=none; b=Wr885Rupd7LPAZAbtkERSMoxkTxHSQBiZ7/arbWFy7Kg1eo1CKJnublSYovOuSW/0v6CLsv41/d5xysdqSLdxOdSIDj1t73PeV27ainWYdIVI49laUsPzgAdXQeDNzPcquqNZ/7fkGH5WMkNUYPO61flQRyYQhCFX4g1d0R/6FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717867360; c=relaxed/simple;
	bh=aJU8SB0qMl1jM6F6mIYmTHWvqz70C9U2BWdN3As/mxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DwHqNpQEL8TAFyQCZQocFpHZCvIm58wr9CYzJZqqhAhSamA2lxo0g1pHb8VtlA7lZYTCBgohJVaGexUXVaXdkYDpKn1JeAaHgITebpEC+1QKwIhzQ0Hwd6ujz/PL1rpKBJgIuwp9usdy8wJssROJ+I0ZGX8KfjFr+WCSD7Rb3RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=mYduqXEB; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="mYduqXEB"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1717867356;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=yLXzEkVrh+K4Nn4zUbzYDwad7mXW413lk+5HM7Frhl0=;
	b=mYduqXEBZ7J/masx1qIhvi3M1Fx8UdOM3e3jKUPl4wrQEPj/31clmHTCdt8lYFHgYa3lud
	gnpskqidZiCOwIsbA440LzpZYLZmGz/O+FQGBb1RHQgKXVzHzx9pSzIfDYt8X1dZaCHrDf
	2IcQryvg2+Y5VVTAeTS7i0eCMvKWAseQ/IzwyWQqMV/FdAZDzIVM7Qo1Tbw1hwpqEAnLlV
	2miABgMKuGxjCZqURli+HUh3Dfri3n8VC8Zhu0ud5gdX+8wN0Ur/1u8C/iPX+WJVhLLlbM
	eE1Owy03S1XuPFRgpOG261f8qNaM7oq/ADmdZRRg3AVUSMbTXOBnyMXqb+kjog==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] checkpolicy: reject duplicate nodecon statements
Date: Sat,  8 Jun 2024 19:22:33 +0200
Message-ID: <20240608172233.139679-1-cgoettsche@seltendoof.de>
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

Reject multiple nodecon declarations with the same address and netmask.
Avoids mistakes when defining them in different places or using both the
address-with-netmask and CIDR-notation syntax.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 186 +++++++++++++++++-------------------
 1 file changed, 87 insertions(+), 99 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 1d17f73d..4931f23d 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -5238,12 +5238,45 @@ int define_netif_context(void)
 	return 0;
 }
 
+static int insert_ipv4_node(ocontext_t *newc)
+{
+	ocontext_t *c, *l;
+	char addr[INET_ADDRSTRLEN];
+	char mask[INET_ADDRSTRLEN];
+
+	/* Create order of most specific to least retaining
+	   the order specified in the configuration. */
+	for (l = NULL, c = policydbp->ocontexts[OCON_NODE]; c; l = c, c = c->next) {
+		if (newc->u.node.mask == c->u.node.mask &&
+		    newc->u.node.addr == c->u.node.addr) {
+			yyerror2("duplicate entry for network node %s %s",
+				 inet_ntop(AF_INET, &newc->u.node.addr, addr, INET_ADDRSTRLEN) ?: "<invalid>",
+				 inet_ntop(AF_INET, &newc->u.node.mask, mask, INET_ADDRSTRLEN) ?: "<invalid>");
+			context_destroy(&newc->context[0]);
+			free(newc);
+			return -1;
+		}
+
+		if (newc->u.node.mask > c->u.node.mask)
+			break;
+	}
+
+	newc->next = c;
+
+	if (l)
+		l->next = newc;
+	else
+		policydbp->ocontexts[OCON_NODE] = newc;
+
+	return 0;
+}
+
 int define_ipv4_node_context(void)
 {	
 	char *id;
 	int rc = 0;
 	struct in_addr addr, mask;
-	ocontext_t *newc, *c, *l, *head;
+	ocontext_t *newc;
 
 	if (policydbp->target_platform != SEPOL_TARGET_SELINUX) {
 		yyerror("nodecon not supported for target");
@@ -5254,40 +5287,34 @@ int define_ipv4_node_context(void)
 		free(queue_remove(id_queue));
 		free(queue_remove(id_queue));
 		parse_security_context(NULL);
-		goto out;
+		return 0;
 	}
 
 	id = queue_remove(id_queue);
 	if (!id) {
 		yyerror("failed to read ipv4 address");
-		rc = -1;
-		goto out;
+		return -1;
 	}
 
 	rc = inet_pton(AF_INET, id, &addr);
 	if (rc < 1) {
 		yyerror2("failed to parse ipv4 address %s", id);
 		free(id);
-		if (rc == 0)
-			rc = -1;
-		goto out;
+		return -1;
 	}
 	free(id);
 
 	id = queue_remove(id_queue);
 	if (!id) {
 		yyerror("failed to read ipv4 address");
-		rc = -1;
-		goto out;
+		return -1;
 	}
 
 	rc = inet_pton(AF_INET, id, &mask);
 	if (rc < 1) {
 		yyerror2("failed to parse ipv4 mask %s", id);
 		free(id);
-		if (rc == 0)
-			rc = -1;
-		goto out;
+		return -1;
 	}
 
 	free(id);
@@ -5303,8 +5330,7 @@ int define_ipv4_node_context(void)
 	newc = malloc(sizeof(ocontext_t));
 	if (!newc) {
 		yyerror("out of memory");
-		rc = -1;
-		goto out;
+		return -1;
 	}
 
 	memset(newc, 0, sizeof(ocontext_t));
@@ -5316,23 +5342,7 @@ int define_ipv4_node_context(void)
 		return -1;
 	}
 
-	/* Create order of most specific to least retaining
-	   the order specified in the configuration. */
-	head = policydbp->ocontexts[OCON_NODE];
-	for (l = NULL, c = head; c; l = c, c = c->next) {
-		if (newc->u.node.mask > c->u.node.mask)
-			break;
-	}
-
-	newc->next = c;
-
-	if (l)
-		l->next = newc;
-	else
-		policydbp->ocontexts[OCON_NODE] = newc;
-	rc = 0;
-out:
-	return rc;
+	return insert_ipv4_node(newc);
 }
 
 int define_ipv4_cidr_node_context(void)
@@ -5341,7 +5351,7 @@ int define_ipv4_cidr_node_context(void)
 	unsigned long mask_bits;
 	uint32_t mask;
 	struct in_addr addr;
-	ocontext_t *newc, *c, *l, *head;
+	ocontext_t *newc;
 	int rc;
 
 	if (policydbp->target_platform != SEPOL_TARGET_SELINUX) {
@@ -5411,22 +5421,7 @@ int define_ipv4_cidr_node_context(void)
 		return -1;
 	}
 
-	/* Create order of most specific to least retaining
-	   the order specified in the configuration. */
-	head = policydbp->ocontexts[OCON_NODE];
-	for (l = NULL, c = head; c; l = c, c = c->next) {
-		if (newc->u.node.mask > c->u.node.mask)
-			break;
-	}
-
-	newc->next = c;
-
-	if (l)
-		l->next = newc;
-	else
-		policydbp->ocontexts[OCON_NODE] = newc;
-
-	return 0;
+	return insert_ipv4_node(newc);
 }
 
 static int ipv6_is_mask_contiguous(const struct in6_addr *mask)
@@ -5483,12 +5478,45 @@ static void ipv6_cidr_bits_to_mask(unsigned long cidr_bits, struct in6_addr *mas
 	}
 }
 
+static int insert_ipv6_node(ocontext_t *newc)
+{
+	ocontext_t *c, *l;
+	char addr[INET6_ADDRSTRLEN];
+	char mask[INET6_ADDRSTRLEN];
+
+	/* Create order of most specific to least retaining
+	   the order specified in the configuration. */
+	for (l = NULL, c = policydbp->ocontexts[OCON_NODE6]; c; l = c, c = c->next) {
+		if (memcmp(&newc->u.node6.mask, &c->u.node6.mask, 16) == 0 &&
+		    memcmp(&newc->u.node6.addr, &c->u.node6.addr, 16) == 0) {
+			yyerror2("duplicate entry for network node %s %s",
+				 inet_ntop(AF_INET6, &newc->u.node6.addr, addr, INET6_ADDRSTRLEN) ?: "<invalid>",
+				 inet_ntop(AF_INET6, &newc->u.node6.mask, mask, INET6_ADDRSTRLEN) ?: "<invalid>");
+			context_destroy(&newc->context[0]);
+			free(newc);
+			return -1;
+		}
+
+		if (memcmp(&newc->u.node6.mask, &c->u.node6.mask, 16) > 0)
+			break;
+	}
+
+	newc->next = c;
+
+	if (l)
+		l->next = newc;
+	else
+		policydbp->ocontexts[OCON_NODE6] = newc;
+
+	return 0;
+}
+
 int define_ipv6_node_context(void)
 {
 	char *id;
 	int rc = 0;
 	struct in6_addr addr, mask;
-	ocontext_t *newc, *c, *l, *head;
+	ocontext_t *newc;
 
 	if (policydbp->target_platform != SEPOL_TARGET_SELINUX) {
 		yyerror("nodecon not supported for target");
@@ -5499,23 +5527,20 @@ int define_ipv6_node_context(void)
 		free(queue_remove(id_queue));
 		free(queue_remove(id_queue));
 		parse_security_context(NULL);
-		goto out;
+		return 0;
 	}
 
 	id = queue_remove(id_queue);
 	if (!id) {
 		yyerror("failed to read ipv6 address");
-		rc = -1;
-		goto out;
+		return -1;
 	}
 
 	rc = inet_pton(AF_INET6, id, &addr);
 	if (rc < 1) {
 		yyerror2("failed to parse ipv6 address %s", id);
 		free(id);
-		if (rc == 0)
-			rc = -1;
-		goto out;
+		return -1;
 	}
 
 	free(id);
@@ -5523,17 +5548,14 @@ int define_ipv6_node_context(void)
 	id = queue_remove(id_queue);
 	if (!id) {
 		yyerror("failed to read ipv6 address");
-		rc = -1;
-		goto out;
+		return -1;
 	}
 
 	rc = inet_pton(AF_INET6, id, &mask);
 	if (rc < 1) {
 		yyerror2("failed to parse ipv6 mask %s", id);
 		free(id);
-		if (rc == 0)
-			rc = -1;
-		goto out;
+		return -1;
 	}
 
 	free(id);
@@ -5549,8 +5571,7 @@ int define_ipv6_node_context(void)
 	newc = malloc(sizeof(ocontext_t));
 	if (!newc) {
 		yyerror("out of memory");
-		rc = -1;
-		goto out;
+		return -1;
 	}
 
 	memset(newc, 0, sizeof(ocontext_t));
@@ -5559,28 +5580,10 @@ int define_ipv6_node_context(void)
 
 	if (parse_security_context(&newc->context[0])) {
 		free(newc);
-		rc = -1;
-		goto out;
-	}
-
-	/* Create order of most specific to least retaining
-	   the order specified in the configuration. */
-	head = policydbp->ocontexts[OCON_NODE6];
-	for (l = NULL, c = head; c; l = c, c = c->next) {
-		if (memcmp(&newc->u.node6.mask, &c->u.node6.mask, 16) > 0)
-			break;
+		return -1;
 	}
 
-	newc->next = c;
-
-	if (l)
-		l->next = newc;
-	else
-		policydbp->ocontexts[OCON_NODE6] = newc;
-
-	rc = 0;
-      out:
-	return rc;
+	return insert_ipv6_node(newc);
 }
 
 int define_ipv6_cidr_node_context(void)
@@ -5589,7 +5592,7 @@ int define_ipv6_cidr_node_context(void)
 	unsigned long mask_bits;
 	int rc;
 	struct in6_addr addr, mask;
-	ocontext_t *newc, *c, *l, *head;
+	ocontext_t *newc;
 
 	if (policydbp->target_platform != SEPOL_TARGET_SELINUX) {
 		yyerror("nodecon not supported for target");
@@ -5658,22 +5661,7 @@ int define_ipv6_cidr_node_context(void)
 		return -1;
 	}
 
-	/* Create order of most specific to least retaining
-	   the order specified in the configuration. */
-	head = policydbp->ocontexts[OCON_NODE6];
-	for (l = NULL, c = head; c; l = c, c = c->next) {
-		if (memcmp(&newc->u.node6.mask, &c->u.node6.mask, 16) > 0)
-			break;
-	}
-
-	newc->next = c;
-
-	if (l)
-		l->next = newc;
-	else
-		policydbp->ocontexts[OCON_NODE6] = newc;
-
-	return 0;
+	return insert_ipv6_node(newc);
 }
 
 int define_fs_use(int behavior)
-- 
2.45.1

