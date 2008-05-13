Subject: Re: [PATCH] selinux:  fix sleeping allocation in
	security_context_to_sid (Was: + selinux-dopey-hack.patch added to -mm tree)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <20080513092150.c819e1fc.akpm@linux-foundation.org>
References: <200805130810.m4D8ACbM032389@imap1.linux-foundation.org>
	 <1210688804.6206.141.camel@moss-spartans.epoch.ncsc.mil>
	 <20080513092150.c819e1fc.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Tue, 13 May 2008 13:01:46 -0400
Message-Id: <1210698106.6206.188.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-05-13 at 09:21 -0700, Andrew Morton wrote:
> On Tue, 13 May 2008 10:26:44 -0400 Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > On Tue, 2008-05-13 at 01:10 -0700, akpm@linux-foundation.org wrote:
> > > From: Andrew Morton <akpm@linux-foundation.org>
> > > 
> > > BUG: sleeping function called from invalid context at mm/slab.c:3052
> > > in_atomic():1, irqs_disabled():0
> > > 3 locks held by S99local/2391:
> > >  #0:  (&type->i_mutex_dir_key#4){--..}, at: [<c017973c>] do_lookup+0x72/0x146
> > >  #1:  (&isec->lock){--..}, at: [<c01cc3e5>] inode_doinit_with_dentry+0x35/0x52f
> > >  #2:  (policy_rwlock){..-?}, at: [<c01d7f89>] security_context_to_sid_core+0x5e/0x157
> > > Pid: 2391, comm: S99local Not tainted 2.6.26-rc2 #1
> > >  [<c011863c>] __might_sleep+0xde/0xe5
> > >  [<c01706e5>] __kmalloc+0x52/0xd5
> > >  [<c01d7d9f>] string_to_context_struct+0x2e/0x1ba
> > >  [<c01d7fa3>] security_context_to_sid_core+0x78/0x157
> > >  [<c01d80a5>] security_context_to_sid_default+0x10/0x12
> > >  [<c01cc609>] inode_doinit_with_dentry+0x259/0x52f
> > >  [<c01cc8f1>] selinux_d_instantiate+0x12/0x14
> > 
> > Please use this patch instead.
> 
> I'd rather not.
> 
> > Fix a sleeping function called from invalid context bug introduced by 
> > the deferred mapping of contexts support, which restructured the code 
> > into a helper and moved the locking to the caller.  Always use GFP_ATOMIC 
> > for allocating copies of the context  and remove the gfp_flags argument as it
> > is no longer used.  These allocations are generally small and transient.
> > 
> 
> GFP_ATOMIC is bad.  It can fail and it drains page reserves for things
> which actually need to use it.
> 
> It seems particualrly bad to use an unreliable mechanism in something
> which is security-related.
> 
> Please reconsider.

I don't see a good alternative without replacing the policy rwlock with
a different locking scheme.  Which is certainly something to investigate
but will take longer (efforts were made in the past to convert to RCU
but the results were not encouraging).  GFP_ATOMIC allocations certainly
aren't new in that code path or elsewhere in the security server at
times due to its own internal locking and at other times due to caller
locking, and the code does handle allocation failure in a safe manner.

James or Eric - do you see a better alternative at present?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
