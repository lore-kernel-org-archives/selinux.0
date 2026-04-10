Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D5C33D51B
	for <selinux@vger.kernel.org>; Fri, 10 Apr 2026 19:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850614; cv=pass; b=MkbuqY+SZ8DAcIEKvKQABkU1/I123rWImRxDaMMU041qkay5p/3NTMuZBbXFJWvPxqSDbt1xKdrV9qMgXhch++46JIM7yfWLSEfSjXqqz4ohEaBH32PCkRRUglNR0KwFH8glyZmaxb62uhwFor7PNAaJ/Rt4Rt9POUtSRFqrvjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850614; c=relaxed/simple;
	bh=v+R0G0xkvSEID5KRV3dCCeXeWwdCSCJAjmaBx4YleIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXgAld3R4J+eJOYpU50ZZNhizC1yWBjfgvOrNKVa4Oo9gT1DwE/DBDDrSKXoFrikgFJLdGYAeADTeK9P/dNbuLDMmmEFeZDIeHWG37ghdnrOMpc1JZQENieELjj7hqmaULggxlZxmvX/wWSHGcYaGThZy/yu7JWfVZFFQ99ZPwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaPn8B9/; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaPn8B9/"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b258576d8cso14757585ad.0
        for <selinux@vger.kernel.org>; Fri, 10 Apr 2026 12:50:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775850612; cv=none;
        d=google.com; s=arc-20240605;
        b=FogYMurAipXzr/bw+lf8BBvEYOmLaP8bobhPyyGfKEcUwQefbGbMQ0avY04E4bO1bq
         StwdCsj0WlnWPQDPYwXzZYP2gyHZLsxBkw/1pF2mv0nM5irWv7kQ6YwnSTr8oqvBn3WC
         ML4mE6IwlU20E0wfMbOlsuvI7e0++O2qSZFlYk8zGAxEE9kZ4nvEOYvoiUl1ipTscbXu
         o9a3soJk0j8VnG3DIdAZlsURhfTwZ2MpRngXJeRGMXkRYqlR9Fhk2Ygz/lc22npzoL9h
         N6Am5IINpQLJZi4Vz9pAnM42nT1vy3tn/50EkBhp65KypSTMKHP7zgyPUyd9M+prfGMN
         7pFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/R1qESToYbBiDDiGrn0R02GBCnyYt95ErfdUWDAkxRE=;
        fh=K0P3yueWX+9wvznQ61j7DXol8naVFvlsq/Ek+LAYujo=;
        b=kXlBhBsnch7S0fFfZ/NXhSPp74RTAbAtlWLSf1W2PxJDR6V5bMg8bSS4IPt7cOM1lK
         x6joqoh28KdQ5tPs+A37xpo5IB5y6VW4+d7umJ14IUh0U3odE/z6Z0z7nSLHTnX3Lzra
         ym4sIGhwBn3zIUh+YXjQrtEr8Up0+hDubOa16JwCR+0A/1zDtxrBsg3e8Kt5Y1Lr6sao
         E33/c7uX0IaUTV16HYkA0C1eHYGdwwd5R42Sm9oBeQUmiMHvl6cacWX0NeyR8t7RxjWS
         9jHcG0F5b1cYP15OLA6qOVxhOOd1nVeianMzfEIQIAywGZ2ItwI1BUmdF4VDa5Xa2v0Z
         jsBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775850612; x=1776455412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/R1qESToYbBiDDiGrn0R02GBCnyYt95ErfdUWDAkxRE=;
        b=EaPn8B9/AqJpjtWQvW9h2ssEyrOk3NBg3xPv0Tfz5rP982UQFx8VeJ4wvm8PRBqETZ
         A0wBxXfzxUDcKnK8TVSY8+9mt2H78sGPXWnpt8sZM2YVc7nqN4zy+Acq9ay0W8Bdx4+6
         Ov/GeD+kEcMEZyGh6S+07MVbEN+/SQ1cfi9ks5jsiPSbQ8su3AQXnfcvgeTlxSjBLaBi
         qDBk3ke0RK95bpY2ZtyrxJf0OXvvr6uEG15IBuuSDl6CEPGuJRol11wdgMwCn1jJp52b
         80BOTz3knWZ7W5rZ9jhxTMMANQYTy6BENzyNb6LEIZXidcw0LX5XIUGKP8K7EKKi48sJ
         khvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850612; x=1776455412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/R1qESToYbBiDDiGrn0R02GBCnyYt95ErfdUWDAkxRE=;
        b=FnlpCjYfzJ66PfzhVG5m4XCFTOqXFQQmF4eoqTDGz44HneyZ68ngj7sBf67a7IQXsB
         x5jbUXXZudETdO9+Jw+0IkVRbDL+6deUtcFEBtAMZKY24LU52xm3YzKzExHIG5UEBpmY
         I/pA+YXE6PtUtMC1LiXIG07r2KW57oG+5jlOJIRxIYainVxKHe6LZbSNigueqHODPhPV
         8l/OJ5o2k8061It77WmDdsXofhOlegoIrT8uu8H2tUosYLjUuwnIhNP6ZFstAcWjeQp+
         p0k+iJ1jOLQgC+kdiYa/w++ZU57XoAUuplrDrJ5/D88BOi2QNmWMNUdoFBzWFOAG71vA
         ssIg==
X-Gm-Message-State: AOJu0YwExLw82nUhS5YCN3BOAku6jSmE0+eWm7MoIDOivgPkN6ofKBj3
	K218NItFKG+VsBrKVIYwvQWpVBPrDAD7bYtN1r2kWpMHZzl32wEwR80eKD0LO+sKZp9FQmS2ztE
	KHQSjivyE1IWjgwhGzAVV8E1/wnHwdcSaOQ==
X-Gm-Gg: AeBDieul5zM41k2nz0q9djaKv8Mgb4ip3g12OlwDy7Gi/o0qJdbmu4mYVrxt23d5hRC
	6t+HNmpDVM+0HWWoS5zy04HCoaF+xvoneU0UOkDukSVSTHye6a5yaOdHWjAIqKDv0n8t0L+i27K
	d/iM+/YuYKiFC6szuaadaV+LR31qi1LrHHG6YJAi8i2GaeKdhIwGzLna8ndLQLFy1odo7o7+f/Q
	7iVitk5ZAaZ2TQMppA4XzpSDReOYu5T7Y1Cawd13WpjSUB0WMraw8dT2ouYXbgiBxtwjPFxyi7J
	MsXBRLoQJ9/kHvxRvA==
X-Received: by 2002:a17:902:d50f:b0:2b0:b290:f2f4 with SMTP id
 d9443c01a7336-2b2d5a557d5mr45709035ad.32.1775850611834; Fri, 10 Apr 2026
 12:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410192949.16542-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260410192949.16542-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 10 Apr 2026 15:49:59 -0400
X-Gm-Features: AQROBzA7q7JAFHeqLgqv4nkHQ_0BjKtyHG99Xg5PtrI6T3SEHSDwR3U4-Ff2MwA
Message-ID: <CAEjxPJ6y9p0gs17s7090UcbAcA2KtGcj2nKqi-hBtNZ3zgwKDQ@mail.gmail.com>
Subject: Re: [PATCH v4] selinux: fix avdcache auditing
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 3:32=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The per-task avdcache was incorrectly saving and reusing the
> audited vector computed by avc_audit_required() rather than
> recomputing based on the currently requested permissions and
> distinguishing the denied versus allowed cases. As a result,
> some permission checks were not being audited, e.g.
> directory write checks after a previously cached directory
> search check.
>
> Fixes: dde3a5d0f4dce ("selinux: move avdcache to per-task security struct=
")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v4 changes struct avdc_entry to contain a complete struct av_decision
> rather than individual fields copied from it. This allows the use
> of avc_audit_required() for both the cache hit and miss cases.

Entirely up to you whether you want to proceed with v3 or v4 (or
something else altogether).
Just offering up options. Shouldn't be any behavioral difference, just
a question of whether we want
to keep the change as minimal and streamlined in the cache hit case
(v3) or prioritize ease of
maintenance of the logic (v4).

>
>  security/selinux/hooks.c          | 32 ++++++++++++++-----------------
>  security/selinux/include/objsec.h |  4 +---
>  2 files changed, 15 insertions(+), 21 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6ef9c1aade65..dbb03132d4af 100644
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
> @@ -3205,9 +3203,7 @@ static inline void task_avdcache_update(struct task=
_security_struct *tsec,
>         spot =3D (tsec->avdcache.dir_spot + 1) & (TSEC_AVDC_DIR_SIZE - 1)=
;
>         tsec->avdcache.dir_spot =3D spot;
>         tsec->avdcache.dir[spot].isid =3D isec->sid;
> -       tsec->avdcache.dir[spot].audited =3D audited;
> -       tsec->avdcache.dir[spot].allowed =3D avd->allowed;
> -       tsec->avdcache.dir[spot].permissive =3D avd->flags & AVD_FLAGS_PE=
RMISSIVE;
> +       tsec->avdcache.dir[spot].avd =3D *avd;
>         tsec->avdcache.permissive_neveraudit =3D
>                 (avd->flags =3D=3D (AVD_FLAGS_PERMISSIVE|AVD_FLAGS_NEVERA=
UDIT));
>  }
> @@ -3228,6 +3224,7 @@ static int selinux_inode_permission(struct inode *i=
node, int requested)
>         struct task_security_struct *tsec;
>         struct inode_security_struct *isec;
>         struct avdc_entry *avdc;
> +       struct av_decision avd, *avdp =3D &avd;
>         int rc, rc2;
>         u32 audited, denied;
>
> @@ -3249,23 +3246,22 @@ static int selinux_inode_permission(struct inode =
*inode, int requested)
>         rc =3D task_avdcache_search(tsec, isec, &avdc);
>         if (likely(!rc)) {
>                 /* Cache hit. */
> -               audited =3D perms & avdc->audited;
> -               denied =3D perms & ~avdc->allowed;
> -               if (unlikely(denied && enforcing_enabled() &&
> -                            !avdc->permissive))
> +               avdp =3D &avdc->avd;
> +               denied =3D perms & ~avdp->allowed;
> +               if (unlikely(denied) && enforcing_enabled() &&
> +                       !(avdp->flags & AVD_FLAGS_PERMISSIVE))
>                         rc =3D -EACCES;
>         } else {
> -               struct av_decision avd;
> -
>                 /* Cache miss. */
>                 rc =3D avc_has_perm_noaudit(sid, isec->sid, isec->sclass,
> -                                         perms, 0, &avd);
> -               audited =3D avc_audit_required(perms, &avd, rc,
> -                       (requested & MAY_ACCESS) ? FILE__AUDIT_ACCESS : 0=
,
> -                       &denied);
> -               task_avdcache_update(tsec, isec, &avd, audited);
> +                                         perms, 0, avdp);
> +               task_avdcache_update(tsec, isec, avdp);
>         }
>
> +       audited =3D avc_audit_required(perms, avdp, rc,
> +                               (requested & MAY_ACCESS) ?
> +                               FILE__AUDIT_ACCESS : 0,
> +                               &denied);
>         if (likely(!audited))
>                 return rc;
>
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include=
/objsec.h
> index 5bddd28ea5cb..9b5151ad184c 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -32,9 +32,7 @@
>
>  struct avdc_entry {
>         u32 isid; /* inode SID */
> -       u32 allowed; /* allowed permission bitmask */
> -       u32 audited; /* audited permission bitmask */
> -       bool permissive; /* AVC permissive flag */
> +       struct av_decision avd; /* av decision */
>  };
>
>  struct cred_security_struct {
> --
> 2.53.0
>
