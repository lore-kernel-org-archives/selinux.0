MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC 0/3] libsepol enforcement hooks for policy server
Date: Wed, 9 Aug 2006 18:50:17 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158832AF50@exchange.columbia.tresys.com>
In-Reply-To: <1155159858.942.103.camel@localhost.localdomain>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: <selinux@tycho.nsa.gov>, <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> 
> > 
> 
> I assume that this approach stems from the desire to enforce 
> the results of the policy (the semantics) rather than the 
> syntax. For example, you want to enforce _both_ the adding of 
> an attribute to a type and the additional access that this generates.
> 

As is the style in SELinux we'd like to do as many checks as possible,
in this case we check both the syntactic (eg., adding an attribute to a
type) and the semantic (an allow rule after expansion)

> Additionally the process adding the module does not have to 
> have sufficient access to add everything in the policy - only 
> the added elements.
> 
> These two decisions produce the bulk of your complexity: they 
> require the extra expansion and diffing of the policies. 
> Otherwise you could do a simple syntactic check of the module 
> and only refer to the other policy to enforce symbol removal. 
> I also think that the access removal checks are of 
> questionable value (unlike the symbol removal checks) - who 
> cares about DOS anyway?
> 

Well, syntactic checking means walking each rule on the old policy
avrule_decl list for each rule on the new policy, this is rediculously
ineffecient, the purpose of the avtabs is for fast lookups, which is the
reason we are using them. 

> So, I think that the syntactic check would be sufficient 
> because the semantics of the syntax are clearly defined and 
> can be taken into account by the meta-policy author. It would 
> also _greatly_ reduce the complexity of enforcement.
> 
> My question: do you have examples where a well-crafted 
> meta-policy could not successfully enforce policy access 
> control doing only the checks that I am suggesting? My guess 
> is that you are only going to get a reduction in granularity 
> that is acceptable.
> 

At this point I do not have well crafted examples, however I do not
believe the object model will be complete and non-bypassable without
semantic checking.

> > A main concern I have about the current patches is that the 
> > security_ops struct is publically accessible by shared 
> users of this 
> > library. This is obviously non-ideal because of abi compatibility. 
> > Anyone with better ideas of how to implement the callback system 
> > please speak up :)
> > 
> 
> Are you certain that you don't want to restrict these to static users?
> 

I'd like it to be available to shared users.

> You can pad the struct so that you can add additional members 
> in the future, though this sucks.
> 

Right, or add accessors for every field, which also sucks.

> I'll comment on some of the specifics of the other patches.
> 

Thanks


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
