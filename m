Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0538D298CC9
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314640; cv=none; b=lilvAPryiK0oXpnnz/hwHAjCvAi8VYxQFFTez1CrrnS4OPLeC7dj8ZXYlG6mtKP+QKMV/7Kf457hYMdAJqsMOdav7bIUxrn7VnHHrIjWWCCtlWhsQL+moHaeDdw+cnYiM0AqGguTg3yt1BAypWw1yGFTHvM4+M8+zC5vgXxOfyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314640; c=relaxed/simple;
	bh=ibTo3UFsEwBKo+ZXbiVuWVCtHw6ZrmUKS6q4eAeaago=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNqNY3I7fbKar9K2qQ/e5Hk4lbRci8ZZG6FApIZOHhtDdnFxt1nN1MjngSz2Mt2xmuUGXl+RIpXZcVGwBaXyeZgdOeGWGGeOUvKJILo0MU0avcnwcm+IiD21n2GQZ09KxG8mhvi/pRAKQc/OOxOp51qJ2/a6PRbjK1r6Rd8MSg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PICGwlUy; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PICGwlUy"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47662449055so5407291cf.1
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314638; x=1747919438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYZrUN4cMku20wpzBHw+j6RDLG2y3wOA9T6mSwSA/KE=;
        b=PICGwlUy6N/4dXfuVCwq6xhJlgPJyH21mzZYsKZKTdHbwNevjbW0CsZxFaVEfFKXkF
         lpEWZsd/CS++EMLdzWIJwFtlaHGSITE7euoEH/CZXOqjbW96+ATJlxNla+0d8ccvdbcI
         p23KT0KtmH/JE5Jc33mtoZu3XkKTpO62JWDwoDMPfnusEhKvUd6Zmh3nexZsDawjNvEN
         3PPIeIx716IA6hGvzgpTbAt6hs6ol+STYW0hc0a5S6XXKhHmjYGZxhVzmM/noM6pSpBl
         WZt4MpXrK05y+IIbHC3kZToLis+JOzR3lvgPEOCIZaSZLHWg5Ue+piSAa3ToQqyhqxcT
         dXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314638; x=1747919438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYZrUN4cMku20wpzBHw+j6RDLG2y3wOA9T6mSwSA/KE=;
        b=wlZq5m9WNbn0QBYgg04LcPqr3XAdBbS+J/8gJ6ntydAAkz7Jp4Ag5LpY6bkJOIqoES
         R9W9Ui0Ynjb87W3TpPI3QaYojZlLUiHHhkx0ddcTuCATiptpKzoaSExE4DTHufk72vac
         3qjUy4tjtxxcGr9QLtHOagYbcc0BGLN8H/932cMnmPZG0JCilHieTnE2xRGzT64jECWA
         WxTohAPUzr3mCK7h5dWme7+/Eh8TbB5mbXZPdybLuZ8tD1muUrNimc9ZDWvhEOqvxito
         PPDr/tb/zZ2+ST9PM/xiVII8FNcizep1QeCnPE7FQlezJzuX+ZUowzRzbFvFBXX3nA1S
         pKWQ==
X-Gm-Message-State: AOJu0YznGnqZaXjfh02148w1G5ONK0K2RjAUQfWGfNMhrzY16X530pyV
	idRr34g+Mt208ytI2XqMY5HZ9dLuy0bbt6fI10m2M4ciu5CuS81iS9rJQA==
X-Gm-Gg: ASbGncsg2hcZsqXH934GhFykAgnhd1tQUlEMCeNDCDdibcoUHTkeiHYOFtEjp47nCO5
	UaGH2IZZKzH/9dspDaU+bHqjhvUR5+RsXEoz6sqszM8bS5WzkKajVmZi5KmgVzZONClm5RR6RgX
	COlR3VVKTpIZVgy2paV7MP+/ug1Mvrd+OG36KeuOQ7jU2OUKD1ghTO8JXKd09zrapXdwJ6WjtD+
	708qxEq/Lh2FOyACLNXZr7joGe7W4U3RuZ4l65Kc5bnAq7JYFE4VdVrKZ84hYkKeTIsEw600trc
	+F2BDCSlcTLJdOpJIZ0aqHfUNXtW/quRbUArTAo4OIWaqUO0slfEwDZ+P8R2689SufnShMuwZhV
	PBOOBB7hjVV3P5z5xihs6Y2oLr38pk5Z+OqHIrbOZdtv4DEZovtjnvg==
X-Google-Smtp-Source: AGHT+IE6w9GkzGr4iVTpH2u/LlRoSjniFlV73YY0auN5RlwHDn2KzlrfVwivOyO5pfUMsZR15bUoxw==
X-Received: by 2002:a05:622a:2284:b0:472:28d:62b0 with SMTP id d75a77b69052e-49495cdb3e6mr139016431cf.41.1747314637470;
        Thu, 15 May 2025 06:10:37 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:37 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 25/49] selinux: introduce selinux_state_has_perm()
Date: Thu, 15 May 2025 09:09:23 -0400
Message-ID: <20250515130947.52806-26-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
References: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
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
index efafe8a06908..cecbfea6b72a 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1678,6 +1678,43 @@ int cred_other_has_perm(const struct cred *cred, const struct cred *other,
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
index c70c228095b9..1b0fef00cc84 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5329,16 +5329,16 @@ static int selinux_inet_sys_rcv_skb(struct selinux_state *state,
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
@@ -5358,8 +5358,9 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
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
@@ -5419,8 +5420,8 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
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
@@ -5428,8 +5429,9 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
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
@@ -5610,9 +5612,9 @@ static int selinux_sctp_process_new_assoc(struct sctp_association *asoc,
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
@@ -5974,8 +5976,9 @@ static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 	}
 
 	if (secmark_active)
-		if (avc_has_perm(se_state, peer_sid, skb->secmark,
-				 SECCLASS_PACKET, PACKET__FORWARD_IN, &ad))
+		if (selinux_state_has_perm(se_state, peer_sid, skb->secmark,
+					   SECCLASS_PACKET,
+					   PACKET__FORWARD_IN, &ad))
 			return NF_DROP;
 
 	if (netlbl_enabled())
@@ -6056,8 +6059,9 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 		return NF_DROP;
 
 	if (selinux_secmark_enabled())
-		if (avc_has_perm(sksec->state, sksec->sid, skb->secmark,
-				 SECCLASS_PACKET, PACKET__SEND, &ad))
+		if (selinux_state_has_perm(sksec->state, sksec->sid,
+					   skb->secmark, SECCLASS_PACKET,
+					   PACKET__SEND, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
 	if (selinux_xfrm_postroute_last(sksec->sid, skb, sksec->state, &ad,
@@ -6183,8 +6187,8 @@ static unsigned int selinux_ip_postroute(void *priv,
 		return NF_DROP;
 
 	if (secmark_active)
-		if (avc_has_perm(se_state, peer_sid, skb->secmark,
-				 SECCLASS_PACKET, secmark_perm, &ad))
+		if (selinux_state_has_perm(se_state, peer_sid, skb->secmark,
+					   SECCLASS_PACKET, secmark_perm, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
 	if (peerlbl_active) {
@@ -6193,14 +6197,14 @@ static unsigned int selinux_ip_postroute(void *priv,
 
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
 
@@ -7103,10 +7107,10 @@ static int selinux_ib_pkey_access(void *ib_sec, u64 subnet_prefix, u16 pkey_val)
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
@@ -7128,10 +7132,10 @@ static int selinux_ib_endport_manage_subnet(void *ib_sec, const char *dev_name,
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
@@ -7733,6 +7737,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 static void selinux_state_free(struct work_struct *work);
 
 int selinux_state_create(struct selinux_state *parent,
+			 u32 creator_sid,
 			 struct selinux_state **state)
 {
 	struct selinux_state *newstate;
@@ -7742,6 +7747,8 @@ int selinux_state_create(struct selinux_state *parent,
 	if (!newstate)
 		return -ENOMEM;
 
+	newstate->creator_sid = creator_sid;
+
 	refcount_set(&newstate->count, 1);
 	INIT_WORK(&newstate->work, selinux_state_free);
 
@@ -7787,7 +7794,8 @@ static __init int selinux_init(void)
 {
 	pr_info("SELinux:  Initializing.\n");
 
-	if (selinux_state_create(NULL, &init_selinux_state))
+	if (selinux_state_create(NULL, SECINITSID_KERNEL,
+				 &init_selinux_state))
 		panic("SELinux: Could not create initial namespace\n");
 	enforcing_set(init_selinux_state, selinux_enforcing_boot);
 
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 03bba48040c7..511847a6b11c 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -176,6 +176,10 @@ int cred_other_has_perm(const struct cred *cred, const struct cred *other,
 int task_obj_has_perm(const struct task_struct *s, const struct task_struct *t,
 		      u16 tclass, u32 requested, struct common_audit_data *ad);
 
+int selinux_state_has_perm(struct selinux_state *state, u32 ssid, u32 tsid,
+			   u16 tclass, u32 requested,
+			   struct common_audit_data *ad);
+
 u32 avc_policy_seqno(struct selinux_state *state);
 
 #define AVC_CALLBACK_GRANT		1
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index dac0b9a5eb9f..78cbe39b1261 100644
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
index fb1a0f0c3fad..e92c8eb5723f 100644
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
2.49.0

