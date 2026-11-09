Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238710;
	b=UavDR/5Dgbo+a717ON1fhWLjHk8a+LV6+jsGGJ/HOShE4g5fkPFqk6iwR6rKjc2UuPhb
	 I5jiw1qnoNG2sjT/sqWaQui4z99Rg0b/RcgsweHdNvNCzSwTXQpKPJWcndD/ck4OoRX4V
	 04S8nvVCfrFcK1j/vtKYdfsoDu25ZiWsxqbMOHDWCjMDeHAtl/69XPchn8TDgMYXWd/Ci
	 Rscxdl1DB3ZBqvDjNF5Z0ic9RBnke9avc6vKRXvJ77KWluNmxo3NZs7ouaJ2wHxP/6swI
	 kSAw8LTp8LjTyripLapS8nBbWtAzTtggTLhoXZwPUrQHkLhWIvhekW+Z0fSOBT3aSoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238710;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=iIqlmoH3itkyMm0RKt5dXtlPabQmxQmE4oAJqOyY7HM=;
	b=1zF6Syxzz/AK4QbdxTTsfTqnwLwAlWIn6zEvJWfaBHK6tEdxWjAGkQ9xcavZzwYfJLxW
	 5ttJeoYVI3mrVVUz4ByK6Ik2bVz4qzQ3GD7jGzIc4wGGDKhYj9RYZXacNt8ZD4mhCid9e
	 FEADmnI6rGIO2+OwwwbsqUmbPN8hztehK0hDbHAFhXADTwHVBpvS4yCjZTzglZcxQmgKo
	 zWfdjDuaHhW/EV8xRjS44FBPbrRsSOIXw8B/VnB+Hiz+1DMbnn2ScFgvJLX+kXBSrcO4h
	 bLRRgI0//guZTd3LKcqfJtvvjOckLFjDBHQhzFyi6fW85BKzuZ81KVOjpfaz5Mqa4wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=jIQGbOjp;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1E9606A326
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 15:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB1E9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=jIQGbOjp
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1794238700;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIqlmoH3itkyMm0RKt5dXtlPabQmxQmE4oAJqOyY7HM=;
	b=jIQGbOjpE43BdStXRL4aH4fMNyp8JL8Nae+Jn54wwVeDGGZSuWGOzi7X926T1rXHbAAIpk
	LcIT3gCdwTV0fQvgOe9QefTselAvx39pXyy3f2be/UqL2jdAYaJjts2UBDeNgmE5TTEmmx
	zHVUL3uTXpEKCp+cG91sNVnzIjFRh4iRVBEvUIBN+WRtueRjMtErxnyYGCgyJf62PnMnBv
	vpO2xP4RWsi0zHOpU+ZZdXdLihXL534acq8gQdqrEjR1XM4OgqQ5K+hoQEwwZtc3ON4A0s
	zwh3I09qGvFef01xMmxnMebVU7ZB1ZH2Y9SkSIKVLa6+tyekND7S0+GVkVoMqg==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 3/5] selinux: prevent stale AVC insertions after policy changes
Date: Mon,  9 Nov 2026 16:37:59 +0100
Message-ID: <20261109153802.76176-2-cgoettsche@seltendoof.de>
In-Reply-To: <20261109153802.76176-1-cgoettsche@seltendoof.de>
References: <20261109153802.76176-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

A cache miss can compute a decision under the old policy and pass the
latest_notif check in avc_insert(), then be delayed until after a policy
change has flushed the AVC and updated latest_notif.  Inserting the old
decision at that point allows subsequent cache hits to keep using the
old permissions, including permissions revoked by the new policy.

Keep security_compute_av() and avc_insert() in one RCU read-side
critical section.  Both selinux_policy_commit() and security_set_bools()
publish the new policy and wait for an RCU grace period before flushing
the AVC.  This ensures that insertions based on the old policy finish
before the flush.  The sequence-number check alone cannot provide that
guarantee, even when it takes the notification lock.

The insertion path uses nonblocking allocations and already runs under
RCU when called from avc_has_extended_perms(), where the new read-side
critical section simply nests within the existing one.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com> (code wise,
  inline comments updated in v2)
---
v2:
  - document the grace period ordering requirement at the
    synchronize_rcu() call sites in selinux_policy_commit() and
    security_set_bools()
---
 security/selinux/avc.c         | 7 +++++++
 security/selinux/ss/services.c | 9 +++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 2a9d4888384b..6dcb4b354d7c 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -993,8 +993,15 @@ static noinline void avc_compute_av(u32 ssid, u32 tsid, u16 tclass,
 				    struct avc_xperms_node *xp_node)
 {
 	INIT_LIST_HEAD(&xp_node->xpd_head);
+	/*
+	 * Compute and insert under one RCU read lock: policy changes wait
+	 * for a grace period before flushing the AVC, so a decision based
+	 * on the old policy cannot be inserted after the flush.
+	 */
+	rcu_read_lock();
 	security_compute_av(ssid, tsid, tclass, avd, &xp_node->xp);
 	avc_insert(ssid, tsid, tclass, avd, xp_node);
+	rcu_read_unlock();
 }
 
 static noinline int avc_denied(u32 ssid, u32 tsid, u16 tclass, u32 requested,
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index b1987367e8b0..79b24500ca7b 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2288,7 +2288,10 @@ void selinux_policy_commit(struct selinux_load_state *load_state)
 		selinux_complete_init();
 	}
 
-	/* Free the old policy */
+	/*
+	 * Free the old policy.  The grace period must also precede the AVC
+	 * flush (see avc_compute_av()); do not convert to call_rcu().
+	 */
 	synchronize_rcu();
 	selinux_policy_free(oldpolicy);
 	kfree(load_state->convert_data);
@@ -3037,7 +3040,9 @@ int security_set_bools(u32 len, const int *values)
 	/*
 	 * Free the conditional portions of the old policydb
 	 * that were copied for the new policy, and the oldpolicy
-	 * structure itself but not what it references.
+	 * structure itself but not what it references.  The grace
+	 * period must also precede the AVC flush (see avc_compute_av());
+	 * do not convert to call_rcu().
 	 */
 	synchronize_rcu();
 	selinux_policy_cond_free(oldpolicy);
-- 
2.55.0

