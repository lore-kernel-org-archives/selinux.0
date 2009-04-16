Subject: Re: access(2) vs. SELinux
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1239901725.7591.51.camel@localhost.localdomain>
References: <1239810710.27560.53.camel@localhost.localdomain>
	 <1239813708.3486.61.camel@localhost.localdomain>
	 <1239826404.27560.68.camel@localhost.localdomain>
	 <1239901725.7591.51.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 16 Apr 2009 14:10:38 -0400
Message-Id: <1239905439.3722.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-04-16 at 13:08 -0400, Stephen Smalley wrote:
> On Wed, 2009-04-15 at 16:13 -0400, Stephen Smalley wrote:
> > On Wed, 2009-04-15 at 12:41 -0400, Eric Paris wrote:
> > > On Wed, 2009-04-15 at 11:51 -0400, Stephen Smalley wrote:
> > > > - Using a different class or set of permissions when checking for
> > > > access(2), likewise requiring reworking the underlying implementation so
> > > > that we can distinguish the checking from open(2).  Then one could
> > > > choose to use dontaudit rules to suppress the access(2) checking w/o
> > > > suppressing the open(2) checking.  However, this could present a major
> > > > consistency problem between what access(2) reports and what is actually
> > > > allowed upon open(2) or execve(2).
> > > 
> > > Assuming I'm thinking about this the right way, to make this useful we
> > > must keep the access and the open permissions in sync.  For every
> > > file/read we MUST have an access/read etc.  Right?  So to solve Dan's
> > > problem we'd need rules like:
> > > 
> > > allow my_app_t my_file_t:file read
> > > allow my_app_t my_file_t:access read
> > > dontaudit my_app_t my_file_t:access write
> > > 
> > > I'm worried that Dan would go wild adding
> > > dontaudit my_app_t my_file_t:access *
> > > 
> > > Which would be just as bad for the end user experience as simply
> > > dontauditing them in the kernel (which I won't do)  So if we go this
> > > route, don't do that dan.
> > > 
> > > 
> > > Now I could probably do some sort of fancy black magic in the kernel
> > > whereby we actually check file/* for the permission but display access/*
> > > for the audit message and access/* for the dontaudit rules, but that
> > > seems very fragile and untenable.  Next is how audit2allow is going to
> > > try to generate a policy with only access/*, which is quickly going to
> > > fall down next on file/*
> > > 
> > > I sorta feel like the 'right' solution is going to be forcing userspace
> > > to keep those 2 in sync.  I'm willing to put an in kernel check on
> > > policy load that rejects policy when they are not in sync...   but it
> > > feels like it should be an all userspace problem.  Best in my opinion
> > > would be to make the userspace tool chain just create the access class
> > > allow rules out of the file class allow rule, and vice versa.....
> > 
> > That will generate a lot of policy bloat.  It would be far more compact
> > if we were to define new access_read, access_write, access_execute
> > permissions in each of the file classes, assuming we still have the
> > space, and forcibly set those bits whenever we set read, write, or
> > execute in the same access vector.
> 
> Note that migrating access(2) to new permissions also requires adding a
> new policy capability flag to tell the kernel whether the policy expects
> access(2) to be controlled via read/write/execute or via the new
> permissions.  Otherwise, new kernels with old policies would always try
> checking the new permissions, and these would either be always denied or
> always allowed depending on the handle_unknown flag, thereby causing
> access(2) to either always fail or always succeed (either of which could
> break applications).

Bah, implementation detail.  We could instead look to see if the
access_* bits were ever set in policy and if so set an in kernel flag
telling us to use those on access checks (but I'll probably use the
capability flag)  anyway...

He's some concerns/thoughts.

domain_t calls access(W_OK) on file_t.

This generates a denial

denied  { access_write } scontext=domain_t tcontext=file_t tclass=file

Which audit2allow will gladly turn into:

allow domain_t file_t:file { access_write }

Load that module and then, POP the next time

denied { write } scontext=domain_t tcontext=file_t tclass=file

So somewhere we need some sort of synchronization.

---

I suggested to Dan that audit2allow should should, given the above
access_write denial output:
allow domain_t file_t:file { write }

and the tool chain just automatically maps all write rule to both allow
bits for BOTH write and access_write.

---

We could also have the tool chain just run in both directions and leave
audit2allow alone.  Any rule with access_write would cause the tool
chain to add write and any rule with write would cause us to add
access_write.

>From the point of view of policy analysis I think think that makes
things worse.  Now the access_write rule really means something.  That's
fine with me, but I have a feeling the people who care about policy
analysis might not like that idea.....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
