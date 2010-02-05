From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: MLS and network
Date: Fri, 5 Feb 2010 15:18:21 -0500
Cc: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>, selinux@tycho.nsa.gov
References: <20100204174901.GL1750@myhost.felk.cvut.cz> <20100205051921.GM1750@myhost.felk.cvut.cz> <1265378086.18100.33.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1265378086.18100.33.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201002051518.21701.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 05 February 2010 08:54:46 am Stephen Smalley wrote:
> On Fri, 2010-02-05 at 06:19 +0100, Michal Svoboda wrote:
> > Stephen Smalley wrote:
> > > If you want network enforcement, you need to configure labeled
> > > networking - that isn't enabled by default.
> >
> > Thanks. I have two more questions. First, why does MLS require this, but
> > for TE it is sufficient to have labeled ports? And second, I have
> > managed to label my network to s0, but still, if I try to connect as s1
> > user, the outbound connection gets through, only the response (ie.
> > syn/ack) is denied. This still violates BLP; is this a matter of how the
> > refpolicy is set up?
> 
> (cc'd the labeled networking maintainer)
> 
> 1) Regardless of security policy model (TE or MLS), the newer networking
> checks (peer send/recv, netif egress/ingress, node recvfrom/sendto) were
> made conditional on configuration of labeled networking to minimize
> performance overhead and ensure backward compatibility for users who
> have no interest in network enforcement.

...

> Paul, am I missing anything above?

You explained it pretty well.  The only thing I might add (I was just asked 
about this yesterday, so I thought I would mention it again) is that while we 
have a peer:recv permission we don't have a peer:send permission.  Why?  Well, 
the peer:recv permission is present to allow us to control the level of the 
peer traffic a given socket is allowed to receive, i.e. a socket created at s0 
can not receive s1 labeled traffic.  If you flip this around for the send 
side, i.e. the mysterious peer:send permission, you would want the permission 
to control the level of the traffic an application could write to a give 
socket - which we already have through the other socket/FD access controls so 
adding a new peer:send permission would be redundant.  If you want to control 
what traffic is allowed out of a specific interface you want the netif:egress 
permission, that is what it is intended to do.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
