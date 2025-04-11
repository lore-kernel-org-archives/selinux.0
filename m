Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00870148850
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377313; cv=none; b=ozjlRDwUqiM7f07sgf62oVlqW1d6XOwHueIkHsFfKS4vM+BIjs4qfhrhar0VWjt8RqTViCAp2zjpHzcO5R+20K9ZmI1ixapUpFTrp5diSWB2+6MP80HxP4IdG9xVf1OWNpjuDFgvvrI4ag0Tb6sJL9qw/DOwFpccR3wFTv0SNAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377313; c=relaxed/simple;
	bh=3YBjD2aS16Cm+UVu+CoELVANUd2MpTI5VYlZTZ+tSZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NbzciTmQN7dKwzqjB3IF+brf+GiybIIc0mYWdV1dIRFjKITqr8vSbNN1Xi3+ovxr1Ra65RmzZhzMJNXalMWbyAQuMeGSWdBTzL5RcP94/olbLbfB6dfTc4xDl3/Fwb5Cgzz3QYmHyac+l24Z83xLIo798Q5TMVXs7v/RNRq3OIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRaUBhRh; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRaUBhRh"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-303a66af07eso1584290a91.2
        for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 06:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744377310; x=1744982110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBSrhePFCW+PD8VsOXk85iIBJFUcWw2YgMZ/PZhm6x4=;
        b=ZRaUBhRhjMN9w1vSB1QOXt6IbKgmnAAtyyc53JvtL03F4b1B1DgaodflfnBe6cAED1
         KWwU3hbvVoFMj27YGekMmCnM6dT8HUQYNCF0kF3IPcVPwFIIszfVabHUvjzaJ9h58scY
         NzTZAObLqW0uI5Nucl3wpg09MWFjLbcd9Ck/HzvC8sAsVAn8AjK1JbAFl7aPW4Hu442d
         q19DPvkqpXJKAZdGWas8PfPwp+5DtFbr1dPio1zsDKsiy5Tx98QmxonIucUI5i0Tw1Tz
         iaqqFOKYnH1T9dyz3dh3Ofn03CQANIo+REEND7p8U5K8H0FD8kVQYgu8f4/mAVW0fCQh
         8fIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744377310; x=1744982110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBSrhePFCW+PD8VsOXk85iIBJFUcWw2YgMZ/PZhm6x4=;
        b=A2SKwEbMCXxZDmZl7IENjDDP+dySO5pfVxgVKqXPTFMN/Dq2WlvFtdD5Npl5tWYh45
         Kh7NeV6g496LqToNgBAKk3c26iH0IL+521uc8orbA1RwExIHhR8IK7YRYp0VyPT4l9zo
         TqUlpaDjpb+pJGZdUoymQ+m2dgvNNvmblSXbCtj+yVS5OAaHsf6iHw94VWVyygBBKsa7
         UPo7WFUaRh9uSAe3boZEZI8yqIzcEcMBwaDgXNjiiXzR6yYQl+t+7Wmi9AwmUyY6Etue
         L1xJ7r+D0Bsqowf3U8M6iSMBZEcxTXuI5Njo1cZ6tAWr+k0f04hO/kPSx5s6tC9zDeT9
         pGqw==
X-Gm-Message-State: AOJu0YyJps4V+5u4Pa31s2iq5EPB6wa3rz7bx7oxOia/mKzxQLlrGkPL
	oQvFl4GfJKP6cfXg063zPIgoF/XBft/1bprI1X6u07mnZIXSIGxwfQ+eUEufIUhHzTdwwKV/ESH
	1OlRm5SUpD1XTpTgeUZuC4OWO+UR8MpTl
X-Gm-Gg: ASbGncv3uXOzgjRRpdaG6k8jPGdgPbTpMcXvrYGqkzfH8DRjxQBOUuhozmjXLBk6lo9
	wMpbiDjjKWfd0+neJxsZtJUg93/7lz16WT/3Qg4yh57GZT9mowVbj1Hiakpi3lfCeGWLzgO4wZH
	P8Mtaj6dARI+ga3yct95JwDw==
X-Google-Smtp-Source: AGHT+IHHmXaWbbf3RuB6bfOexHclWZ3I6k1a3LduuVD+/IQ0+KeJYSyYz2M4YbkKCP7BUTFMs5i4mK6XfCjfiDrQGXk=
X-Received: by 2002:a17:90b:2751:b0:305:2d68:8d39 with SMTP id
 98e67ed59e1d1-3082377c2c4mr5338080a91.12.1744377309733; Fri, 11 Apr 2025
 06:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410192031.259180-2-paul@paul-moore.com>
In-Reply-To: <20250410192031.259180-2-paul@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 11 Apr 2025 09:14:58 -0400
X-Gm-Features: ATxdqUHQiEHJ4OUpyXJj68A_MQUC5K2AiRVgNy4uLt64WJgpfZPw_5B7rWtPkhQ
Message-ID: <CAEjxPJ4G6+f74EA4usHA+ZqW_tuVXCkft-2+3wApXVpRMtMNEg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: reduce path walk overhead
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 3:25=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Reduce the SELinux performance overhead during path walks through the
> use of a per-task directory access cache and some minor code
> optimizations.  The directory access cache is per-task because it allows
> for a lockless cache while also fitting well with a common application
> pattern of heavily accessing a relatively small number of SELinux
> directory labels.  The cache is inherited by child processes when the
> child runs with the same SELinux domain as the parent, and invalidated
> on changes to the task's SELinux domain or the loaded SELinux policy.
> A cache of four entries was chosen based on testing with the Fedora
> "targeted" policy, a SELinux Reference Policy variant, and
> 'make allmodconfig' on Linux v6.14.
>
> Code optimizations include better use of inline functions to reduce
> function calls in the common case, especially in the inode revalidation
> code paths, and elimination of redundant checks between the LSM and
> SELinux layers.
>
> As mentioned briefly above, aside from general use and regression
> testing with the selinux-testsuite, performance was measured using
> 'make allmodconfig' with Linux v6.14 as a base reference.  As expected,
> there were variations from one test run to another, but the measurements
> below are a good representation of the test results seen on my test
> system.
>
>  * Linux v6.14
>    REF
>      1.26%  [k] __d_lookup_rcu
>    SELINUX (1.31%)
>      0.58%  [k] selinux_inode_permission
>      0.29%  [k] avc_lookup
>      0.25%  [k] avc_has_perm_noaudit
>      0.19%  [k] __inode_security_revalidate
>
>  * Linux v6.14 + patch
>    REF
>      1.41%  [k] __d_lookup_rcu
>    SELINUX (0.89%)
>      0.65%  [k] selinux_inode_permission
>      0.15%  [k] avc_lookup
>      0.05%  [k] avc_has_perm_noaudit
>      0.04%  [k] avc_policy_seqno
>      X.XX%  [k] __inode_security_revalidate (now inline)
>
> In both cases the __d_lookup_rcu() function was used as a reference
> point to establish a context for the SELinux related functions.  On a
> unpatched Linux v6.14 system we see the time spent in the combined
> SELinux functions exceeded that of __d_lookup_rcu(), 1.31% compared to
> 1.26%.  However, with this patch applied the time spent in the combined
> SELinux functions dropped to roughly 65% of the time spent in
> __d_lookup_rcu(), 0.89% compared to 1.41%.  Aside from the significant
> decrease in time spent in the SELinux AVC, it appears that any additional
> time spent searching and updating the cache is offset by other code
> improvements, e.g. time spent in selinux_inode_permission() +
> __inode_security_revalidate() + avc_policy_seqno() is less on the
> patched kernel than the unpatched kernel.
>
> It is worth noting that in this patch the use of the per-task cache is
> limited to the security_inode_permission() LSM callback,
> selinux_inode_permission(), but future work could expand the cache into
> inode_has_perm(), likely through consolidation of the two functions.
> While this would likely have little to no impact on path walks, it
> may benefit other operations.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Thanks for doing this!

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/hooks.c          | 225 +++++++++++++++++++++++-------
>  security/selinux/include/objsec.h |  14 ++
>  2 files changed, 185 insertions(+), 54 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e7a7dcab81db..edc9ae81e202 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -213,8 +213,10 @@ static void cred_init_security(void)
>  {
>         struct task_security_struct *tsec;
>
> +       /* NOTE: the lsm framework zeros out the buffer on allocation */
> +
>         tsec =3D selinux_cred(unrcu_pointer(current->real_cred));
> -       tsec->osid =3D tsec->sid =3D SECINITSID_KERNEL;
> +       tsec->osid =3D tsec->sid =3D tsec->avdcache.sid =3D SECINITSID_KE=
RNEL;
>  }
>
>  /*
> @@ -278,27 +280,21 @@ static int __inode_security_revalidate(struct inode=
 *inode,
>                                        struct dentry *dentry,
>                                        bool may_sleep)
>  {
> -       struct inode_security_struct *isec =3D selinux_inode(inode);
> +       if (!selinux_initialized())
> +               return 0;
>
> -       might_sleep_if(may_sleep);
> +       if (may_sleep)
> +               might_sleep();
> +       else
> +               return -ECHILD;
>
>         /*
> -        * The check of isec->initialized below is racy but
> -        * inode_doinit_with_dentry() will recheck with
> -        * isec->lock held.
> +        * Check to ensure that an inode's SELinux state is valid and try
> +        * reloading the inode security label if necessary.  This will fa=
il if
> +        * @dentry is NULL and no dentry for this inode can be found; in =
that
> +        * case, continue using the old label.
>          */
> -       if (selinux_initialized() &&
> -           data_race(isec->initialized !=3D LABEL_INITIALIZED)) {
> -               if (!may_sleep)
> -                       return -ECHILD;
> -
> -               /*
> -                * Try reloading the inode security label.  This will fai=
l if
> -                * @opt_dentry is NULL and no dentry for this inode can b=
e
> -                * found; in that case, continue using the old label.
> -                */
> -               inode_doinit_with_dentry(inode, dentry);
> -       }
> +       inode_doinit_with_dentry(inode, dentry);
>         return 0;
>  }
>
> @@ -307,41 +303,53 @@ static struct inode_security_struct *inode_security=
_novalidate(struct inode *ino
>         return selinux_inode(inode);
>  }
>
> -static struct inode_security_struct *inode_security_rcu(struct inode *in=
ode, bool rcu)
> +static inline struct inode_security_struct *inode_security_rcu(struct in=
ode *inode,
> +                                                              bool rcu)
>  {
> -       int error;
> +       int rc;
> +       struct inode_security_struct *isec =3D selinux_inode(inode);
>
> -       error =3D __inode_security_revalidate(inode, NULL, !rcu);
> -       if (error)
> -               return ERR_PTR(error);
> -       return selinux_inode(inode);
> +       /* check below is racy, but revalidate will recheck with lock hel=
d */
> +       if (data_race(likely(isec->initialized =3D=3D LABEL_INITIALIZED))=
)
> +               return isec;
> +       rc =3D __inode_security_revalidate(inode, NULL, !rcu);
> +       if (rc)
> +               return ERR_PTR(rc);
> +       return isec;
>  }
>
>  /*
>   * Get the security label of an inode.
>   */
> -static struct inode_security_struct *inode_security(struct inode *inode)
> +static inline struct inode_security_struct *inode_security(struct inode =
*inode)
>  {
> +       struct inode_security_struct *isec =3D selinux_inode(inode);
> +
> +       /* check below is racy, but revalidate will recheck with lock hel=
d */
> +       if (data_race(likely(isec->initialized =3D=3D LABEL_INITIALIZED))=
)
> +               return isec;
>         __inode_security_revalidate(inode, NULL, true);
> -       return selinux_inode(inode);
> +       return isec;
>  }
>
> -static struct inode_security_struct *backing_inode_security_novalidate(s=
truct dentry *dentry)
> +static inline struct inode_security_struct *backing_inode_security_noval=
idate(struct dentry *dentry)
>  {
> -       struct inode *inode =3D d_backing_inode(dentry);
> -
> -       return selinux_inode(inode);
> +       return selinux_inode(d_backing_inode(dentry));
>  }
>
>  /*
>   * Get the security label of a dentry's backing inode.
>   */
> -static struct inode_security_struct *backing_inode_security(struct dentr=
y *dentry)
> +static inline struct inode_security_struct *backing_inode_security(struc=
t dentry *dentry)
>  {
>         struct inode *inode =3D d_backing_inode(dentry);
> +       struct inode_security_struct *isec =3D selinux_inode(inode);
>
> +       /* check below is racy, but revalidate will recheck with lock hel=
d */
> +       if (data_race(likely(isec->initialized =3D=3D LABEL_INITIALIZED))=
)
> +               return isec;
>         __inode_security_revalidate(inode, dentry, true);
> -       return selinux_inode(inode);
> +       return isec;
>  }
>
>  static void inode_free_security(struct inode *inode)
> @@ -1683,12 +1691,15 @@ static inline int dentry_has_perm(const struct cr=
ed *cred,
>                                   struct dentry *dentry,
>                                   u32 av)
>  {
> -       struct inode *inode =3D d_backing_inode(dentry);
>         struct common_audit_data ad;
> +       struct inode *inode =3D d_backing_inode(dentry);
> +       struct inode_security_struct *isec =3D selinux_inode(inode);
>
>         ad.type =3D LSM_AUDIT_DATA_DENTRY;
>         ad.u.dentry =3D dentry;
> -       __inode_security_revalidate(inode, dentry, true);
> +       /* check below is racy, but revalidate will recheck with lock hel=
d */
> +       if (data_race(unlikely(isec->initialized !=3D LABEL_INITIALIZED))=
)
> +               __inode_security_revalidate(inode, dentry, true);
>         return inode_has_perm(cred, inode, av, &ad);
>  }
>
> @@ -1699,12 +1710,15 @@ static inline int path_has_perm(const struct cred=
 *cred,
>                                 const struct path *path,
>                                 u32 av)
>  {
> -       struct inode *inode =3D d_backing_inode(path->dentry);
>         struct common_audit_data ad;
> +       struct inode *inode =3D d_backing_inode(path->dentry);
> +       struct inode_security_struct *isec =3D selinux_inode(inode);
>
>         ad.type =3D LSM_AUDIT_DATA_PATH;
>         ad.u.path =3D *path;
> -       __inode_security_revalidate(inode, path->dentry, true);
> +       /* check below is racy, but revalidate will recheck with lock hel=
d */
> +       if (data_race(unlikely(isec->initialized !=3D LABEL_INITIALIZED))=
)
> +               __inode_security_revalidate(inode, path->dentry, true);
>         return inode_has_perm(cred, inode, av, &ad);
>  }
>
> @@ -3088,44 +3102,147 @@ static noinline int audit_inode_permission(struc=
t inode *inode,
>                             audited, denied, result, &ad);
>  }
>
> -static int selinux_inode_permission(struct inode *inode, int mask)
> +/**
> + * task_avdcache_reset - Reset the task's AVD cache
> + * @tsec: the task's security state
> + *
> + * Clear the task's AVD cache in @tsec and reset it to the current polic=
y's
> + * and task's info.
> + */
> +static inline void task_avdcache_reset(struct task_security_struct *tsec=
)
>  {
> +       memset(&tsec->avdcache.dir, 0, sizeof(tsec->avdcache.dir));
> +       tsec->avdcache.sid =3D tsec->sid;
> +       tsec->avdcache.seqno =3D avc_policy_seqno();
> +       tsec->avdcache.dir_spot =3D TSEC_AVDC_DIR_SIZE - 1;
> +}
> +
> +/**
> + * task_avdcache_search - Search the task's AVD cache
> + * @tsec: the task's security state
> + * @isec: the inode to search for in the cache
> + * @avdc: matching avd cache entry returned to the caller
> + *
> + * Search @tsec for a AVD cache entry that matches @isec and return it t=
o the
> + * caller via @avdc.  Returns 0 if a match is found, negative values oth=
erwise.
> + */
> +static inline int task_avdcache_search(struct task_security_struct *tsec=
,
> +                                      struct inode_security_struct *isec=
,
> +                                      struct avdc_entry **avdc)
> +{
> +       int orig, iter;
> +
> +       /* focused on path walk optimization, only cache directories */
> +       if (isec->sclass !=3D SECCLASS_DIR)
> +               return -ENOENT;
> +
> +       if (unlikely(tsec->sid !=3D tsec->avdcache.sid ||
> +                    tsec->avdcache.seqno !=3D avc_policy_seqno())) {
> +               task_avdcache_reset(tsec);
> +               return -ENOENT;
> +       }
> +
> +       orig =3D iter =3D tsec->avdcache.dir_spot;
> +       do {
> +               if (tsec->avdcache.dir[iter].isid =3D=3D isec->sid) {
> +                       /* cache hit */
> +                       tsec->avdcache.dir_spot =3D iter;
> +                       *avdc =3D &tsec->avdcache.dir[iter];
> +                       return 0;
> +               }
> +               iter =3D (iter - 1) & (TSEC_AVDC_DIR_SIZE - 1);
> +       } while (iter !=3D orig);
> +
> +       return -ENOENT;
> +}
> +
> +/**
> + * task_avdcache_update - Update the task's AVD cache
> + * @tsec: the task's security state
> + * @isec: the inode associated with the cache entry
> + * @avdc: the AVD info to cache
> + * @audited: the permission audit bitmask to cache
> + *
> + * Update the AVD cache in @tsec with the @avdc and @audited info associ=
ated
> + * with @isec.
> + */
> +static inline void task_avdcache_update(struct task_security_struct *tse=
c,
> +                                       struct inode_security_struct *ise=
c,
> +                                       struct av_decision *avd,
> +                                       u32 audited)
> +{
> +       int spot;
> +
> +       /* focused on path walk optimization, only cache directories */
> +       if (isec->sclass !=3D SECCLASS_DIR)
> +               return;
> +
> +       /* update cache */
> +       spot =3D (tsec->avdcache.dir_spot + 1) & (TSEC_AVDC_DIR_SIZE - 1)=
;
> +       tsec->avdcache.dir_spot =3D spot;
> +       tsec->avdcache.dir[spot].isid =3D isec->sid;
> +       tsec->avdcache.dir[spot].audited =3D audited;
> +       tsec->avdcache.dir[spot].allowed =3D avd->allowed;
> +       tsec->avdcache.dir[spot].permissive =3D avd->flags & AVD_FLAGS_PE=
RMISSIVE;
> +}
> +
> +/**
> + * selinux_inode_permission - Check if the current task can access an in=
ode
> + * @inode: the inode that is being accessed
> + * @requested: the accesses being requested
> + *
> + * Check if the current task is allowed to access @inode according to
> + * @requested.  Returns 0 if allowed, negative values otherwise.
> + */
> +static int selinux_inode_permission(struct inode *inode, int requested)
> +{
> +       int mask;
>         u32 perms;
> -       bool from_access;
> -       bool no_block =3D mask & MAY_NOT_BLOCK;
> +       struct task_security_struct *tsec;
>         struct inode_security_struct *isec;
> -       u32 sid =3D current_sid();
> -       struct av_decision avd;
> +       struct avdc_entry *avdc;
>         int rc, rc2;
>         u32 audited, denied;
>
> -       from_access =3D mask & MAY_ACCESS;
> -       mask &=3D (MAY_READ|MAY_WRITE|MAY_EXEC|MAY_APPEND);
> +       mask =3D requested & (MAY_READ|MAY_WRITE|MAY_EXEC|MAY_APPEND);
>
>         /* No permission to check.  Existence test. */
>         if (!mask)
>                 return 0;
>
> -       if (unlikely(IS_PRIVATE(inode)))
> -               return 0;
> -
> -       perms =3D file_mask_to_av(inode->i_mode, mask);
> -
> -       isec =3D inode_security_rcu(inode, no_block);
> +       isec =3D inode_security_rcu(inode, requested & MAY_NOT_BLOCK);
>         if (IS_ERR(isec))
>                 return PTR_ERR(isec);
> +       tsec =3D selinux_cred(current_cred());
> +       perms =3D file_mask_to_av(inode->i_mode, mask);
> +
> +       rc =3D task_avdcache_search(tsec, isec, &avdc);
> +       if (likely(!rc)) {
> +               /* Cache hit. */
> +               audited =3D perms & avdc->audited;
> +               denied =3D perms & ~avdc->allowed;
> +               if (unlikely(denied && enforcing_enabled() &&
> +                            !avdc->permissive))
> +                       rc =3D -EACCES;
> +       } else {
> +               struct av_decision avd;
> +
> +               /* Cache miss. */
> +               rc =3D avc_has_perm_noaudit(tsec->sid, isec->sid, isec->s=
class,
> +                                         perms, 0, &avd);
> +               audited =3D avc_audit_required(perms, &avd, rc,
> +                       (requested & MAY_ACCESS) ? FILE__AUDIT_ACCESS : 0=
,
> +                       &denied);
> +               task_avdcache_update(tsec, isec, &avd, audited);
> +       }
>
> -       rc =3D avc_has_perm_noaudit(sid, isec->sid, isec->sclass, perms, =
0,
> -                                 &avd);
> -       audited =3D avc_audit_required(perms, &avd, rc,
> -                                    from_access ? FILE__AUDIT_ACCESS : 0=
,
> -                                    &denied);
>         if (likely(!audited))
>                 return rc;
>
>         rc2 =3D audit_inode_permission(inode, perms, audited, denied, rc)=
;
>         if (rc2)
>                 return rc2;
> +
>         return rc;
>  }
>
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include=
/objsec.h
> index c88cae81ee4c..b00f8ac98b84 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -29,6 +29,13 @@
>  #include "flask.h"
>  #include "avc.h"
>
> +struct avdc_entry {
> +       u32 isid; /* inode SID */
> +       u32 allowed; /* allowed permission bitmask */
> +       u32 audited; /* audited permission bitmask */
> +       bool permissive; /* AVC permissive flag */
> +};
> +
>  struct task_security_struct {
>         u32 osid; /* SID prior to last execve */
>         u32 sid; /* current SID */
> @@ -36,6 +43,13 @@ struct task_security_struct {
>         u32 create_sid; /* fscreate SID */
>         u32 keycreate_sid; /* keycreate SID */
>         u32 sockcreate_sid; /* fscreate SID */
> +#define TSEC_AVDC_DIR_SIZE (1 << 2)
> +       struct {
> +               u32 sid; /* current SID for cached entries */
> +               u32 seqno; /* AVC sequence number */
> +               unsigned int dir_spot; /* dir cache index to check first =
*/
> +               struct avdc_entry dir[TSEC_AVDC_DIR_SIZE]; /* dir entries=
 */
> +       } avdcache;
>  } __randomize_layout;
>
>  enum label_initialized {
> --
> 2.49.0
>
>
