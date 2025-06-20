Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAC72F0C64;
	Fri, 20 Jun 2025 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441549; cv=none; b=ch7zHtvZpdpyFOJLY1+DaNoXd8OQLFUR78YWzQe9jkpdAGH+mAco+hDXMSTHepXPUBVQEjpBfcVgF7vp0SNDyMZAv6eEI6m9dLraZcLtBai0dWyd0mhw5Rz7r4DSgRx/Mdtuf/JtzNCa68BHCtKag+xRkfLRJTNs2A3f/ZVCDnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441549; c=relaxed/simple;
	bh=o3qaxOkWvSYQYnV6eDqj1y/eDdUi2z03OSWydNTKuKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lgx2DjxC4zlHLzOzXI4vf3i8ooX3jB7pIwGDrNG+o5HnoRtscyzGJPb80rjyXTS5GaDdYmnOXDakOf2v1ojpH5JX66kNitJGgNEDmieaJEX22PYXg1DLgMSrbyS31NPJcs5jVqmJeKNaXEjJKW/1VAYvCIU/KLup5uSVG5Brs5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nl51vPHr; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl51vPHr"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d094ef02e5so215223885a.1;
        Fri, 20 Jun 2025 10:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441546; x=1751046346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SOsElaq8vR/EjLUpVFPr8K9l8QgN1tp8ed+JoAUV8M=;
        b=Nl51vPHr9EbZkX4ua2YpyaYbdWHGvhMmsLqQAYFJM6r/3Cpv1PcIhgo0UGfHrWzCJn
         C57QkBdPBPeDz8ZTYpKCbZFi/4YLGdSLIOhOmncpfBNsqMvbsnWt+l5wXT8dzq6zhn17
         ywUyZGTMyzLFyJ5GtOyO0vvVOj0HN9v0F/Wz/0DTlejhNKf6DUFJNfHUHBAJe52eGDvF
         eWFS6rm9RspfY9qDCpZeJ4lbnD4UoYO9Au52QGgCzvDE5SQEfNAzqgkurTihWSteU9ZN
         2xh3ptE48MhMEDt1qfmsNvewOc+9f147KKC3qfX3gjOuHzG/NZAtp/wAlD2YuFYX3U2n
         2uFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441546; x=1751046346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SOsElaq8vR/EjLUpVFPr8K9l8QgN1tp8ed+JoAUV8M=;
        b=mtS1X2hDpYTvEYDz2jKgj6ey4IvsTphoVJdhfAssyaKMc6dM3ysxwl3W27ZXHLuRJK
         LYHlyuQAj4UZZlLFuGB0cgE3DmI+2P2+dF5mqGd5SgEcVa2mf+XYIAoAPXtwRlRuw5hV
         JFm01TooH2BHIDPBZr0l0jiJ1LJ9z93T+S1EVrimZDBc3e3iQOYXworZlKrREtI8QQvq
         odxF6Q/O3ACLS+I7v0LkYjWBn5NLC0ud7035p5AQfncqiN6vBvvWO2cx0pPLSlkPZa4+
         lPGllTz5/rZcZx08ZKdsw6CgdXIzBLdS8/TbkK1ucOw5Uvu2chXwezS/CDvU6Z+B5mbm
         eRqA==
X-Forwarded-Encrypted: i=1; AJvYcCU0lp5F3Z//RxB3aDa4X+9ECjpYKwAiino71T/AdxdXEJWTouXAzGFVALs+iv/G47BD4cNIvHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJxhpM6knAVots8/GtsY+BfaTrZcJRgNmEpjR3gTCEOfJW16u6
	POIycMdMvj4hpdA9HFeawHLOyxCkubqaqyaTaOf6ksmvV6j5z3NVGBkNVgg04w==
X-Gm-Gg: ASbGncuj9YcOGzOf2Z9nNFwkEQHjC+T9JFI25zA4w6ztZ22mteq0mIYk55rOiJiwE+4
	eZyM1sNal6bRAuXgfo14OqfRAD013U1l/oJnJTwJvLpqm7QLXbSCe3zSq541r5ajSbn7q0hx237
	slJpS7mH8BobMzNtKdEmAOiqd92EYAUFub49+i06sLCI/SV8sI5RAmWntHPIytRnkRb8svxbsq9
	0Vx62vH5rk4jwE8qLRDne6HHM647Q7zw3PKJ+EcYY5LBvL1eZkZ2SkfOpNydPPNKl9R+QXdCFD7
	2XOzse56WsLgz/NoyU4tLERGxl+cJQM3lkp/lDXU9xUXoTK67VJFpd54JhqponG9RwVEb9g7aQ5
	Y+Iodc5GuWT7+NLgct49xDdY+fLrgl30uY/OkM0Eg0WJbXwWEuIsO/VkooDYrL35rcQ==
X-Google-Smtp-Source: AGHT+IEyuEKgFjJFareaGDtD3EzsOKQYaexatqTxOyLc+3Ue07rsxuTbmgSbPmXxlTbRiM1MUe352Q==
X-Received: by 2002:a05:620a:29d1:b0:7d3:f8bd:f34c with SMTP id af79cd13be357-7d3fbf9cab7mr379580285a.10.1750441546166;
        Fri, 20 Jun 2025 10:45:46 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:45 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 34/42] selinux: introduce selinux_state_has_perm()
Date: Fri, 20 Jun 2025 13:44:46 -0400
Message-ID: <20250620174502.1838-35-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
References: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
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
index 61716e17538d..5b690194b86a 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1689,6 +1689,43 @@ int cred_other_has_perm(const struct cred *cred, const struct cred *other,
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
index 27efe6f05d65..21efa17b4d56 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5298,16 +5298,16 @@ static int selinux_inet_sys_rcv_skb(struct selinux_state *state,
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
@@ -5327,8 +5327,9 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
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
@@ -5388,8 +5389,8 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
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
@@ -5397,8 +5398,9 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
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
@@ -5582,9 +5584,9 @@ static int selinux_sctp_process_new_assoc(struct sctp_association *asoc,
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
@@ -5952,8 +5954,9 @@ static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 	}
 
 	if (secmark_active)
-		if (avc_has_perm(se_state, peer_sid, skb->secmark,
-				 SECCLASS_PACKET, PACKET__FORWARD_IN, &ad))
+		if (selinux_state_has_perm(se_state, peer_sid, skb->secmark,
+					   SECCLASS_PACKET,
+					   PACKET__FORWARD_IN, &ad))
 			return NF_DROP;
 
 	if (netlbl_enabled())
@@ -6034,8 +6037,9 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 		return NF_DROP;
 
 	if (selinux_secmark_enabled())
-		if (avc_has_perm(sksec->state, sksec->sid, skb->secmark,
-				 SECCLASS_PACKET, PACKET__SEND, &ad))
+		if (selinux_state_has_perm(sksec->state, sksec->sid,
+					   skb->secmark, SECCLASS_PACKET,
+					   PACKET__SEND, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
 	if (selinux_xfrm_postroute_last(sksec->sid, skb, sksec->state, &ad,
@@ -6161,8 +6165,8 @@ static unsigned int selinux_ip_postroute(void *priv,
 		return NF_DROP;
 
 	if (secmark_active)
-		if (avc_has_perm(se_state, peer_sid, skb->secmark,
-				 SECCLASS_PACKET, secmark_perm, &ad))
+		if (selinux_state_has_perm(se_state, peer_sid, skb->secmark,
+					   SECCLASS_PACKET, secmark_perm, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
 	if (peerlbl_active) {
@@ -6171,14 +6175,14 @@ static unsigned int selinux_ip_postroute(void *priv,
 
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
 
@@ -7081,10 +7085,10 @@ static int selinux_ib_pkey_access(void *ib_sec, u64 subnet_prefix, u16 pkey_val)
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
@@ -7106,10 +7110,10 @@ static int selinux_ib_endport_manage_subnet(void *ib_sec, const char *dev_name,
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
@@ -7721,6 +7725,7 @@ int selinux_state_create(const struct cred *cred)
 {
 	struct task_security_struct *tsec = selinux_cred(cred);
 	struct selinux_state *parent = tsec->state;
+	u32 creator_sid = tsec->sid;
 	struct selinux_state *newstate;
 	int rc;
 
@@ -7736,6 +7741,8 @@ int selinux_state_create(const struct cred *cred)
 	if (!newstate)
 		return -ENOMEM;
 
+	newstate->creator_sid = creator_sid;
+
 	refcount_set(&newstate->count, 1);
 	INIT_WORK(&newstate->work, selinux_state_free);
 
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 5c6c07033711..cf437d0479f5 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -179,6 +179,10 @@ int cred_other_has_perm(const struct cred *cred, const struct cred *other,
 int task_obj_has_perm(const struct task_struct *s, const struct task_struct *t,
 		      u16 tclass, u32 requested, struct common_audit_data *ad);
 
+int selinux_state_has_perm(struct selinux_state *state, u32 ssid, u32 tsid,
+			   u16 tclass, u32 requested,
+			   struct common_audit_data *ad);
+
 u32 avc_policy_seqno(struct selinux_state *state);
 
 #define AVC_CALLBACK_GRANT		1
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 99c5f1771e1a..df3ea20f2026 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -111,6 +111,7 @@ struct selinux_state {
 
 	refcount_t count;
 	struct work_struct work;
+	u32 creator_sid; /* SID of namespace creator */
 	unsigned short depth;
 } __randomize_layout;
 
-- 
2.49.0

