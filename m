Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2JJJhoP009812
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 15:19:43 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2JJJgRc015566
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 19:19:43 GMT
Subject: Re: mls changes to get xinetd to work with labeled networking
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45F025F7.7060609@redhat.com>
References: <45F025F7.7060609@redhat.com>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 19:19:54 +0000
Message-Id: <1174331994.16707.18.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'd prefer to wait for the final MLS constraints for LSPP.

On Thu, 2007-03-08 at 10:04 -0500, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/modules/kernel/mls.if 2006-11-16 17:15:04.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/kernel/mls.if      2007-03-08 08:42:37.000000000 -0500
> @@ -154,6 +154,26 @@
>  ########################################
>  ## <summary>
>  ##     Make specified domain MLS trusted
> +##     for writing to sockets at any level
> +##     that is dominated by the process clearance.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Domain allowed access.
> +##     </summary>
> +## </param>
> +#
> +interface(`mls_socket_write_to_clearance',`
> +       gen_require(`
> +               attribute mlsnetwritetoclr;
> +       ')
> +
> +       typeattribute $1 mlsnetwritetoclr;
> +')
> +
> +########################################
> +## <summary>
> +##     Make specified domain MLS trusted
>  ##     for writing to sockets at any level.
>  ## </summary>
>  ## <param name="domain">
> --- nsaserefpolicy/policy/modules/kernel/mls.te 2007-01-02 12:57:13.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/kernel/mls.te      2007-03-08 08:42:37.000000000 -0500
> @@ -18,6 +18,7 @@
>  attribute mlsnetreadtoclr;
>  attribute mlsnetwrite;
>  attribute mlsnetwritetoclr;
> +attribute mlsnetwriteranged;
>  attribute mlsnetupgrade;
>  attribute mlsnetdowngrade;
>  attribute mlsnetrecvall;
> @@ -43,6 +44,8 @@
>  attribute mlsxwinwritecolormap;
>  attribute mlsxwinwritexinput;
>  
> +# Object attributes that allow MLS overrides for access by all subjects
> +attribute mlsrangedobject;
>  attribute mlstrustedobject;
>  
>  attribute privrangetrans;
> --- nsaserefpolicy/policy/modules/services/inetd.te     2007-02-19 11:32:53.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/services/inetd.te  2007-03-08 08:42:37.000000000 -0500
> @@ -140,8 +140,8 @@
>  mls_fd_use_all_levels(inetd_t)
>  mls_fd_share_all_levels(inetd_t)
>  mls_socket_read_to_clearance(inetd_t)
> +mls_socket_write_to_clearance(inetd_t)
>  mls_process_set_level(inetd_t)
> -mls_socket_read_to_clearance(inetd_t)
>  
>  sysnet_read_config(inetd_t)
>  
> @@ -192,6 +192,9 @@
>  # for identd
>  allow inetd_child_t self:netlink_tcpdiag_socket r_netlink_socket_perms;
>  allow inetd_child_t self:capability { setuid setgid };
> +allow inetd_child_t self:dir search;
> +allow inetd_child_t self:{ lnk_file file } { getattr read };
> +
>  files_search_home(inetd_child_t)
>  
>  manage_dirs_pattern(inetd_child_t,inetd_child_tmp_t,inetd_child_tmp_t)
> --- nsaserefpolicy/policy/mls   2006-11-16 17:15:26.000000000 -0500
> +++ serefpolicy-2.5.8/policy/mls        2007-03-08 08:42:36.000000000 -0500
> @@ -89,12 +89,14 @@
>  mlsconstrain { file lnk_file fifo_file dir chr_file blk_file sock_file } { write create setattr relabelfrom append unlink link rename mounton }
>         (( l1 eq l2 ) or
>          (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
> -        (( t2 == mlsfilewriteinrange ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
>          ( t1 == mlsfilewrite ) or
> +        (( t2 == mlsrangedobject ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
>          ( t2 == mlstrustedobject ));
>  
> +# Directory "write" ops
>  mlsconstrain dir { add_name remove_name reparent rmdir }
> -       ((( l1 dom l2 ) and ( l1 domby h2 )) or
> +       (( l1 eq l2 ) or
> +        (( t1 == mlsfilewriteinrange ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
>          (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
>          ( t1 == mlsfilewrite ) or
>          ( t2 == mlstrustedobject ));
> @@ -165,8 +167,20 @@
>  mlsconstrain { socket tcp_socket udp_socket rawip_socket netlink_socket packet_socket key_socket unix_stream_socket unix_dgram_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } relabelto
>         ( h1 dom h2 );
>  
> +# the socket "read+write" ops
> +# (Socket FDs are generally bidirectional, equivalent to open(..., O_RDWR),
> +# require equal levels for unprivileged subjects, or read *and* write overrides)
> +mlsconstrain { socket tcp_socket udp_socket rawip_socket netlink_socket packet_socket key_socket unix_stream_socket unix_dgram_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } { accept connect }
> +       (( l1 eq l2 ) or
> +        (((( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
> +          ( t1 == mlsnetread )) and
> +         ((( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
> +          (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
> +          ( t1 == mlsnetwrite ))));
> +
> +
>  # the socket "read" ops (note the check is dominance of the low level)
> -mlsconstrain { socket tcp_socket udp_socket rawip_socket netlink_socket packet_socket key_socket unix_stream_socket unix_dgram_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } { read getattr listen accept getopt recv_msg }
> +mlsconstrain { socket tcp_socket udp_socket rawip_socket netlink_socket packet_socket key_socket unix_stream_socket unix_dgram_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } { read getattr listen getopt recv_msg }
>         (( l1 dom l2 ) or
>          (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
>          ( t1 == mlsnetread ));
> @@ -177,13 +191,14 @@
>          ( t1 == mlsnetread ));
>  
>  # the socket "write" ops
> -mlsconstrain { socket tcp_socket udp_socket rawip_socket netlink_socket packet_socket key_socket unix_stream_socket unix_dgram_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } { write setattr relabelfrom connect setopt shutdown }
> -       ((( l1 dom l2 ) and ( l1 domby h2 )) or
> +mlsconstrain { socket tcp_socket udp_socket rawip_socket netlink_socket packet_socket key_socket unix_stream_socket unix_dgram_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } { write setattr relabelfrom setopt shutdown }
> +       (( l1 eq l2 ) or 
> +        (( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
>          (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
>          ( t1 == mlsnetwrite ));
>  
>  # used by netlabel to restrict normal domains to same level connections
> -mlsconstrain { tcp_socket udp_socket } recvfrom
> +mlsconstrain { tcp_socket udp_socket rawip_socket } recvfrom
>         (( l1 eq l2 ) or
>          (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
>          ( t1 == mlsnetread ));
> @@ -274,7 +289,8 @@
>  
>  # the netif/node "write" ops (implicit single level socket doing the write)
>  mlsconstrain { netif node } { tcp_send udp_send rawip_send }
> -       (( l1 dom l2 ) and ( l1 domby h2 ));
> +       (( l1 eq l2 ) or
> +       (( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 )));
>  
>  # these access vectors have no MLS restrictions
>  # node enforce_dest
> @@ -581,7 +597,8 @@
>          ( t2 == unlabeled_t ));
>  
>  mlsconstrain association { sendto }
> -       ((( l1 dom l2 ) and ( l1 domby h2 )) or
> +       (( l1 eq l2 ) or
> +        (( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
>          ( t2 == unlabeled_t ));
>  
>  mlsconstrain association { polmatch }
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
