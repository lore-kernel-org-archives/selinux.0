Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l86ISdpP012969
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2007 14:28:39 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l86ISaaO008993
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2007 18:28:38 GMT
Subject: Re: [PATCH] refpolicy: system_raid changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708022018.l72KIU8q030133@redsox.boston.devel.redhat.com>
References: <200708022018.l72KIU8q030133@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Thu, 06 Sep 2007 14:27:14 -0400
Message-Id: <1189103234.3664.29.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 16:18 -0400, dwalsh@redhat.com wrote:
> mdadm makes nodes
> Tries to look in users homedirs
> 
> --- nsaserefpolicy/policy/modules/system/raid.te        2007-06-15 14:54:34.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/system/raid.te     2007-08-02 11:02:02.000000000 -0400
> @@ -19,7 +19,7 @@
>  # Local policy
>  #
> 
> -allow mdadm_t self:capability { dac_override sys_admin ipc_lock };
> +allow mdadm_t self:capability { dac_override mknod sys_admin ipc_lock };
>  dontaudit mdadm_t self:capability sys_tty_config;
>  allow mdadm_t self:process { sigchld sigkill sigstop signull signal };
>  allow mdadm_t self:fifo_file rw_fifo_file_perms;

This is redundant, the storage_manage_fixed_disk(mdadm_t) already adds
this.

> @@ -70,6 +70,7 @@
> 
>  userdom_dontaudit_use_unpriv_user_fds(mdadm_t)
>  userdom_dontaudit_use_sysadm_ttys(mdadm_t)
> +userdom_dontaudit_search_all_users_home_content(mdadm_t)
> 
>  mta_send_mail(mdadm_t)

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
