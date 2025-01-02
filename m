Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C7715C14B
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836359; cv=none; b=OvICP3voWXi8ciWRi8DyleHrPYpjH6rbqWcIxGP8gp608iBkHJlufGkyreAvcJnFHKwH1S77xdmU4QnCxJbCoPQe+917MzmI3D0Arax4TSYfrpoABqYwy7zDksnGJk1idZp4D2/siZqRBtYgx3g2CKxIZ7S78jfmQ1iW0UpCEf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836359; c=relaxed/simple;
	bh=6yABFnon6lWmAIEfDwjauDvWxlakaJ5VCIiBBNtxl/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WMo78kYr6UKtPFn842tz1C65+yahpYUwCH8f095TKqeN9upGxgpFT/H5bvc6CpY7f29jm+21LnWbKwmfSpPxqBJjUz7lHC7X/++2Qd2FRMF63b+c2VBBo479y5kKKuXLTBTPe9+y0YGwx3vhfTT5PhzGU8oeCPCsZaP236qsl1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBmm9c/M; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBmm9c/M"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-467b086e0easo59350691cf.1
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836354; x=1736441154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueWae7UAsncssRcZaGi8g3eHnW0Xddpnc0FDay9WJEI=;
        b=KBmm9c/M5g3BwjSXqJVMYno4UfZ6AofD76wHMKYDRfz21D/UkX/Su8vUZUCUTSD5mv
         8NzBHQ8pjOe/mMyABN/BiNYGPuFG674tN+uK9cc8ZToN2PVsM3KdDZaQ+2k2+EpP3WBb
         k1AfKLjRiTTktG5SVy1WbRtdV+xxjWvMUZ3LMjkOQLoCDemsuABjOoBZuQwkZ44u0jQT
         9u5YQfIeawrnXMDyFnrt8uXWms3Z00Y4Q4GvZcVXwnwOiH6f7jaUEpC5bkzcjXJDoz4E
         YTk1NwtR5AwoI5j3cgBCeUNdTDUI766wdqeamjzpSTZj35C5F9bkggyXrAAC8+AnPx7w
         nY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836354; x=1736441154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueWae7UAsncssRcZaGi8g3eHnW0Xddpnc0FDay9WJEI=;
        b=NFZq4vJVj2KKYHGHx8yggRiA9J5xoke3eoSLv/F75vzzWHUPyurRibekAETb+Ay5aT
         RMMG7fLSIBkIPpxRbCa7yn5855ZAbU/2TMTHF9GAvisFkRxbkKfU/ndbCqnW/13Dwqzy
         Tjw35H/lBR3eNn9kzyRCBdZJW0rQ8RXLAdap++MbrMK1uisGN4xDR+A+FLmprkAlVm1d
         Sv83dxvZQdk+B52oVpdH77Hz0gIsDEiCH8Fr8gwbyF2JGMZdmZBNfaIGSGCSrxUgu6R1
         c75+Nj9lCC6FwnuV7Nd0qGDMNKRAZtuhEnQ7iA9FEHJLSlqReKv1xE3o/GxW8ly79UFc
         BCcQ==
X-Gm-Message-State: AOJu0Yz1PBTcbCVgaCZxDFURMNtW2B5ZusYWwhrzmzI790AITBuXb510
	o/9v++niCNidZlOQKcDOaQWGur5bxHlF8TQOsPCZ8NnV8PkZTy1Pu67tHQ==
X-Gm-Gg: ASbGncvPgBzVx5AbLaRayscxBkq5NpGyiBL7OKGOsnwB65z/s7eS6/5ZROLWhlDL0bV
	1AdDfxcPLnHxGBsmWwadIPEbdvakntks/60OBqkgAYa59YpoDKuWSESca9EP7Ix4tFC4AhgpCs2
	5DbRYALKNmAdg06jFjQMTp3Pu2HPsXdS/JkeiPjVBZaLMly0GQnJLh5Q6P/1MLTL0TY9ecc9SDQ
	eXyDQA6vkv0R2/p1nrsXR+cXMtoWf6iL4k30+a2opBsZyGrLHSMB55q+F5HLWr0LWlAM9jtON2p
	NnV+KbEzhkzvQuXU/yH0KdrwLJWaGShAs5Ppe9IxkxSb5nQ7pWL08qEe9jzTy19HtLhREA==
X-Google-Smtp-Source: AGHT+IGRsxlFvpWwuAs6Jsf8u4ukU0RQWawkmzwygq3OKeJPCK52xVI55nm6ot0OgOVUWv0WX97yWg==
X-Received: by 2002:ac8:5754:0:b0:466:9738:22de with SMTP id d75a77b69052e-46a4a988996mr770073281cf.41.1735836352271;
        Thu, 02 Jan 2025 08:45:52 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:51 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 25/44] selinux: introduce selinux_state_has_perm()
Date: Thu,  2 Jan 2025 11:44:50 -0500
Message-Id: <20250102164509.25606-26-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
References: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
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
 security/selinux/avc.c              | 37 +++++++++++++++
 security/selinux/hooks.c            | 72 ++++++++++++++++-------------
 security/selinux/include/avc.h      |  4 ++
 security/selinux/include/security.h |  3 +-
 security/selinux/selinuxfs.c        |  3 +-
 5 files changed, 85 insertions(+), 34 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 250d56dae487..a533385d0149 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1662,6 +1662,43 @@ int cred_other_has_perm(const struct cred *cred, const struct cred *other,
 	return 0;
 }
 
+/**
+ * selinux_state_has_perm - Check and audit permissions on a (ssid, tsid) pair
+ * @state: SELinux state
+ * @ssid: source security identifier
+ * @tsid: target security identifier
+ * @tclass: target security class
+ * @requested: requested permissions, interpreted based on @tclass
+ * @auditdata: auxiliary audit data
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
index 9e09bfff8392..3fd787bf5cc6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5158,16 +5158,16 @@ static int selinux_inet_sys_rcv_skb(struct selinux_state *state,
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
@@ -5187,8 +5187,9 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
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
@@ -5248,8 +5249,8 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
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
@@ -5257,8 +5258,9 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
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
@@ -5439,9 +5441,9 @@ static int selinux_sctp_process_new_assoc(struct sctp_association *asoc,
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
@@ -5803,8 +5805,9 @@ static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 	}
 
 	if (secmark_active)
-		if (avc_has_perm(se_state, peer_sid, skb->secmark,
-				 SECCLASS_PACKET, PACKET__FORWARD_IN, &ad))
+		if (selinux_state_has_perm(se_state, peer_sid, skb->secmark,
+					   SECCLASS_PACKET,
+					   PACKET__FORWARD_IN, &ad))
 			return NF_DROP;
 
 	if (netlbl_enabled())
@@ -5885,8 +5888,9 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 		return NF_DROP;
 
 	if (selinux_secmark_enabled())
-		if (avc_has_perm(sksec->state, sksec->sid, skb->secmark,
-				 SECCLASS_PACKET, PACKET__SEND, &ad))
+		if (selinux_state_has_perm(sksec->state, sksec->sid,
+					   skb->secmark, SECCLASS_PACKET,
+					   PACKET__SEND, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
 	if (selinux_xfrm_postroute_last(sksec->sid, skb, sksec->state, &ad,
@@ -6012,8 +6016,8 @@ static unsigned int selinux_ip_postroute(void *priv,
 		return NF_DROP;
 
 	if (secmark_active)
-		if (avc_has_perm(se_state, peer_sid, skb->secmark,
-				 SECCLASS_PACKET, secmark_perm, &ad))
+		if (selinux_state_has_perm(se_state, peer_sid, skb->secmark,
+					   SECCLASS_PACKET, secmark_perm, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
 	if (peerlbl_active) {
@@ -6022,14 +6026,14 @@ static unsigned int selinux_ip_postroute(void *priv,
 
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
 
@@ -6912,10 +6916,10 @@ static int selinux_ib_pkey_access(void *ib_sec, u64 subnet_prefix, u16 pkey_val)
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
@@ -6937,10 +6941,10 @@ static int selinux_ib_endport_manage_subnet(void *ib_sec, const char *dev_name,
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
@@ -7530,6 +7534,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 static void selinux_state_free(struct work_struct *work);
 
 int selinux_state_create(struct selinux_state *parent,
+			 u32 creator_sid,
 			 struct selinux_state **state)
 {
 	struct selinux_state *newstate;
@@ -7539,6 +7544,8 @@ int selinux_state_create(struct selinux_state *parent,
 	if (!newstate)
 		return -ENOMEM;
 
+	newstate->creator_sid = creator_sid;
+
 	refcount_set(&newstate->count, 1);
 	INIT_WORK(&newstate->work, selinux_state_free);
 
@@ -7584,7 +7591,8 @@ static __init int selinux_init(void)
 {
 	pr_info("SELinux:  Initializing.\n");
 
-	if (selinux_state_create(NULL, &init_selinux_state))
+	if (selinux_state_create(NULL, SECINITSID_KERNEL,
+				 &init_selinux_state))
 		panic("SELinux: Could not create initial namespace\n");
 	enforcing_set(init_selinux_state, selinux_enforcing_boot);
 
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 967848594270..95fed265071d 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -174,6 +174,10 @@ int cred_other_has_perm(const struct cred *cred, const struct cred *other,
 int task_obj_has_perm(const struct task_struct *s, const struct task_struct *t,
 		      u16 tclass, u32 requested, struct common_audit_data *ad);
 
+int selinux_state_has_perm(struct selinux_state *state, u32 ssid, u32 tsid,
+			   u16 tclass, u32 requested,
+			   struct common_audit_data *ad);
+
 u32 avc_policy_seqno(struct selinux_state *state);
 
 #define AVC_CALLBACK_GRANT		1
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 261a6971f262..bf2d13227113 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -110,11 +110,12 @@ struct selinux_state {
 
 	refcount_t count;
 	struct work_struct work;
+	u32 creator_sid; /* SID of namespace creator */
 } __randomize_layout;
 
 extern struct selinux_state *init_selinux_state;
 
-int selinux_state_create(struct selinux_state *parent,
+int selinux_state_create(struct selinux_state *parent, u32 creator_sid,
 			 struct selinux_state **state);
 void __put_selinux_state(struct selinux_state *state);
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index c3308a5c168d..8c159b88615f 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -367,7 +367,8 @@ static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 			goto out;
 		}
 		tsec = selinux_cred(cred);
-		if (selinux_state_create(state, &tsec->state)) {
+		if (selinux_state_create(state, current_sid(),
+					 &tsec->state)) {
 			abort_creds(cred);
 			length = -ENOMEM;
 			goto out;
-- 
2.47.1

