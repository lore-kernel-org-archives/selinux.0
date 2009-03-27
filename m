Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2RKt0Jx003306
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 16:55:00 -0400
Received: from g4t0015.houston.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2RKp1Ro006554
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 20:51:01 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [PATCH 1/6] lsm: Relocate the IPv4 security_inet_conn_request() hooks
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Cc: netdev@vger.kernel.org, casey@schaufler-ca.com,
        etienne.basset@numericable.fr
Date: Fri, 27 Mar 2009 16:54:55 -0400
Message-ID: <20090327205455.17740.61639.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The current placement of the security_inet_conn_request() hooks do not allow
individual LSMs to override the IP options of the connection's request_sock.
This is a problem as both SELinux and Smack have the ability to use labeled
networking protocols which make use of IP options to carry security attributes
and the inability to set the IP options at the start of the TCP handshake is
problematic.

This patch moves the IPv4 security_inet_conn_request() hooks past the code
where the request_sock's IP options are set/reset so that the LSM can safely
manipulate the IP options as needed.  This patch intentionally does not change
the related IPv6 hooks as IPv6 based labeling protocols which use IPv6 options
are not currently implemented, once they are we will have a better idea of
the correct placement for the IPv6 hooks.

Signed-off-by: Paul Moore <paul.moore@hp.com>
Acked-by: David S. Miller <davem@davemloft.net>
---

 net/ipv4/syncookies.c |    9 +++++----
 net/ipv4/tcp_ipv4.c   |    7 ++++---
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index d346c22..b35a950 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -288,10 +288,6 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb,
 	if (!req)
 		goto out;
 
-	if (security_inet_conn_request(sk, skb, req)) {
-		reqsk_free(req);
-		goto out;
-	}
 	ireq = inet_rsk(req);
 	treq = tcp_rsk(req);
 	treq->rcv_isn		= ntohl(th->seq) - 1;
@@ -322,6 +318,11 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb,
 		}
 	}
 
+	if (security_inet_conn_request(sk, skb, req)) {
+		reqsk_free(req);
+		goto out;
+	}
+
 	req->expires	= 0UL;
 	req->retrans	= 0;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index d0a3148..5d427f8 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1230,14 +1230,15 @@ int tcp_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 
 	tcp_openreq_init(req, &tmp_opt, skb);
 
-	if (security_inet_conn_request(sk, skb, req))
-		goto drop_and_free;
-
 	ireq = inet_rsk(req);
 	ireq->loc_addr = daddr;
 	ireq->rmt_addr = saddr;
 	ireq->no_srccheck = inet_sk(sk)->transparent;
 	ireq->opt = tcp_v4_save_options(sk, skb);
+
+	if (security_inet_conn_request(sk, skb, req))
+		goto drop_and_free;
+
 	if (!want_cookie)
 		TCP_ECN_create_request(req, tcp_hdr(skb));
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
