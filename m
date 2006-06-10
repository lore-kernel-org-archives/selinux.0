Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5CFoFm8007897
	for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2006 11:50:16 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5CFoElb024182
	for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2006 15:50:14 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6) with ESMTP id k5CFoNJM010590
	for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2006 11:50:23 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6/Submit) id k5CFoNEL010589
	for selinux@tycho.nsa.gov; Mon, 12 Jun 2006 11:50:23 -0400
Message-ID: <36282A1733C57546BE392885C0618592012D6271@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: redhat-lspp@redhat.com, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        jmorris@redhat.com, tjaeger@cse.psu.edu, latten@austin.ibm.com
Cc: Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel
	 <DGoeddel@TrustedCS.com>
Subject: [RFC] [SELXFRM 4/4] FOR REFERENCE ONLY: Add support to serefpolic
	y
Date: Sat, 10 Jun 2006 17:38:29 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch will be submitted to the serefpolicy list later. It has been
included here just for reference.

This patch adds a polmatch avperm to arbitrate access between a flow/state
to a xfrm policy. It also defines MLS policy for association { sendto,
recvfrom, polmatch }.

NOTE: When an inbound packet is not using an IPSec SA, a check is performed
between the socket label and the unlabeled sid (SYSTEM_HIGH MLS label). For
MLS purposes however, the target of the check should be the MLS label taken
from the node sid (or secmark in the new secmark world). This would present
a severe performance overhead (to make a new sid based on the unlabeled sid
with the MLS taken from the node sid or secmark and then using this sid as
the target). While discussions are ongoing on fine tuning the networking
design in the context of secmark, IPSec, netlabel, etc., I have chosen to
currently make an exception for unlabeled_t SAs if TE policy allowed it. A
similar problem exists for the outbound case and it has been similarly
handled in the policy below (by making an exception for unlabeled_t).


--- serefpolicy-2.2.34/policy/mls       2006-04-20 07:18:44.000000000 -0500
+++ serefpolicy-2.2.34.ipsec/policy/mls 2006-05-11 10:04:29.000000000 -0500
@@ -671,4 +671,18 @@
 # these access vectors have no MLS restrictions
 # association *

+mlsconstrain association { recvfrom }
+        (( l1 eq l2 ) or
+         (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
+         ( t1 == mlsnetread ) or
+         ( t2 == unlabeled_t ));
+
+mlsconstrain association { sendto }
+        ((( l1 dom l2 ) and ( l1 domby h2 )) or
+         ( t2 == unlabeled_t ));
+
+mlsconstrain association { polmatch }
+         (( l1 dom l2 ) and ( h1 domby h2 ));
+
+
 ') dnl end enable_mls
--- serefpolicy-2.2.34/policy/flask/access_vectors      2006-04-20
07:18:44.000000000 -0500
+++ serefpolicy-2.2.34.ipsec/policy/flask/access_vectors        2006-04-27
10:34:44.000000000 -0500
@@ -602,6 +602,7 @@
        sendto
        recvfrom
        setcontext
+       polmatch
 }

 # Updated Netlink class for KOBJECT_UEVENT family.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
