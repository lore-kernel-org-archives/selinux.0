Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2QLDux6020228
	for <selinux@tycho.nsa.gov>; Wed, 26 Mar 2003 16:13:57 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h2QLDtR1008613
	for <selinux@tycho.nsa.gov>; Wed, 26 Mar 2003 21:13:55 GMT
Received: from petrus.schuldei.org ([81.27.1.16])
        by jazzband.ncsc.mil  with ESMTP id h2QLDsj9008525 for <selinux@tycho.nsa.gov>; Wed, 26 Mar 2003 21:13:55 GMT
Received: from lukas (lukas.schuldei.com [192.168.31.10])
	by petrus.schuldei.org (Postfix) with ESMTP id A4E73FBB62
	for <selinux@tycho.nsa.gov>; Wed, 26 Mar 2003 22:12:23 +0100 (CET)
Date: Wed, 26 Mar 2003 22:12:33 +0100
From: Andreas Schuldei <andreas@schuldei.org>
To: selinux@tycho.nsa.gov
Subject: DHCP server and client
Message-ID: <20030326211233.GE1342@lukas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

when i run a DHCP client or server on an selinux box the
interface dhcp uses is switched to promiscous mode.

as a result i get lots of denies for all the rest of the system,
which clutter up the logs. this is what newrules-selinux -d tells
me:

allow dhcpd_t sshd_t:packet_socket { recvfrom };
allow dhcpd_t courier_tcpd_t:packet_socket { recvfrom };
allow dhcpd_t netmsg_eth1_t:packet_socket { recvfrom };
allow dhcpd_t icmp_socket_t:rawip_socket { recvfrom };
allow dhcpd_t ping_t:rawip_socket { recvfrom };
allow dhcpd_t named_t:packet_socket { recvfrom };
allow dhcpd_t netmsg_eth0_t:packet_socket { recvfrom };
allow dhcpd_t apt_t:packet_socket { recvfrom };
allow dhcpd_t inetd_t:packet_socket { recvfrom };
allow dhcpd_t postfix_master_t:packet_socket { recvfrom };
allow dhcpd_t tcp_socket_t:packet_socket { recvfrom };

i am not sure if i have to allow them or wheather a dontaudit
should suffice. shouldnt one or the other be put in some kind of
dhcp-handling policy? the logging facility is becoming really
useless otherwise, since an avc denied warnings in the logs and
the really importent once get dropped.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
