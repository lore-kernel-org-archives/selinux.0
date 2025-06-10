Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B737224DD14;
	Tue, 10 Jun 2025 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576211; cv=none; b=HmKAyRgOvrdXLhDxo37wdUlPKWjB3EpuAdzFgwqhs/id9nA1r9XcZfyupwATlmZ5ebG/kq3SpCE2iuinLmo5KRO7h3CoQE5lZLNXh64ILJ10anmayIzImlhE7ZGszujYZI26PY2m0vA7HsDxMEx8m035KNE9fOiRBzqHzNV9Cok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576211; c=relaxed/simple;
	bh=t6NuNAriJQcl8RkFcX0xjFVJlrFh9HA3/kp/iktCBws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=If9GI6ZtbtSVLDp0DxIOtJdCQZhSbL0q499o66qpFOHEle8UrtOC1Q9X07S/PbQPQehrRyqmZ3sd/576hUoqVCzeX8NV06cy5AN8eOopA8k4i5XUwbO/PbbIcT7v8d7FJCaGJQt9PPi3t9qZSWpYz6XHhrQXMjvhvthEaC8XNLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2bmN+Ny; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2bmN+Ny"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6f8b2682d61so855086d6.0;
        Tue, 10 Jun 2025 10:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576208; x=1750181008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWKaS86s6AlrtoGibgoF8WMGVatN4hAal7gFq6ayWF8=;
        b=D2bmN+Nyaqof33PGLfvafoQ75huVmKs5V2fYC1EYuMVl/dH4jJpNdp2Z0U9ntFOlEZ
         6Q+8xz7dEwtouNPolD3ChW2NirspW69UHIiNdtrA865pjuvhXCx8Iku8qVdGv9dlAp/1
         P38CulA7fzq+4U7OZf2nV+rDnCQ8OPRmh+717VDz9WHJitQYQHoyPL5iKbiqazebK8L9
         Z5qetXvuIMuGSp+iMJLPoWtY1uY3h5r5eyZNtW+PcXr8exXWF1fq4EFx/Ev1YcjbWrkK
         eAl1GFDuj7xVmxsghJlWag4cpP96TKKpriB6doZVIc2Wq7tPw6HRATCBqOaAUQrTcOqP
         pp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576208; x=1750181008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWKaS86s6AlrtoGibgoF8WMGVatN4hAal7gFq6ayWF8=;
        b=SsaspiJM1tYgMTZppHNJn+9w4MREX+uVVpRj/XA6YhiBzZfPcNEGHp9rLYgLFQRjBb
         jR8g1Lnt4+3MqJvuVxeWqGkz0AvfPlMeX/ct48KQdKRDCQtN0IKpV+q23SsBYXeAd5mC
         mYxwdF2IUYI9rInL2Ld0lqu8mAXK210ri6Lznrnwcio/5pIZ2B0/IXpaPY1k8SpB4VSJ
         uYjE1y6nhm9U+q9XXycuXp5pvj41QF2k4CT6m8ZVX9hx/QDozJoVpiuaVindyrR5C6qF
         Qjoqo1YINA2WZ518qc3gZhQa14JuS2DTSjQbaEUR/AWvIVKuOAk6i7Mea0R+MvM+MKYS
         ZGBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWATX4s/wzmyQLylKqbULxtbvVOtNHdMl5Ee2jZ2UHtw595MzaB9mcetsuGewikyN5T5foeneI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxrKF4H3ZFWbqUy4Y8pLoPau27cPri59oBUlAPw6UayWLr1C4Y
	duu7ZNE1kcfPfOf2K0OuwlVnW6MQJfsjpEXpvh7EH8ZSEOj76MgotwJfp2qubw==
X-Gm-Gg: ASbGncucFrwce4Lc4XVEvE2pSdJOHHe9K1A5+MWLKeiOZEZLD9SFwO8B3PitODyq9/G
	H2vPu4hCu7+P/hVFLqCjM9c+ZhNKOHwVybyGwdF9Y4Qvddk9yJoFs3nBfe6E+NmZu+FNGak/VZm
	txTomIoBME99W5gLrNi5RgrHminjqLGW0EEzdKd7GkQFlJunHabktSxN1Jm7C/KjVOpvzbTW6i8
	f9RqFmjZx15HMl5I1fo3tNA9Ts/CmhoQpZ7JZezMmB3BEKToco6T8BeEevq30tzzh9Sg1pLr1e+
	GGPDDMiM5RaZAVI4ZlZuMwAz6KBSaT+GaQPgwacSKZRW+XxxF/0gArztxkk+9NVJCAd2a9kfu4S
	Au0cj9f+C05qH3ByaNDpbW3oYmmIqJlTGAqNuN+1MvCynW+gP9tTQGP4KxBlwGCB5dQ==
X-Google-Smtp-Source: AGHT+IF235f2gUNYuxKd2DpPjEbiOgl+jQ1PcR7WvAt4Q++kQGz7omTWUaMZIMxK6yR+ELSFoO8Xzw==
X-Received: by 2002:a05:6214:e81:b0:6fa:a5c9:2ee7 with SMTP id 6a1803df08f44-6fb2c38bbc7mr4040846d6.8.1749576208196;
        Tue, 10 Jun 2025 10:23:28 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:27 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 34/42] selinux: introduce selinux_state_has_perm()
Date: Tue, 10 Jun 2025 13:22:05 -0400
Message-ID: <20250610172226.1470741-35-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
References: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce selinux_state_has_perm() for checking permissions on a
(ssid, tsid) pair for a namespace and its ancestors when there
is no cred available, e.g. for the networking checks.

To support selinux_state_has_perm(), introduce a creator SID field
in the selinux_state structure to save the SID of the process
that created the namespace, or SECINITSID_KERNEL for the initial
namespace. This SID is used as the subject SID for checks in the
parent namespace.

Some of the checks previously converted to using cred_ssid_has_perm()
may be candidates for switching to this new helper even though a cred
was available in those hooks.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c              | 37 ++++++++++++++++
 security/selinux/hooks.c            | 69 ++++++++++++++++-------------
 security/selinux/include/avc.h      |  4 ++
 security/selinux/include/security.h |  1 +
 4 files changed, 80 insertions(+), 31 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index c81b511ed1f8..35cd0c9c9d41 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1688,6 +1688,43 @@ int cred_other_has_perm(const struct cred *cred, const struct cred *other,
 	return 0;
 }
 
+/**
+ * selinux_state_has_perm - Check and audit permissions on a (ssid, tsid) pair
+ * @state: SELinux state
+ * @ssid: source security identifier
+ * @tsid: target security identifier
+ * @tclass: target security class
+ * @requested: requested permissions, interpreted based on @tclass
+ * @ad: auxiliary audit data
+ *
+ * Check permissions between a source SID @ssid and a target SID @tsid for
+ * @state and all ancestors to determine whether the @requested permissions
+ * are granted, interpreting the permissions based on @tclass.
+ * For the ancestor checks, use the SID of the creator of the namespace
+ * as the source SID of the check.
+ * Audit the granting or denial of permissions in accordance with the policy.
+ * Return %0 if all @requested permissions are granted, -%EACCES if any
+ * permissions are denied, or another -errno upon other errors.
+ * DO NOT USE when a cred is available; use cred_*_has_perm() instead.
+ */
+int selinux_state_has_perm(struct selinux_state *state, u32 ssid, u32 tsid,
+			   u16 tclass, u32 requested,
+			   struct common_audit_data *ad)
+{
+	int rc;
+
+	do {
+		rc = avc_has_perm(state, ssid, tsid, tclass, requested, ad);
+		if (rc)
+			return rc;
+
+		ssid = state->creator_sid;
+		state = state->parent;
+	} while (state);
+
+	return 0;
+}
+
 u32 avc_policy_seqno(struct selinux_state *state)
 {
 	return state->avc->avc_cache.latest_notif;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d13749aa5f24..775bf64fd3d5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5286,16 +5286,16 @@ static int selinux_inet_sys_rcv_skb(struct selinux_state *state,
 	err = sel_netif_sid(state, ns, ifindex, &if_sid);
 	if (err)
 		return err;
-	err = avc_has_perm(state, peer_sid, if_sid,
-			   SECCLASS_NETIF, NETIF__INGRESS, ad);
+	err = selinux_state_has_perm(state, peer_sid, if_sid,
+				     SECCLASS_NETIF, NETIF__INGRESS, ad);
 	if (err)
 		return err;
 
 	err = sel_netnode_sid(state, addrp, family, &node_sid);
 	if (err)
 		return err;
-	return avc_has_perm(state, peer_sid, node_sid, SECCLASS_NODE,
-			    NODE__RECVFROM, ad);
+	return selinux_state_has_perm(state, peer_sid, node_sid, SECCLASS_NODE,
+				      NODE__RECVFROM, ad);
 }
 
 static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
@@ -5315,8 +5315,9 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 		return err;
 
 	if (selinux_secmark_enabled()) {
-		err = avc_has_perm(state, sk_sid, skb->secmark, SECCLASS_PACKET,
-				   PACKET__RECV, &ad);
+		err = selinux_state_has_perm(state, sk_sid, skb->secmark,
+					     SECCLASS_PACKET, PACKET__RECV,
+					     &ad);
 		if (err)
 			return err;
 	}
@@ -5376,8 +5377,8 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 			selinux_netlbl_err(skb, family, err, 0);
 			return err;
 		}
-		err = avc_has_perm(state, sk_sid, peer_sid, SECCLASS_PEER,
-				   PEER__RECV, &ad);
+		err = selinux_state_has_perm(state, sk_sid, peer_sid,
+					     SECCLASS_PEER, PEER__RECV, &ad);
 		if (err) {
 			selinux_netlbl_err(skb, family, err, 0);
 			return err;
@@ -5385,8 +5386,9 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	}
 
 	if (secmark_active) {
-		err = avc_has_perm(state, sk_sid, skb->secmark, SECCLASS_PACKET,
-				   PACKET__RECV, &ad);
+		err = selinux_state_has_perm(state, sk_sid, skb->secmark,
+					     SECCLASS_PACKET, PACKET__RECV,
+					     &ad);
 		if (err)
 			return err;
 	}
@@ -5570,9 +5572,9 @@ static int selinux_sctp_process_new_assoc(struct sctp_association *asoc,
 		 * consistency among the peer SIDs.
 		 */
 		ad_net_init_from_sk(&ad, &net, asoc->base.sk);
-		err = avc_has_perm(state, sksec->peer_sid, asoc->peer_secid,
-				   sksec->sclass, SCTP_SOCKET__ASSOCIATION,
-				   &ad);
+		err = selinux_state_has_perm(state, sksec->peer_sid,
+					     asoc->peer_secid, sksec->sclass,
+					     SCTP_SOCKET__ASSOCIATION, &ad);
 		if (err)
 			return err;
 	}
@@ -5940,8 +5942,9 @@ static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 	}
 
 	if (secmark_active)
-		if (avc_has_perm(se_state, peer_sid, skb->secmark,
-				 SECCLASS_PACKET, PACKET__FORWARD_IN, &ad))
+		if (selinux_state_has_perm(se_state, peer_sid, skb->secmark,
+					   SECCLASS_PACKET,
+					   PACKET__FORWARD_IN, &ad))
 			return NF_DROP;
 
 	if (netlbl_enabled())
@@ -6022,8 +6025,9 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 		return NF_DROP;
 
 	if (selinux_secmark_enabled())
-		if (avc_has_perm(sksec->state, sksec->sid, skb->secmark,
-				 SECCLASS_PACKET, PACKET__SEND, &ad))
+		if (selinux_state_has_perm(sksec->state, sksec->sid,
+					   skb->secmark, SECCLASS_PACKET,
+					   PACKET__SEND, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
 	if (selinux_xfrm_postroute_last(sksec->sid, skb, sksec->state, &ad,
@@ -6149,8 +6153,8 @@ static unsigned int selinux_ip_postroute(void *priv,
 		return NF_DROP;
 
 	if (secmark_active)
-		if (avc_has_perm(se_state, peer_sid, skb->secmark,
-				 SECCLASS_PACKET, secmark_perm, &ad))
+		if (selinux_state_has_perm(se_state, peer_sid, skb->secmark,
+					   SECCLASS_PACKET, secmark_perm, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
 	if (peerlbl_active) {
@@ -6159,14 +6163,14 @@ static unsigned int selinux_ip_postroute(void *priv,
 
 		if (sel_netif_sid(se_state, state->net, ifindex, &if_sid))
 			return NF_DROP;
-		if (avc_has_perm(se_state, peer_sid, if_sid,
-				 SECCLASS_NETIF, NETIF__EGRESS, &ad))
+		if (selinux_state_has_perm(se_state, peer_sid, if_sid,
+					   SECCLASS_NETIF, NETIF__EGRESS, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
 		if (sel_netnode_sid(se_state, addrp, family, &node_sid))
 			return NF_DROP;
-		if (avc_has_perm(se_state, peer_sid, node_sid,
-				 SECCLASS_NODE, NODE__SENDTO, &ad))
+		if (selinux_state_has_perm(se_state, peer_sid, node_sid,
+					   SECCLASS_NODE, NODE__SENDTO, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 	}
 
@@ -7069,10 +7073,10 @@ static int selinux_ib_pkey_access(void *ib_sec, u64 subnet_prefix, u16 pkey_val)
 	ibpkey.subnet_prefix = subnet_prefix;
 	ibpkey.pkey = pkey_val;
 	ad.u.ibpkey = &ibpkey;
-	return avc_has_perm(current_selinux_state,
-			    sec->sid, sid,
-			    SECCLASS_INFINIBAND_PKEY,
-			    INFINIBAND_PKEY__ACCESS, &ad);
+	return selinux_state_has_perm(current_selinux_state,
+				      sec->sid, sid,
+				      SECCLASS_INFINIBAND_PKEY,
+				      INFINIBAND_PKEY__ACCESS, &ad);
 }
 
 static int selinux_ib_endport_manage_subnet(void *ib_sec, const char *dev_name,
@@ -7094,10 +7098,10 @@ static int selinux_ib_endport_manage_subnet(void *ib_sec, const char *dev_name,
 	ibendport.dev_name = dev_name;
 	ibendport.port = port_num;
 	ad.u.ibendport = &ibendport;
-	return avc_has_perm(current_selinux_state,
-			    sec->sid, sid,
-			    SECCLASS_INFINIBAND_ENDPORT,
-			    INFINIBAND_ENDPORT__MANAGE_SUBNET, &ad);
+	return selinux_state_has_perm(current_selinux_state,
+				      sec->sid, sid,
+				      SECCLASS_INFINIBAND_ENDPORT,
+				      INFINIBAND_ENDPORT__MANAGE_SUBNET, &ad);
 }
 
 static int selinux_ib_alloc_security(void *ib_sec)
@@ -7709,6 +7713,7 @@ int selinux_state_create(const struct cred *cred)
 {
 	struct task_security_struct *tsec = selinux_cred(cred);
 	struct selinux_state *parent = tsec->state;
+	u32 creator_sid = tsec->sid;
 	struct selinux_state *newstate;
 	int rc;
 
@@ -7724,6 +7729,8 @@ int selinux_state_create(const struct cred *cred)
 	if (!newstate)
 		return -ENOMEM;
 
+	newstate->creator_sid = creator_sid;
+
 	refcount_set(&newstate->count, 1);
 	INIT_WORK(&newstate->work, selinux_state_free);
 
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 1916ee418aa3..ffb8946dfeda 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -175,6 +175,10 @@ int cred_other_has_perm(const struct cred *cred, const struct cred *other,
 int task_obj_has_perm(const struct task_struct *s, const struct task_struct *t,
 		      u16 tclass, u32 requested, struct common_audit_data *ad);
 
+int selinux_state_has_perm(struct selinux_state *state, u32 ssid, u32 tsid,
+			   u16 tclass, u32 requested,
+			   struct common_audit_data *ad);
+
 u32 avc_policy_seqno(struct selinux_state *state);
 
 #define AVC_CALLBACK_GRANT		1
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 572d9ea9cef6..00e3e22b274b 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -110,6 +110,7 @@ struct selinux_state {
 
 	refcount_t count;
 	struct work_struct work;
+	u32 creator_sid; /* SID of namespace creator */
 	unsigned short depth;
 } __randomize_layout;
 
-- 
2.49.0

