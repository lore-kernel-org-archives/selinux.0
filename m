Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1CLHJPm009948
	for <selinux@tycho.nsa.gov>; Thu, 12 Feb 2009 16:17:19 -0500
Received: from g4t0015.houston.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1CLHHXZ003830
	for <selinux@tycho.nsa.gov>; Thu, 12 Feb 2009 21:17:18 GMT
Message-Id: <20090212211531.619341973@hp.com>
Date: Thu, 12 Feb 2009 16:15:26 -0500
From: Paul Moore <paul.moore@hp.com>
To: refpolicy@oss.tresys.com
Cc: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: Add missing network related MLS constraints
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add MLS constraints for several network related access controls including
the new ingress/egress controls and the older Secmark controls.  Based on
the following post to the SELinux Reference Policy mailing list:

 * http://oss.tresys.com/pipermail/refpolicy/2009-February/000579.html

Signed-off-by: Paul Moore <paul.moore@hp.com>

---
 policy/mls |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

Index: refpolicy_svn_repo/policy/mls
===================================================================
--- refpolicy_svn_repo.orig/policy/mls
+++ refpolicy_svn_repo/policy/mls
@@ -295,8 +295,59 @@ mlsconstrain { netif node } { tcp_send u
 # these access vectors have no MLS restrictions
 # node enforce_dest
 
+#
+# MLS policy for the network ingress/egress controls
+#
 
+# the netif ingress/egress ops, the ingress permission is a "write" operation
+# because the subject in this particular case is the remote domain which is
+# writing data out the network interface which is acting as the object
+mlsconstrain { netif } { ingress }
+	(( l1 eq l2 ) or
+	 (( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
+	 (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
+	 ( t1 == mlsnetwrite ) or
+	 ( t1 == unlabeled_t ));
+mlsconstrain { netif } { egress }
+	(( l1 eq l2 ) or
+	 (( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
+	 (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
+	 ( t1 == mlsnetwrite ));
 
+# the node recvfrom/sendto ops, the recvfrom permission is a "write" operation
+# because the subject in this particular case is the remote domain which is
+# writing data out the network node which is acting as the object
+mlsconstrain { node } { recvfrom }
+	(( l1 eq l2 ) or
+	 (( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
+	 (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
+	 ( t1 == mlsnetwrite ) or
+	 ( t1 == unlabeled_t ));
+mlsconstrain { node } { sendto }
+	(( l1 eq l2 ) or
+	 (( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
+	 (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
+	 ( t1 == mlsnetwrite ));
+
+# the forward ops, the forward_in permission is a "write" operation because the
+# subject in this particular case is the remote domain which is writing data
+# to the network with a secmark label, the object in this case
+mlsconstrain { packet } { forward_in forward_out }
+	(( l1 eq l2 ) or
+	 (( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
+	 (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
+	 ( t1 == mlsnetwrite ) or
+	 ( t1 == unlabeled_t ));
+
+#
+# MLS policy for the secmark and peer controls
+#
+
+# the peer/packet recv op
+mlsconstrain { peer packet } { recv }
+	(( l1 dom l2 ) or
+	 (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
+	 ( t1 == mlsnetread ));
 
 #
 # MLS policy for the process class

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
