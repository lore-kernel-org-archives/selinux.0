Message-Id: <200603241724.k2OHOlNq024142@gotham.columbia.tresys.com>
From: "Kevin Carr" <kcarr@tresys.com>
To: <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, <SELinux-dev@tresys.com>
Subject: RE: [RFC][PATCH] extending the libsepol API
Date: Fri, 24 Mar 2006 12:24:47 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1143143894.28120.416.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Thu, 2006-03-23 at 14:23 -0500, Kevin Carr wrote:
> > Keys are not sufficient to help us with rule searches.  Imagine that we
> want
> > to find all the rules that have a certain subset of permissions.  The
> key
> > would have the source, target, and class right?  Thus we cannot
> construct a
> > key for what we want.  What we really need is a way to access all the
> rules
> > independent of some search criteria so that we can do complex rule
> matching
> > outside of libsepol.
> 
> For which you can use the sepol_<record>_iterate() interfaces, right?

We are concerned about short-term stability of API as you are, but we feel
that the long-term viability of the API is even more important.  Besides the
fact that the iterate callbacks are simply annoying to use, imagine a user
down the line wants a swig wrapper for libsepol.  Function pointers are a
bad idea to have in the API. 

> But that doesn't mean that no user of the library will want to use
> key-based interfaces for lookups, ala an encapsulated form of the
> avtab_search interface, or that we shouldn't provide such interfaces.

A key cannot be constructed for a rule that will return a single record.
The key would contain all parts of the rule.  This breaks the metaphor of
keys and records.  This is not a policy "database" with generic keys and
records, it is a concrete policy representation.

> > Yes, of course the user will have to know what type of object he's
> > accessing, this is the only thing that's ever different when using
> > iterators.
> 
> The actual processing that is occurring during the iteration is
> object-specific, so why is it a problem to have object-specific iterate
> APIs?
> 
> > I agree that SELinux needs to become more stable and I believe that is
> what
> > we are trying to do right now.
> 
> No, you don't understand.  There is a stable ABI for libsepol right now.
> You are suggesting deprecating a large chunk of it in favor of your own
> model.  The burden of proof that such deprecation is justified is on
> you, and it needs to be more than just "our proposed API is better
> suited to our particular needs".

We are concerned about the needs of a general purpose policy representation
library for SELinux.  This should represent the interests of the community.
We are in a unique position because we write analysis tools that inspect the
entire policy representation. In doing so, we have a very good idea about
what this API should contain.

> > a) I think the maintenance will be minimal.  An option might be to
> > re-implement the existing functions, by using the new ones.  Then just
> > maintaining the new ones would suffice indefinitely.  b) I don't think
> that
> > there is ever a reason to keep the functions in the library if no one is
> > using them, in that long-term case, they should be removed.  c) I don't
> > think this will cause any confusion to developers as anything that is
> > deprecated should be clearly marked as such, either in the documentation
> or
> > with attributes in the source.
> 
> Removing the interface once it has gone into a stable OS release (e.g.
> FC5) is very bad form.  And we have to plan that people developing for
> the next generation of distribution releases are looking at the current
> APIs as their basis.

As I said, reimplementing these functions with new ones will allow these
functions to continue working.  I understand that the ultimate decision
resides with the maintainer of libsepol, however it is important to express
that the issues with the current API will continue to plaque developers of
all tools that need a good representation library for SELinux.  Long-term
viability has to be considered.

Kevin Carr
Tresys Technology
410.290.1411 x137



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
