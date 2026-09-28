Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3004C4DEC2D
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617625; cv=none; b=Ns8g2u8kspLqzJt2c2RQ/7K1aW8Aj/5nBTmYPi7aWgfDu2k1uY95fci3lfc1ioiOqNj18iExj/aHQvK929g3LjAIYWBd8Rh31Oi9e/4apEMSsTGypFYsg+vC129MFxVaJECn3eg7tho2MDP5yYQ6UwIeuwYimnnRhnVLWZWoQXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617625; c=relaxed/simple;
	bh=2ruTBWrsx9X+eTDD0jSZQoBuiI2af/JnhjZFoEXyklg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ECKuSH0yrzJdrFHzgnEWjxl7tp9Pu5XrK3iMYnWUWBmjaHqSorsH+0O2cb2NYXfwEYNPMbHY4zRnGKcr7T88TrLGu+IWB505Bqgq91CMf1Omleibb+UsLhieHDzzYlKIePy59uUrrNWz0GNO+LCnV8X7LgbTpsmnQgJzTFWcdB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ceFO/S4u; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ceFO/S4u"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617620;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iFiRJEN2uR/7gmI5SSXl6vxNxzSZdxStuRC8xq+cE8c=;
	b=ceFO/S4uwpGlIggT07woFXQ9/wsIpzrLiFzYuJeREtvwS6RKjtst0CBdq3h7AKd1rwJG3b
	POSlr/9z13hUa86vgpgtl6+LQcv1GWXAiPU1dlX4nrcFQsCxD8J8q1olFFNshP2+dymDHj
	iffrKsp4E4Es9uCaQFnJXmfKClBSMmaKas5u403dH4yfqtFigzVB/87Ib9lKzdH/tfw19k
	+kIYq2/gz9SGPxfmhAMrbxTR2eZdaarfUNr0+TtOr2xk+yvNyKOuFNoOI3W7iE9HeGbW2v
	tZe0CE4z6vM2kyTD2elF10M/pYx/okeUo3sA0QlXNNf1KZHnP77jJIxmW08B0g==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 14/32] selinux: make sidtab_init() return void
Date: Mon, 28 Sep 2026 19:46:24 +0200
Message-ID: <20260928174643.2458710-13-cgoettsche@seltendoof.de>
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

sidtab_init() cannot fail.  Drop its return value and the unreachable
error handling in its only caller.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 6 +-----
 security/selinux/ss/sidtab.c   | 4 +---
 security/selinux/ss/sidtab.h   | 2 +-
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index cad404fc8819..ba96baec74a9 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -934,11 +934,7 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 	bool isid_init;
 	int rc;
 
-	rc = sidtab_init(s);
-	if (rc) {
-		pr_err("SELinux:  out of memory on SID table init\n");
-		return rc;
-	}
+	sidtab_init(s);
 
 	isid_init = ebitmap_get_bit(&p->policycaps,
 				    POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT);
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index 118af0aa2767..f55e1d781e52 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -32,7 +32,7 @@ struct sidtab_str_cache {
 #define index_to_sid(index) ((index) + SECINITSID_NUM + 1)
 #define sid_to_index(sid)   ((sid) - (SECINITSID_NUM + 1))
 
-int sidtab_init(struct sidtab *s)
+void sidtab_init(struct sidtab *s)
 {
 	u32 i;
 
@@ -53,8 +53,6 @@ int sidtab_init(struct sidtab *s)
 	INIT_LIST_HEAD(&s->cache_lru_list);
 	spin_lock_init(&s->cache_lock);
 #endif
-
-	return 0;
 }
 
 static u32 context_to_sid(struct sidtab *s, struct context *context, u32 hash)
diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
index a9d932a6352e..0298070fb759 100644
--- a/security/selinux/ss/sidtab.h
+++ b/security/selinux/ss/sidtab.h
@@ -104,7 +104,7 @@ struct sidtab {
 	DECLARE_HASHTABLE(context_to_sid, SIDTAB_HASH_BITS);
 };
 
-int sidtab_init(struct sidtab *s);
+void sidtab_init(struct sidtab *s);
 int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context);
 struct sidtab_entry *sidtab_search_entry(struct sidtab *s, u32 sid);
 struct sidtab_entry *sidtab_search_entry_force(struct sidtab *s, u32 sid);
-- 
2.55.0

