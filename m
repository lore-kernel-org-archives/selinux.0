Message-ID: <44EDE6FB.2060501@trustedcs.com>
Date: Thu, 24 Aug 2006 12:50:51 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
CC: jmorris@namei.org, sds@tycho.nsa.gov, chanson@TrustedCS.com
Subject: [PATCH 1/3] secid reconciliation-v01
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently a packet accumulates multiple security identifiers, each of a
different class, as it enters the system. This patch set reconciles these
identifiers into a single identifier while also allowing LSM (SELinux is
addressed in this patch set) to impose flow control checks based on the
identifiers.

The reconciliation steps for SELinux are explained in the Labeled Networking
document at:
http://marc.theaimsgroup.com/?l=linux-netdev&m=115136637800361&w=2
with the change that SELinux transition rules are used when available
to arrive at the new secid.

The following are the identifiers handled here:

1. secmark on the skb
2. xfrm security identifier associated with the skb if it used any xfrms,
  a zero secid otherwise.

This patch: Add new flask definitions to SELinux

Adds a new avperm "come_thru" to arbitrate among the identifiers on the
inbound (input/forward). Also adds a new avperm "go_thru" to enable flow
control checks on the outbound (output/forward), addressed in a later
patch.

Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>
---
 security/selinux/include/av_perm_to_string.h |    2 ++
 security/selinux/include/av_permissions.h    |    2 ++
 2 files changed, 4 insertions(+)

--- net-2.6.19.orig/security/selinux/include/av_permissions.h	2006-08-24 09:19:13.000000000 -0500
+++ net-2.6.19.sid1/security/selinux/include/av_permissions.h	2006-08-24 09:43:09.000000000 -0500
@@ -962,6 +962,8 @@
 #define PACKET__SEND                              0x00000001UL
 #define PACKET__RECV                              0x00000002UL
 #define PACKET__RELABELTO                         0x00000004UL
+#define PACKET__FLOW_IN                           0x00000008UL
+#define PACKET__FLOW_OUT                          0x00000010UL
 
 #define KEY__VIEW                                 0x00000001UL
 #define KEY__READ                                 0x00000002UL
--- net-2.6.19.orig/security/selinux/include/av_perm_to_string.h	2006-08-24 09:19:13.000000000 -0500
+++ net-2.6.19.sid1/security/selinux/include/av_perm_to_string.h	2006-08-24 09:43:09.000000000 -0500
@@ -245,6 +245,8 @@
    S_(SECCLASS_PACKET, PACKET__SEND, "send")
    S_(SECCLASS_PACKET, PACKET__RECV, "recv")
    S_(SECCLASS_PACKET, PACKET__RELABELTO, "relabelto")
+   S_(SECCLASS_PACKET, PACKET__FLOW_IN, "flow_in")
+   S_(SECCLASS_PACKET, PACKET__FLOW_OUT, "flow_out")
    S_(SECCLASS_KEY, KEY__VIEW, "view")
    S_(SECCLASS_KEY, KEY__READ, "read")
    S_(SECCLASS_KEY, KEY__WRITE, "write")

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
