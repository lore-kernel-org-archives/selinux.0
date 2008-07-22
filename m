Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6MAnsT5011558
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 06:49:54 -0400
Received: from tyo202.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6MAnqfY021260
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 10:49:53 GMT
Message-ID: <4885BB42.4060603@ak.jp.nec.com>
Date: Tue, 22 Jul 2008 19:49:38 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        DGoeddel@TrustedCS.com, vyekkirala@TrustedCS.com
Subject: Re: [PATCH] Communication between domains under labeled networks
References: <D709A20F2164C84E8B7014B0301F5EF87C72FA@HAVOC.tcs-sec.com>	 <1203428116.13618.77.camel@gorn> <47BB7B6A.1090207@ak.jp.nec.com>	 <200802192237.22546.paul.moore@hp.com>  <47BBB69C.2050007@ak.jp.nec.com>	 <1203955972.32061.55.camel@gorn> <47C3738A.3010007@ak.jp.nec.com>	 <4860BA1B.5030302@ak.jp.nec.com>  <4861DED0.9050407@ak.jp.nec.com> <1216388484.21191.139.camel@gorn>
In-Reply-To: <1216388484.21191.139.camel@gorn>
Content-Type: multipart/mixed;
 boundary="------------080907070009000501050206"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080907070009000501050206
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Christopher J. PeBenito wrote:
> On Wed, 2008-06-25 at 14:59 +0900, KaiGai Kohei wrote:
>> Hi,
>>
>> The attached patch allows user domains to communicate with daemon
>> domain, and some other domains (Apache and CGI script) to communicate
>> with RDBMS (PostgreSQL and MySQL) using xxxx_tcp_connect() interface.
>>
>> This approach enables to cover most of relationship needed.
>> All we have to do is to describe the rest of relationship like
>> ones between CGI script and RDBMS, daemons and name server,
>> anything and samba server, ....
>>
>> At least, we cannot get labeled networks available unless adding
>> policies to communicate between proper domains.
>> I think it is necessary to make a decision to describe the policies.
> 
>>
>>
>>
>>
>> differences
>> between files
>> attachment
>> (refpolicy-labeled_communication.2.patch)

The attached patch is a revised version.
Please review it again.

And I also noticed that ipsec_match_default_spd() should be invoked with
server's domain as postgresql_t doing.
(e.g: communication between staff_t and sshd_t)
I think it also should be allowed for whole of daemon attribute.
What is your opinion? The version.3 patch also contains this fix.


>> Index: refpolicy/policy/modules/services/apache.if
>> ===================================================================
>> --- refpolicy/policy/modules/services/apache.if (revision 2733)
>> +++ refpolicy/policy/modules/services/apache.if (working copy)
>> @@ -189,10 +189,8 @@
>>                 corenet_udp_sendrecv_all_nodes(httpd_$1_script_t)
>>                 corenet_tcp_sendrecv_all_ports(httpd_$1_script_t)
>>                 corenet_udp_sendrecv_all_ports(httpd_$1_script_t)
>> -               corenet_tcp_connect_postgresql_port(httpd_$1_script_t)
>> -               corenet_tcp_connect_mysqld_port(httpd_$1_script_t)
>> -               corenet_sendrecv_postgresql_client_packets(httpd_
>> $1_script_t)
>> -               corenet_sendrecv_mysqld_client_packets(httpd_
>> $1_script_t)
>> +               postgresql_tcp_connect(httpd_$1_script_t)
>> +               mysql_tcp_connect(httpd_$1_script_t)
>>  
>>                 sysnet_read_config(httpd_$1_script_t)
>>         ')
> 
> In this case, we want to break out the two databases into individual
> optionals, e.g.
> 
> optional_policy(`
>    tunable_policy(`.... && ....',`
>       mysql_tcp_connect()
>    ')
> ')

OK, these are separated from the tunable block.


> In fact we may want to just duplicate the whole tunable since the other
> perms don't make much sense if you cant connect to mysql or postgresql.
> 
>> Index: refpolicy/policy/modules/system/init.if
>> ===================================================================
>> --- refpolicy/policy/modules/system/init.if     (revision 2733)
>> +++ refpolicy/policy/modules/system/init.if     (working copy)
>> @@ -1273,3 +1273,37 @@
>>         files_search_pids($1)
>>         allow $1 initrc_var_run_t:file manage_file_perms;
>>  ')
> [...]
>> +interface(`daemon_labeled_tcp_recvfrom',`
>> +       gen_require(`
>> +               attribute daemon;
>> +       ')
>> +       corenet_tcp_recvfrom_labeled($1,daemon)
>> +')
>> +
> [...]
>> +interface(`daemon_labeled_udp_recvfrom',`
>> +       gen_require(`
>> +               attribute daemon;
>> +       ')
>> +       corenet_udp_recvfrom_labeled($1,daemon)
>> +')
>>
> 
> Both interfaces need naming fixes.  init_tcp_recvfrom_all_daemons() and
> init_udp_recvfrom_all_daemons().

OK, these are renamed.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------080907070009000501050206
Content-Type: text/x-patch;
 name="refpolicy-labeled_communication.3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="refpolicy-labeled_communication.3.patch"

Index: refpolicy/policy/modules/services/mysql.if
===================================================================
--- refpolicy/policy/modules/services/mysql.if	(revision 2762)
+++ refpolicy/policy/modules/services/mysql.if	(working copy)
@@ -20,6 +20,27 @@
 
 ########################################
 ## <summary>
+##	Allow the specified domain to connect to postgresql with a tcp socket.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`mysql_tcp_connect',`
+	gen_require(`
+		type mysqld_t;
+	')
+
+	corenet_tcp_recvfrom_labeled($1,mysqld_t)
+	corenet_tcp_sendrecv_mysqld_port($1)
+	corenet_tcp_connect_mysqld_port($1)
+	corenet_sendrecv_mysqld_client_packets($1)
+')
+
+########################################
+## <summary>
 ##	Connect to MySQL using a unix domain stream socket.
 ## </summary>
 ## <param name="domain">
Index: refpolicy/policy/modules/services/apache.te
===================================================================
--- refpolicy/policy/modules/services/apache.te	(revision 2762)
+++ refpolicy/policy/modules/services/apache.te	(working copy)
@@ -459,8 +459,7 @@
 	mysql_rw_db_sockets(httpd_t)
 
 	tunable_policy(`httpd_can_network_connect_db',`
-		corenet_tcp_connect_mysqld_port(httpd_t)
-		corenet_sendrecv_mysqld_client_packets(httpd_t)
+		mysql_tcp_connect(httpd_t)
 	')
 ')
 
Index: refpolicy/policy/modules/services/apache.if
===================================================================
--- refpolicy/policy/modules/services/apache.if	(revision 2762)
+++ refpolicy/policy/modules/services/apache.if	(working copy)
@@ -189,14 +189,22 @@
 		corenet_udp_sendrecv_all_nodes(httpd_$1_script_t)
 		corenet_tcp_sendrecv_all_ports(httpd_$1_script_t)
 		corenet_udp_sendrecv_all_ports(httpd_$1_script_t)
-		corenet_tcp_connect_postgresql_port(httpd_$1_script_t)
-		corenet_tcp_connect_mysqld_port(httpd_$1_script_t)
-		corenet_sendrecv_postgresql_client_packets(httpd_$1_script_t)
-		corenet_sendrecv_mysqld_client_packets(httpd_$1_script_t)
 
 		sysnet_read_config(httpd_$1_script_t)
 	')
 
+	optional_policy(`
+		tunable_policy(`httpd_enable_cgi && httpd_can_network_connect_db',`
+			mysql_tcp_connect(httpd_$1_script_t)
+		')
+	')
+
+	optional_policy(`
+		tunable_policy(`httpd_enable_cgi && httpd_can_network_connect_db',`
+			postgresql_tcp_connect(httpd_$1_script_t)
+		')
+	')
+
 	tunable_policy(`httpd_enable_cgi && httpd_can_network_connect',`
 		allow httpd_$1_script_t self:tcp_socket create_stream_socket_perms;
 		allow httpd_$1_script_t self:udp_socket create_socket_perms;
Index: refpolicy/policy/modules/services/postgresql.te
===================================================================
--- refpolicy/policy/modules/services/postgresql.te	(revision 2762)
+++ refpolicy/policy/modules/services/postgresql.te	(working copy)
@@ -245,10 +245,6 @@
 ')
 
 optional_policy(`
-	ipsec_match_default_spd(postgresql_t)
-')
-
-optional_policy(`
 	kerberos_use(postgresql_t)
 ')
 
Index: refpolicy/policy/modules/system/userdomain.if
===================================================================
--- refpolicy/policy/modules/system/userdomain.if	(revision 2762)
+++ refpolicy/policy/modules/system/userdomain.if	(working copy)
@@ -549,7 +549,14 @@
 	corenet_tcp_connect_all_ports($1_t)
 	corenet_sendrecv_all_client_packets($1_t)
 
+	corenet_all_recvfrom_labeled($1_t, $1_t)
+
 	optional_policy(`
+		init_tcp_recvfrom_all_daemons($1_t)
+		init_udp_recvfrom_all_daemons($1_t)
+	')
+
+	optional_policy(`
 		ipsec_match_default_spd($1_t)
 	')
 ')
Index: refpolicy/policy/modules/system/init.te
===================================================================
--- refpolicy/policy/modules/system/init.te	(revision 2762)
+++ refpolicy/policy/modules/system/init.te	(working copy)
@@ -609,6 +609,8 @@
 optional_policy(`
 	ipsec_read_config(initrc_t)
 	ipsec_manage_pid(initrc_t)
+
+	ipsec_match_default_spd(daemon)
 ')
 
 optional_policy(`
Index: refpolicy/policy/modules/system/init.if
===================================================================
--- refpolicy/policy/modules/system/init.if	(revision 2762)
+++ refpolicy/policy/modules/system/init.if	(working copy)
@@ -1283,3 +1283,37 @@
 	files_search_pids($1)
 	allow $1 initrc_var_run_t:file manage_file_perms;
 ')
+
+########################################
+## <summary>
+##	Allow the specified domain to connect to daemon with a tcp socket
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`init_tcp_recvfrom_all_daemons',`
+	gen_require(`
+		attribute daemon;
+	')
+	corenet_tcp_recvfrom_labeled($1,daemon)
+')
+
+########################################
+## <summary>
+##	Allow the specified domain to connect to daemon with a udp socket
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`init_udp_recvfrom_all_daemons',`
+	gen_require(`
+		attribute daemon;
+	')
+	corenet_udp_recvfrom_labeled($1,daemon)
+')

--------------080907070009000501050206--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
