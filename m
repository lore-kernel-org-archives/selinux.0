Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9RFIWXZ021628
	for <selinux@tycho.nsa.gov>; Wed, 27 Oct 2004 11:18:32 -0400 (EDT)
Subject: Re: Limiting the power of can_network, improving the security of
	strict policy.
From: Russell Coker <rcoker@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, sgrubb@redhat.com,
   Colin Walters <walters@redhat.com>, SE Linux list <selinux@tycho.nsa.gov>
In-Reply-To: <417FB917.8030109@redhat.com>
References: <417FB917.8030109@redhat.com>
Content-Type: text/plain
Date: Thu, 28 Oct 2004 01:18:17 +1000
Message-Id: <1098890298.16430.145.camel@aeon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-10-27 at 11:04 -0400, Daniel J Walsh wrote:
> Finally we are looking into limiting the power of can_network.  
> Currently any daemon that has can_network can receive
> and establish TCP/UDP connections.  The only thing not provided is 
> name_bind.  I want to break this out to eliminate the
> ability for daemons also to connect.  So an incoming only daemon, can 
> not establish a connection back out.  To do this
> I have modified create_socket_perms and eliminated the connect call.  I 
> have added a connect_socket_perms which includes
> the create_socket_perms.  This has caused many changes to be made in 
> policy, and I am not sure if it was a good idea?

I think it might be better to leave create_socket_perms as it is and
have another macro connected_socket_perms which doesn't have create
access.

> Also I modified can_network to take a second parameter of the type of 
> the connection (udp or tcp).  This allows you to turn off tcp, connections
> on a UDP application.  (I am not sure you can do this for a tcp only app 
> if they are going to use name service.)

What if we have two new macros can_tcp_network() and can_udp_network()
which can_network() invokes.

> Is this a good idea or am I wasting my time?

It's a great idea!  But I think some minor changes to the way that
backward compatability works would be good.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
