Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5CD0kmZ017585
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 09:00:46 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5CD0cgu003112
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 13:00:45 GMT
Subject: Re: kernel_terminal changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301516.l4UFGeH5010406@localhost.localdomain>
References: <200705301516.l4UFGeH5010406@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 12 Jun 2007 08:59:18 -0400
Message-Id: <1181653158.16029.62.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 11:16 -0400, dwalsh@redhat.com wrote:
> Console is a legitimate login device on s390,
> 
> --- nsaserefpolicy/policy/modules/kernel/terminal.if	2007-05-29 14:10:48.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/kernel/terminal.if	2007-05-30 09:25:53.000000000 -0400
> @@ -278,6 +278,25 @@
>  
>  ########################################
>  ## <summary>
> +##	Relabel from and to the console_device_t
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +#
> +interface(`term_relabel_console',`
> +	gen_require(`
> +		type console_device_t;
> +	')
> +
> +	dev_list_all_dev_nodes($1)
> +	allow $1 console_device_t:chr_file { relabelfrom relabelto };
> +')
> +
> +########################################
> +## <summary>
>  ##	Create the console device (/dev/console).
>  ## </summary>
>  ## <param name="domain">
> @@ -1052,7 +1071,7 @@
>  	')
>  
>  	dev_list_all_dev_nodes($1)
> -	allow $1 ttynode:chr_file { getattr write };
> +	allow $1 ttynode:chr_file { getattr write append };
>  ')
>  
>  ########################################

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
