Date: Thu, 4 Oct 2018 04:13:08 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Kees Cook <keescook@chromium.org>
cc: Casey Schaufler <casey@schaufler-ca.com>,
 LSM <linux-security-module@vger.kernel.org>,
 SE Linux <selinux@tycho.nsa.gov>, LKLM <linux-kernel@vger.kernel.org>,
 John Johansen <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
 Salvatore Mesoraca <s.mesoraca16@gmail.com>
In-Reply-To: <CAGXu5jL1Ek85Hky+PZ2pGQF09_cd_odn-LanYU=vVKgw24b8vg@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1810040409280.13517@namei.org>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <f24ab6a2-aa1d-1c36-9e51-22c924ad37e5@schaufler-ca.com>
 <CAGXu5jL1Ek85Hky+PZ2pGQF09_cd_odn-LanYU=vVKgw24b8vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [PATCH v4 14/19] LSM: Infrastructure management of the
 inode security
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 21 Sep 2018, Kees Cook wrote:

> On Fri, Sep 21, 2018 at 5:19 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:

> > + * lsm_early_inode - during initialization allocate a composite inode blob
> > + * @inode: the inode that needs a blob
> > + *
> > + * Allocate the inode blob for all the modules if it's not already there
> > + */
> > +void lsm_early_inode(struct inode *inode)
> > +{
> > +       int rc;
> > +
> > +       if (inode == NULL)
> > +               panic("%s: NULL inode.\n", __func__);
> > +       if (inode->i_security != NULL)
> > +               return;
> > +       rc = lsm_inode_alloc(inode);
> > +       if (rc)
> > +               panic("%s: Early inode alloc failed.\n", __func__);
> > +}
> 
> I'm still advising against using panic(), but I'll leave it up to James.
> 

Calling panic() is not appropriate here. Perhaps if it was during 
boot-time initialization of LSM infrastructure, but not on the fly.

Use a WARN_ONCE then propagate the error back and fail the operation.


-- 
James Morris
<jmorris@namei.org>
