Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l87DYh5k016448
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 09:34:43 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l87DYaZn003163
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 13:34:41 GMT
Subject: Re: [PATCH] refpolicy: services_automount changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708022100.l72L08Ii000786@redsox.boston.devel.redhat.com>
References: <200708022100.l72L08Ii000786@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Fri, 07 Sep 2007 09:33:17 -0400
Message-Id: <1189171997.3664.58.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 17:00 -0400, dwalsh@redhat.com wrote:
> automount reads /dev/rand
> corecmd_exec_bin defined twice

Merged.

> --- nsaserefpolicy/policy/modules/services/automount.te 2007-07-25
> 10:37:42.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/services/automount.te
> 2007-08-02 11:02:02.000000000 -0400
> @@ -69,6 +69,7 @@
>  files_mounton_all_mountpoints(automount_t)
>  files_mount_all_file_type_fs(automount_t)
>  files_unmount_all_file_type_fs(automount_t)
> +files_manage_non_security_dirs(automount_t)
> 
>  fs_mount_all_fs(automount_t)
>  fs_unmount_all_fs(automount_t)
> @@ -99,6 +100,7 @@
> 
>  dev_read_sysfs(automount_t)
>  # for SSP
> +dev_read_rand(automount_t)
>  dev_read_urand(automount_t)
> 
>  domain_use_interactive_fds(automount_t)
> @@ -147,10 +149,6 @@
>  userdom_dontaudit_search_sysadm_home_dirs(automount_t)
> 
>  optional_policy(`
> -       corecmd_exec_bin(automount_t)
> -')
> -
> -optional_policy(`
>         bind_search_cache(automount_t)
>  ')
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
