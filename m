Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w84MIsj1027505
 for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2018 18:18:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id s12-v6so4529089ljj.0
 for <selinux@tycho.nsa.gov>; Tue, 04 Sep 2018 15:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180904205136.27935-1-sds@tycho.nsa.gov>
In-Reply-To: <20180904205136.27935-1-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 4 Sep 2018 18:18:38 -0400
Message-ID: <CAHC9VhQfL6c-D+TkPzdTv6=R3V2B8+7ngDEtPivU30U78Ze6Hw@mail.gmail.com>
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

On Tue, Sep 4, 2018 at 4:49 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> commit 901ef845fa2469c ("selinux: allow per-file labeling for cgroupfs")
> broke mounting of cgroup2 under older SELinux policies which lacked
> a genfscon rule for cgroup2.  This prevents mounting of cgroup2 even
> when SELinux is permissive.
>
> Change the handling when there is no genfscon rule in policy to
> just mark the inode unlabeled and not return an error to the caller.
> This permits mounting and access if allowed by policy, e.g. to
> unconfined domains.
>
> I also considered changing the behavior of security_genfs_sid() to
> never return -ENOENT, but the current behavior is relied upon by
> other callers to perform caller-specific handling.
>
> Fixes: 901ef845fa2469c ("selinux: allow per-file labeling for cgroupfs")
> CC: <stable@vger.kernel.org>
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Reported-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c | 5 +++++
>  1 file changed, 5 insertions(+)

Looks like a reasonable approach to me, merged into selinux/next, thanks.

As a FYI, since the US holiday and LSS-NA delayed the start of merging
things into selinux/next I've updated selinux/next on top of v4.19-rc2
instead of -rc1 this time around.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f78318af8254..58fee382a3bb 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1508,6 +1508,11 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
>                 }
>                 rc = security_genfs_sid(&selinux_state, sb->s_type->name,
>                                         path, tclass, sid);
> +               if (rc == -ENOENT) {
> +                       /* No match in policy, mark as unlabeled. */
> +                       *sid = SECINITSID_UNLABELED;
> +                       rc = 0;
> +               }
>         }
>         free_page((unsigned long)buffer);
>         return rc;
> --
> 2.14.4

-- 
paul moore
www.paul-moore.com
