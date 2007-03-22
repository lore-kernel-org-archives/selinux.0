Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2MDW2EQ007757
	for <selinux@tycho.nsa.gov>; Thu, 22 Mar 2007 09:32:02 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2MDW1cm029796
	for <selinux@tycho.nsa.gov>; Thu, 22 Mar 2007 13:32:01 GMT
Subject: Re: syslogd-ng defines tcp ports to connect to.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45F0213C.8020800@redhat.com>
References: <45F0213C.8020800@redhat.com>
Content-Type: text/plain
Date: Thu, 22 Mar 2007 13:32:33 +0000
Message-Id: <1174570354.19924.27.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 09:44 -0500, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/modules/system/logging.te     2007-02-23 16:50:01.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/system/logging.te  2007-03-08 08:42:37.000000000 -0500
> @@ -328,6 +329,9 @@
>  corenet_tcp_bind_all_nodes(syslogd_t)
>  corenet_tcp_bind_rsh_port(syslogd_t)
>  corenet_tcp_connect_rsh_port(syslogd_t)
> +# Allow users to define additional syslog ports to connect to
> +corenet_tcp_bind_syslogd_port(syslogd_t)
> +corenet_tcp_connect_syslogd_port(syslogd_t)
>  
>  # syslog-ng can send or receive logs
>  corenet_sendrecv_syslogd_client_packets(syslogd_t)

Merged this part, the later parts are not related.

> --- nsaserefpolicy/policy/modules/kernel/corenetwork.te.in      2007-02-19 11:32:51.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/kernel/corenetwork.te.in   2007-03-08 08:42:36.000000000 -0500
> @@ -43,11 +43,16 @@
>  sid port gen_context(system_u:object_r:port_t,s0)
>  
>  #
> -# reserved_port_t is the type of INET port numbers below 1024.
> +# reserved_port_t is the type of INET port numbers below 599.
>  #
>  type reserved_port_t, port_type, reserved_port_type;
>  
>  #
> +# hi_reserved_port_t is the type of INET port numbers between 600-1023.
> +#
> +type hi_reserved_port_t, port_type, reserved_port_type, rpc_port_type;
> +
> +#
>  # server_packet_t is the default type of IPv4 and IPv6 server packets.
>  #
>  type server_packet_t, packet_type, server_packet_type;
> @@ -140,6 +145,7 @@
>  network_port(soundd, tcp,8000,s0, tcp,9433,s0)
>  type socks_port_t, port_type; dnl network_port(socks) # no defined portcon
>  type stunnel_port_t, port_type; dnl network_port(stunnel) # no defined portcon in current strict
> +network_port(squid, udp,3401,s0, tcp,3401,s0, udp,4827,s0, tcp,4827,s0, )
>  network_port(swat, tcp,901,s0)
>  network_port(syslogd, udp,514,s0)
>  network_port(telnetd, tcp,23,s0)
> @@ -157,8 +163,11 @@
>  
>  # Defaults for reserved ports.  Earlier portcon entries take precedence;
>  # these entries just cover any remaining reserved ports not otherwise declared.
> -portcon tcp 1-1023 gen_context(system_u:object_r:reserved_port_t, s0)
> -portcon udp 1-1023 gen_context(system_u:object_r:reserved_port_t, s0)
> +
> +portcon tcp 600-1023 gen_context(system_u:object_r:hi_reserved_port_t, s0)
> +portcon udp 600-1023 gen_context(system_u:object_r:hi_reserved_port_t, s0)
> +portcon tcp 1-599 gen_context(system_u:object_r:reserved_port_t, s0)
> +portcon udp 1-599 gen_context(system_u:object_r:reserved_port_t, s0)
>  
>  ########################################
>  # 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
