Subject: Re: [POLICYREP PATCH] Add generic iterators and a list data type
	to	libsepol
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <46291A98.2040003@tycho.nsa.gov>
References: <20070420133430.9884.86379.stgit@localhost.localdomain>
	 <46291A98.2040003@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 23 Apr 2007 11:48:46 -0400
Message-Id: <1177343326.26236.18.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-04-20 at 15:55 -0400, Eamon Walsh wrote:
> Karl MacMillan wrote:
> > Add a generic iterator data structure and a linked-list implementation
> > based that uses the iterators to libsepol. Includes test cases for the
> > linked-list implementation.
> > 
> > This version is updated to remove improper use of void** based on comments 
> > from James Antill.
> > 
> > Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
> >
> 
> Is there no standard utility library out there that could provide these 
> things?  Glib?  APR?
> 

In the past, we had decided to not use external libraries because it
would pull in a fairly large library (like glib) close to the root of
the library dependency tree. If we maintain a complete split between
libsepol / libselinux then much of that concern seems to go away. It
also means that the extra dependency is only present on managed systems,
which doesn't make things worse for embedded.

APR seems aimed at a slightly different problem set (less data
structures, more system abstraction).

Glib, on the other hand, would provide everything that we need. In fact,
gobject is a perfect fit for the policy object abstraction that I
created with many advantages (including support for exporting the
objects to other languages like python).

The Pros of using glib:
* All the data structures that we need.
* Better tested foundation.
* Safe string functions.
* Familiar environment for many developers.
* Complete object-oriented layer for the policy rep.
* Easy export to Python and other languages.
* Our code gets much smaller (libsemanage in particular could shrink if
we used glib).

The Cons:
* Large dependency.
* Potential security issues in glib (not certain this is a real issue,
but glib is fairly big).
* Glib tends to be slightly verbose and boilerplate heavy.

So, if you ask me, I think we should start using glib in libsepol (and
eventually libsemanage). I can work up some code to see what the
policyrep stuff would look like based on glib if others think this is
worth exploring.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
