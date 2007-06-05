Subject: RE: SELinux userspace infrastructure language
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <1180975778.2862.36.camel@localhost.localdomain>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588BF01FF@exchange.columbia.tresys.com>
	 <1180633622.3534.78.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588BF0204@exchange.columbia.tresys.com>
	 <1180639909.22021.26.camel@localhost.localdomain>
	 <1180995888.9766.63.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588BF044D@exchange.columbia.tresys.com>
	 <1180975778.2862.36.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 05 Jun 2007 10:19:27 -0400
Message-Id: <1181053167.25769.38.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-06-04 at 12:49 -0400, Karl MacMillan wrote:
> On Mon, 2007-06-04 at 20:52 -0400, Joshua Brindle wrote:
> > Karl MacMillan wrote:
> > > This has basically convinced me that C++ is the way to go (or
> > > to put it another way - please, oh, please don't make me
> > > write any more C code).
> > > Thoughts?
> > > 
> > 
> > Great news :)
> > 
> 
> I assume that means you think this is the way to go? Steve - any
> thoughts?

I'm open to trying it.  Time to create a new branch for it?  So you
would introduce this new library, and prune libsepol down to only
dealing with the kernel policy representation?

Meanwhile, I suppose I should create a separate branch and replay the
setlocaldefs/preservebools changes into it, and we can do the namespace
work in that separate branch as well, separately from the policyrep
work.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
