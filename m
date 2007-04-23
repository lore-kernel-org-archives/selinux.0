Subject: Re: [POLICYREP PATCH] Add generic iterators and a list data type
	to	libsepol
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Antill <jantill@redhat.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <1177345688.20127.9.camel@code.and.org>
References: <20070420133430.9884.86379.stgit@localhost.localdomain>
	 <46291A98.2040003@tycho.nsa.gov>
	 <1177343326.26236.18.camel@localhost.localdomain>
	 <1177345688.20127.9.camel@code.and.org>
Content-Type: text/plain
Date: Mon, 23 Apr 2007 13:52:53 -0400
Message-Id: <1177350773.24282.63.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-04-23 at 12:28 -0400, James Antill wrote:
> On Mon, 2007-04-23 at 11:48 -0400, Karl MacMillan wrote:
> 
> > Glib, on the other hand, would provide everything that we need. In fact,
> > gobject is a perfect fit for the policy object abstraction that I
> > created with many advantages (including support for exporting the
> > objects to other languages like python).
> > 
> > The Pros of using glib:
> > * All the data structures that we need.
> > * Better tested foundation.
> > * Safe string functions.
> > * Familiar environment for many developers.
> > * Complete object-oriented layer for the policy rep.
> > * Easy export to Python and other languages.
> > * Our code gets much smaller (libsemanage in particular could shrink if
> > we used glib).
> > 
> > The Cons:
> > * Large dependency.
> > * Potential security issues in glib (not certain this is a real issue,
> > but glib is fairly big).
> > * Glib tends to be slightly verbose and boilerplate heavy.
> 
>  I'm pretty sure glib is used in a few security relevant places, so I
> doubt that's a problem. The "dependency" argument just seems like normal
> C programmer twitchyness ... glib is at least as portable as what we'd
> use it in and is included in pretty much every distro.
> 
>  The only real problem I've ever had with glib is that calling g_new()
> calls abort() on failure (and by extension so does everything that
> allocates in glib).
>  This also tends to mean that glib code allocates much more freely than
> normal C code. But if you can swallow the allocation death pill, it's
> hard to argue against glib ... IMO.

I can't swallow the allocation death pill - how does one perform sane
cleanup with such behavior?  However, looking around, I see you can
replace the allocator virtual table with your own functions and there
are g_try_* functions that return NULL rather than calling abort.  But
not clear that helps with its own internal usage of g_new.

David Wheeler's Secure Programming howto notes this behavior as a
problem for use of glib in most secure programs.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
