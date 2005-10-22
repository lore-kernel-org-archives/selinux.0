Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9MJtENs025431
	for <selinux@tycho.nsa.gov>; Sat, 22 Oct 2005 15:55:14 -0400 (EDT)
Received: from sbcs.cs.sunysb.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9MJptK1019811
	for <selinux@tycho.nsa.gov>; Sat, 22 Oct 2005 19:51:55 GMT
Received: from compserv1 (compserv1 [130.245.1.44])
	by sbcs.cs.sunysb.edu (8.12.3/8.12.11) with ESMTP id j9MJpqT3019742
	for <selinux@tycho.nsa.gov>; Sat, 22 Oct 2005 15:51:52 -0400 (EDT)
Date: Sat, 22 Oct 2005 15:51:54 -0400 (EDT)
From: Gaurav Poothia <gpoothia@cs.sunysb.edu>
To: selinux@tycho.nsa.gov
Subject: Security context of tcp_socket
Message-ID: <Pine.GSO.4.53.0510221547130.12755@compserv1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have a fundamental doubt regarding SELinux security contexts associated
with objects in the system.

Lets take the following rules for example:
1.allow dhcpd_t self : tcp_socket { create ioctl read  getattr write
setattr append bind connect getopt  setopt shutdown listen accept };

2.allow dhcpd_t node_type : { tcp_socket udp_socket } node_bind ;

3.allow dhcpd_t port_type : { tcp_socket udp_socket } { send_msg recv_msg
};


According to the first rule dhcpd can create a tcp_socket and then
perform various operations on it. I assume that the object thus created of
the tcp_socket class will inherit the type dhcp_t (since there is no
parent directory for a socket)

Now rules 2 and 3 allow dhcpd to have permissions node_bind and send/rcv
message over a tcp_socket object provided it has the a type with
attribute node_type or port_type respectively.

The object in question of class tcp_socket has type dhcpd_t (assumed
above) which has neither attribute port_type or node_type.

How do rules 2 and 3 then take effect (these are taken from the targeted
policy)?

Thanks and regards,
Gaurav


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
