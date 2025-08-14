Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19383009FD;
	Thu, 14 Aug 2025 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178049; cv=none; b=e2vVNAHMK7F7dIrNWiyuuyygKtlpufRArIYd7Jr1Ad37jmK8cCdDDP6lZ92Df79ndwVutymK3DX9EBMwLs8uqu4ymqeUbxoOEjAt7PBeLRYezT6/qlxF2ARY/NrUkNLplrKLLrvPajjlYE02kjSaTxyrghmOzcD+XO04f3sL6fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178049; c=relaxed/simple;
	bh=fNnVH1ilLXxbDH70KGNSaqu+nGrcmDbqarqCnXIwy/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0iAE1W+0TAGQKXNb6GiRb9KzGj6yl874XEma6KwqCI1DnEpzmuYws54R3GIExy2JhuE5LSW3yHuYmf9Wyxt1PPvPa/+ezXxm8tNUwWio6oBED3k3MSxpQkJIyzWow3khlSgF/pvfY2ak8uY90dtSemK0CLXpzYaW8dCqvfDE8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSP4oc2x; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSP4oc2x"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b10993301fso11590891cf.0;
        Thu, 14 Aug 2025 06:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178045; x=1755782845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDwbJoHXY9MXLM4LIE+VtNPBqtY5AFHy2SrzFebRSkw=;
        b=hSP4oc2xhzozoeaVGJ8BAqO7//PhMrUwFwxHmGE8P9wdW1rg2ZGsmTh/Es0pr61GrQ
         A7ECIXrao2RC2hOcjbgtIY7tTqAuObhgTUe4rW55TjTzXswg9TaHnKWQdsD6e560t3xL
         1tN4z8y4Y9c5lc3vowRIYKAeQcDoy2hzwj+q9FM6eRB4ojaVF/+nPs/N/C1QILJvkGPr
         u6q+l/ePAdM4QIhPUlY8ZYSXtlZHTyCfWX6/b65xQYwtP2zwrFnp5j0moeyFh8itrb7e
         Kffej+6LxbpPSlAf9taMaTr/3kRYeLyMcFgl7ctHgthApS2X/T4JIe2mcCgN3QtAquoG
         Essw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178045; x=1755782845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDwbJoHXY9MXLM4LIE+VtNPBqtY5AFHy2SrzFebRSkw=;
        b=stMzu9StZpf/HkmyN3nkVSkO9TzFQ9k1qADXor1+JtJAqrfebT5rTtb4P8Ywz4NwP/
         krUwuK5qTEJ0NxLyywygBhFxPiflNC0fh/hbiVD3tzSfcVRl0LJm16RlizJi7W+4+1vI
         +DUvw4pew6GKRgWcU89ubbmYv7ffSTAPLCMh1Ynd9xrqGhEizEn8sLi6D/rKAAoO2r6U
         K2Z9R357szjnm6ZhgsbMQSiImBZnZfLhU3bPNFUivfONIJ5EEZPH36r2rddNlfEonzjP
         q/6m0eL8ytsmYL35UTU9KwjvM5jCqM+W9pzN8OhQqOuO4+qT3XqZL6/aPkUNaQA06T4W
         rGFA==
X-Forwarded-Encrypted: i=1; AJvYcCVo5Z4ppRHK3F4MBor+zjnZZ8twKizMvW9g0+KgoOLSnlsb/jVJvvgOxO3eXolMZIonAn73yYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeSmhkimXsOz5iN+GeUgOQo54dB8qIrR+S1twSS+ZFEHnXIpQl
	IDijtW/PXz6gCU1nP9F83GE6suTjSw8DqdtMDY+AVE5xUNjY6qK49Qq/LNUQPQ==
X-Gm-Gg: ASbGncsfhw76bV9RE1tMuMntvWxLDiXHO4ABlGKgU2JUvP0t/9O/NCCjMljAJ7YNq1u
	sIkTYmpaaev1eEoup7DyFzkrsB5VvLz8/WDq9IT7xkQq07zcJ2xHmIvyjhNsM6zJW7trsMOyfgk
	XQj5IFvQEpMGFcXyrxp+PLn8eB+Gsjjc1kqp7XmIhZQSnF32CcdMQw+VKeb8SoBcqvWomyjYWc0
	76TARfhqM5YszxWBg5nT/4Uk/W2uwknQLVl8DXZkGpAkI9eRJpMRca+iq0TNJLyrl//ezBgVYsn
	vD7bLeliOQSY6PFFuYVo939FlwxeHHwHoIq6SWFf7FHAz/VP45VDT2AaCkidOb5Ymp+4IrN8Sd9
	4gNgZLRYaN3XrZqVZgb+yqv4Gi1TmTPu0sbyp8V3afLlztpCxhaBCxJwZPrVF9Sv+MpwfuPPnqt
	QKHji05htxBcty8jXz0ja2+/W/Ig==
X-Google-Smtp-Source: AGHT+IHtqNme2FTzuaKB5xzfZ+0OPpPPsTvH3brYKBT57tcDRtIVtK45H81S7y8Q2+c7+KcHWsl6dQ==
X-Received: by 2002:a05:622a:110:b0:4b0:77d4:ec1e with SMTP id d75a77b69052e-4b10a92001emr48812841cf.3.1755178044716;
        Thu, 14 Aug 2025 06:27:24 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:24 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 21/42] selinux: update hook functions to use correct selinux namespace
Date: Thu, 14 Aug 2025 09:26:12 -0400
Message-ID: <20250814132637.1659-22-stephen.smalley.work@gmail.com>
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

Update the SELinux hook functions to use the correct SELinux namespace
rather than always using the current SELinux namespace. This is
necessary for hook functions that can be called outside of process
context. In order to have a SELinux namespace available for use in all
such hook functions, this change saves a reference to the current
SELinux namespace in open file security blobs for use by send_sigiotask
and in sock security blobs for use in network input or forward hooks. It
also fixes a few remaining uses of current_selinux_state that should be
using cred_selinux_state() on an appropriate cred structure.

In order to correctly label nodes and network interfaces, the SELinux
namespace is passed from the hook functions to the sel_netnode and
sel_netif interfaces and cached along with the other information.
Similarly, where needed, the SELinux namespace is passed from the hook
functions to the selinux_netlbl and selinux_xfrm interfaces for use in
invoking various security server or AVC interfaces.

There are a few residual xfrm functions where we do not have a
SELinux namespace available currently. For now these functions
always use the init SELinux namespace.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c            | 169 +++++++++++++++++-----------
 security/selinux/include/netif.h    |   4 +-
 security/selinux/include/netlabel.h |  14 ++-
 security/selinux/include/netnode.h  |   4 +-
 security/selinux/include/objsec.h   |   5 +
 security/selinux/include/xfrm.h     |   8 +-
 security/selinux/netif.c            |  31 +++--
 security/selinux/netlabel.c         |  35 +++---
 security/selinux/netnode.c          |  26 +++--
 security/selinux/xfrm.c             |  26 +++--
 10 files changed, 206 insertions(+), 116 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e8cfd18a1cb1..99a83acfa19e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2092,14 +2092,14 @@ static int selinux_binder_transaction(const struct cred *from,
 	int rc;
 
 	if (mysid != fromsid) {
-		rc = avc_has_perm(current_selinux_state,
+		rc = avc_has_perm(cred_selinux_state(from),
 				  mysid, fromsid, SECCLASS_BINDER,
 				  BINDER__IMPERSONATE, NULL);
 		if (rc)
 			return rc;
 	}
 
-	return avc_has_perm(current_selinux_state, fromsid, tosid,
+	return avc_has_perm(cred_selinux_state(from), fromsid, tosid,
 			    SECCLASS_BINDER, BINDER__CALL, NULL);
 }
 
@@ -2127,7 +2127,7 @@ static int selinux_binder_transfer_file(const struct cred *from,
 	ad.u.path = file->f_path;
 
 	if (sid != fsec->sid) {
-		rc = avc_has_perm(current_selinux_state,
+		rc = avc_has_perm(cred_selinux_state(to),
 				  sid, fsec->sid,
 				  SECCLASS_FD,
 				  FD__USE,
@@ -2146,7 +2146,7 @@ static int selinux_binder_transfer_file(const struct cred *from,
 		return 0;
 
 	isec = backing_inode_security(dentry);
-	return avc_has_perm(current_selinux_state,
+	return avc_has_perm(cred_selinux_state(to),
 			    sid, isec->sid, isec->sclass, file_to_av(file),
 			    &ad);
 }
@@ -3868,10 +3868,19 @@ static int selinux_file_alloc_security(struct file *file)
 
 	fsec->sid = sid;
 	fsec->fown_sid = sid;
+	fsec->state = get_selinux_state(current_selinux_state);
 
 	return 0;
 }
 
+static void selinux_file_free_security(struct file *file)
+{
+	struct file_security_struct *fsec = selinux_file(file);
+
+	put_selinux_state(fsec->state);
+	fsec->state = NULL;
+}
+
 /*
  * Check whether a task has the ioctl permission and cmd
  * operation to an inode.
@@ -3908,7 +3917,7 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 		return 0;
 
 	isec = inode_security(inode);
-	rc = avc_has_extended_perms(current_selinux_state,
+	rc = avc_has_extended_perms(cred_selinux_state(cred),
 				    ssid, isec->sid, isec->sclass,
 				    requested, driver, AVC_EXT_IOCTL, xperm,
 				    &ad);
@@ -4184,7 +4193,7 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
 	else
 		perm = signal_to_av(signum);
 
-	return avc_has_perm(current_selinux_state,
+	return avc_has_perm(fsec->state,
 			    fsec->fown_sid, sid,
 			    SECCLASS_PROCESS, perm, NULL);
 }
@@ -4559,9 +4568,15 @@ static int selinux_task_movememory(struct task_struct *p)
 static int selinux_task_kill(struct task_struct *p, struct kernel_siginfo *info,
 				int sig, const struct cred *cred)
 {
+	struct selinux_state *state;
 	u32 secid;
 	u32 perm;
 
+	if (cred)
+		state = cred_selinux_state(cred);
+	else
+		state = current_selinux_state;
+
 	if (!sig)
 		perm = PROCESS__SIGNULL; /* null signal; existence test */
 	else
@@ -4570,8 +4585,8 @@ static int selinux_task_kill(struct task_struct *p, struct kernel_siginfo *info,
 		secid = current_sid();
 	else
 		secid = cred_sid(cred);
-	return avc_has_perm(current_selinux_state,
-			    secid, task_sid_obj(p), SECCLASS_PROCESS, perm, NULL);
+	return avc_has_perm(state, secid, task_sid_obj(p),
+			    SECCLASS_PROCESS, perm, NULL);
 }
 
 static void selinux_task_to_inode(struct task_struct *p,
@@ -4797,6 +4812,7 @@ static int selinux_parse_skb(struct sk_buff *skb, struct common_audit_data *ad,
  * selinux_skb_peerlbl_sid - Determine the peer label of a packet
  * @skb: the packet
  * @family: protocol family
+ * @state: the SELinux state
  * @sid: the packet's peer label SID
  *
  * Description:
@@ -4808,7 +4824,8 @@ static int selinux_parse_skb(struct sk_buff *skb, struct common_audit_data *ad,
  * peer labels.
  *
  */
-static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u16 family, u32 *sid)
+static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u16 family,
+				   struct selinux_state *state, u32 *sid)
 {
 	int err;
 	u32 xfrm_sid;
@@ -4818,12 +4835,13 @@ static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u16 family, u32 *sid)
 	err = selinux_xfrm_skb_sid(skb, &xfrm_sid);
 	if (unlikely(err))
 		return -EACCES;
-	err = selinux_netlbl_skbuff_getsid(skb, family, &nlbl_type, &nlbl_sid);
+	err = selinux_netlbl_skbuff_getsid(skb, family, state, &nlbl_type,
+					   &nlbl_sid);
 	if (unlikely(err))
 		return -EACCES;
 
-	err = security_net_peersid_resolve(current_selinux_state, nlbl_sid,
-					   nlbl_type, xfrm_sid, sid);
+	err = security_net_peersid_resolve(state, nlbl_sid, nlbl_type,
+					   xfrm_sid, sid);
 	if (unlikely(err)) {
 		pr_warn(
 		       "SELinux: failure in selinux_skb_peerlbl_sid(),"
@@ -4838,6 +4856,7 @@ static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u16 family, u32 *sid)
  * selinux_conn_sid - Determine the child socket label for a connection
  * @sk_sid: the parent socket's SID
  * @skb_sid: the packet's SID
+ * @state: the SELinux state
  * @conn_sid: the resulting connection SID
  *
  * If @skb_sid is valid then the user:role:type information from @sk_sid is
@@ -4846,13 +4865,13 @@ static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u16 family, u32 *sid)
  * of @sk_sid.  Returns zero on success, negative values on failure.
  *
  */
-static int selinux_conn_sid(u32 sk_sid, u32 skb_sid, u32 *conn_sid)
+static int selinux_conn_sid(u32 sk_sid, u32 skb_sid,
+			    struct selinux_state *state, u32 *conn_sid)
 {
 	int err = 0;
 
 	if (skb_sid != SECSID_NULL)
-		err = security_sid_mls_copy(current_selinux_state, sk_sid, skb_sid,
-					    conn_sid);
+		err = security_sid_mls_copy(state, sk_sid, skb_sid, conn_sid);
 	else
 		*conn_sid = sk_sid;
 
@@ -5092,7 +5111,8 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 			break;
 		}
 
-		err = sel_netnode_sid(addrp, family_sa, &sid);
+		err = sel_netnode_sid(current_selinux_state, addrp, family_sa,
+				      &sid);
 		if (err)
 			goto out;
 
@@ -5342,7 +5362,8 @@ static int selinux_socket_unix_may_send(struct socket *sock,
 			    &ad);
 }
 
-static int selinux_inet_sys_rcv_skb(struct net *ns, int ifindex,
+static int selinux_inet_sys_rcv_skb(struct selinux_state *state,
+				    struct net *ns, int ifindex,
 				    char *addrp, u16 family, u32 peer_sid,
 				    struct common_audit_data *ad)
 {
@@ -5350,21 +5371,19 @@ static int selinux_inet_sys_rcv_skb(struct net *ns, int ifindex,
 	u32 if_sid;
 	u32 node_sid;
 
-	err = sel_netif_sid(ns, ifindex, &if_sid);
+	err = sel_netif_sid(state, ns, ifindex, &if_sid);
 	if (err)
 		return err;
-	err = avc_has_perm(current_selinux_state,
-			   peer_sid, if_sid,
+	err = avc_has_perm(state, peer_sid, if_sid,
 			   SECCLASS_NETIF, NETIF__INGRESS, ad);
 	if (err)
 		return err;
 
-	err = sel_netnode_sid(addrp, family, &node_sid);
+	err = sel_netnode_sid(state, addrp, family, &node_sid);
 	if (err)
 		return err;
-	return avc_has_perm(current_selinux_state,
-			    peer_sid, node_sid,
-			    SECCLASS_NODE, NODE__RECVFROM, ad);
+	return avc_has_perm(state, peer_sid, node_sid, SECCLASS_NODE,
+			    NODE__RECVFROM, ad);
 }
 
 static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
@@ -5373,6 +5392,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 	int err = 0;
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	u32 sk_sid = sksec->sid;
+	struct selinux_state *state = sksec->state;
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
 	char *addrp;
@@ -5383,8 +5403,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 		return err;
 
 	if (selinux_secmark_enabled()) {
-		err = avc_has_perm(current_selinux_state,
-				   sk_sid, skb->secmark, SECCLASS_PACKET,
+		err = avc_has_perm(state, sk_sid, skb->secmark, SECCLASS_PACKET,
 				   PACKET__RECV, &ad);
 		if (err)
 			return err;
@@ -5393,7 +5412,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 	err = selinux_netlbl_sock_rcv_skb(sksec, skb, family, &ad);
 	if (err)
 		return err;
-	err = selinux_xfrm_sock_rcv_skb(sksec->sid, skb, &ad);
+	err = selinux_xfrm_sock_rcv_skb(sksec, skb, &ad);
 
 	return err;
 }
@@ -5404,6 +5423,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family = sk->sk_family;
 	u32 sk_sid = sksec->sid;
+	struct selinux_state *state = sksec->state;
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
 	char *addrp;
@@ -5435,17 +5455,16 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	if (peerlbl_active) {
 		u32 peer_sid;
 
-		err = selinux_skb_peerlbl_sid(skb, family, &peer_sid);
+		err = selinux_skb_peerlbl_sid(skb, family, state, &peer_sid);
 		if (err)
 			return err;
-		err = selinux_inet_sys_rcv_skb(sock_net(sk), skb->skb_iif,
+		err = selinux_inet_sys_rcv_skb(state, sock_net(sk), skb->skb_iif,
 					       addrp, family, peer_sid, &ad);
 		if (err) {
 			selinux_netlbl_err(skb, family, err, 0);
 			return err;
 		}
-		err = avc_has_perm(current_selinux_state,
-				   sk_sid, peer_sid, SECCLASS_PEER,
+		err = avc_has_perm(state, sk_sid, peer_sid, SECCLASS_PEER,
 				   PEER__RECV, &ad);
 		if (err) {
 			selinux_netlbl_err(skb, family, err, 0);
@@ -5454,8 +5473,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	}
 
 	if (secmark_active) {
-		err = avc_has_perm(current_selinux_state,
-				   sk_sid, skb->secmark, SECCLASS_PACKET,
+		err = avc_has_perm(state, sk_sid, skb->secmark, SECCLASS_PACKET,
 				   PACKET__RECV, &ad);
 		if (err)
 			return err;
@@ -5521,7 +5539,8 @@ static int selinux_socket_getpeersec_dgram(struct socket *sock,
 		isec = inode_security_novalidate(SOCK_INODE(sock));
 		peer_secid = isec->sid;
 	} else if (skb)
-		selinux_skb_peerlbl_sid(skb, family, &peer_secid);
+		selinux_skb_peerlbl_sid(skb, family, current_selinux_state,
+					&peer_secid);
 
 	*secid = peer_secid;
 	if (peer_secid == SECSID_NULL)
@@ -5536,6 +5555,7 @@ static int selinux_sk_alloc_security(struct sock *sk, int family, gfp_t priority
 	sksec->peer_sid = SECINITSID_UNLABELED;
 	sksec->sid = SECINITSID_UNLABELED;
 	sksec->sclass = SECCLASS_SOCKET;
+	sksec->state = get_selinux_state(current_selinux_state);
 	selinux_netlbl_sk_security_reset(sksec);
 
 	return 0;
@@ -5546,6 +5566,7 @@ static void selinux_sk_free_security(struct sock *sk)
 	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	selinux_netlbl_sk_security_free(sksec);
+	put_selinux_state(sksec->state);
 }
 
 static void selinux_sk_clone_security(const struct sock *sk, struct sock *newsk)
@@ -5556,6 +5577,10 @@ static void selinux_sk_clone_security(const struct sock *sk, struct sock *newsk)
 	newsksec->sid = sksec->sid;
 	newsksec->peer_sid = sksec->peer_sid;
 	newsksec->sclass = sksec->sclass;
+	if (newsksec->state != sksec->state) {
+		put_selinux_state(newsksec->state);
+		newsksec->state = get_selinux_state(sksec->state);
+	}
 
 	selinux_netlbl_sk_security_reset(newsksec);
 }
@@ -5593,6 +5618,7 @@ static int selinux_sctp_process_new_assoc(struct sctp_association *asoc,
 	struct sock *sk = asoc->base.sk;
 	u16 family = sk->sk_family;
 	struct sk_security_struct *sksec = selinux_sock(sk);
+	struct selinux_state *state = sksec->state;
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
 	int err;
@@ -5607,7 +5633,8 @@ static int selinux_sctp_process_new_assoc(struct sctp_association *asoc,
 		/* This will return peer_sid = SECSID_NULL if there are
 		 * no peer labels, see security_net_peersid_resolve().
 		 */
-		err = selinux_skb_peerlbl_sid(skb, family, &asoc->peer_secid);
+		err = selinux_skb_peerlbl_sid(skb, family, state,
+					      &asoc->peer_secid);
 		if (err)
 			return err;
 
@@ -5631,8 +5658,7 @@ static int selinux_sctp_process_new_assoc(struct sctp_association *asoc,
 		 * consistency among the peer SIDs.
 		 */
 		ad_net_init_from_sk(&ad, &net, asoc->base.sk);
-		err = avc_has_perm(current_selinux_state,
-				   sksec->peer_sid, asoc->peer_secid,
+		err = avc_has_perm(state, sksec->peer_sid, asoc->peer_secid,
 				   sksec->sclass, SCTP_SOCKET__ASSOCIATION,
 				   &ad);
 		if (err)
@@ -5649,6 +5675,7 @@ static int selinux_sctp_assoc_request(struct sctp_association *asoc,
 				      struct sk_buff *skb)
 {
 	struct sk_security_struct *sksec = selinux_sock(asoc->base.sk);
+	struct selinux_state *state = sksec->state;
 	u32 conn_sid;
 	int err;
 
@@ -5665,7 +5692,7 @@ static int selinux_sctp_assoc_request(struct sctp_association *asoc,
 	 * socket to be generated. selinux_sctp_sk_clone() will then
 	 * plug this into the new socket.
 	 */
-	err = selinux_conn_sid(sksec->sid, asoc->peer_secid, &conn_sid);
+	err = selinux_conn_sid(sksec->sid, asoc->peer_secid, state, &conn_sid);
 	if (err)
 		return err;
 
@@ -5792,6 +5819,10 @@ static void selinux_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk
 	newsksec->sid = asoc->secid;
 	newsksec->peer_sid = asoc->peer_secid;
 	newsksec->sclass = sksec->sclass;
+	if (newsksec->state != sksec->state) {
+		put_selinux_state(newsksec->state);
+		newsksec->state = get_selinux_state(sksec->state);
+	}
 	selinux_netlbl_sctp_sk_clone(sk, newsk);
 }
 
@@ -5802,6 +5833,10 @@ static int selinux_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
 
 	ssksec->sclass = sksec->sclass;
 	ssksec->sid = sksec->sid;
+	if (ssksec->state != sksec->state) {
+		put_selinux_state(ssksec->state);
+		ssksec->state = get_selinux_state(sksec->state);
+	}
 
 	/* replace the existing subflow label deleting the existing one
 	 * and re-recreating a new label using the updated context
@@ -5814,21 +5849,22 @@ static int selinux_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 				     struct request_sock *req)
 {
 	struct sk_security_struct *sksec = selinux_sock(sk);
+	struct selinux_state *state = sksec->state;
 	int err;
 	u16 family = req->rsk_ops->family;
 	u32 connsid;
 	u32 peersid;
 
-	err = selinux_skb_peerlbl_sid(skb, family, &peersid);
+	err = selinux_skb_peerlbl_sid(skb, family, state, &peersid);
 	if (err)
 		return err;
-	err = selinux_conn_sid(sksec->sid, peersid, &connsid);
+	err = selinux_conn_sid(sksec->sid, peersid, state, &connsid);
 	if (err)
 		return err;
 	req->secid = connsid;
 	req->peer_secid = peersid;
 
-	return selinux_netlbl_inet_conn_request(req, family);
+	return selinux_netlbl_inet_conn_request(req, family, state);
 }
 
 static void selinux_inet_csk_clone(struct sock *newsk,
@@ -5857,7 +5893,7 @@ static void selinux_inet_conn_established(struct sock *sk, struct sk_buff *skb)
 	if (family == PF_INET6 && skb->protocol == htons(ETH_P_IP))
 		family = PF_INET;
 
-	selinux_skb_peerlbl_sid(skb, family, &sksec->peer_sid);
+	selinux_skb_peerlbl_sid(skb, family, sksec->state, &sksec->peer_sid);
 }
 
 static int selinux_secmark_relabel_packet(u32 sid)
@@ -5966,6 +6002,7 @@ static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 	u32 peer_sid;
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
+	struct selinux_state *se_state = init_selinux_state;
 	int secmark_active, peerlbl_active;
 
 	if (!selinux_policycap_netpeer())
@@ -5977,7 +6014,7 @@ static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 		return NF_ACCEPT;
 
 	family = state->pf;
-	if (selinux_skb_peerlbl_sid(skb, family, &peer_sid) != 0)
+	if (selinux_skb_peerlbl_sid(skb, family, se_state, &peer_sid) != 0)
 		return NF_DROP;
 
 	ifindex = state->in->ifindex;
@@ -5988,7 +6025,7 @@ static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 	if (peerlbl_active) {
 		int err;
 
-		err = selinux_inet_sys_rcv_skb(state->net, ifindex,
+		err = selinux_inet_sys_rcv_skb(se_state, state->net, ifindex,
 					       addrp, family, peer_sid, &ad);
 		if (err) {
 			selinux_netlbl_err(skb, family, err, 1);
@@ -5997,8 +6034,7 @@ static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 	}
 
 	if (secmark_active)
-		if (avc_has_perm(current_selinux_state,
-				 peer_sid, skb->secmark,
+		if (avc_has_perm(se_state, peer_sid, skb->secmark,
 				 SECCLASS_PACKET, PACKET__FORWARD_IN, &ad))
 			return NF_DROP;
 
@@ -6007,7 +6043,8 @@ static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 		 * path because we want to make sure we apply the necessary
 		 * labeling before IPsec is applied so we can leverage AH
 		 * protection */
-		if (selinux_netlbl_skbuff_setsid(skb, family, peer_sid) != 0)
+		if (selinux_netlbl_skbuff_setsid(skb, family, se_state, peer_sid)
+			!= 0)
 			return NF_DROP;
 
 	return NF_ACCEPT;
@@ -6016,6 +6053,7 @@ static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 static unsigned int selinux_ip_output(void *priv, struct sk_buff *skb,
 				      const struct nf_hook_state *state)
 {
+	struct selinux_state *se_state;
 	struct sock *sk;
 	u32 sid;
 
@@ -6047,9 +6085,12 @@ static unsigned int selinux_ip_output(void *priv, struct sk_buff *skb,
 		/* standard practice, label using the parent socket */
 		sksec = selinux_sock(sk);
 		sid = sksec->sid;
-	} else
+		se_state = sksec->state;
+	} else {
 		sid = SECINITSID_KERNEL;
-	if (selinux_netlbl_skbuff_setsid(skb, state->pf, sid) != 0)
+		se_state = init_selinux_state;
+	}
+	if (selinux_netlbl_skbuff_setsid(skb, state->pf, se_state, sid) != 0)
 		return NF_DROP;
 
 	return NF_ACCEPT;
@@ -6075,12 +6116,12 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 		return NF_DROP;
 
 	if (selinux_secmark_enabled())
-		if (avc_has_perm(current_selinux_state,
-				 sksec->sid, skb->secmark,
+		if (avc_has_perm(sksec->state, sksec->sid, skb->secmark,
 				 SECCLASS_PACKET, PACKET__SEND, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
-	if (selinux_xfrm_postroute_last(sksec->sid, skb, &ad, proto))
+	if (selinux_xfrm_postroute_last(sksec->sid, skb, sksec->state, &ad,
+					proto))
 		return NF_DROP_ERR(-ECONNREFUSED);
 
 	return NF_ACCEPT;
@@ -6098,6 +6139,7 @@ static unsigned int selinux_ip_postroute(void *priv,
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
 	char *addrp;
+	struct selinux_state *se_state = init_selinux_state;
 	int secmark_active, peerlbl_active;
 
 	/* If any sort of compatibility mode is enabled then handoff processing
@@ -6139,7 +6181,8 @@ static unsigned int selinux_ip_postroute(void *priv,
 		 * query the packet directly to determine the security label. */
 		if (skb->skb_iif) {
 			secmark_perm = PACKET__FORWARD_OUT;
-			if (selinux_skb_peerlbl_sid(skb, family, &peer_sid))
+			if (selinux_skb_peerlbl_sid(skb, family, se_state,
+						    &peer_sid))
 				return NF_DROP;
 		} else {
 			secmark_perm = PACKET__SEND;
@@ -6159,7 +6202,8 @@ static unsigned int selinux_ip_postroute(void *priv,
 		struct sk_security_struct *sksec;
 
 		sksec = selinux_sock(sk);
-		if (selinux_skb_peerlbl_sid(skb, family, &skb_sid))
+		se_state = sksec->state;
+		if (selinux_skb_peerlbl_sid(skb, family, se_state, &skb_sid))
 			return NF_DROP;
 		/* At this point, if the returned skb peerlbl is SECSID_NULL
 		 * and the packet has been through at least one XFRM
@@ -6181,7 +6225,7 @@ static unsigned int selinux_ip_postroute(void *priv,
 				return NF_DROP_ERR(-ECONNREFUSED);
 			}
 		}
-		if (selinux_conn_sid(sksec->sid, skb_sid, &peer_sid))
+		if (selinux_conn_sid(sksec->sid, skb_sid, se_state, &peer_sid))
 			return NF_DROP;
 		secmark_perm = PACKET__SEND;
 	} else {
@@ -6190,6 +6234,7 @@ static unsigned int selinux_ip_postroute(void *priv,
 		struct sk_security_struct *sksec = selinux_sock(sk);
 		peer_sid = sksec->sid;
 		secmark_perm = PACKET__SEND;
+		se_state = sksec->state;
 	}
 
 	ifindex = state->out->ifindex;
@@ -6198,8 +6243,7 @@ static unsigned int selinux_ip_postroute(void *priv,
 		return NF_DROP;
 
 	if (secmark_active)
-		if (avc_has_perm(current_selinux_state,
-				 peer_sid, skb->secmark,
+		if (avc_has_perm(se_state, peer_sid, skb->secmark,
 				 SECCLASS_PACKET, secmark_perm, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
@@ -6207,17 +6251,15 @@ static unsigned int selinux_ip_postroute(void *priv,
 		u32 if_sid;
 		u32 node_sid;
 
-		if (sel_netif_sid(state->net, ifindex, &if_sid))
+		if (sel_netif_sid(se_state, state->net, ifindex, &if_sid))
 			return NF_DROP;
-		if (avc_has_perm(current_selinux_state,
-				 peer_sid, if_sid,
+		if (avc_has_perm(se_state, peer_sid, if_sid,
 				 SECCLASS_NETIF, NETIF__EGRESS, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
-		if (sel_netnode_sid(addrp, family, &node_sid))
+		if (sel_netnode_sid(se_state, addrp, family, &node_sid))
 			return NF_DROP;
-		if (avc_has_perm(current_selinux_state,
-				 peer_sid, node_sid,
+		if (avc_has_perm(se_state, peer_sid, node_sid,
 				 SECCLASS_NODE, NODE__SENDTO, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 	}
@@ -7573,6 +7615,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(file_permission, selinux_file_permission),
 	LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
+	LSM_HOOK_INIT(file_free_security, selinux_file_free_security),
 	LSM_HOOK_INIT(file_ioctl, selinux_file_ioctl),
 	LSM_HOOK_INIT(file_ioctl_compat, selinux_file_ioctl_compat),
 	LSM_HOOK_INIT(mmap_file, selinux_mmap_file),
diff --git a/security/selinux/include/netif.h b/security/selinux/include/netif.h
index 2838bdc170dd..32de496bb948 100644
--- a/security/selinux/include/netif.h
+++ b/security/selinux/include/netif.h
@@ -19,6 +19,8 @@
 
 void sel_netif_flush(void);
 
-int sel_netif_sid(struct net *ns, int ifindex, u32 *sid);
+struct selinux_state;
+int sel_netif_sid(struct selinux_state *state, struct net *ns, int ifindex,
+		  u32 *sid);
 
 #endif /* _SELINUX_NETIF_H_ */
diff --git a/security/selinux/include/netlabel.h b/security/selinux/include/netlabel.h
index 5731c0dcd3e8..b8ee75e9d155 100644
--- a/security/selinux/include/netlabel.h
+++ b/security/selinux/include/netlabel.h
@@ -32,12 +32,15 @@ void selinux_netlbl_err(struct sk_buff *skb, u16 family, int error,
 void selinux_netlbl_sk_security_free(struct sk_security_struct *sksec);
 void selinux_netlbl_sk_security_reset(struct sk_security_struct *sksec);
 
-int selinux_netlbl_skbuff_getsid(struct sk_buff *skb, u16 family, u32 *type,
+int selinux_netlbl_skbuff_getsid(struct sk_buff *skb, u16 family,
+				 struct selinux_state *state, u32 *type,
 				 u32 *sid);
-int selinux_netlbl_skbuff_setsid(struct sk_buff *skb, u16 family, u32 sid);
+int selinux_netlbl_skbuff_setsid(struct sk_buff *skb, u16 family,
+				 struct selinux_state *state, u32 sid);
 int selinux_netlbl_sctp_assoc_request(struct sctp_association *asoc,
 				      struct sk_buff *skb);
-int selinux_netlbl_inet_conn_request(struct request_sock *req, u16 family);
+int selinux_netlbl_inet_conn_request(struct request_sock *req, u16 family,
+				     struct selinux_state *state);
 void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family);
 void selinux_netlbl_sctp_sk_clone(struct sock *sk, struct sock *newsk);
 int selinux_netlbl_socket_post_create(struct sock *sk, u16 family);
@@ -75,6 +78,7 @@ selinux_netlbl_sk_security_reset(struct sk_security_struct *sksec)
 }
 
 static inline int selinux_netlbl_skbuff_getsid(struct sk_buff *skb, u16 family,
+					       struct selinux_state *state,
 					       u32 *type, u32 *sid)
 {
 	*type = NETLBL_NLTYPE_NONE;
@@ -82,6 +86,7 @@ static inline int selinux_netlbl_skbuff_getsid(struct sk_buff *skb, u16 family,
 	return 0;
 }
 static inline int selinux_netlbl_skbuff_setsid(struct sk_buff *skb, u16 family,
+					       struct selinux_state *state,
 					       u32 sid)
 {
 	return 0;
@@ -94,7 +99,8 @@ selinux_netlbl_sctp_assoc_request(struct sctp_association *asoc,
 	return 0;
 }
 static inline int selinux_netlbl_inet_conn_request(struct request_sock *req,
-						   u16 family)
+						   u16 family,
+						   struct selinux_state *state)
 {
 	return 0;
 }
diff --git a/security/selinux/include/netnode.h b/security/selinux/include/netnode.h
index e4dc904c3585..029b9b1110c2 100644
--- a/security/selinux/include/netnode.h
+++ b/security/selinux/include/netnode.h
@@ -21,6 +21,8 @@
 
 void sel_netnode_flush(void);
 
-int sel_netnode_sid(const void *addr, u16 family, u32 *sid);
+struct selinux_state;
+int sel_netnode_sid(struct selinux_state *state, const void *addr, u16 family,
+		    u32 *sid);
 
 #endif
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index cfac79df617b..662329923214 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -28,6 +28,7 @@
 #include <net/net_namespace.h>
 #include "flask.h"
 #include "avc.h"
+#include "security.h"
 
 static inline bool task_avdcache_permnoaudit(struct task_security_struct *tsec)
 {
@@ -57,6 +58,7 @@ struct file_security_struct {
 	u32 fown_sid; /* SID of file owner (for SIGIO) */
 	u32 isid; /* SID of inode at the time of file open */
 	u32 pseqno; /* Policy seqno at the time of file open */
+	struct selinux_state *state; /* SELinux state */
 };
 
 struct superblock_security_struct {
@@ -83,6 +85,7 @@ struct netif_security_struct {
 	const struct net *ns; /* network namespace */
 	int ifindex; /* device index */
 	u32 sid; /* SID for this interface */
+	struct selinux_state *state; /* SELinux state */
 };
 
 struct netnode_security_struct {
@@ -92,6 +95,7 @@ struct netnode_security_struct {
 	} addr;
 	u32 sid; /* SID for this node */
 	u16 family; /* address family */
+	struct selinux_state *state; /* SELinux state */
 };
 
 struct netport_security_struct {
@@ -118,6 +122,7 @@ struct sk_security_struct {
 	       SCTP_ASSOC_UNSET = 0,
 	       SCTP_ASSOC_SET,
 	} sctp_assoc_state;
+	struct selinux_state *state; /* SELinux state */
 };
 
 struct tun_security_struct {
diff --git a/security/selinux/include/xfrm.h b/security/selinux/include/xfrm.h
index de485556ae29..36c390475752 100644
--- a/security/selinux/include/xfrm.h
+++ b/security/selinux/include/xfrm.h
@@ -38,9 +38,11 @@ static inline int selinux_xfrm_enabled(void)
 	return (atomic_read(&selinux_xfrm_refcount) > 0);
 }
 
-int selinux_xfrm_sock_rcv_skb(u32 sk_sid, struct sk_buff *skb,
+int selinux_xfrm_sock_rcv_skb(struct sk_security_struct *sksec,
+			      struct sk_buff *skb,
 			      struct common_audit_data *ad);
 int selinux_xfrm_postroute_last(u32 sk_sid, struct sk_buff *skb,
+				struct selinux_state *state,
 				struct common_audit_data *ad, u8 proto);
 int selinux_xfrm_decode_session(struct sk_buff *skb, u32 *sid, int ckall);
 int selinux_xfrm_skb_sid(struct sk_buff *skb, u32 *sid);
@@ -60,13 +62,15 @@ static inline int selinux_xfrm_enabled(void)
 	return 0;
 }
 
-static inline int selinux_xfrm_sock_rcv_skb(u32 sk_sid, struct sk_buff *skb,
+static inline int selinux_xfrm_sock_rcv_skb(struct sk_security_struct *sksec,
+					    struct sk_buff *skb,
 					    struct common_audit_data *ad)
 {
 	return 0;
 }
 
 static inline int selinux_xfrm_postroute_last(u32 sk_sid, struct sk_buff *skb,
+					      struct selinux_state *state,
 					      struct common_audit_data *ad,
 					      u8 proto)
 {
diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index 6bd8c434a37a..ddb36c7d0ba6 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -56,6 +56,7 @@ static inline u32 sel_netif_hashfn(const struct net *ns, int ifindex)
 
 /**
  * sel_netif_find - Search for an interface record
+ * @state: the SELinux state
  * @ns: the network namespace
  * @ifindex: the network interface
  *
@@ -64,7 +65,8 @@ static inline u32 sel_netif_hashfn(const struct net *ns, int ifindex)
  * If an entry can not be found in the table return NULL.
  *
  */
-static inline struct sel_netif *sel_netif_find(const struct net *ns,
+static inline struct sel_netif *sel_netif_find(struct selinux_state *state,
+					       const struct net *ns,
 					       int ifindex)
 {
 	u32 idx = sel_netif_hashfn(ns, ifindex);
@@ -72,7 +74,8 @@ static inline struct sel_netif *sel_netif_find(const struct net *ns,
 
 	list_for_each_entry_rcu(netif, &sel_netif_hash[idx], list)
 		if (net_eq(netif->nsec.ns, ns) &&
-		    netif->nsec.ifindex == ifindex)
+		    netif->nsec.ifindex == ifindex &&
+			(!state || netif->nsec.state == state))
 			return netif;
 
 	return NULL;
@@ -113,11 +116,13 @@ static void sel_netif_destroy(struct sel_netif *netif)
 {
 	list_del_rcu(&netif->list);
 	sel_netif_total--;
+	put_selinux_state(netif->nsec.state);
 	kfree_rcu(netif, rcu_head);
 }
 
 /**
  * sel_netif_sid_slow - Lookup the SID of a network interface using the policy
+ * @state: the SELinux state
  * @ns: the network namespace
  * @ifindex: the network interface
  * @sid: interface SID
@@ -129,7 +134,8 @@ static void sel_netif_destroy(struct sel_netif *netif)
  * failure.
  *
  */
-static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
+static int sel_netif_sid_slow(struct selinux_state *state, struct net *ns,
+			      int ifindex, u32 *sid)
 {
 	int ret = 0;
 	struct sel_netif *netif;
@@ -147,13 +153,13 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
 	}
 
 	spin_lock_bh(&sel_netif_lock);
-	netif = sel_netif_find(ns, ifindex);
+	netif = sel_netif_find(state, ns, ifindex);
 	if (netif != NULL) {
 		*sid = netif->nsec.sid;
 		goto out;
 	}
 
-	ret = security_netif_sid(current_selinux_state, dev->name, sid);
+	ret = security_netif_sid(state, dev->name, sid);
 	if (ret != 0)
 		goto out;
 
@@ -165,8 +171,11 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
 		new->nsec.ns = ns;
 		new->nsec.ifindex = ifindex;
 		new->nsec.sid = *sid;
-		if (sel_netif_insert(new))
+		new->nsec.state = get_selinux_state(state);
+		if (sel_netif_insert(new)) {
+			put_selinux_state(state);
 			kfree(new);
+		}
 	}
 
 out:
@@ -180,6 +189,7 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
 
 /**
  * sel_netif_sid - Lookup the SID of a network interface
+ * @state: the SELinux state
  * @ns: the network namespace
  * @ifindex: the network interface
  * @sid: interface SID
@@ -192,12 +202,13 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
  * on failure.
  *
  */
-int sel_netif_sid(struct net *ns, int ifindex, u32 *sid)
+int sel_netif_sid(struct selinux_state *state, struct net *ns, int ifindex,
+		  u32 *sid)
 {
 	struct sel_netif *netif;
 
 	rcu_read_lock();
-	netif = sel_netif_find(ns, ifindex);
+	netif = sel_netif_find(state, ns, ifindex);
 	if (likely(netif != NULL)) {
 		*sid = netif->nsec.sid;
 		rcu_read_unlock();
@@ -205,7 +216,7 @@ int sel_netif_sid(struct net *ns, int ifindex, u32 *sid)
 	}
 	rcu_read_unlock();
 
-	return sel_netif_sid_slow(ns, ifindex, sid);
+	return sel_netif_sid_slow(state, ns, ifindex, sid);
 }
 
 /**
@@ -224,7 +235,7 @@ static void sel_netif_kill(const struct net *ns, int ifindex)
 
 	rcu_read_lock();
 	spin_lock_bh(&sel_netif_lock);
-	netif = sel_netif_find(ns, ifindex);
+	netif = sel_netif_find(NULL, ns, ifindex);
 	if (netif)
 		sel_netif_destroy(netif);
 	spin_unlock_bh(&sel_netif_lock);
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index e35c224145a4..9c360f2ee7fc 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -32,6 +32,7 @@
  * @skb: the packet
  * @family: the packet's address family
  * @secattr: the NetLabel security attributes
+ * @state: the SELinux state
  * @sid: the SID
  *
  * Description:
@@ -43,11 +44,12 @@
 static int selinux_netlbl_sidlookup_cached(struct sk_buff *skb,
 					   u16 family,
 					   struct netlbl_lsm_secattr *secattr,
+					   struct selinux_state *state,
 					   u32 *sid)
 {
 	int rc;
 
-	rc = security_netlbl_secattr_to_sid(current_selinux_state, secattr, sid);
+	rc = security_netlbl_secattr_to_sid(state, secattr, sid);
 	if (rc == 0 &&
 	    (secattr->flags & NETLBL_SECATTR_CACHEABLE) &&
 	    (secattr->flags & NETLBL_SECATTR_CACHE))
@@ -79,8 +81,7 @@ static struct netlbl_lsm_secattr *selinux_netlbl_sock_genattr(struct sock *sk)
 	if (secattr == NULL)
 		return ERR_PTR(-ENOMEM);
 
-	rc = security_netlbl_sid_to_secattr(current_selinux_state, sksec->sid,
-					    secattr);
+	rc = security_netlbl_sid_to_secattr(sksec->state, sksec->sid, secattr);
 	if (rc != 0) {
 		netlbl_secattr_free(secattr);
 		return ERR_PTR(rc);
@@ -183,6 +184,7 @@ void selinux_netlbl_sk_security_reset(struct sk_security_struct *sksec)
  * selinux_netlbl_skbuff_getsid - Get the sid of a packet using NetLabel
  * @skb: the packet
  * @family: protocol family
+ * @state: the SELinux state
  * @type: NetLabel labeling protocol type
  * @sid: the SID
  *
@@ -194,6 +196,7 @@ void selinux_netlbl_sk_security_reset(struct sk_security_struct *sksec)
  */
 int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
 				 u16 family,
+				 struct selinux_state *state,
 				 u32 *type,
 				 u32 *sid)
 {
@@ -210,7 +213,7 @@ int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
 	rc = netlbl_skbuff_getattr(skb, family, &secattr);
 	if (rc == 0 && secattr.flags != NETLBL_SECATTR_NONE)
 		rc = selinux_netlbl_sidlookup_cached(skb, family,
-						     &secattr, sid);
+						     &secattr, state, sid);
 	else
 		*sid = SECSID_NULL;
 	*type = secattr.type;
@@ -223,6 +226,7 @@ int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
  * selinux_netlbl_skbuff_setsid - Set the NetLabel on a packet given a sid
  * @skb: the packet
  * @family: protocol family
+ * @state: the SELinux state
  * @sid: the SID
  *
  * Description
@@ -232,6 +236,7 @@ int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
  */
 int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
 				 u16 family,
+				 struct selinux_state *state,
 				 u32 sid)
 {
 	int rc;
@@ -252,8 +257,7 @@ int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
 	if (secattr == NULL) {
 		secattr = &secattr_storage;
 		netlbl_secattr_init(secattr);
-		rc = security_netlbl_sid_to_secattr(current_selinux_state, sid,
-						    secattr);
+		rc = security_netlbl_sid_to_secattr(state, sid, secattr);
 		if (rc != 0)
 			goto skbuff_setsid_return;
 	}
@@ -290,8 +294,8 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_association *asoc,
 		return 0;
 
 	netlbl_secattr_init(&secattr);
-	rc = security_netlbl_sid_to_secattr(current_selinux_state,
-					    asoc->secid, &secattr);
+	rc = security_netlbl_sid_to_secattr(sksec->state, asoc->secid,
+					    &secattr);
 	if (rc != 0)
 		goto assoc_request_return;
 
@@ -322,6 +326,7 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_association *asoc,
  * selinux_netlbl_inet_conn_request - Label an incoming stream connection
  * @req: incoming connection request socket
  * @family: the request socket's address family
+ * @state: the SELinux state
  *
  * Description:
  * A new incoming connection request is represented by @req, we need to label
@@ -330,7 +335,8 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_association *asoc,
  * is complete.  Returns zero on success, negative values on failure.
  *
  */
-int selinux_netlbl_inet_conn_request(struct request_sock *req, u16 family)
+int selinux_netlbl_inet_conn_request(struct request_sock *req, u16 family,
+				     struct selinux_state *state)
 {
 	int rc;
 	struct netlbl_lsm_secattr secattr;
@@ -339,8 +345,7 @@ int selinux_netlbl_inet_conn_request(struct request_sock *req, u16 family)
 		return 0;
 
 	netlbl_secattr_init(&secattr);
-	rc = security_netlbl_sid_to_secattr(current_selinux_state, req->secid,
-					    &secattr);
+	rc = security_netlbl_sid_to_secattr(state, req->secid, &secattr);
 	if (rc != 0)
 		goto inet_conn_request_return;
 	rc = netlbl_req_setattr(req, &secattr);
@@ -454,8 +459,8 @@ int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
 	netlbl_secattr_init(&secattr);
 	rc = netlbl_skbuff_getattr(skb, family, &secattr);
 	if (rc == 0 && secattr.flags != NETLBL_SECATTR_NONE)
-		rc = selinux_netlbl_sidlookup_cached(skb, family,
-						     &secattr, &nlbl_sid);
+		rc = selinux_netlbl_sidlookup_cached(skb, family, &secattr,
+						     sksec->state, &nlbl_sid);
 	else
 		nlbl_sid = SECINITSID_UNLABELED;
 	netlbl_secattr_destroy(&secattr);
@@ -473,8 +478,8 @@ int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
 		perm = RAWIP_SOCKET__RECVFROM;
 	}
 
-	rc = avc_has_perm(current_selinux_state,
-			  sksec->sid, nlbl_sid, sksec->sclass, perm, ad);
+	rc = avc_has_perm(sksec->state, sksec->sid, nlbl_sid, sksec->sclass,
+			  perm, ad);
 	if (rc == 0)
 		return 0;
 
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index 502aefcf2d77..dc6f09c73f9c 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -92,6 +92,7 @@ static unsigned int sel_netnode_hashfn_ipv6(const struct in6_addr *addr)
 
 /**
  * sel_netnode_find - Search for a node record
+ * @state: SELinux state
  * @addr: IP address
  * @family: address family
  *
@@ -100,7 +101,8 @@ static unsigned int sel_netnode_hashfn_ipv6(const struct in6_addr *addr)
  * entry can not be found in the table return NULL.
  *
  */
-static struct sel_netnode *sel_netnode_find(const void *addr, u16 family)
+static struct sel_netnode *sel_netnode_find(struct selinux_state *state,
+					    const void *addr, u16 family)
 {
 	unsigned int idx;
 	struct sel_netnode *node;
@@ -118,7 +120,7 @@ static struct sel_netnode *sel_netnode_find(const void *addr, u16 family)
 	}
 
 	list_for_each_entry_rcu(node, &sel_netnode_hash[idx].list, list)
-		if (node->nsec.family == family)
+		if (node->nsec.family == family && node->nsec.state == state)
 			switch (family) {
 			case PF_INET:
 				if (node->nsec.addr.ipv4 == *(const __be32 *)addr)
@@ -176,6 +178,7 @@ static void sel_netnode_insert(struct sel_netnode *node)
 
 /**
  * sel_netnode_sid_slow - Lookup the SID of a network address using the policy
+ * @state: the SELinux state
  * @addr: the IP address
  * @family: the address family
  * @sid: node SID
@@ -187,14 +190,15 @@ static void sel_netnode_insert(struct sel_netnode *node)
  * failure.
  *
  */
-static int sel_netnode_sid_slow(const void *addr, u16 family, u32 *sid)
+static int sel_netnode_sid_slow(struct selinux_state *state, const void *addr,
+				u16 family, u32 *sid)
 {
 	int ret;
 	struct sel_netnode *node;
 	struct sel_netnode *new;
 
 	spin_lock_bh(&sel_netnode_lock);
-	node = sel_netnode_find(addr, family);
+	node = sel_netnode_find(state, addr, family);
 	if (node != NULL) {
 		*sid = node->nsec.sid;
 		spin_unlock_bh(&sel_netnode_lock);
@@ -207,13 +211,13 @@ static int sel_netnode_sid_slow(const void *addr, u16 family, u32 *sid)
 	new = kmalloc(sizeof(*new), GFP_ATOMIC);
 	switch (family) {
 	case PF_INET:
-		ret = security_node_sid(current_selinux_state, PF_INET,
+		ret = security_node_sid(state, PF_INET,
 					addr, sizeof(struct in_addr), sid);
 		if (new)
 			new->nsec.addr.ipv4 = *(const __be32 *)addr;
 		break;
 	case PF_INET6:
-		ret = security_node_sid(current_selinux_state, PF_INET6,
+		ret = security_node_sid(state, PF_INET6,
 					addr, sizeof(struct in6_addr), sid);
 		if (new)
 			new->nsec.addr.ipv6 = *(const struct in6_addr *)addr;
@@ -225,6 +229,7 @@ static int sel_netnode_sid_slow(const void *addr, u16 family, u32 *sid)
 	if (ret == 0 && new) {
 		new->nsec.family = family;
 		new->nsec.sid = *sid;
+		new->nsec.state = get_selinux_state(state);
 		sel_netnode_insert(new);
 	} else
 		kfree(new);
@@ -238,6 +243,7 @@ static int sel_netnode_sid_slow(const void *addr, u16 family, u32 *sid)
 
 /**
  * sel_netnode_sid - Lookup the SID of a network address
+ * @state: the SELinux state
  * @addr: the IP address
  * @family: the address family
  * @sid: node SID
@@ -250,12 +256,13 @@ static int sel_netnode_sid_slow(const void *addr, u16 family, u32 *sid)
  * on failure.
  *
  */
-int sel_netnode_sid(const void *addr, u16 family, u32 *sid)
+int sel_netnode_sid(struct selinux_state *state, const void *addr, u16 family,
+		    u32 *sid)
 {
 	struct sel_netnode *node;
 
 	rcu_read_lock();
-	node = sel_netnode_find(addr, family);
+	node = sel_netnode_find(state, addr, family);
 	if (likely(node != NULL)) {
 		*sid = node->nsec.sid;
 		rcu_read_unlock();
@@ -263,7 +270,7 @@ int sel_netnode_sid(const void *addr, u16 family, u32 *sid)
 	}
 	rcu_read_unlock();
 
-	return sel_netnode_sid_slow(addr, family, sid);
+	return sel_netnode_sid_slow(state, addr, family, sid);
 }
 
 /**
@@ -283,6 +290,7 @@ void sel_netnode_flush(void)
 		list_for_each_entry_safe(node, node_tmp,
 					 &sel_netnode_hash[idx].list, list) {
 				list_del_rcu(&node->list);
+				put_selinux_state(node->nsec.state);
 				kfree_rcu(node, rcu);
 		}
 		sel_netnode_hash[idx].size = 0;
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 4ad8b610eb77..411e1f1ba4cd 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -149,6 +149,8 @@ static int selinux_xfrm_delete(struct xfrm_sec_ctx *ctx)
  */
 int selinux_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid)
 {
+	/* TODO: obtain SELinux state from related sock */
+	struct selinux_state *state = init_selinux_state;
 	int rc;
 
 	/* All flows should be treated as polmatch'ing an otherwise applicable
@@ -160,8 +162,7 @@ int selinux_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid)
 	if (!selinux_authorizable_ctx(ctx))
 		return -EINVAL;
 
-	rc = avc_has_perm(current_selinux_state,
-			  fl_secid, ctx->ctx_sid,
+	rc = avc_has_perm(state, fl_secid, ctx->ctx_sid,
 			  SECCLASS_ASSOCIATION, ASSOCIATION__POLMATCH, NULL);
 	return (rc == -EACCES ? -ESRCH : rc);
 }
@@ -174,6 +175,8 @@ int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x,
 				      struct xfrm_policy *xp,
 				      const struct flowi_common *flic)
 {
+	/* TODO: obtain SELinux state from related sock */
+	struct selinux_state *state = init_selinux_state;
 	u32 state_sid;
 	u32 flic_sid;
 
@@ -202,9 +205,8 @@ int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x,
 	/* We don't need a separate SA Vs. policy polmatch check since the SA
 	 * is now of the same label as the flow and a flow Vs. policy polmatch
 	 * check had already happened in selinux_xfrm_policy_lookup() above. */
-	return (avc_has_perm(current_selinux_state, flic_sid, state_sid,
-			     SECCLASS_ASSOCIATION, ASSOCIATION__SENDTO,
-			     NULL) ? 0 : 1);
+	return (avc_has_perm(state, flic_sid, state_sid, SECCLASS_ASSOCIATION,
+			     ASSOCIATION__SENDTO, NULL) ? 0 : 1);
 }
 
 static u32 selinux_xfrm_skb_sid_egress(struct sk_buff *skb)
@@ -341,6 +343,8 @@ int selinux_xfrm_state_alloc(struct xfrm_state *x,
 int selinux_xfrm_state_alloc_acquire(struct xfrm_state *x,
 				     struct xfrm_sec_ctx *polsec, u32 secid)
 {
+	/* TODO: Obtain SELinux state from related sock */
+	struct selinux_state *state = init_selinux_state;
 	int rc;
 	struct xfrm_sec_ctx *ctx;
 	char *ctx_str = NULL;
@@ -352,8 +356,7 @@ int selinux_xfrm_state_alloc_acquire(struct xfrm_state *x,
 	if (secid == 0)
 		return -EINVAL;
 
-	rc = security_sid_to_context(current_selinux_state, secid, &ctx_str,
-				     &str_len);
+	rc = security_sid_to_context(state, secid, &ctx_str, &str_len);
 	if (rc)
 		return rc;
 
@@ -399,10 +402,11 @@ int selinux_xfrm_state_delete(struct xfrm_state *x)
  * we need to check for unlabelled access since this may not have
  * gone thru the IPSec process.
  */
-int selinux_xfrm_sock_rcv_skb(u32 sk_sid, struct sk_buff *skb,
+int selinux_xfrm_sock_rcv_skb(struct sk_security_struct *sksec, struct sk_buff *skb,
 			      struct common_audit_data *ad)
 {
 	int i;
+	u32 sk_sid = sksec->sid;
 	struct sec_path *sp = skb_sec_path(skb);
 	u32 peer_sid = SECINITSID_UNLABELED;
 
@@ -421,8 +425,7 @@ int selinux_xfrm_sock_rcv_skb(u32 sk_sid, struct sk_buff *skb,
 	/* This check even when there's no association involved is intended,
 	 * according to Trent Jaeger, to make sure a process can't engage in
 	 * non-IPsec communication unless explicitly allowed by policy. */
-	return avc_has_perm(current_selinux_state,
-			    sk_sid, peer_sid,
+	return avc_has_perm(sksec->state, sk_sid, peer_sid,
 			    SECCLASS_ASSOCIATION, ASSOCIATION__RECVFROM, ad);
 }
 
@@ -434,6 +437,7 @@ int selinux_xfrm_sock_rcv_skb(u32 sk_sid, struct sk_buff *skb,
  * checked in the selinux_xfrm_state_pol_flow_match hook above.
  */
 int selinux_xfrm_postroute_last(u32 sk_sid, struct sk_buff *skb,
+				struct selinux_state *state,
 				struct common_audit_data *ad, u8 proto)
 {
 	struct dst_entry *dst;
@@ -465,6 +469,6 @@ int selinux_xfrm_postroute_last(u32 sk_sid, struct sk_buff *skb,
 	/* This check even when there's no association involved is intended,
 	 * according to Trent Jaeger, to make sure a process can't engage in
 	 * non-IPsec communication unless explicitly allowed by policy. */
-	return avc_has_perm(current_selinux_state, sk_sid, SECINITSID_UNLABELED,
+	return avc_has_perm(state, sk_sid, SECINITSID_UNLABELED,
 			    SECCLASS_ASSOCIATION, ASSOCIATION__SENDTO, ad);
 }
-- 
2.50.1

