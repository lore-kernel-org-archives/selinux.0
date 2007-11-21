Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAL4T201030615
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2007 23:29:02 -0500
Received: from tyo202.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAL4SxkP025142
	for <selinux@tycho.nsa.gov>; Wed, 21 Nov 2007 04:29:00 GMT
Message-ID: <4743B38D.3070803@ak.jp.nec.com>
Date: Wed, 21 Nov 2007 13:26:53 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov, paul.moore@hp.com, DGoeddel@TrustedCS.com,
        vyekkirala@TrustedCS.com
Subject: Re: [PATCH] IPsec SPD default security context
References: <D709A20F2164C84E8B7014B0301F5EF87C72FA@HAVOC.tcs-sec.com>	 <47331BAB.8040107@kaigai.gr.jp>  <473872F8.7000208@ak.jp.nec.com>	 <1195055160.13737.33.camel@gorn.columbia.tresys.com>	 <473B23F9.4080506@ak.jp.nec.com>	 <1195064402.13737.42.camel@gorn.columbia.tresys.com>	 <473BB437.3070005@ak.jp.nec.com>	 <1195136813.13737.67.camel@gorn.columbia.tresys.com>	 <4740F30D.9000304@ak.jp.nec.com> <1195498093.16660.44.camel@gorn>	 <4742A571.1060601@ak.jp.nec.com> <1195583693.16660.49.camel@gorn>
In-Reply-To: <1195583693.16660.49.camel@gorn>
Content-Type: multipart/mixed;
 boundary="------------090506060500060506070903"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090506060500060506070903
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hi,

The attached patch provides the followins features:
 - Two new policy pattern "labeled_(tcp|udp)_pattern" are added
 - The postgresql_tcp_connect interface is revised to allow a domain
   to communicate with postgresql_t.
 - postgresql_t can communicate others via default SPD.
 - An obvious permission of "$1 self association:{sendto}" is allowed
   to any domain using ipsec_spd_t.
 - Any user-domain using core-networks can communicate others via
   default SPD.
 - Any user-domain can communicate postgresql_t via labeled networks.

>>> 	# compat labeled ipsec rule
>>> 	allow $1 self:association sendto;
>>>
>>> and then even the labeled networking part could be put into a policy
>>> pattern.
>> What does it means policy pattern?
> 
> Its a support macro.  See support/file_patterns.spt for file access
> patterns.

I see.
The attached patch provides "labeled_(tcp|udp)_pattern".

>> It's a bit unclear for me whether you intend to make a new template
>> interface like the one defined at kernel/corenetwork.if.m4, or make
>> a new interface for each daemon domains.
> 
> Each of the daemons would need it.

The attached patch revises the postgresql_tcp_connect interface
as the first one of them.

>> Is it same for the unconfined_domain_type? They can receive messages from
>> any domain, but the peer domain without unconfined_domain_type cannot receive
>> messages from unconfined_domain_type.
> 
> Good question.  I'm not sure.

There is an idea that a new boolean enables to turn on/off whether any domain
can accept labeled packets come from unconfined domain, or not.
Therefore, the attached patch does not touch the unconfined domain.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------090506060500060506070903
Content-Type: text/x-patch;
 name="refpolicy-labeled-network.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="refpolicy-labeled-network.2.patch"

Index: refpolicy/policy/modules/services/postgresql.if
===================================================================
--- refpolicy/policy/modules/services/postgresql.if	(revision 2530)
+++ refpolicy/policy/modules/services/postgresql.if	(working copy)
@@ -79,7 +79,7 @@
 
 ########################################
 ## <summary>
-##	Allow the specified domain to connect to postgresql with a tcp socket.  (Deprecated)
+##	Allow the specified domain to connect to postgresql with a tcp socket.
 ## </summary>
 ## <param name="domain">
 ##	<summary>
@@ -88,7 +88,13 @@
 ## </param>
 #
 interface(`postgresql_tcp_connect',`
-	refpolicywarn(`$0($*) has been deprecated.')
+	gen_require(`
+		type postgresql_t;
+	')
+	corenet_tcp_sendrecv_postgresql_port($1)
+	corenet_tcp_connect_postgresql_port($1)
+	corenet_sendrecv_postgresql_client_packets($1)
+	labeled_tcp_pattern($1,postgresql_t)
 ')
 
 ########################################
Index: refpolicy/policy/modules/services/apache.te
===================================================================
--- refpolicy/policy/modules/services/apache.te	(revision 2530)
+++ refpolicy/policy/modules/services/apache.te	(working copy)
@@ -369,14 +369,6 @@
 	corenet_tcp_connect_all_ports(httpd_t)
 ')
 
-tunable_policy(`httpd_can_network_connect_db',`
-	# allow httpd to connect to mysql/posgresql
-	corenet_tcp_connect_postgresql_port(httpd_t)
-	corenet_tcp_connect_mysqld_port(httpd_t)
-	corenet_sendrecv_postgresql_client_packets(httpd_t)
-	corenet_sendrecv_mysqld_client_packets(httpd_t)
-')
-
 tunable_policy(`httpd_can_network_relay',`
 	# allow httpd to work as a relay
 	corenet_tcp_connect_gopher_port(httpd_t)
@@ -457,8 +449,13 @@
 ')
 
 optional_policy(`
+	# Allow httpd to work with mysql
 	mysql_stream_connect(httpd_t)
 	mysql_rw_db_sockets(httpd_t)
+	tunable_policy(`httpd_can_network_connect_db',`
+		corenet_tcp_connect_mysqld_port(httpd_t)
+		corenet_sendrecv_mysqld_client_packets(httpd_t)
+	')
 ')
 
 optional_policy(`
@@ -476,6 +473,9 @@
 optional_policy(`
 	# Allow httpd to work with postgresql
 	postgresql_stream_connect(httpd_t)
+	tunable_policy(`httpd_can_network_connect_db',`
+		postgresql_tcp_connect(httpd_t)
+	')
 ')
 
 optional_policy(`
Index: refpolicy/policy/modules/services/postgresql.te
===================================================================
--- refpolicy/policy/modules/services/postgresql.te	(revision 2530)
+++ refpolicy/policy/modules/services/postgresql.te	(working copy)
@@ -154,6 +154,10 @@
 ')
 
 optional_policy(`
+	ipsec_match_default_spd(postgresql_t)
+')
+
+optional_policy(`
 	kerberos_use(postgresql_t)
 ')
 
Index: refpolicy/policy/modules/system/ipsec.if
===================================================================
--- refpolicy/policy/modules/system/ipsec.if	(revision 2530)
+++ refpolicy/policy/modules/system/ipsec.if	(working copy)
@@ -109,6 +109,7 @@
 	')
 
 	allow $1 ipsec_spd_t:association polmatch;
+	allow $1 self:association sendto;
 ')
 
 ########################################
Index: refpolicy/policy/modules/system/userdomain.if
===================================================================
--- refpolicy/policy/modules/system/userdomain.if	(revision 2530)
+++ refpolicy/policy/modules/system/userdomain.if	(working copy)
@@ -548,6 +548,8 @@
 	corenet_udp_sendrecv_all_ports($1_t)
 	corenet_tcp_connect_all_ports($1_t)
 	corenet_sendrecv_all_client_packets($1_t)
+
+	ipsec_match_default_spd($1_t)
 ')
 
 #######################################
@@ -840,6 +842,7 @@
 	optional_policy(`
 		tunable_policy(`allow_user_postgresql_connect',`
 			postgresql_stream_connect($1_t)
+			postgresql_tcp_connect($1_t)
 		')
 	')
 
Index: refpolicy/policy/support/ipc_patterns.spt
===================================================================
--- refpolicy/policy/support/ipc_patterns.spt	(revision 2530)
+++ refpolicy/policy/support/ipc_patterns.spt	(working copy)
@@ -12,3 +12,18 @@
 	allow $1 $3:sock_file { getattr write };
 	allow $1 $4:unix_dgram_socket sendto;
 ')
+
+#
+# labeled networking patterns
+#
+define(`labeled_tcp_pattern',`
+	allow $1 $2:{association tcp_socket} recvfrom;
+	allow $2 $1:{association tcp_socket} recvfrom;
+	allow $1 self:association sendto;
+')
+
+define(`labeled_udp_pattern',`
+	allow $1 $2:{association udp_socket} recvfrom;
+	allow $2 $1:{association udp_socket} recvfrom;
+	allow $1 self:association sendto;
+')

--------------090506060500060506070903--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
