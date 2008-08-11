Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7BE9oWO007180
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 10:09:50 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m7BE9nPn010601
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 14:09:49 GMT
Subject: Re: [patch 34/35] qmail policy update
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080804123740.137182729@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
	 <20080804123740.137182729@hardeman.nu>
Content-Type: text/plain
Date: Mon, 11 Aug 2008 10:08:52 -0400
Message-Id: <1218463732.16773.22.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 14:35 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_services_qmail.patch)
> Parts of the RH changes to the qmail module, mostly related to script
> execution and logging...

Merged.

> Index: refpolicy/policy/modules/services/qmail.te
> ===================================================================
> --- refpolicy.orig/policy/modules/services/qmail.te	2008-08-03 16:47:00.000000000 +0200
> +++ refpolicy/policy/modules/services/qmail.te	2008-08-03 22:57:55.000000000 +0200
> @@ -14,7 +14,7 @@
>  qmail_child_domain_template(qmail_clean, qmail_start_t)
>  
>  type qmail_etc_t;
> -files_type(qmail_etc_t)
> +files_config_file(qmail_etc_t)
>  
>  type qmail_exec_t;
>  files_type(qmail_exec_t)
> @@ -85,6 +85,8 @@
>  libs_use_ld_so(qmail_inject_t)
>  libs_use_shared_libs(qmail_inject_t)
>  
> +miscfiles_read_localization(qmail_inject_t)
> +
>  qmail_read_config(qmail_inject_t)
>  
>  ########################################
> @@ -106,11 +108,17 @@
>  
>  kernel_read_system_state(qmail_local_t)
>  
> +corecmd_exec_bin(qmail_local_t)
>  corecmd_exec_shell(qmail_local_t)
> +can_exec(qmail_local_t, qmail_local_exec_t)
>  
>  files_read_etc_files(qmail_local_t)
>  files_read_etc_runtime_files(qmail_local_t)
>  
> +auth_use_nsswitch(qmail_local_t)
> +
> +logging_send_syslog_msg(qmail_local_t)
> +
>  mta_append_spool(qmail_local_t)
>  
>  qmail_domtrans_queue(qmail_local_t)
> @@ -155,6 +163,10 @@
>  manage_files_pattern(qmail_queue_t, qmail_spool_t, qmail_spool_t)
>  rw_fifo_files_pattern(qmail_queue_t, qmail_spool_t, qmail_spool_t)
>  
> +corecmd_exec_bin(qmail_queue_t)
> +
> +logging_send_syslog_msg(qmail_queue_t)
> +
>  optional_policy(`
>  	daemontools_ipc_domain(qmail_queue_t)
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
