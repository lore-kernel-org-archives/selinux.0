From: Paul Moore <paul.moore@hp.com>
To: Kyle Moffett <kyle@moffetthome.net>
Subject: Re: MCS and default labels
Date: Wed, 30 Sep 2009 10:20:49 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, russell@coker.com.au,
        Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>,
        selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
References: <20090908055806.GA24297@myhost.felk.cvut.cz> <200909300919.35275.paul.moore@hp.com> <f73f7ab80909300649n785436b6nb15dc62d13713b2@mail.gmail.com>
In-Reply-To: <f73f7ab80909300649n785436b6nb15dc62d13713b2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <200909301020.50157.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 30 September 2009 09:49:51 am Kyle Moffett wrote:
> On Wed, Sep 30, 2009 at 09:19, Paul Moore <paul.moore@hp.com> wrote:
> > On Tuesday 29 September 2009 11:51:42 pm Kyle Moffett wrote:
> >>  (C)  Processes which are *not* s4 may communicate over the network
> >> only when protected by IPsec, and only if the IPsec connection is
> >> specifically negotiated using certificates/keys based on the level of
> >> the data being protected.
> >
> > I think the tricky part here is the "... certificates/keys based on the
> > level of the data ..." statement.  Is is sufficient to have one
> > certificate per host/node as long as you have one SA per label?
> 
> Unfortunately not.  Imagine that the device is some kind of network
> appliance, router, etc.  You would not want to reconfigure your
> storage server or router every time you add a new node.

True, but I don't follow how having one IKE phase-1 negotiation with a node 
(single certificate for the node) requires reconfiguration ... I suppose if 
you require a certificate per-label (which it appears you do) ...

> Beyond that, different data levels probably have different protection
> requirements.  For instance, say you have a physical network that is safe to
> transport "personal data" unprotected, but not  "trade secrets" (IE:
> the network itself is s0:c1):
> 
>   * When you send data between "s0" processes across the network, you
> would want to save CPU and enable better network debugging by just
> using AH (the data doesn't need protection against exposure, just
> against contamination).
> 
>   * When you send data between "trade secrets" (s0:c2) processes
> across the network, that *does* need protection, and so you would use
> ESP.

I understand that, I'm just fairly certain that it isn't possible with the 
current implementation.  I was asking about using the same/most-stringent 
IPsec configuration (AH/ESP, algorithms, key lengths, etc.) for the different 
labels as that is possible today.

> For a lot of government classified-data systems, there's a lot more
> levels than that, and some levels require different key-lengths or
> algorithms.  I'm afraid that for the purposes I am interested in, a
> separate root-CA per MLS level is really the only practical
> configuration.

Unfortunately, that last requirement is the show stopper for the current 
implementation.  While we generate per-label AH/ESP SAs, I am almost certain 
we do not generate a new phase-1 SA for each new AH/ESP SA (generally 
considered to be wasteful).

> Given that, I guess the question is, how hard would it be to modify
> racoon and/or the kernel to give me the behavior I want?

I think one of the biggest problems that you will have to overcome is that I 
believe racoon maps a single "secret" (PSK, certificate, etc.) to a single IP 
address; what you want to do will require multiple "secrets" per node and will 
require some rework of the racoon code.  The extent of the rework is not 
something I can scope with any certainty, but my guess would be that it is 
non-trivial.  The kernel modifications should be fairly trivial, if any are 
required, since userspace is responsible for IKE negotiation.

At this point I would encourage you to start thinking about alternative 
solutions to the problem but if the guard requirements are strict and explicit 
than I understand this may not be an option for you - in that case, I wish you 
the best of luck.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
