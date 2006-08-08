Message-ID: <44D8A44F.9000509@trustedcs.com>
Date: Tue, 08 Aug 2006 09:48:47 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: [PATCH 2/2] userland support for new range_transition statements
References: <6FE441CD9F0C0C479F2D88F959B0158832ADAE@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158832ADAE@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
>>From: Darrel Goeddel [mailto:dgoeddel@trustedcs.com] 
>>
>>>I think the string may be easiest.  Otherwise a list of structs
> 
> like:
> 
>>struct mls_cat_component {
>>	int start;
>>	int stop;
>>	struct mls_cat_component *next;
>>} mls_cat_component_t
>>
>>could be used.  Where something like c0,c4,c10.c20,c25 would 
>>be represented as:
>>
>>   start=1
>>   stop=1
>>   next=......start=4
>>              stop=4
>>              next=......start=c10
>>                         stop=c20
>>                         next=......start=25
>>                                    stop=25
>>                                    next=NULL
>>
> 
> 
> Should start/stop be datum values or just pointers to the datum?

datum values - they would map to the values that are represented by the
"required" items.  So for the above context we would require the following
(as you stated below):

Require {
	sens s1, s10;
	cats c0, c4, c10, c20, c25;
}

Let's say that maps to the following datum values for the module:

s1=0, s10=1, c0=0, c4=1, c10=2, c20=3, c25=4

then the representation for the cats (in the module) would be:

   start=0
   stop=0
   next=......start=1
              stop=1
              next=......start=2
                         stop=3
                         next=......start=4
                                    stop=4
                                    next=NULL

Those datum values would need to be mapped to the "real" values when the
policy is linked to the base which contains the definitions like this:

s1=1, s10=10, c0=0, c4=4, c10=10, c20=20, c25=25

The representation for the modules when it is linked and expanded would
then turn out to be what I had originally (without the 'c's in the 3rd member -
that was a mistake...)

As you can see, this would require a lot more logic than just interpreting the
string at expand time.  Unless, I'm way off on this one - I still need to study
up on the linking...

<snip>

> How likely is it that the mls component in the context will ever change?

I'm not sure I follow you on this - are you asking about future format
changes for a context?  If so, I'd hope that it wouldn't ;)

> There is an interesting benefit to making the mls component opaque to
> the compiler and the module format (by storing a string) but it also
> makes error checking harder. Then again, right now you can only do
> syntactic checking anyway since we don't know the level/cat
> configuration from a module.

What is the interesting benefit?

> One other thing, we need a require syntax for these things, we have been
> using each symbol type so s1-s10:c0,c4,c10.c20 would look like
> 
> Require {
> 	sens s1, s10;
> 	cats c0, c4, c10, c20;
> }
> 
> Which ensures the symbols are present but not that they make sense, we
> have a similar problem with class requires since the permissions for the
> class may not be there, the error must be handled at link time, likewise
> this would also.

This is what I was thinking.

> Another option we threw around when thinking about this problem was
> using the entire component as the symbol:
> Require {
> 	level s1-s10:c0,c4,c10.c20;
> }
> 
> I'm not sure which is more appropriate, since MLS does not view each cat
> as a separate entity the second one seems more within the model but it
> isn't a real symbol in terms of the symbol tables (unless we turn it
> into one)
> 
> I think the latter might be the best bet, the entire level could be a
> symbol and the mls_range_rule_t (or whatever) would just have the value
> of the level. Then at expand time the mls_range_rule_t gets converted
> into an mls_range_t and the symbol is interpreted and checked for
> validity.

Wouldn't this mean that the base module would have to define every possible
combination of sensitivities and categories?  That would make things a bit
unmanageable.

> I'm dubious about using the same symbol table to store sens (s1) and
> levels (s1-s10:c0) but adding a new symtab that is missing in the kernel
> format while the sens and cats are unused in the module format seems
> silly. 
> 
> I'm also a little skeptical about having levels in this fashion at all,
> categories are a local configuration and, in general, we've been pushing
> local configurations to libsemanage. Granted policy modules have file
> contexts with levels but they can still be overridden locally. I almost
> think the policy modules need to be using symbolic names so that they
> can be converted to the local system configuration, throwing translation
> into the expander mix seems fairly non-ideal though, what are your
> thoughts on this?

I don't look at categories and sensitivities s local configuration at all -
they are a defined part of the policy.  A human-readable translation for
what the level means is a local configuration.  It is really the same story
for types - I can use security_t in my module, but I am making assumptions
about what security_t means in the base policy.  When I put s4:c0,c5,c100.c150
into a module, I am making the same assumptions.

As for putting the translations into the policy - that doesn't work out very
well.  I believe that we experimented with that a long time ago and found it
to be a complete nightmare.  IMO, the correct place for translations would be
at the level of a tool that would help create policy modules.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
