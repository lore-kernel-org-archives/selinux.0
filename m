Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1352429A5
	for <selinux@vger.kernel.org>; Mon,  9 Jun 2025 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749473157; cv=none; b=bkDdASa6Ufpz/fgPUVXajbmEVG2w3mVObPuNnKc+1Ft0eRx72oZtPR6L/vUmb+7vmmXknqoVSeClrS7lwV4XEhkHA6XBvoSHFNdAcJX5hB5Hyq/uyTWTSAoheX2SDvngpyRu1GfC2EgqxT6rtPcWFkGFpiA/2MG4I0cpFULZvVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749473157; c=relaxed/simple;
	bh=UD3dXctXe6eXmsDiVWqsFf4/bmEx6wpXbtdPVZgocfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GoZNJ0INpIzC7qp6UeJJnMETM3/C9ZjYsWL5iK3uyPVZnqe/44W+IN8y2+lLxgcPGYZ9KpWFMf7oOHhRmnilfuxAtJpWJodta3XfsdT/pB4tAaECmih6V+Z+Qc7KkWoow5M+FuAu3rb+Ef4gLnvaP9d9Al5E4T2149e0t7mj/D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdHxhWJD; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdHxhWJD"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b26d7ddbfd7so4609692a12.0
        for <selinux@vger.kernel.org>; Mon, 09 Jun 2025 05:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749473153; x=1750077953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPRviuhTKS0+GAmR8ZvuH0tMo8uiKvDOalBigB0u+Tk=;
        b=GdHxhWJD4HVmWLyQUJERuFOca0p6Clrg8Z2HROwBrDlvJx7fKco1Y4ycgOlG1DS1VI
         q6Ss048gwxZbJqcYBLr0hB7xHv+COJqXCwzEzJtekdbXgKvSacPP1SEKxIJZcTo0CUDk
         9xxHKdIOu8YgddYWUxJTK3+kCOrKkpJ2WxQhfIXRnD4R4O/62GVZIfOaaOwsW7Okm7va
         lbgSZvBx1BxDeaQ/vYEzIfP6z9+g5GJlkYzS1koGDUh2BtYP7l3tYr407gdL5FRWkVZy
         V4k2BNxMnTAtdK2QzxXu3a7g7bpP3Z4Jyt/X0axE/M9JogOHUGO1QjybyfPNjJ5RlC0Y
         3qVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749473153; x=1750077953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPRviuhTKS0+GAmR8ZvuH0tMo8uiKvDOalBigB0u+Tk=;
        b=kivyGBaWiVeIAsQep9u8ZrWuGZ0H12+qIIUbnFWRf1Gb76aJb3mNB+kR91uleheiAg
         xhppwZezugvnev/2Qr/mjxM5ib3TJ5TM91afkrTTWLXcF1iHNdD15g1kcHpKtYddx650
         ig8qRiqTTkp1r0avnEKVWhGspydNFU+6AdNS2REUN0iEpxKvyUkJsad9zFjfaVgmEfGq
         eWLCVfmw0zsfIMtkdnwsR4uxPnT9H2Ylcqm2GcmHTlcVoJoDrl9S4vTCcnsgyS3UwIwQ
         S42qjW0gHPmQaKwBAucANzllEX1GQEVsPz5DFMVuFfO9mPJznJ1YKRwFFa+gPkiThqlb
         Zt3g==
X-Forwarded-Encrypted: i=1; AJvYcCXRA+KOTFC8MJdXFT/O3E8ywKnd1Isl2dmq9jCO5sM8OmjkR/R6j7b/fEVkmJdfq8F1blZnE/Zp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7rK+xc+iiFN6oyPomMYmiEl1kK4khmcoWhW7wpBCoBYOHeRbz
	GInDvLUZZY63xmdNCRRndg9XGC9Fev6NuuvORZDId4mhFu+Oq/6M5PiZiO0teNh9aGfqU0M/RIf
	qbaZrAK4rq5g4y9BQi6af52gV4iU04p0RfA==
X-Gm-Gg: ASbGncvaMVeNAfLwE3d6OokqA9p1Nu3n5lHxQKu8ET3JiD0nEPjJGDtCmZvIc/ErvNM
	iGEO9JI9s+8Ow5jyXVRgHm/ksFQ+kIWIqzQB++b1pmnRKCmzWtHoKztxW9lJmTajPN5ViAMc7fl
	K6MMU57vNuelGqXMRuo/QQrLVuXksEAOVSddyger8VPHSnzUOZ2CPk/g==
X-Google-Smtp-Source: AGHT+IGud+6Wc47DGqOtioxk7tcEf1n1sJRDPbdr1n+LgC2jd3DeF4VE1APQIsAVsd71SbPZCZJAmpfwqV68vmcDQLU=
X-Received: by 2002:a17:90b:47:b0:312:e90b:419c with SMTP id
 98e67ed59e1d1-31347057cb5mr15162189a91.26.1749473153286; Mon, 09 Jun 2025
 05:45:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609065841.1164578-1-omosnace@redhat.com>
In-Reply-To: <20250609065841.1164578-1-omosnace@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 9 Jun 2025 08:45:41 -0400
X-Gm-Features: AX0GCFvR8gXm_axjwsN1YKDK-r5nbQ7cF27cKHwiTwxbsgSycyvksc5VhcpDnl8
Message-ID: <CAEjxPJ4YiUQpFNwxhAix3CZnXF9Vkbn5Vbs8_Kp7zDxCoevouQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix security context comparison on execve(2)
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, 
	Guido Trentalancia <guido@trentalancia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 2:58=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> selinux_bprm_creds_for_exec() needs to compare the old and new SIDs to
> determine if the execve(2) operation is transitioning into a new context
> (where process { transition } and file { entrypoint } permissions would
> be checked) or not (file { execute_no_trans } would be checked). It does
> so by just comparing their numeric values.
>
> However, after ae254858ce07 ("selinux: introduce an initial SID for
> early boot processes"), we can now easily get into a situation where the
> SID numbers differ, but the context is the same for both. Specifically
> when the policy assigns the same context for SECINITSID_KERNEL and
> SECINITSID_INIT - in this case when a process labeled with
> SECINITSID_INIT does execve(2) without a transition,
> security_transition_sid() will translate the unchanged context to the
> first matching SID number, which is SECINITSID_KERNEL, not
> SECINITSID_INIT. Thus the kernel thinks that a transition has happened
> and unexpectedly tests for the file { entrypoint } permission.
>
> Fix this by checking the SID equality more carefully, trying
> context_equal() on the underlying contexts when it is necessary - in the
> rare case that the SIDs differ, but both are "initial" SIDs.

We check for SID equality elsewhere as well, e.g. file_has_perm() and
selinux_binder_transfer_file(), ioctl_has_perm(), and
selinux_kernel_load_from_file() to decide whether to check fd use
permission, selinux_file_permission() to decide whether we need to
revalidate permissions, selinux_binder_transaction() to decide whether
to check binder impersonate permission, task_avdcache_search() to
decide whether we can use the avdcache. I'm wondering if we wouldn't
be better off just ensuring that security_transition_sid() returns
SECINITSID_INIT when called with SECINITSID_INIT and there is no
transition defined.

>
> Reported-by: Guido Trentalancia <guido@trentalancia.com>
> Fixes: ae254858ce07 ("selinux: introduce an initial SID for early boot pr=
ocesses")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/hooks.c            |  2 +-
>  security/selinux/include/security.h |  2 ++
>  security/selinux/ss/services.c      | 35 +++++++++++++++++++++++++++++
>  3 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index b8115df536abd..be95e6e83f1d0 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2369,7 +2369,7 @@ static int selinux_bprm_creds_for_exec(struct linux=
_binprm *bprm)
>         ad.type =3D LSM_AUDIT_DATA_FILE;
>         ad.u.file =3D bprm->file;
>
> -       if (new_tsec->sid =3D=3D old_tsec->sid) {
> +       if (security_sids_equal(new_tsec->sid, old_tsec->sid)) {
>                 rc =3D avc_has_perm(old_tsec->sid, isec->sid,
>                                   SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, =
&ad);
>                 if (rc)
> diff --git a/security/selinux/include/security.h b/security/selinux/inclu=
de/security.h
> index 278c144c22d60..c3ed350718d1d 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -299,6 +299,8 @@ int security_context_to_sid_default(const char *scont=
ext, u32 scontext_len,
>  int security_context_to_sid_force(const char *scontext, u32 scontext_len=
,
>                                   u32 *sid);
>
> +bool security_sids_equal(u32 sid1, u32 sid2);
> +
>  int security_get_user_sids(u32 fromsid, const char *username, u32 **sids=
, u32 *nel);
>
>  int security_port_sid(u8 protocol, u16 port, u32 *out_sid);
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index 7becf3808818a..297317763f6d4 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1448,6 +1448,41 @@ int security_sid_to_context_inval(u32 sid,
>                                             scontext_len, 1, 1);
>  }
>
> +/**
> + * security_sids_equal - Determine if two SIDs map to the same context.
> + * @sid1: first SID
> + * @sid2: second SID
> + */
> +bool security_sids_equal(u32 sid1, u32 sid2)
> +{
> +       struct context *c1, *c2;
> +       struct selinux_policy *policy;
> +       struct sidtab *sidtab;
> +       bool res;
> +
> +       if (!selinux_initialized())
> +               return sid1 =3D=3D sid2;
> +
> +       if (sid1 =3D=3D sid2)
> +               return true;
> +
> +       if (sid1 > SECINITSID_NUM || sid2 > SECINITSID_NUM)
> +               return false;
> +
> +       /* Initial SIDs may map to the same context, so do a full compari=
son */
> +       rcu_read_lock();
> +       policy =3D rcu_dereference(selinux_state.policy);
> +       sidtab =3D policy->sidtab;
> +       c1 =3D sidtab_search(sidtab, sid1);
> +       c2 =3D sidtab_search(sidtab, sid2);
> +       if (!c1 || !c2)
> +               res =3D false;
> +       else
> +               res =3D context_equal(c1, c2);
> +       rcu_read_unlock();
> +       return res;
> +}
> +
>  /*
>   * Caveat:  Mutates scontext.
>   */
> --
> 2.49.0
>
