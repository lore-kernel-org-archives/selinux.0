Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730673090EF;
	Thu, 14 Aug 2025 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178061; cv=none; b=M10qNvdyiSeZnz6+PnlM0H7UV0rJfl1hfR+hXxpUe33Xpe5/SIyhA+K7m0k1qPDeejuGhr+bzvFk9qValXj150Jfen/fFeKvqfs87WfZ2iZjTqRI//4vZZPF5aD+GUlaGcnuPTmVXlYG93WfS31qqUqFrPuiwACBhr+ler0Aqmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178061; c=relaxed/simple;
	bh=bWnrOVx+VjsmWWqwmbMAzMg1BWKM9v5ftM68zSb2C8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zft0/XvwWrGsYPRLxS/O+fkuzbg5jp/jTTcrdnMbIzJ/S+lhjARsxajIvh8ZUzrSnegd2spSxtWTPOO1joo9h+TEfRZZun+OLoFlXxjJO7AF9azoMRUGN6vjTagJrE03sPxswiShflFp8tzRw9orHDVlXqadmmtf2sr6AhTYanM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFPtRP9Z; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFPtRP9Z"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e8706a6863so95990485a.3;
        Thu, 14 Aug 2025 06:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178057; x=1755782857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJeuVlUsxX54YXH7hKMPOh+Jj3LYYcb6+vJfGvPlVCY=;
        b=hFPtRP9ZmPJEWFJJXNf84FB41UBlwgK9IWmWSud4B0HDQYSzeDiZOcz94nT2Rxp7rZ
         VfHFgO6+uonCASgv4265nS6OYFJzV/0lX5xsUuLXoT5cu58LCIHPp01NPVlpS9IhBqkP
         TYe6YRgl4+epjQ60XG4GVnLdjJkoKhyPCRse+EqkTlZLgZKR4QW1mMkG/HBe+E5ywgY/
         Qvn1nK4QDkMQZpZU/6N7iYP8jUzQflaLdAepBm7cpAHdqF5Wp0LF66FVJ+eNcoQy/wlZ
         iKhEqCF/VEvcAuvin7rp7CWEPkfWZ5k002Pk91uHVASFJsXlnweWfGQAx4gMwkJWk6qQ
         1zUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178057; x=1755782857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJeuVlUsxX54YXH7hKMPOh+Jj3LYYcb6+vJfGvPlVCY=;
        b=KM4B0XXClL0Cim+s+nhiUPhkT0slwIPVJqGGHj7NTOu1HkHDyd5rvHA5ZmgFUuNERS
         PhGcTX3Ugro/5JpjMPwQJhGI8VX3LP50930wxNQ9oKYgRnmBP1Ypik0vvIeOzgl9n5OF
         6mee/3O+UBt+WpMybhYwe0OYX2pg0+DFNAItEL2r4QR1gDxgXh/kautSQhT99+3tU9uv
         HjrDTuLWZrN5bHiGFOyfqHIsR3/25m8527JhlB++gOmJsa3mUzEHMbAFoHF1o00rRkub
         Bfxo95k+eKzGO3hD0LYfuOMbxkgKXbItXIjNVZ2xXPJcDCzr2SWjZR4NKRSICSWnpQoZ
         931g==
X-Forwarded-Encrypted: i=1; AJvYcCX9+ZLYCHyS9XnosRQX86gkswfZrS8Wsjch4fqHQ620x8rxXmIkX9ikJm6zv41RvTGHKRGMiLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnl5lZrkSvmpaVJuOJDB0pfVyTDvyTI3EMIwwV1kzJ39Fbs9KE
	habYwVjVc1V8gHaZYXu9Lwopr83+6rGdlggXw1Ezr9QH3tQAyhUnV6MvXPw34g==
X-Gm-Gg: ASbGncuRqLJM57eqliQhTQ7NEQLIexQHltmlsP/8F6QfSkDjHSane0ZPMtrM7ZcHz3f
	cxyuymkkQ2vjgdIZZkjTKkEtmUtabOTjUlGlaCHwa+hztD8Hw1SAZSWcDVDJkMJHKUC9VQaLOs1
	8syrKglLMLULE8bnXCbDdqVoFNyiALBD+6poh9V0EvPvxLBljeWDwLe2pAhf1vkIKozH5k5erau
	u+ZofNk2wp7/JtI2oLgVLmhNjmDfPiZYbjy2dqL3eAdVeDlFbiZhCYy26T7yBrJRT1qzT4Cw9Bq
	wBjWn245P43psdQRPa+L2d91SKRTap2HE0Umg8L5zZWAL46gXiVWsxtpajXXpKj+tmAsqy55vUK
	jw13SdsedPUIEBTFiZcJqk612Ekd20bAAiz2ezZj0mfixWgrZM62twlmh5AhSCEvHvOD6VVimFe
	BM3blvhqtJuyAKF9YSe1R6PfzR1A==
X-Google-Smtp-Source: AGHT+IEkxEm1wI+rT4gjjVp2jTiitN+VRp9AQr8dJ3P/dtV5nfdTomNmIOwXB8hlCMWEwx/orvWJ9g==
X-Received: by 2002:a05:620a:19a1:b0:7e8:3d43:1661 with SMTP id af79cd13be357-7e8705ad5e4mr464328685a.63.1755178056573;
        Thu, 14 Aug 2025 06:27:36 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:36 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 34/42] selinux: introduce selinux_state_has_perm()
Date: Thu, 14 Aug 2025 09:26:25 -0400
Message-ID: <20250814132637.1659-35-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
References: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
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
index 01405d1fb546..1095b7720eb8 100644
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
index 71ccd86c5303..8a32f5655980 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5310,16 +5310,16 @@ static int selinux_inet_sys_rcv_skb(struct selinux_state *state,
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
@@ -5339,8 +5339,9 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
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
@@ -5400,8 +5401,8 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
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
@@ -5409,8 +5410,9 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
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
@@ -5594,9 +5596,9 @@ static int selinux_sctp_process_new_assoc(struct sctp_association *asoc,
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
@@ -5964,8 +5966,9 @@ static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 	}
 
 	if (secmark_active)
-		if (avc_has_perm(se_state, peer_sid, skb->secmark,
-				 SECCLASS_PACKET, PACKET__FORWARD_IN, &ad))
+		if (selinux_state_has_perm(se_state, peer_sid, skb->secmark,
+					   SECCLASS_PACKET,
+					   PACKET__FORWARD_IN, &ad))
 			return NF_DROP;
 
 	if (netlbl_enabled())
@@ -6046,8 +6049,9 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 		return NF_DROP;
 
 	if (selinux_secmark_enabled())
-		if (avc_has_perm(sksec->state, sksec->sid, skb->secmark,
-				 SECCLASS_PACKET, PACKET__SEND, &ad))
+		if (selinux_state_has_perm(sksec->state, sksec->sid,
+					   skb->secmark, SECCLASS_PACKET,
+					   PACKET__SEND, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
 	if (selinux_xfrm_postroute_last(sksec->sid, skb, sksec->state, &ad,
@@ -6173,8 +6177,8 @@ static unsigned int selinux_ip_postroute(void *priv,
 		return NF_DROP;
 
 	if (secmark_active)
-		if (avc_has_perm(se_state, peer_sid, skb->secmark,
-				 SECCLASS_PACKET, secmark_perm, &ad))
+		if (selinux_state_has_perm(se_state, peer_sid, skb->secmark,
+					   SECCLASS_PACKET, secmark_perm, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
 	if (peerlbl_active) {
@@ -6183,14 +6187,14 @@ static unsigned int selinux_ip_postroute(void *priv,
 
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
 
@@ -7093,10 +7097,10 @@ static int selinux_ib_pkey_access(void *ib_sec, u64 subnet_prefix, u16 pkey_val)
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
@@ -7118,10 +7122,10 @@ static int selinux_ib_endport_manage_subnet(void *ib_sec, const char *dev_name,
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
@@ -7735,6 +7739,7 @@ int selinux_state_create(const struct cred *cred)
 {
 	struct task_security_struct *tsec = selinux_cred(cred);
 	struct selinux_state *parent = tsec->state;
+	u32 creator_sid = tsec->sid;
 	struct selinux_state *newstate;
 	int rc;
 
@@ -7750,6 +7755,8 @@ int selinux_state_create(const struct cred *cred)
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
index f6b6482301fc..145ab528d71e 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -111,6 +111,7 @@ struct selinux_state {
 
 	refcount_t count;
 	struct work_struct work;
+	u32 creator_sid; /* SID of namespace creator */
 	unsigned short depth;
 } __randomize_layout;
 
-- 
2.50.1

