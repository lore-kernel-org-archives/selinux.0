Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7RHojpS023107
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2007 13:50:45 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7RHojQQ019018
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2007 17:50:45 GMT
Subject: Re: [PATCH] refpolicy: apps_slocate changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708021957.l72Jv463029456@redsox.boston.devel.redhat.com>
References: <200708021957.l72Jv463029456@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Mon, 27 Aug 2007 13:49:41 -0400
Message-Id: <1188236981.6723.30.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 15:57 -0400, dwalsh@redhat.com wrote:
> locate uses nsswitch (getpwnam)

Merged a few lines lower.

> --- nsaserefpolicy/policy/modules/apps/slocate.te       2007-07-25 10:37:37.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/apps/slocate.te    2007-08-02 11:02:02.000000000 -0400
> @@ -29,6 +29,8 @@
>  manage_dirs_pattern(locate_t,locate_var_lib_t,locate_var_lib_t)
>  manage_files_pattern(locate_t,locate_var_lib_t,locate_var_lib_t)
> 
> +auth_use_nsswitch(locate_t)
> +
>  kernel_read_system_state(locate_t)
>  kernel_dontaudit_search_sysctl(locate_t)
> 
> 
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
