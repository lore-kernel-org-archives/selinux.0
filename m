Message-ID: <d729f7dc451cf26f5fdb63e44930c8fb67da41d3.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 peter.enderborg@sony.com, selinux@tycho.nsa.gov,
 linux-kernel@vger.kernel.org
Date: Mon, 02 Jul 2018 14:31:32 -0700
In-Reply-To: <CAHC9VhS_UmWfv0aFGLfaqw-fLSmoGiDEcXGFZ3bvwNgp2PF=zg@mail.gmail.com>
References: <3880c8030c55a97ee38335fc0dbf5dfd4f296c59.1529476660.git.joe@perches.com>
 <CAHC9VhS_UmWfv0aFGLfaqw-fLSmoGiDEcXGFZ3bvwNgp2PF=zg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Subject: Re: [PATCH] selinux: Use pr_fmt to prefix "SELinux: "
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2018-07-02 at 16:51 -0400, Paul Moore wrote:
> On Wed, Jun 20, 2018 at 2:39 AM Joe Perches <joe@perches.com> wrote:
> > pr_fmt can be used with the pr_<level> macros to prefix
> > arbitrary content to logging messages.
> > 
> > So add '#define pr_fmt(fmt) "SELinux: " fmt' to selinux files
> > that use pr_<level> and remove embedded "SELinux: " prefixes
> > from the format strings.

[]
> > @@ -1644,13 +1640,12 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
> > 
> >                                 if (rc == -EINVAL) {
> >                                         if (printk_ratelimit())
> > -                                               pr_notice("SELinux: inode=%lu on dev=%s was found to have an invalid "
> > -                                                       "context=%s.  This indicates you may need to relabel the inode or the "
> > -                                                       "filesystem in question.\n", ino, dev, context);
> > +                                               pr_notice("inode=%lu on dev=%s was found to have an invalid context=%s.  This indicates you may need to relabel the inode or the filesystem in question.\n",
> > +                                                         ino, dev, context);
> 
> Please split up lines like this.  I realize that there isn't much room
> left, but this message wraps a silly amount in my 80-char terminal; if
> you need to wrap, please limit it to a word or two.
> 
> To stop the argument before it starts, I don't care what checkpatch.pl
> says about splitting printk format strings like this.

I do, so does Linus.  It's also specified in CodingStyle.

2) Breaking long lines and strings
----------------------------------
[]
never break user-visible strings such as
printk messages, because that breaks the ability to grep for them.
----------------------------------

Likely this would also use pr_notice_ratelimited(etc...)
to reduce indentation a bit too.

Probably these should be output on 2 lines as the output
dmesg line length is extremely long.

> What tree did you base your patch on?

next-20180619 on the day it was sent. 

> Please base SELinux patches
> either on the SELinux tree or Linus' tree.  The SELinux tree can be
> found at the links below:
> 
> * git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
> * https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git

It's almost always better to use selinux/next.
Why should this patch be different?

cheers, Joe
