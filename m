Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36FD2ECEB4;
	Tue, 17 Jun 2025 14:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169210; cv=none; b=mPAKJv0sNLiJ1BSNIQWuJTYNTzowOvV66IbIKUe89zcmYaslkj2TiUZ6m+TNWRCjKVDAamjB63SLC0hNtOz0umndfvgxt0f4oaLWSAxvRqrIlwo43xah2NoH4s/folB91hOr4GfWbDnyZqGE2VVt2IgkjONjIPIeFGNWkp9t/M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169210; c=relaxed/simple;
	bh=LZzSLDvYrS2hFKI7AllSW+kKN4Yg+F903SIMcN44L6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5pKXzPxfavBpQQhXagjxwuRWp+WBB4Kw1RcuPAb3uzIlJuEI7YIB6HQrWylV0qOxOvLSg7LGH03zZ2HEKQhO0BXSGe85gk2oeTFLkEjcrE/lrhXM8UBfz3MHDTt8TAy0FX46NQyY0kQREZMl9fOyNhnmeCmLqXE+UWRbBNTC9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OG25gI9x; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG25gI9x"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c5f720c717so722447385a.0;
        Tue, 17 Jun 2025 07:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169207; x=1750774007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RkL0KI0NRw6aWE26zoj9IucYtjpO3syaN0f9CNWg9Q=;
        b=OG25gI9xa1DUgeXf+DovpBSKBhV9G3COXxn2CcW27eJO6ugHCQ4RBXhrqp2o8Cn0ao
         nhqrHbzP7ZE4cqlvBRWBxuNCKv0+8DGkGpzhKljF31LlNe8A4hmCvn9scBfFWXjsPdQm
         OVn7BE3IxR6FXg6AcIkOnVFp8pe5REe3uuv6lDiaMPUlCUMaz+LfsUfkrRGvu1jPKZCP
         F3yruSsnYNPxoOLeqmSPeoc4K7SbQC7+YgcIrrFTGwJ8yOpaAkFNj++F4Bj89e21a+fU
         2zAFF6UQY2t+o25U4pHeycqCKr097NMp7ghMRNxEJDkd+mrKPqsy0Ive8rKjjnlJzEc2
         3OPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169207; x=1750774007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RkL0KI0NRw6aWE26zoj9IucYtjpO3syaN0f9CNWg9Q=;
        b=H2pKE6Z+/XgvNGEwSte2zuxc08mPUGosRXn8we9DH6P74ZV7blr7tAhIig13P7Cy9h
         0OqzD1g6j64nV6NolTdnU8dEfEinQ/jBKeDysL/qxHOEUhY6Tpze5S8vQHNNP0iphHO7
         L13FSG53agV6/hk+yJL//UzU0qWeZON00q01pBgrBKSnx+4XU8WKPlte8X25mtXfD9w9
         h5uaVYS+XU2rYCYpJA6oGz2g+mCudDwFEAx99GmeWz+LL0pSsajgvSkMscLKbdIuDn4R
         9+Y3vxLN+5JpUSZPdPP6aHIWsekaAL8h8kmPfD+arz17VFWPE45ewxbwc9luSue9H3mk
         nS8w==
X-Forwarded-Encrypted: i=1; AJvYcCV+xmDX+LH9LmFmCVXrADQETYICq3KsQ9K63AIKNI4iIRhzgdQQK9PdwVRAonglsKhcZ0+0PMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTsUiIP+WKBJXpgwrhrNujnOmbcJW0GBsSTX4Sdwdgd0zAEukT
	AiPk+PruYEzlDTu3qGVUSx0y9PAYxJ8SfSVcivxgGlKmWpxizMy/9XEeuvYMMg==
X-Gm-Gg: ASbGncsAvng1PMVc38ADpzEbbYZvcCdRIT6f1lDx32HFtlboiRJrRUB5eO+CLSV/VjA
	nLbd8JZMN+xXmTtzgeXwt/WFWhOiTg1AvUK0i/DaC2WIXhLyZNhr5sXWQybg1EecS9767sKa0pl
	wDhtJrAlWO4sYkQJkWhQDZtT0agSjLVIrEwF7R332Ww9Op0PowflY/otujGQ1vBKiz3VIAlw+In
	ffxmLuONE80PBNxbJoHQW2017E8pfXpY9usWo+ukZVTkMTBYZU9DnwFuDN2mmRoJx4JrZfTZP0V
	6I8rxWlh4Lo0XwuqQeClrmUz/MGNjC5N3E8BJp5xKztEX6lhfZAqYQlXVHIuRYyq8ghOKIUggVg
	kA1qo2FOqJzjD0Rc3W42VdQDpEEgayfJ1q65w6cUbr5W9FkV7rASE6ZUgDWbZdtHYjBczF0Fuu4
	Ei
X-Google-Smtp-Source: AGHT+IHGWj3dzT/H+0+I1PbQSoOf5YcJP1VSdEomfYLK1g0IhQbjyZHb2veJlHi9Rr2JktOK92m/Gw==
X-Received: by 2002:a05:620a:2412:b0:7cd:45ec:aac6 with SMTP id af79cd13be357-7d3c68563b4mr1813755885a.24.1750169207097;
        Tue, 17 Jun 2025 07:06:47 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:46 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 34/42] selinux: introduce selinux_state_has_perm()
Date: Tue, 17 Jun 2025 10:05:21 -0400
Message-ID: <20250617140531.2036-35-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
References: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
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
index 8ea1402bd84f..1513eb6efb64 100644
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
index ac3f818675d1..5cd49ca2e2b2 100644
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

