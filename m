Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6KLgvbK007368
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2012 17:43:02 -0400
Received: from TCSEXCH1.tcs-sec.com (tcsexch1.tcs-sec.com [192.168.1.225]) by barracuda.trustedcs.com with ESMTP id JIAabaqV0zKpeRFi (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO) for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2012 17:43:00 -0400 (EDT)
From: Chad Hanson <chanson@TrustedCS.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: [PATCH] Fix broken peer recv check
Date: Fri, 20 Jul 2012 21:42:59 +0000
Message-ID: <C42CE43E0E13AB44A299B62E25500374120AC7@TCSEXCH1.tcs-sec.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fix a broken networking check. Return an error if peer recv fails. If secmark is active
and the packet recv succeeds the peer recv error is ignored.

Signed-off-by: Chad Hanson <chanson@trustedcs.com>
---
 hooks.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d85b793..64826a0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4215,8 +4215,10 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		}
 		err = avc_has_perm(sk_sid, peer_sid, SECCLASS_PEER,
 				   PEER__RECV, &ad);
-		if (err)
+		if (err) {
 			selinux_netlbl_err(skb, err, 0);
+			return err;
+		}
 	}
 
 	if (secmark_active) {


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
