Date: Sat, 14 Feb 2009 09:43:31 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, paul.moore@hp.com
Subject: Re: [PATCH -v2 3/3] SELinux: better printk when file with invalid
 label found
In-Reply-To: <20090212200110.25810.93732.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.1.10.0902140943270.32324@tundra.namei.org>
References: <20090212200059.25810.72120.stgit@paris.rdu.redhat.com> <20090212200110.25810.93732.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 12 Feb 2009, Eric Paris wrote:

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

Applied.

> ---
> 
>  security/selinux/hooks.c |   17 +++++++++++++----
>  1 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e733fc1..45e286c 100644
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
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
