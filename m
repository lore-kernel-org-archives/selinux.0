Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oBEFgemk013265
	for <selinux@tycho.nsa.gov>; Tue, 14 Dec 2010 10:42:40 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id oBEFgdwZ000060
	for <selinux@tycho.nsa.gov>; Tue, 14 Dec 2010 15:42:39 GMT
Message-ID: <4D079066.5050802@redhat.com>
Date: Tue, 14 Dec 2010 10:42:30 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss1.tresys.com>
Subject: Fwd: [rhel5-cc-external-list] SELinux: refpolicy-2.20091117
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I got asked this question, by someone.  I am asking on both lists in
case the mls guys don't pay attention to the refpolicy list.
> 
> 
> Looking into the mls file, I find two rules for the accept syscall and the 
> same objects where one rule is read-like and the other is write like:
> 
> mlsconstrain { socket tcp_socket udp_socket rawip_socket netlink_socket 
> packet_socket key_socket unix_stream_socket unix_dgram_socket 
> netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket 
> netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket 
> netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } { accept 
> connect }
>         (( l1 eq l2 ) or
>          (((( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
>            ( t1 == mlsnetread )) and
>           ((( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 )) 
> or
>            (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) 
> or
>            ( t1 == mlsnetwrite ))));
> 
> 
> # the socket "read" ops (note the check is dominance of the low level)
> mlsconstrain { socket tcp_socket udp_socket rawip_socket netlink_socket 
> packet_socket key_socket unix_stream_socket unix_dgram_socket 
> netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket 
> netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket 
> netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } { read getattr 
> listen accept getopt recv_msg }
>         (( l1 dom l2 ) or
>          (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
>          ( t1 == mlsnetread ));

Isn't the second accept covered by the first?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0HkGYACgkQrlYvE4MpobOuDQCgmzdkQ6ZMjvitsbv4+m46uYZl
HA8AnRdXoZdYIu+Yxv0BHj3SpeCkPPbZ
=NfK7
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
