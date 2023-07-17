Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124DDC0015E
	for <selinux@archiver.kernel.org>; Mon, 17 Jul 2023 14:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjGQO2u (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jul 2023 10:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGQO2t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Jul 2023 10:28:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5911B6
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 07:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689604084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EKTS79jj/xyzoYrFC5azw0n3hL2SoIXKe4RmH2OX0FE=;
        b=iPBjEo3RXCasANPwaprw726sqfYl/lSHylIbeuu3tco5hN/C9hfnPSq8irNneqFvs78fxx
        n5kqoRMbkbZ1dUGflJQ97mstptDkrEDLPOvGqL52Nyml7H6j8lsXnicB63+26668qx0tq2
        25t1aDeX9+L4YfiP9l6wrq7Hn9O5uEk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-ajio4RHVPlyfmwkuhKlCmQ-1; Mon, 17 Jul 2023 10:28:02 -0400
X-MC-Unique: ajio4RHVPlyfmwkuhKlCmQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C13E188496F;
        Mon, 17 Jul 2023 14:28:00 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 184214A9004;
        Mon, 17 Jul 2023 14:27:58 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>
Subject: [RFC PATCH] selinux: introduce and use ad_init_net*() helpers
Date:   Mon, 17 Jul 2023 16:27:18 +0200
Message-ID: <73a810980a8452f0cb98d25698c4ae83285b7393.1689604030.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Perf traces of network-related workload shows a measurable overhead
inside the network-related selinux hooks while zeroing the
lsm_network_audit struct.

In most cases we can delay the initialization of such structure to the
usage point, avoiding such overhead in a few cases.

Additionally, the audit code accesses the IP address information only
for AF_INET* families, and selinux_parse_skb() will fill-out the
relevant fields in such cases. When the family field is zeroed or the
initialization is followed by the mentioned parsing, the zeroing can be
limited to the sk, family and netif fields.

By factoring out the audit-data initialization to new helpers, this
patch removes some duplicate code and gives small but measurable
performance gain under UDP flood.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note the performance gain is small, but measurable and let the selinux
hooks almost disappear from the perf traces I collect. The only
remaining perf-related pain-point I see is the indirect call at the
security_ level, and tackling it looks much more difficult... :(
---
 security/selinux/hooks.c | 84 ++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 41 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d06e350fedee..9a75b3bcff2b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4495,18 +4495,41 @@ static int socket_sockcreate_sid(const struct task_security_struct *tsec,
 				       secclass, NULL, socksid);
 }
 
+static void __ad_init_net(struct common_audit_data *ad,
+			  struct lsm_network_audit *net,
+			  int ifindex, struct sock *sk, u16 family)
+{
+	ad->type = LSM_AUDIT_DATA_NET;
+	ad->u.net = net;
+	net->netif = ifindex;
+	net->sk = sk;
+	net->family = family;
+}
+
+static void ad_init_net_from_sk(struct common_audit_data *ad,
+				struct lsm_network_audit *net,
+				struct sock *sk)
+{
+	__ad_init_net(ad, net, 0, sk, 0);
+}
+
+static void ad_init_net_from_netif_family(struct common_audit_data *ad,
+					  struct lsm_network_audit *net,
+					  int ifindex, u16 family)
+{
+	__ad_init_net(ad, net, ifindex, 0, family);
+}
+
 static int sock_has_perm(struct sock *sk, u32 perms)
 {
 	struct sk_security_struct *sksec = sk->sk_security;
 	struct common_audit_data ad;
-	struct lsm_network_audit net = {0,};
+	struct lsm_network_audit net;
 
 	if (sksec->sid == SECINITSID_KERNEL)
 		return 0;
 
-	ad.type = LSM_AUDIT_DATA_NET;
-	ad.u.net = &net;
-	ad.u.net->sk = sk;
+	ad_init_net_from_sk(&ad, &net, sk);
 
 	return avc_has_perm(current_sid(), sksec->sid, sksec->sclass, perms,
 			    &ad);
@@ -4899,12 +4922,10 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 	struct sk_security_struct *sksec_other = other->sk_security;
 	struct sk_security_struct *sksec_new = newsk->sk_security;
 	struct common_audit_data ad;
-	struct lsm_network_audit net = {0,};
+	struct lsm_network_audit net;
 	int err;
 
-	ad.type = LSM_AUDIT_DATA_NET;
-	ad.u.net = &net;
-	ad.u.net->sk = other;
+	ad_init_net_from_sk(&ad, &net, other);
 
 	err = avc_has_perm(sksec_sock->sid, sksec_other->sid,
 			   sksec_other->sclass,
@@ -4931,11 +4952,9 @@ static int selinux_socket_unix_may_send(struct socket *sock,
 	struct sk_security_struct *ssec = sock->sk->sk_security;
 	struct sk_security_struct *osec = other->sk->sk_security;
 	struct common_audit_data ad;
-	struct lsm_network_audit net = {0,};
+	struct lsm_network_audit net;
 
-	ad.type = LSM_AUDIT_DATA_NET;
-	ad.u.net = &net;
-	ad.u.net->sk = other->sk;
+	ad_init_net_from_sk(&ad, &net, other->sk);
 
 	return avc_has_perm(ssec->sid, osec->sid, osec->sclass, SOCKET__SENDTO,
 			    &ad);
@@ -4971,13 +4990,10 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 	struct sk_security_struct *sksec = sk->sk_security;
 	u32 sk_sid = sksec->sid;
 	struct common_audit_data ad;
-	struct lsm_network_audit net = {0,};
+	struct lsm_network_audit net;
 	char *addrp;
 
-	ad.type = LSM_AUDIT_DATA_NET;
-	ad.u.net = &net;
-	ad.u.net->netif = skb->skb_iif;
-	ad.u.net->family = family;
+	ad_init_net_from_netif_family(&ad, &net, skb->skb_iif, family);
 	err = selinux_parse_skb(skb, &ad, &addrp, 1, NULL);
 	if (err)
 		return err;
@@ -5004,7 +5020,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	u16 family = sk->sk_family;
 	u32 sk_sid = sksec->sid;
 	struct common_audit_data ad;
-	struct lsm_network_audit net = {0,};
+	struct lsm_network_audit net;
 	char *addrp;
 	u8 secmark_active;
 	u8 peerlbl_active;
@@ -5028,10 +5044,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	if (!secmark_active && !peerlbl_active)
 		return 0;
 
-	ad.type = LSM_AUDIT_DATA_NET;
-	ad.u.net = &net;
-	ad.u.net->netif = skb->skb_iif;
-	ad.u.net->family = family;
+	ad_init_net_from_netif_family(&ad, &net, skb->skb_iif, family);
 	err = selinux_parse_skb(skb, &ad, &addrp, 1, NULL);
 	if (err)
 		return err;
@@ -5201,7 +5214,7 @@ static int selinux_sctp_process_new_assoc(struct sctp_association *asoc,
 	u16 family = sk->sk_family;
 	struct sk_security_struct *sksec = sk->sk_security;
 	struct common_audit_data ad;
-	struct lsm_network_audit net = {0,};
+	struct lsm_network_audit net;
 	int err;
 
 	/* handle mapped IPv4 packets arriving via IPv6 sockets */
@@ -5237,9 +5250,7 @@ static int selinux_sctp_process_new_assoc(struct sctp_association *asoc,
 		/* Other association peer SIDs are checked to enforce
 		 * consistency among the peer SIDs.
 		 */
-		ad.type = LSM_AUDIT_DATA_NET;
-		ad.u.net = &net;
-		ad.u.net->sk = asoc->base.sk;
+		ad_init_net_from_sk(&ad, &net, asoc->base.sk);
 		err = avc_has_perm(sksec->peer_sid, asoc->peer_secid,
 				   sksec->sclass, SCTP_SOCKET__ASSOCIATION,
 				   &ad);
@@ -5584,7 +5595,7 @@ static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 	char *addrp;
 	u32 peer_sid;
 	struct common_audit_data ad;
-	struct lsm_network_audit net = {0,};
+	struct lsm_network_audit net;
 	int secmark_active, peerlbl_active;
 
 	if (!selinux_policycap_netpeer())
@@ -5600,10 +5611,7 @@ static unsigned int selinux_ip_forward(void *priv, struct sk_buff *skb,
 		return NF_DROP;
 
 	ifindex = state->in->ifindex;
-	ad.type = LSM_AUDIT_DATA_NET;
-	ad.u.net = &net;
-	ad.u.net->netif = ifindex;
-	ad.u.net->family = family;
+	ad_init_net_from_netif_family(&ad, &net, ifindex, family);
 	if (selinux_parse_skb(skb, &ad, &addrp, 1, NULL) != 0)
 		return NF_DROP;
 
@@ -5683,7 +5691,7 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 	struct sock *sk;
 	struct sk_security_struct *sksec;
 	struct common_audit_data ad;
-	struct lsm_network_audit net = {0,};
+	struct lsm_network_audit net;
 	u8 proto = 0;
 
 	sk = skb_to_full_sk(skb);
@@ -5691,10 +5699,7 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 		return NF_ACCEPT;
 	sksec = sk->sk_security;
 
-	ad.type = LSM_AUDIT_DATA_NET;
-	ad.u.net = &net;
-	ad.u.net->netif = state->out->ifindex;
-	ad.u.net->family = state->pf;
+	ad_init_net_from_netif_family(&ad, &net, state->out->ifindex, state->pf);
 	if (selinux_parse_skb(skb, &ad, NULL, 0, &proto))
 		return NF_DROP;
 
@@ -5719,7 +5724,7 @@ static unsigned int selinux_ip_postroute(void *priv,
 	int ifindex;
 	struct sock *sk;
 	struct common_audit_data ad;
-	struct lsm_network_audit net = {0,};
+	struct lsm_network_audit net;
 	char *addrp;
 	int secmark_active, peerlbl_active;
 
@@ -5816,10 +5821,7 @@ static unsigned int selinux_ip_postroute(void *priv,
 	}
 
 	ifindex = state->out->ifindex;
-	ad.type = LSM_AUDIT_DATA_NET;
-	ad.u.net = &net;
-	ad.u.net->netif = ifindex;
-	ad.u.net->family = family;
+	ad_init_net_from_netif_family(&ad, &net, ifindex, family);
 	if (selinux_parse_skb(skb, &ad, &addrp, 0, NULL))
 		return NF_DROP;
 
-- 
2.41.0

