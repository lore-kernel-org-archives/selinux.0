Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7EEQYXc003941
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 10:26:34 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m7EEQJaK008197
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 14:26:19 GMT
Subject: Re: [patch 02/35] kudzu policy update
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080804123734.845685765@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
	 <20080804123734.845685765@hardeman.nu>
Content-Type: text/plain
Date: Thu, 14 Aug 2008 10:25:23 -0400
Message-Id: <1218723923.8095.80.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 14:34 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_admin_kudzu.patch)
> kudzu is RedHat's hw management app, none of the changes seem
> controversial.

Missing interfaces:

+init_read_init_state(kudzu_t)
+init_ptrace_init_domain(kudzu_t)

I suspect that the ptrace is still related to the /proc/pid entry that
triggers a ptrace check.  That was only fixed recently, I think.

+modutils_unlink_module_config(kudzu_t)


Merged the other parts.

> Previously sent Jul 19, no comments so far
> 
> Index: refpolicy/policy/modules/admin/kudzu.te
> ===================================================================
> --- refpolicy.orig/policy/modules/admin/kudzu.te	2008-08-03 16:47:00.000000000 +0200
> +++ refpolicy/policy/modules/admin/kudzu.te	2008-08-03 16:54:21.000000000 +0200
> @@ -21,8 +21,8 @@
>  # Local policy
>  #
>  
> -allow kudzu_t self:capability { dac_override sys_admin sys_rawio net_admin sys_tty_config mknod };
> -dontaudit kudzu_t self:capability { sys_ptrace sys_tty_config };
> +allow kudzu_t self:capability { dac_override sys_admin sys_ptrace sys_rawio net_admin sys_tty_config mknod };
> +dontaudit kudzu_t self:capability sys_tty_config;
>  allow kudzu_t self:process { signal_perms execmem };
>  allow kudzu_t self:fifo_file rw_fifo_file_perms;
>  allow kudzu_t self:unix_stream_socket { connectto create_stream_socket_perms };
> @@ -68,6 +68,7 @@
>  modutils_read_module_deps(kudzu_t)
>  modutils_read_module_config(kudzu_t)
>  modutils_rename_module_config(kudzu_t)
> +modutils_unlink_module_config(kudzu_t)
>  
>  storage_read_scsi_generic(kudzu_t)
>  storage_read_tape(kudzu_t)
> @@ -103,6 +104,8 @@
>  init_use_fds(kudzu_t)
>  init_use_script_ptys(kudzu_t)
>  init_stream_connect_script(kudzu_t)
> +init_read_init_state(kudzu_t)
> +init_ptrace_init_domain(kudzu_t)
>  # kudzu will telinit to make init re-read
>  # the inittab after configuring serial consoles
>  init_telinit(kudzu_t)
> @@ -143,28 +146,6 @@
>  ')
>  
>  optional_policy(`
> -	# cjp: this was originally in the else block
> -	# of ifdef userhelper.te, but it seems to
> -	# make more sense here.  also, require
> -	# blocks curently do not work in the
> -	# else block of optionals
> +	unconfined_domtrans(kudzu_t)
>  	unconfined_domain(kudzu_t)
>  ')
> -
> -ifdef(`TODO',`
> -allow kudzu_t modules_conf_t:file unlink;
> -optional_policy(`
> -	allow kudzu_t printconf_t:file { getattr read };
> -')
> -optional_policy(`
> -	allow kudzu_t xserver_exec_t:file getattr;
> -')
> -optional_policy(`
> -	allow kudzu_t rhgb_t:unix_stream_socket connectto;
> -')
> -optional_policy(`
> -	role system_r types sysadm_userhelper_t;
> -	domain_auto_trans(kudzu_t, userhelper_exec_t, sysadm_userhelper_t)
> -')
> -allow kudzu_t cupsd_rw_etc_t:dir list_dir_perms;
> -')
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
