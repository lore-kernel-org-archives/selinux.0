Subject: RE: [RFC 0/3] libsepol enforcement hooks for policy server
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158832AF50@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B0158832AF50@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 12:07:27 -0400
Message-Id: <1155226047.8018.20.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-08-09 at 18:50 -0400, Joshua Brindle wrote:
> > From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> > 
> > > 
> > 
> > I assume that this approach stems from the desire to enforce 
> > the results of the policy (the semantics) rather than the 
> > syntax. For example, you want to enforce _both_ the adding of 
> > an attribute to a type and the additional access that this generates.
> > 
> 
> As is the style in SELinux we'd like to do as many checks as possible,
> in this case we check both the syntactic (eg., adding an attribute to a
> type) and the semantic (an allow rule after expansion)
> 

I don't feel strongly about this.

> > Additionally the process adding the module does not have to 
> > have sufficient access to add everything in the policy - only 
> > the added elements.
> > 
> > These two decisions produce the bulk of your complexity: they 
> > require the extra expansion and diffing of the policies. 
> > Otherwise you could do a simple syntactic check of the module 
> > and only refer to the other policy to enforce symbol removal. 
> > I also think that the access removal checks are of 
> > questionable value (unlike the symbol removal checks) - who 
> > cares about DOS anyway?
> > 
> 
> Well, syntactic checking means walking each rule on the old policy
> avrule_decl list for each rule on the new policy, this is rediculously
> ineffecient, the purpose of the avtabs is for fast lookups, which is the
> reason we are using them. 
> 

Only if you want to detect changes to prevent the source type from
having to have permission to add all rules in the policy module. I think
that it is acceptable to simply require permission to add all rules.

> > So, I think that the syntactic check would be sufficient 
> > because the semantics of the syntax are clearly defined and 
> > can be taken into account by the meta-policy author. It would 
> > also _greatly_ reduce the complexity of enforcement.
> > 
> > My question: do you have examples where a well-crafted 
> > meta-policy could not successfully enforce policy access 
> > control doing only the checks that I am suggesting? My guess 
> > is that you are only going to get a reduction in granularity 
> > that is acceptable.
> > 
> 
> At this point I do not have well crafted examples, however I do not
> believe the object model will be complete and non-bypassable without
> semantic checking.
> 

I can't think of any bypass from only performing syntactic checks - I'd
be curious to hear a counter-example, but again I don't feel strongly.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
