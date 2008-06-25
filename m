Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5P60ZLN026651
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 02:00:35 -0400
Received: from tyo201.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5P60XNg003668
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 06:00:34 GMT
Message-ID: <4861DED0.9050407@ak.jp.nec.com>
Date: Wed, 25 Jun 2008 14:59:44 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        DGoeddel@TrustedCS.com, vyekkirala@TrustedCS.com
Subject: [PATCH] Communication between domains under labeled networks
References: <D709A20F2164C84E8B7014B0301F5EF87C72FA@HAVOC.tcs-sec.com>	 <1203428116.13618.77.camel@gorn> <47BB7B6A.1090207@ak.jp.nec.com>	 <200802192237.22546.paul.moore@hp.com>  <47BBB69C.2050007@ak.jp.nec.com> <1203955972.32061.55.camel@gorn> <47C3738A.3010007@ak.jp.nec.com> <4860BA1B.5030302@ak.jp.nec.com>
In-Reply-To: <4860BA1B.5030302@ak.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------070007090305040007000400"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070007090305040007000400
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hi,

The attached patch allows user domains to communicate with daemon
domain, and some other domains (Apache and CGI script) to communicate
with RDBMS (PostgreSQL and MySQL) using xxxx_tcp_connect() interface.

This approach enables to cover most of relationship needed.
All we have to do is to describe the rest of relationship like
ones between CGI script and RDBMS, daemons and name server,
anything and samba server, ....

At least, we cannot get labeled networks available unless adding
policies to communicate between proper domains.
I think it is necessary to make a decision to describe the policies.

Thanks,

KaiGai Kohei wrote:
> Kohei KaiGai wrote:
>> Christopher J. PeBenito wrote:
>>> On Wed, 2008-02-20 at 14:11 +0900, Kohei KaiGai wrote:
>>>> Paul Moore wrote:
>>>>> On Tuesday 19 February 2008 7:59:22 pm Kohei KaiGai wrote:
>>>>>> Is it acceptable one, if we provide an interface to allow a domain
>>>>>> to communicate postgresql_t via labeled networking, separated from
>>>>>> existing permissions for local ports and nodes?
>>>>>>
>>>>>> For example:
>>>>>> -- at postgresql.if
>>>>>> interface(`postgresql_labeled_connect',`
>>>>>> 	gen_require(`
>>>>>> 		type postgresql_t;
>>>>>> 	')
>>>>>> 	corenet_tcp_recvfrom_labeled($1,postgresql_t)
>>>>>> ')
>>>>>>
>>>>>> and
>>>>>> -- at apache.te
>>>>>> postgresql_labeled_connect(httpd_t)
>>>>>>
>>>>>> I think this approach enables to keep independency between modules
>>>>>> in unlabeled networking cases too.
>>>>> For what it is worth, it looks like a good idea to me.
>>>> At first, I implemented this idea for three services (PostgreSQL/MySQL/SSHd).
>>>>
>>>> This patch adds the following interfaces:
>>>> - postgresql_labeled_communicate(domain)
>>>> - mysql_labeled_communicate(domain)
>>>> - ssh_labeled_communicate(domain)
>>>>
>>>> Chris, is it suitable for refpolicy framework?
>>> The only issue I have with it would just be the interface naming;
>>> probably something like mysql_tcp_recvfrom() would be better.
>> I think the name of "xxxx_tcp_recvfrom()" is not obvious whether it means
>> permissions related to labeled networking, or not.
>>
>> What do you think the following ideas?
>>  - something_labeled_recvfrom(domain)
>>       or
>>  - something_labeled_tcp_recvfrom(domain)
>>
>> Thanks,
> 
> Oops, I found out this topic has not been progressed for a long time.
> 
> An interface of corenet_*_recvfrom_labeled(dom1, dom2) is
> provided in the latest policy, but nobody uses it except
> for a few cases like:
>  - communication between unconfined domain and any other domain.
>  - communication between httpd_t and postgresql_t.
> 
> In the previous discussion, you were hesitant to add permissions
> which allows to communicate between widespread domains, so we
> made a decision to put per-domain interfaces as above.
> 
> At first, could you fix its naming scheme?
> I think somethind_labeled_tcp_recvfrom(domain) is more obvious
> to show its meanings.
> 
> And, I'm worried about massive enumeration of these interfaces
> at userdom_basic_networking_template.
> Currently, it allows widespread permissions toward any nodes,
> port and interfaces.
> I don't think "daemon_labeled_tcp_recvfrom($1_t)" here makes
> security degrading. Is it reasonable to allow to communicate
> between userdomains and daemon attribute?
> 
> Thanks,


-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------070007090305040007000400
Content-Type: text/x-patch;
 name="refpolicy-labeled_communication.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="refpolicy-labeled_communication.2.patch"

Index: refpolicy/policy/modules/services/mysql.if
===================================================================
--- refpolicy/policy/modules/services/mysql.if	(revision 2733)
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
--- refpolicy/policy/modules/services/apache.te	(revision 2733)
+++ refpolicy/policy/modules/services/apache.te	(working copy)
@@ -455,8 +455,7 @@
 	mysql_rw_db_sockets(httpd_t)
 
 	tunable_policy(`httpd_can_network_connect_db',`
-		corenet_tcp_connect_mysqld_port(httpd_t)
-		corenet_sendrecv_mysqld_client_packets(httpd_t)
+		mysql_tcp_connect(httpd_t)
 	')
 ')
 
Index: refpolicy/policy/modules/services/apache.if
===================================================================
--- refpolicy/policy/modules/services/apache.if	(revision 2733)
+++ refpolicy/policy/modules/services/apache.if	(working copy)
@@ -189,10 +189,8 @@
 		corenet_udp_sendrecv_all_nodes(httpd_$1_script_t)
 		corenet_tcp_sendrecv_all_ports(httpd_$1_script_t)
 		corenet_udp_sendrecv_all_ports(httpd_$1_script_t)
-		corenet_tcp_connect_postgresql_port(httpd_$1_script_t)
-		corenet_tcp_connect_mysqld_port(httpd_$1_script_t)
-		corenet_sendrecv_postgresql_client_packets(httpd_$1_script_t)
-		corenet_sendrecv_mysqld_client_packets(httpd_$1_script_t)
+		postgresql_tcp_connect(httpd_$1_script_t)
+		mysql_tcp_connect(httpd_$1_script_t)
 
 		sysnet_read_config(httpd_$1_script_t)
 	')
Index: refpolicy/policy/modules/system/userdomain.if
===================================================================
--- refpolicy/policy/modules/system/userdomain.if	(revision 2733)
+++ refpolicy/policy/modules/system/userdomain.if	(working copy)
@@ -549,7 +549,14 @@
 	corenet_tcp_connect_all_ports($1_t)
 	corenet_sendrecv_all_client_packets($1_t)
 
+	corenet_all_recvfrom_labeled($1_t, $1_t)
+
 	optional_policy(`
+		daemon_labeled_tcp_recvfrom($1_t)
+		daemon_labeled_udp_recvfrom($1_t)
+	')
+
+	optional_policy(`
 		ipsec_match_default_spd($1_t)
 	')
 ')
Index: refpolicy/policy/modules/system/init.if
===================================================================
--- refpolicy/policy/modules/system/init.if	(revision 2733)
+++ refpolicy/policy/modules/system/init.if	(working copy)
@@ -1273,3 +1273,37 @@
 	files_search_pids($1)
 	allow $1 initrc_var_run_t:file manage_file_perms;
 ')
+
+########################################
+## <summary>
+##      Allow the specified domain to connect to daemon with a tcp socket
+## </summary>
+## <param name="domain">
+##      <summary>
+##      Domain allowed access.
+##      </summary>
+## </param>
+#
+interface(`daemon_labeled_tcp_recvfrom',`
+	gen_require(`
+		attribute daemon;
+	')
+	corenet_tcp_recvfrom_labeled($1,daemon)
+')
+
+########################################
+## <summary>
+##      Allow the specified domain to connect to daemon with a udp socket
+## </summary>
+## <param name="domain">
+##      <summary>
+##      Domain allowed access.
+##      </summary>
+## </param>
+#
+interface(`daemon_labeled_udp_recvfrom',`
+	gen_require(`
+		attribute daemon;
+	')
+	corenet_udp_recvfrom_labeled($1,daemon)
+')

--------------070007090305040007000400--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
