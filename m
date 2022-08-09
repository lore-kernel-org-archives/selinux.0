Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2157DC25B08
	for <selinux@archiver.kernel.org>; Tue,  9 Aug 2022 22:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiHIWN7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Aug 2022 18:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiHIWNi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Aug 2022 18:13:38 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6975518B00
        for <selinux@vger.kernel.org>; Tue,  9 Aug 2022 15:12:56 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id d1so9687485qvs.0
        for <selinux@vger.kernel.org>; Tue, 09 Aug 2022 15:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:from:to:cc;
        bh=epZqiiNp2nsOkxw4iWG0v7lD/2m/qQz0yGF46LAn7Q8=;
        b=A/HSbvYMcskV/J8Xs9lrLPOLV30ycStOY9lYqisogOOYZJssW7qQCaKi/pyMzalrxZ
         NKiVm25uJ6dflZiS3HJHSWih6cqgUXd5hTPUXXGyVQ7YP4DGj55UPZz46AaEf6fe5Wff
         TM3tikgI80Vpp6bKfLUaxE9fr+obWcNWIpqV1H8faMyMG3JJASaf1+rrChi0ha6xdzAp
         rXjaoAwum4gSnLiOxfNGeoupCWk0M8Uyu8TE+yj5GKcuXoiWxC2YKjndJ0VTQp0OIFH2
         FWW3PGKqrWpyS/BjLoXqqVfqgi2p3LZr0/qGCExPvm+M4Ruegbdw6uorS7fCBbkx6RQ7
         0svA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:x-gm-message-state:from:to:cc;
        bh=epZqiiNp2nsOkxw4iWG0v7lD/2m/qQz0yGF46LAn7Q8=;
        b=uKdaADB+tFUgVWr9kwPZ5X+3mFrioSu7dAYQ2fCERmBXslpNK3DbCFE3619FxRCtKT
         YGa3Z+Buo2ZzDScNYjO5OJmEF50413fW5bnCQA912JRHPAvjyiT93ov1CYvCTEraefQi
         sClUHbBH2gUFUny9hfVCCFTuxRVyjeQJTLCn3frDd+5yY8/CBeaT5FyKkRarZeHCCQQS
         AzH3dmooEBQDl01mwNBW2ELKdtRyxETYy/dzde0fYjzhsiNKWCDPJKS5/f2q20vskjqa
         0TvWMKBW8DrXWRByMyfHYxyPfe/Nht7yi9jpL65OeQODyjJRfb4eDs8yN1Ie0Ke0S/H3
         mjgQ==
X-Gm-Message-State: ACgBeo0or2gbqwLc11b5KmuuDH5u7fhryX34JWLMPYiDN+ndlWLxy0LC
        7wpOSm0QwO8uM3iJp23rUc6jdIU7Xgmz
X-Google-Smtp-Source: AA6agR7JsEsbk7l/SnsnVAfUkKc8do1PuE5EolPFPfcXJte1pvLH6QHEnpMR0On57ay4DRfLlRDXgw==
X-Received: by 2002:a05:6214:246d:b0:476:6485:7670 with SMTP id im13-20020a056214246d00b0047664857670mr21919436qvb.84.1660083175095;
        Tue, 09 Aug 2022 15:12:55 -0700 (PDT)
Received: from localhost (pool-96-237-52-46.bstnma.fios.verizon.net. [96.237.52.46])
        by smtp.gmail.com with ESMTPSA id bx7-20020a05622a090700b0031ef67386a5sm10411362qtb.68.2022.08.09.15.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:12:54 -0700 (PDT)
Subject: [PATCH] selinux: SCTP fixes, including ASCONF
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Tue, 09 Aug 2022 18:12:53 -0400
Message-ID: <166008317384.447519.7250489605112175227.stgit@olly>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch makes two changes to how SELinux processes SCTP traffic:

* Considering the multi-homed nature of SCTP, all SCTP traffic is
  marked as NLBL_REQSKB from a NetLabel perspective so that
  traffic is labeled on a per-packet basis using the destination IP,
  and not the on-the-wire label cached at the socket layer.

* New permissions have been added to the "sctp_socket" object class:
  sctp_socket/{asconf_addip, asconf_connect}.  These new permissions
  are gated by the "sctp_asconf" SELinux policy capability, and
  control the ability of ASCONF to add a new IP address to an
  association and set the primary IP of the association.  The ASCONF
  access control points now work like the examples below; <socket> is
  the local socket's label, <port> is the label of the network port,
  and <peer> is the network peer label (dependent on the labeled
  networking configuration).

  - legacy policy (no sctp_asconf)

    allow <socket> <port>:sctp_socket { name_connect };

  - updated policy without labeled networking (enabled sctp_asconf)

    allow <socket> <port>:sctp_socket { asconf_connect };

  - updated policy with labeled networking (enabled sctp_asconf)

    allow <peer> <socket>:sctp_socket { asconf_addip };
    allow <socket> <port>:sctp_socket { asconf_connect };

Cc: stable@vger.kernel.org
Fixes: d452930fd3b9 ("selinux: Add SCTP support")
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c                   |   86 +++++++++++++++++++---------
 security/selinux/include/classmap.h        |    3 +
 security/selinux/include/netlabel.h        |    1 
 security/selinux/include/policycap.h       |    1 
 security/selinux/include/policycap_names.h |    3 +
 security/selinux/include/security.h        |    7 ++
 security/selinux/netlabel.c                |   30 ++++++++--
 7 files changed, 95 insertions(+), 36 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1bbd53321d13..02751a66c5d8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4530,7 +4530,7 @@ static int socket_sockcreate_sid(const struct task_security_struct *tsec,
 				       secclass, NULL, socksid);
 }
 
-static int sock_has_perm(struct sock *sk, u32 perms)
+static int sock_has_perm_subj(u32 subj, struct sock *sk, u32 perms)
 {
 	struct sk_security_struct *sksec = sk->sk_security;
 	struct common_audit_data ad;
@@ -4544,8 +4544,12 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 	ad.u.net->sk = sk;
 
 	return avc_has_perm(&selinux_state,
-			    current_sid(), sksec->sid, sksec->sclass, perms,
-			    &ad);
+			    subj, sksec->sid, sksec->sclass, perms, &ad);
+}
+
+static int sock_has_perm(struct sock *sk, u32 perms)
+{
+	return sock_has_perm_subj(current_sid(), sk, perms);
 }
 
 static int selinux_socket_create(int family, int type,
@@ -4752,16 +4756,13 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 /* This supports connect(2) and SCTP connect services such as sctp_connectx(3)
  * and sctp_sendmsg(3) as described in Documentation/security/SCTP.rst
  */
-static int selinux_socket_connect_helper(struct socket *sock,
+static int selinux_socket_connect_helper(struct socket *sock, u32 perm,
 					 struct sockaddr *address, int addrlen)
 {
 	struct sock *sk = sock->sk;
 	struct sk_security_struct *sksec = sk->sk_security;
 	int err;
 
-	err = sock_has_perm(sk, SOCKET__CONNECT);
-	if (err)
-		return err;
 	if (addrlen < offsetofend(struct sockaddr, sa_family))
 		return -EINVAL;
 
@@ -4783,7 +4784,7 @@ static int selinux_socket_connect_helper(struct socket *sock,
 		struct sockaddr_in *addr4 = NULL;
 		struct sockaddr_in6 *addr6 = NULL;
 		unsigned short snum;
-		u32 sid, perm;
+		u32 sid;
 
 		/* sctp_connectx(3) calls via selinux_sctp_bind_connect()
 		 * that validates multiple connect addresses. Because of this
@@ -4817,18 +4818,6 @@ static int selinux_socket_connect_helper(struct socket *sock,
 		if (err)
 			return err;
 
-		switch (sksec->sclass) {
-		case SECCLASS_TCP_SOCKET:
-			perm = TCP_SOCKET__NAME_CONNECT;
-			break;
-		case SECCLASS_DCCP_SOCKET:
-			perm = DCCP_SOCKET__NAME_CONNECT;
-			break;
-		case SECCLASS_SCTP_SOCKET:
-			perm = SCTP_SOCKET__NAME_CONNECT;
-			break;
-		}
-
 		ad.type = LSM_AUDIT_DATA_NET;
 		ad.u.net = &net;
 		ad.u.net->dport = htons(snum);
@@ -4847,9 +4836,26 @@ static int selinux_socket_connect(struct socket *sock,
 				  struct sockaddr *address, int addrlen)
 {
 	int err;
+	u32 perm;
 	struct sock *sk = sock->sk;
+	struct sk_security_struct *sksec;
 
-	err = selinux_socket_connect_helper(sock, address, addrlen);
+	err = sock_has_perm(sk, SOCKET__CONNECT);
+	if (err)
+		return err;
+	sksec = sk->sk_security;
+	switch (sksec->sclass) {
+	case SECCLASS_TCP_SOCKET:
+		perm = TCP_SOCKET__NAME_CONNECT;
+		break;
+	case SECCLASS_DCCP_SOCKET:
+		perm = DCCP_SOCKET__NAME_CONNECT;
+		break;
+	case SECCLASS_SCTP_SOCKET:
+		perm = SCTP_SOCKET__NAME_CONNECT;
+		break;
+	}
+	err = selinux_socket_connect_helper(sock, perm, address, addrlen);
 	if (err)
 		return err;
 
@@ -5360,17 +5366,24 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 				     int addrlen)
 {
 	int len, err = 0, walk_size = 0;
+	int pcap_asconf;
+	int peerlbl;
+	u32 perm;
 	void *addr_buf;
 	struct sockaddr *addr;
 	struct socket *sock;
+	struct sk_security_struct *sksec;
 
 	if (!selinux_policycap_extsockclass())
 		return 0;
 
-	/* Process one or more addresses that may be IPv4 or IPv6 */
+	pcap_asconf = selinux_policycap_sctp_asconf();
+	peerlbl = selinux_peerlbl_enabled();
+	sksec = sk->sk_security;
 	sock = sk->sk_socket;
 	addr_buf = address;
 
+	/* Process one or more addresses that may be IPv4 or IPv6 */
 	while (walk_size < addrlen) {
 		if (walk_size + sizeof(sa_family_t) > addrlen)
 			return -EINVAL;
@@ -5393,18 +5406,21 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 
 		err = -EINVAL;
 		switch (optname) {
-		/* Bind checks */
+		/* bind() style checks */
 		case SCTP_PRIMARY_ADDR:
 		case SCTP_SET_PEER_PRIMARY_ADDR:
 		case SCTP_SOCKOPT_BINDX_ADD:
 			err = selinux_socket_bind(sock, addr, len);
 			break;
-		/* Connect checks */
+		/* connect() style checks */
 		case SCTP_SOCKOPT_CONNECTX:
-		case SCTP_PARAM_SET_PRIMARY:
-		case SCTP_PARAM_ADD_IP:
 		case SCTP_SENDMSG_CONNECT:
-			err = selinux_socket_connect_helper(sock, addr, len);
+			err = sock_has_perm(sk, SOCKET__CONNECT);
+			if (err)
+				return err;
+			err = selinux_socket_connect_helper(sock,
+						SCTP_SOCKET__NAME_CONNECT,
+						addr, len);
 			if (err)
 				return err;
 
@@ -5421,6 +5437,22 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 			 */
 			err = selinux_netlbl_socket_connect_locked(sk, addr);
 			break;
+		/* ASCONF checks (IETF RFC 5061) */
+		case SCTP_PARAM_ADD_IP:
+		case SCTP_PARAM_SET_PRIMARY:
+			if (pcap_asconf) {
+				if (peerlbl) {
+					err = sock_has_perm_subj(sksec->peer_sid,
+						sk, SCTP_SOCKET__ASCONF_ADDIP);
+					if (err)
+						return err;
+				}
+				perm = SCTP_SOCKET__ASCONF_CONNECT;
+			} else
+				perm = SCTP_SOCKET__NAME_CONNECT;
+			err = selinux_socket_connect_helper(sock, perm,
+							    addr, len);
+			break;
 		}
 
 		if (err)
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index ff757ae5f253..8d4e3b4d160e 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -179,7 +179,8 @@ const struct security_class_mapping secclass_map[] = {
 	  { COMMON_CAP2_PERMS, NULL } },
 	{ "sctp_socket",
 	  { COMMON_SOCK_PERMS,
-	    "node_bind", "name_connect", "association", NULL } },
+	    "node_bind", "name_connect", "association", "asconf_addip",
+	    "asconf_connect", NULL } },
 	{ "icmp_socket",
 	  { COMMON_SOCK_PERMS,
 	    "node_bind", NULL } },
diff --git a/security/selinux/include/netlabel.h b/security/selinux/include/netlabel.h
index 4d0456d3d459..32aa8d4724fa 100644
--- a/security/selinux/include/netlabel.h
+++ b/security/selinux/include/netlabel.h
@@ -55,7 +55,6 @@ int selinux_netlbl_socket_setsockopt(struct socket *sock,
 int selinux_netlbl_socket_connect(struct sock *sk, struct sockaddr *addr);
 int selinux_netlbl_socket_connect_locked(struct sock *sk,
 					 struct sockaddr *addr);
-
 #else
 static inline void selinux_netlbl_cache_invalidate(void)
 {
diff --git a/security/selinux/include/policycap.h b/security/selinux/include/policycap.h
index f35d3458e71d..6aaee9e12812 100644
--- a/security/selinux/include/policycap.h
+++ b/security/selinux/include/policycap.h
@@ -12,6 +12,7 @@ enum {
 	POLICYDB_CAP_NNP_NOSUID_TRANSITION,
 	POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS,
 	POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
+	POLICYDB_CAP_SCTP_ASCONF,
 	__POLICYDB_CAP_MAX
 };
 #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
diff --git a/security/selinux/include/policycap_names.h b/security/selinux/include/policycap_names.h
index 2a87fc3702b8..e6d8fbddbbdc 100644
--- a/security/selinux/include/policycap_names.h
+++ b/security/selinux/include/policycap_names.h
@@ -13,7 +13,8 @@ const char *const selinux_policycap_names[__POLICYDB_CAP_MAX] = {
 	"cgroup_seclabel",
 	"nnp_nosuid_transition",
 	"genfs_seclabel_symlinks",
-	"ioctl_skip_cloexec"
+	"ioctl_skip_cloexec",
+	"sctp_asconf",
 };
 
 #endif /* _SELINUX_POLICYCAP_NAMES_H_ */
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 393aff41d3ef..98d3e6c0a146 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -230,6 +230,13 @@ static inline bool selinux_policycap_ioctl_skip_cloexec(void)
 	return READ_ONCE(state->policycap[POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]);
 }
 
+static inline bool selinux_policycap_sctp_asconf(void)
+{
+	struct selinux_state *state = &selinux_state;
+
+	return READ_ONCE(state->policycap[POLICYDB_CAP_SCTP_ASCONF]);
+}
+
 struct selinux_policy_convert_data;
 
 struct selinux_load_state {
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 1321f15799e2..28d0ead32416 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -373,10 +373,10 @@ void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
  */
 void selinux_netlbl_sctp_sk_clone(struct sock *sk, struct sock *newsk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
 	struct sk_security_struct *newsksec = newsk->sk_security;
 
-	newsksec->nlbl_state = sksec->nlbl_state;
+	/* SCTP is multi-homed so we must label each packet based on dest IP */
+	newsksec->nlbl_state = NLBL_REQSKB;
 }
 
 /**
@@ -401,6 +401,17 @@ int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
 	secattr = selinux_netlbl_sock_genattr(sk);
 	if (secattr == NULL)
 		return -ENOMEM;
+
+	/* SCTP has the ability to communicate with multiple endpoints for a
+	 * given association so we need to force NLBL_REQSKB so that we always
+	 * label traffic based on the destination endpoint and not the
+	 * association's connection
+	 */
+	if (sk->sk_protocol == IPPROTO_SCTP) {
+		sksec->nlbl_state = NLBL_REQSKB;
+		return 0;
+	}
+
 	rc = netlbl_sock_setattr(sk, family, secattr);
 	switch (rc) {
 	case 0:
@@ -548,10 +559,17 @@ static int selinux_netlbl_socket_connect_helper(struct sock *sk,
 	struct sk_security_struct *sksec = sk->sk_security;
 	struct netlbl_lsm_secattr *secattr;
 
-	/* connected sockets are allowed to disconnect when the address family
-	 * is set to AF_UNSPEC, if that is what is happening we want to reset
-	 * the socket */
-	if (addr->sa_family == AF_UNSPEC) {
+	/* special handling for AF_UNSPEC and IPPROTO_SCTP:
+	 * - sockets are allowed to disconnect when the address family
+	 *   is set to AF_UNSPEC, if that is what is happening we want to reset
+	 *   the socket
+	 * - SCTP has the ability to communicate with multiple endpoints for
+	 *   a given association so we need to force NLBL_REQSKB so that we
+	 *   always label traffic based on the destination endpoint and not
+	 *   the association's connection, see similar comment in
+	 *   selinux_netlbl_socket_post_create()
+	 */
+	if (addr->sa_family == AF_UNSPEC || sk->sk_protocol == IPPROTO_SCTP) {
 		netlbl_sock_delattr(sk);
 		sksec->nlbl_state = NLBL_REQSKB;
 		rc = 0;

