Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iANKDgIi014630
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 15:13:42 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iANKC8uA007882
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 20:12:08 GMT
Subject: Re: can_network patch.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Jim Carter <jwcart2@epoch.ncsc.mil>, Russell Coker <russell@coker.com.au>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux <selinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>
In-Reply-To: <41A3917F.30104@redhat.com>
References: <41741A2C.8040408@redhat.com>
	 <200410260138.19426.russell@coker.com.au>
	 <20041025213122.GA2535@jmh.mhn.de>
	 <200410270036.14935.russell@coker.com.au>
	 <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>
	 <4192A029.5050909@redhat.com>
	 <1100722524.22035.18.camel@moss-lions.epoch.ncsc.mil>
	 <419CB2A8.7020504@redhat.com>
	 <1101235934.7273.24.camel@moss-lions.epoch.ncsc.mil>
	 <1101236807.19785.216.camel@moss-spartans.epoch.ncsc.mil>
	 <41A3917F.30104@redhat.com>
Content-Type: text/plain
Message-Id: <1101240468.19785.298.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 23 Nov 2004 15:07:48 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-11-23 at 14:37, Daniel J Walsh wrote:
> Well thats ok, but it means we change 87 instances and leave 19 instances. 
> Which does not make much sense to me.

It accurately represents what we are doing, i.e. removing a permission
from 87 domains that never needed it based on an explicit assessment.   

> We are still treating name_bind separately.  I see bind and connect 
> being the similar access rights.  IE Both are used to "connect" a port to a
> socket.  So why aren't we talking about moving name_bind into the 
> can_network series of connections?

Process->socket bind permission is granted by can_network(), as with
process->socket connect permission.  socket->port name_bind permission
is allowed separately, as can_network is too generic to know which ports
are needed by the application, and we certainly don't want to allow
arbitrary port binding.  However, we used to allow name_bind for the
default port_t type in can_network(), and could probably restore those
rules now that all reserved ports are guaranteed to be mapped to
reserved_port_t or an individual port type.

If no one agrees with me about preserving can_network() semantics, then
I can be overruled.  But I thought that Russell had voiced a similar
concern earlier.

> I still think we need ability to specify which ports a network can 
> connect to.
> Any movement on providing this capability?

Not yet, AFAIK.  I don't think it will be difficult, but it is too late
for certain distro releases anyway.  So even if we gave you the
capability now, you couldn't make use of it for some time.

> I can add
> can_network_server()
> can_network_client()
> can_tcp_server()
> can_tcp_client()
> can_udp_server()
> can_udp_client()
> 
> And then retain can_network

client/server distinction only makes sense for TCP.  You can distinguish
sender/receiver for UDP, but most real applications that use UDP are
going to be acting as both a sender and a receiver anyway.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
