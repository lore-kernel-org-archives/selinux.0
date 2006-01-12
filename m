Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0CJ2oXf013239
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2006 14:02:50 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0CJ1f5L008258
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2006 19:01:42 GMT
From: Spencer Shimko <sshimko@tresys.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH] sereference: network macros and permissions
Date: Thu, 12 Jan 2006 14:03:36 -0500
Cc: "PeBenito, Christopher" <cpebenito@tresys.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IgqxDfdX/t3kEX7"
Message-Id: <200601121403.36679.sshimko@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_IgqxDfdX/t3kEX7
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch modifies networking in reference policy in several 
ways:

-It adds support for generating corenetwork interfaces based on attributes 
in addition to types.  create_???_type_interfaces  
create_???_attrib_interfaces have been added to corenetwork.if.m4.

-Removes an extraneous delcare_ports macro from corenetwork.if.m4.

-Adds declare_nodes to corenetwork.te.m4.  Permits the listing of multiple 
nodes in a network_node() that will be given the same type.

The patch also adds two new permission sets to the object class permission 
support macros.

Thanks,
Spencer
-- 
Spencer Shimko
Tresys Technology, LLC
(410) 290 - 1411 ext. 125
sshimko@tresys.com

--Boundary-00=_IgqxDfdX/t3kEX7
Content-Type: text/x-diff;
  charset="us-ascii";
  name="refpol-net.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="refpol-net.diff"

diff -urN refpolicy-old/policy/modules/kernel/corenetwork.if.m4 refpolicy-new/policy/modules/kernel/corenetwork.if.m4
--- refpolicy-old/policy/modules/kernel/corenetwork.if.m4	2005-10-21 09:11:17.000000000 -0400
+++ refpolicy-new/policy/modules/kernel/corenetwork.if.m4	2006-01-12 12:54:38.000000000 -0500
@@ -21,12 +21,12 @@
 ## </param>
 ## <infoflow type="both" weight="10"/>
 #
-interface(`corenet_tcp_sendrecv_$1',`
+interface(`corenet_tcp_sendrecv_$1_netif',`
 	gen_require(`
-		type $1_netif_t;
+		$3 $1_$2;
 	')
 
-	allow dollarsone $1_netif_t:netif { tcp_send tcp_recv };
+	allow dollarsone $1_$2:netif { tcp_send tcp_recv };
 ')
 
 ########################################
@@ -38,12 +38,12 @@
 ## </param>
 ## <infoflow type="write" weight="10"/>
 #
-interface(`corenet_udp_send_$1',`
+interface(`corenet_udp_send_$1_netif',`
 	gen_require(`
-		type $1_netif_t;
+		$3 $1_$2;
 	')
 
-	allow dollarsone $1_netif_t:netif udp_send;
+	allow dollarsone $1_$2:netif udp_send;
 ')
 
 ########################################
@@ -55,12 +55,12 @@
 ## </param>
 ## <infoflow type="read" weight="10"/>
 #
-interface(`corenet_udp_receive_$1',`
+interface(`corenet_udp_receive_$1_netif',`
 	gen_require(`
-		type $1_netif_t;
+		$3 $1_$2;
 	')
 
-	allow dollarsone $1_netif_t:netif udp_recv;
+	allow dollarsone $1_$2:netif udp_recv;
 ')
 
 ########################################
@@ -72,7 +72,7 @@
 ## </param>
 ## <infoflow type="both" weight="10"/>
 #
-interface(`corenet_udp_sendrecv_$1',`
+interface(`corenet_udp_sendrecv_$1_netif',`
 	corenet_udp_send_$1(dollarsone)
 	corenet_udp_receive_$1(dollarsone)
 ')
@@ -86,12 +86,12 @@
 ## </param>
 ## <infoflow type="write" weight="10"/>
 #
-interface(`corenet_raw_send_$1',`
+interface(`corenet_raw_send_$1_netif',`
 	gen_require(`
-		type $1_netif_t;
+		$3 $1_$2;
 	')
 
-	allow dollarsone $1_netif_t:netif rawip_send;
+	allow dollarsone $1_$2:netif rawip_send;
 
 	# cjp: comment out until raw access is
 	# is fixed for network users
@@ -107,12 +107,12 @@
 ## </param>
 ## <infoflow type="read" weight="10"/>
 #
-interface(`corenet_raw_receive_$1',`
+interface(`corenet_raw_receive_$1_netif',`
 	gen_require(`
-		type $1_netif_t;
+		$3 $1_$2;
 	')
 
-	allow dollarsone $1_netif_t:netif rawip_recv;
+	allow dollarsone $1_$2:netif rawip_recv;
 ')
 
 ########################################
@@ -124,7 +124,7 @@
 ## </param>
 ## <infoflow type="both" weight="10"/>
 #
-interface(`corenet_raw_sendrecv_$1',`
+interface(`corenet_raw_sendrecv_$1_netif',`
 	corenet_raw_send_$1(dollarsone)
 	corenet_raw_receive_$1(dollarsone)
 ')
@@ -148,10 +148,10 @@
 #
 interface(`corenet_tcp_sendrecv_$1_node',`
 	gen_require(`
-		type $1_node_t;
+		$3 $1_$2;
 	')
 
-	allow dollarsone $1_node_t:node { tcp_send tcp_recv };
+	allow dollarsone $1_$2:node { tcp_send tcp_recv };
 ')
 
 ########################################
@@ -165,10 +165,10 @@
 #
 interface(`corenet_udp_send_$1_node',`
 	gen_require(`
-		type $1_node_t;
+		$3 $1_$2;
 	')
 
-	allow dollarsone $1_node_t:node udp_send;
+	allow dollarsone $1_$2:node udp_send;
 ')
 
 ########################################
@@ -182,10 +182,10 @@
 #
 interface(`corenet_udp_receive_$1_node',`
 	gen_require(`
-		type $1_node_t;
+		$3 $1_$2;
 	')
 
-	allow dollarsone $1_node_t:node udp_recv;
+	allow dollarsone $1_$2:node udp_recv;
 ')
 
 ########################################
@@ -213,10 +213,10 @@
 #
 interface(`corenet_raw_send_$1_node',`
 	gen_require(`
-		type $1_node_t;
+		$3 $1_$2;
 	')
 
-	allow dollarsone $1_node_t:node rawip_send;
+	allow dollarsone $1_$2:node rawip_send;
 ')
 
 ########################################
@@ -230,10 +230,10 @@
 #
 interface(`corenet_raw_receive_$1_node',`
 	gen_require(`
-		type $1_node_t;
+		$3 $1_$2;
 	')
 
-	allow dollarsone $1_node_t:node rawip_recv;
+	allow dollarsone $1_$2:node rawip_recv;
 ')
 
 ########################################
@@ -261,10 +261,10 @@
 #
 interface(`corenet_tcp_bind_$1_node',`
 	gen_require(`
-		type $1_node_t;
+		$3 $1_$2;
 	')
 
-	allow dollarsone $1_node_t:tcp_socket node_bind;
+	allow dollarsone $1_$2:tcp_socket node_bind;
 ')
 
 ########################################
@@ -278,10 +278,10 @@
 #
 interface(`corenet_udp_bind_$1_node',`
 	gen_require(`
-		type $1_node_t;
+		$3 $1_$2;
 	')
 
-	allow dollarsone $1_node_t:udp_socket node_bind;
+	allow dollarsone $1_$2:udp_socket node_bind;
 ')
 '') dnl end create_node_interfaces
 
@@ -303,10 +303,10 @@
 #
 interface(`corenet_tcp_sendrecv_$1_port',`
 	gen_require(`
-		type $1_port_t;
+		$3 $1_$2;
 	')
 
-	allow dollarsone $1_port_t:tcp_socket { send_msg recv_msg };
+	allow dollarsone $1_$2:tcp_socket { send_msg recv_msg };
 ')
 
 ########################################
@@ -320,10 +320,10 @@
 #
 interface(`corenet_udp_send_$1_port',`
 	gen_require(`
-		type $1_port_t;
+		$3 $1_$2;
 	')
 
-	allow dollarsone $1_port_t:udp_socket send_msg;
+	allow dollarsone $1_$2:udp_socket send_msg;
 ')
 
 ########################################
@@ -337,10 +337,10 @@
 #
 interface(`corenet_udp_receive_$1_port',`
 	gen_require(`
-		type $1_port_t;
+		$3 $1_$2;
 	')
 
-	allow dollarsone $1_port_t:udp_socket recv_msg;
+	allow dollarsone $1_$2:udp_socket recv_msg;
 ')
 
 ########################################
@@ -368,11 +368,11 @@
 #
 interface(`corenet_tcp_bind_$1_port',`
 	gen_require(`
-		type $1_port_t;
+		$3 $1_$2;
 	')
 
-	allow dollarsone $1_port_t:tcp_socket name_bind;
-	$2
+	allow dollarsone $1_$2:tcp_socket name_bind;
+	$4
 ')
 
 ########################################
@@ -386,11 +386,11 @@
 #
 interface(`corenet_udp_bind_$1_port',`
 	gen_require(`
-		type $1_port_t;
+		$3 $1_$2;
 	')
 
-	allow dollarsone $1_port_t:udp_socket name_bind;
-	$2
+	allow dollarsone $1_$2:udp_socket name_bind;
+	$4
 ')
 
 ########################################
@@ -403,43 +403,65 @@
 #
 interface(`corenet_tcp_connect_$1_port',`
 	gen_require(`
-		type $1_port_t;
+		$3 $1_$2;
 	')
 
-	allow dollarsone $1_port_t:tcp_socket name_connect;
+	allow dollarsone $1_$2:tcp_socket name_connect;
 ')
 '') dnl end create_port_interfaces
 
 #
+# create_netif_*_interfaces(linux_interfacename)
+#
+define(`create_netif_type_interfaces',`
+create_netif_interfaces($1,netif_t,type)
+')
+define(`create_netif_attrib_interfaces',`
+create_netif_interfaces($1,netif,attribute)
+')
+
+#
 # network_interface(linux_interfacename,mls_sensitivity)
 #
 define(`network_interface',`
-create_netif_interfaces($1)
+create_netif_type_interfaces($1)
+')
+
+#
+# create_node_*_interfaces(node_name)
+#
+define(`create_node_type_interfaces',`
+create_node_interfaces($1,node_t,type)
+')
+define(`create_node_attrib_interfaces',`
+create_node_interfaces($1,node,attribute)
 ')
 
 #
 # network_node(node_name,mls_sensitivity,address,netmask)
 #
 define(`network_node',`
-create_node_interfaces($1)
+create_node_type_interfaces($1)
 ')
 
 # These next three macros have formatting, and should not me indented
 define(`determine_reserved_capability',`dnl
+ifelse($2,`',`',`dnl
 ifelse(eval($2 < 1024),1,``allow' dollarsone self:capability net_bind_service;',`dnl
-ifelse($4,`',`',`determine_reserved_capability(shiftn(3,$*))')dnl end inner ifelse
+determine_reserved_capability(shiftn(3,$*))dnl
+')dnl end inner ifelse
 ')dnl end outer ifelse
 ') dnl end determine reserved capability
 
-define(`declare_ports',`dnl
-ifelse(eval($3 < 1024),1,`typeattribute $1 reserved_port_type;',`dnl')
-portcon $2 $3 gen_context(system_u:object_r:$1,$4)
-ifelse(`$5',`',`',`declare_ports($1,shiftn(4,$*))')dnl
-')
+#
+# create_port_*_interfaces(port_name, protocol portnum mls_sensitivity [,protocol portnum mls_sensitivity[,...]])
+# (these wrap create_port_interfaces to handle attributes and types)
+define(`create_port_type_interfaces',`create_port_interfaces($1,port_t,type,determine_reserved_capability(shift($*)))')
+define(`create_port_attrib_interfaces',`create_port_interfaces($1,port,attribute,determine_reserved_capability(shift($*)))')
 
 #
 # network_port(port_name,protocol portnum mls_sensitivity [,protocol portnum mls_sensitivity[,...]])
 #
 define(`network_port',`
-create_port_interfaces($1,determine_reserved_capability(shift($*)))
+create_port_type_interfaces($*)
 ')
diff -urN refpolicy-old/policy/modules/kernel/corenetwork.te.in refpolicy-new/policy/modules/kernel/corenetwork.te.in
--- refpolicy-old/policy/modules/kernel/corenetwork.te.in	2006-01-06 17:51:40.000000000 -0500
+++ refpolicy-new/policy/modules/kernel/corenetwork.te.in	2006-01-12 13:20:01.000000000 -0500
@@ -169,4 +169,4 @@
 ifdef(`enable_mls', `
 network_interface(lo, lo,s0 - s15:c0.c255)
 ')
-#network_interface(eth0, eth0,s0)
+#network_interface(eth0, eth0, s0)
diff -urN refpolicy-old/policy/modules/kernel/corenetwork.te.m4 refpolicy-new/policy/modules/kernel/corenetwork.te.m4
--- refpolicy-old/policy/modules/kernel/corenetwork.te.m4	2005-10-21 09:11:17.000000000 -0400
+++ refpolicy-new/policy/modules/kernel/corenetwork.te.m4	2006-01-12 12:58:51.000000000 -0500
@@ -19,12 +19,17 @@
 declare_netifs($1_netif_t,shift($*))
 ')
 
+define(`declare_nodes',`dnl
+nodecon $3 $4 gen_context(system_u:object_r:$1,$2)
+ifelse(`$5',`',`',`declare_nodes($1,shiftn(4,$*))')dnl
+')
+
 #
-# network_node(node_name,mls_sensitivity,address,netmask)
+# network_node(node_name,mls_sensitivity,address,netmask[, linux_interface, mls_sensitivity [...]])
 #
 define(`network_node',`
 type $1_node_t alias node_$1_t, node_type;
-nodecon $3 $4 gen_context(system_u:object_r:$1_node_t,$2)
+declare_nodes($1_node_t,shift($*))
 ')
 
 # These next three macros have formatting, and should not me indented
diff -urN refpolicy-old/policy/support/obj_perm_sets.spt refpolicy-new/policy/support/obj_perm_sets.spt
--- refpolicy-old/policy/support/obj_perm_sets.spt	2005-10-21 15:36:49.000000000 -0400
+++ refpolicy-new/policy/support/obj_perm_sets.spt	2006-01-12 12:59:37.000000000 -0500
@@ -147,6 +147,15 @@
 # 
 define(`connected_stream_socket_perms', `{ connected_socket_perms listen accept }')
 
+#
+# Permissions for stream socket clients (don't need accept list)
+#
+define(`client_stream_socket_perms', `{ create ioctl read getattr write setattr append bind getopt setopt shutdown }')
+
+#
+# Permissions for stream socket servers 
+#
+define(`server_stream_socket_perms', `{ client_stream_socket_perms listen accept }')
 
 #
 # Permissions for creating and using netlink sockets.

--Boundary-00=_IgqxDfdX/t3kEX7--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
