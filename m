Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70EC1F2361
	for <selinux@vger.kernel.org>; Fri,  4 Apr 2025 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743775207; cv=none; b=IPRO56qp3bJQ4Cj4tM+GmGowyGg75H6PjTcBiCpnZZHhd9eIvwXXVRa9pU+AubGIn2Lu/7oMsA49tmreP74bfzZ0sOp1gkfwXQjhHHTCeC92KSuM2nzjwgxm+luRmOJ9CxK9Z5ogPCnmoLT6QgIy1CxOZhh0VCd8ysVjPl5Z16Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743775207; c=relaxed/simple;
	bh=mCSpioFszQpeWo7NfX062w8/T6iW2HU19QzwIRn41zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hG+hjg05S9o2yrNQedN/LuTpaaaCp6Jsbyzc8tbzbTRzb0dJyzIrTdIxbL8/5VRDlSKfioIXI/+s/awnfghC0T8+iF5dCOHgeYBOXlN4s0rJQyQh6ZMtV+DvPVgp+RpnjimayJIAlN/gYRt7PaoKVFcY36zfjKCUGQhvxiKrkMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIv3iBIl; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIv3iBIl"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-afc857702d1so88996a12.3
        for <selinux@vger.kernel.org>; Fri, 04 Apr 2025 07:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743775205; x=1744380005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/nPO5D0FxaPsBsFhHjjwdWYM1QGJKDXnVUm51tUiT4=;
        b=nIv3iBIlku9yn4qdc82J1rcjjjoAAE4UmgK1oQSImBu3rQlkWy1d+8KmKgr7iVl/4u
         dBynFgwMP2fw/Tz1Y0ygcQq1It9pLza+tmzut633xGB/Wj8fA0SjsTdPlJgT80ckf2XE
         mcArFFfmb6l5DSn8d9fMdR5QI1D8lQ0PSNj6/GCPwp+x8NsL3TeJUns1v7Wqs3AfPB5a
         zUAyEJTyLeoo6arw4quYpN+La0K9vyUbSwFClaEYRHuzzr5nbtY8BloKOGsu7zwtoZvc
         9RdencrZEgzKLFc1Nxtpp/nMmbGXTALOhX8hXouqNsVXjjeBT09QpkhBnmbQl4fYsmJM
         yfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743775205; x=1744380005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/nPO5D0FxaPsBsFhHjjwdWYM1QGJKDXnVUm51tUiT4=;
        b=gY+duOKJl+Ht1eBFqkGnXX+Re3hw4hfAKrTE/708Zb8WFEOek72MoLrzdGqwy538tX
         1cDdHgGFWJI/jWYqrpl5gJgkTzncxUU20/W7hqvp66sZLlKew8jQzgk6BzUaAYFpLIiF
         wQVHjPQtB+/FvlV+5ZoTsynWVdZvimBhk4msJxKcnPnmCbwNkLW+Bh141OBdvaazaCt/
         0bpkzdkovap8gzUWptIKSM9adgNu2+GUbbxgFG1oHUHFnJlULWX1R0G9qaxLTlNwVHi2
         a9x6anjbvjcJj37MKYnPNBgP+Ornnxid4xg8z1puB76n4l3JpuakJ0Sy1/eWnW79d0K/
         ENrw==
X-Gm-Message-State: AOJu0YwBvoTNpX7hcY74f8O7N9EJ24JDxZH4Qp8+an0kzXQI5BEcaQFW
	NHjHvg0MBGYzbWgDVAhGDuUYlvbasNNWqggSMEQkfo0QVc4diXkbOPtY0Whqa3N/zpGZ4Am5KAh
	6H/pFmkxipkTtsqDFWPmIoZxbCpk=
X-Gm-Gg: ASbGncsvm4T5baICjS/QaTc+Mv8BLmknwz5+fka7xwkPOgWxpHNfvQYdSPulCPMHjcC
	hqN/zM7/g19GC6GMNABhRSm0nxQZZSiW3oCmNYRYO/AvxZ7rWieCigFaHAxO5Nn6B612h5pmPbY
	CAAPnH+tlXoJOVWJAK3cR/Xshs9g==
X-Google-Smtp-Source: AGHT+IF/ITH+/gjorYgsO0TA1oFW53MDIs4TViAJJWFtKsqNeLffAg8dhXQuTc2kn8gGqjRIIpUAHYzZZnlh3bMN47o=
X-Received: by 2002:a17:90b:53c3:b0:2ff:6f8a:3a13 with SMTP id
 98e67ed59e1d1-306a497242fmr4726696a91.25.1743775204722; Fri, 04 Apr 2025
 07:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402203052.237444-2-paul@paul-moore.com>
In-Reply-To: <20250402203052.237444-2-paul@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 4 Apr 2025 09:59:52 -0400
X-Gm-Features: AQ5f1JoSdxzBgGdgR0O4Dm8ffNMJdqa5f0Qgbh2eaksu-rJ9v1z2WdIQhNXZWjw
Message-ID: <CAEjxPJ7zEv5zt5i-fhrnytQKuu4YUEZSXUNjvZcOsbh6ETs99Q@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: reduce path walk overhead
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 4:31=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
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
> ---
>  security/selinux/hooks.c          | 216 +++++++++++++++++++++++-------
>  security/selinux/include/objsec.h |  14 ++
>  2 files changed, 181 insertions(+), 49 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7b867dfec88b..df2bc01175b4 100644
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
> @@ -278,27 +280,20 @@ static int __inode_security_revalidate(struct inode=
 *inode,
>                                        struct dentry *dentry,
>                                        bool may_sleep)
>  {
> -       struct inode_security_struct *isec =3D selinux_inode(inode);
> +       if (!selinux_initialized())
> +               return 0;

Any particular reason you didn't lift this test up to the callers as
with the isec->initialized test? Or alternatively, leave these tests
in this function and just inline it?

>
>         might_sleep_if(may_sleep);
> +       if (!may_sleep)
> +               return -ECHILD;
>
>         /*
> -        * The check of isec->initialized below is racy but
> -        * inode_doinit_with_dentry() will recheck with
> -        * isec->lock held.
> +        * Check to ensure that an inode's SELinux state is invalid and t=
ry

is valid

> +        * reloading the inode security label if necessary.  This will fa=
il if
> +        * @dentry is NULL and no dentry for this inode can be found; in =
that
> +        * case, continue using the old label.
>          */
> -       if (selinux_initialized() &&
> -           data_race(isec->initialized !=3D LABEL_INITIALIZED)) {

Don't appear to have lifted the isec->initialized check up into
dentry_has_perm() and path_has_perm()? A possible reason to keep the
checks in this function and just inline them.

> @@ -2313,6 +2320,9 @@ static int selinux_bprm_creds_for_exec(struct linux=
_binprm *bprm)
>         new_tsec->keycreate_sid =3D 0;
>         new_tsec->sockcreate_sid =3D 0;
>
> +       /* Reset AVD cache, transfer the old_tsec cache later if possible=
. */
> +       new_tsec->avdcache.sid =3D 0;
> +

Since we'll know whether or not we need to do this before the end of
this function, could just wait?

>         /*
>          * Before policy is loaded, label any task outside kernel space
>          * as SECINITSID_INIT, so that any userspace tasks surviving from
> @@ -2406,6 +2416,11 @@ static int selinux_bprm_creds_for_exec(struct linu=
x_binprm *bprm)
>                 bprm->secureexec |=3D !!rc;
>         }
>
> +       /* Transfer the AVD cache if the SIDs match. */
> +       if (new_tsec->sid =3D=3D old_tsec->sid)
> +               memcpy(&new_tsec->avdcache, &old_tsec->avdcache,
> +                      sizeof(old_tsec->avdcache));
> +

Shouldn't be needed, right, since selinux_cred_transfer() will have
already copied everything over from the old_tsec?

Should also reset the cache from selinux_lsm_setattr() with attr =3D=3D
LSM_ATTR_CURRENT.

> @@ -3088,44 +3103,147 @@ static noinline int audit_inode_permission(struc=
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

Since we mediate any task SID changes, we can invalidate the cache
upon them immediately and then shouldn't need to actually store the
task SID in the cache or check it each time during lookup.

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

Ditto.
