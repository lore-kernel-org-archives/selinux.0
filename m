Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w632fUQf007086
 for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2018 22:41:30 -0400
Received: by mail-lj1-f195.google.com with SMTP id o26-v6so298052ljg.3
 for <selinux@tycho.nsa.gov>; Mon, 02 Jul 2018 19:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <3880c8030c55a97ee38335fc0dbf5dfd4f296c59.1529476660.git.joe@perches.com>
 <CAHC9VhS_UmWfv0aFGLfaqw-fLSmoGiDEcXGFZ3bvwNgp2PF=zg@mail.gmail.com>
 <d729f7dc451cf26f5fdb63e44930c8fb67da41d3.camel@perches.com>
 <CAHC9VhTzV5QKcjaQL0L_mTZECCexUq=FaSuQjC1AZjubD+VdJA@mail.gmail.com>
 <743d2fd7b0b661bc636766e7b569fefa95a462f6.camel@perches.com>
In-Reply-To: <743d2fd7b0b661bc636766e7b569fefa95a462f6.camel@perches.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 2 Jul 2018 22:41:10 -0400
Message-ID: <CAHC9VhTRmWnobxqjffSwvUQfjOP0mo-qOVF_CAd5po_8tGpR5A@mail.gmail.com>
To: joe@perches.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 peter.enderborg@sony.com, selinux@tycho.nsa.gov,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: Use pr_fmt to prefix "SELinux: "
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jul 2, 2018 at 10:10 PM Joe Perches <joe@perches.com> wrote:
> On Mon, 2018-07-02 at 21:15 -0400, Paul Moore wrote:
> > On Mon, Jul 2, 2018 at 5:31 PM Joe Perches <joe@perches.com> wrote:
> > > On Mon, 2018-07-02 at 16:51 -0400, Paul Moore wrote:
> > > > On Wed, Jun 20, 2018 at 2:39 AM Joe Perches <joe@perches.com> wrote:
> > > > > pr_fmt can be used with the pr_<level> macros to prefix
> > > > > arbitrary content to logging messages.
> > > > >
> > > > > So add '#define pr_fmt(fmt) "SELinux: " fmt' to selinux files
> > > > > that use pr_<level> and remove embedded "SELinux: " prefixes
> > > > > from the format strings.
> > > []
> > > > What tree did you base your patch on?
> > >
> > > next-20180619 on the day it was sent.
> > >
> > > > Please base SELinux patches
> > > > either on the SELinux tree or Linus' tree.  The SELinux tree can be
> > > > found at the links below:
> > > >
> > > > * git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
> > > > * https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
> > >
> > > It's almost always better to use selinux/next.
> > > Why should this patch be different?
> >
> > Yes, that's what I said, please base your patch against the selinux/next branch.
>
> Again, this patch was based on that branch on the date the
> patch was sent.
>
> It still applies today to -next.

It doesn't apply cleanly to the selinux/next branch, I believe because
there are other trees which have made changes under security/selinux/*
(I believe there was some fs related work from David Howells that
touched some SELinux/LSM code).

As I said earlier, if you want me to apply your patches to the SELinux
tree, please base them either against the selinux/next tree or against
Linus' tree.

-- 
paul moore
www.paul-moore.com
