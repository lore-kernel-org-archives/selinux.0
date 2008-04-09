Subject: Re: [PATCH] SELinux: don't BUG if fs reuses a superblock
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: linux-nfs@vger.kernel.org, selinux@tycho.nsa.gov, steved@redhat.com,
        jlayton@redhat.com, jmorris@namei.org, trond.myklebust@fys.uio.no,
        chuck.lever@oracle.com
In-Reply-To: <1207764515.3070.39.camel@localhost.localdomain>
References: <1207764515.3070.39.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 09 Apr 2008 16:22:35 -0400
Message-Id: <1207772555.21223.624.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-04-09 at 14:08 -0400, Eric Paris wrote:
> I (wrongly) assumed that nfs_xdev_get_sb() would not ever share a
> superblock and so cloning mount options would always be correct.  Turns
> out that isn't the case and we could fall over a BUG_ON() that wasn't a
> BUG at all.  Since there is little we can do to reconcile different
> mount options this patch just leaves the sb alone and the first set of
> options wins.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

This is a bug fix - should go into 2.6.25.

> 
> ---
> 
>  security/selinux/hooks.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 89bb6d3..d39b59c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -760,13 +760,13 @@ static void selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
>  	 * this early in the boot process. */
>  	BUG_ON(!ss_initialized);
>  
> -	/* this might go away sometime down the line if there is a new user
> -	 * of clone, but for now, nfs better not get here... */
> -	BUG_ON(newsbsec->initialized);
> -
>  	/* how can we clone if the old one wasn't set up?? */
>  	BUG_ON(!oldsbsec->initialized);
>  
> +	/* if fs is reusing a sb, just let its options stand... */
> +	if (newsbsec->initialized)
> +		return;
> +
>  	mutex_lock(&newsbsec->lock);
>  
>  	newsbsec->flags = oldsbsec->flags;
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
