Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7BE9tFM007212
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 10:09:55 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m7BE9sPn010647
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 14:09:55 GMT
Subject: Re: [patch 29/35] ipsec policy update
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080804123739.357107258@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
	 <20080804123739.357107258@hardeman.nu>
Content-Type: text/plain
Date: Mon, 11 Aug 2008 10:08:58 -0400
Message-Id: <1218463738.16773.23.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 14:35 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_system_ipsec.patch)
> ipsec changes including a new interface which is used by the sysnetwork
> module...

Merged.

> Index: refpolicy/policy/modules/system/ipsec.if
> ===================================================================
> --- refpolicy.orig/policy/modules/system/ipsec.if	2008-07-19 19:15:43.000000000 +0200
> +++ refpolicy/policy/modules/system/ipsec.if	2008-08-03 21:32:40.000000000 +0200
> @@ -150,6 +150,26 @@
>  	manage_files_pattern($1,ipsec_var_run_t,ipsec_var_run_t)
>  ')
>  
> +
> +########################################
> +## <summary>
> +##	write the ipsec_var_run_t files.
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	The type of the process performing this action.
> +##	</summary>
> +## </param>
> +#
> +interface(`ipsec_write_pid',`
> +	gen_require(`
> +		type ipsec_var_run_t;
> +	')
> +
> +	files_search_pids($1)
> +	write_files_pattern($1,ipsec_var_run_t,ipsec_var_run_t)
> +')
> +
>  ########################################
>  ## <summary>
>  ##	Execute racoon in the racoon domain.
> Index: refpolicy/policy/modules/system/ipsec.te
> ===================================================================
> --- refpolicy.orig/policy/modules/system/ipsec.te	2008-07-19 19:15:43.000000000 +0200
> +++ refpolicy/policy/modules/system/ipsec.te	2008-08-03 21:33:27.000000000 +0200
> @@ -69,8 +69,8 @@
>  read_files_pattern(ipsec_t,ipsec_key_file_t,ipsec_key_file_t)
>  read_lnk_files_pattern(ipsec_t,ipsec_key_file_t,ipsec_key_file_t)
>  
> -allow ipsec_t ipsec_var_run_t:file manage_file_perms;
> -allow ipsec_t ipsec_var_run_t:sock_file manage_sock_file_perms;
> +manage_files_pattern(ipsec_t, ipsec_var_run_t, ipsec_var_run_t)
> +manage_sock_files_pattern(ipsec_t, ipsec_var_run_t, ipsec_var_run_t)
>  files_pid_filetrans(ipsec_t,ipsec_var_run_t,{ file sock_file })
>  
>  can_exec(ipsec_t, ipsec_mgmt_exec_t)
> Index: refpolicy/policy/modules/system/sysnetwork.te
> ===================================================================
> --- refpolicy.orig/policy/modules/system/sysnetwork.te	2008-08-03 21:37:35.000000000 +0200
> +++ refpolicy/policy/modules/system/sysnetwork.te	2008-08-03 21:38:27.000000000 +0200
> @@ -332,6 +332,10 @@
>  ')
>  
>  optional_policy(`
> +	ipsec_write_pid(ifconfig_t)
> +')
> +
> +optional_policy(`
>  	kernel_read_xen_state(ifconfig_t)
>  	kernel_write_xen_state(ifconfig_t)
>  	xen_append_log(ifconfig_t)
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
