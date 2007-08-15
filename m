Subject: RE: [patch 0/4] libsemanage: genhomedircon replacement
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>, Todd Miller <tmiller@tresys.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <1187209889.20485.138.camel@moss-spartans.epoch.ncsc.mil>
References: <20070815204411.705994826@tresys.com>
	 <1187190639.2674.51.camel@localhost.localdomain>
	 <46C31BD0.5060200@tresys.com>
	 <1187192832.2674.74.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588EDEB74@exchange.columbia.tresys.com>
	 <1187198560.20485.45.camel@moss-spartans.epoch.ncsc.mil>
	 <1187205378.2838.12.camel@localhost.localdomain>
	 <1187207793.20485.103.camel@moss-spartans.epoch.ncsc.mil>
	 <1187209022.2838.38.camel@localhost.localdomain>
	 <1187209889.20485.138.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 15 Aug 2007 16:41:44 -0400
Message-Id: <1187210504.2838.56.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-15 at 16:31 -0400, Stephen Smalley wrote:
> On Wed, 2007-08-15 at 16:17 -0400, Karl MacMillan wrote:
> > On Wed, 2007-08-15 at 15:56 -0400, Stephen Smalley wrote:

[...]

> > > By remove/merge, do you mean just use the Linux username as the SELinux
> > > user identity, like we used to do before seusers?  You can even do that
> > > today just by removing seusers or making it empty.  The problem with
> > > that approach I thought was that it required regenerating and loading
> > > kernel policy each time we add or remove a Linux user.
> > > 
> > 
> > No, I mean removing the separate user identity entirely and allowing
> > selinux to directly use the linux user identity where appropriate (e.g.,
> > for constraints). This may be an awful idea, it's just that we abandoned
> 
> s/may be/is/
> 

Glad we cleared that up :)

> > SELinux knowledge of individual users because of scalability problems
> > (which seems somewhat unfortunate) and added a somewhat redundant level
> > of indirection. Allowing direct interaction with the linux user identity
> > would solve the scalability while giving selinux a chance to have policy
> > around individual users.
> 
> It isn't quite redundant.  Today the SELinux user is an "authorized role
> set", while the role field indicates the active role.  So it still
> functions as a bound on what roles are reachable by the user, and means
> that newrole isn't completely trusted (can't jump to an arbitrary role,
> but only to one in the "authorized role set" identified by the SELinux
> user).
> 
> If we gave that up, then newrole would be a completely trusted program,
> i.e. it would fully adjudicate what roles can be entered by what users.
> 
> The Linux uid is less useful to us, as we certainly don't want to encode
> uids (integers) into the SELinux policy, so defining user-role
> authorizations based on Linux uid in kernel policy isn't going to be
> workable.
> 
> Also, the fact that the Linux uid can be changed by a suid application
> makes it a less reliable source of information.
> 
> Simple uid comparisons are what we essentially get from DAC.
> 
> So if you wanted to toss user-role authorizations by the kernel to the
> winds, you can achieve that by defining a single SELinux user
> (authorized for all roles in kernel policy), handling the Linux user ->
> role mapping entirely in seusers, and adjudicating that in login, sshd,
> and newrole.
> 

Ok - I'm convinced (teach me to brain storm over email). So I'm fine
with leaving user-level separation to DAC / namespace and leave the
current selinux users.

So I vote for removing genhomedircon entirely unless some other
objection comes up. Anyone that wants that behavior could certainly set
something up fairly easily.

Karl




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
