Subject: Re: [PATCH] add selpolgen
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1169214598.22731.508.camel@moss-spartans.epoch.ncsc.mil>
References: <45ACEE9E.7000709@mentalrootkit.com>
	 <1169135113.22731.285.camel@moss-spartans.epoch.ncsc.mil>
	 <45AFD027.9070007@mentalrootkit.com>
	 <1169214598.22731.508.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 19 Jan 2007 11:09:39 -0500
Message-Id: <1169222979.22731.567.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-01-19 at 08:49 -0500, Stephen Smalley wrote:
> On Thu, 2007-01-18 at 14:53 -0500, Karl MacMillan wrote:
> > Stephen Smalley wrote:
> > > On Tue, 2007-01-16 at 10:26 -0500, Karl MacMillan wrote:
> > >> This is a patch (available for download because of size - see url below) 
> > >> to add a python library named selpolgen and a new version of audit2allow 
> > >> that uses this library. This is a minimally changed version of what I 
> > >> have been calling madison.
> > >>
> > >> I am submitting this for inclusion as part of the main selinux 
> > >> distribution. I believe that inclusion here will help make good policy 
> > >> generation tools develop sooner and give a common base for creating new 
> > >> tools.
> > >>
> > >> Questions:
> > >> * I have the library at the top-level of the project - like the C 
> > >> libraries. Is this the best location? What about the name?
> > > 
> > > The top-level location seems sane, but the naming and structure diverges
> > > from the C libraries (e.g. one might expect a libsepolgen with man,
> > > include, src, and tests subdirectories and ChangeLog, COPYING, Makefile,
> > > and VERSION files).
> > 
> > * libsepolgen would not match python practice (this is a module not a 
> > library in python terms). I don't feel strongly either way, though, and 
> > the new patch changes this libselgen (see below).
> 
> We can follow whatever practice is normal for python modules.  However,
> how are those usually packaged?  Separate from the application that uses
> them?  Or together?  As it stands, this module would become a dependency
> of audit2allow and thus of policycoreutils; is there any benefit to
> packaging it separately?

Or conversely, we could remove audit2allow from policycoreutils and put
it and this new python module into a single package.  It isn't as though
audit2allow is fundamental to system operation anyway.

> 
> > I was trying to use a name that described its use without confusing it 
> > with polgen. What about 'selgen'? Any other ideas (I'd really prefer a 
> > meaningful name).
> 
> Not sure that is any less prone to confusion than selpolgen, and it
> conveys less information about the purpose.  So I suppose selpolgen is
> acceptable. 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
