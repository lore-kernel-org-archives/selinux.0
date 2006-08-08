MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/2] userland support for new range_transition statements
Date: Tue, 8 Aug 2006 18:45:43 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158832AE66@exchange.columbia.tresys.com>
In-Reply-To: <44D8A44F.9000509@trustedcs.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Darrel Goeddel" <dgoeddel@TrustedCS.com>
Cc: "SELinux List" <SELinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Eric Paris" <eparis@redhat.com>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Darrel Goeddel [mailto:dgoeddel@trustedcs.com] 
> 
> Joshua Brindle wrote:
> > 
> > Should start/stop be datum values or just pointers to the datum?
> 
> datum values - they would map to the values that are 
> represented by the "required" items.  So for the above 
> context we would require the following (as you stated below):
> 

right

> 
> The representation for the modules when it is linked and 
> expanded would then turn out to be what I had originally 
> (without the 'c's in the 3rd member - that was a mistake...)
> 
> As you can see, this would require a lot more logic than just 
> interpreting the string at expand time.  Unless, I'm way off 
> on this one - I still need to study up on the linking...
> 

It's a little more logic but pretty much the same thing we have to do
everywhere else. 

> <snip>
> 
> 
> > There is an interesting benefit to making the mls component 
> opaque to 
> > the compiler and the module format (by storing a string) 
> but it also 
> > makes error checking harder. Then again, right now you can only do 
> > syntactic checking anyway since we don't know the level/cat 
> > configuration from a module.
> 
> What is the interesting benefit?
> 

The benefit is that if the mls context structure ever changes the format
won't, only the expander will have to be changed to deal with it. This
might not be compelling since you indicate it'll never happen

> > 
> > I think the latter might be the best bet, the entire level 
> could be a 
> > symbol and the mls_range_rule_t (or whatever) would just have the 
> > value of the level. Then at expand time the mls_range_rule_t gets 
> > converted into an mls_range_t and the symbol is interpreted and 
> > checked for validity.
> 
> Wouldn't this mean that the base module would have to define 
> every possible combination of sensitivities and categories?  
> That would make things a bit unmanageable.

No, the required range would be interpreted the same way that any other
range is. Every complete range used within a module (or optional block)
would have to be required though, but I'm not sure how big of a deal
that is, how many different combinations are typically used? Now that
users aren't even put in the policy for different mls ranges I assume it
is very few.

> I don't look at categories and sensitivities s local 
> configuration at all - they are a defined part of the policy. 
>  A human-readable translation for what the level means is a 
> local configuration.  It is really the same story for types - 
> I can use security_t in my module, but I am making 
> assumptions about what security_t means in the base policy.  
> When I put s4:c0,c5,c100.c150 into a module, I am making the 
> same assumptions.
> 

Not sure about this, SystemHigh is not the same on every system, how
does a module reconcile that? You are right about the typespace which is
something we want to address, refpolicy interfaces introduced
encapsulation where modules don't know about other modules types,
unfortunately since its all compile time now the encapsulation isn't
enforced but interfaces in the language would be able to do that.

> As for putting the translations into the policy - that 
> doesn't work out very well.  I believe that we experimented 
> with that a long time ago and found it to be a complete 
> nightmare.  IMO, the correct place for translations would be 
> at the level of a tool that would help create policy modules.
> 

I understand that, I'm just wondering how one could ever distribute a
module with any mls range to different sites. If everyone is using
refpolicy the types are known to be the same, that isn't the case with
sensitivities and categories since they truly are a local configuration
via the translations.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
