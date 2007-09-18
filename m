Message-ID: <46F00B7D.6000909@trustedcs.com>
Date: Tue, 18 Sep 2007 12:31:41 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, paul.moore@hp.com, sds@tycho.nsa.gov,
        jmorris@namei.org
Subject: [RFC] [PATCH 1/4] Label-based flow control of traffic
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch set implements network traffic flow control
based on the extenal/fallback label of the packet and
label of the interfaces/nodes involved.

This patch set provides an outline for how it could
work using labeled xfrms. This needs to be augmented
with NetLabel and fallback labels for packets and
potentially a combined interface/network label for
interfaces/nodes.

Locally destined packets are flow-controlled in the existing
rcv_skb LSM hook. Forwarded packets are flow-controlled on
the way in, using a new forward netfilter hook in the LSM.
All traffic is flow-controlled on the way out using a new
skb_flow_out LSM hook.

The first patch defines flow_in/flow_out perms for
the netif and node class since netifs and nodes are
labeled and flow-controlled-against separately in
this patch set.

diff --git a/security/selinux/include/av_perm_to_string.h b/security/selinux/include/av_perm_to_string.h
index 049bf69..40f14c7 100644
--- a/security/selinux/include/av_perm_to_string.h
+++ b/security/selinux/include/av_perm_to_string.h
@@ -37,6 +37,8 @@
    S_(SECCLASS_NODE, NODE__ENFORCE_DEST, "enforce_dest")
    S_(SECCLASS_NODE, NODE__DCCP_RECV, "dccp_recv")
    S_(SECCLASS_NODE, NODE__DCCP_SEND, "dccp_send")
+   S_(SECCLASS_NODE, NODE__FLOW_IN, "flow_in")
+   S_(SECCLASS_NODE, NODE__FLOW_OUT, "flow_out")
    S_(SECCLASS_NETIF, NETIF__TCP_RECV, "tcp_recv")
    S_(SECCLASS_NETIF, NETIF__TCP_SEND, "tcp_send")
    S_(SECCLASS_NETIF, NETIF__UDP_RECV, "udp_recv")
@@ -45,6 +47,8 @@
    S_(SECCLASS_NETIF, NETIF__RAWIP_SEND, "rawip_send")
    S_(SECCLASS_NETIF, NETIF__DCCP_RECV, "dccp_recv")
    S_(SECCLASS_NETIF, NETIF__DCCP_SEND, "dccp_send")
+   S_(SECCLASS_NETIF, NETIF__FLOW_IN, "flow_in")
+   S_(SECCLASS_NETIF, NETIF__FLOW_OUT, "flow_out")
    S_(SECCLASS_UNIX_STREAM_SOCKET, UNIX_STREAM_SOCKET__CONNECTTO, "connectto")
    S_(SECCLASS_UNIX_STREAM_SOCKET, UNIX_STREAM_SOCKET__NEWCONN, "newconn")
    S_(SECCLASS_UNIX_STREAM_SOCKET, UNIX_STREAM_SOCKET__ACCEPTFROM, "acceptfrom")
diff --git a/security/selinux/include/av_permissions.h b/security/selinux/include/av_permissions.h
index eda89a2..44188a2 100644
--- a/security/selinux/include/av_permissions.h
+++ b/security/selinux/include/av_permissions.h
@@ -292,6 +292,8 @@
 #define NODE__ENFORCE_DEST                        0x00000040UL
 #define NODE__DCCP_RECV                           0x00000080UL
 #define NODE__DCCP_SEND                           0x00000100UL
+#define NODE__FLOW_IN                             0x00000200UL
+#define NODE__FLOW_OUT                            0x00000400UL
 #define NETIF__TCP_RECV                           0x00000001UL
 #define NETIF__TCP_SEND                           0x00000002UL
 #define NETIF__UDP_RECV                           0x00000004UL
@@ -300,6 +302,8 @@
 #define NETIF__RAWIP_SEND                         0x00000020UL
 #define NETIF__DCCP_RECV                          0x00000040UL
 #define NETIF__DCCP_SEND                          0x00000080UL
+#define NETIF__FLOW_IN                            0x00000100UL
+#define NETIF__FLOW_OUT                           0x00000200UL
 #define NETLINK_SOCKET__IOCTL                     0x00000001UL
 #define NETLINK_SOCKET__READ                      0x00000002UL
 #define NETLINK_SOCKET__WRITE                     0x00000004UL

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
