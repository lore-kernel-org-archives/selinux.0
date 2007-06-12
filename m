Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5CD1B7T017672
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 09:01:11 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5CD18gq003219
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 13:01:09 GMT
Subject: Re: services_mailman changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301546.l4UFk5GH011930@localhost.localdomain>
References: <200705301546.l4UFk5GH011930@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 12 Jun 2007 12:59:24 +0000
Message-Id: <1181653164.16029.64.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 11:46 -0400, dwalsh@redhat.com wrote:
> Additional interfaces for mailman
> 
> --- nsaserefpolicy/policy/modules/services/mailman.if	2007-05-29 14:10:57.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/services/mailman.if	2007-05-30 09:25:53.000000000 -0400
> @@ -275,6 +275,25 @@
>  
>  #######################################
>  ## <summary>
> +##	append
> +##	mailman logs.
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +#
> +interface(`mailman_append_log',`
> +	gen_require(`
> +		type mailman_log_t;
> +	')
> +
> +	append_files_pattern($1,mailman_log_t,mailman_log_t)
> +')
> +
> +#######################################
> +## <summary>
>  ##	Allow domain to read mailman archive files.
>  ## </summary>
>  ## <param name="domain">

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
