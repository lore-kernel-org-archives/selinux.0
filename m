Message-ID: <36282A1733C57546BE392885C061859201512D46@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joy Latten <latten@us.ibm.com>,
        selinux@tycho.nsa.gov, paul.moore@hp.com
Subject: RE: ipsec and getpeercon()
Date: Fri, 1 Sep 2006 11:49:07 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> 
> Hrm, am I right in understanding that the selinux context from one
> machine is never sent over ipsec to the destination? 

Not verbatim, but only in the form of the spi (such as 0x001)
along with the encrypted packets.

The security context string is used in the IKE negotiations
though (resulting in the spi(s)).

> 
> What you talk about above (using static SA's which refer to different
> contexts on each side) is doable but seems inconvenient and fragile
> (multiple client domains talking to the same destination daemon using
> lots of SA's that have to be managed).
> 
> One option (maybe) is to get racoon to send the context of the
> connecting domain as part of the negotiation, this still requires lots
> of SA's.

I am thinking about this as well. Rather than use the Type specified in
the SPD rule, we could use the one from the connecting domain. Should
only be a minor change code-wise.

This way you could have just a set of domains that "polmatch"
to a specific policy domain/Type, but they could all be using
unique SAs based on the context of the connecting domain.

> 
> Another way is if I could have a local proxy that has a 
> single SA to the
> destination machine and can send an appropriate context in 
> the AH or ESP
> header (in the authentication data field? I don't now the 
> ipsec spec at
> all so I'm not sure if any of this is possible, please let me know if
> not so I can start looking elsewhere).

Not feasible AFAIK. The spi is the only identifier that can
reasonably be leveraged like we do currently.

> 
> Note that we may be sending contexts that aren't even valid 
> on the local
> machine, but would be valid on the destination machine. 

Could you please elaborate on this (a practical scenario).

> 
> is any of this possible?
> 

Sounds like we are making some progress here. Thanks for the discussion.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
