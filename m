Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6IDfpo5020160
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 09:41:51 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m6IDfpAI009822
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 13:41:51 GMT
Subject: Re: [PATCH] Communication between domains under labeled networks
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        DGoeddel@TrustedCS.com, vyekkirala@TrustedCS.com
In-Reply-To: <4861DED0.9050407@ak.jp.nec.com>
References: <D709A20F2164C84E8B7014B0301F5EF87C72FA@HAVOC.tcs-sec.com>
	 <1203428116.13618.77.camel@gorn> <47BB7B6A.1090207@ak.jp.nec.com>
	 <200802192237.22546.paul.moore@hp.com>  <47BBB69C.2050007@ak.jp.nec.com>
	 <1203955972.32061.55.camel@gorn> <47C3738A.3010007@ak.jp.nec.com>
	 <4860BA1B.5030302@ak.jp.nec.com>  <4861DED0.9050407@ak.jp.nec.com>
Content-Type: text/plain
Date: Fri, 18 Jul 2008 09:41:24 -0400
Message-Id: <1216388484.21191.139.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-06-25 at 14:59 +0900, KaiGai Kohei wrote:
> Hi,
> 
> The attached patch allows user domains to communicate with daemon
> domain, and some other domains (Apache and CGI script) to communicate
> with RDBMS (PostgreSQL and MySQL) using xxxx_tcp_connect() interface.
> 
> This approach enables to cover most of relationship needed.
> All we have to do is to describe the rest of relationship like
> ones between CGI script and RDBMS, daemons and name server,
> anything and samba server, ....
> 
> At least, we cannot get labeled networks available unless adding
> policies to communicate between proper domains.
> I think it is necessary to make a decision to describe the policies.

> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (refpolicy-labeled_communication.2.patch)


> Index: refpolicy/policy/modules/services/apache.if
> ===================================================================
> --- refpolicy/policy/modules/services/apache.if (revision 2733)
> +++ refpolicy/policy/modules/services/apache.if (working copy)
> @@ -189,10 +189,8 @@
>                 corenet_udp_sendrecv_all_nodes(httpd_$1_script_t)
>                 corenet_tcp_sendrecv_all_ports(httpd_$1_script_t)
>                 corenet_udp_sendrecv_all_ports(httpd_$1_script_t)
> -               corenet_tcp_connect_postgresql_port(httpd_$1_script_t)
> -               corenet_tcp_connect_mysqld_port(httpd_$1_script_t)
> -               corenet_sendrecv_postgresql_client_packets(httpd_
> $1_script_t)
> -               corenet_sendrecv_mysqld_client_packets(httpd_
> $1_script_t)
> +               postgresql_tcp_connect(httpd_$1_script_t)
> +               mysql_tcp_connect(httpd_$1_script_t)
>  
>                 sysnet_read_config(httpd_$1_script_t)
>         ')

In this case, we want to break out the two databases into individual
optionals, e.g.

optional_policy(`
   tunable_policy(`.... && ....',`
      mysql_tcp_connect()
   ')
')

In fact we may want to just duplicate the whole tunable since the other
perms don't make much sense if you cant connect to mysql or postgresql.

> Index: refpolicy/policy/modules/system/init.if
> ===================================================================
> --- refpolicy/policy/modules/system/init.if     (revision 2733)
> +++ refpolicy/policy/modules/system/init.if     (working copy)
> @@ -1273,3 +1273,37 @@
>         files_search_pids($1)
>         allow $1 initrc_var_run_t:file manage_file_perms;
>  ')
[...]
> +interface(`daemon_labeled_tcp_recvfrom',`
> +       gen_require(`
> +               attribute daemon;
> +       ')
> +       corenet_tcp_recvfrom_labeled($1,daemon)
> +')
> +
[...]
> +interface(`daemon_labeled_udp_recvfrom',`
> +       gen_require(`
> +               attribute daemon;
> +       ')
> +       corenet_udp_recvfrom_labeled($1,daemon)
> +')
> 

Both interfaces need naming fixes.  init_tcp_recvfrom_all_daemons() and
init_udp_recvfrom_all_daemons().

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
