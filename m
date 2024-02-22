Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787D414038D
	for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 23:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646394; cv=none; b=JMSj02UDmjaGM2OyZ3ESKHbMUwdhfeObzvhRA67XXVe4iFP2B6Pkbu4vflyMhjFzU6PuDNmBxzhGNf5cv9KdOD5nETjPbpFq9lKGxkiws0TYI1JVmwhjV5wr9SgKX2R6sYDKmXFYYWcavaE6MGsYTe1BJO8SejbGM1MMyXnFlsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646394; c=relaxed/simple;
	bh=lJrcmSgC9EMiYe6KkWcngkQRPlbEw0GsWbu7yhus6zQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEaOrm938n44xxyJ62yCti4yWo2b5IaBxWX8+M5rTARUasEP4EsAHjvFTNYJbCMJB+Kl0v5XhlUePM0e74zKeeZLJFOVS9584AKRUXGIvPvLY9q8ZLbtHL/Jxnds0qICkXQU+Bf5tExN7A37zq5qySMrRkWZ6jjtphdSCUiq884=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bY/GBC6K; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bY/GBC6K"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-787aca0b502so8851885a.1
        for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 15:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708646391; x=1709251191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FPZNPM6ysqdZgtKCmKQMcjHP4qPa7n6/sOYp15wjxLU=;
        b=bY/GBC6KzDkqswFPxGjnsCbpFTzV0DXeBhOwKLEh8vWdeuga/G2kCk9PU73qzbhc0N
         jcoi9HPRGkj5SitwnHH7rOZaI6LrWq52mQ+hjvOEVu12EU0rUUkJrdjfgSHZpeXjBGKP
         4yjhQTnZjGGiKNgJqkzOUweMg1EzphM9i7nk45jd1yGUaDBQlXvJrskGxAEmeD3Ru8zu
         Ps2PKwcSDR6LbdvOnRoblqJ32IIKqqO+EU2ihHx87xPJbWeiuCPC/K0CAxImNoWgKZ4w
         4/fKVa9fByimoATxa0MPd1VzCObuH3CXZdUi6BxOrAIzFRCO+UsnXNSpxy2I4RRlR2Cj
         U/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646391; x=1709251191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPZNPM6ysqdZgtKCmKQMcjHP4qPa7n6/sOYp15wjxLU=;
        b=VgwlfYtNdA/UzXrIdEC3nfXbP/1TLW1t3turY1KmM/adlmkALTYu8ITJB+amJaAiB5
         5XP1xiHMCzhiAF4ETLftuAZmXR/trhX/V2msKRps5kw2toSY2GZkJRrd9HJA+S/MdAOr
         03CotsGzu0bUteFzIGjZZNWtG7UnYY2VHW3rxLtb33q2jQXPAOkbF18lyMdNFwGOoSsp
         5h2d9OVSTXq8Nn4DBTxK4hh9/UyHtcA80txtF20MVjQ08T4W7yUbzovpSMoWsQvTdR9z
         j3CTUs88HgNVDManr31YGas66dgvTvM2J7bIiidfbl8JQOszjZH89uwgacjr0ZuRjQoa
         R6ug==
X-Gm-Message-State: AOJu0Ywc36ONZ+wg5F+Z62Iq+Y0HQEGSUWRqMD4UpkQV87C1ePdzppe5
	MIT67ThnddiJjRxKDqTWBdl2uOEHKPKvBvU71d1z79XJhd2EcZDtVqbrjSBZE2xNWLBzuBTsg1I
	=
X-Google-Smtp-Source: AGHT+IHrlk4Lgb4qPCTM4CEIKu1dcZqouGmEg85VDnTA57itidnBosAQ93eJJK2ugWr/tQFSiKyWqQ==
X-Received: by 2002:a05:620a:2046:b0:787:28cb:5ab8 with SMTP id d6-20020a05620a204600b0078728cb5ab8mr598789qka.41.1708646391156;
        Thu, 22 Feb 2024 15:59:51 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id l8-20020ae9f008000000b007877add9363sm2814499qkg.103.2024.02.22.15.59.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 15:59:50 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 19/21] selinux: fix style issues in security/selinux/ss/sidtab.c
Date: Thu, 22 Feb 2024 18:52:37 -0500
Message-ID: <20240222235708.386652-42-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222235708.386652-23-paul@paul-moore.com>
References: <20240222235708.386652-23-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6822; i=paul@paul-moore.com; h=from:subject; bh=lJrcmSgC9EMiYe6KkWcngkQRPlbEw0GsWbu7yhus6zQ=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBl19/KeeqUZkzfB6/cs3qSJga0M3f4J80MRtvu/ UWGt88v9gyJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZdffygAKCRDqIPLalzeJ c+wGD/4x7w0yHIbc/XOCm+EC9wFg+kvhCFYsynNX7Kj8n2nncFMGgOgfDRQvlxCSNKdEf2Ml1+s R4/wqMkKqquzol1T1SXFlUMmylixQkeT6YOUT2RXsbdOz/w5ZbOtBaSzfy2OmrljKETDE043xMc GTg5FCPF5QG6/mgljNKQXZqF+SmsEkXR8mbE8IiFXJHLgW01QMDF1kRK3LVRZDMY6Y7BUB4sUCi zBg4Zh8/2g8i/9E0iMMqDI91n2nhrOiw8iMEyCjsTqI2F7GUdgYGshV5PDA3zerV3EFBW+9WBg7 DJ+uijCBn7NrhNv001YYH7LKuVabMm/ynq9AU4knqluCtsFWeNepClSgUkpnAVjcJ+pCBt99nSj t5n1cjLF4qgrK3WDQitfIxdyLHFHLpJeYNKPCBnoeQsFHQQa/FSdGpbzYnfP0czFZTTpkoGdXO7 V0G1u3ofHLY4OWIwGvS5z41kGWGP2TzB5e8SdpYEWg9w8190n5T3Hg0mOtl8ngMw+1LzX2xjFtl N37HeCoPilsjcU3ivTGZsvfvCdwI3boJn8nsHZ9am3wJPtN/W+/Ft0C9sIw+8JkaJBAsG8g94uT ZY31UKGS1W9bI6qmF23cNrlLqfn28/bSsE+Xi+1EQ0PmwtI5JW9MVGC66TfKhg+SS0uyQNVNYxx 2qUg/hS/ZJrh0Pw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As part of on ongoing effort to perform more automated testing and
provide more tools for individual developers to validate their
patches before submitting, we are trying to make our code
"clang-format clean".  My hope is that once we have fixed all of our
style "quirks", developers will be able to run clang-format on their
patches to help avoid silly formatting problems and ensure their
changes fit in well with the rest of the SELinux kernel code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ss/sidtab.c | 69 +++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 32 deletions(-)

diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index 732fd8e22a12..c8848cbba81f 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -7,6 +7,7 @@
  *
  * Copyright (C) 2018 Red Hat, Inc.
  */
+
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -29,7 +30,7 @@ struct sidtab_str_cache {
 };
 
 #define index_to_sid(index) ((index) + SECINITSID_NUM + 1)
-#define sid_to_index(sid) ((sid) - (SECINITSID_NUM + 1))
+#define sid_to_index(sid)   ((sid) - (SECINITSID_NUM + 1))
 
 int sidtab_init(struct sidtab *s)
 {
@@ -140,9 +141,11 @@ int sidtab_hash_stats(struct sidtab *sidtab, char *page)
 	if (chain_len > max_chain_len)
 		max_chain_len = chain_len;
 
-	return scnprintf(page, PAGE_SIZE, "entries: %d\nbuckets used: %d/%d\n"
-			 "longest chain: %d\n", entries,
-			 slots_used, SIDTAB_HASH_BUCKETS, max_chain_len);
+	return scnprintf(page, PAGE_SIZE,
+			 "entries: %d\nbuckets used: %d/%d\n"
+			 "longest chain: %d\n",
+			 entries, slots_used, SIDTAB_HASH_BUCKETS,
+			 max_chain_len);
 }
 
 static u32 sidtab_level_from_count(u32 count)
@@ -162,15 +165,15 @@ static int sidtab_alloc_roots(struct sidtab *s, u32 level)
 	u32 l;
 
 	if (!s->roots[0].ptr_leaf) {
-		s->roots[0].ptr_leaf = kzalloc(SIDTAB_NODE_ALLOC_SIZE,
-					       GFP_ATOMIC);
+		s->roots[0].ptr_leaf =
+			kzalloc(SIDTAB_NODE_ALLOC_SIZE, GFP_ATOMIC);
 		if (!s->roots[0].ptr_leaf)
 			return -ENOMEM;
 	}
 	for (l = 1; l <= level; ++l)
 		if (!s->roots[l].ptr_inner) {
-			s->roots[l].ptr_inner = kzalloc(SIDTAB_NODE_ALLOC_SIZE,
-							GFP_ATOMIC);
+			s->roots[l].ptr_inner =
+				kzalloc(SIDTAB_NODE_ALLOC_SIZE, GFP_ATOMIC);
 			if (!s->roots[l].ptr_inner)
 				return -ENOMEM;
 			s->roots[l].ptr_inner->entries[0] = s->roots[l - 1];
@@ -203,16 +206,16 @@ static struct sidtab_entry *sidtab_do_lookup(struct sidtab *s, u32 index,
 
 		if (!entry->ptr_inner) {
 			if (alloc)
-				entry->ptr_inner = kzalloc(SIDTAB_NODE_ALLOC_SIZE,
-							   GFP_ATOMIC);
+				entry->ptr_inner = kzalloc(
+					SIDTAB_NODE_ALLOC_SIZE, GFP_ATOMIC);
 			if (!entry->ptr_inner)
 				return NULL;
 		}
 	}
 	if (!entry->ptr_leaf) {
 		if (alloc)
-			entry->ptr_leaf = kzalloc(SIDTAB_NODE_ALLOC_SIZE,
-						  GFP_ATOMIC);
+			entry->ptr_leaf =
+				kzalloc(SIDTAB_NODE_ALLOC_SIZE, GFP_ATOMIC);
 		if (!entry->ptr_leaf)
 			return NULL;
 	}
@@ -262,8 +265,7 @@ struct sidtab_entry *sidtab_search_entry_force(struct sidtab *s, u32 sid)
 	return sidtab_search_core(s, sid, 1);
 }
 
-int sidtab_context_to_sid(struct sidtab *s, struct context *context,
-			  u32 *sid)
+int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid)
 {
 	unsigned long flags;
 	u32 count, hash = context_compute_hash(context);
@@ -327,8 +329,8 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context,
 			goto out_unlock;
 		}
 
-		rc = services_convert_context(convert->args,
-					      context, &dst_convert->context,
+		rc = services_convert_context(convert->args, context,
+					      &dst_convert->context,
 					      GFP_ATOMIC);
 		if (rc) {
 			context_destroy(&dst->context);
@@ -338,8 +340,8 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context,
 		dst_convert->hash = context_compute_hash(&dst_convert->context);
 		target->count = count + 1;
 
-		hash_add_rcu(target->context_to_sid,
-			     &dst_convert->list, dst_convert->hash);
+		hash_add_rcu(target->context_to_sid, &dst_convert->list,
+			     dst_convert->hash);
 	}
 
 	if (context->len)
@@ -373,8 +375,8 @@ static void sidtab_convert_hashtable(struct sidtab *s, u32 count)
 }
 
 static int sidtab_convert_tree(union sidtab_entry_inner *edst,
-			       union sidtab_entry_inner *esrc,
-			       u32 *pos, u32 count, u32 level,
+			       union sidtab_entry_inner *esrc, u32 *pos,
+			       u32 count, u32 level,
 			       struct sidtab_convert_params *convert)
 {
 	int rc;
@@ -382,8 +384,8 @@ static int sidtab_convert_tree(union sidtab_entry_inner *edst,
 
 	if (level != 0) {
 		if (!edst->ptr_inner) {
-			edst->ptr_inner = kzalloc(SIDTAB_NODE_ALLOC_SIZE,
-						  GFP_KERNEL);
+			edst->ptr_inner =
+				kzalloc(SIDTAB_NODE_ALLOC_SIZE, GFP_KERNEL);
 			if (!edst->ptr_inner)
 				return -ENOMEM;
 		}
@@ -399,17 +401,18 @@ static int sidtab_convert_tree(union sidtab_entry_inner *edst,
 		}
 	} else {
 		if (!edst->ptr_leaf) {
-			edst->ptr_leaf = kzalloc(SIDTAB_NODE_ALLOC_SIZE,
-						 GFP_KERNEL);
+			edst->ptr_leaf =
+				kzalloc(SIDTAB_NODE_ALLOC_SIZE, GFP_KERNEL);
 			if (!edst->ptr_leaf)
 				return -ENOMEM;
 		}
 		i = 0;
 		while (i < SIDTAB_LEAF_ENTRIES && *pos < count) {
-			rc = services_convert_context(convert->args,
-					&esrc->ptr_leaf->entries[i].context,
-					&edst->ptr_leaf->entries[i].context,
-					GFP_KERNEL);
+			rc = services_convert_context(
+				convert->args,
+				&esrc->ptr_leaf->entries[i].context,
+				&edst->ptr_leaf->entries[i].context,
+				GFP_KERNEL);
 			if (rc)
 				return rc;
 			(*pos)++;
@@ -489,13 +492,15 @@ void sidtab_cancel_convert(struct sidtab *s)
 	spin_unlock_irqrestore(&s->lock, flags);
 }
 
-void sidtab_freeze_begin(struct sidtab *s, unsigned long *flags) __acquires(&s->lock)
+void sidtab_freeze_begin(struct sidtab *s, unsigned long *flags)
+	__acquires(&s->lock)
 {
 	spin_lock_irqsave(&s->lock, *flags);
 	s->frozen = true;
 	s->convert = NULL;
 }
-void sidtab_freeze_end(struct sidtab *s, unsigned long *flags) __releases(&s->lock)
+void sidtab_freeze_end(struct sidtab *s, unsigned long *flags)
+	__releases(&s->lock)
 {
 	spin_unlock_irqrestore(&s->lock, *flags);
 }
@@ -600,8 +605,8 @@ void sidtab_sid2str_put(struct sidtab *s, struct sidtab_entry *entry,
 	kfree_rcu(victim, rcu_member);
 }
 
-int sidtab_sid2str_get(struct sidtab *s, struct sidtab_entry *entry,
-		       char **out, u32 *out_len)
+int sidtab_sid2str_get(struct sidtab *s, struct sidtab_entry *entry, char **out,
+		       u32 *out_len)
 {
 	struct sidtab_str_cache *cache;
 	int rc = 0;
-- 
2.43.2

