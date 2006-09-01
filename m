Message-ID: <36282A1733C57546BE392885C061859201512DB6@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>, Joy Latten <latten@us.ibm.com>,
        selinux@tycho.nsa.gov, paul.moore@hp.com
Subject: RE: ipsec and getpeercon()
Date: Fri, 1 Sep 2006 15:41:21 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > I am thinking about this as well. Rather than use the Type 
> specified in
> > the SPD rule, we could use the one from the connecting 
> domain. Should
> > only be a minor change code-wise.
> 
> In that case, can we just use the sender's context as a whole for the
> SA, and not derive a context from some combination of the 
> sender and the
> policy context?  Then we could even drop in a single spd entry that
> matches all contexts and still get per-context SAs.

Offhand I don't see why not. I will try this and post a patch next week.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
