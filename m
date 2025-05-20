Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162C31DFD84
	for <selinux@vger.kernel.org>; Tue, 20 May 2025 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747753790; cv=none; b=ckg04YaDllBgvIYaTb0+N18zsdfWG+KC3joCU20YH1rFiToG780wVk3Wtg/ZVna3lXIIWyZzqCIR7sTtAKo04AJ5fQnLLJJfin7dKVROfY7XlREspwFW9HfTvKXdMA2Wn4hxlEUAFslM9N9nNfW488nDyBlcDkK/prFcB8Ixv+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747753790; c=relaxed/simple;
	bh=iXa4pChEzZO2cmMMeIQjp7R3mNTPkhaCPghAseljb54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ioy8diUK90knjNw9C3XMZZcSQIHE7ZM2pBCam7Oc64GM6dbj/Dawxbdxk+fniM9rU4hqjQgPNd+Qn64Sg7VCnHneKLfl/RN+j60qgMmMlgGHtp1w2ebe1HLRQS1UE0cWcDQgeOiS2FsSCRq/GWL05MwAfxrRsSFy4bRMXfbPhQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAwjWzT2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAwjWzT2"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2321c38a948so31144215ad.2
        for <selinux@vger.kernel.org>; Tue, 20 May 2025 08:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747753788; x=1748358588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lL+93MSMlkY5gvMhVlilg/v3VxW8nf3iSSQ4DKeqk2U=;
        b=EAwjWzT2l/kN2YhMeEKXx9VQKh11b+UdLfXP/PMHg+oj6Xz4tyuUw4BeqR0bBcnAOl
         FgvDdyqyHwGzzXIkuUAyPehumOXb10U08y1Yi8hklqMvgYqWfmrXm3FNGI1jXyYzmURU
         Hs7fJYQCUp6FkP4untUXgwxUcoJSNasNdltISecVjeTvF76DAxyXPNwoRfOu0OqFDck2
         Zk+aKPyEy59lkjYUA+c/++vLWp/WxYQLFAonQumAPEd4wC0aVQni5ELhRdbmdOK7MGKQ
         NqRpD7m7e6s8hUyUlxTBcQv4hQ/s0GQNsKkCMhQfaVeWH1zp6tVklCo9uE32NOUR7zKc
         woJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747753788; x=1748358588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lL+93MSMlkY5gvMhVlilg/v3VxW8nf3iSSQ4DKeqk2U=;
        b=XqcXfjkPKyF3jELEUIvdTVkg/GERhDt0qXkfHE7sDqjK66hWOH9SDv1RQ7myaIrOHL
         91TNqrbj9KwvcNHK60ZuzdenIWKMd1nmszbomghOwKgloQMOGp8WbYPEh04Bc8LiJbyQ
         u72OM/WJ1mR75Vqlb373pkGPspe8Z+hRC+EOd6s8qfowmJb3Ye8tXYNOC7np0LKs+a8e
         86ChGgP1Nm9tALEevMmhGZW9K7MTOTUNEjVHA7dLjpLXygUTDuQ4ZdsJaKTAPNNd0kHC
         zRFxx3tjeUakRyJbvhH/LORcVX5a631ChIMsQbCMEIsqs1QEvBa9v3OKqcYNgoDXn3fz
         B+bg==
X-Gm-Message-State: AOJu0Yxo70D16uJjiQe0faybySwGaP1y3qXbliW96z8C/l18g5m5CZY6
	ZszKPPo/CuLGjsiLEGe34aR49GmbaiQHTAzCPZ1VRRu75o+LQ8v3Xoqa14+A45/VeolKBxdwfo8
	0R9erYb3p+VAWbSPxDmmjFv9yNvNMKOcStg==
X-Gm-Gg: ASbGncvh8VtCikmO1GZA28MgFgBK++4De6alfvK2k13Nn6bV8i0MkhaS9WRlLmnA+75
	ZasPYILKCcZDbAoeqJzLsD4Pk+cn4ZEUmwY11YJhyufH5gz7b+xO0iuara/7VZfm2LsNG46hV1h
	yhQ+50beA5QaLvyMSc7w68aDo2cvTDJZQ4
X-Google-Smtp-Source: AGHT+IEU03v7IZog+nbY9K9TONljFOSFGqoZ7flPX7HYt+ImCuWjB54iAUB9iiYIfoeRqyY9YEjtA68Nln6m3ZkpIwk=
X-Received: by 2002:a17:902:fc46:b0:223:5379:5e4e with SMTP id
 d9443c01a7336-231de351434mr294725615ad.10.1747753787878; Tue, 20 May 2025
 08:09:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502170450.27160-2-stephen.smalley.work@gmail.com>
 <20250502170450.27160-3-stephen.smalley.work@gmail.com> <CAEjxPJ6B9COCXeM5xaWQC4aY8iB3TQwm57VRSK-c6k3Or-K3gQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6B9COCXeM5xaWQC4aY8iB3TQwm57VRSK-c6k3Or-K3gQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 20 May 2025 11:09:36 -0400
X-Gm-Features: AX0GCFspc04aM91h8NW1TD77wJpbWyF03srIdk5DuKHTSckWHcg5ED095UZGD-k
Message-ID: <CAEjxPJ5=LLqsPHejSgMjH0oV256XP+jp2qK69oa1mYFLMqHS9Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] selinux: optimize selinux_inode_getattr/permission()
 based on neveraudit|permissive
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 8:20=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, May 2, 2025 at 1:05=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
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
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
>
> FYI, I posted a revised version of the userspace patch to support this
> extension here:
> https://lore.kernel.org/selinux/20250514195928.33737-2-stephen.smalley.wo=
rk@gmail.com/
>
> No change required to the kernel patches.
> Would appreciate any feedback.

Gentle ping on these patches. I believe these would go a long way
toward improving our story around performance for Linus, which in turn
could be crucial to accepting the SELinux namespace patches.

>
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
> >         tsec->avdcache.dir[spot].audited =3D audited;
> >         tsec->avdcache.dir[spot].allowed =3D avd->allowed;
> >         tsec->avdcache.dir[spot].permissive =3D avd->flags & AVD_FLAGS_=
PERMISSIVE;
> > +       tsec->avdcache.permissive_neveraudit =3D
> > +               (avd->flags =3D=3D (AVD_FLAGS_PERMISSIVE|AVD_FLAGS_NEVE=
RAUDIT));
> >  }
> >
> >  /**
> > @@ -3210,10 +3212,15 @@ static int selinux_inode_permission(struct inod=
e *inode, int requested)
> >         if (!mask)
> >                 return 0;
> >
> > +       tsec =3D selinux_cred(current_cred());
> > +       if (tsec->avdcache.permissive_neveraudit &&
> > +               tsec->sid =3D=3D tsec->avdcache.sid &&
> > +               tsec->avdcache.seqno =3D=3D avc_policy_seqno())
> > +               return 0;
> > +
> >         isec =3D inode_security_rcu(inode, requested & MAY_NOT_BLOCK);
> >         if (IS_ERR(isec))
> >                 return PTR_ERR(isec);
> > -       tsec =3D selinux_cred(current_cred());
> >         perms =3D file_mask_to_av(inode->i_mode, mask);
> >
> >         rc =3D task_avdcache_search(tsec, isec, &avdc);
> > @@ -3277,6 +3284,15 @@ static int selinux_inode_setattr(struct mnt_idma=
p *idmap, struct dentry *dentry,
> >
> >  static int selinux_inode_getattr(const struct path *path)
> >  {
> > +       struct task_security_struct *tsec;
> > +
> > +       tsec =3D selinux_cred(current_cred());
> > +
> > +       if (tsec->avdcache.permissive_neveraudit &&
> > +               tsec->sid =3D=3D tsec->avdcache.sid &&
> > +               tsec->avdcache.seqno =3D=3D avc_policy_seqno())
> > +               return 0;
> > +
> >         return path_has_perm(current_cred(), path, FILE__GETATTR);
> >  }
> >
> > diff --git a/security/selinux/include/objsec.h b/security/selinux/inclu=
de/objsec.h
> > index 6ee7dc4dfd6e..51a42b1a61a9 100644
> > --- a/security/selinux/include/objsec.h
> > +++ b/security/selinux/include/objsec.h
> > @@ -49,6 +49,7 @@ struct task_security_struct {
> >                 u32 seqno; /* AVC sequence number */
> >                 unsigned int dir_spot; /* dir cache index to check firs=
t */
> >                 struct avdc_entry dir[TSEC_AVDC_DIR_SIZE]; /* dir entri=
es */
> > +               bool permissive_neveraudit; /* permissive and neveraudi=
t */
> >         } avdcache;
> >  } __randomize_layout;
> >
> > --
> > 2.49.0
> >
