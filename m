Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB133200CA6
	for <selinux@vger.kernel.org>; Wed,  6 Nov 2024 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908518; cv=none; b=VtyZTNLvHJTIEjy/fBfkgbeX6vysytx6nM65GW2hWIAc6uqgsGN15G9kdr+EnGBpzGuxUJX6DHt1nAj9IHnAvoHQSWAskpYuFAaskivo48ok08jGjoq9HMXSBxVelgqPQ2rSutjvr9KzCB+MaHy+uwBHxDlPm6UQNiU4GiwpfL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908518; c=relaxed/simple;
	bh=WFaj/Ldb/Nsmu9LtgiqEDVm3syCH5bEeO6Dm2hOqL5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F8/fqgt6lFKNkl5rmpDkHNOMvoEuQzWjVONltURzeVwAFKHMDCNW4hQr9t/0qYN8z6w4dxpDdnhVYcAwSxa/ec29OIqTYv3EoIMzKJgUBDtPwDiw+/p+Am2f/yW0EoD6DGfhn/NJZ8Fh9XOCR0B4dH5DPWHBiIqUIY4G+dKok2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MBF2Jkk4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MBF2Jkk4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730908515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MzByn1PFTd2UZqqQ0F2U/wwWXAvxlXNkbCplWb1cU3o=;
	b=MBF2Jkk4IVb2oBkxWpRYT83lUF8W0gR86QJB27eRYYwnCPLWKRQYZWTPIvLuRmpYTbOZQ+
	Y3LN/mirm6CVAL/K9UKnY2FaIMhIyhjMYoZKXJXV51YBV5nHEQOU7CCcWclMfMSMInXuiH
	PnV3JtvAmtkIDvI913a8OkYsp9ltqhg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529--1kjC4zFNgaf0GWAdacK4A-1; Wed, 06 Nov 2024 10:55:14 -0500
X-MC-Unique: -1kjC4zFNgaf0GWAdacK4A-1
X-Mimecast-MFC-AGG-ID: -1kjC4zFNgaf0GWAdacK4A
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2fcda6c1906so45122071fa.1
        for <selinux@vger.kernel.org>; Wed, 06 Nov 2024 07:55:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730908513; x=1731513313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzByn1PFTd2UZqqQ0F2U/wwWXAvxlXNkbCplWb1cU3o=;
        b=XktmAgUbUa4IcoZP5I8NwJY2GXbvcpRjU/mWaaRoxGY9xpZ/a/8dIGJAV6iFG/hyLl
         389Nss3w+ealaWHmMQnHuqtIN7qgCaBBCC0Wy/qCsJzNWg9nQrWklkSC3UlxFXT/pmT+
         PppVndHp+GBOb5GkLwpeuyOBbb0b2i5kp4bLSCRkcpzoTo4ts8CCtSWpn7zzuROfT6Py
         5t0W/ZewU3oKxaqecDLtP5/2ASMN2makfLORQlAIIlBh/lj2fdCRkszFtGNyAeAGAlHA
         VHJrTXZCStMFkF/zZb6kYgMFg6DRPB8kmdVrwQil3JSluIZ3K5tTfWggOXZLV49YJfmo
         cXqw==
X-Forwarded-Encrypted: i=1; AJvYcCVk4OcmytRs3GC0OfWYjScVtah+RymWghZXA63I2dVV3vbdUsan/eXDmmwlbpUsQHXkjpy7M/jT@vger.kernel.org
X-Gm-Message-State: AOJu0YxN+nvQROHGxCwnm9a/0tL3c+iL5C3F0hNy1XEGJQER0Xu7nyRd
	HaQL9tAiej94sJbGkv74YIsYIVmKnDwT4pAeh8zNWyZtcsSH01QdpMahLOYnDDBCr/im2OY3ccQ
	zUVFChpNfYxRCRy8fEmN93zpwAUj+dp7vL5xItthxmzS7A2JV9RI6ilQ=
X-Received: by 2002:a2e:510a:0:b0:2fb:5014:c939 with SMTP id 38308e7fff4ca-2fd0df8461cmr103533351fa.41.1730908512474;
        Wed, 06 Nov 2024 07:55:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZggE/NoO9RDxJ/BVwOrlZsrCuvRF6+RhLP7wSLiLfX9x9S+YHhjOnYDxcX9ZwAtQ6LfkbJA==
X-Received: by 2002:a2e:510a:0:b0:2fb:5014:c939 with SMTP id 38308e7fff4ca-2fd0df8461cmr103533201fa.41.1730908511965;
        Wed, 06 Nov 2024 07:55:11 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6afe648sm2940498a12.69.2024.11.06.07.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:55:10 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Paul Moore <paul@paul-moore.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] selinux,xfrm: fix dangling refcount on deferred skb free
Date: Wed,  6 Nov 2024 16:55:09 +0100
Message-ID: <20241106155509.1706965-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SELinux tracks the number of allocated xfrm_state/xfrm_policy objects
(via the selinux_xfrm_refcount variable) as an input in deciding if peer
labeling should be used.

However, as a result of commits f35f821935d8 ("tcp: defer skb freeing
after socket lock is released") and 68822bdf76f1 ("net: generalize skb
freeing deferral to per-cpu lists"), freeing of a sk_buff object, which
may hold a reference to an xfrm_state object, can be deferred for
processing on another CPU core, so even after xfrm_state is deleted from
the configuration by userspace, the refcount isn't decremented until the
deferred freeing of relevant sk_buffs happens. On a system with many
cores this can take a very long time (even minutes or more if the system
is not very active), leading to peer labeling being enabled for much
longer than expected.

Fix this by moving the selinux_xfrm_refcount decrementing to just after
the actual deletion of the xfrm objects rather than waiting for the
freeing to happen. For xfrm_policy it currently doesn't seem to be
necessary, but let's do the same there for consistency and
future-proofing.

We hit this issue on a specific aarch64 256-core system, where the
sequence of unix_socket/test and inet_socket/tcp/test from
selinux-testsuite [1] would quite reliably trigger this scenario, and a
subsequent sctp/test run would then stumble because the policy for that
test misses some rules that would make it work under peer labeling
enabled (namely it was getting the netif::egress permission denied in
some of the test cases).

[1] https://github.com/SELinuxProject/selinux-testsuite/

Fixes: f35f821935d8 ("tcp: defer skb freeing after socket lock is released")
Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu lists")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/lsm_hook_defs.h   |  2 ++
 include/linux/security.h        | 10 ++++++++++
 net/xfrm/xfrm_policy.c          |  1 +
 net/xfrm/xfrm_state.c           |  2 ++
 security/security.c             | 26 ++++++++++++++++++++++++++
 security/selinux/hooks.c        |  2 ++
 security/selinux/include/xfrm.h |  2 ++
 security/selinux/xfrm.c         | 17 ++++++++++++++++-
 8 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 9eca013aa5e1f..c1f58a74a64ba 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -387,12 +387,14 @@ LSM_HOOK(int, 0, xfrm_policy_clone_security, struct xfrm_sec_ctx *old_ctx,
 LSM_HOOK(void, LSM_RET_VOID, xfrm_policy_free_security,
 	 struct xfrm_sec_ctx *ctx)
 LSM_HOOK(int, 0, xfrm_policy_delete_security, struct xfrm_sec_ctx *ctx)
+LSM_HOOK(void, LSM_RET_VOID, xfrm_policy_deleted, struct xfrm_sec_ctx *ctx)
 LSM_HOOK(int, 0, xfrm_state_alloc, struct xfrm_state *x,
 	 struct xfrm_user_sec_ctx *sec_ctx)
 LSM_HOOK(int, 0, xfrm_state_alloc_acquire, struct xfrm_state *x,
 	 struct xfrm_sec_ctx *polsec, u32 secid)
 LSM_HOOK(void, LSM_RET_VOID, xfrm_state_free_security, struct xfrm_state *x)
 LSM_HOOK(int, 0, xfrm_state_delete_security, struct xfrm_state *x)
+LSM_HOOK(void, LSM_RET_VOID, xfrm_state_deleted, struct xfrm_state *x)
 LSM_HOOK(int, 0, xfrm_policy_lookup, struct xfrm_sec_ctx *ctx, u32 fl_secid)
 LSM_HOOK(int, 1, xfrm_state_pol_flow_match, struct xfrm_state *x,
 	 struct xfrm_policy *xp, const struct flowi_common *flic)
diff --git a/include/linux/security.h b/include/linux/security.h
index b86ec2afc6910..ac1f85d0f1110 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1873,10 +1873,12 @@ int security_xfrm_policy_alloc(struct xfrm_sec_ctx **ctxp,
 int security_xfrm_policy_clone(struct xfrm_sec_ctx *old_ctx, struct xfrm_sec_ctx **new_ctxp);
 void security_xfrm_policy_free(struct xfrm_sec_ctx *ctx);
 int security_xfrm_policy_delete(struct xfrm_sec_ctx *ctx);
+void security_xfrm_policy_deleted(struct xfrm_sec_ctx *ctx);
 int security_xfrm_state_alloc(struct xfrm_state *x, struct xfrm_user_sec_ctx *sec_ctx);
 int security_xfrm_state_alloc_acquire(struct xfrm_state *x,
 				      struct xfrm_sec_ctx *polsec, u32 secid);
 int security_xfrm_state_delete(struct xfrm_state *x);
+void security_xfrm_state_deleted(struct xfrm_state *x);
 void security_xfrm_state_free(struct xfrm_state *x);
 int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid);
 int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
@@ -1908,6 +1910,10 @@ static inline int security_xfrm_policy_delete(struct xfrm_sec_ctx *ctx)
 	return 0;
 }
 
+static inline void security_xfrm_policy_deleted(struct xfrm_sec_ctx *ctx)
+{
+}
+
 static inline int security_xfrm_state_alloc(struct xfrm_state *x,
 					struct xfrm_user_sec_ctx *sec_ctx)
 {
@@ -1929,6 +1935,10 @@ static inline int security_xfrm_state_delete(struct xfrm_state *x)
 	return 0;
 }
 
+static inline void security_xfrm_state_deleted(struct xfrm_state *x)
+{
+}
+
 static inline int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid)
 {
 	return 0;
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 914bac03b52ad..1433520c62c94 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2313,6 +2313,7 @@ static struct xfrm_policy *__xfrm_policy_unlink(struct xfrm_policy *pol,
 	list_del_init(&pol->walk.all);
 	net->xfrm.policy_count[dir]--;
 
+	security_xfrm_policy_deleted(pol->security);
 	return pol;
 }
 
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 37478d36a8dff..80f5006bc414e 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -760,6 +760,8 @@ int __xfrm_state_delete(struct xfrm_state *x)
 
 		xfrm_dev_state_delete(x);
 
+		security_xfrm_state_deleted(x);
+
 		/* All xfrm_state objects are created by xfrm_state_alloc.
 		 * The xfrm_state_alloc call gives a reference, and that
 		 * is what we are dropping here.
diff --git a/security/security.c b/security/security.c
index 6875eb4a59fcc..f6a985417f6f8 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5295,6 +5295,19 @@ int security_xfrm_policy_delete(struct xfrm_sec_ctx *ctx)
 	return call_int_hook(xfrm_policy_delete_security, ctx);
 }
 
+/**
+ * security_xfrm_policy_deleted() - Handle deletion of xfrm policy
+ * @ctx: xfrm security context
+ *
+ * Handle deletion of xfrm policy. This is called on the actual deletion
+ * of the policy from the xfrm system. References to the policy may be
+ * still held elsewhere, so resources should not be freed yet.
+ */
+void security_xfrm_policy_deleted(struct xfrm_sec_ctx *ctx)
+{
+	call_void_hook(xfrm_policy_deleted, ctx);
+}
+
 /**
  * security_xfrm_state_alloc() - Allocate a xfrm state LSM blob
  * @x: xfrm state being added to the SAD
@@ -5345,6 +5358,19 @@ int security_xfrm_state_delete(struct xfrm_state *x)
 }
 EXPORT_SYMBOL(security_xfrm_state_delete);
 
+/**
+ * security_xfrm_state_deleted() - Handle deletion of xfrm state
+ * @x: xfrm state
+ *
+ * Handle deletion of xfrm state. This is called on the actual deletion
+ * of the state from the xfrm system. References to the state may be
+ * still held elsewhere, so resources should not be freed yet.
+ */
+void security_xfrm_state_deleted(struct xfrm_state *x)
+{
+	call_void_hook(xfrm_state_deleted, x);
+}
+
 /**
  * security_xfrm_state_free() - Free a xfrm state
  * @x: xfrm state
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ad3abd48eed1d..d3ade56c09e8f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7315,8 +7315,10 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
 	LSM_HOOK_INIT(xfrm_policy_free_security, selinux_xfrm_policy_free),
 	LSM_HOOK_INIT(xfrm_policy_delete_security, selinux_xfrm_policy_delete),
+	LSM_HOOK_INIT(xfrm_policy_deleted, selinux_xfrm_policy_deleted),
 	LSM_HOOK_INIT(xfrm_state_free_security, selinux_xfrm_state_free),
 	LSM_HOOK_INIT(xfrm_state_delete_security, selinux_xfrm_state_delete),
+	LSM_HOOK_INIT(xfrm_state_deleted, selinux_xfrm_state_deleted),
 	LSM_HOOK_INIT(xfrm_policy_lookup, selinux_xfrm_policy_lookup),
 	LSM_HOOK_INIT(xfrm_state_pol_flow_match,
 			selinux_xfrm_state_pol_flow_match),
diff --git a/security/selinux/include/xfrm.h b/security/selinux/include/xfrm.h
index de485556ae29c..bde5a9e2ccf95 100644
--- a/security/selinux/include/xfrm.h
+++ b/security/selinux/include/xfrm.h
@@ -19,12 +19,14 @@ int selinux_xfrm_policy_clone(struct xfrm_sec_ctx *old_ctx,
 			      struct xfrm_sec_ctx **new_ctxp);
 void selinux_xfrm_policy_free(struct xfrm_sec_ctx *ctx);
 int selinux_xfrm_policy_delete(struct xfrm_sec_ctx *ctx);
+void selinux_xfrm_policy_deleted(struct xfrm_sec_ctx *ctx);
 int selinux_xfrm_state_alloc(struct xfrm_state *x,
 			     struct xfrm_user_sec_ctx *uctx);
 int selinux_xfrm_state_alloc_acquire(struct xfrm_state *x,
 				     struct xfrm_sec_ctx *polsec, u32 secid);
 void selinux_xfrm_state_free(struct xfrm_state *x);
 int selinux_xfrm_state_delete(struct xfrm_state *x);
+void selinux_xfrm_state_deleted(struct xfrm_state *x);
 int selinux_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid);
 int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x,
 				      struct xfrm_policy *xp,
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 90ec4ef1b082f..35372bdba7279 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -124,7 +124,6 @@ static void selinux_xfrm_free(struct xfrm_sec_ctx *ctx)
 	if (!ctx)
 		return;
 
-	atomic_dec(&selinux_xfrm_refcount);
 	kfree(ctx);
 }
 
@@ -321,6 +320,14 @@ int selinux_xfrm_policy_delete(struct xfrm_sec_ctx *ctx)
 	return selinux_xfrm_delete(ctx);
 }
 
+/*
+ * LSM hook implementation that handles deletion of labeled SAs.
+ */
+void selinux_xfrm_policy_deleted(struct xfrm_sec_ctx *ctx)
+{
+	atomic_dec(&selinux_xfrm_refcount);
+}
+
 /*
  * LSM hook implementation that allocates a xfrm_sec_state, populates it using
  * the supplied security context, and assigns it to the xfrm_state.
@@ -389,6 +396,14 @@ int selinux_xfrm_state_delete(struct xfrm_state *x)
 	return selinux_xfrm_delete(x->security);
 }
 
+/*
+ * LSM hook implementation that handles deletion of labeled SAs.
+ */
+void selinux_xfrm_state_deleted(struct xfrm_state *x)
+{
+	atomic_dec(&selinux_xfrm_refcount);
+}
+
 /*
  * LSM hook that controls access to unlabelled packets.  If
  * a xfrm_state is authorizable (defined by macro) then it was
-- 
2.47.0

