Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h91L6gsJ028751
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 17:06:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h91L4rZt009224
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 21:04:54 GMT
Received: from Woody.fw.matav.hu (matav-1.matav.hu [145.236.241.98])
	by jazzswing.ncsc.mil  with ESMTP id h91L4rM3009221
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 21:04:53 GMT
Date: Wed, 1 Oct 2003 20:57:58 +0000
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: [selinux] Re: X Windows discussion
Message-ID: <20031001205758.GD13500@bunuel.tii.matav.hu>
References: <1064880029.5342.349.camel@moss-tarheels.epoch.ncsc.mil> <200309301631.12831.wlsel@verizon.net> <200310011534.09826.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <200310011534.09826.russell@coker.com.au>
From: mag@bunuel.tii.matav.hu (Magosányi Árpád)
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A levelezõm azt hiszi, hogy Russell Coker a következõeket írta:
> Are many people running systems where screen capture speed is a bottleneck?

I am not in that set, if it does matter:)

> For local connections we control access to the Unix domain socket and to the 
> TCP port.  For remote connections the only sensible thing to do is to use ssh 
> tunneling.  You just have to avoid doing "ssh -X untrusted-host" (you would 
> be amazed how many people try to do X forwarding from my play machine).

No. What if my environment have proper physical security, and consists
of one or more trusted hosts being on the same switched network (for
example I use the multilevel packet switch certified TCSEC A1 :), and
some untrusted hosts being either on the same switched network or
at the far end of some router or firewall? Or -horribile dictu-
my site is connected to other similar enclaves through ipsec or
ssl channels, which channels end in a firewall/guard which is able
to properly label the traffic either through CIPSO or RIPSO,
or putting source tcp ports/ip addresses to predefined
intervalls/values?

The above is a set of assumptions which can be more or less easily
satisfied (well, me buying an A1 switch was just a joke, but if you
have a spare one, I will give you my postal address ;). With this
set of assumptions you do not have to need X forwarding.

Anyway, the main point here is not cryptography, but authentication.
And authentication should be done by Xauthority, I think.

> As for labeled networking, requiring IPSEC is a difficult issue, many people 
> have deployed networks with other systems and are not in a hurry to change.  

Yes, and even naked cipso/ripso are not a real option.

____And here comes the important part:____

Having labels communicated to the packet filter IS an option which can be
relatively easily done, and can be used for communicating labels in a
multitude of ways through nodes.
Here are some scenarios which can be done if labels are translated to
netfilter marks:

1. outgoing packets can be SNAT-ed to either some port ranges or source
addresses based on label. In this way the other end can directly attach
the appropriate label to the traffic with the existing capabilities.

2. same for routing decisions to always go through trusted paths.

3. my favourite multilevel network protocol is plain old http(s),
with a X-security-level: or similar header. Wrap-in to this protocol
is easily implementable, wrap-out is actually implemented by Zorp.
We just need the labels, which can be picked up from the netfilter
mark, or with mechanisms given in point 1.

I guess that the main point is to have a way for the network mechanisms
to attach the label to the outgoing traffic in a manner which can be
handled by them by their usual habit.

> If we demand that all networked SE-X users have IPSEC and labeled networking 
> running then we'll greatly delay any use of the technology.

And if we have iptable_semark module, we'll greatly speed it up...

-- 
GNU GPL: csak tiszta forrásból


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
