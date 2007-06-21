Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5LDucLF030294
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 09:56:38 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5LDucPC019351
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 13:56:38 GMT
Subject: Re: Cron needs many changes to run on MLS
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301442.l4UEgvZP008075@localhost.localdomain>
References: <200705301442.l4UEgvZP008075@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 21 Jun 2007 09:54:58 -0400
Message-Id: <1182434098.24679.4.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 10:42 -0400, dwalsh@redhat.com wrote:
> nis domains should use rpc_ports not reserved ports

Should the reserved port binding rules turn to dontaudits:

> @@ -244,6 +253,8 @@
>  corenet_udp_bind_all_nodes(ypserv_t)
>  corenet_tcp_bind_reserved_port(ypserv_t)
>  corenet_udp_bind_reserved_port(ypserv_t)
> +corenet_tcp_bind_all_rpc_ports(ypserv_t)
> +corenet_udp_bind_all_rpc_ports(ypserv_t)
>  corenet_dontaudit_tcp_bind_all_reserved_ports(ypserv_t)
>  corenet_dontaudit_udp_bind_all_reserved_ports(ypserv_t)
>  corenet_sendrecv_generic_server_packets(ypserv_t)
> @@ -311,6 +323,8 @@
>  corenet_udp_bind_all_nodes(ypxfr_t)
>  corenet_tcp_bind_reserved_port(ypxfr_t)
>  corenet_udp_bind_reserved_port(ypxfr_t)
> +corenet_tcp_bind_all_rpc_ports(ypxfr_t)
> +corenet_udp_bind_all_rpc_ports(ypxfr_t)
>  corenet_dontaudit_tcp_bind_all_reserved_ports(ypxfr_t)
>  corenet_dontaudit_udp_bind_all_reserved_ports(ypxfr_t)
>  corenet_tcp_connect_all_ports(ypxfr_t)
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
