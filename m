Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3BHpLI5003471
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 13:51:21 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l3BHpGT4025813
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 17:51:19 GMT
Subject: Re: Remove unconfined_domain from udev
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <460428EB.8080904@redhat.com>
References: <460428EB.8080904@redhat.com>
Content-Type: text/plain
Date: Wed, 11 Apr 2007 13:51:59 -0400
Message-Id: <1176313919.9840.50.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-23 at 15:22 -0400, Daniel J Walsh wrote:
> Fixed labeling on /dev/\.udev(/.*)?
> udev searches usbfs dirs
> searches ptys

Merged, with an ordering fix on the ptys rule.  The usbfs one is missing
an interface implementation. I also wouldn't be surprised if it ends up
being a read on usbfs, not just search.

> 
> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (udev.patch),
> "udev.patch"
> 
> --- nsaserefpolicy/policy/modules/system/udev.fc        2006-11-16 17:15:24.000000000 -0500
> +++ serefpolicy-2.5.10/policy/modules/system/udev.fc    2007-03-22 15:06:59.000000000 -0400
> @@ -1,6 +1,6 @@
>  # udev
>  
> -/dev/\.udev(/.*)?      gen_context(system_u:object_r:udev_tbl_t,s0)
> +/dev/\.udev(/.*)? --   gen_context(system_u:object_r:udev_tbl_t,s0)
>  /dev/\.udevdb  --      gen_context(system_u:object_r:udev_tbl_t,s0)
>  /dev/udev\.tbl --      gen_context(system_u:object_r:udev_tbl_t,s0)
>  
> --- nsaserefpolicy/policy/modules/system/udev.te        2007-03-20 23:38:29.000000000 -0400
> +++ serefpolicy-2.5.10/policy/modules/system/udev.te    2007-03-22 15:06:59.000000000 -0400
> @@ -89,6 +89,7 @@
>  dev_manage_all_dev_nodes(udev_t)
>  dev_rw_generic_files(udev_t)
>  dev_delete_generic_files(udev_t)
> +dev_search_usbfs_dirs(udev_t)
>  
>  domain_read_all_domains_state(udev_t)
>  domain_dontaudit_ptrace_all_domains(udev_t) #pidof triggers these 
> @@ -166,13 +167,14 @@
>  
>         # for arping used for static IP addresses on PCMCIA ethernet
>         netutils_domtrans(udev_t)
> +
> +       term_search_ptys(udev_t)
> +
>  ')
>  
>  ifdef(`targeted_policy',`
>         term_dontaudit_use_unallocated_ttys(udev_t)
>         term_dontaudit_use_generic_ptys(udev_t)
> -
> -       unconfined_domain(udev_t)
>  ')
>  
>  optional_policy(`
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
