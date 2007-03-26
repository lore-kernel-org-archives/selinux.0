Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2QJhkPx023305
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 15:43:46 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2QJhfRM022668
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 19:43:42 GMT
Subject: Re: Resend of cpuspeed.patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45F02F63.9050704@redhat.com>
References: <45F02F63.9050704@redhat.com>
Content-Type: text/plain
Date: Mon, 26 Mar 2007 15:44:18 -0400
Message-Id: <1174938258.28830.77.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 10:44 -0500, Daniel J Walsh wrote:
> Included interface definition also.

Merged.  Moved the interface down in the file.
> 
> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (cpuspeed.patch)
> 
> --- nsaserefpolicy/policy/modules/kernel/devices.if     2007-01-02
> 12:57:13.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/kernel/devices.if  2007-03-08
> 08:42:36.000000000 -0500
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
> ---
> nsaserefpolicy/policy/modules/services/cpucontrol.te        2007-01-02
> 12:57:43.000000000 -0500
> +++
> serefpolicy-2.5.8/policy/modules/services/cpucontrol.te     2007-03-08
> 08:42:37.000000000 -0500
> @@ -91,6 +91,7 @@
>  kernel_read_system_state(cpuspeed_t)
>  kernel_read_kernel_sysctls(cpuspeed_t)
>  
> +dev_write_sysfs_dirs(cpuspeed_t)
>  dev_rw_sysfs(cpuspeed_t)
>  
>  domain_use_interactive_fds(cpuspeed_t) 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
