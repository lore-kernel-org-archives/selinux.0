Message-ID: <1493994275.5745.7.camel@tycho.nsa.gov>
Subject: Re: [RFC][PATCH] selinux: add a map permission check for mmap
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <brindle@quarksecurity.com>
Cc: paul@paul-moore.com, selinux@tycho.nsa.gov, eparis@parisplace.org,
 pebenito@ieee.org, jwcart2@tycho.nsa.gov
Date: Fri, 05 May 2017 10:24:35 -0400
In-Reply-To: <590C8148.6010307@quarksecurity.com>
References: <20170505131448.8718-1-sds@tycho.nsa.gov>
 <590C8148.6010307@quarksecurity.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-05-05 at 09:42 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > Add a map permission check on mmap so that we can distinguish
> > memory mapped
> > access (since it has different implications for revocation). When a
> > file
> > is opened and then read or written via syscalls like
> > read(2)/write(2),
> > we revalidate access on each read/write operation via
> > selinux_file_permission() and therefore can revoke access if the
> > process context, the file context, or the policy changes in such a
> > manner that access is no longer allowed. When a file is opened and
> > then
> > memory mapped via mmap(2) and then subsequently read or written
> > directly
> > in memory, we presently have no way to revalidate or revoke access.
> > The purpose of a separate map permission check on mmap(2) is to
> > permit
> > policy to prohibit memory mapping of specific files for which we
> > need
> > to ensure that every access is revalidated, particularly useful for
> > scenarios where we expect the file to be relabeled at runtime in
> > order
> > to reflect state changes (e.g. cross-domain solution, assured
> > pipeline
> > without data copying).
> > 
> > Signed-off-by: Stephen Smalley<sds@tycho.nsa.gov>
> > ---
> > NB I chose not to define a new policy capability for this
> > permission,
> > since it is adequately covered by handle_unknown for compatibility
> > and
> > others seemed to agree that this does not fall into the category of
> > changes requiring a new policy capability.  I also chose to define
> > the
> > permission for socket classes in addition to file classes and let
> > it
> > be checked for both.
> 
> Thank you. This is very helpful. This fully closes the relabel 
> revocation issue, right?
> 
> Is it actually safe to tell people that relabel+move is sufficient in
> an 
> assured pipeline now?

It isn't a 100% solution, but it is likely sufficient to address their
concerns. When possible, I would still encourage use of copying rather
than relabeling but this does reduce the risk associated with doing so.

The residual concern is with respect to in-progress system calls that
have already passed the associated permission checks but not yet
completed the data transfer.  In Flask/Fluke, we could interrupt such
operations or wait for them to complete (with bounded delay).  Not so
much in Linux.  There is also some level of async I/O support in the
Linux kernel, which could widen the window between the permission check
and the data transfer, although the kernel AIO implementation seems to
be perpetually incomplete and is not used by the glibc aio
implementation.  However, this is less of a concern than the ability to
map the file and read/write the data indefinitely after the relabel
completes, which is what this patch is seeking to help prevent.

Obviously to leverage this facility one must ensure that no domains are
 allowed map permission to the relevant file types.  That will require
removal of unconfined, careful policy writing (e.g. don't use refpolicy
patterns/permission sets that might include map) and appropriate use of
neverallows to ensure it isn't undermined elsewhere.

> 
> > 
> >   security/selinux/hooks.c            | 12 ++++++++++++
> >   security/selinux/include/classmap.h |  2 +-
> >   2 files changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index e67a526..5432628 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -3550,6 +3550,18 @@ static int selinux_mmap_addr(unsigned long
> > addr)
> >   static int selinux_mmap_file(struct file *file, unsigned long
> > reqprot,
> >   			     unsigned long prot, unsigned long
> > flags)
> >   {
> > +	struct common_audit_data ad;
> > +	int rc;
> > +
> > +	if (file) {
> > +		ad.type = LSM_AUDIT_DATA_FILE;
> > +		ad.u.file = file;
> > +		rc = inode_has_perm(current_cred(),
> > file_inode(file),
> > +				    FILE__MAP,&ad);
> > +		if (rc)
> > +			return rc;
> > +	}
> > +
> >   	if (selinux_checkreqprot)
> >   		prot = reqprot;
> > 
> > diff --git a/security/selinux/include/classmap.h
> > b/security/selinux/include/classmap.h
> > index 1e0cc9b..3e49a78 100644
> > --- a/security/selinux/include/classmap.h
> > +++ b/security/selinux/include/classmap.h
> > @@ -1,7 +1,7 @@
> >   #include<linux/capability.h>
> > 
> >   #define COMMON_FILE_SOCK_PERMS "ioctl", "read", "write",
> > "create", \
> > -    "getattr", "setattr", "lock", "relabelfrom", "relabelto",
> > "append"
> > +    "getattr", "setattr", "lock", "relabelfrom", "relabelto",
> > "append", "map"
> > 
> >   #define COMMON_FILE_PERMS COMMON_FILE_SOCK_PERMS, "unlink",
> > "link", \
> >       "rename", "execute", "quotaon", "mounton", "audit_access", \
