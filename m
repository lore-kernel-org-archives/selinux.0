Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9AFkHgC019683
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 11:46:17 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9AFjbTb011354
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 15:45:38 GMT
Message-ID: <36282A1733C57546BE392885C0618592015CFE37@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Venkat Yekkirala
	 <vyekkirala@TrustedCS.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
Subject: RE: Denials from newest kernel
Date: Tue, 10 Oct 2006 11:45:56 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Thats what was intended, but that doesn't mean its the only solution.
> Netfilter is supposed to be flexible and works in many different ways,
> otherwise everyone would have similar firewalls.  The netfilter
> configuration currently provided by refpolicy provides the anticipated
> behavior on mainline kernels, the same as if it were done the 
> way James
> suggested.  What you're describing breaks the current behavior.

First of all, we are dealing with a different paradigm here (of security
points)
and any policy written to operate within that paradigm is naturally (perhaps
unfortunately) subject to the constraints as well.

Secondly, as to your contention that this breaks the current behavior,
it just happened that the policy was written to the paradigm current
as of the time it was written. For example, if that paradigm said "the
first label prevails", then the policy would have been done that way
(more restrictive followed by the catch-all).

In fact I view the constraints with the new paradigm  a blessing since
it has the effect of resulting in a very succinct policy since it
enforces a strict sequence of flow controls among the security point
domains when more than one apply to a packet.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
