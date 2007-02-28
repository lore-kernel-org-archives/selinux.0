Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1SFdQnN015626
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 10:39:26 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1SFem2u016200
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 15:40:48 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: Kerberos changes for policy
Date: Wed, 28 Feb 2007 10:41:06 -0500
Message-ID: <1172677266.11157.64.camel@sgc>
In-Reply-To: <200702261726.l1QHQlsd030617@localhost.localdomain>
References: <200702261726.l1QHQlsd030617@localhost.localdomain>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: <dwalsh@localhost.localdomain>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 12:26 -0500, dwalsh@localhost.localdomain wrote:
> Dontaudit additional library checks on files
> kdc requires setsched
> Needs to communicate with itself over fifo files
> Wants to look at the network

This one is a dupe (already upstreamed).

> ===File /tmp/patches/done/nsaserefpolicy_policy_modules_services_kerberos.patch===
> --- nsaserefpolicy/policy/modules/services/kerberos.if	2007-02-19 11:32:53.000000000 -0500
> +++ serefpolicy-2.5.5/policy/modules/services/kerberos.if	2007-02-26 11:02:34.000000000 -0500
> @@ -40,8 +40,8 @@
>  	files_search_etc($1)
>  	allow $1 krb5_conf_t:file { getattr read };
>  	dontaudit $1 krb5_conf_t:file write;
> -	dontaudit $1 krb5kdc_conf_t:dir list_dir_perms;
> -	dontaudit $1 krb5kdc_conf_t:file read_file_perms;
> +	dontaudit $1 krb5kdc_conf_t:dir r_dir_perms;
> +	dontaudit $1 krb5kdc_conf_t:file rw_file_perms;
>  
>  	tunable_policy(`allow_kerberos',`
>  		allow $1 self:tcp_socket create_socket_perms;
> --- nsaserefpolicy/policy/modules/services/kerberos.te	2007-02-19 11:32:53.000000000 -0500
> +++ serefpolicy-2.5.5/policy/modules/services/kerberos.te	2007-02-26 11:02:34.000000000 -0500
> @@ -154,10 +154,11 @@
>  # Use capabilities. Surplus capabilities may be allowed.
>  allow krb5kdc_t self:capability { setuid setgid net_admin chown fowner dac_override sys_nice };
>  dontaudit krb5kdc_t self:capability sys_tty_config;
> -allow krb5kdc_t self:process { getsched signal_perms };
> +allow krb5kdc_t self:process { setsched getsched signal_perms };
>  allow krb5kdc_t self:netlink_route_socket r_netlink_socket_perms;
>  allow krb5kdc_t self:tcp_socket create_stream_socket_perms;
>  allow krb5kdc_t self:udp_socket create_socket_perms;
> +allow krb5kdc_t self:fifo_file rw_fifo_file_perms;
>  
>  allow krb5kdc_t krb5_conf_t:file read_file_perms;
>  dontaudit krb5kdc_t krb5_conf_t:file write;
> @@ -185,6 +186,7 @@
>  kernel_list_proc(krb5kdc_t)
>  kernel_read_proc_symlinks(krb5kdc_t)
>  kernel_read_network_state(krb5kdc_t)
> +kernel_search_network_sysctl(krb5kdc_t)
>  
>  corecmd_exec_sbin(krb5kdc_t)
>  corecmd_exec_bin(krb5kdc_t)
> ============================================================
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
