Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3NKNxI4004743
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 16:23:59 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3NKNw7R027456
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 20:23:58 GMT
Received: from petrus.schuldei.org ([81.27.1.16])
        by jazzband.ncsc.mil  with ESMTP id h3NKNvKP027398 for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 20:23:57 GMT
Date: Wed, 23 Apr 2003 22:13:33 +0200
From: Andreas Schuldei <andreas@schuldei.org>
To: Peter Gervai <grin@tolna.net>
Cc: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: please offer your good advices / new policies: exim, dovecot, maradns, (aptitude)
Message-ID: <20030423201331.GA14673@lukas>
References: <20030423111231.GV3993@narya.grin.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030423111231.GV3993@narya.grin.hu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Peter Gervai (grin@tolna.net) [030423 20:56]:
> (One line for every packet ever arriving on the network!)
> 
> I don't see the reason for this (I have wild guesses), and I don't see the
> solution. And I don't get why nobody had this problem before. Shall I
> dontaudit these (modifying dhcpc, newrole, sshd, ...)? Is there a better
> solution?

yes, that is what i did, too. (i think i asked the same question
here, too, and never got an answer.)

i have here collected over time:
dontaudit dhcpd_t sshd_t:packet_socket { recvfrom };
dontaudit dhcpd_t courier_tcpd_t:packet_socket { recvfrom };
dontaudit dhcpd_t netmsg_eth1_t:packet_socket { recvfrom };
dontaudit dhcpd_t icmp_socket_t:rawip_socket { recvfrom };
dontaudit dhcpd_t ping_t:rawip_socket { recvfrom };
dontaudit dhcpd_t named_t:packet_socket { recvfrom };
dontaudit dhcpd_t netmsg_eth0_t:packet_socket { recvfrom };
dontaudit dhcpd_t apt_t:packet_socket { recvfrom };
dontaudit dhcpd_t inetd_t:packet_socket { recvfrom };
dontaudit dhcpd_t postfix_master_t:packet_socket { recvfrom };
dontaudit dhcpd_t tcp_socket_t:packet_socket { recvfrom };
dontaudit dhcpd_t dhcpd_t:packet_socket { recvfrom };
dontaudit dhcpd_t icmp_socket_t:packet_socket { recvfrom };
dontaudit dhcpd_t sysadm_ssh_t:packet_socket { recvfrom };

basicly, these are all the services i run on that box.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
