Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6VDhXHa002689
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 09:43:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6VDhVDW003813
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 13:43:31 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h6VDhUeN003809 for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 13:43:31 GMT
Subject: Re: macro about network
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
In-Reply-To: <20030729184953.31a3b3fb.ynakam@ori.hitachi-sk.co.jp>
References: <20030729184953.31a3b3fb.ynakam@ori.hitachi-sk.co.jp>
Content-Type: text/plain
Message-Id: <1059659001.1052.170.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 31 Jul 2003 09:43:22 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-07-29 at 05:49, Yuichi Nakamura wrote:
> In "can_network" macro,
> "allow $1 netmsg_type:tcp_socket { connectto acceptfrom };"
> exists.
> 
> I think in some case "connectto" permission is not neccesary.
> 
> For example,
> If worm like Slammer appeared for Apache,
> "connectto" permission might be used by worm 
> and Apache might used to send packet flood to other sites.
> 
> So,I would like to suggest three macros as attached to this mail.
> tcp_accept_only(domain)
> tcp_connect_netmsg(domain,netmsg)
> can_network_except_tcp(domain)
> 
> "tcp_accept_only" macro allows domain only TCP connection from network interface,
> but domain can not initiate TCP connection.
> 
> "tcp_connect_netmsg" macro is used to initiate TCP connection 
> to limited network initerface.
> 
> "can_network_except_tcp" macro is used to use network generally except TCP.
> 
> Example:
> tcp_accept_only(httpd_t)
> tcp_connect_netmsg(httpd_t,netmsg_lo_t)
> can_network_except_tcp(httpd_t)
> --->"httpd_t" can initiate TCP connection only to network interface "lo",
> and can use UDP socket.
> 
> I think it is useful if there are more fine grained macros(macros to control access to NICs,nodes).

I agree that we want finer-grained macros for the network permissions.
However, prior to starting down that path, it would be worthwhile to
first revisit the design and implementation of the socket and network
access controls, since we must do this anyway to deal with the fact that
most of the LSM networking security fields and hooks were rejected for
mainline Linux 2.5 and are not part of 2.6.  The general socket layer
hooks, including the (critical) sock_rcv_skb hook, were accepted, and we
can still implement some functionality using NetFilter, but we need to
revisit the implementation due to the loss of security fields in the
sk_buff and net_device, and this would also be a good time to consider
whether the existing set of permissions should be revised to better
support real network mandatory access control needs.  Feel free to make
suggestions in this area based on your own experiences with the existing
set of SELinux socket/network access controls.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
