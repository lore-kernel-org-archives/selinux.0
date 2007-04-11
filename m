Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3BHp9CW003421
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 13:51:09 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3BHp6GQ010590
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 17:51:06 GMT
Subject: Re: Removed unconfined_domain for insmod_t
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46042C36.9020808@redhat.com>
References: <46042C36.9020808@redhat.com>
Content-Type: text/plain
Date: Wed, 11 Apr 2007 13:51:54 -0400
Message-Id: <1176313914.9840.46.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-23 at 15:36 -0400, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/modules/system/modutils.te    2007-02-19 11:32:53.000000000 -0500
> +++ serefpolicy-2.5.10/policy/modules/system/modutils.te        2007-03-22 15:08:58.000000000 -0400
> @@ -68,7 +68,7 @@
>  # for locking: (cjp: ????)
>  files_write_kernel_modules(insmod_t)
>  
> -dev_read_sysfs(insmod_t)
> +dev_rw_sysfs(insmod_t)
>  dev_search_usbfs(insmod_t)
>  dev_rw_mtrr(insmod_t)
>  dev_read_urand(insmod_t)

Merged.

> @@ -102,6 +102,7 @@
>  init_use_fds(insmod_t)
>  init_use_script_fds(insmod_t)
>  init_use_script_ptys(insmod_t)
> +init_spec_domtrans_script(insmod_t)
>  
>  libs_use_ld_so(insmod_t)
>  libs_use_shared_libs(insmod_t)

I'll need some justification for this.

> @@ -118,7 +119,8 @@
>  }
>  
>  ifdef(`targeted_policy',`
> -       unconfined_domain(insmod_t)
> +       term_use_unallocated_ttys(insmod_t)
> +       term_use_generic_ptys(insmod_t)
>  ')
>  
>  optional_policy(`

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
