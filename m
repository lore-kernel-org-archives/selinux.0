Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3OG7qI4008787
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 12:07:52 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3OG7p7R022605
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 16:07:51 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h3OG7pKP022602 for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 16:07:51 GMT
Subject: Re: please offer your good advices / new policies: exim, dovecot,
	maradns, (aptitude)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Peter Gervai <grin@tolna.net>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <20030423111231.GV3993@narya.grin.hu>
References: <20030423111231.GV3993@narya.grin.hu>
Content-Type: text/plain
Message-Id: <1051200452.20300.53.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 24 Apr 2003 12:07:32 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-04-23 at 12:06, Peter Gervai wrote:
> There was a question a month ago about dhcpc_t (and sshd_t and newrole_t in
> cases) emitting this:
> 
> avc:  denied  { recvfrom } for  pid=1059 exe=/usr/sbin/exim saddr=10.1.1.16
>  source=17664 daddr=10.1.1.1 dest=60 netif=eth0
>  scontext=system_u:system_r:dhcpc_t tcontext=root:sysadm_r:sysadm_t
>  tclass=packet_socket
> 
> (One line for every packet ever arriving on the network!)

SELinux checks recvfrom permission between the socket and the packet
just before the packet is queued on the receiving socket; the hook is
security_sock_rcv_skb in sock_queue_rcv_skb in include/net/sock.h in the
2.4 tree.  Since dhcpc is using a packet socket, every packet reaches
this point, although it may be filtering them after the check via a
socket filter.  Note that the example policy grants this permission to
netmsg_eth0_t, the default type for incoming packets on eth0.  Locally
generated packets would show up with the domain of the sending socket
(== domain of the process that created the sending socket).  You can
probably just 'allow dhcpc_t domain:packet_socket recvfrom;'.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
