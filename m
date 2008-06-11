Subject: Re: [RFC] SELinux: allow fstype unknown to policy to use xattrs if
	present
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1213203686.4597.59.camel@localhost.localdomain>
References: <1213203686.4597.59.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 11 Jun 2008 14:01:53 -0400
Message-Id: <1213207313.17842.101.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-06-11 at 13:01 -0400, Eric Paris wrote:
> Currently if a fs is mounted for which selinux policy does not define an
> fs_use_* or a genfscon statement that FS will not support labeling of
> any kind.  This patch allows the kernel to check if the filesystem
> supports security xattrs and if so will use those if there is no
> fs_use_* rule in policy.  An fstype with a genfs rule will use xattrs if
> available and will follow the genfs rule if they are not.
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
> Its also useful as the kernel adds new FS's we don't need to add them in
> policy if they support xattrs and that's how we want to handle them.
> 
> The real question: is this how we want to solve this?  We need some way
> for ecryptfs to be usable on top of NFS and on top of persistant labeled
> FS.  What I'm worried about is how to handle ecryptfs on top of
> non-persistant FS's like tmpfs which has xattrs...

I think that situation is ok; in that case, the tmpfs filesystem will
follow the fs_use_trans rule in determining its' inodes labels, and then
ecryptfs will fetch those labels via i_op->getxattr on the lower inode.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index dcc2e1c..3c4afe9 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1849,14 +1851,22 @@ int security_fs_use(
>  				goto out;
>  		}
>  		*sid = c->sid[0];
> +		goto out;
> +	}
> +
> +	/* labeling behavior not in policy, use xattrs if possible */
> +	if (can_xattr) {
> +		*behavior = SECURITY_FS_USE_XATTR;

Need to set *sid to a value before returning for the superblock SID.
SECINITSID_FS would make sense there.

> +		goto out;
> +	}
> +
> +	/* no behavior in policy and can't use xattrs, try GENFS */
> +	rc = security_genfs_sid(fstype, "/", SECCLASS_DIR, sid);
> +	if (rc) {
> +		*behavior = SECURITY_FS_USE_NONE;
> +		rc = 0;
>  	} else {
> -		rc = security_genfs_sid(fstype, "/", SECCLASS_DIR, sid);
> -		if (rc) {
> -			*behavior = SECURITY_FS_USE_NONE;
> -			rc = 0;
> -		} else {
> -			*behavior = SECURITY_FS_USE_GENFS;
> -		}
> +		*behavior = SECURITY_FS_USE_GENFS;
>  	}
>  
>  out:
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
