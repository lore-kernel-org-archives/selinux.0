Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2SIJEgA024967
	for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2007 14:19:14 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2SIJCLB001562
	for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2007 18:19:13 GMT
Subject: Re: cpuspeed wants to write to sysfs_dirs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46042830.2090807@redhat.com>
References: <46042830.2090807@redhat.com>
Content-Type: text/plain
Date: Wed, 28 Mar 2007 18:19:50 +0000
Message-Id: <1175105990.29300.109.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dupe.  Already merged.

On Fri, 2007-03-23 at 15:19 -0400, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/modules/kernel/devices.if     2007-01-02 12:57:13.000000000 -0500
> +++ serefpolicy-2.5.10/policy/modules/kernel/devices.if 2007-03-22 15:06:58.000000000 -0400
> @@ -2449,6 +2449,24 @@
>  
>  ########################################
>  ## <summary>
> +##     Write in a sysfs directories.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     The type of the process performing this action.
> +##     </summary>
> +## </param>
> +#
> +interface(`dev_write_sysfs_dirs',`
> +       gen_require(`
> +               type sysfs_t;
> +       ')
> +
> +       allow $1 sysfs_t:dir write;
> +')
> +
> +########################################
> +## <summary>
>  ##     Search the sysfs directories.
>  ## </summary>
>  ## <param name="domain">
> --- nsaserefpolicy/policy/modules/services/cpucontrol.te        2007-01-02 12:57:43.000000000 -0500
> +++ serefpolicy-2.5.10/policy/modules/services/cpucontrol.te    2007-03-22 15:06:59.000000000 -0400
> @@ -91,6 +91,7 @@
>  kernel_read_system_state(cpuspeed_t)
>  kernel_read_kernel_sysctls(cpuspeed_t)
>  
> +dev_write_sysfs_dirs(cpuspeed_t)
>  dev_rw_sysfs(cpuspeed_t)
>  
>  domain_use_interactive_fds(cpuspeed_t)
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
