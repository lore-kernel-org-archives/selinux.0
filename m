Message-ID: <4550E039.6080601@redhat.com>
Date: Tue, 07 Nov 2006 14:36:25 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Proposed patch for handling bindresvport call.
Content-Type: multipart/mixed;
 boundary="------------010504090206010504030607"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010504090206010504030607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Currently we handle reserved ports from 1-1023 by defining 
reserved_port_t to cover that range.  The bindresvport call which I 
believe results in most if not all of the 
corenet_bind_all_reserved_ports calls in policy, actually only binds to 
512-1023.  

I propose with this patch that we break the range in to, adding a 
hi_reserved_port_t to reserved_port_t and making reserved_port_t go from 
1-511 and hi_reserved_port_t go from 512-1023. 

This fixes a bug in the calls to corenet_bind_all_rpc_ports, which 
currently fails on undefined ports.

Perhaps we should rename this call.

Eventually we should replace all corenet_bind_all_reserved_ports with 
corenet_bind_all_rpc_ports.


Dan

--------------010504090206010504030607
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/corenetwork.if.in serefpolicy-2.4.3/policy/modules/kernel/corenetwork.if.in
--- nsaserefpolicy/policy/modules/kernel/corenetwork.if.in	2006-10-17 13:47:44.000000000 -0400
+++ serefpolicy-2.4.3/policy/modules/kernel/corenetwork.if.in	2006-11-07 11:31:40.000000000 -0500
@@ -998,9 +998,11 @@
 interface(`corenet_tcp_sendrecv_reserved_port',`
 	gen_require(`
 		type reserved_port_t;
+		type hi_reserved_port_t;
 	')
 
 	allow $1 reserved_port_t:tcp_socket { send_msg recv_msg };
+	allow $1 hi_reserved_port_t:tcp_socket { send_msg recv_msg };
 ')
 
 ########################################
@@ -1016,9 +1018,11 @@
 interface(`corenet_udp_send_reserved_port',`
 	gen_require(`
 		type reserved_port_t;
+		type hi_reserved_port_t;
 	')
 
 	allow $1 reserved_port_t:udp_socket send_msg;
+	allow $1 hi_reserved_port_t:udp_socket send_msg;
 ')
 
 ########################################
@@ -1034,9 +1038,11 @@
 interface(`corenet_udp_receive_reserved_port',`
 	gen_require(`
 		type reserved_port_t;
+		type hi_reserved_port_t;
 	')
 
 	allow $1 reserved_port_t:udp_socket recv_msg;
+	allow $1 hi_reserved_port_t:udp_socket recv_msg;
 ')
 
 ########################################
@@ -1067,9 +1073,11 @@
 interface(`corenet_tcp_bind_reserved_port',`
 	gen_require(`
 		type reserved_port_t;
+		type hi_reserved_port_t;
 	')
 
 	allow $1 reserved_port_t:tcp_socket name_bind;
+	allow $1 hi_reserved_port_t:tcp_socket name_bind;
 	allow $1 self:capability net_bind_service;
 ')
 
@@ -1086,9 +1094,11 @@
 interface(`corenet_udp_bind_reserved_port',`
 	gen_require(`
 		type reserved_port_t;
+		type hi_reserved_port_t;
 	')
 
 	allow $1 reserved_port_t:udp_socket name_bind;
+	allow $1 hi_reserved_port_t:udp_socket name_bind;
 	allow $1 self:capability net_bind_service;
 ')
 
@@ -1105,9 +1115,11 @@
 interface(`corenet_tcp_connect_reserved_port',`
 	gen_require(`
 		type reserved_port_t;
+		type hi_reserved_port_t;
 	')
 
 	allow $1 reserved_port_t:tcp_socket name_connect;
+	allow $1 hi_reserved_port_t:tcp_socket name_connect;
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/corenetwork.te.in serefpolicy-2.4.3/policy/modules/kernel/corenetwork.te.in
--- nsaserefpolicy/policy/modules/kernel/corenetwork.te.in	2006-11-06 11:13:17.000000000 -0500
+++ serefpolicy-2.4.3/policy/modules/kernel/corenetwork.te.in	2006-11-07 11:32:22.000000000 -0500
@@ -43,11 +43,16 @@
 sid port gen_context(system_u:object_r:port_t,s0)
 
 #
-# reserved_port_t is the type of INET port numbers below 1024.
+# reserved_port_t is the type of INET port numbers below 512.
 #
 type reserved_port_t, port_type, reserved_port_type;
 
 #
+# hi_reserved_port_t is the type of INET port numbers between 600-1023.
+#
+type hi_reserved_port_t, port_type, reserved_port_type, rpc_port_type;
+
+#
 # server_packet_t is the default type of IPv4 and IPv6 server packets.
 #
 type server_packet_t, packet_type, server_packet_type;
@@ -152,8 +160,11 @@
 
 # Defaults for reserved ports.  Earlier portcon entries take precedence;
 # these entries just cover any remaining reserved ports not otherwise declared.
-portcon tcp 1-1023 gen_context(system_u:object_r:reserved_port_t, s0)
-portcon udp 1-1023 gen_context(system_u:object_r:reserved_port_t, s0)
+
+portcon tcp 512-1023 gen_context(system_u:object_r:hi_reserved_port_t, s0)
+portcon udp 512-1023 gen_context(system_u:object_r:hi_reserved_port_t, s0)
+portcon tcp 1-511 gen_context(system_u:object_r:reserved_port_t, s0)
+portcon udp 1-511 gen_context(system_u:object_r:reserved_port_t, s0)
 
 ########################################
 #
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/corenetwork.te.m4 serefpolicy-2.4.3/policy/modules/kernel/corenetwork.te.m4
--- nsaserefpolicy/policy/modules/kernel/corenetwork.te.m4	2006-09-29 14:28:01.000000000 -0400
+++ serefpolicy-2.4.3/policy/modules/kernel/corenetwork.te.m4	2006-11-07 11:08:36.000000000 -0500
@@ -55,8 +55,8 @@
 define(`declare_ports',`dnl
 ifelse(eval($3 < 1024),1,`
 typeattribute $1 reserved_port_type;
-#bindresvport in glibc starts searching for reserved ports at 600
-ifelse(eval($3 >= 600),1,`typeattribute $1 rpc_port_type;',`dnl')
+#bindresvport in glibc starts searching for reserved ports at 512
+ifelse(eval($3 >= 512),1,`typeattribute $1 rpc_port_type;',`dnl')
 ',`dnl')
 portcon $2 $3 gen_context(system_u:object_r:$1,$4)
 ifelse(`$5',`',`',`declare_ports($1,shiftn(4,$*))')dnl

--------------010504090206010504030607--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
