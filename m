Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9314A4E77EA
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617630; cv=none; b=ARpU4UTPgafgVxI6hhnZ8IDRPwBMX7uIOV5tutEYnwi+2gO0wRyVGhOF3H5DNF7zrlTEaJv977Z1abJf4+Skhbnz85QKd9oQEgviS9t3tUJ8KnSiAMw+8N+d2kMK38BwTBs7yDHYuicMSyHCETLAPNoMlVfq40C9j/Zq05DnTiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617630; c=relaxed/simple;
	bh=TcChf7aMHovYMXhC4oS1Xf1N1Wv7h5rSiyXnIOo9+PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pw+zOob8Cysvy2b/bCnvUeAClFVwYuyCCeRv55X6F8sGxPkHIksZ9UjWt1oS4zILRozaNg8I7cZO6FQH0/fg3x1LJn+KSGTVFy59oCW/Sh6WZ9qDwIiinuzcnoQyUJi38Yt/NbOh9oO51F8OktE7GKkhw7oFxUy+vMxzsQO72Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=bcG887UJ; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="bcG887UJ"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617626;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WqhX1SgDLmYnJOkuZFgm545zVXZRYQGpVfkOeY1gFsI=;
	b=bcG887UJyxKEwVXN8biTDErXD01sL3SLWUgk4ylHDMp8ixqQSqOLmHGEu3+du+gvQX8BEG
	XR9esa1Khj5IE9xRj4eEFYadwHxpx/qgttlutHiAUYtuoXj+RWM+UxbBV5vbaGG61hpWal
	OrifMgqYUXs/QeUnY8D0oNOR79oYSNGH9c/GF/sV1e11Ny5WQuegq3S8/nvLYR/0YN6iTg
	A3XV3k40NsyHRiqV3RlkkKMQjo6gfjrVLfYcLnV2bR/LXWrg5oxLbS2+rdsrZrdmYtWr1J
	1ZDE6HE9MWwxZKPEBt8mPBYll4PuYg21bTNSJk+UvVYPN3Bh9aT28PxyKkQXnQ==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 30/32] selinux: add level_val_to_struct[] for sensitivity lookups
Date: Mon, 28 Sep 2026 19:46:40 +0200
Message-ID: <20260928174643.2458710-29-cgoettsche@seltendoof.de>
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

mls_level_isvalid() is reached from policydb_context_isvalid() for every
newly computed context, e.g. on each security_compute_sid() call.  To
get at the level datum it translates the sensitivity value to its name
via sym_val_to_name[] and then looks that name up again in the p_levels
hash table, which requires hashing and comparing the string.

Record the non-alias level datums in a new level_val_to_struct[] array,
filled in sens_index() next to sym_val_to_name[SYM_LEVELS] and freed in
policydb_destroy() like the other *_val_to_struct arrays, and use it in
mls_level_isvalid().

Allocate the array with kvzalloc_objs() and release it with kvfree(), so
large sensitivity indexes can fall back to vmalloc just like the
existing sensitivity name array.

The result is the same: sym_val_to_name[SYM_LEVELS] only holds the keys
of non-alias datums, and looking such a key up in the (unique-key)
symbol table yields exactly the datum that registered it.  A value with
no non-alias datum still has a NULL entry and is rejected.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/mls.c      | 7 +------
 security/selinux/ss/policydb.c | 7 +++++++
 security/selinux/ss/policydb.h | 2 ++
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 81e6cfd0272b..68e4625a2a38 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -159,17 +159,12 @@ void mls_sid_to_context(struct policydb *p, struct context *context,
 static bool mls_level_isvalid(const struct policydb *p,
 			      const struct mls_level *l)
 {
-	const char *name;
 	const struct level_datum *levdatum;
 
 	if (!l->sens || l->sens > p->p_levels.nprim)
 		return false;
 
-	name = sym_name(p, SYM_LEVELS, l->sens - 1);
-	if (!name)
-		return false;
-
-	levdatum = symtab_search(&p->p_levels, name);
+	levdatum = p->level_val_to_struct[l->sens - 1];
 	if (!levdatum)
 		return false;
 
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index a80aebf0bbfa..8bdfad99aafa 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -658,6 +658,7 @@ static int sens_index(void *key, void *datum, void *datap)
 		if (p->sym_val_to_name[SYM_LEVELS][levdatum->level.sens - 1])
 			return -EINVAL;
 		p->sym_val_to_name[SYM_LEVELS][levdatum->level.sens - 1] = key;
+		p->level_val_to_struct[levdatum->level.sens - 1] = levdatum;
 	}
 
 	return 0;
@@ -791,6 +792,11 @@ static int policydb_index(struct policydb *p)
 	if (!p->type_val_to_struct)
 		return -ENOMEM;
 
+	p->level_val_to_struct = kvzalloc_objs(*p->level_val_to_struct,
+					       p->p_levels.nprim);
+	if (!p->level_val_to_struct)
+		return -ENOMEM;
+
 	rc = cond_init_bool_indexes(p);
 	if (rc)
 		goto out;
@@ -857,6 +863,7 @@ void policydb_destroy(struct policydb *p)
 	kfree(p->role_val_to_struct);
 	kfree(p->user_val_to_struct);
 	kvfree(p->type_val_to_struct);
+	kvfree(p->level_val_to_struct);
 
 	avtab_destroy(&p->te_avtab);
 
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 974180b2e3a3..a5ab8ffc4eae 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -256,6 +256,8 @@ struct policydb {
 	struct role_datum **role_val_to_struct;
 	struct user_datum **user_val_to_struct;
 	struct type_datum **type_val_to_struct;
+	/* non-alias sensitivities indexed by (sens - 1) */
+	struct level_datum **level_val_to_struct;
 
 	/* type enforcement access vectors and transitions */
 	struct avtab te_avtab;
-- 
2.55.0

