Subject: Re: policycoreutils patch for semanage/seobject.py
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1191594199.891.11.camel@moss-spartans.epoch.ncsc.mil>
References: <4703B5CA.7040309@redhat.com>
	 <1191594199.891.11.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 05 Oct 2007 10:35:37 -0400
Message-Id: <1191594937.891.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-10-05 at 10:23 -0400, Stephen Smalley wrote:
> On Wed, 2007-10-03 at 11:31 -0400, Daniel J Walsh wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > Patch implements handling of booleans via semanage
> > 
> > Adds display of local list.  So you can either show all booleans,
> > fcontext, ports or just your local modifications.
> > 
> > Implements a store command, so you can use semanage to manage
> > alternative stores.
> > 
> > Implements deleteall so you can remove all local customizations.
> > 
> > Add support for <<none>> as a context type for fcontext.
> 
> Thanks, merged, although I think we will want to eventually revisit the
> division of labor between semanage and libsemanage for
> interpreting/handling <<none>>.
> 
> Also, it seems like the deleteall method should be implemented for all
> relevant objects - seems useful for fcontext as well as boolean.
> 
> When would use you use setsebool -P vs. semanage boolean -m?

Actually, you don't appear to have fully implemented semanage boolean -m
support (value is never defined).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
