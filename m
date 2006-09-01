Subject: RE: ipsec and getpeercon()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, Joy Latten <latten@us.ibm.com>,
        selinux@tycho.nsa.gov, paul.moore@hp.com
In-Reply-To: <36282A1733C57546BE392885C061859201512D46@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C061859201512D46@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 12:52:14 -0400
Message-Id: <1157129534.26621.197.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-01 at 11:49 -0400, Venkat Yekkirala wrote:
> > 
> > Hrm, am I right in understanding that the selinux context from one
> > machine is never sent over ipsec to the destination? 
> 
> Not verbatim, but only in the form of the spi (such as 0x001)
> along with the encrypted packets.
> 
> The security context string is used in the IKE negotiations
> though (resulting in the spi(s)).
> 
> > 
> > What you talk about above (using static SA's which refer to different
> > contexts on each side) is doable but seems inconvenient and fragile
> > (multiple client domains talking to the same destination daemon using
> > lots of SA's that have to be managed).
> > 
> > One option (maybe) is to get racoon to send the context of the
> > connecting domain as part of the negotiation, this still requires lots
> > of SA's.
> 
> I am thinking about this as well. Rather than use the Type specified in
> the SPD rule, we could use the one from the connecting domain. Should
> only be a minor change code-wise.

In that case, can we just use the sender's context as a whole for the
SA, and not derive a context from some combination of the sender and the
policy context?  Then we could even drop in a single spd entry that
matches all contexts and still get per-context SAs.

> 
> This way you could have just a set of domains that "polmatch"
> to a specific policy domain/Type, but they could all be using
> unique SAs based on the context of the connecting domain.


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
