MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/2] userland support for new range_transition statements
Date: Mon, 7 Aug 2006 09:18:32 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158832ADAE@exchange.columbia.tresys.com>
In-Reply-To: <44D37216.8090902@trustedcs.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Darrel Goeddel" <dgoeddel@TrustedCS.com>
Cc: "SELinux List" <SELinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Eric Paris" <eparis@redhat.com>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Darrel Goeddel [mailto:dgoeddel@trustedcs.com] 
> > I think the string may be easiest.  Otherwise a list of structs
like:
> 
> struct mls_cat_component {
> 	int start;
> 	int stop;
> 	struct mls_cat_component *next;
> } mls_cat_component_t
> 
> could be used.  Where something like c0,c4,c10.c20,c25 would 
> be represented as:
> 
>    start=1
>    stop=1
>    next=......start=4
>               stop=4
>               next=......start=c10
>                          stop=c20
>                          next=......start=25
>                                     stop=25
>                                     next=NULL
>

Should start/stop be datum values or just pointers to the datum?

> I can play with working something up based on storing the 
> string rather than the mls_range_t just to see what it would 
> look like.  I'm not sure going with a more complicated 
> structure based method really buys us much.  If there are 
> other structure ideas - I'd sure like to investigate them.
> 
> BTW, sorry for the delay, I was unavailable yesterday...
> 

How likely is it that the mls component in the context will ever change?
There is an interesting benefit to making the mls component opaque to
the compiler and the module format (by storing a string) but it also
makes error checking harder. Then again, right now you can only do
syntactic checking anyway since we don't know the level/cat
configuration from a module.

One other thing, we need a require syntax for these things, we have been
using each symbol type so s1-s10:c0,c4,c10.c20 would look like

Require {
	sens s1, s10;
	cats c0, c4, c10, c20;
}

Which ensures the symbols are present but not that they make sense, we
have a similar problem with class requires since the permissions for the
class may not be there, the error must be handled at link time, likewise
this would also.

Another option we threw around when thinking about this problem was
using the entire component as the symbol:
Require {
	level s1-s10:c0,c4,c10.c20;
}

I'm not sure which is more appropriate, since MLS does not view each cat
as a separate entity the second one seems more within the model but it
isn't a real symbol in terms of the symbol tables (unless we turn it
into one)

I think the latter might be the best bet, the entire level could be a
symbol and the mls_range_rule_t (or whatever) would just have the value
of the level. Then at expand time the mls_range_rule_t gets converted
into an mls_range_t and the symbol is interpreted and checked for
validity.

I'm dubious about using the same symbol table to store sens (s1) and
levels (s1-s10:c0) but adding a new symtab that is missing in the kernel
format while the sens and cats are unused in the module format seems
silly. 

I'm also a little skeptical about having levels in this fashion at all,
categories are a local configuration and, in general, we've been pushing
local configurations to libsemanage. Granted policy modules have file
contexts with levels but they can still be overridden locally. I almost
think the policy modules need to be using symbolic names so that they
can be converted to the local system configuration, throwing translation
into the expander mix seems fairly non-ideal though, what are your
thoughts on this?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
