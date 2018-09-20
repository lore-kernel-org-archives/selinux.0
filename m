Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Eric Paris <eparis@parisplace.org>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>
From: Taras Kondratiuk <takondra@cisco.com>
In-Reply-To: <f283c1e7-19eb-2b99-3fef-a19e2bf99a2b@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
 xe-linux-external@cisco.com
References: <20180919165248.53090-1-takondra@cisco.com>
 <f283c1e7-19eb-2b99-3fef-a19e2bf99a2b@tycho.nsa.gov>
Message-ID: <153741130781.7326.1773144725860636439@takondra-t460s>
Date: Wed, 19 Sep 2018 19:41:47 -0700
Subject: Re: [RFC PATCH] selinux: add a fallback to defcontext for
 native labeling
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Quoting Stephen Smalley (2018-09-19 12:00:33)
> On 09/19/2018 12:52 PM, Taras Kondratiuk wrote:
> > When files on NFSv4 server are not properly labeled (label doesn't match
> > a policy on a client) they will end up with unlabeled_t type which is
> > too generic. We would like to be able to set a default context per
> > mount. 'defcontext' mount option looks like a nice solution, but it
> > doesn't seem to be fully implemented for native labeling. Default
> > context is stored, but is never used.
> > 
> > The patch adds a fallback to a default context if a received context is
> > invalid. If the inode context is already initialized, then it is left
> > untouched to preserve a context set locally on a client.
> 
> Can you explain the use case further?  Why are you exporting a 
> filesystem with security labeling enabled to a client that doesn't 
> understand all of the labels used within it?  Why wouldn't you just 
> disable NFSv4 security labeling and/or use a regular context= mount to 
> assign a single context to all files in the mount?

Client and server are two embedded devices. They are part of a bigger
modular system and normally run the same SW version, so they understand
each others NFSv4 SELinux labels. But during migration from one SW
version to another a client and a server may run different versions for
some time.

The immediate issue I'm trying to address is a migration between
releases with and without SELinux policy. A client (with policy) gets
initial SID labels from a server (without policy). Those labels are
considered invalid, so files remain unlabeled. This also causes lots of
errors from nfs_setsecurity() in dmesg.

Using 'context=' at mount point level is an option, but in a normal case
when both sides have a policy we need more granular labels. It is
possible to detect a case when a server doesn't have a policy and
remount with 'context=', but this special case handling looks a bit
ugly. Having something like 'defcontext' whould allow to avoid this
special case and unconditionally assign default context to the
mountpoint.

'defcontext' may also help during migration between SELinux-enabled
releases if a new release introduces labels that are not recognized by
older release. In this case they can also fallback to defcontext.

> 
> To be clear, defcontext= doesn't work that way for local/FS_USE_XATTR 
> filesystems. The context specified by it is only used for:
> 1) files that don't implement the xattr inode operations at all,
> 2) files that lack a security.selinux xattr,
> 3) the MLS portion of the context if it was missing (strictly as a 
> legacy compatibility mechanism for RHEL4 which predated the enabling of 
> the MLS field/logic).
> 
> A file with a security.selinux xattr that is invalid under policy for 
> any reason other than a missing MLS field will be handled as having the 
> unlabeled context.

inode_doinit_with_dentry() invokes security_context_to_sid_default()
that invokes security_context_to_sid_core() with 'force' flag. Won't
sidtab_context_to_sid() in this case allocate a new SID for the invalid
xattr context instead of leaving it unlabeled?

> 
> So this would be a divergence in semantics for defcontext= between 
> local/FS_USE_XATTR and NFS/FS_USE_NATIVE filesystems.

Yeah, I also didn't like this semantics mismatch. But from another point
defcontext allows to assign a context to files that would otherwise be
unlabeled. Something similar I'd like to achive for NFS.

> 
> > 
> > Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
> > ---
> >   security/selinux/hooks.c | 25 ++++++++++++++++++++++++-
> >   1 file changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index ad9a9b8e9979..f7debe798bf5 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -6598,7 +6598,30 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
> >    */
> >   static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
> >   {
> > -     return selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);
> > +     struct superblock_security_struct *sbsec;
> > +     struct inode_security_struct *isec;
> > +     int rc;
> > +
> > +     rc = selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);
> 
> In this case, we likely don't gain much by reusing 
> selinux_inode_setsecurity() here and could just inline the relevant 
> portion of it if we were to make this change.  Logically they mean 
> different things.
> 
> > +
> > +     /*
> > +      * In case of Native labeling with defcontext mount option fall back
> > +      * to a default SID if received context is invalid.
> > +      */
> > +     if (rc == -EINVAL) {
> > +             sbsec = inode->i_sb->s_security;
> > +             if (sbsec->behavior == SECURITY_FS_USE_NATIVE &&
> > +                 sbsec->flags & DEFCONTEXT_MNT) {
> > +                     isec = inode->i_security;
> > +                     if (!isec->initialized) {
> > +                             isec->sclass = inode_mode_to_security_class(inode->i_mode);
> > +                             isec->sid = sbsec->def_sid;
> > +                             isec->initialized = 1;
> > +                     }
> > +                     rc = 0;
> > +             }
> > +     }
> > +     return rc;
> >   }
> >   
> >   /*
> > 
> 
