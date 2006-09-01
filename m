Subject: RE: ipsec and getpeercon()
From: Joshua Brindle <jbrindle@tresys.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joy Latten <latten@us.ibm.com>,
        selinux@tycho.nsa.gov, paul.moore@hp.com
In-Reply-To: <36282A1733C57546BE392885C061859201512D0F@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C061859201512D0F@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 11:25:13 -0400
Message-Id: <1157124313.20971.27.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-01 at 10:35 -0400, Venkat Yekkirala wrote:
> > I'd tentatively guess that the lack of any definition or rules
> > authorizing polmatch is causing the SAs to be left unlabeled.
> 
> It should have then returned the unlabeled context (if it were
> working correctly).
> 
> > 
> > But Joshua's point about needing to manually define spd entries per
> > context (at least per TE domain/type, even if using a MLS 
> > range), would
> > still hold, right?
> 
> In the most practical/intuitive sense, yes, you would want to define
> a unique spd entry for each domain you want to communicate. As for
> "expectation of what domain is on the otherside" like Joshua was
> wondering about, this could either be implicit (by using static SA's;
> spi 0x01 could refer to a_t on one machine and b_t on the other machine)
> or explicit (when using racoon to negotiate). In the latter case, a_t and
> b_t must exist on both machines or the negotiation will fail.
> 
> Also in theory, multiple domains can share a single spd domain (by
> polmatch'ing
> to the spd domain), with the secmark rules doing finer differentiation in
> conjunction with appropriate transition sid rules :).

Hrm, am I right in understanding that the selinux context from one
machine is never sent over ipsec to the destination? 

What you talk about above (using static SA's which refer to different
contexts on each side) is doable but seems inconvenient and fragile
(multiple client domains talking to the same destination daemon using
lots of SA's that have to be managed).

One option (maybe) is to get racoon to send the context of the
connecting domain as part of the negotiation, this still requires lots
of SA's.

Another way is if I could have a local proxy that has a single SA to the
destination machine and can send an appropriate context in the AH or ESP
header (in the authentication data field? I don't now the ipsec spec at
all so I'm not sure if any of this is possible, please let me know if
not so I can start looking elsewhere).

Note that we may be sending contexts that aren't even valid on the local
machine, but would be valid on the destination machine. 

is any of this possible?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
