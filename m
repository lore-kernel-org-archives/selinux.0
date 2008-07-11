Subject: Re: [PATCH-v3] SELinux: allow fstype unknown to policy to use
	xattrs if present
From: Eric Paris <eparis@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, dwalsh@redhat.com,
        cpebenito@tresys.com
In-Reply-To: <Xine.LNX.4.64.0806190911320.22390@us.intercode.com.au>
References: <1213797004.16752.6.camel@localhost.localdomain>
	 <Xine.LNX.4.64.0806190911320.22390@us.intercode.com.au>
Content-Type: text/plain
Date: Fri, 11 Jul 2008 13:13:56 -0400
Message-Id: <1215796436.7567.106.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-06-19 at 09:11 +1000, James Morris wrote:
> On Wed, 18 Jun 2008, Eric Paris wrote:
> 
> > Currently if a FS is mounted for which SELinux policy does not define an
> > fs_use_* that FS will either be genfs labeled or not labeled at all.
> > This decision is based on the existence of a genfscon rule in policy and
> > is irrespective of the capabilities of the filesystem itself.  This
> > patch allows the kernel to check if the filesystem supports security
> > xattrs and if so will use those if there is no fs_use_* rule in policy.
> > An fstype with a no fs_use_* rule but with a genfs rule will use xattrs
> > if available and will follow the genfs rule.
> > 
> > This can be particularly interesting for things like ecryptfs which
> > actually overlays a real underlying FS.  If we define excryptfs in
> > policy to use xattrs we will likely get this wrong at times, so with
> > this path we just don't need to define it!
> > 
> > Overlay ecryptfs on top of NFS with no xattr support:
> > SELinux: initialized (dev ecryptfs, type ecryptfs), uses genfs_contexts
> > Overlay ecryptfs on top of ext4 with xattr support:
> > SELinux: initialized (dev ecryptfs, type ecryptfs), uses xattr
> > 
> > It is also useful as the kernel adds new FS we don't need to add them in
> > policy if they support xattrs and that is how we want to handle them.
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> 
> Applied to for-akpm.

Please drop this patch for now.  It deadlocks on ntfs-3g.  I need to
rework it to handle fuse filesystems better.  (casey was right)

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
