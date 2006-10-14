Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9EKfRcn013695
	for <selinux@tycho.nsa.gov>; Sat, 14 Oct 2006 16:41:27 -0400
Received: from mailhub.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9EKe7S0024066
	for <selinux@tycho.nsa.gov>; Sat, 14 Oct 2006 20:40:08 GMT
From: Paul Moore <paul.moore@hp.com>
To: vyekkirala@TrustedCS.com
Subject: Re: Denials from newest kernel
Date: Sat, 14 Oct 2006 16:41:18 -0400
Cc: selinux@tycho.nsa.gov, "'Christopher J. PeBenito'" <cpebenito@tresys.com>,
        "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        "Joshua Brindle" <jbrindle@tresys.com>
References: <001a01c6efc9$f2699af0$cc0a010a@tcssec.com>
In-Reply-To: <001a01c6efc9$f2699af0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610141641.19251.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 14 October 2006 3:50 pm, Venkat Yekkirala wrote:
> > > Can you specify what we are exactly loosing, if any, in the process?
> >
> > In one work, "understandability"
>
> First of all, the "understandability" problem we have been having has
> to do with the following:
>
> 1. Naming: we just refuse to change the naming for some inexplicable
> reason.

I'm sure James has his own opinions on this, but from my point of view there 
is just no point to it - it's a cosmetic issue.  If the name of a mechanism 
was truly the only problem it could be dealt with through documentation and 
education.

However, I think the real problem is that the secid reconciliation patches are 
a fundamental change in how the secmark field is used.  Other developers, 
policy writers, and users are going to expect it to behave a certain way - 
the way it was originally introduced - and any changes should be compatible 
with that original usage.

> 2. People not reading/studying examples and documentation posted.
> Specifically
>    the following.
> 	http://marc.theaimsgroup.com/?l=selinux&m=116039675620555&w=2
> 	http://marc.theaimsgroup.com/?l=selinux&m=115928609916717&w=2
>
> So, no point in messing with the design when the problem is with the
> naming and people's inertia/confusion with latching onto new paradigms
> particularly
> when a paradigm replaces an existing one (secmark as a way to mark packets
> Vs.
> secpoint as a way to specify fine grained security check points) while the
> naming has stayed the same (secmark).

Yes, yes, yes, that's all well and good - documentation is good, very good in 
fact, but the problem is the policy writers still seem to be having a 
difficult time doing anything useful with the secid changes and I just not 
certain there is going to be any real resolution at this point with the 
current approach.

> >  Sadly I know some people have just given up on the
> > whole discussion.
>
> Not that I am aware of. All the primary stake holders are either already
> on board or close to being so.

Okay - ask yourself this question: have any of the people working on the 
reference policy actually give an explicit "Yes, I like this approach" or did 
they simply stop responding?

> > > > 3. In selinuc_socket_sock_rcv_skb() we would have the usual
> > > > secmark check and if
> > > > external labeling is in use a check similar to the following:
> > > >
> > > >  avc_has_perm(extlbl_sid, sock_sid, sock_class, "recvfrom");
> > >
> > > Again, more access checks (because you don't replace the secmark)
> > > and so more policy.
> >
> > Perhaps, but I think it's policy that is easier to
> > understand, write, and live
> > with.
>
> But totally unnecessary considering the intuitive and straightforward way
> a packet comes to carry one domain.

If it really was as intuitive as you say why would Chris, Josh, and the other 
being have such a hard time with this?  Don't say it's because it's 
called "secmark" ...

> > > > 4. Add a selinux_skb_flow_out() similar to what is done with
> > > > the current secid
> > > > patches but do not change the skb->secmark value (see #1
> > > > above) and if the
> > > > packet is associated with a socket, i.e. skb->sk != NULL, do
> > > > a permission check
> > > > similar to the following:
> > > >
> > > >  avc_has_perm(skb->sk->sk_security->sid, nf_secid, "packet",
> > > > "flow_out");
> > >
> > > This won't work in the corner cases such as icmp, timewait acks
> > > and such where the sock coming with the skb is a proxy sock (not
> > > a real one).
> >
> > In the case where there is not a valid socket SID we just use
> > the unlabeled
> > SID.
>
> Won't work for MLS in the least and would be objectionable/dangerous for
> even
> a strict policy to be needing to let unlabeled stuff out.
>
> >  If the socket has the kernel's SID we can use that or
> > substitute the
> > unlabeled SID.  I guess I don't consider this too much of a
> > problem as those
> > particular packets don't really carry any user generated data
>
> Not necessarily. Look at IGMP.
>
> > so data flow
> > issue aren't really applicable here.  Regardless, using the
> > unlabeled SID or
> > the kernel SID better reflects the true nature of the
> > packet's contents.
>
> Not at all. icmp, timewaitack and such technically carry/indicate
> data at a particular lavel.

I guess I don't understand how an ICMP response is carrying user generated 
data?  Can you give an example?

> > > > The suggestions should address all of the packet flow control
> > > > issues in what I
> > > > think is a reasonable manner.  However, they don't address
> > > > the localhost
> > > > labeling issue,
> > >
> > > They would, effortlessly, if you just let things go with the flow
> > > with secmark. i.e., leverage secmark by letting it carry the
> > > appropriate/socket label on the outbound.
> >
> > While I agree it is tempting it would mean we would be
> > overloading the secmark
> > value which I don't think we should do
>
> It's not overloading since there isn't any undue change in semantics
> at the user level. Hence we call it "leveraging".

The secid patches change how the policy is written, therefore I still consider 
it overloading.  You can call it leveraging.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
