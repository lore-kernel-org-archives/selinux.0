Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rB4KUR7i009941
	for <selinux@tycho.nsa.gov>; Wed, 4 Dec 2013 15:30:29 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rB427FNr008014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2013 21:07:39 -0500
Subject: [PATCH] selinux: pull address family directly from the request_sock
 struct
To: selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Date: Tue, 03 Dec 2013 18:04:11 -0500
Message-ID: <20131203230411.14783.21098.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We don't need to inspect the packet to determine if the packet is an
IPv4 packet arriving on an IPv6 socket when we can query the
request_sock directly.

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 security/selinux/hooks.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index cc076a9..17d7689 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4476,14 +4476,10 @@ static int selinux_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 {
 	struct sk_security_struct *sksec = sk->sk_security;
 	int err;
-	u16 family = sk->sk_family;
+	u16 family = req->rsk_ops->family;
 	u32 connsid;
 	u32 peersid;
 
-	/* handle mapped IPv4 packets arriving via IPv6 sockets */
-	if (family == PF_INET6 && skb->protocol == htons(ETH_P_IP))
-		family = PF_INET;
-
 	err = selinux_skb_peerlbl_sid(skb, family, &peersid);
 	if (err)
 		return err;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
