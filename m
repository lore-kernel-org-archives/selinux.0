Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9EN2hIm016202
	for <selinux@tycho.nsa.gov>; Sat, 14 Oct 2006 19:02:43 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9EN21Jh016647
	for <selinux@tycho.nsa.gov>; Sat, 14 Oct 2006 23:02:01 GMT
Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'James Morris'" <jmorris@namei.org>
Cc: "'Paul Moore'" <paul.moore@hp.com>, <selinux@tycho.nsa.gov>,
        "'Christopher J. PeBenito'" <cpebenito@tresys.com>,
        "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        "Joshua Brindle" <jbrindle@tresys.com>
Subject: RE: Denials from newest kernel
Date: Sat, 14 Oct 2006 18:01:19 -0500
Message-ID: <001c01c6efe4$a9d6b3c0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <Pine.LNX.4.64.0610141645190.18416@d.namei>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > First of all, the "understandability" problem we have been
> having has
> > to do with the following:
> >
> > 1. Naming: we just refuse to change the naming for some
> inexplicable reason.
>
> We are not renaming the SECMARK and CONNSECMARK kernel
> modules, which are
> already upstream, as well as the userland iptables code, and
> the existing
> packet labeling policy constructs.  Secmark works fine for
> normal users
> who are using internal labeling.

Ok. This is where we have a disconnect (I thought we understood this
implicitly a long time back, but since we haven't I will say this):

Secmark DOES NOT work fine for normal users who are using internal
labeling for the reason that it's scope is very narrow (socket Vs. packet)
with no controls for forwarded traffic. Now you may argue that that's what
it was designed for, but the fact still remains: it's NOT a comprehensive
(still talking internal labeling only) solution to the problem of packet
flow control on a modern "security-enhanced" OS. This everyone needs to
first
understand.

>
> Also, ss I've said before, 'secpoint' is an abstraction

It's NOT an abstraction. It is a replacement. Whereas in the secmark case
you were marking security contexts on packets, in the secpoint case, you
are specifying security contexts on "fine-grained flow-control points".
You see the difference?

> which
> IMHO does
> not increase understandability in the common case.  'secmark' is the
> security analog of 'mark' (i.e. the MARK and CONNMARK
> modules), and it is
> very simply understandable as "adding security marks to
> packets".

Which is the reason why I have been angling to get rid of "mark" from the
module name.

>  Thus,
> the packet class is also appropriate, as packets are real
> kernel objects
> which you can literally set a security marking on.

You can, but that's not the primary thing in the secpoint case where you
are instead labeling "fine-grained security/flow-control points".

>
> I think this idea of modifying secmarks when external
> labeling enabled is
> not the right solution.

I can understand why you would think so if you didn't see the
difference between secmark and secpoint.

>
> 1. If you want to use the skb to carry external labeling
> information, then
> you can do this internally by splitting the secmark field and
> assigning
> limits to the number of network labels to be used.

But in the secpoint case, there's no need to do this.

>
> 2. If you want to introduce policy to mediate flow between
> external and
> internal labeling, do so, but don't change the internal label.

There's no such thing as internal Vs. external in secpoint as
far as socket access to the packet is concerned. We use the most
appropriate label (the actual label the packet came in with or
in it's absence the label from the security point; how much more
intuitive can it get?)

IOW, in the terms you use above: the internal label (the security point
label in the new paradigm) is no longer significant once we "mediate flow"
between the external and internal (security point) labeling. IOW, the
internal
(aka secpoint) label has already served it's purpose once the mediation is
done.
The external label prevails like it should, since that's what the label of
the data is.

>
> It's not clear to me that you actually need (1) or (2).
>
> It's much simpler to just have two orthogonal labeling schemes.

As mentioned above, secmark is a good, narrowly focused mechanism that
perhaps has application in some niche areas, but it's not
a comprehensive mechanism. But it has certainly caused us to use it as a
stepping stone for secpoint.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
