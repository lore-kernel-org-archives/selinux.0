Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h92JodsJ005858
	for <selinux@tycho.nsa.gov>; Thu, 2 Oct 2003 15:50:39 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h92Joc7d016283
	for <selinux@tycho.nsa.gov>; Thu, 2 Oct 2003 19:50:38 GMT
Received: from out007.verizon.net (out007pub.verizon.net [206.46.170.107])
        by jazzband.ncsc.mil  with ESMTP id h92JobRn016280 for <selinux@tycho.nsa.gov>; Thu, 2 Oct 2003 19:50:37 GMT
Content-Type: text/plain;
  charset="iso-8859-2"
From: Bill Laut <wlsel@verizon.net>
To: mag@bunuel.tii.matav.hu (=?iso-8859-2?q?Magos=E1nyi?= =?iso-8859-2?q?=20=C1rp=E1d?=)
Subject: Re: [selinux] Re: X Windows discussion
Date: Thu, 2 Oct 2003 15:52:54 -0400
Cc: selinux@tycho.nsa.gov
References: <1064880029.5342.349.camel@moss-tarheels.epoch.ncsc.mil> <200310011534.09826.russell@coker.com.au> <20031001205758.GD13500@bunuel.tii.matav.hu>
In-Reply-To: <20031001205758.GD13500@bunuel.tii.matav.hu>
MIME-Version: 1.0
Message-Id: <200310021552.54216.wlsel@verizon.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 01 October 2003 04:57 pm, Magosányi Árpád wrote:
> A levelezõm azt hiszi, hogy Russell Coker a következõeket írta:
> > Are many people running systems where screen capture speed is a
> > bottleneck?
>
> I am not in that set, if it does matter:)
>

I don't think anyone is, and which was Russell's point.  :-)

My original "concern" was nothing more than idle speculation, namely "is there 
a way we can somehow improve AVC's performance?"  A reflection of the ideal 
of never being satisfied with the status quo.

>
> > For local connections we control access to the Unix domain socket and to
> > the TCP port.  For remote connections the only sensible thing to do is to
> > use ssh tunneling.  You just have to avoid doing "ssh -X untrusted-host"
> > (you would be amazed how many people try to do X forwarding from my play
> > machine).
>
> No. What if my environment have proper physical security, and consists
> of one or more trusted hosts being on the same switched network (for
> example I use the multilevel packet switch certified TCSEC A1 :), and
> some untrusted hosts being either on the same switched network or
> at the far end of some router or firewall? Or -horribile dictu-
> my site is connected to other similar enclaves through ipsec or
> ssl channels, which channels end in a firewall/guard which is able
> to properly label the traffic either through CIPSO or RIPSO,
> or putting source tcp ports/ip addresses to predefined
> intervalls/values?
>
> The above is a set of assumptions which can be more or less easily
> satisfied (well, me buying an A1 switch was just a joke, but if you
> have a spare one, I will give you my postal address ;). With this
> set of assumptions you do not have to need X forwarding.
>

Not every site will reflect the model you list above.  In fact, I wager the 
majority of sites won't fit your description.  However, we have to design 
something that will satisfy the greatest possible audience.

The point of this is that we need to forward the Xclient's SID to the Xserver, 
so it can enforce policy regarding one Xclient's access of another Xclient's 
resources, etc.  Russell's advocacy of X-tunneling via SSH does make it the 
easiest to implement within existing network infrastructures (along with the 
obligatory mapping of type codes between heterogenous client/server 
policies).  

>
> Anyway, the main point here is not cryptography, but authentication.
>

Yes and no.

Yes, it is about authentication in the sense that you want to launch an 
Xclient on some remote host.  You first have to authenticate yourself to the 
remote host before you can launch the client back to your workstation.  SSH 
makes that trivial, and which is why Russell is advocating it.

But once you've authenticated yourself to the remote host, cryptography does 
enter the picture because the Xclient's SID has to be encrypted for its trip 
to the Xserver, otherwise we risk "leaking" some of the remote host's policy 
knowledge over potentially untrusted networks.  And, as the developers we 
have to anticipate and prepare for the worst-case scenario.  That's why I'm 
pushing crypto.

>
> And authentication should be done by Xauthority, I think.
>

Actually, with the advent of SE-X Xauthority will largely relegate to a 
vestigal status:  It'll still be there, but it will have become superfluous 
and redundant.

>
> > As for labeled networking, requiring IPSEC is a difficult issue, many
> > people have deployed networks with other systems and are not in a hurry
> > to change.
>
> Yes, and even naked cipso/ripso are not a real option.
>

But, again, I'm not pushing IPSEC.  I'm pushing the idea of storing the 
encrypted SID in the IP Options field so that (1) each packet is 
unambiguously labeled with its creator's SID, and (2) we minimize the 
potential for spoofing via a hacked SSH.

>
> ____And here comes the important part:____
>
> Having labels communicated to the packet filter IS an option which can be
> relatively easily done, and can be used for communicating labels in a
> multitude of ways through nodes.
> Here are some scenarios which can be done if labels are translated to
> netfilter marks:
>
> 1. outgoing packets can be SNAT-ed to either some port ranges or source
> addresses based on label. In this way the other end can directly attach
> the appropriate label to the traffic with the existing capabilities.
>
> 2. same for routing decisions to always go through trusted paths.
>
> 3. my favourite multilevel network protocol is plain old http(s),
> with a X-security-level: or similar header. Wrap-in to this protocol
> is easily implementable, wrap-out is actually implemented by Zorp.
> We just need the labels, which can be picked up from the netfilter
> mark, or with mechanisms given in point 1.
>
> I guess that the main point is to have a way for the network mechanisms
> to attach the label to the outgoing traffic in a manner which can be
> handled by them by their usual habit.
>

The proposed label is an encrypted SELinux SID transmitted from the Xclient's 
machine to the SE-Xserver, so that policy enforcement by the SE-Xserver can 
be applied to all Xclients, both local and remote.  Inserting the label into 
the IP Options field is the most logical way of "piggybacking" the label with 
the packet it represents.

Since the label is encrypted at the point of origin all routers between the 
client and server won't/shouldn't be able to interpret it (apart from a 
rudimentary header).  And even if the label wasn't encrypted, the values 
themselves and their interpretation are not a network function but are 
internal to SELinux.

Therefore, why would the underlying network infrastructure be concerned with 
the label's contents, provided it doesn't violate applicable RFCs?

Bill


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
