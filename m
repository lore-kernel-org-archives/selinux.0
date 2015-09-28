Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8SJk357010320
 for <selinux@tycho.nsa.gov>; Mon, 28 Sep 2015 15:46:03 -0400
Received: by ioiz6 with SMTP id z6so187031485ioi.2
 for <selinux@tycho.nsa.gov>; Mon, 28 Sep 2015 12:45:51 -0700 (PDT)
Date: Mon, 28 Sep 2015 14:45:30 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 Andy Lutomirski <luto@amacapital.net>, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v4 6/7] Smack: Add support for unprivileged mounts from
 user namespaces
Message-ID: <20150928194530.GB25936@ubuntu-hedt>
References: <1443039368-55445-1-git-send-email-seth.forshee@canonical.com>
 <1443039368-55445-7-git-send-email-seth.forshee@canonical.com>
 <87oagnek25.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87oagnek25.fsf@x220.int.ebiederm.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, Sep 27, 2015 at 02:30:58PM -0500, Eric W. Biederman wrote:
> Seth Forshee <seth.forshee@canonical.com> writes:
> 
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
> 
> Hmm.
> 
> >
> > Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> > ---
> >  security/smack/smack.h     |  8 +++++++-
> >  security/smack/smack_lsm.c | 41 ++++++++++++++++++++++++++++++-----------
> >  2 files changed, 37 insertions(+), 12 deletions(-)
> 
> [snip]
> 
> > @@ -3475,14 +3492,16 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
> >  			if (rc >= 0)
> >  				transflag = SMK_INODE_TRANSMUTE;
> >  		}
> > -		/*
> > -		 * Don't let the exec or mmap label be "*" or "@".
> > -		 */
> > -		skp = smk_fetch(XATTR_NAME_SMACKEXEC, inode, dp);
> > -		if (IS_ERR(skp) || skp == &smack_known_star ||
> > -		    skp == &smack_known_web)
> > -			skp = NULL;
> > -		isp->smk_task = skp;
> > +		if (!(sbsp->smk_flags & SMK_SB_UNTRUSTED)) {
> > +			/*
> > +			 * Don't let the exec or mmap label be "*" or "@".
> > +			 */
> > +			skp = smk_fetch(XATTR_NAME_SMACKEXEC, inode, dp);
> > +			if (IS_ERR(skp) || skp == &smack_known_star ||
> > +			    skp == &smack_known_web)
> > +				skp = NULL;
> > +			isp->smk_task = skp;
> 
> I have to stop and ask is this really what we want to do?
> 
> If I have permission I can get around this by explicitly setting the
> XATTR_NAME_SMACKEXEC.  Perhaps that does not matter but I think it is
> siginficant.
> 
> We don't do any filtering on the the smk_mmap label.
> 
> Given the policy as I understand it is to only honor labels that match
> smk_root would we not be better off allowing anything to be set and
> filtering the labels at use when SMK_SB_UNTRUSTED is set?
> 
> Having three different policies depending on the kind of label concerns
> me.

The thinking behind the behavior was that since SMACK64EXEC is analagous
to suid or file caps it should be handled similarly, i.e. ignore it in
situations when the mount isn't trusted. You have a point about it being
incongruous with how the other Smack labels are handled though.

So let's say we read the label in an untrusted mount and handle it in
bprm_set_creds. If the label matches smk_root, we allow the transition.
I can't think of a problem with that, but I'd like to hear what Casey
has to say.

What if the label doesn't match? We have a couple of options, either
refuse to exec or exec without changing the label. I'd still favor the
latter, which would keep it consistent with what we do with suid or file
caps.

I'm okay with moving to something like this.

Seems like we probably do need to handle smk_mmap as well. Good catch.

Seth
