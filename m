Date: Thu, 19 Jun 2008 09:11:49 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, dwalsh@redhat.com,
        cpebenito@tresys.com
Subject: Re: [PATCH-v3] SELinux: allow fstype unknown to policy to use xattrs
 if present
In-Reply-To: <1213797004.16752.6.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.64.0806190911320.22390@us.intercode.com.au>
References: <1213797004.16752.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 18 Jun 2008, Eric Paris wrote:

> Currently if a FS is mounted for which SELinux policy does not define an
> fs_use_* that FS will either be genfs labeled or not labeled at all.
> This decision is based on the existence of a genfscon rule in policy and
> is irrespective of the capabilities of the filesystem itself.  This
> patch allows the kernel to check if the filesystem supports security
> xattrs and if so will use those if there is no fs_use_* rule in policy.
> An fstype with a no fs_use_* rule but with a genfs rule will use xattrs
> if available and will follow the genfs rule.
> 
> This can be particularly interesting for things like ecryptfs which
> actually overlays a real underlying FS.  If we define excryptfs in
> policy to use xattrs we will likely get this wrong at times, so with
> this path we just don't need to define it!
> 
> Overlay ecryptfs on top of NFS with no xattr support:
> SELinux: initialized (dev ecryptfs, type ecryptfs), uses genfs_contexts
> Overlay ecryptfs on top of ext4 with xattr support:
> SELinux: initialized (dev ecryptfs, type ecryptfs), uses xattr
> 
> It is also useful as the kernel adds new FS we don't need to add them in
> policy if they support xattrs and that is how we want to handle them.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Applied to for-akpm.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
