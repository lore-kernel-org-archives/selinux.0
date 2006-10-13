Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9DMg9Cv018763
	for <selinux@tycho.nsa.gov>; Fri, 13 Oct 2006 18:42:09 -0400
Received: from atlrel6.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9DMeoo6008805
	for <selinux@tycho.nsa.gov>; Fri, 13 Oct 2006 22:40:50 GMT
Message-ID: <45301640.4060407@hp.com>
Date: Fri, 13 Oct 2006 18:42:08 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Cc: vyekkirala@TrustedCS.com,
        "'Christopher J. PeBenito'" <cpebenito@tresys.com>,
        "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: Denials from newest kernel
References: <001501c6ee39$dd9cb8a0$cc0a010a@tcssec.com>
In-Reply-To: <001501c6ee39$dd9cb8a0$cc0a010a@tcssec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> What security goals can I express in the new paradigm that I can NOT
> in the existing paradigm?
> 
> Answer: Flow controlling on forwarded traffic, localhost traffic labeling.

This is something I have been thinking about a lot lately, even before Venkat
reponded with the above answer.  More specifically I've been thinking about how
we can accomplish those two security goals without causing as much disruption as
the secid patches have seem to have caused.  The goal of combining all the
different packet labeling mechanisms into the secmark field is a noble one, but
I think we just loose too much in the process and I don't think we gain enough
to make it worthwhile.

At the risk of being dragged out into the street and shot for suggesting
something new at this stage I would like to offer up this rough idea for
comments, it's not really a big change from the current secid patches but I
think it should help address a lot of the problems that I have seen on the list:

1. The skb->secmark field should only be used for local/netfilter packet
labeling, neither labeled IPsec or NetLabel should ever change it's value.

2. Add a selinux_skb_flow_in() similar to what is done with the current secid
patches but do not change the skb->secmark value (see #1 above) and for each
external packet label do a permission check similar to the following:

 avc_has_perm(extlbl_sid, skb->secmark, "packet", "flow_in");

We could always swap SECINITSID_NETMSG in for the secmark is it was not set
similar to what the secid patches do now.  If there are no external packet
labels then there would be a simple "unlabeled" check similar to the following:

 avc_has_perm(SECINITSID_UNLABELED, skb->secmark, "packet", "flow_in");

3. In selinuc_socket_sock_rcv_skb() we would have the usual secmark check and if
external labeling is in use a check similar to the following:

 avc_has_perm(extlbl_sid, sock_sid, sock_class, "recvfrom");

4. Add a selinux_skb_flow_out() similar to what is done with the current secid
patches but do not change the skb->secmark value (see #1 above) and if the
packet is associated with a socket, i.e. skb->sk != NULL, do a permission check
similar to the following:

 avc_has_perm(skb->sk->sk_security->sid, nf_secid, "packet", "flow_out");

In addition, if there is an external label we would do a permission similar to
the following:

 avc_has_perm(extlbl_sid, nf_secid, "packet", "flow_out");

The suggestions should address all of the packet flow control issues in what I
think is a reasonable manner.  However, they don't address the localhost
labeling issue, but honestly I think this is a completely separate issue which
we shouldn't let clutter up the packet flow issues.  NetLabel works just fine
over localhost and according to Venkat's email earlier this week it looks like
labeled IPsec could work over localhost as well, we just need to do some testing.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
