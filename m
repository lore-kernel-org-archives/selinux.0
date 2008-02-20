Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1K5CDkf020602
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 00:12:13 -0500
Received: from tyo201.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1K5CBlK015615
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 05:12:12 GMT
Message-ID: <47BBB69C.2050007@ak.jp.nec.com>
Date: Wed, 20 Feb 2008 14:11:56 +0900
From: Kohei KaiGai <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov, DGoeddel@TrustedCS.com, vyekkirala@TrustedCS.com
Subject: Re: [PATCH] Labeled IPsec for PostgreSQL/MySQL/SSHd (Re: [PATCH]
 IPsec SPD default security context)
References: <D709A20F2164C84E8B7014B0301F5EF87C72FA@HAVOC.tcs-sec.com> <1203428116.13618.77.camel@gorn> <47BB7B6A.1090207@ak.jp.nec.com> <200802192237.22546.paul.moore@hp.com>
In-Reply-To: <200802192237.22546.paul.moore@hp.com>
Content-Type: multipart/mixed;
 boundary="------------070900000900070705060806"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070900000900070705060806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Paul Moore wrote:
> On Tuesday 19 February 2008 7:59:22 pm Kohei KaiGai wrote:
>> Is it acceptable one, if we provide an interface to allow a domain
>> to communicate postgresql_t via labeled networking, separated from
>> existing permissions for local ports and nodes?
>>
>> For example:
>> -- at postgresql.if
>> interface(`postgresql_labeled_connect',`
>> 	gen_require(`
>> 		type postgresql_t;
>> 	')
>> 	corenet_tcp_recvfrom_labeled($1,postgresql_t)
>> ')
>>
>> and
>> -- at apache.te
>> postgresql_labeled_connect(httpd_t)
>>
>> I think this approach enables to keep independency between modules
>> in unlabeled networking cases too.
> 
> For what it is worth, it looks like a good idea to me.

At first, I implemented this idea for three services (PostgreSQL/MySQL/SSHd).

This patch adds the following interfaces:
- postgresql_labeled_communicate(domain)
- mysql_labeled_communicate(domain)
- ssh_labeled_communicate(domain)

Chris, is it suitable for refpolicy framework?

Thanks
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------070900000900070705060806
Content-Type: text/x-patch;
 name="refpolicy-labeled_communicate.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="refpolicy-labeled_communicate.patch"

Index: refpolicy/policy/modules/services/postgresql.if
===================================================================
--- refpolicy/policy/modules/services/postgresql.if	(revision 2614)
+++ refpolicy/policy/modules/services/postgresql.if	(working copy)
@@ -79,7 +79,7 @@
 
 ########################################
 ## <summary>
-##	Allow the specified domain to connect to postgresql with a tcp socket.
+##	Allow the specified domain to connect to postgresql with a tcp socket.  (Deprecated)
 ## </summary>
 ## <param name="domain">
 ##	<summary>
@@ -88,14 +88,7 @@
 ## </param>
 #
 interface(`postgresql_tcp_connect',`
-	gen_require(`
-		type postgresql_t;
-	')
-
-	corenet_tcp_recvfrom_labeled($1,postgresql_t)
-	corenet_tcp_sendrecv_postgresql_port($1)
-	corenet_tcp_connect_postgresql_port($1)
-	corenet_sendrecv_postgresql_client_packets($1)
+	refpolicywarn(`$0($*) has been deprecated.')
 ')
 
 ########################################
@@ -120,3 +113,20 @@
         # Some versions of postgresql put the sock file in /tmp
 	allow $1 postgresql_tmp_t:sock_file write;
 ')
+
+########################################
+## <summary>
+##	Allow the specified domain to communicate with postgresql via labeled network.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`postgresql_labeled_communicate',`
+	gen_require(`
+		type postgresql_t;
+	')
+	corenet_tcp_recvfrom_labeled($1,postgresql_t)
+')
Index: refpolicy/policy/modules/services/ssh.te
===================================================================
--- refpolicy/policy/modules/services/ssh.te	(revision 2614)
+++ refpolicy/policy/modules/services/ssh.te	(working copy)
@@ -109,6 +109,10 @@
 ')
 
 optional_policy(`
+	ipsec_match_default_spd(sshd_t)
+')
+
+optional_policy(`
 	rpm_use_script_fds(sshd_t)
 ')
 
Index: refpolicy/policy/modules/services/mysql.if
===================================================================
--- refpolicy/policy/modules/services/mysql.if	(revision 2614)
+++ refpolicy/policy/modules/services/mysql.if	(working copy)
@@ -39,6 +39,23 @@
 
 ########################################
 ## <summary>
+##	Allow the specified domain to communicate with MySQL via labeled network.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`mysql_labeled_communicate',`
+	gen_require(`
+		type mysqld_t;
+	')
+	corenet_tcp_recvfrom_labeled($1,mysqld_t)
+')
+
+########################################
+## <summary>
 ##	Read MySQL configuration files.
 ## </summary>
 ## <param name="domain">
Index: refpolicy/policy/modules/services/apache.te
===================================================================
--- refpolicy/policy/modules/services/apache.te	(revision 2614)
+++ refpolicy/policy/modules/services/apache.te	(working copy)
@@ -370,6 +370,14 @@
 	corenet_tcp_connect_all_ports(httpd_t)
 ')
 
+tunable_policy(`httpd_can_network_connect_db',`
+	# allow httpd to connect to mysql/posgresql
+	corenet_tcp_connect_postgresql_port(httpd_t)
+	corenet_tcp_connect_mysqld_port(httpd_t)
+	corenet_sendrecv_postgresql_client_packets(httpd_t)
+	corenet_sendrecv_mysqld_client_packets(httpd_t)
+')
+
 tunable_policy(`httpd_can_network_relay',`
 	# allow httpd to work as a relay
 	corenet_tcp_connect_gopher_port(httpd_t)
@@ -455,8 +463,7 @@
 	mysql_rw_db_sockets(httpd_t)
 
 	tunable_policy(`httpd_can_network_connect_db',`
-		corenet_tcp_connect_mysqld_port(httpd_t)
-		corenet_sendrecv_mysqld_client_packets(httpd_t)
+		mysql_labeled_communicate(httpd_t)
 	')
 ')
 
@@ -477,7 +484,7 @@
 	postgresql_stream_connect(httpd_t)
 
 	tunable_policy(`httpd_can_network_connect_db',`
-		postgresql_tcp_connect(httpd_t)
+		postgresql_labeled_communicate(httpd_t)
 	')
 ')
 
Index: refpolicy/policy/modules/services/ssh.if
===================================================================
--- refpolicy/policy/modules/services/ssh.if	(revision 2614)
+++ refpolicy/policy/modules/services/ssh.if	(working copy)
@@ -640,6 +640,23 @@
 
 ########################################
 ## <summary>
+##	Allow the specified domain to communicate with SSH daemons via labeled network.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`ssh_labeled_communicate',`
+	gen_require(`
+		type sshd_t;
+	')
+	corenet_tcp_recvfrom_labeled($1,sshd_t)
+')
+
+########################################
+## <summary>
 ##	Execute the ssh daemon sshd domain.
 ## </summary>
 ## <param name="domain">
Index: refpolicy/policy/modules/services/apache.if
===================================================================
--- refpolicy/policy/modules/services/apache.if	(revision 2614)
+++ refpolicy/policy/modules/services/apache.if	(working copy)
@@ -226,6 +226,18 @@
 	')
 
 	optional_policy(`
+		tunable_policy(`httpd_enable_cgi && httpd_can_network_connect_db',`
+			mysql_labeled_communicate(httpd_$1_script_t)
+		')
+	')
+
+	optional_policy(`
+		tunable_policy(`httpd_enable_cgi && httpd_can_network_connect_db',`
+			postgresql_labeled_communicate(httpd_$1_script_t)
+		')
+	')
+
+	optional_policy(`
 		nscd_socket_use(httpd_$1_script_t)
 	')
 ')
Index: refpolicy/policy/modules/system/userdomain.if
===================================================================
--- refpolicy/policy/modules/system/userdomain.if	(revision 2614)
+++ refpolicy/policy/modules/system/userdomain.if	(working copy)
@@ -834,6 +834,7 @@
 	optional_policy(`
 		tunable_policy(`allow_user_mysql_connect',`
 			mysql_stream_connect($1_t)
+			mysql_labeled_communicate($1_t)
 		')
 	')
 
@@ -850,7 +851,7 @@
 	optional_policy(`
 		tunable_policy(`allow_user_postgresql_connect',`
 			postgresql_stream_connect($1_t)
-			postgresql_tcp_connect($1_t)
+			postgresql_labeled_communicate($1_t)
 		')
 	')
 
@@ -872,6 +873,10 @@
 	')
 
 	optional_policy(`
+		ssh_labeled_communicate($1_t)
+	')
+
+	optional_policy(`
 		usernetctl_run($1_t,$1_r,{ $1_devpts_t $1_tty_device_t })
 	')
 ')

--------------070900000900070705060806--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
