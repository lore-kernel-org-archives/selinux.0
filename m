Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB2FuVIi002617
	for <selinux@tycho.nsa.gov>; Thu, 2 Dec 2004 10:56:31 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB2Fsv5X013657
	for <selinux@tycho.nsa.gov>; Thu, 2 Dec 2004 15:54:57 GMT
Subject: Re: Reissue previous patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <41AF23B0.4020100@redhat.com>
References: <41741A2C.8040408@redhat.com>
	 <200410260138.19426.russell@coker.com.au>
	 <20041025213122.GA2535@jmh.mhn.de>
	 <200410270036.14935.russell@coker.com.au>
	 <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>
	 <4192A029.5050909@redhat.com>
	 <1100722524.22035.18.camel@moss-lions.epoch.ncsc.mil>
	 <419CB2A8.7020504@redhat.com>
	 <1101235934.7273.24.camel@moss-lions.epoch.ncsc.mil>
	 <41A4B54F.3070709@redhat.com>
	 <1101325733.12859.37.camel@moss-lions.epoch.ncsc.mil>
	 <41ACE3E6.5030801@redhat.com>
	 <1101995669.8032.20.camel@moss-lions.epoch.ncsc.mil>
	 <41AF23B0.4020100@redhat.com>
Content-Type: text/plain
Message-Id: <1102002706.26015.117.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 02 Dec 2004 10:51:46 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-02 at 09:16, Daniel J Walsh wrote:
> I think this is caused by the resolver.  This is why I would like to get 
> to the point of using
> can_resolve() where we specify the exact port that you can connect to.

Aren't the udp_socket send_msg/recv_msg permissions sufficient for this
purpose (check is between the socket context and the remote port
context), i.e. you can say that it can only send_msg/recv_msg to
dns_port_t:udp_socket?

Likewise, in what cases is it not sufficient to use the tcp_socket
send_msg/recv_msg permissions (i.e. when do you truly need the separate
name_connect permission check that you proposed earlier)?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
