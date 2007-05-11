Subject: Re: [RFC][PATCH] libselinux: Namespacing
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1178829062.24335.86.camel@localhost.localdomain>
References: <1178827922.3504.141.camel@moss-spartans.epoch.ncsc.mil>
	 <1178829062.24335.86.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 11 May 2007 08:37:42 -0400
Message-Id: <1178887062.3504.147.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-10 at 16:31 -0400, Karl MacMillan wrote:
> On Thu, 2007-05-10 at 16:12 -0400, Stephen Smalley wrote:
> > libselinux presently lacks proper namespacing of its functions.  This
> > patch is just for comment on an approach to gradually fixing that
> > problem, starting with just a trivial example for a single function.
> > The idea is to switch over the real function to being properly
> > namespaced, provide an alias under the old name in the symbol table for
> > binary compatibility, and make the old name a macro in the public
> > headers that expands to the new name so that source rebuilds against the
> > new library will start using the new name.  Then at some point in the
> > future, we drop the old name macro from the source API, forcing an
> > update to external sources to build against newer headers, while leaving
> > the alias present in the symbol table as long as we need compatibility
> > with existing binaries.  Thoughts?
> > 
> 
> Sounds good to me - will this impact the python bindings? If we do have
> to change the bindings we should take as an opportunity to fix the
> namespace issues there. For example, bo reason to have
> selinux.selinux_booleans_path - should be changed to
> selinux.booleans_path.

Yes, it would affect the python bindings too; not sure what needs to be
done there for backward compatibility.

We also have to decide what to do about functions that already have
their own prefix, like the security_ functions and the avc_ functions;
I'm inclined to leave those alone as already being adequately
namespaced.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
