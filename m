Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7MJu2DZ019278
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2007 15:56:02 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7MJu1ca002243
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2007 19:56:01 GMT
Subject: Re: [PATCH] refpolicy: services_bind changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708021926.l72JQNnn025047@redsox.boston.devel.redhat.com>
References: <200708021926.l72JQNnn025047@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Wed, 22 Aug 2007 15:55:07 -0400
Message-Id: <1187812507.13874.100.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 15:26 -0400, dwalsh@redhat.com wrote:
> bind now listens on dhcpd port
> New cache directory

There is a dnsmasq policy, no need to supplement bind.

> --- nsaserefpolicy/policy/modules/services/bind.fc      2007-05-29
> 14:10:57.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/services/bind.fc   2007-08-02
> 11:02:02.000000000 -0400
> @@ -45,4 +45,6 @@
>  /var/named/chroot/var/named/slaves(/.*)?
> gen_context(system_u:object_r:named_cache_t,s0)
>  /var/named/chroot/var/named/data(/.*)?
> gen_context(system_u:object_r:named_cache_t,s0)
>  /var/named/chroot/var/named/named\.ca --
> gen_context(system_u:object_r:named_conf_t,s0)
> +/var/named/dynamic(/.*)?
> gen_context(system_u:object_r:named_cache_t,s0)
> +/var/named/chroot/var/named/dynamic(/.*)?
> gen_context(system_u:object_r:named_cache_t,s0)
>  ')
> --- nsaserefpolicy/policy/modules/services/bind.te      2007-07-25
> 10:37:42.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/services/bind.te   2007-08-02
> 11:02:02.000000000 -0400
> @@ -119,6 +119,11 @@
>  corenet_sendrecv_dns_client_packets(named_t)
>  corenet_sendrecv_rndc_server_packets(named_t)
>  corenet_sendrecv_rndc_client_packets(named_t)
> +corenet_udp_bind_all_unreserved_ports(named_t)
> +
> +#dnsmasq
> +corenet_tcp_bind_dhcpd_port(named_t)
> +corenet_udp_bind_dhcpd_port(named_t)
> 
>  dev_read_sysfs(named_t)
>  dev_read_rand(named_t)
> @@ -232,6 +237,7 @@
>  corenet_tcp_sendrecv_all_nodes(ndc_t)
>  corenet_tcp_sendrecv_all_ports(ndc_t)
>  corenet_tcp_connect_rndc_port(ndc_t)
> +corenet_tcp_bind_all_nodes(ndc_t)
>  corenet_sendrecv_rndc_client_packets(ndc_t)
> 
>  fs_getattr_xattr_fs(ndc_t)
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
