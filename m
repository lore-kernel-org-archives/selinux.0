Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7BDpIl1002364
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 09:51:18 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m7BDp6ec004235
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 13:51:06 GMT
Subject: Re: [patch 27/35] inetd policy update
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080804123739.041708374@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
	 <20080804123739.041708374@hardeman.nu>
Content-Type: text/plain
Date: Mon, 11 Aug 2008 09:50:19 -0400
Message-Id: <1218462619.16773.20.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 14:35 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_services_inetd.patch)
> RH changes to the inetd module, most of these are related to the MLS/MCS
> override which is already present in the module...

Comments inline

> Index: refpolicy/policy/modules/services/inetd.if
> ===================================================================
> --- refpolicy.orig/policy/modules/services/inetd.if	2008-08-03 16:47:00.000000000 +0200
> +++ refpolicy/policy/modules/services/inetd.if	2008-08-03 21:25:12.000000000 +0200
> @@ -115,6 +115,10 @@
>  
>  	allow $1 inetd_t:tcp_socket rw_stream_socket_perms;
>  	allow $1 inetd_t:udp_socket rw_socket_perms;
> +
> +	optional_policy(`
> +		stunnel_service_domain($1,$2)
> +	')
>  ')
>
>  ########################################
> Index: refpolicy/policy/modules/services/inetd.te
> ===================================================================
> --- refpolicy.orig/policy/modules/services/inetd.te	2008-08-03 16:47:00.000000000 +0200
> +++ refpolicy/policy/modules/services/inetd.te	2008-08-03 21:25:12.000000000 +0200
> @@ -30,6 +30,10 @@
>  type inetd_child_var_run_t;
>  files_pid_file(inetd_child_var_run_t)
>  
> +ifdef(`enable_mcs',`
> +	init_ranged_daemon_domain(inetd_t,inetd_exec_t,s0 - mcs_systemhigh)
> +')
> +
>  ########################################
>  #
>  # Local policy
> @@ -84,6 +88,7 @@
>  corenet_udp_bind_ftp_port(inetd_t)
>  corenet_tcp_bind_inetd_child_port(inetd_t)
>  corenet_udp_bind_inetd_child_port(inetd_t)
> +corenet_tcp_bind_ircd_port(inetd_t)
>  corenet_udp_bind_ktalkd_port(inetd_t)
>  corenet_tcp_bind_printer_port(inetd_t)
>  corenet_udp_bind_rlogind_port(inetd_t)
> @@ -137,6 +142,7 @@
>  miscfiles_read_localization(inetd_t)
>  
>  # xinetd needs MLS override privileges to work
> +mls_fd_use_all_levels(inetd_t)
>  mls_fd_share_all_levels(inetd_t)
>  mls_socket_read_to_clearance(inetd_t)
>  mls_socket_write_to_clearance(inetd_t)
> @@ -165,6 +171,7 @@
>  ')
>  
>  optional_policy(`
> +	unconfined_domain(inetd_t)
>  	unconfined_domtrans(inetd_t)
>  ')
>  
> @@ -181,6 +188,9 @@
>  # for identd
>  allow inetd_child_t self:netlink_tcpdiag_socket r_netlink_socket_perms;
>  allow inetd_child_t self:capability { setuid setgid };
> +allow inetd_child_t self:dir search;
> +allow inetd_child_t self:{ lnk_file file } { getattr read };
> +
>  files_search_home(inetd_child_t)
>  
>  manage_dirs_pattern(inetd_child_t, inetd_child_tmp_t, inetd_child_tmp_t)

Reverses an upstream change; these rules are redundant.

> @@ -227,3 +237,7 @@
>  optional_policy(`
>  	unconfined_domain(inetd_child_t)
>  ')
> +
> +optional_policy(`
> +	inetd_service_domain(inetd_child_t,bin_t)
> +')

Not acceptable, as bin_t doesn't belong to this module.  Probably want
corecmd_bin_domtrans() and corecmd_bin_entry_type().

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
