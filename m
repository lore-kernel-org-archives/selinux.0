Message-ID: <44F839FD.4000602@trustedcs.com>
Date: Fri, 01 Sep 2006 08:47:41 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: sds@tycho.nsa.gov, cpebenito@tresys.com
Subject: MLSXFRM-v02: Add support to serefpolicy
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds a polmatch avperm to arbitrate flow/state's access to
a xfrm policy. It also defines MLS policy for association { sendto,
recvfrom, polmatch }.

NOTE: When an inbound packet is not using an IPSec SA, a check is performed
between the socket label and the unlabeled sid (SYSTEM_HIGH MLS label). For
MLS purposes however, the target of the check should be the MLS label taken
from the node sid (or secmark in the new secmark world). This would present
a severe performance overhead (to make a new sid based on the unlabeled sid
with the MLS taken from the node sid or secmark and then using this sid as
the target). Pending reconciliation of the netlabel, ipsec and iptables contexts,
I have chosen to currently make an exception for unlabeled_t SAs if TE policy
allowed it. A similar problem exists for the outbound case and it has been similarly
handled in the policy below (by making an exception for unlabeled_t).

I am submitting the below limited patch pending a comprehensive patch from
Joy Latten at IBM (latten@austin.ibm.com).

I am not sure if I needed to manually do a "make tolib" in the flask subdir
and submit the results as well. Please let me know if I needed to.

Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>
---

--- serefpolicy-2.3.2.vanilla/policy/mls	2006-07-09 04:51:24.000000000 -0500
+++ serefpolicy-2.3.2/policy/mls	2006-07-29 11:48:50.000000000 -0500
@@ -668,7 +668,19 @@ mlsconstrain xinput { setattr relabelinp
 # MLS policy for the association class
 #
 
-# these access vectors have no MLS restrictions
-# association *
+mlsconstrain association { recvfrom }
+	((( l1 dom l2 ) and ( l1 domby h2 )) or
+	 (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
+	 ( t1 == mlsnetread ) or
+	 ( t2 == unlabeled_t ));
+
+mlsconstrain association { sendto }
+	((( l1 dom l2 ) and ( l1 domby h2 )) or
+	 ( t2 == unlabeled_t ));
+
+mlsconstrain association { polmatch }
+	((( l1 dom l2 ) and ( h1 domby h2 )) or
+	 ( t2 == unlabeled_t ));
+
 
 ') dnl end enable_mls
--- serefpolicy-2.3.2.vanilla/policy/flask/access_vectors	2006-07-09 04:51:24.000000000 -0500
+++ serefpolicy-2.3.2/policy/flask/access_vectors	2006-07-29 12:08:31.000000000 -0500
@@ -603,6 +603,7 @@ class association
 	sendto
 	recvfrom
 	setcontext
+	polmatch
 }
 
 # Updated Netlink class for KOBJECT_UEVENT family.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
