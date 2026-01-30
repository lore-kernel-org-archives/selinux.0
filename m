Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F3C330658
	for <selinux@vger.kernel.org>; Fri, 30 Jan 2026 18:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769796186; cv=none; b=UHP5VgzvTWsJgJIpAvAExE67sHYkW9TuA1W92RsuTm0hW5+8qhbaPyQX4JPQ7Q8wZVjT3vcKEBcUQBRLrqv/z0qJmZlTScyYhlvxiCpVY29/OyzXxnIlTD54QWZsq1hG14SPCfoydOCRAobbzA2DmSHGSvhKwCt7aljzFIBfOBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769796186; c=relaxed/simple;
	bh=AugqtcNWnDI6swN/JWmn4NrpNr8G1m3opBVJ6O9xyJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d1RpckhUJqlce/uDlPpg00JfxHVvA0CDBcWPfQVz6wDn+fLlJYWIZixJvaKLseQiIS/KG4x8YeJWxlU628l+5bwhHMiw79Jd5cp+pR2SubQCnbK5C0i+BBpisuTXJsQr1leZR+/SzyIOUsBX28OrqKcj/IxEpheTHgkJ5D0LRaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDPKG8J6; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDPKG8J6"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-894674a4c4aso44539876d6.3
        for <selinux@vger.kernel.org>; Fri, 30 Jan 2026 10:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769796182; x=1770400982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k/fIvHWiQtX1mPMXx6xuxXbcnt5Id7Aga0ulit6pLus=;
        b=FDPKG8J6pq3xDb/fxktn2ZPSY0UFdjgoQBK6z6CNSEZ4BhlYgQ5cpk0HYl8P0gzwnu
         wnmU12p1GxAAig20cQg8m0a5m11Pn4A7tHo8CrQ6kX/MLAu1W/0BKsQOG7DWSnysvOLM
         Ia1MVW+qH1LfKTSqfIzqKl/5DRpW5Xz6Y8fUZHen7frDOY9kJydi3Iuq5Xy2FVCFppoT
         fHAXzD8QW0PpMa8ictKrdG5FX4DDZSMcJQO+HqLpCBQGh1QGyViacEWI6HCBZP75iuMb
         16mwmAWcEAS+kb9jrPpI1SgwYX0IAb2G5BqzsIyeL4fweZpdgMr40z8BMSADag9kwRkI
         9gfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769796182; x=1770400982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/fIvHWiQtX1mPMXx6xuxXbcnt5Id7Aga0ulit6pLus=;
        b=MfQGW27L9fosYyAoVMVxtZ1wCI1Q5fvRnT2s+V+gCSLenOfzO4rvlCgysMpxHc22F2
         U0foXTGY1Yj9yvnJFn93rdnDNuk4NOQc7B2+fjY/m7dhHjkz5HDbv/9BF/dL8kNyEIcG
         0RQTn9DM+DUuta/gokLCQxL2wyF3h5+OHrl+FOD8BL/mNhlYbQ0QiPg6pwpvBOPwpD0x
         NpYhhqTIGp21c6M3CNAWFkcLWRkU3LYf52o4Kjm0Fb571SZD5OJk7xJoO/APxLpWjYyY
         PyaneUXHbVd7rEtOeANhExFri17FQ9kObgOQBewGpWbWlK1jxa8zWEzEXa+NDiXAGuJP
         Umbg==
X-Gm-Message-State: AOJu0YwVHiY9UdeWbsQOrfSGJcxjFYbmfaUVfXuuwljugCclZmsmCXKG
	WFNJ7XkqV0KqUkS/9kBd4te2NcU9BHVWKcyuQe4OroCrhp0uPbmkVRavXjBtN0RT
X-Gm-Gg: AZuq6aJF3E39QvZYWiPchyumK5IWiM59kGXDVwGayxkEGEGgQ0gd+qy4EsMJNbZ13jb
	3WzkmxTdOuYKpbpzyWjYoYTx4GZ0WmkUGUXr1+7tT36SXCkrG1WWlrbzIFOHPrmEBe8h/n8q6IT
	aLK7Jo/NWhCCwlCJn13jdvhWZdZuyLRofrcBXvfBx04wDYBH04bz+YXKvEG25/d6jphLBdR9ImA
	inxgiL9WJ8qn7ihoVUUNxMZKh2/BXYnoYFCoWTWLqgwNZxWyT5QcB9ObN7O1GmBeDLBDzRySLNF
	BsciDQpgCuawpKUOydpp/cD5/xjgbOQ7Vv+fdaUdn4T5Q6J/9ZqNaRBB2fqmaAne/nRXBFzchF7
	naSVkZPVd7ILT7k9kbDDa9P3A57xzuSNqsdisfgpVgNgagUyHvcB+hFamT6k72Awgb8Ppbj3Z+a
	J/ftgrRbXpxH27Cj9GPGptShqWkLDyGpamRV2DTsNX+iKophA7GliClNOISGLcn6yQhziQVDXtX
	Zut0an5qYDgp/+d
X-Received: by 2002:a05:6214:27ec:b0:894:7143:3f25 with SMTP id 6a1803df08f44-894e9f92d7cmr58196466d6.11.1769796181435;
        Fri, 30 Jan 2026 10:03:01 -0800 (PST)
Received: from localhost (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36a5ca2sm62678086d6.7.2026.01.30.10.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 10:03:00 -0800 (PST)
From: danieldurning.work@gmail.com
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com
Subject: [RFC PATCH v2 selinuxns] selinux: optimize context string handling and global sidtab
Date: Fri, 30 Jan 2026 17:59:31 +0000
Message-ID: <20260130175931.2054-1-danieldurning.work@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Durning <danieldurning.work@gmail.com>

Changed context structs to always hold the context string.
Context strings must always be held in the global sidtab anyway, so this
avoids needing to frequently allocate and free the context strings.
Context validity is now determined by the user field being set rather
than the string field being empty. Removed sid2str cache since context
strings no longer have to be generated at runtime. Removed unnecessary
string copies in the global sidtab, and updated callers to avoid freeing
context strings. This makes accessing contexts quicker at runtime at
the cost of some additional memory overhead.

KASAN and kmemleak were used to ensure that the patch did not introduce
any double-frees or memory leaks.

Performance data was collected to measure both the performance gain and
memory usage increase.

We used the following command to test runtime for an operation involving
heavy use of security contexts. Other performance measurements like
kcbench showed virtually no change in runtime. This command accesses
file contexts many times, calling the relevant functions to
produce/retrieve context strings.

perf stat setfiles -n /etc/selinux/targeted/contexts/files/file_contexts /

The command was run 5 times and the results were averaged.

Without Patch:

Average Cycles: 7352390645.6
Average Seconds (Sys): 0.9041048

With Patch:

Average Cycles: 7183282892.4
Average Seconds (Sys): 0.8739688

The command ran ~3.45% faster (in terms of sys seconds) and used ~2.35%
less cycles on average with the patch than without.

We added some additional code to the sidtab_hash_stats() function to
print the total length of all cached context strings and measure memory
overhead.

Without Patch:

entries: 386
context length (rounded): 0 (bytes)

With Patch:

entries: 386
context length (rounded): 22336 (bytes)

The patch used ~22 kb of additional memory.

Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
---
V2: Improved const correctness and added rcu read locks to guard context
strings pulled from security_sid_to_context().
---
 include/trace/events/avc.h            |   4 +-
 security/selinux/Kconfig              |  11 -
 security/selinux/avc.c                |  10 +-
 security/selinux/global_sidtab.c      |  97 +++++---
 security/selinux/hooks.c              | 133 ++++++++---
 security/selinux/include/context.h    |  19 +-
 security/selinux/include/security.h   |  16 +-
 security/selinux/include/selinux_ss.h |   6 +-
 security/selinux/include/sidtab.h     |  29 ---
 security/selinux/selinuxfs.c          |  70 ++++--
 security/selinux/ss/context.c         |  14 +-
 security/selinux/ss/policydb.c        |  10 +-
 security/selinux/ss/services.c        | 330 ++++++++++----------------
 security/selinux/ss/services.h        |   5 +
 security/selinux/ss/sidtab.c          | 101 +-------
 security/selinux/xfrm.c               |   7 +-
 16 files changed, 383 insertions(+), 479 deletions(-)

diff --git a/include/trace/events/avc.h b/include/trace/events/avc.h
index fed0f141d5f6..297a9ba07982 100644
--- a/include/trace/events/avc.h
+++ b/include/trace/events/avc.h
@@ -14,8 +14,8 @@
 TRACE_EVENT(selinux_audited,
 
 	TP_PROTO(struct selinux_audit_data *sad,
-		char *scontext,
-		char *tcontext,
+		const char *scontext,
+		const char *tcontext,
 		const char *tclass
 	),
 
diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 76d12be7bab6..e26ad833183b 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -58,17 +58,6 @@ config SECURITY_SELINUX_SIDTAB_HASH_BITS
 	  chain lengths are high (e.g. > 20) then selecting a higher value here
 	  will ensure that lookups times are short and stable.
 
-config SECURITY_SELINUX_SID2STR_CACHE_SIZE
-	int "SELinux SID to context string translation cache size"
-	depends on SECURITY_SELINUX
-	default 256
-	help
-	  This option defines the size of the internal SID -> context string
-	  cache, which improves the performance of context to string
-	  conversion.  Setting this option to 0 disables the cache completely.
-
-	  If unsure, keep the default value.
-
 config SECURITY_SELINUX_AVC_HASH_BITS
 	int "SELinux avc hashtable size"
 	depends on SECURITY_SELINUX
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 5e3d1e2ed457..21c46b0de647 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -716,13 +716,14 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
 {
 	struct common_audit_data *ad = a;
 	struct selinux_audit_data *sad = ad->selinux_audit_data;
-	char *scontext = NULL;
-	char *tcontext = NULL;
+	const char *scontext = NULL;
+	const char *tcontext = NULL;
 	const char *tclass = NULL;
 	u32 scontext_len;
 	u32 tcontext_len;
 	int rc;
 
+	rcu_read_lock();
 	rc = security_sid_to_context(sad->state, sad->ssid, &scontext,
 				     &scontext_len);
 	if (rc)
@@ -744,8 +745,6 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
 		audit_log_format(ab, " permissive=%u", sad->result ? 0 : 1);
 
 	trace_selinux_audited(sad, scontext, tcontext, tclass);
-	kfree(tcontext);
-	kfree(scontext);
 
 	/* in case of invalid context report also the actual context string */
 	rc = security_sid_to_context_inval(sad->state, sad->ssid, &scontext,
@@ -755,7 +754,6 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
 			scontext_len--;
 		audit_log_format(ab, " srawcon=");
 		audit_log_n_untrustedstring(ab, scontext, scontext_len);
-		kfree(scontext);
 	}
 
 	rc = security_sid_to_context_inval(sad->state, sad->tsid, &scontext,
@@ -765,8 +763,8 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
 			scontext_len--;
 		audit_log_format(ab, " trawcon=");
 		audit_log_n_untrustedstring(ab, scontext, scontext_len);
-		kfree(scontext);
 	}
+	rcu_read_unlock();
 }
 
 /*
diff --git a/security/selinux/global_sidtab.c b/security/selinux/global_sidtab.c
index e1acf6607788..de8f8ed38bae 100644
--- a/security/selinux/global_sidtab.c
+++ b/security/selinux/global_sidtab.c
@@ -30,7 +30,7 @@ int global_sidtab_init(void)
 		 */
 		if (sid == SECINITSID_INIT)
 			str = "kernel";
-		ctx.str = (char *)str;
+		ctx.str = str;
 		ctx.len = strlen(str)+1;
 		rc = sidtab_set_initial(&global_sidtab, sid, &ctx);
 		if (rc)
@@ -40,7 +40,7 @@ int global_sidtab_init(void)
 	return 0;
 }
 
-static int global_sid_to_context(u32 sid, char **scontext, u32 *scontext_len)
+static int global_sid_to_context(u32 sid, const char **scontext, u32 *scontext_len)
 {
 	struct context *ctx;
 
@@ -53,19 +53,7 @@ static int global_sid_to_context(u32 sid, char **scontext, u32 *scontext_len)
 		return -EINVAL;
 	}
 	*scontext_len = ctx->len;
-	/*
-	 * Could eliminate allocation + copy if callers do not free
-	 * since the global sidtab entries are never freed.
-	 * This however would not match the current expectation
-	 * of callers of security_sid_to_context().
-	 * TODO: Update all callers and get rid of this copy.
-	 */
-	*scontext = kstrdup(ctx->str, GFP_ATOMIC);
-	if (!(*scontext)) {
-		rcu_read_unlock();
-		*scontext_len = 0;
-		return -ENOMEM;
-	}
+	*scontext = ctx->str;
 
 	rcu_read_unlock();
 	return 0;
@@ -117,7 +105,7 @@ static int map_global_sid_to_ss(struct selinux_state *state, u32 sid,
 {
 	struct sidtab_entry *entry;
 	int rc;
-	char *scontext;
+	const char *scontext;
 	u32 scontext_len;
 #if CONFIG_SECURITY_SELINUX_SS_SID_CACHE_SIZE > 0
 	struct sidtab_ss_sid_cache *cache;
@@ -197,7 +185,6 @@ static int map_global_sid_to_ss(struct selinux_state *state, u32 sid,
 		spin_unlock_irqrestore(&global_sidtab.lock, flags);
 	}
 #endif
-	kfree(scontext);
 	return rc;
 }
 
@@ -209,7 +196,7 @@ void global_sidtab_invalidate_state(struct selinux_state *state)
 static int map_ss_sid_to_global(struct selinux_state *state, u32 ss_sid,
 				u32 *out_sid, gfp_t gfp)
 {
-	char *scontext;
+	const char *scontext;
 	u32 scontext_len;
 	int rc;
 
@@ -218,19 +205,21 @@ static int map_ss_sid_to_global(struct selinux_state *state, u32 ss_sid,
 		return 0;
 	}
 
+	rcu_read_lock();
 	rc = selinux_ss_sid_to_context_force(state, ss_sid, &scontext,
 					     &scontext_len);
 	if (rc)
-		return rc;
+		goto out;
 
 	rc = global_context_to_sid(state, ss_sid, scontext, scontext_len,
 				   out_sid, GFP_ATOMIC);
-	kfree(scontext);
+out:
+	rcu_read_unlock();
 	return rc;
 }
 
 int security_sid_to_context(struct selinux_state *state, u32 sid,
-			    char **scontext, u32 *scontext_len)
+			    const char **scontext, u32 *scontext_len)
 {
 	// initial SID contexts have to be obtained from the policy, if initialized
 	if (sid <= SECINITSID_NUM && selinux_initialized(state))
@@ -240,7 +229,7 @@ int security_sid_to_context(struct selinux_state *state, u32 sid,
 }
 
 int security_sid_to_context_valid(struct selinux_state *state, u32 sid,
-			    char **scontext, u32 *scontext_len)
+			    const char **scontext, u32 *scontext_len)
 {
 	int rc;
 	u32 ss_sid;
@@ -258,7 +247,7 @@ int security_sid_to_context_valid(struct selinux_state *state, u32 sid,
 }
 
 int security_sid_to_context_force(struct selinux_state *state, u32 sid,
-				  char **scontext, u32 *scontext_len)
+				  const char **scontext, u32 *scontext_len)
 {
 	// initial SID contexts have to be obtained from the policy, if initialized
 	if (sid <= SECINITSID_NUM && selinux_initialized(state))
@@ -268,7 +257,7 @@ int security_sid_to_context_force(struct selinux_state *state, u32 sid,
 }
 
 int security_sid_to_context_inval(struct selinux_state *state, u32 sid,
-				  char **scontext, u32 *scontext_len)
+				  const char **scontext, u32 *scontext_len)
 {
 	int rc;
 	u32 ss_sid;
@@ -290,7 +279,8 @@ int security_context_to_sid(struct selinux_state *state, const char *scontext,
 {
 	int rc;
 	u32 sid, ss_sid = 0;
-	char *ctx = NULL;
+	const char *ctx = NULL;
+	bool alloc = false;
 
 	/*
 	 * If initialized, validate and canonicalize the context against
@@ -302,11 +292,18 @@ int security_context_to_sid(struct selinux_state *state, const char *scontext,
 		if (rc)
 			return rc;
 
+		rcu_read_lock();
 		rc = selinux_ss_sid_to_context(state, ss_sid, &ctx,
 					       &scontext_len);
 		if (rc)
-			return rc;
-		scontext = ctx;
+			goto err_unlock;
+		scontext = kmemdup(ctx, scontext_len, GFP_ATOMIC);
+		if (!scontext) {
+			rc = -ENOMEM;
+			goto err_unlock;
+		}
+		alloc = true;
+		rcu_read_unlock();
 	}
 
 	// allocate or lookup a SID in the global SID table
@@ -318,7 +315,11 @@ int security_context_to_sid(struct selinux_state *state, const char *scontext,
 	*out_sid = sid;
 
 out:
-	kfree(ctx);
+	if (alloc)
+		kfree(scontext);
+	return rc;
+err_unlock:
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -337,7 +338,8 @@ int security_context_to_sid_default(struct selinux_state *state,
 {
 	int rc;
 	u32 sid, ss_sid = 0;
-	char *ctx = NULL;
+	const char *ctx = NULL;
+	bool alloc = false;
 
 	/*
 	 * If initialized, validate and canonicalize the context against
@@ -350,11 +352,18 @@ int security_context_to_sid_default(struct selinux_state *state,
 		if (rc)
 			return rc;
 
+		rcu_read_lock();
 		rc = selinux_ss_sid_to_context(state, ss_sid, &ctx,
 					       &scontext_len);
 		if (rc)
-			return rc;
-		scontext = ctx;
+			goto err_unlock;
+		scontext = kmemdup(ctx, scontext_len, GFP_ATOMIC);
+		if (!scontext) {
+			rc = -ENOMEM;
+			goto err_unlock;
+		}
+		alloc = true;
+		rcu_read_unlock();
 	}
 
 	// allocate or lookup a SID in the global SID table
@@ -366,7 +375,11 @@ int security_context_to_sid_default(struct selinux_state *state,
 	*out_sid = sid;
 
 out:
-	kfree(ctx);
+	if (alloc)
+		kfree(scontext);
+	return rc;
+err_unlock:
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -376,7 +389,8 @@ int security_context_to_sid_force(struct selinux_state *state,
 {
 	int rc;
 	u32 sid, ss_sid = 0;
-	char *ctx = NULL;
+	const char *ctx = NULL;
+	bool alloc = false;
 
 	/*
 	 * If initialized, validate and canonicalize the context against
@@ -389,11 +403,18 @@ int security_context_to_sid_force(struct selinux_state *state,
 		if (rc)
 			return rc;
 
+		rcu_read_lock();
 		rc = selinux_ss_sid_to_context_force(state, ss_sid, &ctx,
 						     &scontext_len);
 		if (rc)
-			return rc;
-		scontext = ctx;
+			goto err_unlock;
+		scontext = kmemdup(ctx, scontext_len, GFP_ATOMIC);
+		if (!scontext) {
+			rc = -ENOMEM;
+			goto err_unlock;
+		}
+		alloc = true;
+		rcu_read_unlock();
 	}
 
 	// allocate or lookup a SID in the global SID table
@@ -405,7 +426,11 @@ int security_context_to_sid_force(struct selinux_state *state,
 	*out_sid = sid;
 
 out:
-	kfree(ctx);
+	if (alloc)
+		kfree(scontext);
+	return rc;
+err_unlock:
+	rcu_read_unlock();
 	return rc;
 }
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 442c5c1b477f..3ed557beb379 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1071,10 +1071,11 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 
 static int show_sid(struct seq_file *m, u32 sid)
 {
-	char *context = NULL;
+	const char *context = NULL;
 	u32 len;
 	int rc;
 
+	rcu_read_lock();
 	rc = security_sid_to_context(current_selinux_state, sid,
 					     &context, &len);
 	if (!rc) {
@@ -1087,7 +1088,7 @@ static int show_sid(struct seq_file *m, u32 sid)
 		if (has_comma)
 			seq_putc(m, '\"');
 	}
-	kfree(context);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -2953,6 +2954,7 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
 {
 	u32 newsid;
 	int rc;
+	const char *ctx;
 
 	rc = selinux_determine_inode_label(selinux_cred(current_cred()),
 					   d_inode(dentry->d_parent), name,
@@ -2965,8 +2967,19 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
 		*xattr_name = XATTR_NAME_SELINUX;
 
 	cp->id = LSM_ID_SELINUX;
-	return security_sid_to_context(current_selinux_state, newsid,
-				       &cp->context, &cp->len);
+	rcu_read_lock();
+	rc = security_sid_to_context(current_selinux_state, newsid,
+				       &ctx, &cp->len);
+	if (rc)
+		goto out_unlock;
+
+	cp->context = kmemdup(ctx, cp->len, GFP_ATOMIC);
+	if (!cp->context)
+		rc = ENOMEM;
+
+out_unlock:
+	rcu_read_unlock();
+	return rc;
 }
 
 static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
@@ -3000,7 +3013,8 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	u32 newsid, clen;
 	u16 newsclass;
 	int rc;
-	char *context;
+	const char *context;
+	char *value;
 
 	sbsec = selinux_superblock(dir->i_sb);
 
@@ -3022,17 +3036,27 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	    !selinux_is_sblabel_mnt(dir->i_sb))
 		return -EOPNOTSUPP;
 
+	rcu_read_lock();
 	if (xattr) {
 		rc = security_sid_to_context_force(current_selinux_state, newsid,
 						   &context, &clen);
 		if (rc)
-			return rc;
-		xattr->value = context;
+			goto out_unlock;
+
+		value = kmemdup(context, clen, GFP_ATOMIC);
+		if (!(value)) {
+			rc = -ENOMEM;
+			goto out_unlock;
+		}
+
+		xattr->value = value;
 		xattr->value_len = clen;
 		xattr->name = XATTR_SELINUX_SUFFIX;
 	}
 
-	return 0;
+out_unlock:
+	rcu_read_unlock();
+	return rc;
 }
 
 static int selinux_inode_init_security_anon(struct inode *inode,
@@ -3676,7 +3700,7 @@ static int selinux_inode_getsecurity(struct mnt_idmap *idmap,
 {
 	u32 size;
 	int error;
-	char *context = NULL;
+	const char *context = NULL;
 	struct inode_security_struct *isec;
 
 	/*
@@ -3697,6 +3721,7 @@ static int selinux_inode_getsecurity(struct mnt_idmap *idmap,
 	 * in-core context value, not a denial.
 	 */
 	isec = inode_security(inode);
+	rcu_read_lock();
 	if (has_cap_mac_admin(false))
 		error = security_sid_to_context_force(current_selinux_state,
 						      isec->sid, &context,
@@ -3705,14 +3730,16 @@ static int selinux_inode_getsecurity(struct mnt_idmap *idmap,
 		error = security_sid_to_context_valid(current_selinux_state, isec->sid,
 						&context, &size);
 	if (error)
-		return error;
+		goto out_unlock;
 	error = size;
 	if (alloc) {
-		*buffer = context;
-		goto out_nofree;
+		*buffer = kmemdup(context, size, GFP_ATOMIC);
+		if (!(*buffer))
+			error = -ENOMEM;
 	}
-	kfree(context);
-out_nofree:
+
+out_unlock:
+	rcu_read_unlock();
 	return error;
 }
 
@@ -3810,6 +3837,7 @@ static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
 	u32 parent_sid, newsid, clen;
 	int rc;
 	char *context;
+	const char *context2;
 
 	rc = kernfs_xattr_get(kn_dir, XATTR_NAME_SELINUX, NULL, 0);
 	if (rc == -ENODATA)
@@ -3828,9 +3856,13 @@ static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
 		return rc;
 	}
 
-	rc = security_context_to_sid(current_selinux_state, context, clen,
+	context2 = kmemdup(context, clen, GFP_KERNEL);
+	if (!context2)
+		return -ENOMEM;
+	rc = security_context_to_sid(current_selinux_state, context2, clen,
 				     &parent_sid, GFP_KERNEL);
 	kfree(context);
+	kfree(context2);
 	if (rc) {
 		if (rc == -EINVAL &&
 			current_selinux_state != init_selinux_state) {
@@ -3858,15 +3890,27 @@ static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
 			return rc;
 	}
 
+	rcu_read_lock();
 	rc = security_sid_to_context_force(current_selinux_state, newsid,
-					   &context, &clen);
+					   &context2, &clen);
 	if (rc)
-		return rc;
+		goto err_unlock;
+
+	context = kmemdup(context2, clen, GFP_ATOMIC);
+	if (!context2) {
+		rc = -ENOMEM;
+		goto err_unlock;
+	}
+	rcu_read_unlock();
 
 	rc = kernfs_xattr_set(kn, XATTR_NAME_SELINUX, context, clen,
 			      XATTR_CREATE);
 	kfree(context);
 	return rc;
+
+err_unlock:
+	rcu_read_unlock();
+	return rc;
 }
 
 
@@ -5528,7 +5572,8 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
 					    unsigned int len)
 {
 	int err = 0;
-	char *scontext = NULL;
+	const char *scontext = NULL;
+	char *scontext2;
 	u32 scontext_len;
 	struct sk_security_struct *sksec = selinux_sock(sock->sk);
 	u32 peer_sid = SECSID_NULL;
@@ -5540,21 +5585,31 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
 	if (peer_sid == SECSID_NULL)
 		return -ENOPROTOOPT;
 
+	rcu_read_lock();
 	err = security_sid_to_context(current_selinux_state, peer_sid, &scontext,
 				      &scontext_len);
 	if (err)
-		return err;
+		goto err_unlock;
+	scontext2 = kmemdup(scontext, scontext_len, GFP_ATOMIC);
+	if (!scontext2) {
+		err = -ENOMEM;
+		goto err_unlock;
+	}
+	rcu_read_unlock();
 	if (scontext_len > len) {
 		err = -ERANGE;
 		goto out_len;
 	}
 
-	if (copy_to_sockptr(optval, scontext, scontext_len))
+	if (copy_to_sockptr(optval, scontext2, scontext_len))
 		err = -EFAULT;
 out_len:
+	kfree(scontext2);
 	if (copy_to_sockptr(optlen, &scontext_len, sizeof(scontext_len)))
 		err = -EFAULT;
-	kfree(scontext);
+	return err;
+err_unlock:
+	rcu_read_unlock();
 	return err;
 }
 
@@ -6744,6 +6799,7 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 			       char **value)
 {
 	const struct cred_security_struct *crsec;
+	const char *ctx;
 	int error;
 	u32 sid;
 	u32 len;
@@ -6792,17 +6848,20 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 		error = -EOPNOTSUPP;
 		goto err_unlock;
 	}
-	rcu_read_unlock();
 
 	if (sid == SECSID_NULL) {
 		*value = NULL;
-		return 0;
+		goto err_unlock;
 	}
 
-	error = security_sid_to_context(current_selinux_state, sid, value, &len);
+	error = security_sid_to_context(current_selinux_state, sid, &ctx, &len);
 	if (error)
-		return error;
-	return len;
+		goto err_unlock;
+	*value = kmemdup(ctx, len, GFP_ATOMIC);
+	if (!*value)
+		error = -ENOMEM;
+	else
+		error = len;
 
 err_unlock:
 	rcu_read_unlock();
@@ -7056,13 +7115,19 @@ static int selinux_secid_to_secctx(u32 secid, struct lsm_context *cp)
 {
 	u32 seclen;
 	int ret;
+	const char *ctx;
 
 	if (cp) {
+		rcu_read_lock();
 		cp->id = LSM_ID_SELINUX;
 		ret = security_sid_to_context(current_selinux_state, secid,
-					      &cp->context, &cp->len);
+					      &ctx, &cp->len);
 		if (ret < 0)
-			return ret;
+			goto err_unlock;
+		cp->context = kmemdup(ctx, cp->len, GFP_ATOMIC);
+		rcu_read_unlock();
+		if (!cp->context)
+			return -ENOMEM;
 		return cp->len;
 	}
 	ret = security_sid_to_context(current_selinux_state, secid, NULL,
@@ -7070,6 +7135,10 @@ static int selinux_secid_to_secctx(u32 secid, struct lsm_context *cp)
 	if (ret < 0)
 		return ret;
 	return seclen;
+
+err_unlock:
+	rcu_read_unlock();
+	return ret;
 }
 
 static int selinux_lsmprop_to_secctx(struct lsm_prop *prop,
@@ -7198,15 +7267,19 @@ static int selinux_key_permission(key_ref_t key_ref,
 static int selinux_key_getsecurity(struct key *key, char **_buffer)
 {
 	struct key_security_struct *ksec = selinux_key(key);
-	char *context = NULL;
+	const char *context = NULL;
 	unsigned len;
 	int rc;
 
+	rcu_read_lock();
 	rc = security_sid_to_context(current_selinux_state, ksec->sid,
 				     &context, &len);
 	if (!rc)
 		rc = len;
-	*_buffer = context;
+	*_buffer = kmemdup(context, len, GFP_ATOMIC);
+	rcu_read_unlock();
+	if (!(*_buffer))
+		return -ENOMEM;
 	return rc;
 }
 
diff --git a/security/selinux/include/context.h b/security/selinux/include/context.h
index dd3b9b5b588e..0e8d34a26ea1 100644
--- a/security/selinux/include/context.h
+++ b/security/selinux/include/context.h
@@ -31,7 +31,7 @@ struct context {
 	u32 type;
 	u32 len; /* length of string in bytes */
 	struct mls_range range;
-	char *str; /* string representation if context cannot be mapped. */
+	const char *str; /* string representation */
 };
 
 static inline void mls_context_init(struct context *c)
@@ -160,15 +160,10 @@ static inline int context_cpy(struct context *dst, const struct context *src)
 	dst->user = src->user;
 	dst->role = src->role;
 	dst->type = src->type;
-	if (src->str) {
-		dst->str = kstrdup(src->str, GFP_ATOMIC);
-		if (!dst->str)
-			return -ENOMEM;
-		dst->len = src->len;
-	} else {
-		dst->str = NULL;
-		dst->len = 0;
-	}
+	dst->str = kstrdup(src->str, GFP_ATOMIC);
+	if (!dst->str)
+		return -ENOMEM;
+	dst->len = src->len;
 	rc = mls_context_cpy(dst, src);
 	if (rc) {
 		kfree(dst->str);
@@ -191,9 +186,9 @@ static inline void context_destroy(struct context *c)
 static inline bool context_equal(const struct context *c1,
 				 const struct context *c2)
 {
-	if (c1->len && c2->len)
+	if (!c1->user && !c2->user)
 		return (c1->len == c2->len && !strcmp(c1->str, c2->str));
-	if (c1->len || c2->len)
+	if (!c1->user || !c2->user)
 		return 0;
 	return ((c1->user == c2->user) && (c1->role == c2->role) &&
 		(c1->type == c2->type) && mls_context_equal(c1, c2));
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 5864cd1b9039..86be62fc814b 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -355,16 +355,16 @@ int security_transition_sid(struct selinux_state *state, u32 ssid, u32 tsid,
 			    u16 tclass, const struct qstr *qstr, u32 *out_sid);
 
 int security_sid_to_context(struct selinux_state *state, u32 sid,
-			    char **scontext, u32 *scontext_len);
+			    const char **scontext, u32 *scontext_len);
 
 int security_sid_to_context_valid(struct selinux_state *state, u32 sid,
-				  char **scontext, u32 *scontext_len);
+				  const char **scontext, u32 *scontext_len);
 
 int security_sid_to_context_force(struct selinux_state *state, u32 sid,
-				  char **scontext, u32 *scontext_len);
+				  const char **scontext, u32 *scontext_len);
 
 int security_sid_to_context_inval(struct selinux_state *state, u32 sid,
-				  char **scontext, u32 *scontext_len);
+				  const char **scontext, u32 *scontext_len);
 
 int security_context_to_sid(struct selinux_state *state, const char *scontext,
 			    u32 scontext_len, u32 *out_sid, gfp_t gfp);
@@ -437,20 +437,20 @@ static inline int security_transition_sid(struct selinux_state *state, u32 ssid,
 }
 
 static inline int security_sid_to_context(struct selinux_state *state, u32 sid,
-					  char **scontext, u32 *scontext_len)
+					  const char **scontext, u32 *scontext_len)
 {
 	return selinux_ss_sid_to_context(state, sid, scontext, scontext_len);
 }
 
 static inline int security_sid_to_context_valid(struct selinux_state *state,
-						u32 sid, char **scontext,
+						u32 sid, const char **scontext,
 						u32 *scontext_len)
 {
 	return selinux_ss_sid_to_context(state, sid, scontext, scontext_len);
 }
 
 static inline int security_sid_to_context_force(struct selinux_state *state,
-						u32 sid, char **scontext,
+						u32 sid, const char **scontext,
 						u32 *scontext_len)
 {
 	return selinux_ss_sid_to_context_force(state, sid, scontext,
@@ -458,7 +458,7 @@ static inline int security_sid_to_context_force(struct selinux_state *state,
 }
 
 static inline int security_sid_to_context_inval(struct selinux_state *state,
-						u32 sid, char **scontext,
+						u32 sid, const char **scontext,
 						u32 *scontext_len)
 {
 	return selinux_ss_sid_to_context_inval(state, sid, scontext,
diff --git a/security/selinux/include/selinux_ss.h b/security/selinux/include/selinux_ss.h
index 0c3c6df88f5d..2a5597c5fe5b 100644
--- a/security/selinux/include/selinux_ss.h
+++ b/security/selinux/include/selinux_ss.h
@@ -37,13 +37,13 @@ int selinux_ss_change_sid(struct selinux_state *state, u32 ssid, u32 tsid,
 			  u16 tclass, u32 *out_sid);
 
 int selinux_ss_sid_to_context(struct selinux_state *state, u32 sid,
-			      char **scontext, u32 *scontext_len);
+			      const char **scontext, u32 *scontext_len);
 
 int selinux_ss_sid_to_context_force(struct selinux_state *state, u32 sid,
-				    char **scontext, u32 *scontext_len);
+				    const char **scontext, u32 *scontext_len);
 
 int selinux_ss_sid_to_context_inval(struct selinux_state *state, u32 sid,
-				    char **scontext, u32 *scontext_len);
+				    const char **scontext, u32 *scontext_len);
 
 int selinux_ss_context_to_sid(struct selinux_state *state, const char *scontext,
 			      u32 scontext_len, u32 *out_sid, gfp_t gfp);
diff --git a/security/selinux/include/sidtab.h b/security/selinux/include/sidtab.h
index 2df3ac0df935..5fd841f6c33b 100644
--- a/security/selinux/include/sidtab.h
+++ b/security/selinux/include/sidtab.h
@@ -32,9 +32,6 @@ struct sidtab_entry {
 	u32 sid;
 	u32 hash;
 	struct context context;
-#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
-	struct sidtab_str_cache __rcu *cache;
-#endif
 	struct hlist_node list;
 #ifdef CONFIG_SECURITY_SELINUX_NS
 	u32 ss_sid;
@@ -107,13 +104,6 @@ struct sidtab {
 	bool frozen;
 	spinlock_t lock;
 
-#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
-	/* SID -> context string cache */
-	u32 cache_free_slots;
-	struct list_head cache_lru_list;
-	spinlock_t cache_lock;
-#endif
-
 	/* index == SID - 1 (no entry for SECSID_NULL) */
 	struct sidtab_isid_entry isids[SECINITSID_NUM];
 
@@ -160,25 +150,6 @@ void sidtab_destroy(struct sidtab *s);
 
 int sidtab_hash_stats(struct sidtab *sidtab, char *page);
 
-#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
-void sidtab_sid2str_put(struct sidtab *s, struct sidtab_entry *entry,
-			const char *str, u32 str_len);
-int sidtab_sid2str_get(struct sidtab *s, struct sidtab_entry *entry, char **out,
-		       u32 *out_len);
-#else
-static inline void sidtab_sid2str_put(struct sidtab *s,
-				      struct sidtab_entry *entry,
-				      const char *str, u32 str_len)
-{
-}
-static inline int sidtab_sid2str_get(struct sidtab *s,
-				     struct sidtab_entry *entry, char **out,
-				     u32 *out_len)
-{
-	return -ENOENT;
-}
-#endif /* CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0 */
-
 #ifdef CONFIG_SECURITY_SELINUX_NS
 #if CONFIG_SECURITY_SELINUX_SS_SID_CACHE_SIZE > 0
 extern void sidtab_invalidate_state(struct sidtab *s,
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 39fbcd7bc576..6d8ed0426b51 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -812,7 +812,7 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
 {
 	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
 	struct selinux_state *state = fsi->state;
-	char *canon = NULL;
+	const char *canon = NULL;
 	u32 sid, len;
 	ssize_t length;
 
@@ -830,21 +830,23 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
 	if (length)
 		goto out;
 
+	rcu_read_lock();
 	length = selinux_ss_sid_to_context(state, sid, &canon, &len);
 	if (length)
-		goto out;
+		goto out_unlock;
 
 	length = -ERANGE;
 	if (len > SIMPLE_TRANSACTION_LIMIT) {
 		pr_err("SELinux: %s:  context size (%u) exceeds "
 			"payload max\n", __func__, len);
-		goto out;
+		goto out_unlock;
 	}
 
 	memcpy(buf, canon, len);
 	length = len;
+out_unlock:
+	rcu_read_unlock();
 out:
-	kfree(canon);
 	return length;
 }
 
@@ -1125,7 +1127,7 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 	u32 ssid, tsid, newsid;
 	u16 tclass;
 	ssize_t length;
-	char *newcon = NULL;
+	const char *newcon = NULL;
 	u32 len;
 	int nargs;
 
@@ -1203,21 +1205,23 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 	if (length)
 		goto out;
 
+	rcu_read_lock();
 	length = selinux_ss_sid_to_context(state, newsid, &newcon, &len);
 	if (length)
-		goto out;
+		goto out_unlock;
 
 	length = -ERANGE;
 	if (len > SIMPLE_TRANSACTION_LIMIT) {
 		pr_err("SELinux: %s:  context size (%u) exceeds "
 			"payload max\n", __func__, len);
-		goto out;
+		goto out_unlock;
 	}
 
 	memcpy(buf, newcon, len);
 	length = len;
+out_unlock:
+	rcu_read_unlock();
 out:
-	kfree(newcon);
 	kfree(namebuf);
 	kfree(tcon);
 	kfree(scon);
@@ -1232,7 +1236,7 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 	u32 ssid, tsid, newsid;
 	u16 tclass;
 	ssize_t length;
-	char *newcon = NULL;
+	const char *newcon = NULL;
 	u32 len;
 
 	/*
@@ -1272,18 +1276,20 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 	if (length)
 		goto out;
 
+	rcu_read_lock();
 	length = selinux_ss_sid_to_context(state, newsid, &newcon, &len);
 	if (length)
-		goto out;
+		goto out_unlock;
 
 	length = -ERANGE;
 	if (len > SIMPLE_TRANSACTION_LIMIT)
-		goto out;
+		goto out_unlock;
 
 	memcpy(buf, newcon, len);
 	length = len;
+out_unlock:
+	rcu_read_unlock();
 out:
-	kfree(newcon);
 	kfree(tcon);
 	kfree(scon);
 	return length;
@@ -1296,7 +1302,7 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 	char *con = NULL, *user = NULL, *ptr;
 	u32 sid, *sids = NULL;
 	ssize_t length;
-	char *newcon;
+	const char *newcon;
 	int rc;
 	u32 i, len, nsids;
 
@@ -1350,22 +1356,23 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 
 	length = sprintf(buf, "%u", nsids) + 1;
 	ptr = buf + length;
+	rcu_read_lock();
 	for (i = 0; i < nsids; i++) {
 		rc = selinux_ss_sid_to_context(state, sids[i], &newcon, &len);
 		if (rc) {
 			length = rc;
-			goto out;
+			goto out_unlock;
 		}
 		if ((length + len) >= SIMPLE_TRANSACTION_LIMIT) {
-			kfree(newcon);
 			length = -ERANGE;
-			goto out;
+			goto out_unlock;
 		}
 		memcpy(ptr, newcon, len);
-		kfree(newcon);
 		ptr += len;
 		length += len;
 	}
+out_unlock:
+	rcu_read_unlock();
 out:
 	kfree(sids);
 	kfree(user);
@@ -1381,7 +1388,7 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 	u32 ssid, tsid, newsid;
 	u16 tclass;
 	ssize_t length;
-	char *newcon = NULL;
+	const char *newcon = NULL;
 	u32 len;
 
 	/*
@@ -1421,21 +1428,23 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 	if (length)
 		goto out;
 
+	rcu_read_lock();
 	length = selinux_ss_sid_to_context(state, newsid, &newcon, &len);
 	if (length)
-		goto out;
+		goto out_unlock;
 
 	length = -ERANGE;
 	if (len > SIMPLE_TRANSACTION_LIMIT) {
 		pr_err("SELinux: %s:  context size (%u) exceeds "
 			"payload max\n", __func__, len);
-		goto out;
+		goto out_unlock;
 	}
 
 	memcpy(buf, newcon, len);
 	length = len;
+out_unlock:
+	rcu_read_unlock();
 out:
-	kfree(newcon);
 	kfree(tcon);
 	kfree(scon);
 	return length;
@@ -1936,17 +1945,28 @@ static ssize_t sel_read_initcon(struct file *file, char __user *buf,
 				size_t count, loff_t *ppos)
 {
 	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
-	char *con;
+	const char *con;
+	char *con2;
 	u32 sid, len;
 	ssize_t ret;
 
 	sid = file_inode(file)->i_ino&SEL_INO_MASK;
+	rcu_read_lock();
 	ret = selinux_ss_sid_to_context(fsi->state, sid, &con, &len);
 	if (ret)
-		return ret;
+		goto err;
+	con2 = kmemdup(con, len, GFP_ATOMIC);
+	if (!con2) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	rcu_read_unlock();
 
-	ret = simple_read_from_buffer(buf, count, ppos, con, len);
-	kfree(con);
+	ret = simple_read_from_buffer(buf, count, ppos, con2, len);
+	kfree(con2);
+	return ret;
+err:
+	rcu_read_unlock();
 	return ret;
 }
 
diff --git a/security/selinux/ss/context.c b/security/selinux/ss/context.c
index a528b7f76280..47cdec24f85d 100644
--- a/security/selinux/ss/context.c
+++ b/security/selinux/ss/context.c
@@ -16,14 +16,14 @@ u32 context_compute_hash(const struct context *c)
 	u32 hash = 0;
 
 	/*
-	 * If a context is invalid, it will always be represented by a
-	 * context struct with only the len & str set (and vice versa)
-	 * under a given policy. Since context structs from different
-	 * policies should never meet, it is safe to hash valid and
-	 * invalid contexts differently. The context_equal() function
-	 * already operates under the same assumption.
+	 * If a context is invalid, it will never have user set
+	 * (and vice versa) under a given policy. Since context
+	 * structs from different policies should never meet,
+	 * it is safe to hash valid and invalid contexts differently.
+	 * The context_equal() function already operates under the
+	 * under the same assumption.
 	 */
-	if (c->len)
+	if (!c->user)
 		return full_name_hash(NULL, c->str, c->len);
 
 	hash = jhash_3words(c->user, c->role, c->type, hash);
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 91df3db6a88c..3bd6ce4df16a 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1066,6 +1066,8 @@ static int context_read_and_validate(struct context *c, struct policydb *p,
 {
 	__le32 buf[3];
 	int rc;
+	const char *str = NULL;
+	u32 str_len = 0;
 
 	rc = next_entry(buf, fp, sizeof buf);
 	if (rc) {
@@ -1089,7 +1091,13 @@ static int context_read_and_validate(struct context *c, struct policydb *p,
 		context_destroy(c);
 		goto out;
 	}
-	rc = 0;
+	rc = context_struct_to_string(p, c, &str, &str_len);
+	if (rc) {
+		context_destroy(c);
+		goto out;
+	}
+	c->str = str;
+	c->len = str_len;
 out:
 	return rc;
 }
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index a2c25d2bac33..276cd624f349 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -75,15 +75,10 @@ struct selinux_policy_convert_data {
 };
 
 /* Forward declaration. */
-static int context_struct_to_string(struct policydb *policydb,
-				    struct context *context,
-				    char **scontext,
-				    u32 *scontext_len);
-
 static int sidtab_entry_to_string(struct policydb *policydb,
 				  struct sidtab *sidtab,
 				  struct sidtab_entry *entry,
-				  char **scontext,
+				  const char **scontext,
 				  u32 *scontext_len);
 
 static void context_struct_compute_av(struct policydb *policydb,
@@ -464,11 +459,8 @@ static void security_dump_masked_av(struct policydb *policydb,
 	struct class_datum *tclass_dat;
 	struct audit_buffer *ab;
 	char *tclass_name;
-	char *scontext_name = NULL;
-	char *tcontext_name = NULL;
 	char *permission_names[32];
 	int index;
-	u32 length;
 	bool need_comma = false;
 
 	if (!permissions)
@@ -482,30 +474,21 @@ static void security_dump_masked_av(struct policydb *policydb,
 	if (common_dat &&
 	    hashtab_map(&common_dat->permissions.table,
 			dump_masked_av_helper, permission_names) < 0)
-		goto out;
+		return;
 
 	if (hashtab_map(&tclass_dat->permissions.table,
 			dump_masked_av_helper, permission_names) < 0)
-		goto out;
-
-	/* get scontext/tcontext in text form */
-	if (context_struct_to_string(policydb, scontext,
-				     &scontext_name, &length) < 0)
-		goto out;
-
-	if (context_struct_to_string(policydb, tcontext,
-				     &tcontext_name, &length) < 0)
-		goto out;
+		return;
 
 	/* audit a message */
 	ab = audit_log_start(audit_context(),
 			     GFP_ATOMIC, AUDIT_SELINUX_ERR);
 	if (!ab)
-		goto out;
+		return;
 
 	audit_log_format(ab, "op=security_compute_av reason=%s "
 			 "scontext=%s tcontext=%s tclass=%s perms=",
-			 reason, scontext_name, tcontext_name, tclass_name);
+			 reason, scontext->str, tcontext->str, tclass_name);
 
 	for (index = 0; index < 32; index++) {
 		u32 mask = (1 << index);
@@ -520,10 +503,6 @@ static void security_dump_masked_av(struct policydb *policydb,
 		need_comma = true;
 	}
 	audit_log_end(ab);
-out:
-	/* release scontext/tcontext */
-	kfree(tcontext_name);
-	kfree(scontext_name);
 }
 
 /*
@@ -731,7 +710,7 @@ static int security_validtrans_handle_fail(struct selinux_state *state,
 {
 	struct policydb *p = &policy->policydb;
 	struct sidtab *sidtab = policy->sidtab;
-	char *o = NULL, *n = NULL, *t = NULL;
+	const char *o = NULL, *n = NULL, *t = NULL;
 	u32 olen, nlen, tlen;
 
 	if (sidtab_entry_to_string(p, sidtab, oentry, &o, &olen))
@@ -745,10 +724,6 @@ static int security_validtrans_handle_fail(struct selinux_state *state,
 		  " oldcontext=%s newcontext=%s taskcontext=%s tclass=%s",
 		  o, n, t, sym_name(p, SYM_CLASSES, tclass-1));
 out:
-	kfree(o);
-	kfree(n);
-	kfree(t);
-
 	if (!enforcing_enabled(state))
 		return 0;
 	return -EPERM;
@@ -923,8 +898,8 @@ int selinux_ss_bounded_transition(struct selinux_state *state,
 	}
 
 	if (rc) {
-		char *old_name = NULL;
-		char *new_name = NULL;
+		const char *old_name = NULL;
+		const char *new_name = NULL;
 		u32 length;
 
 		if (!sidtab_entry_to_string(policydb, sidtab, old_entry,
@@ -938,8 +913,6 @@ int selinux_ss_bounded_transition(struct selinux_state *state,
 				  "oldcontext=%s newcontext=%s",
 				  old_name, new_name);
 		}
-		kfree(new_name);
-		kfree(old_name);
 	}
 out:
 	rcu_read_unlock();
@@ -1269,9 +1242,9 @@ void selinux_ss_compute_av_user(struct selinux_state *state,
  * to point to this string and set `*scontext_len' to
  * the length of the string.
  */
-static int context_struct_to_string(struct policydb *p,
+int context_struct_to_string(struct policydb *p,
 				    struct context *context,
-				    char **scontext, u32 *scontext_len)
+				    const char **scontext, u32 *scontext_len)
 {
 	char *scontextp;
 
@@ -1322,18 +1295,12 @@ static int context_struct_to_string(struct policydb *p,
 static int sidtab_entry_to_string(struct policydb *p,
 				  struct sidtab *sidtab,
 				  struct sidtab_entry *entry,
-				  char **scontext, u32 *scontext_len)
+				  const char **scontext, u32 *scontext_len)
 {
-	int rc = sidtab_sid2str_get(sidtab, entry, scontext, scontext_len);
-
-	if (rc != -ENOENT)
-		return rc;
+	*scontext = entry->context.str;
+	*scontext_len = entry->context.len;
 
-	rc = context_struct_to_string(p, &entry->context, scontext,
-				      scontext_len);
-	if (!rc && scontext)
-		sidtab_sid2str_put(sidtab, entry, *scontext, *scontext_len);
-	return rc;
+	return 0;
 }
 
 #include "initial_sid_to_string.h"
@@ -1365,7 +1332,7 @@ const char *security_get_initial_sid_context(u32 sid)
 }
 
 static int security_sid_to_context_core(struct selinux_state *state,
-					u32 sid, char **scontext,
+					u32 sid, const char **scontext,
 					u32 *scontext_len, int force,
 					int only_invalid)
 {
@@ -1381,7 +1348,6 @@ static int security_sid_to_context_core(struct selinux_state *state,
 
 	if (!selinux_initialized(state)) {
 		if (sid <= SECINITSID_NUM) {
-			char *scontextp;
 			const char *s;
 
 			/*
@@ -1400,10 +1366,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
 			*scontext_len = strlen(s) + 1;
 			if (!scontext)
 				return 0;
-			scontextp = kmemdup(s, *scontext_len, GFP_ATOMIC);
-			if (!scontextp)
-				return -ENOMEM;
-			*scontext = scontextp;
+			*scontext = s;
 			return 0;
 		}
 		pr_err("SELinux: %s:  called before initial "
@@ -1425,7 +1388,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
 		rc = -EINVAL;
 		goto out_unlock;
 	}
-	if (only_invalid && !entry->context.len)
+	if (only_invalid && entry->context.user)
 		goto out_unlock;
 
 	rc = sidtab_entry_to_string(policydb, sidtab, entry, scontext,
@@ -1449,14 +1412,14 @@ static int security_sid_to_context_core(struct selinux_state *state,
  * to point to this string and set @scontext_len to the length of the string.
  */
 int selinux_ss_sid_to_context(struct selinux_state *state,
-			      u32 sid, char **scontext, u32 *scontext_len)
+			      u32 sid, const char **scontext, u32 *scontext_len)
 {
 	return security_sid_to_context_core(state, sid, scontext,
 					    scontext_len, 0, 0);
 }
 
 int selinux_ss_sid_to_context_force(struct selinux_state *state, u32 sid,
-				    char **scontext, u32 *scontext_len)
+				    const char **scontext, u32 *scontext_len)
 {
 	return security_sid_to_context_core(state, sid, scontext,
 					    scontext_len, 1, 0);
@@ -1477,7 +1440,7 @@ int selinux_ss_sid_to_context_force(struct selinux_state *state, u32 sid,
  * the length of the string (or 0 if the context is valid).
  */
 int selinux_ss_sid_to_context_inval(struct selinux_state *state, u32 sid,
-				    char **scontext, u32 *scontext_len)
+				    const char **scontext, u32 *scontext_len)
 {
 	return security_sid_to_context_core(state, sid, scontext,
 					    scontext_len, 1, 1);
@@ -1572,7 +1535,9 @@ static int security_context_to_sid_core(struct selinux_state *state,
 	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
-	char *scontext2, *str = NULL;
+	char *scontext2;
+	const char *str = NULL;
+	u32 str_len = 0;
 	struct context context;
 	int rc = 0;
 
@@ -1600,13 +1565,13 @@ static int security_context_to_sid_core(struct selinux_state *state,
 	}
 	*sid = SECSID_NULL;
 
-	if (force) {
-		/* Save another copy for storing in uninterpreted form */
-		rc = -ENOMEM;
-		str = kstrdup(scontext2, gfp_flags);
-		if (!str)
-			goto out;
-	}
+	/* Save another copy for storing in uninterpreted form */
+	rc = -ENOMEM;
+	str = kstrdup(scontext2, gfp_flags);
+	if (!str)
+		goto out;
+	str_len = strlen(scontext2) + 1;
+
 retry:
 	rcu_read_lock();
 	policy = rcu_dereference(state->policy);
@@ -1614,19 +1579,24 @@ static int security_context_to_sid_core(struct selinux_state *state,
 	sidtab = policy->sidtab;
 	rc = string_to_context_struct(policydb, sidtab, scontext2,
 				      &context, def_sid);
-	if (rc == -EINVAL && force) {
-		context.str = str;
-		context.len = strlen(str) + 1;
-		str = NULL;
-	} else if (rc)
+	if (rc && !(rc == -EINVAL && force))
 		goto out_unlock;
+	if (rc != -EINVAL) {
+		kfree(str);
+		str = NULL;
+		rc = context_struct_to_string(policydb, &context, &str, &str_len);
+		if (rc)
+			goto out_unlock;
+	}
+	context.str = str;
+	context.len = str_len;
+	str = NULL;
 	rc = sidtab_context_to_sid(sidtab, &context, sid);
 	if (rc == -ESTALE) {
 		rcu_read_unlock();
-		if (context.str) {
-			str = context.str;
-			context.str = NULL;
-		}
+		str = context.str;
+		context.str = NULL;
+		context.len = 0;
 		context_destroy(&context);
 		goto retry;
 	}
@@ -1713,30 +1683,25 @@ static int compute_sid_handle_invalid_context(
 {
 	struct policydb *policydb = &policy->policydb;
 	struct sidtab *sidtab = policy->sidtab;
-	char *s = NULL, *t = NULL, *n = NULL;
-	u32 slen, tlen, nlen;
+	const char *s = NULL, *t = NULL;
+	u32 slen, tlen;
 	struct audit_buffer *ab;
 
 	if (sidtab_entry_to_string(policydb, sidtab, sentry, &s, &slen))
 		goto out;
 	if (sidtab_entry_to_string(policydb, sidtab, tentry, &t, &tlen))
 		goto out;
-	if (context_struct_to_string(policydb, newcontext, &n, &nlen))
-		goto out;
 	ab = audit_log_start(audit_context(), GFP_ATOMIC, AUDIT_SELINUX_ERR);
 	if (!ab)
 		goto out;
 	audit_log_format(ab,
 			 "op=security_compute_sid invalid_context=");
 	/* no need to record the NUL with untrusted strings */
-	audit_log_n_untrustedstring(ab, n, nlen - 1);
+	audit_log_n_untrustedstring(ab, newcontext->str, newcontext->len - 1);
 	audit_log_format(ab, " scontext=%s tcontext=%s tclass=%s",
 			 s, t, sym_name(policydb, SYM_CLASSES, tclass-1));
 	audit_log_end(ab);
 out:
-	kfree(s);
-	kfree(t);
-	kfree(n);
 	if (!enforcing_enabled(state))
 		return 0;
 	return -EACCES;
@@ -1792,6 +1757,8 @@ static int security_compute_sid(struct selinux_state *state,
 	u16 tclass;
 	int rc = 0;
 	bool sock;
+	const char *str = NULL;
+	u32 str_len = 0;
 
 	if (!selinux_initialized(state)) {
 		switch (orig_tclass) {
@@ -1943,6 +1910,13 @@ static int security_compute_sid(struct selinux_state *state,
 	if (rc)
 		goto out_unlock;
 
+	/* Set the context string */
+	rc = context_struct_to_string(policydb, &newcontext, &str, &str_len);
+	if (rc)
+		goto out_unlock;
+	newcontext.str = str;
+	newcontext.len = str_len;
+
 	/* Check the validity of the context. */
 	if (!policydb_context_isvalid(policydb, &newcontext)) {
 		rc = compute_sid_handle_invalid_context(state, policy, sentry,
@@ -2056,19 +2030,14 @@ int selinux_ss_change_sid(struct selinux_state *state,
 
 static inline int convert_context_handle_invalid_context(
 	struct selinux_state *state,
-	struct policydb *policydb,
 	struct context *context)
 {
-	char *s;
-	u32 len;
-
 	if (enforcing_enabled(state))
 		return -EINVAL;
 
-	if (!context_struct_to_string(policydb, context, &s, &len)) {
+	if (!context->str) {
 		pr_warn("SELinux:  Context %s would be invalid if enforcing\n",
-			s);
-		kfree(s);
+			context->str);
 	}
 	return 0;
 }
@@ -2089,114 +2058,32 @@ int services_convert_context(struct convert_context_args *args,
 			     struct context *oldc, struct context *newc,
 			     gfp_t gfp_flags)
 {
-	struct ocontext *oc;
-	struct role_datum *role;
-	struct type_datum *typdatum;
-	struct user_datum *usrdatum;
 	char *s;
-	u32 len;
 	int rc;
 
-	if (oldc->str) {
-		s = kstrdup(oldc->str, gfp_flags);
-		if (!s)
-			return -ENOMEM;
+	s = kstrdup(oldc->str, gfp_flags);
+	if (!s)
+		return -ENOMEM;
 
-		rc = string_to_context_struct(args->newp, NULL, s, newc, SECSID_NULL);
-		if (rc == -EINVAL) {
-			/*
-			 * Retain string representation for later mapping.
-			 *
-			 * IMPORTANT: We need to copy the contents of oldc->str
-			 * back into s again because string_to_context_struct()
-			 * may have garbled it.
-			 */
-			memcpy(s, oldc->str, oldc->len);
-			context_init(newc);
-			newc->str = s;
-			newc->len = oldc->len;
-			return 0;
-		}
+	rc = string_to_context_struct(args->newp, NULL, s, newc, SECSID_NULL);
+	if (rc && rc != -EINVAL) {
+		/* Other error condition, e.g. ENOMEM. */
+		pr_err("SELinux:   Unable to map context %s, rc = %d.\n",
+			oldc->str, -rc);
 		kfree(s);
-		if (rc) {
-			/* Other error condition, e.g. ENOMEM. */
-			pr_err("SELinux:   Unable to map context %s, rc = %d.\n",
-			       oldc->str, -rc);
-			return rc;
-		}
-		pr_info("SELinux:  Context %s became valid (mapped).\n",
-			oldc->str);
-		return 0;
-	}
-
-	context_init(newc);
-
-	/* Convert the user. */
-	usrdatum = symtab_search(&args->newp->p_users,
-				 sym_name(args->oldp, SYM_USERS, oldc->user - 1));
-	if (!usrdatum)
-		goto bad;
-	newc->user = usrdatum->value;
-
-	/* Convert the role. */
-	role = symtab_search(&args->newp->p_roles,
-			     sym_name(args->oldp, SYM_ROLES, oldc->role - 1));
-	if (!role)
-		goto bad;
-	newc->role = role->value;
-
-	/* Convert the type. */
-	typdatum = symtab_search(&args->newp->p_types,
-				 sym_name(args->oldp, SYM_TYPES, oldc->type - 1));
-	if (!typdatum)
-		goto bad;
-	newc->type = typdatum->value;
-
-	/* Convert the MLS fields if dealing with MLS policies */
-	if (args->oldp->mls_enabled && args->newp->mls_enabled) {
-		rc = mls_convert_context(args->oldp, args->newp, oldc, newc);
-		if (rc)
-			goto bad;
-	} else if (!args->oldp->mls_enabled && args->newp->mls_enabled) {
-		/*
-		 * Switching between non-MLS and MLS policy:
-		 * ensure that the MLS fields of the context for all
-		 * existing entries in the sidtab are filled in with a
-		 * suitable default value, likely taken from one of the
-		 * initial SIDs.
-		 */
-		oc = args->newp->ocontexts[OCON_ISID];
-		while (oc && oc->sid[0] != SECINITSID_UNLABELED)
-			oc = oc->next;
-		if (!oc) {
-			pr_err("SELinux:  unable to look up"
-				" the initial SIDs list\n");
-			goto bad;
-		}
-		rc = mls_range_set(newc, &oc->context[0].range);
-		if (rc)
-			goto bad;
-	}
-
-	/* Check the validity of the new context. */
-	if (!policydb_context_isvalid(args->newp, newc)) {
-		rc = convert_context_handle_invalid_context(args->state,
-							    args->oldp, oldc);
-		if (rc)
-			goto bad;
+		return rc;
 	}
 
-	return 0;
-bad:
-	/* Map old representation to string and save it. */
-	rc = context_struct_to_string(args->oldp, oldc, &s, &len);
-	if (rc)
-		return rc;
-	context_destroy(newc);
+	/*
+	 * Retain string representation for later mapping.
+	 *
+	 * IMPORTANT: We need to copy the contents of oldc->str
+	 * back into s again because string_to_context_struct()
+	 * may have garbled it.
+	 */
+	memcpy(s, oldc->str, oldc->len);
 	newc->str = s;
-	newc->len = len;
-	pr_info("SELinux:  Context %s became invalid (unmapped).\n",
-		newc->str);
+	newc->len = oldc->len;
 	return 0;
 }
 
@@ -2836,6 +2723,8 @@ int selinux_ss_get_user_sids(struct selinux_state *state,
 	struct context *fromcon, usercon;
 	u32 *mysids = NULL, *mysids2, sid;
 	u32 i, j, mynel, maxnel = SIDS_NEL;
+	const char *str = NULL;
+	u32 str_len = 0;
 	struct user_datum *user;
 	struct role_datum *role;
 	struct ebitmap_node *rnode, *tnode;
@@ -2882,7 +2771,18 @@ int selinux_ss_get_user_sids(struct selinux_state *state,
 						 &usercon))
 				continue;
 
+			/* Set the context string */
+			rc = context_struct_to_string(policydb, &usercon, &str, &str_len);
+			if (rc) {
+				context_destroy(&usercon);
+				goto out_unlock;
+			}
+			usercon.str = str;
+			usercon.len = str_len;
+
 			rc = sidtab_context_to_sid(sidtab, &usercon, &sid);
+			/* all done with usercon, free it */
+			context_destroy(&usercon);
 			if (rc == -ESTALE) {
 				rcu_read_unlock();
 				goto retry;
@@ -3303,8 +3203,8 @@ int selinux_ss_sid_mls_copy(struct selinux_state *state,
 	struct context *context1;
 	struct context *context2;
 	struct context newcon;
-	char *s;
-	u32 len;
+	const char *s = NULL;
+	u32 len = 0;
 	int rc;
 
 	if (!selinux_initialized(state)) {
@@ -3349,25 +3249,27 @@ int selinux_ss_sid_mls_copy(struct selinux_state *state,
 	if (rc)
 		goto out_unlock;
 
+	rc = context_struct_to_string(policydb, &newcon, &s, &len);
+	if (rc)
+		goto out_unlock;
+	newcon.str = s;
+	newcon.len = len;
+
 	/* Check the validity of the new context. */
 	if (!policydb_context_isvalid(policydb, &newcon)) {
-		rc = convert_context_handle_invalid_context(state, policydb,
+		rc = convert_context_handle_invalid_context(state,
 							&newcon);
 		if (rc) {
-			if (!context_struct_to_string(policydb, &newcon, &s,
-						      &len)) {
-				struct audit_buffer *ab;
-
-				ab = audit_log_start(audit_context(),
-						     GFP_ATOMIC,
-						     AUDIT_SELINUX_ERR);
-				audit_log_format(ab,
-						 "op=security_sid_mls_copy invalid_context=");
-				/* don't record NUL with untrusted strings */
-				audit_log_n_untrustedstring(ab, s, len - 1);
-				audit_log_end(ab);
-				kfree(s);
-			}
+			struct audit_buffer *ab;
+
+			ab = audit_log_start(audit_context(),
+					     GFP_ATOMIC,
+					     AUDIT_SELINUX_ERR);
+			audit_log_format(ab,
+					 "op=security_sid_mls_copy invalid_context=");
+			/* don't record NUL with untrusted strings */
+			audit_log_n_untrustedstring(ab, s, len - 1);
+			audit_log_end(ab);
 			goto out_unlock;
 		}
 	}
@@ -3959,6 +3861,8 @@ int selinux_ss_netlbl_secattr_to_sid(struct selinux_state *state,
 	int rc;
 	struct context *ctx;
 	struct context ctx_new;
+	const char *str = NULL;
+	u32 str_len = 0;
 
 	if (!selinux_initialized(state)) {
 		*sid = SECSID_NULL;
@@ -3996,8 +3900,22 @@ int selinux_ss_netlbl_secattr_to_sid(struct selinux_state *state,
 			goto out;
 		}
 
+		rc = context_struct_to_string(policydb, &ctx_new, &str, &str_len);
+		if (rc) {
+			ebitmap_destroy(&ctx_new.range.level[0].cat);
+			goto out;
+		}
+		ctx_new.str = str;
+		ctx_new.len = str_len;
+
 		rc = sidtab_context_to_sid(sidtab, &ctx_new, sid);
+		/*
+		 * Done with ctx_new, free its allocated memory.
+		 * NB we cannot use context_destroy here due to
+		 * level[1] being aliased.
+		 */
 		ebitmap_destroy(&ctx_new.range.level[0].cat);
+		kfree(str);
 		if (rc == -ESTALE) {
 			rcu_read_unlock();
 			goto retry;
diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
index 8696f9300529..4f2da6e20816 100644
--- a/security/selinux/ss/services.h
+++ b/security/selinux/ss/services.h
@@ -45,4 +45,9 @@ int services_convert_context(struct convert_context_args *args,
 			     struct context *oldc, struct context *newc,
 			     gfp_t gfp_flags);
 
+int context_struct_to_string(struct policydb *policydb,
+				    struct context *context,
+				    const char **scontext,
+				    u32 *scontext_len);
+
 #endif /* _SS_SERVICES_H_ */
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index eea37f78bec9..36e76f80fb9b 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -21,14 +21,6 @@
 #include "sidtab.h"
 #include "services.h"
 
-struct sidtab_str_cache {
-	struct rcu_head rcu_member;
-	struct list_head lru_member;
-	struct sidtab_entry *parent;
-	u32 len;
-	char str[] __counted_by(len);
-};
-
 #define index_to_sid(index) ((index) + SECINITSID_NUM + 1)
 #define sid_to_index(sid)   ((sid) - (SECINITSID_NUM + 1))
 
@@ -48,12 +40,6 @@ int sidtab_init(struct sidtab *s)
 
 	spin_lock_init(&s->lock);
 
-#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
-	s->cache_free_slots = CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE;
-	INIT_LIST_HEAD(&s->cache_lru_list);
-	spin_lock_init(&s->cache_lock);
-#endif
-
 	return 0;
 }
 
@@ -90,9 +76,6 @@ int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context)
 	if (rc)
 		return rc;
 
-#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
-	isid->entry.cache = NULL;
-#endif
 	isid->set = 1;
 
 	hash = context_compute_hash(context);
@@ -248,7 +231,7 @@ static struct sidtab_entry *sidtab_search_core(struct sidtab *s, u32 sid,
 			entry = sidtab_lookup(s, sid_to_index(sid));
 		else
 			entry = sidtab_lookup_initial(s, sid);
-		if (entry && (!entry->context.len || force))
+		if (entry && (entry->context.user || force))
 			return entry;
 	}
 
@@ -520,9 +503,6 @@ void sidtab_freeze_end(struct sidtab *s, unsigned long *flags)
 static void sidtab_destroy_entry(struct sidtab_entry *entry)
 {
 	context_destroy(&entry->context);
-#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
-	kfree(rcu_dereference_raw(entry->cache));
-#endif
 }
 
 static void sidtab_destroy_tree(union sidtab_entry_inner entry, u32 level)
@@ -570,85 +550,6 @@ void sidtab_destroy(struct sidtab *s)
 	 */
 }
 
-#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
-
-void sidtab_sid2str_put(struct sidtab *s, struct sidtab_entry *entry,
-			const char *str, u32 str_len)
-{
-	struct sidtab_str_cache *cache, *victim = NULL;
-	unsigned long flags;
-
-	/* do not cache invalid contexts */
-	if (entry->context.len)
-		return;
-
-	spin_lock_irqsave(&s->cache_lock, flags);
-
-	cache = rcu_dereference_protected(entry->cache,
-					  lockdep_is_held(&s->cache_lock));
-	if (cache) {
-		/* entry in cache - just bump to the head of LRU list */
-		list_move(&cache->lru_member, &s->cache_lru_list);
-		goto out_unlock;
-	}
-
-	cache = kmalloc(struct_size(cache, str, str_len), GFP_ATOMIC);
-	if (!cache)
-		goto out_unlock;
-
-	if (s->cache_free_slots == 0) {
-		/* pop a cache entry from the tail and free it */
-		victim = container_of(s->cache_lru_list.prev,
-				      struct sidtab_str_cache, lru_member);
-		list_del(&victim->lru_member);
-		rcu_assign_pointer(victim->parent->cache, NULL);
-	} else {
-		s->cache_free_slots--;
-	}
-	cache->parent = entry;
-	cache->len = str_len;
-	memcpy(cache->str, str, str_len);
-	list_add(&cache->lru_member, &s->cache_lru_list);
-
-	rcu_assign_pointer(entry->cache, cache);
-
-out_unlock:
-	spin_unlock_irqrestore(&s->cache_lock, flags);
-	kfree_rcu(victim, rcu_member);
-}
-
-int sidtab_sid2str_get(struct sidtab *s, struct sidtab_entry *entry, char **out,
-		       u32 *out_len)
-{
-	struct sidtab_str_cache *cache;
-	int rc = 0;
-
-	if (entry->context.len)
-		return -ENOENT; /* do not cache invalid contexts */
-
-	rcu_read_lock();
-
-	cache = rcu_dereference(entry->cache);
-	if (!cache) {
-		rc = -ENOENT;
-	} else {
-		*out_len = cache->len;
-		if (out) {
-			*out = kmemdup(cache->str, cache->len, GFP_ATOMIC);
-			if (!*out)
-				rc = -ENOMEM;
-		}
-	}
-
-	rcu_read_unlock();
-
-	if (!rc && out)
-		sidtab_sid2str_put(s, entry, *out, *out_len);
-	return rc;
-}
-
-#endif /* CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0 */
-
 #ifdef CONFIG_SECURITY_SELINUX_NS
 #if CONFIG_SECURITY_SELINUX_SS_SID_CACHE_SIZE > 0
 static void sidtab_invalidate_state_entry(struct sidtab_entry *entry,
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 92fb31661e54..7bf50661c844 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -348,7 +348,7 @@ int selinux_xfrm_state_alloc_acquire(struct xfrm_state *x,
 	struct selinux_state *state = init_selinux_state;
 	int rc;
 	struct xfrm_sec_ctx *ctx;
-	char *ctx_str = NULL;
+	const char *ctx_str = NULL;
 	u32 str_len;
 
 	if (!polsec)
@@ -357,9 +357,10 @@ int selinux_xfrm_state_alloc_acquire(struct xfrm_state *x,
 	if (secid == 0)
 		return -EINVAL;
 
+	rcu_read_lock();
 	rc = security_sid_to_context(state, secid, &ctx_str, &str_len);
 	if (rc)
-		return rc;
+		goto out;
 
 	ctx = kmalloc(struct_size(ctx, ctx_str, str_len), GFP_ATOMIC);
 	if (!ctx) {
@@ -376,7 +377,7 @@ int selinux_xfrm_state_alloc_acquire(struct xfrm_state *x,
 	x->security = ctx;
 	atomic_inc(&selinux_xfrm_refcount);
 out:
-	kfree(ctx_str);
+	rcu_read_unlock();
 	return rc;
 }
 
-- 
2.52.0

