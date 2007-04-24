Subject: Re: [POLICYREP PATCH] Add generic iterators and a list data type
	to	libsepol
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: James Antill <jantill@redhat.com>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        selinux@tycho.nsa.gov
In-Reply-To: <1177364151.6398.9.camel@localhost.localdomain>
References: <20070420133430.9884.86379.stgit@localhost.localdomain>
	 <46291A98.2040003@tycho.nsa.gov>
	 <1177343326.26236.18.camel@localhost.localdomain>
	 <1177345688.20127.9.camel@code.and.org>
	 <1177350773.24282.63.camel@moss-spartans.epoch.ncsc.mil>
	 <1177364151.6398.9.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 24 Apr 2007 08:26:24 -0400
Message-Id: <1177417584.24282.115.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-04-23 at 17:35 -0400, Karl MacMillan wrote:
> On Mon, 2007-04-23 at 13:52 -0400, Stephen Smalley wrote:
> > On Mon, 2007-04-23 at 12:28 -0400, James Antill wrote:
> > > On Mon, 2007-04-23 at 11:48 -0400, Karl MacMillan wrote:
> > > 
> > > > Glib, on the other hand, would provide everything that we need. In fact,
> > > > gobject is a perfect fit for the policy object abstraction that I
> > > > created with many advantages (including support for exporting the
> > > > objects to other languages like python).
> > > > 
> > > > The Pros of using glib:
> > > > * All the data structures that we need.
> > > > * Better tested foundation.
> > > > * Safe string functions.
> > > > * Familiar environment for many developers.
> > > > * Complete object-oriented layer for the policy rep.
> > > > * Easy export to Python and other languages.
> > > > * Our code gets much smaller (libsemanage in particular could shrink if
> > > > we used glib).
> > > > 
> > > > The Cons:
> > > > * Large dependency.
> > > > * Potential security issues in glib (not certain this is a real issue,
> > > > but glib is fairly big).
> > > > * Glib tends to be slightly verbose and boilerplate heavy.
> > > 
> > >  I'm pretty sure glib is used in a few security relevant places, so I
> > > doubt that's a problem. The "dependency" argument just seems like normal
> > > C programmer twitchyness ... glib is at least as portable as what we'd
> > > use it in and is included in pretty much every distro.
> > > 
> > >  The only real problem I've ever had with glib is that calling g_new()
> > > calls abort() on failure (and by extension so does everything that
> > > allocates in glib).
> > >  This also tends to mean that glib code allocates much more freely than
> > > normal C code. But if you can swallow the allocation death pill, it's
> > > hard to argue against glib ... IMO.
> > 
> > I can't swallow the allocation death pill - how does one perform sane
> > cleanup with such behavior?
> 
> To be fair, in libsepol we currently just exist on allocation error.
> Yes, it's better than abort, but we don't really have a need to perform
> cleanup.
> 
> libsemanage is obviously different and I don't think the libsemanage
> dependency on libsepol is ever going to be removed.
> 
> >   However, looking around, I see you can
> > replace the allocator virtual table with your own functions and there
> > are g_try_* functions that return NULL rather than calling abort.  But
> > not clear that helps with its own internal usage of g_new.
> > 
> 
> This does help internal usage of g_new (verified by code inspection and
> experimentation). However, glib includes several custom allocators and
> replacing the allocator vtable did not seem to help there. It might be
> possible to track down all of the allocators and convince them not to
> abort, but there may be problems in the future. We could also try
> catching sigabort but there would be no good way to figure out why the
> abort was delivered. This is really frustrating and is causing people to
> not use glib (the X hackers rejected it over this reason).
> 
> Any other options (there don't seem to be any obvious ones)? Personally,
> I vote for the C++ STL but that requires a small change to which some
> might object. In summary - C sucks and I'm tired of this 1980s
> programming environment.

I think rolling our own (in C) is the only real option here.

Also, keep in mind that we will continue to have a /sbin/init ->
libsepol dependency for the purpose of downgrading policy versions, so
external dependencies do matter.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
