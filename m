Message-ID: <1340289811.4234.51.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH external/sepolicy] Add selinux network script to policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: jbrindle@tresys.com
Cc: selinux@tycho.nsa.gov
Date: Thu, 21 Jun 2012 10:43:31 -0400
In-Reply-To: <1340207887-30359-1-git-send-email-jbrindle@tresys.com>
References: <1340207887-30359-1-git-send-email-jbrindle@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-06-20 at 11:58 -0400, jbrindle@tresys.com wrote:
> From: Joshua Brindle <jbrindle@tresys.com>
> 
> Signed-off-by: Joshua Brindle <jbrindle@tresys.com>
> ---
>  Android.mk         |   13 +++++++++++++
>  selinux-network.sh |   18 ++++++++++++++++++
>  2 files changed, 31 insertions(+)
>  create mode 100755 selinux-network.sh

Thanks, merged all 7 patches.  A few notes:
- I merged these on the master or seandroid branches and then merged
master or seandroid onto mmac.  Some of your patches were against mmac
so I fixed those by hand.

- I haven't yet cherry-picked them onto seandroid-4.0.4 and mmac-4.0.4,
but will likely do so.

- Do we want some basic attribute/type definitions and allow rules in
the base policy to support this functionality, even though by default
the iptables secmark rules are commented out?  Something like the
following patch to support at least the wlan0 and lo secmark labeling:

diff --git a/attributes b/attributes
index 1016ec6..3bc4a9f 100644
--- a/attributes
+++ b/attributes
@@ -33,6 +33,9 @@ attribute netif_type;
 # All types used for network ports.
 attribute port_type;
 
+# All types used for secmark packet labeling.
+attribute packet_type;
+
 # All types used for property service
 attribute property_type;
 
diff --git a/net.te b/net.te
index b10cecd..500e958 100644
--- a/net.te
+++ b/net.te
@@ -2,6 +2,8 @@
 type node, node_type;
 type netif, netif_type;
 type port, port_type;
+type packet, packet_type;
+type lo_packet, packet_type;
 
 # Use network sockets.
 allow netdomain self:{ tcp_socket udp_socket } *;
@@ -13,6 +15,9 @@ allow netdomain port_type:udp_socket name_bind;
 allow netdomain port_type:tcp_socket name_bind;
 # Get route information.
 allow netdomain self:netlink_route_socket { create bind read nlmsg_read };
+# Send/recv packets.
+allow netdomain packet:packet { send recv };
+allow netdomain lo_packet:packet { send recv };
 
 # Talks to netd via dnsproxyd socket.
 unix_socket_connect(netdomain, dnsproxyd, netd)
diff --git a/netd.te b/netd.te
index 47687dc..6bfe2e2 100644
--- a/netd.te
+++ b/netd.te
@@ -12,6 +12,7 @@ allow netd self:rawip_socket *;
 allow netd self:udp_socket *;
 allow netd node:udp_socket node_bind;
 allow netd port:udp_socket name_bind;
+allow netd lo_packet:packet { send recv };
 allow netd self:unix_stream_socket *;
 allow netd shell_exec:file rx_file_perms;
 allow netd system_file:file x_file_perms;
diff --git a/unconfined.te b/unconfined.te
index ff53595..21d62c1 100644
--- a/unconfined.te
+++ b/unconfined.te
@@ -20,5 +20,6 @@ allow unconfineddomain netif_type:netif *;
 allow unconfineddomain port_type:socket_class_set name_bind;
 allow unconfineddomain port_type:{ tcp_socket dccp_socket } name_connect;
 allow unconfineddomain domain:peer recv;
+allow unconfineddomain packet_type:packet *;
 allow unconfineddomain domain:binder { call transfer receive };
 allow unconfineddomain property_type:property_service set;




-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
