Subject: RE: SELinux userspace infrastructure language
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <1181133770.3699.26.camel@moss-spartans.epoch.ncsc.mil>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588BF01FF@exchange.columbia.tresys.com>
	 <1180633622.3534.78.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588BF0204@exchange.columbia.tresys.com>
	 <1180639909.22021.26.camel@localhost.localdomain>
	 <1180995888.9766.63.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588BF044D@exchange.columbia.tresys.com>
	 <1180975778.2862.36.camel@localhost.localdomain>
	 <1181053167.25769.38.camel@moss-spartans.epoch.ncsc.mil>
	 <1181056422.26965.6.camel@localhost.localdomain>
	 <1181133770.3699.26.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 10:51:15 -0400
Message-Id: <1181141475.12540.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-06-06 at 08:42 -0400, Stephen Smalley wrote:
> On Tue, 2007-06-05 at 11:13 -0400, Karl MacMillan wrote:
> > On Tue, 2007-06-05 at 10:19 -0400, Stephen Smalley wrote:
> > > On Mon, 2007-06-04 at 12:49 -0400, Karl MacMillan wrote:
> > > > On Mon, 2007-06-04 at 20:52 -0400, Joshua Brindle wrote:
> > > > > Karl MacMillan wrote:
> > > > > > This has basically convinced me that C++ is the way to go (or
> > > > > > to put it another way - please, oh, please don't make me
> > > > > > write any more C code).
> > > > > > Thoughts?
> > > > > > 
> > > > > 
> > > > > Great news :)
> > > > > 
> > > > 
> > > > I assume that means you think this is the way to go? Steve - any
> > > > thoughts?
> > > 
> > > I'm open to trying it.  Time to create a new branch for it?  So you
> > > would introduce this new library, and prune libsepol down to only
> > > dealing with the kernel policy representation?
> > > 
> > 
> > I think we could continue on the policyrep branch, just pruning libsepol
> > there.
> 
> Actually, I think I'd rather have a clean slate unless you think you'd
> be preserving any of the changes you've made to date in policyrep (vs.
> just reverting/removing all of that code from libsepol).  So I'd favor
> making a clean copy of trunk to a new branch for your new work, and
> another clean copy of trunk to a separate branch for the other changes.
> 

Unfortunately, I don't think any of the changes are needed - *sigh*. We
can do this when the first set of patches is ready.

> > > Meanwhile, I suppose I should create a separate branch and replay the
> > > setlocaldefs/preservebools changes into it, and we can do the namespace
> > > work in that separate branch as well, separately from the policyrep
> > > work.
> > > 
> > 
> > That's fine with me, though I guess it results in two ABI bumps for
> > libsepol.
> 
> Not necessarily; it depends on how/when we merge to trunk.  If the two
> development efforts turn out to "complete" in the same timeframe or we
> choose to hold merging of either until the other is "complete", then we
> can just merge the one branch to the other, and then merge the union to
> the trunk, only requiring a single ABI bump for the library.
> 

Sounds good - that way if this stupid policyrep work ends up on a debian
like release schedule we can still release something in a reasonable
time frame.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
