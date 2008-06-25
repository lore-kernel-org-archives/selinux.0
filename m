Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5PD4jww008219
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 09:04:45 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m5PD4hJ5004204
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 13:04:45 GMT
Subject: Re: [PATCH] CGI scripts/PostgreSQL stream connect
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <485F6BAE.305@ak.jp.nec.com>
References: <485F6BAE.305@ak.jp.nec.com>
Content-Type: text/plain
Date: Wed, 25 Jun 2008 09:03:38 -0400
Message-Id: <1214399018.19712.1.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-06-23 at 18:23 +0900, KaiGai Kohei wrote:
> The attached patch allows CGI scripts to connect PostgreSQL
> via unix domain socket, as MySQL doing.

Merged.

> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (refpolicy-cgi-pgsql-stream.patch)
> 
> Index: refpolicy/policy/modules/services/apache.te
> ===================================================================
> --- refpolicy/policy/modules/services/apache.te (revision 2727)
> +++ refpolicy/policy/modules/services/apache.te (working copy)
> @@ -559,6 +559,10 @@
>  ')
>  
>  optional_policy(`
> +       postgresql_stream_connect(httpd_php_t)
> +')
> +
> +optional_policy(`
>         nis_use_ypbind(httpd_php_t)
>  ')
>  
> @@ -703,6 +707,10 @@
>         mysql_rw_db_sockets(httpd_sys_script_t)
>  ')
>  
> +optional_policy(`
> +       postgresql_stream_connect(httpd_sys_script_t)
> +')
> +
>  ########################################
>  #
>  # httpd_rotatelogs local policy
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
