Message-ID: <36282A1733C57546BE392885C061859201512D0F@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>, Joy Latten <latten@us.ibm.com>,
        selinux@tycho.nsa.gov, paul.moore@hp.com
Subject: RE: ipsec and getpeercon()
Date: Fri, 1 Sep 2006 10:35:36 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I'd tentatively guess that the lack of any definition or rules
> authorizing polmatch is causing the SAs to be left unlabeled.

It should have then returned the unlabeled context (if it were
working correctly).

> 
> But Joshua's point about needing to manually define spd entries per
> context (at least per TE domain/type, even if using a MLS 
> range), would
> still hold, right?

In the most practical/intuitive sense, yes, you would want to define
a unique spd entry for each domain you want to communicate. As for
"expectation of what domain is on the otherside" like Joshua was
wondering about, this could either be implicit (by using static SA's;
spi 0x01 could refer to a_t on one machine and b_t on the other machine)
or explicit (when using racoon to negotiate). In the latter case, a_t and
b_t must exist on both machines or the negotiation will fail.

Also in theory, multiple domains can share a single spd domain (by
polmatch'ing
to the spd domain), with the secmark rules doing finer differentiation in
conjunction with appropriate transition sid rules :).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
