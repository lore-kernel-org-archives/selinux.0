Subject: Re: [RFC 0/3] libsepol enforcement hooks for policy server
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Josh Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
In-Reply-To: <1154433100.23513.7.camel@twoface.columbia.tresys.com>
References: <1154433100.23513.7.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 17:44:18 -0400
Message-Id: <1155159858.942.103.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-01 at 07:51 -0400, Josh Brindle wrote:
> This is an RFC for libsepol enforcement hooks. These patches are to show
> the concept and will in no way compile, I've intentionally left out
> utility functions so that just the important parts are here to discuss.
> 

Thanks for sending this out for comment.

> The enforcement model has changed quite a bit. Rather than looping over
> the policydb inside the policy server as before these hooks will make
> calls back into the policy server if a decision is needed.

I think this is a good overall approach.

>  To decide
> whether a decision is needed we are essentially doing a semantic diff of
> the policies. The enforcer provides the 'other' or previous linked
> policy when initializing its hooks. When a callback is encountered
> hooks.c will determine if an equivalent rule or symbol is present in the
> other policy and if not call the callback. Only strings are passed into
> the callbacks.
> 

I assume that this approach stems from the desire to enforce the results
of the policy (the semantics) rather than the syntax. For example, you
want to enforce _both_ the adding of an attribute to a type and the
additional access that this generates.

Additionally the process adding the module does not have to have
sufficient access to add everything in the policy - only the added
elements.

These two decisions produce the bulk of your complexity: they require
the extra expansion and diffing of the policies. Otherwise you could do
a simple syntactic check of the module and only refer to the other
policy to enforce symbol removal. I also think that the access removal
checks are of questionable value (unlike the symbol removal checks) -
who cares about DOS anyway?

So, I think that the syntactic check would be sufficient because the
semantics of the syntax are clearly defined and can be taken into
account by the meta-policy author. It would also _greatly_ reduce the
complexity of enforcement.

My question: do you have examples where a well-crafted meta-policy could
not successfully enforce policy access control doing only the checks
that I am suggesting? My guess is that you are only going to get a
reduction in granularity that is acceptable.

> To accomplish the semantic diff there were significant changes to the
> compiler to 1) expand the 'other' policy fully including disabled rules
> and symbols (including conflicting rules) and 2) to expand the new
> policy fully to do checks but then not add the disabled rules. The
> disabled symbols must be added for value mapping but I push the disabled
> symbols on to the end of the values so that they can be removed without
> holes in the hashtable forming.
> 

If you decide that you must do the semantic checks, I think that it may
be possible to reduce some of the data structure changes you are making
for the expand. I'll put the suggestion in the relevant patch emails.

> A main concern I have about the current patches is that the security_ops
> struct is publically accessible by shared users of this library. This is
> obviously non-ideal because of abi compatibility. Anyone with better
> ideas of how to implement the callback system please speak up :)
> 

Are you certain that you don't want to restrict these to static users?

You can pad the struct so that you can add additional members in the
future, though this sucks.

I'll comment on some of the specifics of the other patches.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
