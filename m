Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7EDRsLP022348
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 09:27:54 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m7EDRrqV000031
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 13:27:54 GMT
Subject: Re: [patch 03/35] logrotate policy update
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080804123734.999572013@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
	 <20080804123734.999572013@hardeman.nu>
Content-Type: text/plain
Date: Thu, 14 Aug 2008 09:26:43 -0400
Message-Id: <1218720403.8095.65.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 14:34 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_admin_logrotate.patch)
> Perhaps controversial changes
> 
> First sent on Jul 19, dwalsh described the need for the patch here:
> http://marc.info/?l=selinux&m=121726318902852&w=2
> 
> Refreshed to apply cleanly to SVN repo
> 
> Index: refpolicy/policy/modules/admin/logrotate.te
> ===================================================================
> --- refpolicy.orig/policy/modules/admin/logrotate.te	2008-08-03 16:47:00.000000000 +0200
> +++ refpolicy/policy/modules/admin/logrotate.te	2008-08-03 16:59:10.000000000 +0200
> @@ -97,6 +97,7 @@
>  files_read_etc_files(logrotate_t)
>  files_read_etc_runtime_files(logrotate_t)
>  files_read_all_pids(logrotate_t)
> +files_search_all(logrotate_t)
>  # Write to /var/spool/slrnpull - should be moved into its own type.
>  files_manage_generic_spool(logrotate_t)
>  files_manage_generic_spool_dirs(logrotate_t)

Still don't like this.

> @@ -142,9 +143,8 @@
>  ')
>  
>  optional_policy(`
> -	apache_read_config(logrotate_t)
> -	apache_domtrans(logrotate_t)
>  	apache_signull(logrotate_t)
> +	apache_manage_all_content(logrotate_t)
>  ')
>  
>  optional_policy(`

Definitely need justification for this; these aren't even logs.

> @@ -186,6 +186,5 @@
>  ')
>  
>  optional_policy(`
> -	# cjp: why?
> -	squid_domtrans(logrotate_t)
> +	squid_signal(logrotate_t)
>  ')
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
