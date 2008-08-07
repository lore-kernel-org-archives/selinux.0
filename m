Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m77ENV6r015779
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 10:23:31 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m77ENNjg022362
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 14:23:23 GMT
Subject: Re: [patch 01/35] anaconda policy update
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080804123734.692354545@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
	 <20080804123734.692354545@hardeman.nu>
Content-Type: text/plain
Date: Thu, 07 Aug 2008 10:22:53 -0400
Message-Id: <1218118973.5345.29.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 14:34 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_admin_anaconda.patch)
> Anaconda is a RH installation program, RH should know their own program and
> the changes are quite trivial
> 
> Previously submitted Jul 19, refreshed to apply to current SVN

Merged except for the setsebool part which doesn't exist upstream at the
moment.

> Index: refpolicy/policy/modules/admin/anaconda.te
> ===================================================================
> --- refpolicy.orig/policy/modules/admin/anaconda.te	2008-08-03 16:47:00.000000000 +0200
> +++ refpolicy/policy/modules/admin/anaconda.te	2008-08-03 16:52:56.000000000 +0200
> @@ -31,14 +31,9 @@
>  modutils_domtrans_insmod(anaconda_t)
>  
>  seutil_domtrans_semanage(anaconda_t)
> +seutil_domtrans_setsebool(anaconda_t)
>  
> -unconfined_domain(anaconda_t)
> -
> -unprivuser_home_dir_filetrans_home_content(anaconda_t, { dir file lnk_file fifo_file sock_file })
> -
> -optional_policy(`
> -	dmesg_domtrans(anaconda_t)
> -')
> +unprivuser_home_dir_filetrans_home_content(anaconda_t,{ dir file lnk_file fifo_file sock_file })
>  
>  optional_policy(`
>  	kudzu_domtrans(anaconda_t)
> @@ -58,5 +53,9 @@
>  ')
>  
>  optional_policy(`
> +	unconfined_domain(anaconda_t)
> +')
> +
> +optional_policy(`
>  	usermanage_domtrans_admin_passwd(anaconda_t)
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
