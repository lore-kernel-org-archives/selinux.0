Message-ID: <7e0fb38c0901031416w596d9c25vf42fb72a6824268b@mail.gmail.com>
Date: Sat, 3 Jan 2009 17:16:54 -0500
From: "Eric Paris" <eparis@parisplace.org>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: Re: [PATCH 2/3] SELinux: Add new security mount option to indicate security label support.
Cc: jmorris@namei.org, sds@tycho.nsa.gov, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
In-Reply-To: <1230915146-2359-3-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1230915146-2359-1-git-send-email-dpquigl@tycho.nsa.gov>
	 <1230915146-2359-3-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jan 2, 2009 at 11:52 AM, David P. Quigley <dpquigl@tycho.nsa.gov> wrote:
> There is no easy way to tell if a file system supports SELinux security labeling.
> Because of this a new flag is being added to the super block security structure
> to indicate that the particular super block supports labeling. This flag is set
> for file systems using the xattr, task, and transition labeling methods unless
> that behavior is overridden by context mounts.
>
> Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
> ---


> @@ -431,7 +433,7 @@ static int sb_finish_set_opts(struct super_block *sb)
>                }
>        }
>
> -       sbsec->flags |= SE_SBINITIALIZED;
> +       sbsec->flags |= (SE_SBINITIALIZED | SE_SBLABELSUPP);
>
>        if (sbsec->behavior > ARRAY_SIZE(labeling_behaviors))
>                printk(KERN_ERR "SELinux: initialized (dev %s, type %s), unknown behavior\n",
> @@ -441,6 +443,12 @@ static int sb_finish_set_opts(struct super_block *sb)
>                       sb->s_id, sb->s_type->name,
>                       labeling_behaviors[sbsec->behavior-1]);
>
> +       if (sbsec->behavior == SECURITY_FS_USE_GENFS ||
> +           sbsec->behavior == SECURITY_FS_USE_MNTPOINT ||
> +           sbsec->behavior == SECURITY_FS_USE_NONE ||
> +           sbsec->behavior > ARRAY_SIZE(labeling_behaviors))
> +               sbsec->flags &= ~SE_SBLABELSUPP;
> +
>        /* Initialize the root inode. */
>        rc = inode_doinit_with_dentry(root_inode, root);
>

Why set it just to unset?   Cleaner to only set it for the right
things, Isn't it?

> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index ff4e19c..8143587 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -47,11 +47,13 @@
>  /* Non-mount related flags */
>  #define SE_SBINITIALIZED       0x10
>  #define SE_SBPROC              0x20
> +#define SE_SBLABELSUPP 0x40
>
>  #define CONTEXT_STR    "context="
>  #define FSCONTEXT_STR  "fscontext="
>  #define ROOTCONTEXT_STR        "rootcontext="
>  #define DEFCONTEXT_STR "defcontext="
> +#define LABELSUPP_STR "supports_labeling"

This is very selinux specific and "labeling" is very generic.  James,
you have suggestions?

Don't you also need to swallow this text string somewhere in
selinux_sb_copy_data()?  I think ext3 works fine with option strings
it doesn't understand I think the nfs code will explode if we just
leave the string (maybe we are ok with that....)

I say we just swallow "supports_labeling" in selinux_sb_copy_data() so
trying to mount with it is a noop....   Or allow people to mount with
it and have the mount blow up when they end up not using
xattr/task/transition....

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
