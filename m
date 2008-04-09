Subject: Re: nfs_xdev_get_sb appears to sometimes reuse a sb and makes
	SELinux angry
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-nfs@vger.kernel.org, selinux@tycho.nsa.gov, steved@redhat.com,
        jlayton@redhat.com, jmorris@namei.org, trond.myklebust@fys.uio.no,
        chuck.lever@oracle.com
In-Reply-To: <1207754713.21223.449.camel@moss-spartans.epoch.ncsc.mil>
References: <1207753502.3070.25.camel@localhost.localdomain>
	 <1207754713.21223.449.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 09 Apr 2008 12:08:06 -0400
Message-Id: <1207757286.3070.32.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-04-09 at 11:25 -0400, Stephen Smalley wrote:
> On Wed, 2008-04-09 at 11:05 -0400, Eric Paris wrote:
> > When I wrote the new NFS/SELinux mount options code I was working under
> > the assumption that nfs_xdev_get_sb() would always give a new superblock
> > without the security struct initialized.  I now have a report of a user
> > in which we hit BUG_ON(newsbsec->initialized) indicating to me that NFS
> > is reusing a superblock.  The user says that he only has one mount to
> > the server in fstab, but doesn't know much about the server setup.  Is
> > it expected that nfs_xdev_get_sb might reuse a superblock?  If so maybe
> > we want this patch below?  Instead of me BUGing every time selinux sees
> > a reused superblock we but only if the reused superblock has different
> > security options than the old one.  I can't reproduce the issue so I
> > can't really test it....
> > 
> > comments?  should NFS be reusing a superblock here?  Can the NFS people
> > let me know how I can trigger it to make sure my patch fixes it?
> 
> Looks to me like nfs_compare_mount_options() needs to also compare
> security options as part of the criteria for deciding when sharing is
> permissible.  Otherwise, it seems quite possible that you'll still hit
> the new BUG.

Making nfs_compare_mount_options() security aware is not the right
answer.  Doing so means that we could end up with the same data 2 places
with different security options.  This is just not what we want...

I could make the _clone_ functions return -EINVAL instead of BUG but
since this is inside nfs_xdev_get_sb the user has no way to 'fix' it.
So that's not the right fix. (this is what I do with user controlled
mounts already which go through nfs_get_sb)

I'm currently leaning towards changing all of this to

if (newsbsec->initialized)
	return;

so the first sb wins and its mount options stick forever.  At least we
know we did our best to maintain labeling of the data and nothing is
going to explode.....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
