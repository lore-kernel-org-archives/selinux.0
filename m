Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B6520ADD8;
	Mon, 16 Dec 2024 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367317; cv=none; b=UKECVld3H3wmTNjlga+noICHgdeGioRb9SUobNuXz8o7TNQ9VPQTiUfZWa2EJHuvo37IfpFFX4ipKl1VwlAU/R2UisKAG42vnj7XnURFQ3OeTBmpjyPXkbwMOoAwbxlfwBC41wkX3b85uboHtmfQZzCe3ISBdE5Nl8lM9sGt48U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367317; c=relaxed/simple;
	bh=yTbCf09fyxUPtWhrZYQBY5+/riaOyrc5bEks+cKS2Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tUwjmjtCL4vJDEFjrWM2Q0NAwYECbP5TiUlPn1gSI5goCKvgwkUdC6Wj5dPY2xgUuElGmvnl9YVHGFwF1iroEH3egsck/NNpLE7VVSravi6TSQCLfwrUqdmq1hmXbl/kVO8hdwulmamURmDWsgkkI0axNUyU+OLcTqCcvJ088qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=JWnjM7G3; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="JWnjM7G3"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1734367314;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PHrzWwecyh4Bz6iGzCHjGxxQ9bM9clawGUiGk+/LDa8=;
	b=JWnjM7G37z9x+O5LKNqkp38sADnvf/nyb4QGy4jsEii9JTyVYA4Ix/WvUilzk9ES8MyNOs
	ysmCrr0606oHdeaouzF/FgMTRFZpbeDYrdTdKvNtp/rDi4oSPbelejxs2PMRrhN33YFoxf
	oqMD2At7RELT3Q09Tzru4MyA7RJghNwAwANTXH2FbTk9YrLFeIDIQMpGCARuNdTUWg27AM
	SSmDsgTjN5pV1MNlIMIqJHANrp7u+jBxW2Z8YLdoCVTLY1XZX+y3oqLxwshUC9xMPFTwgR
	sJo52bRiWPO/IxQIckXW4RnLDOfMNMZVcPQjn8JFohPQibnkDt63vqSgQSke4w==
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
Subject: [RFC PATCH v2 17/22] selinux: reorder policydb_index()
Date: Mon, 16 Dec 2024 17:40:15 +0100
Message-ID: <20241216164055.96267-17-cgoettsche@seltendoof.de>
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

Index as soon as possible to enable isvalid() checks to fail on gaps.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index b4381a0b93f6..348cbe36502e 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -728,7 +728,6 @@ static int policydb_index(struct policydb *p)
 	pr_debug("SELinux:  %d classes, %d rules\n", p->p_classes.nprim,
 		 p->te_avtab.nel);
 
-	avtab_hash_eval(&p->te_avtab, "rules");
 	symtab_hash_eval(p->symtab);
 
 	p->class_val_to_struct = kcalloc(p->p_classes.nprim,
@@ -2791,6 +2790,10 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 		p->symtab[i].nprim = nprim;
 	}
 
+	rc = policydb_index(p);
+	if (rc)
+		goto bad;
+
 	rc = -EINVAL;
 	p->process_class = string_to_security_class(p, "process");
 	if (!p->process_class) {
@@ -2802,6 +2805,8 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 	if (rc)
 		goto bad;
 
+	avtab_hash_eval(&p->te_avtab, "rules");
+
 	if (p->policyvers >= POLICYDB_VERSION_BOOL) {
 		rc = cond_read_list(p, fp);
 		if (rc)
@@ -2898,10 +2903,6 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
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

