Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73341297A47
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747311663; cv=none; b=a0pND4ypPkzZIIF0P7lNXoUC6NTxFX7iXFNmFcGtJYNGoy8TwDS8SzENKChlgImZB4ENf7oZXQZNe2HyY6IAp1dMA6XXw6aD4s1iF8T6XqV55Tae5HmA0IJhe5DUwIsSWdxQWEdY8/WFnYSo+hcUkk7F9kmSOcE0shCRhMH19v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747311663; c=relaxed/simple;
	bh=shlnFKO/vnsQfgu/bcrpHx3A/MBkPdDG5j540MMbUT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQUKZWWarPswc/qzTHFc9GJDt4hTgzNJkFeMHhNCNGNJJT2JBJ8kcYqwr2wRJZOuzfaaJ7MpOwrwskjgDz1QZMAPHEWQzOzQFFyGDAAQNHfVSwidT6NGnyvglWQC9lbODmgNiHN1+QmdGNKGHfIJmChX5uw/uSF14IkREN+GHBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dnw+NS4A; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dnw+NS4A"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-30c35ac35dfso719583a91.1
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 05:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747311660; x=1747916460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o19lanGjbSboZ1V5E7yRoesGsNg4TuDUzm3fJqxGHo8=;
        b=Dnw+NS4A1LNECFyqEKJ1O0YGmDFQ7YNl0159QnbpN/aTwJvqidPurAFeJpkEJdq0qt
         KfM6RwaIacCftGg1G4EwxaH4+4uGLAZSMdV58UucJW+zn3pwGaiMN9dbFHL8+0hzB2f8
         BqgQZlYemqDHv46DV8KbyJ+JvB4Na/mVLk1zfc67i8iYcUHEI+vId3D6HXwMLV5rK3wE
         rPl5fGsqmrhfG8qzbkaV2ZteLPmD9koIA5+gq+ElwOWyxs7rsuxBH0fjA/kyNDuSja9T
         +jup5xXwH9KcYuwYIohF6cYDBvyFVDzDz3hsMsKHtvYrbU7saV9sSbo4m6ts1EUjut/J
         SOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747311660; x=1747916460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o19lanGjbSboZ1V5E7yRoesGsNg4TuDUzm3fJqxGHo8=;
        b=dkcuZukEZ+hXjxBLFZxb6XG+Gv+V5b2f5rpYuzOpl/justReMi+A1J+P2H5SeDvB7V
         6Sy2APRQLB76YgIMvbJ+Kt5L8uUDfu/AaGlIp8yoVODBWdJgYbZ7P97vRzwPyPbecW/z
         iXAfeaew/DDGOAOcXAhCCSb3LMs7Rx4z4MZKiOAeJOcaqRHpPZgRB2I1/gBADxo77wKn
         6Nza4+hhYlUhDOJcf/GdfmyyvfMqxHNPvlBN00SAZahM0cVVv6VdsgyL0Yw2b7pNBhrA
         CBoFBqdTmcIXk6uLl8JC8UBqMEuv/FUVIhDi5cgzeDSzQdrVkPSfWsJl9TJs9gh6PksE
         PjHg==
X-Gm-Message-State: AOJu0YxDWC5uFIhsQxvLRvZ102oaaCWP+eCXXhSZtlfGbk8fpCJiEYNp
	NMCEk15RTxQLFDPlqpdul7vOjyg2+z2TkAcMp8HpGAfAjP38pz22pi2KoiTLaGeP7Wh0JKSgzho
	8XzRElPUjdygXK8PxUuKxb+La6W8wwpv1
X-Gm-Gg: ASbGncujLva64jN8T5pUAytPYz6w6O5mv4FacoEUWr4ll6MEUPEHFqWAX9LG2tJPyHX
	fvoT0BT8fxoYcovGLYlu3t0ZFxRbkHEN4pgQ/bqAVnryG1en69QcwRIe52JhSlh3Ywc1EYmpPOB
	Zk/oVzJi8+d29fW7I4zEevQ7KuUcXXdH8m
X-Google-Smtp-Source: AGHT+IEAiNyG0QxiDJmthCWhjkpNIcNgBQjhoVK5JXEhf6h4oFaGp+0nqKGR/K0qK8B/tFDEQXgIKKqCW0imUd1V5Hs=
X-Received: by 2002:a17:90b:58ce:b0:30c:4a09:d1c0 with SMTP id
 98e67ed59e1d1-30e2e687a99mr12947561a91.33.1747311660242; Thu, 15 May 2025
 05:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502170450.27160-2-stephen.smalley.work@gmail.com> <20250502170450.27160-3-stephen.smalley.work@gmail.com>
In-Reply-To: <20250502170450.27160-3-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 15 May 2025 08:20:49 -0400
X-Gm-Features: AX0GCFsoj6qTeOBGasd_Z1bJ3vvM713UHEf5EsNjtm_4S0uJulLjvs3uVxVeXHY
Message-ID: <CAEjxPJ6B9COCXeM5xaWQC4aY8iB3TQwm57VRSK-c6k3Or-K3gQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] selinux: optimize selinux_inode_getattr/permission()
 based on neveraudit|permissive
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 1:05=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Extend the task avdcache to also cache whether the task SID is both
> permissive and neveraudit, and return immediately if so in both
> selinux_inode_getattr() and selinux_inode_permission().
>
> The same approach could be applied to many of the hook functions
> although the avdcache would need to be updated for more than directory
> search checks in order for this optimization to be beneficial for checks
> on objects other than directories.
>
> To test, apply https://github.com/SELinuxProject/selinux/pull/473 to
> your selinux userspace, build and install libsepol and secilc, and use
> the following CIL policy module:
> $ cat neverauditpermissive.cil
> (typeneveraudit unconfined_t)
> (typepermissive unconfined_t)
>
> Without this module inserted, running the following commands:
>    perf record make -jN # on an already built allmodconfig tree
>    perf report --sort=3Dsymbol,dso
> yields the following percentages (only showing __d_lookup_rcu for
> reference and only showing relevant SELinux functions):
>    1.65%  [k] __d_lookup_rcu
>    0.53%  [k] selinux_inode_permission
>    0.40%  [k] selinux_inode_getattr
>    0.15%  [k] avc_lookup
>    0.05%  [k] avc_has_perm
>    0.05%  [k] avc_has_perm_noaudit
>    0.02%  [k] avc_policy_seqno
>    0.02%  [k] selinux_file_permission
>    0.01%  [k] selinux_inode_alloc_security
>    0.01%  [k] selinux_file_alloc_security
> for a total of 1.24% for SELinux compared to 1.65% for
> __d_lookup_rcu().
>
> After running the following command to insert this module:
>    semodule -i neverauditpermissive.cil
> and then re-running the same perf commands from above yields
> the following non-zero percentages:
>    1.74%  [k] __d_lookup_rcu
>    0.31%  [k] selinux_inode_permission
>    0.03%  [k] selinux_inode_getattr
>    0.03%  [k] avc_policy_seqno
>    0.01%  [k] avc_lookup
>    0.01%  [k] selinux_file_permission
>    0.01%  [k] selinux_file_open
> for a total of 0.40% for SELinux compared to 1.74% for
> __d_lookup_rcu().
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---

FYI, I posted a revised version of the userspace patch to support this
extension here:
https://lore.kernel.org/selinux/20250514195928.33737-2-stephen.smalley.work=
@gmail.com/

No change required to the kernel patches.
Would appreciate any feedback.

>  security/selinux/hooks.c          | 18 +++++++++++++++++-
>  security/selinux/include/objsec.h |  1 +
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index b8115df536ab..1a3806fdf3d6 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3184,6 +3184,8 @@ static inline void task_avdcache_update(struct task=
_security_struct *tsec,
>         tsec->avdcache.dir[spot].audited =3D audited;
>         tsec->avdcache.dir[spot].allowed =3D avd->allowed;
>         tsec->avdcache.dir[spot].permissive =3D avd->flags & AVD_FLAGS_PE=
RMISSIVE;
> +       tsec->avdcache.permissive_neveraudit =3D
> +               (avd->flags =3D=3D (AVD_FLAGS_PERMISSIVE|AVD_FLAGS_NEVERA=
UDIT));
>  }
>
>  /**
> @@ -3210,10 +3212,15 @@ static int selinux_inode_permission(struct inode =
*inode, int requested)
>         if (!mask)
>                 return 0;
>
> +       tsec =3D selinux_cred(current_cred());
> +       if (tsec->avdcache.permissive_neveraudit &&
> +               tsec->sid =3D=3D tsec->avdcache.sid &&
> +               tsec->avdcache.seqno =3D=3D avc_policy_seqno())
> +               return 0;
> +
>         isec =3D inode_security_rcu(inode, requested & MAY_NOT_BLOCK);
>         if (IS_ERR(isec))
>                 return PTR_ERR(isec);
> -       tsec =3D selinux_cred(current_cred());
>         perms =3D file_mask_to_av(inode->i_mode, mask);
>
>         rc =3D task_avdcache_search(tsec, isec, &avdc);
> @@ -3277,6 +3284,15 @@ static int selinux_inode_setattr(struct mnt_idmap =
*idmap, struct dentry *dentry,
>
>  static int selinux_inode_getattr(const struct path *path)
>  {
> +       struct task_security_struct *tsec;
> +
> +       tsec =3D selinux_cred(current_cred());
> +
> +       if (tsec->avdcache.permissive_neveraudit &&
> +               tsec->sid =3D=3D tsec->avdcache.sid &&
> +               tsec->avdcache.seqno =3D=3D avc_policy_seqno())
> +               return 0;
> +
>         return path_has_perm(current_cred(), path, FILE__GETATTR);
>  }
>
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include=
/objsec.h
> index 6ee7dc4dfd6e..51a42b1a61a9 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -49,6 +49,7 @@ struct task_security_struct {
>                 u32 seqno; /* AVC sequence number */
>                 unsigned int dir_spot; /* dir cache index to check first =
*/
>                 struct avdc_entry dir[TSEC_AVDC_DIR_SIZE]; /* dir entries=
 */
> +               bool permissive_neveraudit; /* permissive and neveraudit =
*/
>         } avdcache;
>  } __randomize_layout;
>
> --
> 2.49.0
>
