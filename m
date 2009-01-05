Subject: Re: [PATCH 2/3] SELinux: Add new security mount option to indicate
 security label support.
From: Eric Paris <eparis@redhat.com>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Cc: Eric Paris <eparis@parisplace.org>, jmorris@namei.org, sds@tycho.nsa.gov,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
In-Reply-To: <1231167727.18774.2.camel@moss-terrapins.epoch.ncsc.mil>
References: <1230915146-2359-1-git-send-email-dpquigl@tycho.nsa.gov>
	 <1230915146-2359-3-git-send-email-dpquigl@tycho.nsa.gov>
	 <7e0fb38c0901031416w596d9c25vf42fb72a6824268b@mail.gmail.com>
	 <1231167727.18774.2.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 05 Jan 2009 10:54:50 -0500
Message-Id: <1231170890.8826.14.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-01-05 at 10:02 -0500, David P. Quigley wrote:
> On Sat, 2009-01-03 at 17:16 -0500, Eric Paris wrote:
> > On Fri, Jan 2, 2009 at 11:52 AM, David P. Quigley <dpquigl@tycho.nsa.gov> wrote:
> > > There is no easy way to tell if a file system supports SELinux security labeling.
> > > Because of this a new flag is being added to the super block security structure
> > > to indicate that the particular super block supports labeling. This flag is set
> > > for file systems using the xattr, task, and transition labeling methods unless
> > > that behavior is overridden by context mounts.
> > >
> > > Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
> > > ---
> > 
> > 
> > > @@ -431,7 +433,7 @@ static int sb_finish_set_opts(struct super_block *sb)
> > >                }
> > >        }
> > >
> > > -       sbsec->flags |= SE_SBINITIALIZED;
> > > +       sbsec->flags |= (SE_SBINITIALIZED | SE_SBLABELSUPP);
> > >
> > >        if (sbsec->behavior > ARRAY_SIZE(labeling_behaviors))
> > >                printk(KERN_ERR "SELinux: initialized (dev %s, type %s), unknown behavior\n",
> > > @@ -441,6 +443,12 @@ static int sb_finish_set_opts(struct super_block *sb)
> > >                       sb->s_id, sb->s_type->name,
> > >                       labeling_behaviors[sbsec->behavior-1]);
> > >
> > > +       if (sbsec->behavior == SECURITY_FS_USE_GENFS ||
> > > +           sbsec->behavior == SECURITY_FS_USE_MNTPOINT ||
> > > +           sbsec->behavior == SECURITY_FS_USE_NONE ||
> > > +           sbsec->behavior > ARRAY_SIZE(labeling_behaviors))
> > > +               sbsec->flags &= ~SE_SBLABELSUPP;
> > > +
> > >        /* Initialize the root inode. */
> > >        rc = inode_doinit_with_dentry(root_inode, root);
> > >
> > 
> > Why set it just to unset?   Cleaner to only set it for the right
> > things, Isn't it?
> 
> Actually the list of things that support it is larger than the things
> that don't so it is a smaller conditional to assume things support it
> and then remove the ones that don't. Atleast thats what I found
> initially.
> 
> > 
> > > diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> > > index ff4e19c..8143587 100644
> > > --- a/security/selinux/include/security.h
> > > +++ b/security/selinux/include/security.h
> > > @@ -47,11 +47,13 @@
> > >  /* Non-mount related flags */
> > >  #define SE_SBINITIALIZED       0x10
> > >  #define SE_SBPROC              0x20
> > > +#define SE_SBLABELSUPP 0x40
> > >
> > >  #define CONTEXT_STR    "context="
> > >  #define FSCONTEXT_STR  "fscontext="
> > >  #define ROOTCONTEXT_STR        "rootcontext="
> > >  #define DEFCONTEXT_STR "defcontext="
> > > +#define LABELSUPP_STR "supports_labeling"
> > 
> > This is very selinux specific and "labeling" is very generic.  James,
> > you have suggestions?
> 
> I'll switch this to James' suggestion of seclabel
> 
> > 
> > Don't you also need to swallow this text string somewhere in
> > selinux_sb_copy_data()?  I think ext3 works fine with option strings
> > it doesn't understand I think the nfs code will explode if we just
> > leave the string (maybe we are ok with that....)
> 
> Ill look into this. I looked at how we added a new option for the NFS
> code and duplicated that so if we need that there I need to fix the
> labeled NFS code.

Mounting has 2 steps.  Step 1 we call selinux_sb_copy_data which takes
the raw string from the FS, And pulls out the mount options that selinux
deals with and writes those into a new secdata string.  In that process
it actually removes those characters from the original.  Thus the
filesystem never sees selinux strings.

In step 2 the secdata string created in selinux_sb_copy_data is passed
to security_sb_kern_mount->superblock_doinit->selinux_set_mnt_opts()
from a normal user initiated mount or in the case of labeled NFS a data
struct is created and passed directly into security_sb_set_mnt_opts().

So if we add a whole new mount string we need to handle it both in
security_sb_set_mnt_opts (which you already fixed) and when we parse out
what strings "belong" to the lsm.  aka selinux_sb_copy_data() so that
information can ever get to security_sb_set_mnt_opts.

It should be as simple as adding another line to selinux_option....


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
