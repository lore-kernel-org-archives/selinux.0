Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A43525D534;
	Sun, 11 May 2025 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746984682; cv=none; b=pJ5vQrnwoLAQo2ccpMhVXiT0v2b7gF1LmGJZZhN+Tx+Q7wGfdmk56mq/Ww+5vHD6sa15sTFzQFRCYbZYjKhi2NKNdPDWj9MhuKTRCiN5gicB4IZXiTPrkDkLNuWvdvxGbDH2AVK2FEUAyrU2j/oCxbFcGhYOz0JPPOaAvdLiB+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746984682; c=relaxed/simple;
	bh=J4SFkPMU9uL0Rvq3EpkGD1G0j1JTtqPbB8A+6ZFYP3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXviDhsizWrhcxTi5QAX+gR1rBGH5N6Bqqes9qeTCL+ANG6fgFMH4njkwABr54WQRsBgkH/p4kvmimCDjGjBzcx+VDN3u0LIFENbICB3Je8/zK5yguE2vRY0CamgSZKpjPeI0qqNuFzzv8Nfe9YZD9r2nNLtekzw0JIBjHj4XQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=PVxujbaK; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="PVxujbaK"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1746984678;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lz4O6flymv2J3AzsOh7RW9tvDTAU8sYEZcufC56T2Zk=;
	b=PVxujbaKRli6syTvXSOk3KC8zlWbxt5+2Xp5zy+qlXg3DMfkF7fYzfnHtkNdFm+120xtpT
	xrpwLrIY7Ek5fl49lUvrU+A4x9JOHOKUDAMe7sw5FRO05UTM8U7wNn15KEXmZugwhlJDwx
	dnbbMVkjhiiivUyuqtUgUFRX84LiQS3dKMiONWGbJdI5d6pK6S4zlB8CeTWFneCxAvVVOW
	sdAlF2uaJte8SOU9CgaE5KsvcI/WnCPNFYiDjzeVxbSrbcb7ILsKeTugKeR2po/VK2pVb4
	QdG9Pimmd4GmFIK0/sNialvWiz2gitvq/8kLuGfEpa3usoGkpaELgzX/rWQ+Kg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/14] selinux: reorder policydb_index()
Date: Sun, 11 May 2025 19:30:08 +0200
Message-ID: <20250511173055.406906-8-cgoettsche@seltendoof.de>
In-Reply-To: <20250511173055.406906-1-cgoettsche@seltendoof.de>
References: <20250511173055.406906-1-cgoettsche@seltendoof.de>
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
index 27f6809b562a..326d82f8db8c 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -728,7 +728,6 @@ static int policydb_index(struct policydb *p)
 	pr_debug("SELinux:  %d classes, %d rules\n", p->p_classes.nprim,
 		 p->te_avtab.nel);
 
-	avtab_hash_eval(&p->te_avtab, "rules");
 	symtab_hash_eval(p->symtab);
 
 	p->class_val_to_struct = kcalloc(p->p_classes.nprim,
@@ -2799,6 +2798,10 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 		p->symtab[i].nprim = nprim;
 	}
 
+	rc = policydb_index(p);
+	if (rc)
+		goto bad;
+
 	rc = -EINVAL;
 	p->process_class = string_to_security_class(p, "process");
 	if (!p->process_class) {
@@ -2810,6 +2813,8 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 	if (rc)
 		goto bad;
 
+	avtab_hash_eval(&p->te_avtab, "rules");
+
 	if (p->policyvers >= POLICYDB_VERSION_BOOL) {
 		rc = cond_read_list(p, fp);
 		if (rc)
@@ -2907,10 +2912,6 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
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
2.49.0

