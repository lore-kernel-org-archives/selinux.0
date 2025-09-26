Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE09627A12D
	for <selinux@vger.kernel.org>; Fri, 26 Sep 2025 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758867807; cv=none; b=KBPgQ9bBnjeVw5MkuNF+ukqpx+MyrUR8t8OVuJR0v/JsuKNqrr2CmVOd3lncbakGyRurcY9O3UKGaBpNUVsDjG57lytQpu1pOh+wTcZjueQ5LDh2DSZVPlodeJTH+TRCEk800dYD3OHgKll9UjvG98ek/8fRN++IlmAaUIb/P3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758867807; c=relaxed/simple;
	bh=OelFJmvx0NhE6nKyLjoHzfbmYUaetqukKA+N9t1a5OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PdL3e+KusUyHZrPz6b2Ahs4p8y05m4vvYIME82HdXj+OrhxznTHYtgsBYywOKnuO3rIB4YK/NLodXWMi4gnfdjcwPBskK7FXIavRffNRoymlIThA+I2ybhB1Rvz/lzyQyklgAcy6ewiiCl1qHVqYS9ecyFGd/DTpVOYU8PP06bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+PkERD7; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+PkERD7"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b57bffc0248so1395073a12.0
        for <selinux@vger.kernel.org>; Thu, 25 Sep 2025 23:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758867804; x=1759472604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wpopjzKvn+DxHJvP3HonHhrSV+mOoMbKIX1RB72zO4=;
        b=E+PkERD7oS9UrGj/1iMjfoq47zJi0ZWwsKFSOJ7XxCVujWwl3priN6jL+iCJLEsZ5f
         wyJbAwZbRokee5RxK8PfFzTbhgPuZtMOjMXqLzWZPjCa1u5eLX1w0H2lRySvmpaqxnQc
         Ez/t+N9pe/mDw5YcRiZ5KjF3FZktW08nHuQMtXNlY03NYKf7Qs8cfmDvBV1JLoTonkCe
         ziIntqSIptQi+kEYZgvTarveAqNRxtYRw7aEw9n+QamzETaNCYy3+FkJ7r18Z6seaDM2
         J16D8GidO/hOfIO+AA3TEt7gWlv+3MQNNWa03WU684miEDsJZJMENu87jq5RnTCpgJtA
         gzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758867804; x=1759472604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wpopjzKvn+DxHJvP3HonHhrSV+mOoMbKIX1RB72zO4=;
        b=PMoHdPyySnHnQ1vWgoCnJ8FTRNxkvjDNsC127IuT6B/4bwX54ouNfoG9UKbgkT852H
         wj7WZSo0EM3NHtkkrV6cAmpWDGJJZ2j+pOY3Fy0UPDUuVxtCNZdo/xEyrra9WHBIHE7Y
         xIlTpQeeOw9J493vdWPWxzn/4DjYYmTUhwsoY14uzX4K5QqJ+MmUow56a/WQDb8E7bky
         MA4bgiSGTD+o8lMT0BtPOWJR1945qOiczS+XcU84+Fn/UDpGQQ7tvP6zpMM9ErB3UrdT
         bL1vNR7BkcnefZGG4C1fbImyJsGaDtXLzqBhbV6eoqeAMkBlln6r759XMiwaGkpl2bqw
         A5Zw==
X-Forwarded-Encrypted: i=1; AJvYcCX8Di82I2yMTHlRDhTRc7vPOJtg/2+NuxtH2OCOXVtu4XbfgYY8sb3Tps9NGdPMZ1KR8JMxC5I6@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy1rXMJvAya4mnBLOciaeqGgx//XwJemMZMp6HTPvqvRH9fKLS
	pROaICm5MlZez5D05q10+ZJ8m+T9eP96Obl6fVAvZL/VlcvBr1Ym2PpF
X-Gm-Gg: ASbGncu+udm/pWedW635zwUixfhcdLIfGF1/sXhmHV9nXoFjTA6Hlo/Z4BSvvGJcg5k
	bdFhL1mD2Zsj+yrpkFMbmkM9CA2u1SlTNJIdgcrrThG9CyMpjIPRshhGQoU0+pCVtmPtIKXiIPI
	rjom9FJPyWOUJw9od9YaQWymsHQv50perBtFgxyee47KzdIs3nxwHw5bSGQwqxucb4QSOAXQzwq
	mx51IU1YS++mrakD0QwmrF29TXeLZ7Sn9j3SY6uVpQDmZCe9rv6hRgBA35reVl6NEY36K1ogPZD
	AOXSgG9Kvqp6D6E3Zmo36IAVaVsKEmvJ7BwF4Mj3HaLg61kZrwiF8IZOjASPhaimoI48D8iXoIb
	T7fuzPzgkcUiSPhNa1hK6NahyO+MzwcFH17GhVyJLW2dxnlQvkkXcRBa90bswTg==
X-Google-Smtp-Source: AGHT+IFnttlT8Gsdpg7Ug1px+5rpztHmUtlx4NDCBv1QX4Ysm9YVZRvztEIu5YRu9pAQ12p/mEnrHw==
X-Received: by 2002:a17:902:ea11:b0:27d:6995:990d with SMTP id d9443c01a7336-27ed6e1d364mr55460315ad.19.1758867803881;
        Thu, 25 Sep 2025 23:23:23 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69952b3sm43531055ad.96.2025.09.25.23.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 23:23:23 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: stephen.smalley.work@gmail.com,
	paul@paul-moore.com,
	omosnace@redhat.com
Cc: linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	zhanghongru@xiaomi.com
Subject: [PATCH v3 1/2] selinux: Make avc cache slot size configurable during boot
Date: Fri, 26 Sep 2025 14:23:16 +0800
Message-ID: <d849e8a98bf88bd12fd13a8f6b6e84290dcaaf6e.1758859391.git.zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758859391.git.zhanghongru@xiaomi.com>
References: <cover.1758859391.git.zhanghongru@xiaomi.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongru Zhang <zhanghongru@xiaomi.com>

On mobile device high-load situations, permission check can happen
more than 90,000/s (8 core system). With default 512 cache nodes
configuration, avc cache miss happens more often and occasionally
leads to long time (>2ms) irqs off on both big and little cores,
which decreases system real-time capability.

An actual call stack is as follows:
 => avc_compute_av
 => avc_perm_nonode
 => avc_has_perm_noaudit
 => selinux_capable
 => security_capable
 => capable
 => __sched_setscheduler
 => do_sched_setscheduler
 => __arm64_sys_sched_setscheduler
 => invoke_syscall
 => el0_svc_common
 => do_el0_svc
 => el0_svc
 => el0t_64_sync_handler
 => el0t_64_sync

Although we can expand avc nodes through /sys/fs/selinux/cache_threshold
to mitigate long time irqs off, hash conflicts make the bucket average
length longer because of the fixed size of cache slots, leading to
avc_search_node latency increase.

Make avc cache slot size also configurable, and with fine tuning, we can
mitigate long time irqs off with slightly avc_search_node performance
regression.

Theoretically, the main overhead is memory consumption.

avc_search_node avg latency test results (about 100,000,000 times) on
Qcom SM8750, 6.6.30-android15-8:

Case 1:
+---------+---------------------+------------------------+
|         | no-patch (512/512)  | with-patch (512/512)   |
+---------+---------------------+------------------------+
| latency |        85 ns        |         87 ns          |
+---------+---------------------+------------------------+

Case 2:
+---------+---------------------+------------------------+
|         | no-patch (8192/512) | with-patch (8192/8192) |
+---------+---------------------+------------------------+
| latency |        277 ns       |         106 ns         |
+---------+---------------------+------------------------+

Case 1 shows 512 nodes configuration has ~2% performance regression
with patch.
Case 2 shows 8192 nodes configuration has ~61% latency benifit with
patch.

Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>
---
 .../admin-guide/kernel-parameters.txt         |  4 ++
 security/selinux/avc.c                        | 68 +++++++++++++------
 2 files changed, 50 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 747a55abf494..70dc6d659117 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6620,6 +6620,10 @@
 			1 -- enable.
 			Default value is 1.
 
+	selinux_avc_cache_slots= [SELINUX] Set the avc cache slot size.
+			Format: <int> (must be >0, power of 2)
+			Default: 512
+
 	serialnumber	[BUGS=X86-32]
 
 	sev=option[,option...] [X86-64]
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 430b0e23ee00..7a7f88012865 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -34,7 +34,7 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/avc.h>
 
-#define AVC_CACHE_SLOTS			512
+static int avc_cache_slots __ro_after_init = 512;
 #define AVC_DEF_CACHE_THRESHOLD		512
 #define AVC_CACHE_RECLAIM		16
 
@@ -68,9 +68,13 @@ struct avc_xperms_node {
 	struct list_head xpd_head; /* list head of extended_perms_decision */
 };
 
+struct avc_slot {
+	struct hlist_head	slot;		/* head for avc_node->list */
+	spinlock_t		slot_lock;	/* lock for writes */
+};
+
 struct avc_cache {
-	struct hlist_head	slots[AVC_CACHE_SLOTS]; /* head for avc_node->list */
-	spinlock_t		slots_lock[AVC_CACHE_SLOTS]; /* lock for writes */
+	struct avc_slot		*slots;
 	atomic_t		lru_hint;	/* LRU hint for reclaim scan */
 	atomic_t		active_nodes;
 	u32			latest_notif;	/* latest revocation notification */
@@ -93,14 +97,34 @@ struct selinux_avc {
 
 static struct selinux_avc selinux_avc;
 
+static int __init set_selinux_avc_cache_slots(char *str)
+{
+	int val;
+
+	if ((kstrtoint(str, 0, &val)) || !is_power_of_2(val)) {
+		pr_warn("Unable to set selinux_avc_cache_slots, use default value\n");
+		return 1;
+	}
+
+	avc_cache_slots = val;
+
+	return 1;
+}
+__setup("selinux_avc_cache_slots=", set_selinux_avc_cache_slots);
+
 void selinux_avc_init(void)
 {
 	int i;
 
+	selinux_avc.avc_cache.slots =
+		kmalloc_array(avc_cache_slots, sizeof(struct avc_slot), GFP_KERNEL);
+	if (!selinux_avc.avc_cache.slots)
+		panic("SELinux: No memory to alloc avc cache slots\n");
+
 	selinux_avc.avc_cache_threshold = AVC_DEF_CACHE_THRESHOLD;
-	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
-		INIT_HLIST_HEAD(&selinux_avc.avc_cache.slots[i]);
-		spin_lock_init(&selinux_avc.avc_cache.slots_lock[i]);
+	for (i = 0; i < avc_cache_slots; i++) {
+		INIT_HLIST_HEAD(&selinux_avc.avc_cache.slots[i].slot);
+		spin_lock_init(&selinux_avc.avc_cache.slots[i].slot_lock);
 	}
 	atomic_set(&selinux_avc.avc_cache.active_nodes, 0);
 	atomic_set(&selinux_avc.avc_cache.lru_hint, 0);
@@ -124,7 +148,7 @@ static struct kmem_cache *avc_xperms_cachep __ro_after_init;
 
 static inline u32 avc_hash(u32 ssid, u32 tsid, u16 tclass)
 {
-	return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (AVC_CACHE_SLOTS - 1);
+	return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (avc_cache_slots - 1);
 }
 
 /**
@@ -150,8 +174,8 @@ int avc_get_hash_stats(char *page)
 
 	slots_used = 0;
 	max_chain_len = 0;
-	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
-		head = &selinux_avc.avc_cache.slots[i];
+	for (i = 0; i < avc_cache_slots; i++) {
+		head = &selinux_avc.avc_cache.slots[i].slot;
 		if (!hlist_empty(head)) {
 			slots_used++;
 			chain_len = 0;
@@ -167,7 +191,7 @@ int avc_get_hash_stats(char *page)
 	return scnprintf(page, PAGE_SIZE, "entries: %d\nbuckets used: %d/%d\n"
 			 "longest chain: %d\n",
 			 atomic_read(&selinux_avc.avc_cache.active_nodes),
-			 slots_used, AVC_CACHE_SLOTS, max_chain_len);
+			 slots_used, avc_cache_slots, max_chain_len);
 }
 
 /*
@@ -463,11 +487,11 @@ static inline int avc_reclaim_node(void)
 	struct hlist_head *head;
 	spinlock_t *lock;
 
-	for (try = 0, ecx = 0; try < AVC_CACHE_SLOTS; try++) {
+	for (try = 0, ecx = 0; try < avc_cache_slots; try++) {
 		hvalue = atomic_inc_return(&selinux_avc.avc_cache.lru_hint) &
-			(AVC_CACHE_SLOTS - 1);
-		head = &selinux_avc.avc_cache.slots[hvalue];
-		lock = &selinux_avc.avc_cache.slots_lock[hvalue];
+			(avc_cache_slots - 1);
+		head = &selinux_avc.avc_cache.slots[hvalue].slot;
+		lock = &selinux_avc.avc_cache.slots[hvalue].slot_lock;
 
 		if (!spin_trylock_irqsave(lock, flags))
 			continue;
@@ -524,7 +548,7 @@ static inline struct avc_node *avc_search_node(u32 ssid, u32 tsid, u16 tclass)
 	struct hlist_head *head;
 
 	hvalue = avc_hash(ssid, tsid, tclass);
-	head = &selinux_avc.avc_cache.slots[hvalue];
+	head = &selinux_avc.avc_cache.slots[hvalue].slot;
 	hlist_for_each_entry_rcu(node, head, list) {
 		if (ssid == node->ae.ssid &&
 		    tclass == node->ae.tclass &&
@@ -625,8 +649,8 @@ static void avc_insert(u32 ssid, u32 tsid, u16 tclass,
 	}
 
 	hvalue = avc_hash(ssid, tsid, tclass);
-	head = &selinux_avc.avc_cache.slots[hvalue];
-	lock = &selinux_avc.avc_cache.slots_lock[hvalue];
+	head = &selinux_avc.avc_cache.slots[hvalue].slot;
+	lock = &selinux_avc.avc_cache.slots[hvalue].slot_lock;
 	spin_lock_irqsave(lock, flag);
 	hlist_for_each_entry(pos, head, list) {
 		if (pos->ae.ssid == ssid &&
@@ -846,8 +870,8 @@ static int avc_update_node(u32 event, u32 perms, u8 driver, u8 base_perm,
 	/* Lock the target slot */
 	hvalue = avc_hash(ssid, tsid, tclass);
 
-	head = &selinux_avc.avc_cache.slots[hvalue];
-	lock = &selinux_avc.avc_cache.slots_lock[hvalue];
+	head = &selinux_avc.avc_cache.slots[hvalue].slot;
+	lock = &selinux_avc.avc_cache.slots[hvalue].slot_lock;
 
 	spin_lock_irqsave(lock, flag);
 
@@ -929,9 +953,9 @@ static void avc_flush(void)
 	unsigned long flag;
 	int i;
 
-	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
-		head = &selinux_avc.avc_cache.slots[i];
-		lock = &selinux_avc.avc_cache.slots_lock[i];
+	for (i = 0; i < avc_cache_slots; i++) {
+		head = &selinux_avc.avc_cache.slots[i].slot;
+		lock = &selinux_avc.avc_cache.slots[i].slot_lock;
 
 		spin_lock_irqsave(lock, flag);
 		/*
-- 
2.43.0

