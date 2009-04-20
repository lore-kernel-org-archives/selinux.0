Subject: Re: [RFC PATCH] access(2) vs. SELinux
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Chad Sellers <csellers@tresys.com>,
        Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1240256506.1678.11.camel@localhost.localdomain>
References: <C6122AAA.A6957%csellers@tresys.com>
	 <1240251074.2562.80.camel@localhost.localdomain>
	 <1240256506.1678.11.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 20 Apr 2009 18:24:25 -0400
Message-Id: <1240266265.2562.411.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-04-20 at 15:41 -0400, Stephen Smalley wrote:
> On Mon, 2009-04-20 at 14:11 -0400, Eric Paris wrote:
> > On Mon, 2009-04-20 at 13:35 -0400, Chad Sellers wrote:
> > > On 4/20/09 1:21 PM, "Eric Paris" <eparis@redhat.com> wrote:
> > > <snip>
> > > > 
> > > > I'm going to spend a couple minutes and try to prototype an all in
> > > > kernel solution such that on access() we will check the permission:
> > > > 
> > > > allow process_t file_t:file read
> > > > 
> > > > if there is a dontaudit rule for EITHER "read" or "access_read" we will
> > > > NOT print an avc denial.
> > > > 
> > > > on the actual usage we will ONLY check for the "read" dontaudit.
> > > > 
> > > That sounds like a better solution than anything we've talked about so far.
> > > It would mean the policy author would only have to worry about the access_*
> > > perms if they cared about the issue they're designed to solve. Hopefully you
> > > can find an acceptable way to pull it off in the kernel. I'm rooting for
> > > you!
> > 
> > So James, Stephen what do we think of something like this?  Lot of code
> > bloat and pain on the access+denial path, but shouldn't hurt us any in
> > the hot case...
> > 
> > ---
> > diff --git a/fs/open.c b/fs/open.c
> > index 377eb25..485cfd8 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -493,7 +493,7 @@ SYSCALL_DEFINE3(faccessat, int, dfd, const char __user *, filename, int, mode)
> >  			goto out_path_release;
> >  	}
> >  
> > -	res = inode_permission(inode, mode | MAY_ACCESS);
> > +	res = inode_access_permission(inode, mode | MAY_ACCESS);
> 
> I had forgotten that there is already a MAY_ACCESS flag defined and used
> by the vfs.  So why can't we just pass that on to the security modules
> and use that to distinguish access(2) from open(2)?  Looks like it gets
> used on chdir(2) and chroot(2) as well, which is unfortunate, and I
> don't quite understand why.  Maybe we need to look back at the origins
> of the MAY_ACCESS flag and its rationale.

Actually since both of those should be S_ISDIR we should still be able
to tell in the case we care about.

Looks like there was a MAY_CHDIR flag, but viro realized having 2 flags
that didn't overlap was useless...

a110343f0d6d41f68b7cf8c00b57a3172c67f816


-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
