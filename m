Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1NIm6Jx025303
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 13:48:06 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l1NInPPU028855
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 18:49:25 GMT
Subject: Re: nis changes for policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45DB2CCF.8020205@redhat.com>
References: <45DB2CCF.8020205@redhat.com>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 18:49:36 +0000
Message-Id: <1172256576.15371.75.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-20 at 12:15 -0500, Daniel J Walsh wrote:
> Lots of additional rules for ypxfr

Merged, with a little reordering.

> --- nsaserefpolicy/policy/modules/services/nis.te       2007-02-19 11:32:53.000000000 -0500
> +++ serefpolicy-2.5.4/policy/modules/services/nis.te    2007-02-20 12:12:48.000000000 -0500
> @@ -323,17 +323,18 @@
>  #
>  # ypxfr local policy
>  #
> -
> +allow ypxfr_t self:unix_dgram_socket create_stream_socket_perms;
>  allow ypxfr_t self:unix_stream_socket create_stream_socket_perms;
> -allow ypxfr_t self:tcp_socket connected_socket_perms;
> +allow ypxfr_t self:tcp_socket create_stream_socket_perms;
>  allow ypxfr_t self:udp_socket create_socket_perms;
> -
> -manage_files_pattern(ypxfr_t, var_yp_t, var_yp_t)
> +allow ypxfr_t self:netlink_route_socket r_netlink_socket_perms;
>  
>  allow ypxfr_t ypserv_t:tcp_socket { read write };
>  allow ypxfr_t ypserv_t:udp_socket { read write };
>  
> -read_files_pattern(ypxfr_t,var_yp_t,var_yp_t)
> +allow ypxfr_t ypserv_conf_t:file { getattr read };
> +
> +manage_files_pattern(ypxfr_t, var_yp_t, var_yp_t)
>  
>  corenet_non_ipsec_sendrecv(ypxfr_t)
>  corenet_tcp_sendrecv_all_if(ypxfr_t)
> @@ -355,7 +356,18 @@
>  files_read_etc_files(ypxfr_t)
>  files_search_usr(ypxfr_t)
>  
> +init_use_fds(ypxfr_t)
> +
>  libs_use_shared_libs(ypxfr_t)
>  libs_use_ld_so(ypxfr_t)
>  
> +logging_send_syslog_msg(ypxfr_t)
> +
> +miscfiles_read_localization(ypxfr_t)
> +
>  sysnet_read_config(ypxfr_t)
> +
> +ifdef(`targeted_policy', `
> +       term_dontaudit_use_unallocated_ttys(ypxfr_t)
> +       term_dontaudit_use_generic_ptys(ypxfr_t)
> +')
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
