Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA17013
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 18:33:18 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id XAA02149
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 23:31:51 GMT
Received: from tomcat.admin.navo.hpc.mil (tomcat.admin.navo.hpc.mil [204.222.179.33])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id XAA02145
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 23:31:50 GMT
Date: Thu, 11 Jan 2001 17:33:11 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200101112333.RAA80300@tomcat.admin.navo.hpc.mil>
To: bet@rahul.net, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: IPSEC integration (was Re: SELinux and covert channels)
Cc: Stephen Smalley <sds@tislabs.com>, selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Bennett Todd <bet@rahul.net>:
> 2001-01-11-14:17:57 Jesse Pollard:
> > Personally, I wouldn't be happy having to trust a routing protocol
> > for distributing security information.
> 
> You misunderstand what I'm thinking, which of course means I failed
> to express myself well, I'm sorry. What comes of making it up as I
> go along:-).
> 
> The routing protocol enters into things not to distribute any
> security information, but rather (once the ipsec associations have
> been established reflecting the policies specified in the central
> database) to deduce the reachability consequences, and to learn how
> to make use of the provided connectivity to actually reach desired
> destinations. A routing protocol should enable learning about, and
> using, transitive security associations.

I think I understand now - I wasn't considering the/a virtual
network implemented by non- point-to-point IP tunnels. (Re-reading
everything more than once helps understanding....)

> > I think it would be too easy to leak the security info to
> > intermediate routers that have no business examining the data.
> 
> The security info feeds a mechanism (as yet unspecified, presumably
> it'll have to be done as part of the selinux+IPSec integration)
> which establishes IPSec security associations. They provide a
> virtual network, encrypted and authenticated, layered atop the
> physical network that the real routers manipulate. It's this virtual
> network that I'm concerned about routing; its routing traffic is no
> more nor less security sensitive than the rest of the traffic
> passing through the IPSec tunnels, and it'd lie in their security
> domain, and be carried entirely within those tunnels. That's why I
> keep considering BGP4 despite it's relatively dissatisfying features
> match with the problem at hand, at least the BGP peering connections
> should have no trouble nattering through IPSec tunnels.
> 
> > Even though routers should get trusted routing updates, I don't
> > think they should be responsible for forwarding other security
> > data on (less potential exposure that way).
> 
> I see a complete separation between the underlying network media,
> which remains much as it is now, with routers, switches, wires,
> routing protocols, etc., and a new virtual network, entirely
> encrypted and strongly authenticated, riding atop that. The routing
> protocol I'm pondering here is the one that would lie within, and
> discover the connectivity nature of, this new layered virtual
> network.

I was looking at a single host/user desiring to communicate with
one or more designated hosts. Not something like a virtual cluster.
That does need "virtual" routers, though a tree structured distributed
security server would be able to provide some of that, just not at
the speed a router protocol could do.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
