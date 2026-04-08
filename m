Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F145B3D47AC
	for <selinux@vger.kernel.org>; Wed,  8 Apr 2026 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775670979; cv=pass; b=lcRDnXfRm/UYlmbvjfBUcbhAKIFCxSgDheUPAynw6cYB6JKPLa6LzfwFJKz5f6/4vhrzGMxwKO+Yi/RTW05MowMvdP8o/lJg9Sf77Bp7KTZKuXbGO/DB3uLPM+qnkHU/JjgNJFhfTxlnNODCNna0++f9zmEqWngAjqmnYyoNzt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775670979; c=relaxed/simple;
	bh=/Ir/WArPp0eWWmntTkkWr70tcGd5BoFVEkcWEiP5TBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kybadc8jDFS+lQmYaLoRI6wWq5e12uoDvLh2lA3lN0m0fcZ4biUgrvpomRRVZ60hMgLetvSRI2C8D3m44pjX27oFSJy+t0+KPPmofivN1lww0x3boqbICvLAwzfHt/xD/jJEwZBDByYuDDXbcWg61bxoQftBI0+0g9j6gctMaLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VVOOOzca; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VVOOOzca"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35c206f0481so9470a91.0
        for <selinux@vger.kernel.org>; Wed, 08 Apr 2026 10:56:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775670977; cv=none;
        d=google.com; s=arc-20240605;
        b=kyXeP/7bHjEEDa94GWlMzealXamdiM1YWIZW3Ke1jn1arQt//5fsV1gQdunUEctz8+
         V7FAG5IGQmA16ak7x55dKWg6KbxFEzrKx+oQhqIBII62+xARuK6399Ko1xe254HingKI
         7uSgvYh4LCB5WsWDIebO98UzChA+7YDh1XQB6oDlaAPpMk8LF9qBJZj0Cn5hn36fGZbY
         uzyRPn35yCiOCBb4VFisg/4hg0qQdcigAK49iZ4sXXrOTeCOm/i117cCPhHn0UPjaJpi
         ojPvYvLQg00iLbGPlOwSh5fjVVrZIY5IW6hlPae62llTKILo1Q9Rrr6myYG2gcWi15jY
         S87w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=614cnxcG27Z9zJf/jETHI43w2IjKDSFz2+O7nG9OTow=;
        fh=lOev/QwE9DXSi83P/KluQ9UjJBSvfLYOVkCl5H1rM0Y=;
        b=dHbTuZwsAzqy2QYq0dnK2hafEo0++oWHvPfDQPxcACwWox9eIZoT0/qOeVc+qJgWb/
         tro68j5+mAqr5w1JNQaJH56LJBRegHyYDAW3GxzjoEYsC9nAmgHDjjCtDxW08rK6fqS7
         o3qBa3J5EK5/h8O3AQRnFy9Hxd/s+HxrGEouvb691EIA0H4U78IGZCQReTFWx6mjvuyt
         X1yn6gUwh6SIe0tDm+oiUE3ofQyp5Ruk4slhxJqIastR/efPrL1ZRdQhg5jI2cE1v2NO
         zeWPPvPJ3bzgtWjKZHsyg2//kOkSH6LwvomQaS0E1yVLH+ub9q/U9wgEa33Y4ljAcrUk
         pLwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775670977; x=1776275777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=614cnxcG27Z9zJf/jETHI43w2IjKDSFz2+O7nG9OTow=;
        b=VVOOOzcaUtWEw9FksTjbLyuhK18/eqJfe2wVm93qeJkuAWaPSgjnitf8z8bk7O4Mbr
         s0BnMGrV7ApIdGRUCVOQ5JIIsqXwxXDTUByOwoAtWtGtSB6Q7poswv2CLSS/Ozk7SuFR
         wlzEiAiNag85gnoq19BqNZi15ygwf/QDaqt1axK3w2LdAbVNFocnw2m3cOHX2k9Bm3vb
         Ohs+H+1G6IWVb7NGa1uouAWQjVesRwWsrYvIcKhIgYnRqgSCGfpqhHJlvWbtpYrfS/cr
         7hgr7BIZjmA0e8JttbZPcOOfxyz7V2LiukzQNAGJylBQCsYIOyssv9IP2VS+wv5z8k7z
         T0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775670977; x=1776275777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=614cnxcG27Z9zJf/jETHI43w2IjKDSFz2+O7nG9OTow=;
        b=tKDP5d3WLcIrt9PqVPaZO2De5hFvah62t3F0kqyet53CodXHm2MUUTqz3mNCeLH7W8
         zWGW6O2ElqU7zTX4lQQo/LMWsoiIZ90+1oTSOtiNNO+QfmD2YLxSAvgtreiVBPTCXBxO
         RumMCJeyQEcAOWozLB44Hip37fxPDY2H/MhDI9UNWhEXPF50WgBf9BjRj74yyXY4+YzD
         rMdB98zDnLXxtoz45xHDpXIJ9mXnS5X2SNN7UmJLFBJRRJyAwZ0CkBFRs8Ioutv5zfNP
         nAhBUrxSdljL9r3EjEsTG0BOjCBRUPyLjbwJanrujviG5OXXazfqN7I5lSVgJ7fMbl4B
         xJaA==
X-Gm-Message-State: AOJu0YyKWPbGa6T4+9U1YzYfUbwO7lKkSPOnMzxQOFkxctwKUsdO/uI5
	5eJml3y43LLDfMDQ7jp1AThsomtk/ahnUP/PCTTcgMF6h48DwKT2cvriSOpkB78cnxJxdHGFDVy
	q1NxANO6vZoRFaNuBki2olnVjqxUZ/UZzsjt8Sxq6zVh/frrmOKc=
X-Gm-Gg: AeBDiev3eQbm9e7N1u74QLgtSFe/t+MfiHjbLiuMXdQbOjZKN36iDOkQMhDg1pugkiP
	MpyeqLp9oifvQ227tZ7XRGKPGKt3hVbu3uUjbO99LhWkEuw3oDQyJp3ac7zgZTsgQ04xp/AOi1h
	5TZavLsXvTvw3WEQsLdYpDQCPM2dXr0eX9zwbrhg+JAD9pKaSfwfpdLxq1MRmQGDjig+dyvRMaB
	sKnvNmOQTaKasnVxauizboLewmBd9j33fqFcf1OEo4oZt39LbiljPSUCpDKWKCp5KhtQzpjEmNI
	mJnrFJs=
X-Received: by 2002:a17:90b:2e07:b0:35d:a05f:c7eb with SMTP id
 98e67ed59e1d1-35de68f9e47mr20604573a91.22.1775670977196; Wed, 08 Apr 2026
 10:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408165106.15820-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260408165106.15820-1-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 8 Apr 2026 13:56:05 -0400
X-Gm-Features: AQROBzDsTZt814MpPn9f7hQ9P40QW-yuPMXvlc8WhRx17-jEuAlD6P_W4O3NkU8
Message-ID: <CAHC9VhTz7cMmK-iHFk53YiB0cstyz7Cq_kKKc=C+7mx7evFMzA@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix avdcache auditing
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 12:51=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The per-task avdcache was incorrectly saving and reusing the
> audited vector computed by avc_audit_required() rather than
> recomputing based on the currently requested permissions and
> distinguishing the denied versus allowed cases. As a result,
> some permission checks were not being audited, e.g.
> directory write checks after a previously cached directory
> search check. This manifests as unaudited permission denials
> even after removing all dontaudit rules.

I obviously trust what you've written above, and I'm only quickly
looking at this, but off the top of my head I would have expected the
policy sequence number check to catch a change in the dontaudit rules.
Perhaps the sequence number check is actually different than I
remember, or I simply was thinking about wrong in the first place ...
need to look at that again.

> Fixes: dde3a5d0f4dce ("selinux: move avdcache to per-task security struct=
")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/hooks.c          | 21 +++++++++++++--------
>  security/selinux/include/objsec.h |  3 ++-
>  2 files changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6ef9c1aade65..a77a9aa43ea7 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3185,15 +3185,13 @@ static inline int task_avdcache_search(struct tas=
k_security_struct *tsec,
>   * @tsec: the task's security state
>   * @isec: the inode associated with the cache entry
>   * @avd: the AVD to cache
> - * @audited: the permission audit bitmask to cache
>   *
> - * Update the AVD cache in @tsec with the @avdc and @audited info associ=
ated
> + * Update the AVD cache in @tsec with the @avd info associated
>   * with @isec.
>   */
>  static inline void task_avdcache_update(struct task_security_struct *tse=
c,
>                                         struct inode_security_struct *ise=
c,
> -                                       struct av_decision *avd,
> -                                       u32 audited)
> +                                       struct av_decision *avd)
>  {
>         int spot;
>
> @@ -3205,7 +3203,8 @@ static inline void task_avdcache_update(struct task=
_security_struct *tsec,
>         spot =3D (tsec->avdcache.dir_spot + 1) & (TSEC_AVDC_DIR_SIZE - 1)=
;
>         tsec->avdcache.dir_spot =3D spot;
>         tsec->avdcache.dir[spot].isid =3D isec->sid;
> -       tsec->avdcache.dir[spot].audited =3D audited;
> +       tsec->avdcache.dir[spot].auditallow =3D avd->auditallow;
> +       tsec->avdcache.dir[spot].auditdeny =3D avd->auditdeny;
>         tsec->avdcache.dir[spot].allowed =3D avd->allowed;
>         tsec->avdcache.dir[spot].permissive =3D avd->flags & AVD_FLAGS_PE=
RMISSIVE;
>         tsec->avdcache.permissive_neveraudit =3D
> @@ -3249,11 +3248,17 @@ static int selinux_inode_permission(struct inode =
*inode, int requested)
>         rc =3D task_avdcache_search(tsec, isec, &avdc);
>         if (likely(!rc)) {
>                 /* Cache hit. */
> -               audited =3D perms & avdc->audited;
>                 denied =3D perms & ~avdc->allowed;
>                 if (unlikely(denied && enforcing_enabled() &&
> -                            !avdc->permissive))
> +                               !avdc->permissive)) {
>                         rc =3D -EACCES;
> +                       audited =3D denied & avdc->auditdeny;
> +                       if ((requested & MAY_ACCESS) &&
> +                               !(FILE__AUDIT_ACCESS & avdc->auditdeny))
> +                               audited =3D 0;
> +               } else {
> +                       audited =3D requested & avdc->auditallow;
> +               }
>         } else {
>                 struct av_decision avd;

Out of curiosity, have you re-run Linus' kernel build perf test with
this patch?  We obviously need to fix this problem, it's a correctness
issue, but I'm curious about the perf impact of the change.

I also wonder if there is a cleaner way to do the above?  Maybe not, I
need to look at the exact code we have in-tree, but it seems like we
have some not-exactly-the-same-but-very-similar calculations in both
the hit and miss cases.

> @@ -3263,7 +3268,7 @@ static int selinux_inode_permission(struct inode *i=
node, int requested)
>                 audited =3D avc_audit_required(perms, &avd, rc,
>                         (requested & MAY_ACCESS) ? FILE__AUDIT_ACCESS : 0=
,
>                         &denied);
> -               task_avdcache_update(tsec, isec, &avd, audited);
> +               task_avdcache_update(tsec, isec, &avd);
>         }
>
>         if (likely(!audited))
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include=
/objsec.h
> index 5bddd28ea5cb..baf7564c6a2f 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -33,7 +33,8 @@
>  struct avdc_entry {
>         u32 isid; /* inode SID */
>         u32 allowed; /* allowed permission bitmask */
> -       u32 audited; /* audited permission bitmask */
> +       u32 auditallow; /* auditallow permission bitmask */
> +       u32 auditdeny; /* auditdeny aka ~dontaudit permission bitmask */
>         bool permissive; /* AVC permissive flag */
>  };
>
> --
> 2.53.0

--=20
paul-moore.com
