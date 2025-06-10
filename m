Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467482BD015
	for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560821; cv=none; b=JFzM4uVg/U14DjxBww1F+59+9fLztjTVjyPd3ZM6xLmHDBG4bV157rVGa1fkJ6+igt9vN5t8zYQ2PL1+QF9GoIwXd0UrmLjiKEuCMI5XjjDPS6WXdacSvPDvwOYFV9J0S1g3Y1iD6DDza1hydIpO8fS9YGndmcGr4em7bS6Wi3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560821; c=relaxed/simple;
	bh=UkcdgrOzAt/HLQN4PXD+/lIgF02ConzLmhDfyNTKI14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INdJ00vlIzRH+kbetqjiRSCpPa0fPG6S87HNSNgyeydH/NS/B/zVmKqD1uL2Y3KLk4hKYgswkBvDd33kOzsAKS/CI1Wt054rgznXYFLjodgteLYuMnEKeWeHulR6FKtIgrDq9i8VD67Sx+IqSujnocqClxCrtwFvPu0WFjUwuGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqZkAJ+a; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqZkAJ+a"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b2f603b0ef6so2577652a12.1
        for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 06:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749560819; x=1750165619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ax2rN8g8ut0uRXMk64yWFx5Lxbpq+ypevLN2PCfjVnQ=;
        b=YqZkAJ+agoeoSiwVDgz/2zRXuUbM6JWiMHVKcekOljHTM5mnib6t1qiFjZq/HsGq3J
         kOZdMy+RXL65RTK5OaIbaIRtl+b5Jq5vq4fAG7XD8U34SSDN8q+/fsU+qkaglCVhQ0kO
         tjD2fLnpxxzN23yINvkr3eKfhycW7Y/S+fJFzWr56bGGufro4detGunN8IxZ3ZyGLb/u
         Gw91Kt8Plu9XV4hnulzRrgpgPIPNW2gyHlDtS/Em2pZ7mj98QK1J+VNFxkqS5Qe8x5q9
         /1x06n+Pdfmt/UD3QA46vGVF67/Csc2GedjBAjqO+J5i0EwGKv2GWm5ix2pO4bK/1ov+
         mxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749560819; x=1750165619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ax2rN8g8ut0uRXMk64yWFx5Lxbpq+ypevLN2PCfjVnQ=;
        b=Cpl5lorjfAZZm2y3JfJcLJlgJd8oFGn9wO6bAyWgNCZUAPlPmwLWxuZMqIUjnMyCR2
         yWgU3i+BS9pRRur7ePApK3oh/FTjzHnaRu7cVoyM16Ol6wHQfLOuT4QJ24AE7hr3KeS7
         TgqmzMmF7zMI4pTnY7wkjjmvJquZyxsPCqTRST6X1QDwkLjkDyFUn5MkakFPJCFVPpfk
         2g2YgPcawoscLs9bv0RXsPl71Wj0OKsJLjGAE61r2ZIXp8IWB1S/lAx/gdmEr/rIlheV
         ZzprAYG3bWONF8lO9Irv3AHcrfAQacs2mAS3wkyztREEvN866hUyPk20JTRILwppRsIu
         UkrA==
X-Gm-Message-State: AOJu0YzUxuKS1Goh5twxcizRwHGMGhxd2PuTnD3r4C5vhf+Vot+uQvFf
	a4iZQdcHYfLL7zC99wg/u6KGFxihCsPs9pVA7faOBQoTXM9DaGa1dwNRQVo/QMCkNY9R80Gq3ab
	uW8fSqX6D6jCUzi8Jpic2ipBRJ512FFrMfh1G
X-Gm-Gg: ASbGnctI9N53IUKxm1i4yaBnqeDYK7D8iTJVWoLzm2aXrAkAfHBo28nl3ynTB6z1247
	RxfnawROWVagojaibtdmMhB0PE8L05czJBRmS3SRnbTE9K12CAHB/obCxS5prUIGUALs/gphLKT
	AqJQrIdRGuKh1Ke2813Iq9KaplMEiCqrJQeOSQL193tPY=
X-Google-Smtp-Source: AGHT+IFM+2LAenMdk7QFP9l7VhApnoUATEaS5yLwxLAOCsHpRLzvZnMsBtM1gjrglLBJeNkH7HquOoQXSDdrkscIees=
X-Received: by 2002:a17:90b:3d90:b0:312:ffdc:42b2 with SMTP id
 98e67ed59e1d1-3134767f220mr20639624a91.23.1749560819192; Tue, 10 Jun 2025
 06:06:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521144123.199370-2-stephen.smalley.work@gmail.com> <20250521144123.199370-4-stephen.smalley.work@gmail.com>
In-Reply-To: <20250521144123.199370-4-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 10 Jun 2025 09:06:47 -0400
X-Gm-Features: AX0GCFtMRsfM9MbXmUJNscTqAjwMluYCxt-yQN9DBxyGADRr0L2dkX85DtA7o3o
Message-ID: <CAEjxPJ6Fgv7_DEAn1Xpj1qcre5LoB3BeL=K47VpG808NjAu92g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: optimize selinux_inode_getattr/permission()
 based on neveraudit|permissive
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 10:44=E2=80=AFAM Stephen Smalley
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
> your selinux userspace, build and install libsepol, and use the following

The userspace support for neveraudit types has been merged so it is no
longer necessary to apply this pull request; you can simply pull
latest main branch and build and install libsepol as per the README.md
file.

> CIL policy module:
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
> v2 introduces a task_avdcache_permnoaudit() static inline function.
>
>  security/selinux/hooks.c          | 14 +++++++++++++-
>  security/selinux/include/objsec.h |  8 ++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index b8115df536ab..29cb4d48c0c7 100644
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
> @@ -3210,10 +3212,13 @@ static int selinux_inode_permission(struct inode =
*inode, int requested)
>         if (!mask)
>                 return 0;
>
> +       tsec =3D selinux_cred(current_cred());
> +       if (task_avdcache_permnoaudit(tsec))
> +               return 0;
> +
>         isec =3D inode_security_rcu(inode, requested & MAY_NOT_BLOCK);
>         if (IS_ERR(isec))
>                 return PTR_ERR(isec);
> -       tsec =3D selinux_cred(current_cred());
>         perms =3D file_mask_to_av(inode->i_mode, mask);
>
>         rc =3D task_avdcache_search(tsec, isec, &avdc);
> @@ -3277,6 +3282,13 @@ static int selinux_inode_setattr(struct mnt_idmap =
*idmap, struct dentry *dentry,
>
>  static int selinux_inode_getattr(const struct path *path)
>  {
> +       struct task_security_struct *tsec;
> +
> +       tsec =3D selinux_cred(current_cred());
> +
> +       if (task_avdcache_permnoaudit(tsec))
> +               return 0;
> +
>         return path_has_perm(current_cred(), path, FILE__GETATTR);
>  }
>
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include=
/objsec.h
> index 6ee7dc4dfd6e..1d7ac59015a1 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -49,9 +49,17 @@ struct task_security_struct {
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
> +static inline bool task_avdcache_permnoaudit(struct task_security_struct=
 *tsec)
> +{
> +       return (tsec->avdcache.permissive_neveraudit &&
> +               tsec->sid =3D=3D tsec->avdcache.sid &&
> +               tsec->avdcache.seqno =3D=3D avc_policy_seqno());
> +}
> +
>  enum label_initialized {
>         LABEL_INVALID, /* invalid or not initialized */
>         LABEL_INITIALIZED, /* initialized */
> --
> 2.49.0
>
