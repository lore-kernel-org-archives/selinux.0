Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28EiFBT004575
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 09:44:15 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l28EiEko004619
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 14:44:14 GMT
Message-ID: <45F0213C.8020800@redhat.com>
Date: Thu, 08 Mar 2007 09:44:12 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: syslogd-ng defines tcp ports to connect to.
Content-Type: multipart/mixed;
 boundary="------------060304000705010907090409"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060304000705010907090409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

With this change they can use semanage to define additional ports.

--------------060304000705010907090409
Content-Type: text/x-patch;
 name="syslog.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syslog.patch"

--- nsaserefpolicy/policy/modules/system/logging.te	2007-02-23 16:50:01.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/system/logging.te	2007-03-08 08:42:37.000000000 -0500
@@ -328,6 +329,9 @@
 corenet_tcp_bind_all_nodes(syslogd_t)
 corenet_tcp_bind_rsh_port(syslogd_t)
 corenet_tcp_connect_rsh_port(syslogd_t)
+# Allow users to define additional syslog ports to connect to
+corenet_tcp_bind_syslogd_port(syslogd_t)
+corenet_tcp_connect_syslogd_port(syslogd_t)
 
 # syslog-ng can send or receive logs
 corenet_sendrecv_syslogd_client_packets(syslogd_t)
--- nsaserefpolicy/policy/modules/kernel/corenetwork.te.in	2007-02-19 11:32:51.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/kernel/corenetwork.te.in	2007-03-08 08:42:36.000000000 -0500
@@ -43,11 +43,16 @@
 sid port gen_context(system_u:object_r:port_t,s0)
 
 #
-# reserved_port_t is the type of INET port numbers below 1024.
+# reserved_port_t is the type of INET port numbers below 599.
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
@@ -140,6 +145,7 @@
 network_port(soundd, tcp,8000,s0, tcp,9433,s0)
 type socks_port_t, port_type; dnl network_port(socks) # no defined portcon
 type stunnel_port_t, port_type; dnl network_port(stunnel) # no defined portcon in current strict
+network_port(squid, udp,3401,s0, tcp,3401,s0, udp,4827,s0, tcp,4827,s0, )
 network_port(swat, tcp,901,s0)
 network_port(syslogd, udp,514,s0)
 network_port(telnetd, tcp,23,s0)
@@ -157,8 +163,11 @@
 
 # Defaults for reserved ports.  Earlier portcon entries take precedence;
 # these entries just cover any remaining reserved ports not otherwise declared.
-portcon tcp 1-1023 gen_context(system_u:object_r:reserved_port_t, s0)
-portcon udp 1-1023 gen_context(system_u:object_r:reserved_port_t, s0)
+
+portcon tcp 600-1023 gen_context(system_u:object_r:hi_reserved_port_t, s0)
+portcon udp 600-1023 gen_context(system_u:object_r:hi_reserved_port_t, s0)
+portcon tcp 1-599 gen_context(system_u:object_r:reserved_port_t, s0)
+portcon udp 1-599 gen_context(system_u:object_r:reserved_port_t, s0)
 
 ########################################
 #

--------------060304000705010907090409--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
