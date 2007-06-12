Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5CD0jMi017572
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 09:00:45 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5CD0cgs003112
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 13:00:44 GMT
Subject: Re: Arpwatch uses nsswitch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301506.l4UF6gtR009303@localhost.localdomain>
References: <200705301506.l4UF6gtR009303@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 12 Jun 2007 08:59:16 -0400
Message-Id: <1181653156.16029.61.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 11:06 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/arpwatch.te	2007-05-29 14:10:57.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/services/arpwatch.te	2007-05-30 09:25:53.000000000 -0400
> @@ -28,7 +28,6 @@
>  allow arpwatch_t self:process signal_perms;
>  allow arpwatch_t self:unix_dgram_socket create_socket_perms;
>  allow arpwatch_t self:unix_stream_socket create_stream_socket_perms;
> -allow arpwatch_t self:netlink_route_socket r_netlink_socket_perms;
>  allow arpwatch_t self:tcp_socket { connect create_stream_socket_perms };
>  allow arpwatch_t self:udp_socket create_socket_perms;
>  allow arpwatch_t self:packet_socket create_socket_perms;
> @@ -78,15 +77,13 @@
>  
>  miscfiles_read_localization(arpwatch_t)
>  
> -sysnet_read_config(arpwatch_t)
> -
>  userdom_dontaudit_use_unpriv_user_fds(arpwatch_t)
>  userdom_dontaudit_search_sysadm_home_dirs(arpwatch_t)
>  
>  mta_send_mail(arpwatch_t)
>  
>  optional_policy(`
> -	nis_use_ypbind(arpwatch_t)
> +	auth_use_nsswitch(arpwatch_t)
>  ')
>  
>  optional_policy(`

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
