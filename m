Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009F31D173F;
	Fri, 15 Nov 2024 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677837; cv=none; b=uL/Wiu6bAB7PG0qyLMv/B7egR+kjSVAkVn6Z9nOBxD//3Hqz74v3/MwAzSLhodyn1h3EWn9r3J2euj9XykcYPte3ewJ5iaOyfYjlsbarjdxkkQNrBq8VT4cbJ0hr8xBtoveLZFyOdZ7mTX9N4g5dNIimQYHrXcnfOwVd/CrkVCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677837; c=relaxed/simple;
	bh=7XXYAtsMXEfxIhaH/Dt1LjvYjV6jfDWQQLXzod/2i2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDaAvERhe4q1qzMdrFn1ODYWX3uh9fdQsJ6OSZWYCBvgc7cfT44U7mNVC1FljWRXWb2VdAK96adSLKqNIDxl0i7V96vxWr25BTZ+MgHYi1g3JIliuUycjrEtjEP1K1bu6O/veC61+sNXJwM49b8FsRjwEK5Q/7eaGc68MSYwyP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=CaL4uNHy; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="CaL4uNHy"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731677834;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t91YLOiLlnw8j4WKtcHLjtKkdLtMm6a5cmeHeyCLZ2k=;
	b=CaL4uNHyFBwbpmSwKsuNxXTgJCxopAztuvTwFeIoMC9NbktxsVEvtn4slr3FuhAhF2fptt
	Zb9WgvUIo3R7Ipot9wIEhoZ2oKs1P2oG+ryRsG0CCJXgfATiudWp9+LfDliiAv+cwhLh8x
	OTRQo20IQoMnfOrhR9yanEH/xqpcSoRY9OxRw9lsL3QI9BHuQcoTHwUMjFcRQgF75ZXMn+
	5pUVsI290A/XzhqBcAAnErjD+iKOak11qEe/kF7X5zew7/aMpuXy+fMkFeC/F1k0zqyZ4S
	KT/2L8wo1s26fnoIVBBPz/GnYIF5Ok5H4OuB4w5B0z4BSQUphxtv2IA+o5aAVw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 17/22] selinux: reorder policydb_index()
Date: Fri, 15 Nov 2024 14:35:36 +0100
Message-ID: <20241115133619.114393-17-cgoettsche@seltendoof.de>
In-Reply-To: <20241115133619.114393-1-cgoettsche@seltendoof.de>
References: <20241115133619.114393-1-cgoettsche@seltendoof.de>
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

Index as soon as possible to enable isvalid() checks to fail on gaps.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 9b2eae70e2dc..2fe9a68b16f0 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -723,7 +723,6 @@ static int policydb_index(struct policydb *p)
 	pr_debug("SELinux:  %d classes, %d rules\n", p->p_classes.nprim,
 		 p->te_avtab.nel);
 
-	avtab_hash_eval(&p->te_avtab, "rules");
 	symtab_hash_eval(p->symtab);
 
 	p->class_val_to_struct = kcalloc(p->p_classes.nprim,
@@ -2786,6 +2785,10 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 		p->symtab[i].nprim = nprim;
 	}
 
+	rc = policydb_index(p);
+	if (rc)
+		goto bad;
+
 	rc = -EINVAL;
 	p->process_class = string_to_security_class(p, "process");
 	if (!p->process_class) {
@@ -2797,6 +2800,8 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 	if (rc)
 		goto bad;
 
+	avtab_hash_eval(&p->te_avtab, "rules");
+
 	if (p->policyvers >= POLICYDB_VERSION_BOOL) {
 		rc = cond_read_list(p, fp);
 		if (rc)
@@ -2893,10 +2898,6 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 	if (rc)
 		goto bad;
 
-	rc = policydb_index(p);
-	if (rc)
-		goto bad;
-
 	rc = -EINVAL;
 	perm = string_to_av_perm(p, p->process_class, "transition");
 	if (!perm) {
-- 
2.45.2

