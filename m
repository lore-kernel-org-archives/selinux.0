Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8872E2882C7;
	Tue, 20 May 2025 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742504; cv=none; b=XbPX1enfD24l6Y7ZLaAwT9ov0KZMq7BbDmHSA9P+ecJF5vSaBXlavOZOhphJXzACp/jDyIf9ieOYfFsl/NOCEAGvhEqjQLw/G/LLkxZq9zyjygNOLEvDoOlj3VbQcKAsUMLlqHYU3V/r/KXjfUkM12VY1L68+wlBEwa+r+Ov20Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742504; c=relaxed/simple;
	bh=KnICzQclYSCt4TP7OH8plazFIxJRI8gy4if7YnXMDeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QukCYKWmHcOBNlR83JETcC8L7Va8YLwq5xzdb+UA9SjHZdJMAlkATs3PW+dmPUB7Yqm3v7tLD6HNMeLgK0+Kuq8wGJgXSfD/zaJOijl5lINb8UqyTDjVhcnwcP9XFvtbcjmLTDcjH7/S1OMCrRCtzgi9lQIjXEvrhtGXn18+3xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMKjw5I6; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMKjw5I6"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2e41064e247so1603024fac.3;
        Tue, 20 May 2025 05:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742501; x=1748347301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0awAOPcx59TJFe2CnIJsloxzjbKlKPOCaNQj0WXjF/4=;
        b=KMKjw5I6ZMG85RDnYJdUQKNtkIE6qfrDWGY825eD3Bl8LbaAzIdBEfqVkE0olpI0+e
         KH9dnmHiLMwVTXx7AJ9aE7A4Aix+BtwJjyusZ213SMKQLJiEyEsiM6kbCU89xl+CnlW3
         973G95Kap6o0x7PIdvyk6qT0geraUYB+BV3Pe6Af6bmMoifNmDTJtcYC9VDOLQ2wVQyq
         toOyxdZlyyEUbo9v7cMakwVTxmO2iPbinguK4gDq30t2+5sMSNSEg8BhKqHKRCHY+knq
         u6lhLnr7fQ/cCGaW9cmN7gzWwca/o32rOuFBxHmsdKZKPBnrnRyyJOB7I5kYwUh3/q4H
         JX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742501; x=1748347301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0awAOPcx59TJFe2CnIJsloxzjbKlKPOCaNQj0WXjF/4=;
        b=li2yAhW+NSI6MiwQell46pnlnwCgirWPm4BGwYM8kXhvT0RA8XUiq8bfzvpa977BeO
         wySS7GujljdbX4O8woDyUzBJ/GAKOeqhdXJVnOs34cWwAHbfY0t6NjFufGUnR6cm66Qv
         JSanHexeTGN8ZSZD0Rh5n0GvFZV2b7GXldMPcX3WCPoaxWK3E03qwnwrdDRs9KC/MgXK
         sUSspAWKU/bD12rOxVz6LdW3UzE+UW9aHUYTZebxn06aOKZAtQQHSWLYjbt7Kv+m/oRE
         UlxCTyIELrqBqfCPLwCJclzvPYQ0UeVxvE+LsMJSa2hvSRQ9Zf+0Q2agWoE3Poglabg2
         JxUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDR2jmWoVt4Wt8SZHcaD/Q7sbH08tICxgR9yQ1gLk5+Dvj5FB286rTmyHyyfZesG6AlGla+oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJdFdhEbHEy9ZRiUsWbzOj15KdVUsFz+bTimhxcQlRAQrIz7g3
	GF5OKBGU7dhNFTRsVnJ0NXhvqKJ4OQkS4G0ieN/q1bHBGsF0JR4eS/ueYHJP2g==
X-Gm-Gg: ASbGnctO9YBML+YXQnRo64kAI7pO1GNpegrUDGwQIbkqGDf8pbWhhsdRm4qGWvhiglC
	yHaTK5wEGQRZougnr9srXgcDq0hCbT7v+awqCHyBZgTb08/DEhLFmCprfgH8if+ScLwwD14rkyj
	AVa1CgpMhjZiOZ7QLiKKLDD2yvLfqynAeH2Raf1QLSVBpE1GkjG3w6d2IM2zqZNpvLde31rz1+Z
	EKcrBNCIKBNGN1XGqEvSdzqi0NFqDx6NcPx6LXp5ZerxFA/BqXWDiy5c7xBiu3jwFYvKE993MpF
	nQ03HVcFOkYD+HuaEU5Z9/bgyGvIoKBWj+KAPBpfpJr6BOIaq+xfGShNo13YEXXmfvTBSCsrCGF
	GYcBwzPqPz7JXFs218naAf2yQ4FVhwcBjOQdiXiK6kNtUwLfb4zJjzw==
X-Google-Smtp-Source: AGHT+IHYcBkIKalfDVtJmhbkwBEfFqHVUfth1bhoI8iJjvlzlRgwWAuCwKZuTghmJvGYGbP4Y/URRQ==
X-Received: by 2002:a05:6870:2a41:b0:2d5:336f:1b5c with SMTP id 586e51a60fabf-2e3c1f29813mr9893727fac.34.1747742500805;
        Tue, 20 May 2025 05:01:40 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:40 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 33/42] selinux: introduce selinux_state_has_perm()
Date: Tue, 20 May 2025 07:59:31 -0400
Message-ID: <20250520120000.25501-35-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
References: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
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
index ea07fa492e3b..185a528a01c4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5316,16 +5316,16 @@ static int selinux_inet_sys_rcv_skb(struct selinux_state *state,
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
@@ -5345,8 +5345,9 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
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
@@ -5406,8 +5407,8 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
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
@@ -5415,8 +5416,9 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
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
@@ -5600,9 +5602,9 @@ static int selinux_sctp_process_new_assoc(struct sctp_association *asoc,
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
@@ -5970,8 +5972,9 @@ static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 	}
 
 	if (secmark_active)
-		if (avc_has_perm(se_state, peer_sid, skb->secmark,
-				 SECCLASS_PACKET, PACKET__FORWARD_IN, &ad))
+		if (selinux_state_has_perm(se_state, peer_sid, skb->secmark,
+					   SECCLASS_PACKET,
+					   PACKET__FORWARD_IN, &ad))
 			return NF_DROP;
 
 	if (netlbl_enabled())
@@ -6052,8 +6055,9 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 		return NF_DROP;
 
 	if (selinux_secmark_enabled())
-		if (avc_has_perm(sksec->state, sksec->sid, skb->secmark,
-				 SECCLASS_PACKET, PACKET__SEND, &ad))
+		if (selinux_state_has_perm(sksec->state, sksec->sid,
+					   skb->secmark, SECCLASS_PACKET,
+					   PACKET__SEND, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
 	if (selinux_xfrm_postroute_last(sksec->sid, skb, sksec->state, &ad,
@@ -6179,8 +6183,8 @@ static unsigned int selinux_ip_postroute(void *priv,
 		return NF_DROP;
 
 	if (secmark_active)
-		if (avc_has_perm(se_state, peer_sid, skb->secmark,
-				 SECCLASS_PACKET, secmark_perm, &ad))
+		if (selinux_state_has_perm(se_state, peer_sid, skb->secmark,
+					   SECCLASS_PACKET, secmark_perm, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
 	if (peerlbl_active) {
@@ -6189,14 +6193,14 @@ static unsigned int selinux_ip_postroute(void *priv,
 
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
 
@@ -7099,10 +7103,10 @@ static int selinux_ib_pkey_access(void *ib_sec, u64 subnet_prefix, u16 pkey_val)
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
@@ -7124,10 +7128,10 @@ static int selinux_ib_endport_manage_subnet(void *ib_sec, const char *dev_name,
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
@@ -7739,6 +7743,7 @@ int selinux_state_create(const struct cred *cred)
 {
 	struct task_security_struct *tsec = selinux_cred(cred);
 	struct selinux_state *parent = tsec->state;
+	u32 creator_sid = tsec->sid;
 	struct selinux_state *newstate;
 	int rc;
 
@@ -7754,6 +7759,8 @@ int selinux_state_create(const struct cred *cred)
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
index 764023bb0340..e1c1b2da9256 100644
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

