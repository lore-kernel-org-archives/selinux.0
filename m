Subject: Re: [PATCH 3/3] SELinux: better printk when file with invalid
 label found
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <20090209213724.9537.35275.stgit@paris.rdu.redhat.com>
References: <20090209213714.9537.8322.stgit@paris.rdu.redhat.com>
	 <20090209213724.9537.35275.stgit@paris.rdu.redhat.com>
Content-Type: text/plain
Date: Tue, 10 Feb 2009 09:14:43 -0500
Message-Id: <1234275283.4642.29.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-02-09 at 16:37 -0500, Eric Paris wrote:
> Currently when an inode is read into the kernel with an invalid label
> string (can often happen with removable media) we output a string like:
> 
> SELinux: inode_doinit_with_dentry:  context_to_sid([SOME INVALID LABEL])
> returned -22 dor dev=[blah] ino=[blah]
> 
> Which is all but incomprehensible to all but a couple of us.  Instead, on
> EINVAL only, I plan to output a much more user friendly string and I plan to
> ratelimit the printk since many of these could be generated very rapidly.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

You could likely further drop the function name in all cases, and maybe
even the error code (is there no strerror() equivalent in the kernel?).


> ---
> 
>  security/selinux/hooks.c |   17 +++++++++++++----
>  1 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e2bdb28..7fe870d 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1335,10 +1335,19 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>  							     sbsec->def_sid,
>  							     GFP_NOFS);
>  			if (rc) {
> -				printk(KERN_WARNING "SELinux: %s:  context_to_sid(%s) "
> -				       "returned %d for dev=%s ino=%ld\n",
> -				       __func__, context, -rc,
> -				       inode->i_sb->s_id, inode->i_ino);
> +				char *dev = inode->i_sb->s_id;
> +				unsigned long ino = inode->i_ino;
> +
> +				if (rc == -EINVAL) {
> +					if (printk_ratelimit())
> +						printk(KERN_NOTICE "SELinux: inode=%lu on dev=%s was found to have an invalid "
> +							"context=%s.  This indicates you may need to relabel the inode or the "
> +							"filesystem in question.\n", ino, dev, context);
> +				} else {
> +					printk(KERN_WARNING "SELinux: %s:  context_to_sid(%s) "
> +					       "returned %d for dev=%s ino=%ld\n",
> +					       __func__, context, -rc, dev, ino);
> +				}
>  				kfree(context);
>  				/* Leave with the unlabeled SID */
>  				rc = 0;
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
