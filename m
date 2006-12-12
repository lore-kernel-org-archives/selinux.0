Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBC7baku010816
	for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2006 02:37:36 -0500
Received: from mail.atsec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBC7c7S2011945
	for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2006 07:38:07 GMT
Date: Tue, 12 Dec 2006 01:38:13 -0600
From: Klaus Weidner <klaus@atsec.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH RFC 0/2] stricter MLS policy constraints
Message-ID: <20061212073813.GB30421@w-m-p.com>
References: <20061212072825.GA3362@w-m-p.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061212072825.GA3362@w-m-p.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For untrusted subjects, permit write operations on ranged
objects only when the subject effective level equals the object low
level. Introduce new subject attributes "mlsfilewriteranged" and
"mlsnetwriteranged" that give these privileged subjects the right to use
the old ranged-write behavior.

Please see 0/2 message for additional explanations.

Signed-off-by: Klaus Weidner <klaus@atsec.com>

 policy/mls                   |   13 +++++++++----
 policy/modules/kernel/mls.te |    2 ++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff -ur serefpolicy-2.4.6.cleanup/policy/mls serefpolicy-2.4.6.kw/policy/mls
--- serefpolicy-2.4.6.cleanup/policy/mls	2006-12-06 03:26:47.000000000 -0600
+++ serefpolicy-2.4.6.kw/policy/mls	2006-12-06 03:40:25.000000000 -0600
@@ -93,8 +93,10 @@
 	 (( t2 == mlsrangedobject ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
 	 ( t2 == mlstrustedobject ));
 
+# Directory "write" ops
 mlsconstrain dir { add_name remove_name reparent rmdir }
-	((( l1 dom l2 ) and ( l1 domby h2 )) or
+	(( l1 eq l2 ) or
+	 (( t1 == mlsfilewriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
 	 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
 	 ( t1 == mlsfilewrite ) or
 	 ( t2 == mlstrustedobject ));
@@ -178,7 +180,8 @@
 
 # the socket "write" ops
 mlsconstrain { socket tcp_socket udp_socket rawip_socket netlink_socket packet_socket key_socket unix_stream_socket unix_dgram_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } { write setattr relabelfrom connect setopt shutdown }
-	((( l1 dom l2 ) and ( l1 domby h2 )) or
+	(( l1 eq l2 ) or 
+	 (( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
 	 (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
 	 ( t1 == mlsnetwrite ));
 
@@ -274,7 +277,8 @@
 
 # the netif/node "write" ops (implicit single level socket doing the write)
 mlsconstrain { netif node } { tcp_send udp_send rawip_send }
-	(( l1 dom l2 ) and ( l1 domby h2 ));
+	(( l1 eq l2 ) or
+	(( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 )));
 
 # these access vectors have no MLS restrictions
 # node enforce_dest
@@ -581,7 +585,8 @@
 	 ( t2 == unlabeled_t ));
 
 mlsconstrain association { sendto }
-	((( l1 dom l2 ) and ( l1 domby h2 )) or
+	(( l1 eq l2 ) or
+	 (( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
 	 ( t2 == unlabeled_t ));
 
 mlsconstrain association { polmatch }
diff -ur serefpolicy-2.4.6.cleanup/policy/modules/kernel/mls.te serefpolicy-2.4.6.kw/policy/modules/kernel/mls.te
--- serefpolicy-2.4.6.cleanup/policy/modules/kernel/mls.te	2006-12-06 03:34:04.000000000 -0600
+++ serefpolicy-2.4.6.kw/policy/modules/kernel/mls.te	2006-12-06 03:34:54.000000000 -0600
@@ -11,6 +11,7 @@
 attribute mlsfilereadtoclr;
 attribute mlsfilewrite;
 attribute mlsfilewritetoclr;
+attribute mlsfilewriteranged;
 attribute mlsfileupgrade;
 attribute mlsfiledowngrade;
 
@@ -18,6 +19,7 @@
 attribute mlsnetreadtoclr;
 attribute mlsnetwrite;
 attribute mlsnetwritetoclr;
+attribute mlsnetwriteranged;
 attribute mlsnetupgrade;
 attribute mlsnetdowngrade;
 attribute mlsnetrecvall;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
