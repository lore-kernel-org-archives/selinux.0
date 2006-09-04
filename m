Subject: Re: ipsec and getpeercon()
From: Joshua Brindle <jbrindle@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, Joy Latten <latten@us.ibm.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <44F85481.80203@hp.com>
References: <36282A1733C57546BE392885C061859201512D0F@chaos.tcs.tcs-sec.com>
	 <1157124313.20971.27.camel@twoface.columbia.tresys.com>
	 <44F85481.80203@hp.com>
Content-Type: text/plain
Date: Mon, 04 Sep 2006 08:59:24 -0400
Message-Id: <1157374764.6716.14.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-01 at 11:40 -0400, Paul Moore wrote:
> Joshua Brindle wrote:
> > Hrm, am I right in understanding that the selinux context from one
> > machine is never sent over ipsec to the destination? 
> > 
> > What you talk about above (using static SA's which refer to different
> > contexts on each side) is doable but seems inconvenient and fragile
> > (multiple client domains talking to the same destination daemon using
> > lots of SA's that have to be managed).
> > 
> > One option (maybe) is to get racoon to send the context of the
> > connecting domain as part of the negotiation, this still requires lots
> > of SA's.
> > 
> > Another way is if I could have a local proxy that has a single SA to the
> > destination machine and can send an appropriate context in the AH or ESP
> > header (in the authentication data field? I don't now the ipsec spec at
> > all so I'm not sure if any of this is possible, please let me know if
> > not so I can start looking elsewhere).
> > 
> > Note that we may be sending contexts that aren't even valid on the local
> > machine, but would be valid on the destination machine. 
> > 
> > is any of this possible?
> 
> WARNING: *shameless* plug ahead, read at your own risk :)
> 
> NetLabel takes it's security context directly from the socket which is
> writing the data to the network, not from a separate source.  This
> allows for the dynamic context packet labeling I think you are looking
> for ... yes?
> 
> However, in the interest of full disclosure I should point out that
> currently NetLabel only supports the MLS label portion of the context
> but I plan on extending that in the future.  Also, NetLabel only offers
> packet labeling, not packet autentication or encryption like IPsec.
> However, NetLabel could be used in conjunction with regular IPsec
> without problems.  This would allow you a dynamically labeled, secure
> connection between two parties with as few SAs as you desire.
> 

Yes, I have considered NetLabel, contingent on it getting merged into
mainline and supporting full contexts. I've been looking in to the specs
and it looks like you are going to have to make an entirely new tag for
full contexts. This will eliminate its ability to communicate with tsol,
et al right? (unless you change the netlabel policy obviously, I mean by
default). 

It also looks like the tags currently use bitmaps (which is fair since
levels are better represented that way) but for full contexts we'd want
just a u32 right? (u32 is used in the sidtab so a machine can't have
more contexts than that active).

I'm just thinking out loud here.. are there plans at HP to support full
contexts or is this more of a 'someone might do this in the future and
it should work' thing?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
