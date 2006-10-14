Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9E115MG021646
	for <selinux@tycho.nsa.gov>; Fri, 13 Oct 2006 21:01:05 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9E0xjo6026941
	for <selinux@tycho.nsa.gov>; Sat, 14 Oct 2006 00:59:46 GMT
Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Paul Moore'" <paul.moore@hp.com>, <selinux@tycho.nsa.gov>
Cc: "'Christopher J. PeBenito'" <cpebenito@tresys.com>,
        "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        "Joshua Brindle" <jbrindle@tresys.com>
Subject: RE: Denials from newest kernel
Date: Fri, 13 Oct 2006 20:00:31 -0500
Message-ID: <001901c6ef2c$268afc00$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <45301640.4060407@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > What security goals can I express in the new paradigm that I can NOT
> > in the existing paradigm?
> > 
> > Answer: Flow controlling on forwarded traffic, localhost 
> traffic labeling.
> 
> This is something I have been thinking about a lot lately, 
> even before Venkat
> reponded with the above answer.  More specifically I've been 
> thinking about how
> we can accomplish those two security goals without causing as 
> much disruption as
> the secid patches have seem to have caused.  The goal of 
> combining all the
> different packet labeling mechanisms into the secmark field 
> is a noble one, but
> I think we just loose too much in the process

Can you specify what we are exactly loosing, if any, in the process?

> and I don't 
> think we gain enough
> to make it worthwhile.
> 
> At the risk of being dragged out into the street and shot for 
> suggesting
> something new at this stage

Don't bother about the stage we are at. This is open development, so one
should always feel free to come up with new ideas.

BTW, do I have your address correctly as: Carly Ave, Fiorina, CA 12345? :)
(Disclaimer: the above purely a joke)

> I would like to offer up this 
> rough idea for
> comments, it's not really a big change from the current secid 
> patches but I
> think it should help address a lot of the problems

Again I would very much like to see the particular problems
on the list that you are addressing here.

> that I 
> have seen on the list:
> 
> 1. The skb->secmark field should only be used for 
> local/netfilter packet
> labeling, neither labeled IPsec or NetLabel should ever 
> change it's value.

What specifically would we gain with NOT replacing the secmark?

Alternatively, what problems are we warding off here by NOT
replacing the secmark?

> 
> 2. Add a selinux_skb_flow_in() similar to what is done with 
> the current secid
> patches but do not change the skb->secmark value (see #1 
> above) and for each
> external packet label do a permission check similar to the following:
> 
>  avc_has_perm(extlbl_sid, skb->secmark, "packet", "flow_in");

Why repeat the check for "each" external label? The current proposal
(courtesy Paul Moore :)) determines ONE external label with NetLabel
overriding ipsec and performs the check once. We have already determined
that multiple external labels are redundant.

> 
> We could always swap SECINITSID_NETMSG in for the secmark is 
> it was not set
> similar to what the secid patches do now.  If there are no 
> external packet
> labels then there would be a simple "unlabeled" check similar 
> to the following:
> 
>  avc_has_perm(SECINITSID_UNLABELED, skb->secmark, "packet", 
> "flow_in");
> 
> 3. In selinuc_socket_sock_rcv_skb() we would have the usual 
> secmark check and if
> external labeling is in use a check similar to the following:
> 
>  avc_has_perm(extlbl_sid, sock_sid, sock_class, "recvfrom");

Again, more access checks (because you don't replace the secmark)
and so more policy.

> 
> 4. Add a selinux_skb_flow_out() similar to what is done with 
> the current secid
> patches but do not change the skb->secmark value (see #1 
> above) and if the
> packet is associated with a socket, i.e. skb->sk != NULL, do 
> a permission check
> similar to the following:
> 
>  avc_has_perm(skb->sk->sk_security->sid, nf_secid, "packet", 
> "flow_out");

This won't work in the corner cases such as icmp, timewait acks
and such where the sock coming with the skb is a proxy sock (not
a real one).

Also, I don't see the check for forwarded packets (on the way out)
here; did you mean to include it here like it happens in the secid
patches?

> 
> In addition, if there is an external label we would do a 
> permission similar to
> the following:
> 
>  avc_has_perm(extlbl_sid, nf_secid, "packet", "flow_out");

Why the additional check? If you leverage secmark like the secid
patches do, you would end up with one check instead of two.

> 
> The suggestions should address all of the packet flow control 
> issues in what I
> think is a reasonable manner.  However, they don't address 
> the localhost
> labeling issue,

They would, effortlessly, if you just let things go with the flow
with secmark. i.e., leverage secmark by letting it carry the
appropriate/socket label on the outbound.

> but honestly I think this is a completely 
> separate issue which
> we shouldn't let clutter up the packet flow issues.  NetLabel 
> works just fine
> over localhost and according to Venkat's email earlier this 
> week it looks like
> labeled IPsec could work over localhost as well, we just need 
> to do some testing.

All in all, the only significant thing I notice is that you don't
replace secmark. And I wonder why? What problems/issues does it ward off?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
