Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9EJpOOm012689
	for <selinux@tycho.nsa.gov>; Sat, 14 Oct 2006 15:51:24 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9EJnxS0017613
	for <selinux@tycho.nsa.gov>; Sat, 14 Oct 2006 19:50:01 GMT
Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Paul Moore'" <paul.moore@hp.com>
Cc: <selinux@tycho.nsa.gov>,
        "'Christopher J. PeBenito'" <cpebenito@tresys.com>,
        "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        "Joshua Brindle" <jbrindle@tresys.com>
Subject: RE: Denials from newest kernel
Date: Sat, 14 Oct 2006 14:50:05 -0500
Message-ID: <001a01c6efc9$f2699af0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200610140813.26473.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > Can you specify what we are exactly loosing, if any, in the process?
>
> In one work, "understandability"

First of all, the "understandability" problem we have been having has
to do with the following:

1. Naming: we just refuse to change the naming for some inexplicable reason.

2. People not reading/studying examples and documentation posted.
Specifically
   the following.
	http://marc.theaimsgroup.com/?l=selinux&m=116039675620555&w=2
	http://marc.theaimsgroup.com/?l=selinux&m=115928609916717&w=2

So, no point in messing with the design when the problem is with the
naming and people's inertia/confusion with latching onto new paradigms
particularly
when a paradigm replaces an existing one (secmark as a way to mark packets
Vs.
secpoint as a way to specify fine grained security check points) while the
naming has stayed the same (secmark).

> (yeah, I just made that word
> up but I think
> you get the idea).  From my point of view the number one
> problem with the
> current secid work is that is is very difficult for people to
> understand and
> use.  You've documented it, discussed it on the mailing lists
> for weeks now
> and still people can't quite come to grips with how it is all
> supposed to
> work.

See above.

>  Sadly I know some people have just given up on the
> whole discussion.

Not that I am aware of. All the primary stake holders are either already
on board or close to being so.

>
> I think if we ever want to make labeled networking usable for
> real people it
> needs to be much easier to understand and use than it is with
> the current
> secid patches.

And the key to it is to make the naming more intuitive and getting
people to pay attention to documentation.

>
> > > I would like to offer up this
> > > rough idea for
> > > comments, it's not really a big change from the current secid
> > > patches but I
> > > think it should help address a lot of the problems
> >
> > Again I would very much like to see the particular problems
> > on the list that you are addressing here.
>
> See my comments above, and the mailing lists for the past
> several weeks.
>
> > > that I
> > > have seen on the list:
> > >
> > > 1. The skb->secmark field should only be used for
> > > local/netfilter packet
> > > labeling, neither labeled IPsec or NetLabel should ever
> > > change it's value.
> >
> > What specifically would we gain with NOT replacing the secmark?
>
> Consistency: secmark would always be the local label no matter what.
>
> > Alternatively, what problems are we warding off here by NOT
> > replacing the secmark?
>
> Confusion by overloading the secmark value.

This is the least of the confusions we have ever faced with this.
People now understand that there's only one label a packet carries
and that's the external domain if there's one or in it's absence,
the default domain it acquires at the entry point. Very intuitive
and straightforward. No policy having to account for multiple access
checks on the same packet.

>
> > > 2. Add a selinux_skb_flow_in() similar to what is done with
> > > the current secid
> > > patches but do not change the skb->secmark value (see #1
> > > above) and for each
> > > external packet label do a permission check similar to
> the following:
> > >
> > >  avc_has_perm(extlbl_sid, skb->secmark, "packet", "flow_in");
> >
> > Why repeat the check for "each" external label? The current proposal
> > (courtesy Paul Moore :)) determines ONE external label with NetLabel
> > overriding ipsec and performs the check once. We have
> already determined
> > that multiple external labels are redundant.
>
> Okay so we consolidate/reconcile the external label like we do now.
>
> > > 3. In selinuc_socket_sock_rcv_skb() we would have the usual
> > > secmark check and if
> > > external labeling is in use a check similar to the following:
> > >
> > >  avc_has_perm(extlbl_sid, sock_sid, sock_class, "recvfrom");
> >
> > Again, more access checks (because you don't replace the secmark)
> > and so more policy.
>
> Perhaps, but I think it's policy that is easier to
> understand, write, and live
> with.

But totally unnecessary considering the intuitive and straightforward way
a packet comes to carry one domain.

>
> > > 4. Add a selinux_skb_flow_out() similar to what is done with
> > > the current secid
> > > patches but do not change the skb->secmark value (see #1
> > > above) and if the
> > > packet is associated with a socket, i.e. skb->sk != NULL, do
> > > a permission check
> > > similar to the following:
> > >
> > >  avc_has_perm(skb->sk->sk_security->sid, nf_secid, "packet",
> > > "flow_out");
> >
> > This won't work in the corner cases such as icmp, timewait acks
> > and such where the sock coming with the skb is a proxy sock (not
> > a real one).
>
> In the case where there is not a valid socket SID we just use
> the unlabeled
> SID.

Won't work for MLS in the least and would be objectionable/dangerous for
even
a strict policy to be needing to let unlabeled stuff out.

>  If the socket has the kernel's SID we can use that or
> substitute the
> unlabeled SID.  I guess I don't consider this too much of a
> problem as those
> particular packets don't really carry any user generated data

Not necessarily. Look at IGMP.

> so data flow
> issue aren't really applicable here.  Regardless, using the
> unlabeled SID or
> the kernel SID better reflects the true nature of the
> packet's contents.

Not at all. icmp, timewaitack and such technically carry/indicate
data at a particular lavel.

Besides, this whole socket thing is a mute discussion since secmark on
the outbound is anyway available for us to use before we hit netfilter.

>
> > Also, I don't see the check for forwarded packets (on the way out)
> > here; did you mean to include it here like it happens in the secid
> > patches?
>
> Yes, my mistake; the existing secid code for the flow_out() and
> postroute_last() functions are so similar I often only speak
> about one of
> them.
>
> > > In addition, if there is an external label we would do a
> > > permission similar to
> > > the following:
> > >
> > >  avc_has_perm(extlbl_sid, nf_secid, "packet", "flow_out");
> >
> > Why the additional check? If you leverage secmark like the secid
> > patches do, you would end up with one check instead of two.
>
> See all the comments above about the policy being hard to
> understand when the
> secmark value is overridden.

See all the comments above about how intuitive and straightforward is
the way we get to havce a single domain on a packet.

>
> > > The suggestions should address all of the packet flow control
> > > issues in what I
> > > think is a reasonable manner.  However, they don't address
> > > the localhost
> > > labeling issue,
> >
> > They would, effortlessly, if you just let things go with the flow
> > with secmark. i.e., leverage secmark by letting it carry the
> > appropriate/socket label on the outbound.
>
> While I agree it is tempting it would mean we would be
> overloading the secmark
> value which I don't think we should do

It's not overloading since there isn't any undue change in semantics
at the user level. Hence we call it "leveraging".

> (see point #1 in my
> original mail).
> It also has the nasty tendency of using localhost as a
> special case for
> labeled networking which could cause some unintended behavior.
>
> > > but honestly I think this is a completely
> > > separate issue which
> > > we shouldn't let clutter up the packet flow issues.  NetLabel
> > > works just fine
> > > over localhost and according to Venkat's email earlier this
> > > week it looks like
> > > labeled IPsec could work over localhost as well, we just need
> > > to do some testing.
> >
> > All in all, the only significant thing I notice is that you don't
> > replace secmark.
>
> That was the point I was trying to make; I think we can still
> achieve our
> packet flow control goals without reconciling all of the
> secids.

The reconciliation specific issue had long past been beaten on, with
resulting
refinements already incorporated into the design (such as a. no
reconciliation
between xfrm and NetLabel since they are redundant, b. no transitions,
etc.).
No need to resurrect a dead issue and create further confusion in people's
minds.

>  In fact I
> think we can do it in a way that is easier to understand if
> we *don't*
> reconcile the secids.

The way I see it: loss of significant functionality, and need for additional
policy for no real gain in understandability.

My goal here has been to provide a "comprehensive" yet easy to undestand
set of controls that will satisfy our network security goals for the
forseeable
future.
(Yes, I seem to have acquired a little bit of the marketing buzz from you:)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
