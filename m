Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1SLt03t002635
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 16:55:00 -0500
Received: from atlrel7.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1SLuMM8023837
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 21:56:22 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070228215516.892465077@hp.com>
Date: Wed, 28 Feb 2007 16:55:04 -0500
To: selinux@tycho.nsa.gov
Cc: vyekkirala@TrustedCS.com
Subject: [PATCH] Refpolicy: Add rawip_socket to the recvfrom MLS constraints
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It was just pointed out to me that the raw IP socket class is missing from the
recvfrom MLS constraint.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 policy/mls |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: refpolicy/policy/mls
===================================================================
--- refpolicy.orig/policy/mls
+++ refpolicy/policy/mls
@@ -183,7 +183,7 @@ mlsconstrain { socket tcp_socket udp_soc
 	 ( t1 == mlsnetwrite ));
 
 # used by netlabel to restrict normal domains to same level connections
-mlsconstrain { tcp_socket udp_socket } recvfrom
+mlsconstrain { tcp_socket udp_socket rawip_socket } recvfrom
 	(( l1 eq l2 ) or
 	 (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
 	 ( t1 == mlsnetread ));

--
paul moore
linux security @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
