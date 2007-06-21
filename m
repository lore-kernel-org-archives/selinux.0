Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5LEmpsT001268
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 10:48:51 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5LEmoPC028543
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 14:48:50 GMT
Subject: Re: Procmail needs to use ypbind, eliminate bogus udp avc messages
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301429.l4UETs7Q007861@localhost.localdomain>
References: <200705301429.l4UETs7Q007861@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 21 Jun 2007 10:47:10 -0400
Message-Id: <1182437230.24679.5.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 10:29 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/procmail.te	2007-05-29 14:10:57.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/services/procmail.te	2007-05-30 09:08:15.000000000 -0400
> @@ -101,6 +102,10 @@
>  ')
>  
>  optional_policy(`
> +	nis_use_ypbind(procmail_t)
> +')
> +
> +optional_policy(`
>  	# for a bug in the postfix local program
>  	postfix_dontaudit_rw_local_tcp_sockets(procmail_t)
>  	postfix_dontaudit_use_fds(procmail_t)
> @@ -119,8 +124,11 @@
>  
>  optional_policy(`
>  	corenet_udp_bind_generic_port(procmail_t)
> +	corenet_dontaudit_udp_bind_all_ports(procmail_t)
>  
>  	spamassassin_exec(procmail_t)
>  	spamassassin_exec_client(procmail_t)
>  	spamassassin_read_lib_files(procmail_t)
>  ')
> +
> +

Merged, minus the extra whitespace at the end.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
