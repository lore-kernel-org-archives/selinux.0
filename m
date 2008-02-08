Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m18LiGjI012491
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2008 16:44:16 -0500
Received: from g1t0028.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m18LiF5u026334
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2008 21:44:15 GMT
Received: from g1t0028.austin.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id 5D7011C1AA
	for <selinux@tycho.nsa.gov>; Fri,  8 Feb 2008 21:28:27 +0000 (UTC)
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.11.136.114])
	by g1t0028.austin.hp.com (Postfix) with ESMTP id 503891C0AB
	for <selinux@tycho.nsa.gov>; Fri,  8 Feb 2008 21:28:27 +0000 (UTC)
Message-Id: <20080208212825.408095221@hp.com>
References: <20080208212534.491651808@hp.com>
Date: Fri, 08 Feb 2008 16:25:37 -0500
From: paul.moore@hp.com
To: selinux@tycho.nsa.gov
Cc: Paul Moore <paul.moore@hp.com>
Subject: [PATCH 3/4] REFPOL: Remove the unlabeled_t SECMARK policy in kernel_sendrecv_unlabeled_association
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There is really no need for the SECMARK policy hack in the
kernel_sendrecv_unlabeled_association() interface since we already have an
interface call, kernel_sendrecv_unlabeled_packets(), which handles the
unlabeled SECMARK case.  Remove the hack and use the
kernel_sendrecv_unlabeled_packets() where appropriate.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 policy/modules/kernel/corenetwork.if.in |    4 ++++
 policy/modules/kernel/kernel.if         |    3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

Index: refpolicy_svn_repo/policy/modules/kernel/corenetwork.if.in
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/kernel/corenetwork.if.in
+++ refpolicy_svn_repo/policy/modules/kernel/corenetwork.if.in
@@ -1752,6 +1752,7 @@ interface(`corenet_tcp_recvfrom_netlabel
 #
 interface(`corenet_tcp_recvfrom_unlabeled',`
 	kernel_tcp_recvfrom_unlabeled($1)
+	kernel_sendrecv_unlabeled_packets($1)
 
 	# XXX - at some point the oubound/send access check will be removed
 	# but for right now we need to keep this in place so as not to break
@@ -1859,6 +1860,7 @@ interface(`corenet_udp_recvfrom_netlabel
 #
 interface(`corenet_udp_recvfrom_unlabeled',`
 	kernel_udp_recvfrom_unlabeled($1)
+	kernel_sendrecv_unlabeled_packets($1)
 
 	# XXX - at some point the oubound/send access check will be removed
 	# but for right now we need to keep this in place so as not to break
@@ -1966,6 +1968,7 @@ interface(`corenet_raw_recvfrom_netlabel
 #
 interface(`corenet_raw_recvfrom_unlabeled',`
 	kernel_raw_recvfrom_unlabeled($1)
+	kernel_sendrecv_unlabeled_packets($1)
 
 	# XXX - at some point the oubound/send access check will be removed
 	# but for right now we need to keep this in place so as not to break
@@ -2042,6 +2045,7 @@ interface(`corenet_all_recvfrom_unlabele
 	kernel_tcp_recvfrom_unlabeled($1)
 	kernel_udp_recvfrom_unlabeled($1)
 	kernel_raw_recvfrom_unlabeled($1)
+	kernel_sendrecv_unlabeled_packets($1)
 
 	# XXX - at some point the oubound/send access check will be removed
 	# but for right now we need to keep this in place so as not to break
Index: refpolicy_svn_repo/policy/modules/kernel/kernel.if
===================================================================
--- refpolicy_svn_repo.orig/policy/modules/kernel/kernel.if
+++ refpolicy_svn_repo/policy/modules/kernel/kernel.if
@@ -2255,9 +2255,6 @@ interface(`kernel_sendrecv_unlabeled_ass
 	')
 
 	allow $1 unlabeled_t:association { sendto recvfrom };
-
-	# temporary hack until labeling on packets is supported
-	allow $1 unlabeled_t:packet { send recv };
 ')
 
 ########################################

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
