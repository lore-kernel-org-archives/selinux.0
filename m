Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5KJfQ1n014506
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2007 15:41:26 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l5KJfNe3005096
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2007 19:41:24 GMT
Subject: Re: kernel_selinux changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301539.l4UFd9QD011809@localhost.localdomain>
References: <200705301539.l4UFd9QD011809@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 20 Jun 2007 15:39:36 -0400
Message-Id: <1182368376.16539.37.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 11:39 -0400, dwalsh@redhat.com wrote:
> Additional interfaces for access to /selinux
> --- nsaserefpolicy/policy/modules/kernel/selinux.if	2007-05-29 14:10:48.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/kernel/selinux.if	2007-05-30 09:25:53.000000000 -0400
> @@ -51,6 +51,44 @@
>  
>  ########################################
>  ## <summary>
> +##	Do not audit attempts to get the
> +##	attributes of the selinuxfs filesystem
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain to not audit.
> +##	</summary>
> +## </param>
> +#
> +interface(`selinux_dontaudit_getattr_fs',`
> +	gen_require(`
> +		type security_t;
> +	')
> +
> +	dontaudit $1 security_t:filesystem getattr;
> +')
> +
> +########################################
> +## <summary>
> +##	Allow domain to get the
> +##	attributes of the selinuxfs filesystem
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain to not audit.
> +##	</summary>
> +## </param>
> +#
> +interface(`selinux_getattr_fs',`
> +	gen_require(`
> +		type security_t;
> +	')
> +
> +	allow $1 security_t:filesystem getattr;
> +')
> +
> +########################################
> +## <summary>
>  ##	Search selinuxfs.
>  ## </summary>
>  ## <param name="domain">

Merged with the two interfaces swapped.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
