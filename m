Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w85BbCjC012694
 for <selinux@tycho.nsa.gov>; Wed, 5 Sep 2018 07:37:12 -0400
Received: by mail-lf1-f66.google.com with SMTP id e23-v6so5650959lfc.13
 for <selinux@tycho.nsa.gov>; Wed, 05 Sep 2018 04:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180904205136.27935-1-sds@tycho.nsa.gov>
 <CAHC9VhQfL6c-D+TkPzdTv6=R3V2B8+7ngDEtPivU30U78Ze6Hw@mail.gmail.com>
In-Reply-To: <CAHC9VhQfL6c-D+TkPzdTv6=R3V2B8+7ngDEtPivU30U78Ze6Hw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 5 Sep 2018 07:36:53 -0400
Message-ID: <CAHC9VhQhQqV5OFQ8BJpjBo3OBLpbp8fb4ApRoSA0LT3+emDbxA@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, dvyukov@google.com, longman@redhat.com,
 stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: fix mounting of cgroup2 under older
 policies
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Sep 4, 2018 at 6:18 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Sep 4, 2018 at 4:49 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >
> > commit 901ef845fa2469c ("selinux: allow per-file labeling for cgroupfs")
> > broke mounting of cgroup2 under older SELinux policies which lacked
> > a genfscon rule for cgroup2.  This prevents mounting of cgroup2 even
> > when SELinux is permissive.
> >
> > Change the handling when there is no genfscon rule in policy to
> > just mark the inode unlabeled and not return an error to the caller.
> > This permits mounting and access if allowed by policy, e.g. to
> > unconfined domains.
> >
> > I also considered changing the behavior of security_genfs_sid() to
> > never return -ENOENT, but the current behavior is relied upon by
> > other callers to perform caller-specific handling.
> >
> > Fixes: 901ef845fa2469c ("selinux: allow per-file labeling for cgroupfs")
> > CC: <stable@vger.kernel.org>
> > Reported-by: Dmitry Vyukov <dvyukov@google.com>
> > Reported-by: Waiman Long <longman@redhat.com>
> > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> > ---
> >  security/selinux/hooks.c | 5 +++++
> >  1 file changed, 5 insertions(+)
>
> Looks like a reasonable approach to me, merged into selinux/next, thanks.

I probably should expand a bit on this as Stephen's stable CC marking
and the patch's inclusion in selinux/next (as opposed to
selinux/stable-4.19) don't quite match.  I merged this into the next
branch because I didn't feel that this was a severe enough problem to
warrant immediate inclusion into the stable-4.19 branch and since this
is a user visible change I felt some additional time in the next
branch would be valuable.  However, I did leave the CC stable marking
intact so that when this patch does hit Linus tree (expected during
the v4.20 merge window) it should get backported to the various stable
trees.

> As a FYI, since the US holiday and LSS-NA delayed the start of merging
> things into selinux/next I've updated selinux/next on top of v4.19-rc2
> instead of -rc1 this time around.
>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index f78318af8254..58fee382a3bb 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -1508,6 +1508,11 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
> >                 }
> >                 rc = security_genfs_sid(&selinux_state, sb->s_type->name,
> >                                         path, tclass, sid);
> > +               if (rc == -ENOENT) {
> > +                       /* No match in policy, mark as unlabeled. */
> > +                       *sid = SECINITSID_UNLABELED;
> > +                       rc = 0;
> > +               }
> >         }
> >         free_page((unsigned long)buffer);
> >         return rc;
> > --
> > 2.14.4
>
> --
> paul moore
> www.paul-moore.com



-- 
paul moore
www.paul-moore.com
