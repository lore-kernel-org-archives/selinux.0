Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8BJHkeh019514
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2007 15:17:46 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l8BJHiba009966
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2007 19:17:44 GMT
Subject: Re: [PATCH] refpolicy: services_inetd changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708022052.l72KqqEI000531@redsox.boston.devel.redhat.com>
References: <200708022052.l72KqqEI000531@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Tue, 11 Sep 2007 15:16:12 -0400
Message-Id: <1189538172.7512.14.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 16:52 -0400, dwalsh@redhat.com wrote:
> correct ports inetd listens on
> inetd uses nsswitch

Merged.

> --- nsaserefpolicy/policy/modules/services/inetd.te     2007-07-25 10:37:42.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/services/inetd.te  2007-08-02 11:02:02.000000000 -0400
> @@ -80,16 +80,21 @@
>  corenet_udp_bind_comsat_port(inetd_t)
>  corenet_tcp_bind_dbskkd_port(inetd_t)
>  corenet_udp_bind_dbskkd_port(inetd_t)
> +corenet_tcp_bind_ftp_port(inetd_t)
>  corenet_udp_bind_ftp_port(inetd_t)
>  corenet_tcp_bind_inetd_child_port(inetd_t)
> +corenet_udp_bind_inetd_child_port(inetd_t)
>  corenet_udp_bind_ktalkd_port(inetd_t)
>  corenet_tcp_bind_printer_port(inetd_t)
> +corenet_udp_bind_rlogind_port(inetd_t)
>  corenet_udp_bind_rsh_port(inetd_t)
> +corenet_tcp_bind_rsh_port(inetd_t)
>  corenet_tcp_bind_rsync_port(inetd_t)
>  corenet_udp_bind_rsync_port(inetd_t)
>  #corenet_tcp_bind_stunnel_port(inetd_t)
>  corenet_tcp_bind_swat_port(inetd_t)
>  corenet_udp_bind_swat_port(inetd_t)
> +corenet_tcp_bind_telnetd_port(inetd_t)
>  corenet_udp_bind_tftp_port(inetd_t)
>  corenet_tcp_bind_ssh_port(inetd_t)
> 
> @@ -135,14 +140,19 @@
>  mls_fd_use_all_levels(inetd_t)
>  mls_fd_share_all_levels(inetd_t)
>  mls_socket_read_to_clearance(inetd_t)
> +mls_socket_write_to_clearance(inetd_t)
>  mls_process_set_level(inetd_t)
> -mls_socket_read_to_clearance(inetd_t)
> 
>  sysnet_read_config(inetd_t)
> 
>  userdom_dontaudit_use_unpriv_user_fds(inetd_t)
>  userdom_dontaudit_search_sysadm_home_dirs(inetd_t)
> 
> +ifdef(`enable_mls',`
> +       corenet_tcp_recv_netlabel(inetd_t)
> +       corenet_udp_recv_netlabel(inetd_t)
> +')
> +
>  optional_policy(`
>         amanda_search_lib(inetd_t)
>  ')
> @@ -172,6 +182,9 @@
>  # for identd
>  allow inetd_child_t self:netlink_tcpdiag_socket r_netlink_socket_perms;
>  allow inetd_child_t self:capability { setuid setgid };
> +allow inetd_child_t self:dir search;
> +allow inetd_child_t self:{ lnk_file file } { getattr read };
> +
>  files_search_home(inetd_child_t)
> 
>  manage_dirs_pattern(inetd_child_t,inetd_child_tmp_t,inetd_child_tmp_t)
> @@ -214,13 +227,10 @@
>  ')
> 
>  optional_policy(`
> -       nis_use_ypbind(inetd_child_t)
> -')
> -
> -optional_policy(`
> -       nscd_socket_use(inetd_child_t)
> +       auth_use_nsswitch(inetd_child_t)
>  ')
> 
>  optional_policy(`
>         unconfined_domain(inetd_child_t)
> +       inetd_service_domain(inetd_child_t,bin_t)
>  ')
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
