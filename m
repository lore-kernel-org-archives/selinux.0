Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0N31msr027813
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2008 22:01:48 -0500
Received: from tyo202.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0N31fBR010280
	for <selinux@tycho.nsa.gov>; Wed, 23 Jan 2008 03:01:46 GMT
Message-ID: <4796ADE9.8000608@ak.jp.nec.com>
Date: Wed, 23 Jan 2008 12:00:57 +0900
From: Kohei KaiGai <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov, paul.moore@hp.com, DGoeddel@TrustedCS.com,
        vyekkirala@TrustedCS.com
Subject: Re: [PATCH] IPsec SPD default security context
References: <D709A20F2164C84E8B7014B0301F5EF87C72FA@HAVOC.tcs-sec.com>	 <47331BAB.8040107@kaigai.gr.jp>  <473872F8.7000208@ak.jp.nec.com>	 <1195055160.13737.33.camel@gorn.columbia.tresys.com>	 <473B23F9.4080506@ak.jp.nec.com>	 <1195064402.13737.42.camel@gorn.columbia.tresys.com>	 <473BB437.3070005@ak.jp.nec.com>	 <1195136813.13737.67.camel@gorn.columbia.tresys.com>	 <4740F30D.9000304@ak.jp.nec.com> <1195498093.16660.44.camel@gorn>	 <4742A571.1060601@ak.jp.nec.com> <1195583693.16660.49.camel@gorn>	 <4743B38D.3070803@ak.jp.nec.com> <1196095135.20918.32.camel@gorn> <474EA68E.9010108@ak.jp.nec.com>
In-Reply-To: <474EA68E.9010108@ak.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------050702070409040004000802"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050702070409040004000802
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Sorry for a long silence.

I want to resume the discussion again.

>> Merged [1], but I made some changes.  I created corenetwork interfaces
>> to use instead of the patterns, so the current MLS-only netlabel case
>> can be handled too.  I also updated the domain module to use the
>> interfaces.
>>
>> The thing that makes me a little nervous, which I didn't realize at
>> first, is if you use non-labeled networking, the peer policy will still
>> be needed, since the corenet connect/sendrecv calls are abstracted into
>> the interface.  Consider the non-labeled case for apache.  The
>> httpd_can_network_connect_db tunable won't work for postgresql, if the
>> postgresql module isn't in the apache server's policy.  Whats worse is,
>> to make it work, you need to bring in the entire postgresql policy, even
>> though you only need one type, and only need the recvfrom rules.
>>
>> [1] http://oss.tresys.com/projects/refpolicy/changeset/2531
> 
> I've considered to resolve the matter for a while, but I could not get
> any good idea. I think the most appropriate way is to separate corenet
> part from labeled networking part again, and to put corenet sendrecv
> pattern and an interface optionally to communicate via labeled networking.
> 
> I also considered a method to utilize the second argument of the
> "optional_policy" macro, but it seemed to me a bit ugly more.
> 
> How do you think the idea to revert apache.te and create a new interface
> to communicate via labeled networking only?

The attached patch revert the previous changes in postgresql.if, apache.te.
postgresql_tcp_connect() got deprecated again, and we separate the permissions
for unlabeled network and one for labeled networking.

The permissions for unlabeled network are allowed with previous way.
Ones for labeled network are allowed using corenet_tcp_recvfrom_labeled()
macro within optional_policy, because it requires the definition of peer's
domain.
In addition, ipsec_match_default_spd() is put on all domains which have
possibility to attend labeled network communication.

We can apply same process from any othe domain's policy, as follows:
1. add ipsec_match_default_spd() within definitions of domain which can
   attend lebeled network.
2. add corenet_(all|tcp|udp|raw)_recvfrom_labeled() within definitions
   of client domain.

What is your opinion?
Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------050702070409040004000802
Content-Type: text/x-patch;
 name="refpolicy-use-corenet-for-ipsec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="refpolicy-use-corenet-for-ipsec.patch"

Index: refpolicy/policy/modules/services/postgresql.if
===================================================================
--- refpolicy/policy/modules/services/postgresql.if	(revision 2582)
+++ refpolicy/policy/modules/services/postgresql.if	(working copy)
@@ -79,7 +79,7 @@
 
 ########################################
 ## <summary>
-##	Allow the specified domain to connect to postgresql with a tcp socket.
+##	Allow the specified domain to connect to postgresql with a tcp socket. (Deprecated)
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
Index: refpolicy/policy/modules/services/apache.te
===================================================================
--- refpolicy/policy/modules/services/apache.te	(revision 2582)
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
@@ -437,6 +445,10 @@
 ')
 
 optional_policy(`
+	ipsec_match_default_spd(httpd_t)
+')
+
+optional_policy(`
 	kerberos_use(httpd_t)
 	kerberos_read_kdc_config(httpd_t)
 ')
@@ -455,8 +467,7 @@
 	mysql_rw_db_sockets(httpd_t)
 
 	tunable_policy(`httpd_can_network_connect_db',`
-		corenet_tcp_connect_mysqld_port(httpd_t)
-		corenet_sendrecv_mysqld_client_packets(httpd_t)
+		corenet_tcp_recvfrom_labeled(httpd_t,mysqld_t)
 	')
 ')
 
@@ -477,7 +488,7 @@
 	postgresql_stream_connect(httpd_t)
 
 	tunable_policy(`httpd_can_network_connect_db',`
-		postgresql_tcp_connect(httpd_t)
+		corenet_tcp_recvfrom_labeled(httpd_t,postgresql_t)
 	')
 ')
 
Index: refpolicy/policy/modules/services/apache.if
===================================================================
--- refpolicy/policy/modules/services/apache.if	(revision 2582)
+++ refpolicy/policy/modules/services/apache.if	(working copy)
@@ -196,6 +196,11 @@
 
 		sysnet_read_config(httpd_$1_script_t)
 	')
+	optional_policy(`
+		tunable_policy(`httpd_enable_cgi && httpd_can_network_connect_db',`
+			corenet_tcp_recvfrom_labeled(httpd_$1_script_t,postgresql_t)
+		')
+	')
 
 	tunable_policy(`httpd_enable_cgi && httpd_can_network_connect',`
 		allow httpd_$1_script_t self:tcp_socket create_stream_socket_perms;
@@ -214,6 +219,9 @@
 
 		sysnet_read_config(httpd_$1_script_t)
 	')
+	optional_policy(`
+		ipsec_match_default_spd(httpd_$1_script_t)
+	')
 
 	optional_policy(`
 		mta_send_mail(httpd_$1_script_t)
Index: refpolicy/policy/modules/system/userdomain.if
===================================================================
--- refpolicy/policy/modules/system/userdomain.if	(revision 2582)
+++ refpolicy/policy/modules/system/userdomain.if	(working copy)
@@ -844,7 +844,7 @@
 	optional_policy(`
 		tunable_policy(`allow_user_postgresql_connect',`
 			postgresql_stream_connect($1_t)
-			postgresql_tcp_connect($1_t)
+			corenet_tcp_recvfrom_labeled($1_t,postgresql_t)
 		')
 	')
 

--------------050702070409040004000802--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
