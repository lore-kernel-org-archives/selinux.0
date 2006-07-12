Message-ID: <44B5665F.5010400@trustedcs.com>
Date: Wed, 12 Jul 2006 16:15:11 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: jmorris@namei.org, sds@tycho.nsa.gov, tjaeger@cse.psu.edu,
        selinux@tycho.nsa.gov
Subject: FOR REFERENCE ONLY: MLSXFRM: Add support to serefpolicy
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch has been included here just for reference. It will be submitted
to the serefpolicy list later.

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


--- serefpolicy-2.2.34/policy/mls       2006-04-20 07:18:44.000000000 -0500
+++ serefpolicy-2.2.34.ipsec/policy/mls 2006-05-11 10:04:29.000000000 -0500
@@ -671,4 +671,19 @@
 # these access vectors have no MLS restrictions
 # association *

+mlsconstrain association { recvfrom }
+        ((( l1 dom l2 ) and ( l1 domby h2 )) or
+         (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
+         ( t1 == mlsnetread ) or
+         ( t2 == unlabeled_t ));
+
+mlsconstrain association { sendto }
+        ((( l1 dom l2 ) and ( l1 domby h2 )) or
+         ( t2 == unlabeled_t ));
+
+mlsconstrain association { polmatch }
+         ((( l1 dom l2 ) and ( h1 domby h2 )) or
+          ( t2 == unlabeled_t ));
+
+
 ') dnl end enable_mls
--- serefpolicy-2.2.34/policy/flask/access_vectors      2006-04-20 07:18:44.000000000 -0500
+++ serefpolicy-2.2.34.ipsec/policy/flask/access_vectors        2006-04-27 10:34:44.000000000 -0500
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
