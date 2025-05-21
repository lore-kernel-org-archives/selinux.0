Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BC5263F25
	for <selinux@vger.kernel.org>; Wed, 21 May 2025 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747828370; cv=none; b=oCwKv4xBWWGUGWLg62mseMq18cuza9FUPXxC8J4K7oouI2llW91dESz7oa46X05tBiWWTxHfCT9XL2gjoY64eSct0K9gS5wZE9Qci8NsacDPMY2M9r5pLO29T8E1jf5o4bNZlaq6yfMAOPjmBcA4qXlsV+x6BLOHNP3Mwyi1vfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747828370; c=relaxed/simple;
	bh=86AeC0N78GgtztjzGHNFTpbYWEsSMhMIVRb1dwy5xYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCl/f6Gj7VLLcHcqdxTnIRkYke3qPMkV4hHEohYHKWVVmBgcXEd/OHnp7Cxo9VOFFPGNQfpJypQOfKI8rRmUjt+WB8z5IjBky9CvnjpB5GFiwvxaCAiPFuNoHHuvWWQlJguy3GhCBubqJQ7WC0RkneeLbuXZ7Lve/eMCy80ilUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ll7h4OK1; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ll7h4OK1"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-30e57a373c9so6643326a91.2
        for <selinux@vger.kernel.org>; Wed, 21 May 2025 04:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747828368; x=1748433168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFms1NdA+0rl2y6s/W6dDPOON+DzvXdo5k+cx4IcKzU=;
        b=Ll7h4OK1omu9zQCB/dPLzaRAd6dvz53hzrHWP+Ionq84hKrO9M+KvzkSxnWDQ1DSRY
         qbDI3Q9fSHNC2shghQR+FJxI3LgpaVJKLO25OhiY/PkmKZEsMHoG7Mk7K2RNkWqOQgE9
         E+JyjeVX2wVtGzl2wFl5dfjXeN5T9iQZnvH3bL77rFMJfohfcWIj+7s+FcJXoEN27LUc
         nRVynaSRM4E7xv1ytMAQhPm+5QtMfQ/TgVbydP72ErUbT2Lgtpi1Hff30N4s/D4Tr6LV
         CEQh6dAp2dTbSTnjbZcd9ZOEOfl5JH8MrDuZq9xOHUabSk32nIPe6LiSXGVqW/c2W8Da
         YiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747828368; x=1748433168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFms1NdA+0rl2y6s/W6dDPOON+DzvXdo5k+cx4IcKzU=;
        b=bvWZdcvOEW+8/Tb0TQtBQRZwgJkXD3p1ck61yyNhTMEeSM79hAGtEFcvBIXffIyYj/
         wuysIiHJytsKtJPfkjlpgGUX4GwF4mHTzwOptEws9dltNDJPxuEyocK57jNJh++u8pdM
         9mKmq7SjdTmnbcw8oGZbpMvGB7okHaneV4ISeWo9gz9tV4tCN57qxdMF/QydJ5/x9ha/
         wXfL9p1wRFZylxdJBxs99XdVKutz+riBy2IlqcP22x9d0u2lYByJvLEokyK0HGVvi9cB
         fuCZI8iHqSKskmaoxvHKOQOg2V5L1Zuil1W280EDvCCCsEA74h9ufKkur30KkkInRYuM
         ah5g==
X-Gm-Message-State: AOJu0YycBXV+qAhyE9hRzvEN5/o9VgkFU+chJHUvm0dEdq9UOCT3h9l+
	5dg2CJxM3Bvdt5cRhtOxL/jGT5iytTST584T6SGljqzNHi/G/QWah2bZOtvBuDxRTQXETk6LBEF
	axxHuXcKGDAUcwIZ74pOWOTj8Yeraob8=
X-Gm-Gg: ASbGncukzVMJyqm3jgFX23K3M18WHZ+VccFoCLYyy9nEWBplVKxHHF+XyJlHg0d0OeS
	R4stjNLuFsWbJJnxDV2oOmQS9spqFhRTg2T+/jLTiShWjRjz+5k3WukPhDGhKMapMlBR9yG0b5W
	KNoDR3Ev1UwX7tXzgKQAQsuLXlPqw9gg/G7NYBpxAUwMU=
X-Google-Smtp-Source: AGHT+IHoHaQyLgYYXmlw8GA96G5/SAeNqBHtVqA6I6q+jk5clNa29c+9go/XDpTDt9qP5JLaVlsH02Xm3Q3zAfBjItk=
X-Received: by 2002:a17:90b:58e4:b0:30c:4b1d:330 with SMTP id
 98e67ed59e1d1-30e7d5acb3bmr31735133a91.27.1747828368007; Wed, 21 May 2025
 04:52:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502170450.27160-3-stephen.smalley.work@gmail.com> <a0842c097e2b73c93954e2a414b3fad2@paul-moore.com>
In-Reply-To: <a0842c097e2b73c93954e2a414b3fad2@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 21 May 2025 07:52:37 -0400
X-Gm-Features: AX0GCFvJd6jYhZ_sIogFYiuKF4PeyKfCLeRBYWhMcoweGw_4G8tFGb7rHFbCfO0
Message-ID: <CAEjxPJ6jp1Y9uSB2fg6ODufuzvwu-Z3VFz-ER+xMh6escKAyHQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] selinux: optimize selinux_inode_getattr/permission()
 based on neveraudit|permissive
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 7:38=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On May  2, 2025 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> >
> > Extend the task avdcache to also cache whether the task SID is both
> > permissive and neveraudit, and return immediately if so in both
> > selinux_inode_getattr() and selinux_inode_permission().
> >
> > The same approach could be applied to many of the hook functions
> > although the avdcache would need to be updated for more than directory
> > search checks in order for this optimization to be beneficial for check=
s
> > on objects other than directories.
> >
> > To test, apply https://github.com/SELinuxProject/selinux/pull/473 to
> > your selinux userspace, build and install libsepol and secilc, and use
> > the following CIL policy module:
> > $ cat neverauditpermissive.cil
> > (typeneveraudit unconfined_t)
> > (typepermissive unconfined_t)
> >
> > Without this module inserted, running the following commands:
> >    perf record make -jN # on an already built allmodconfig tree
> >    perf report --sort=3Dsymbol,dso
> > yields the following percentages (only showing __d_lookup_rcu for
> > reference and only showing relevant SELinux functions):
> >    1.65%  [k] __d_lookup_rcu
> >    0.53%  [k] selinux_inode_permission
> >    0.40%  [k] selinux_inode_getattr
> >    0.15%  [k] avc_lookup
> >    0.05%  [k] avc_has_perm
> >    0.05%  [k] avc_has_perm_noaudit
> >    0.02%  [k] avc_policy_seqno
> >    0.02%  [k] selinux_file_permission
> >    0.01%  [k] selinux_inode_alloc_security
> >    0.01%  [k] selinux_file_alloc_security
> > for a total of 1.24% for SELinux compared to 1.65% for
> > __d_lookup_rcu().
> >
> > After running the following command to insert this module:
> >    semodule -i neverauditpermissive.cil
> > and then re-running the same perf commands from above yields
> > the following non-zero percentages:
> >    1.74%  [k] __d_lookup_rcu
> >    0.31%  [k] selinux_inode_permission
> >    0.03%  [k] selinux_inode_getattr
> >    0.03%  [k] avc_policy_seqno
> >    0.01%  [k] avc_lookup
> >    0.01%  [k] selinux_file_permission
> >    0.01%  [k] selinux_file_open
> > for a total of 0.40% for SELinux compared to 1.74% for
> > __d_lookup_rcu().
>
> I still don't like the hacky nature of the approach, but it's hard to
> ignore the performance improvement.
>
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  security/selinux/hooks.c          | 18 +++++++++++++++++-
> >  security/selinux/include/objsec.h |  1 +
> >  2 files changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index b8115df536ab..1a3806fdf3d6 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -3184,6 +3184,8 @@ static inline void task_avdcache_update(struct ta=
sk_security_struct *tsec,
> >       tsec->avdcache.dir[spot].audited =3D audited;
> >       tsec->avdcache.dir[spot].allowed =3D avd->allowed;
> >       tsec->avdcache.dir[spot].permissive =3D avd->flags & AVD_FLAGS_PE=
RMISSIVE;
>
> This obviously has nothing to do with your patch, but looking at this
> code has me wondering what my thinking was putting the permissive field
> in the avdc_entry struct instead of task_security_struct::avdcache.  We
> should probably move that ...

Well, it does exist as a per-avd flag so it was consistent with that.
Certainly willing to coalesce.

>
> > +     tsec->avdcache.permissive_neveraudit =3D
> > +             (avd->flags =3D=3D (AVD_FLAGS_PERMISSIVE|AVD_FLAGS_NEVERA=
UDIT));
> >  }
> >
> >  /**
> > @@ -3210,10 +3212,15 @@ static int selinux_inode_permission(struct inod=
e *inode, int requested)
> >       if (!mask)
> >               return 0;
> >
> > +     tsec =3D selinux_cred(current_cred());
> > +     if (tsec->avdcache.permissive_neveraudit &&
> > +             tsec->sid =3D=3D tsec->avdcache.sid &&
> > +             tsec->avdcache.seqno =3D=3D avc_policy_seqno())
> > +             return 0;
>
> Two things come to mind.  The first is that we should probably reorder
> the conditional to reduce the comparisons we need to do when we don't
> have a match.  We always need to check the SID and AVC seqno, so put
> those first:
>
>   if (tsec->sid =3D=3D tsec->avdcache.sid &&
>       tsec->avdcache.seqno =3D=3D avc_policy_seqno() &&
>       tsec->avdcache.permissive_neveraudit)
>     return 0;

No, the order was intentional to minimize the overhead imposed by this
logic for all cases:
1. If tsec->avdcache.permissive_neveraudit =3D=3D false, then we can
short-circuit the rest of the logic and thus minimize the overhead
imposed on non-(permissive+neveraudit) domains. In particular we don't
want to have to call avc_policy_seqno() unnecessarily.
2. If tsec->avdcache.permissive_neveraudit =3D=3D true, then we do need to
compare the SIDs and, if those are the same, we do need to call
avc_policy_seqno(), so again we minimize the overhead to only what is
needed.
Of the three conditions being tested, it is the permissive_neveraudit
bool that is most likely to evaluate to false (for all
non-(permissive+neveraudit) domains), whereas the other two conditions
will rarely be false (only upon a task SID change or policy reload,
neither of which is frequent).

>
> The second thing is that since we have this logic in at least one other
> place there may be some value in encapsulting it in a static inline:
>
>   static inline bool task_avdcache_permnoaudit(tsec)
>   {
>     if (tsec->sid =3D=3D tsec->avdcache.sid &&
>         tsec->avdcache.seqno =3D=3D avc_policy_seqno() &&
>         tsec->avdcache.permissive_neveraudit)
>       return true;
>     return false;
>   }

That's fine but will retain the original order for the reasons above.

>
> >       isec =3D inode_security_rcu(inode, requested & MAY_NOT_BLOCK);
> >       if (IS_ERR(isec))
> >               return PTR_ERR(isec);
> > -     tsec =3D selinux_cred(current_cred());
> >       perms =3D file_mask_to_av(inode->i_mode, mask);
> >
> >       rc =3D task_avdcache_search(tsec, isec, &avdc);
> > @@ -3277,6 +3284,15 @@ static int selinux_inode_setattr(struct mnt_idma=
p *idmap, struct dentry *dentry,
> >
> >  static int selinux_inode_getattr(const struct path *path)
> >  {
> > +     struct task_security_struct *tsec;
> > +
> > +     tsec =3D selinux_cred(current_cred());
> > +
> > +     if (tsec->avdcache.permissive_neveraudit &&
> > +             tsec->sid =3D=3D tsec->avdcache.sid &&
> > +             tsec->avdcache.seqno =3D=3D avc_policy_seqno())
> > +             return 0;
>
> See above.
>
> >       return path_has_perm(current_cred(), path, FILE__GETATTR);
> >  }
>
> --
> paul-moore.com
