Subject: Re: MCS and default labels
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1252930803.13634.1002.camel@moss-pluto.epoch.ncsc.mil>
References: <20090908055806.GA24297@myhost.felk.cvut.cz>
	 <1252424128.13634.404.camel@moss-pluto.epoch.ncsc.mil>
	 <20090908163628.GC24297@myhost.felk.cvut.cz>
	 <1252429805.13634.423.camel@moss-pluto.epoch.ncsc.mil>
	 <20090909100647.GE24297@myhost.felk.cvut.cz>
	 <1252498660.13634.618.camel@moss-pluto.epoch.ncsc.mil>
	 <20090914081910.GL24297@myhost.felk.cvut.cz>
	 <1252930803.13634.1002.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 14 Sep 2009 09:00:29 -0400
Message-Id: <1252933229.13634.1009.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-09-14 at 08:20 -0400, Stephen Smalley wrote:
> On Mon, 2009-09-14 at 10:19 +0200, Michal Svoboda wrote:
> > Stephen Smalley wrote:
> > > The kernel MLS logic lives in security/selinux/ss/mls.c.  Determining
> > > the MLS level of a new subject or object is handled by
> > > mls_compute_sid().  Any change would have to support either model
> > > (inherit from source context or inherit from target context), so
> > > logically it would be policy-driven.  Which likely means an extension to
> > > the policy language and compiler.  Not an entirely trivial undertaking.
> > 
> > I have looked at the source code and it seems that in the said function
> > mls_compute_sid(), under the "case AVTAB_CHANGE:" and in the "else" path
> > (tclass != SECCLASS_PROCESS) the statement
> > 
> > mls_context_cpy_low(newcontext, scontext)
> > 
> > would need to be changed to
> > 
> > mls_context_cpy(newcontext, tcontext).
> > 
> > To support the original behavior, I would add a 1/0 readable/writable
> > file to selinuxfs, say "mls_defcontext_inherit" by mimicking the
> > behavior of the "enforce" file and its associated r/w functions. It
> > seems to me that this would suffice enough and it would avoid the need
> > to modify the policy language.
> > 
> > Would this change be acceptable?
> 
> I don't think so - the problem with selinuxfs tunables is that they
> can't be changed atomically with a policy change, and this is a property
> that should be tied to a particular policy.  For the same reason,
> properties like handle_unknown and permissive domains are defined in the
> policy itself rather than being selinuxfs tunables.

Also, in your situation, I don't think you want to change the
AVTAB_CHANGE behavior but only the AVTAB_TRANSITION behavior.  Thus
you'd need to change that logic to replicate the AVTAB_CHANGE logic
under AVTAB_TRANSITION (and no longer fall through), and then change the
copy under AVTAB_TRANSITION, so that you wouldn't affect the
AVTAB_CHANGE behavior.

AVTAB_CHANGE is exercised when relabeling the tty/pty at login time to
match the user's credentials, and there you do not want to stay with the
current object level but rather use the process' level even for your
usage.

AVTAB_TRANSITION is exercised when creating a new subject or object.
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
