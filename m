Subject: RE: SELinux userspace infrastructure language
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588BF0507@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588BF01FF@exchange.columbia.tresys.com>
	 <1180633622.3534.78.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588BF0204@exchange.columbia.tresys.com>
	 <1180639909.22021.26.camel@localhost.localdomain>
	 <1180995888.9766.63.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588BF044D@exchange.columbia.tresys.com>
	 <1180975778.2862.36.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588BF0507@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 10:48:57 -0400
Message-Id: <1181141337.12540.16.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-06-05 at 19:18 -0400, Joshua Brindle wrote:
> Karl MacMillan wrote:
> > On Mon, 2007-06-04 at 20:52 -0400, Joshua Brindle wrote:
> >> Karl MacMillan wrote:
> >> <snip>
> 
> > [...]
> > 
> >>> diff -r 83885c13a34d libpolicyrep/include/policyrep/policy.hpp
> >>> --- a/libpolicyrep/include/policyrep/policy.hpp       Mon Jun 04
> >>> 13:24:11 2007 -0400 +++ b/libpolicyrep/include/policyrep/policy.hpp
> >>> Mon 
> >> Jun
> >> 04
> >> 
> 
> One thing is that I thought you going to separate classes of object into
> their own files (eg., types.cpp, users.cpp, etc) since you had always
> complained about them being munged together in libsepol.
> 

You've got that backwards - I've always complained about too many
headers in libsepol (two per object).

> >> So this is exported and stable? We never previously exported the
> >> policydb, is this intentional?
> >> 
> > 
> > Not yet - but I intend this to be stable. That is one of the
> > things we need to consider - C++ is not the best for ABI
> > compatibility. I think we can make reasonable API/ABI
> > guarantees for stable versions while still making more
> > changes than we make to libselinux/libsepol (since it will be
> > selinux tools linking to this library I think they will be
> > more tolerant to changes).
> > 
> 
> I worry about making the whole policy structure public instead of just
> the public parts, maybe this isn't something you can do in c++?
> 

Not certain what you mean - you mean the private variables? You can use
the PIMPL idiom - http://www.codepedia.com/1/CppPimpl - but I'm not
convinced it's worth the pain. After the care we took to hide
implementation in libsepol we didn't really make changes that would have
broken in the ABI.

> > [...]
> > 
> > 
> >>> +        std::ostream& operator<<(std::ostream& o, const Node& n); +
> >> 
> >> Are you overloading the << operator? I thought we weren't going to
> >> overload operators. 
> >> 
> > 
> > Overloading << is pretty much required for efficient use of
> > streams. It allows you to do:
> > 
> > policyrep::Type t;
> > std::cout << t << std::endl;
> > 
> > I'm not really a fan of operator overloading in general, but
> > in this case I think it is worthwhile. And because of the
> > friend function hack in the base class we only need to do it
> > in on place - the subclasses simply override the virtual
> > function "output".
> > 
> 
> Hrm, so these aren't included in the elusive "stuff we shouldn't do in
> c++" list?
> 

Nope - this is _very_ standard for C++. Not doing this would be like
avoiding printf.

> > <snip>
> > comparison of unsigned expression < 0 is always false
> 
> Ew.

Yep.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
