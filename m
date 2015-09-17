Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8HCpNTO025765
 for <selinux@tycho.nsa.gov>; Thu, 17 Sep 2015 08:51:23 -0400
Received: by igbkq10 with SMTP id kq10so11472102igb.0
 for <selinux@tycho.nsa.gov>; Thu, 17 Sep 2015 05:50:57 -0700 (PDT)
Date: Thu, 17 Sep 2015 07:50:20 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 Andy Lutomirski <luto@amacapital.net>, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v3 6/7] Smack: Add support for unprivileged mounts from
 user namespaces
Message-ID: <20150917125020.GB85188@ubuntu-hedt>
References: <1442433764-80826-1-git-send-email-seth.forshee@canonical.com>
 <1442433764-80826-7-git-send-email-seth.forshee@canonical.com>
 <55F9D22E.8090902@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55F9D22E.8090902@schaufler-ca.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Sep 16, 2015 at 01:33:50PM -0700, Casey Schaufler wrote:
> On 9/16/2015 1:02 PM, Seth Forshee wrote:
> > Security labels from unprivileged mounts cannot be trusted.
> > Ideally for these mounts we would assign the objects in the
> > filesystem the same label as the inode for the backing device
> > passed to mount. Unfortunately it's currently impossible to
> > determine which inode this is from the LSM mount hooks, so we
> > settle for the label of the process doing the mount.
> >
> > This label is assigned to s_root, and also to smk_default to
> > ensure that new inodes receive this label. The transmute property
> > is also set on s_root to make this behavior more explicit, even
> > though it is technically not necessary.
> >
> > If a filesystem has existing security labels, access to inodes is
> > permitted if the label is the same as smk_root, otherwise access
> > is denied. The SMACK64EXEC xattr is completely ignored.
> >
> > Explicit setting of security labels continues to require
> > CAP_MAC_ADMIN in init_user_ns.
> >
> > Altogether, this ensures that filesystem objects are not
> > accessible to subjects which cannot already access the backing
> > store, that MAC is not violated for any objects in the fileystem
> > which are already labeled, and that a user cannot use an
> > unprivileged mount to gain elevated MAC privileges.
> >
> > sysfs, tmpfs, and ramfs are already mountable from user
> > namespaces and support security labels. We can't rule out the
> > possibility that these filesystems may already be used in mounts
> > from user namespaces with security lables set from the init
> > namespace, so failing to trust lables in these filesystems may
> > introduce regressions. It is safe to trust labels from these
> > filesystems, since the unprivileged user does not control the
> > backing store and thus cannot supply security labels, so an
> > explicit exception is made to trust labels from these
> > filesystems.
> >
> > Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> 
> One coding comment below, otherwise looking good.
> 
> > ---
> >  security/smack/smack.h     |  6 ++++++
> >  security/smack/smack_lsm.c | 35 +++++++++++++++++++++++++++--------
> >  2 files changed, 33 insertions(+), 8 deletions(-)
> >
> > diff --git a/security/smack/smack.h b/security/smack/smack.h
> > index fff0c612bbb7..070223960a2c 100644
> > --- a/security/smack/smack.h
> > +++ b/security/smack/smack.h
> > @@ -91,8 +91,14 @@ struct superblock_smack {
> >  	struct smack_known	*smk_hat;
> >  	struct smack_known	*smk_default;
> >  	int			smk_initialized;
> > +	int			smk_flags;
> 
> How about deleting smk_initialized and using a bit
> in smk_flags. A whole int for each seems excessive.
> The smk_initialized field is only used in two places,
> both in smack_set_mnt_opts.

Sure, I can do that.

Thanks,
Seth
