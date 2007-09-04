Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l84IpZM8027183
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2007 14:51:35 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l84IpKFM021660
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2007 18:51:30 GMT
Subject: Re: [PATCH] refpolicy: apps_loadkeys changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708021957.l72JviPf029474@redsox.boston.devel.redhat.com>
References: <200708021957.l72JviPf029474@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Tue, 04 Sep 2007 14:49:43 -0400
Message-Id: <1188931783.30065.10.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 15:57 -0400, dwalsh@redhat.com wrote:
> loadkeys uses unallocated tty during bootup

Merged.

> --- nsaserefpolicy/policy/modules/apps/loadkeys.te      2007-05-29
> 14:10:48.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/apps/loadkeys.te   2007-08-02
> 11:02:02.000000000 -0400
> @@ -30,7 +30,7 @@
>  files_read_etc_runtime_files(loadkeys_t)
> 
>  term_dontaudit_use_console(loadkeys_t)
> -term_dontaudit_use_unallocated_ttys(loadkeys_t)
> +term_use_unallocated_ttys(loadkeys_t)
> 
>  init_dontaudit_use_script_ptys(loadkeys_t)
> 
> @@ -40,3 +40,8 @@
>  locallogin_use_fds(loadkeys_t)
> 
>  miscfiles_read_localization(loadkeys_t)
> +
> +optional_policy(`
> +       nscd_dontaudit_search_pid(loadkeys_t)
> +')
> +
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
