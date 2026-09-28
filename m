Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFCC4E56CC
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617630; cv=none; b=PXfxh/q7M1/99SoM5pGM6FEwN5GChcnHT27e4BsCyeSF7UTHlmz9s1HG01y8gGdS2SeyJJReb4ufKflfT776cNACKtFs8AxyNoXgPQhHQkhGscWCEbCtYeuLBheKZSv+tGYmYXGh1l6/H9fb+IrjJKjPazuHyeTWf1M9UpvrJJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617630; c=relaxed/simple;
	bh=wJWlO7uk7AeF7BYcFkoURujt+FDCGZ8B57x7zNsK4PE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gTOJcMOosKHJzMwDaUZm+52ieM2VJM7xFXr8dO3QrD9xMLmtYJleIhasIkLezk7516YjMXikMhM7KBarir0LA6aY5SaVTNpGrkaw6kMuanwvZQp4ExdigxsEgKLl1iN93f5tFrTIQ/SaE0En6w1MITvFPk4ASkKQ/8hf/Dad9PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=d9r64ZZT; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="d9r64ZZT"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617626;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xKmeLwHCuprVD8vP8ZuPOJdCoFxdLyQwQJISU21dcs=;
	b=d9r64ZZTNFpPH4OCrX1FK9nZUQSg74cu4MRAiCzUOqZVBzUW3A9T40Sn0z+j3hbSCWveMS
	2PGWJqFuGdDvEce/bLbL7PnxnwZ99VhCPjRFKBLMVzNR1/PWGq08wbcPo5qHVX2EewG0p1
	RjXSL+lY8T+FxVreiJkrAUWsq/yrrYot/AjC1pQ3OX2SEyPgdLOp1c+JAQ/jGk08I6wxqC
	sSjkGa1UYiW4qB0E1PoftUVpiln2BBhwLHqKJuE1CnOPc3jy44LvdG0UQ278LV9v/BuIPW
	O7D0NvPr+B3Fyp2S6mIG21BhgOr9DcncAlZvu+YmwLayCEufs6OfZkxR6gUJcA==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 31/32] selinux: add policydb_class_datum() helper
Date: Mon, 28 Sep 2026 19:46:41 +0200
Message-ID: <20260928174643.2458710-30-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
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

Five sites open-code the range check of a class value followed by the
lookup in class_val_to_struct[]. Add a helper returning the class datum
or NULL for an out of range value, and use it in
context_struct_compute_av(), security_compute_validatetrans(),
security_compute_sid(), mls_compute_sid() and string_to_av_perm().

Each caller keeps its own handling of an invalid class. In
security_compute_sid() the unconditional assignment makes the reset of
cladatum on retry redundant.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/mls.c      |  8 +++-----
 security/selinux/ss/policydb.c |  4 ++--
 security/selinux/ss/policydb.h |  9 +++++++++
 security/selinux/ss/services.c | 13 +++++--------
 4 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 68e4625a2a38..fa19ef6caf7f 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -465,11 +465,9 @@ int mls_compute_sid(struct policydb *p, struct context *scontext,
 		if (r)
 			return mls_range_set(newcontext, r);
 
-		if (tclass && tclass <= p->p_classes.nprim) {
-			cladatum = p->class_val_to_struct[tclass - 1];
-			if (cladatum)
-				default_range = cladatum->default_range;
-		}
+		cladatum = policydb_class_datum(p, tclass);
+		if (cladatum)
+			default_range = cladatum->default_range;
 
 		switch (default_range) {
 		case DEFAULT_SOURCE_LOW:
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 8bdfad99aafa..5230c24d46c3 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2103,10 +2103,10 @@ u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name)
 	struct perm_datum *perdatum = NULL;
 	struct common_datum *comdatum;
 
-	if (!tclass || tclass > p->p_classes.nprim)
+	cladatum = policydb_class_datum(p, tclass);
+	if (!cladatum)
 		return 0;
 
-	cladatum = p->class_val_to_struct[tclass - 1];
 	comdatum = cladatum->comdatum;
 	if (comdatum)
 		perdatum = symtab_search(&comdatum->permissions, name);
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index a5ab8ffc4eae..8ccb4c3392fc 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -408,6 +408,15 @@ static inline const char *sym_name(const struct policydb *p, unsigned int sym_nu
 	return p->sym_val_to_name[sym_num][element_nr];
 }
 
+static inline struct class_datum *policydb_class_datum(const struct policydb *p,
+						       u16 tclass)
+{
+	if (!tclass || tclass > p->p_classes.nprim)
+		return NULL;
+
+	return p->class_val_to_struct[tclass - 1];
+}
+
 static inline bool val_is_boolean(u32 value)
 {
 	return value == 0 || value == 1;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 1b8f420e5e1b..aa7579d21140 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -641,13 +641,12 @@ static void context_struct_compute_av(struct policydb *policydb,
 		memset(xperms, 0, sizeof(*xperms));
 	}
 
-	if (unlikely(!tclass || tclass > policydb->p_classes.nprim)) {
+	tclass_datum = policydb_class_datum(policydb, tclass);
+	if (unlikely(!tclass_datum)) {
 		pr_warn_ratelimited("SELinux:  Invalid class %u\n", tclass);
 		return;
 	}
 
-	tclass_datum = policydb->class_val_to_struct[tclass - 1];
-
 	/*
 	 * If a specific type enforcement rule was defined for
 	 * this permission check, then use it.
@@ -784,11 +783,11 @@ static int security_compute_validatetrans(u32 oldsid, u32 newsid, u32 tasksid,
 	else
 		tclass = orig_tclass;
 
-	if (!tclass || tclass > policydb->p_classes.nprim) {
+	tclass_datum = policydb_class_datum(policydb, tclass);
+	if (!tclass_datum) {
 		rc = -EINVAL;
 		goto out;
 	}
-	tclass_datum = policydb->class_val_to_struct[tclass - 1];
 
 	oentry = sidtab_search_entry(sidtab, oldsid);
 	if (!oentry) {
@@ -1785,7 +1784,6 @@ static int security_compute_sid(u32 ssid,
 	}
 
 retry:
-	cladatum = NULL;
 	context_init(&newcontext);
 
 	rcu_read_lock();
@@ -1822,8 +1820,7 @@ static int security_compute_sid(u32 ssid,
 	scontext = &sentry->context;
 	tcontext = &tentry->context;
 
-	if (tclass && tclass <= policydb->p_classes.nprim)
-		cladatum = policydb->class_val_to_struct[tclass - 1];
+	cladatum = policydb_class_datum(policydb, tclass);
 
 	/* Set the user identity. */
 	switch (specified) {
-- 
2.55.0

