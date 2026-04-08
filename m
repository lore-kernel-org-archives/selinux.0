Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499B23D88F4
	for <selinux@vger.kernel.org>; Wed,  8 Apr 2026 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671101; cv=pass; b=aXpv3RbQecE4DuWHDsKeNgFvTQat1VoJxiRQKooSkA+LpK2DJ06ZMyvzMfoIK0GYhOzLmSJEnvy70aYIrhXEdi9q/HrMx/o4vf5wIoJ3TXfO1bNA1qSi7u1L+jx07Fe4dEb053eyT5dPCJ+ebJclwgeXuK8MmkuByVPgrvbJFhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671101; c=relaxed/simple;
	bh=e5GW/bRLMUaStgI3L1Yet361w5rKDZTWJeh1qhII0E4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+tunhx/elYdIIaIXeyDFdLcuRdmAPnTWO1KZ3QHddyEGjKTId0BH1dFvaeRac14PuehYNcioRTsncGCcV9JuuGINt0c8fVmmQLHr/FzQSXVRf74aSMEmYrKm9iIu8UjhmULmVfcNivXj4vxlhRRWxxypZi1wfsE6Z3lOU97AMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Euf2jiZG; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Euf2jiZG"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35d971fbcddso10349a91.1
        for <selinux@vger.kernel.org>; Wed, 08 Apr 2026 10:58:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775671099; cv=none;
        d=google.com; s=arc-20240605;
        b=SqMNxXN3IdH0mvribI+IDIyZl2XQtzKEDVRZg2CNPAATZoBNxrYD402m2L2Gtu2GSP
         As+ytCywI25UaiJ5X7GmNF3KWQZQWPtn2UqvIlNToy5MbKbz3uP+dfY4o91/AHi2XxuC
         6SJe9oFviJJjd0+ASpgWwL2p1NE+vOk+t4yAQLpKmIVr3QxATfFIK00tuCBZgTVTqJ6J
         QWFpaemX3bmqyzGS9wZC4swTV5YLFX/QB1cHqLJJIdDpTGAzLx3VGHdFYOnZuAp4ZiC6
         4Aq5DsxG4wsMg6Z+7STaP5MRHyWZG5EASGGh2IF4S4HCGtdh9L7URdeYbggx+sBUviw4
         FL+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SyuF2Md+isiLowR8SUIW8ahKPK9TwpzzN+gXSBxcH1Q=;
        fh=lOev/QwE9DXSi83P/KluQ9UjJBSvfLYOVkCl5H1rM0Y=;
        b=W7yFtuqKh9OPv80y8IUszN/SAAPCj6q4vV2Snz6yVP1SBBcp+lAzEkXjbZOG5kYuDD
         gZ2Lg6AeL29er5A3a5VfajaNpfOTwyNCxOgOcVVcbQOi6BbUX/ZiBzMZFnQvDGxbupmr
         ErTCZjE6S/rRp7o+KA+DLlA0xk0zgYazsnP/rA5PZY5X3Nl4jSexv1pUCBIcGDDnOR8U
         7EwqkZdubrptBhNacNDag9o3+jDmXAl5KQHNSiSmCJm5ewNjCW2YPqK/O3vF4HWBRblb
         LZzKsTcDpYwOFoSBrF35PUNPWX0xifLfBLqH6MCpqoq1W2yD4j/CvcsHIlC1oHHwG46I
         1oVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775671099; x=1776275899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyuF2Md+isiLowR8SUIW8ahKPK9TwpzzN+gXSBxcH1Q=;
        b=Euf2jiZGXNABWo2isEAJLvYEGC9YYrE1XtReD0TTEevxfmOG6J4SMgYLVGa/Trznri
         U3gkO3FM4Dz7bfuG+znhRAiV4cg1ZatsnjTpW6NrPgqTzw9yRoSeYX7QLlKgw+3cOcVw
         0d/b3eJXuaOsOthBAXWpQCYLSevEphDc+qLfnVr9t+mN5PQPQ6yOGoiDL+bWFJWEXBU4
         kUvza5cxwgi/Gc819TBHj3Q7qFG89Uy01j82waFN4FUPo9BBtk5n/Lc3rxf1G906FB9B
         dzi+ji5SdEzVwmS1TUupKBUIdPHtxC4bm5j6egAQdTog4UzE2X6um2JCTrAwoOqgLYbH
         Cdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775671099; x=1776275899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SyuF2Md+isiLowR8SUIW8ahKPK9TwpzzN+gXSBxcH1Q=;
        b=UwLDGKgAABFYbCCwzfu6cTblwNBGb9KHZMBIOeo/jJ5DxBjEs0vEHu6pmDXFx9KYt5
         Bj5XFiVV0l0+CdYKi/xKWMGKRDoQLJNAzb8/zz0/Si+4vfwAFM7T9AnJCfocxeahVwrG
         ha5Ie4TCy/EGHiQp0WwZC3uvJJwZ2Zry1QtH1wsKdUL6ZvnHACiGZfT4aUtGaBEJ6WQO
         SnUTFrhW/KsJTc9BGrBnEucKg/13swV3W0Aod6t4Fn+YzEWywPNm0cBzWiL6FjH/Sy9l
         TUZ0AT4IJDdYg4sdkFFi1TzGb4TBCs+wPLiZJub7OvGe1es0njAOHZpbUrA2DY/T6lGx
         TH2Q==
X-Gm-Message-State: AOJu0YztqKKCgSEp9bIFfSngb0crbV9EBQZNX9J8REHZGQdggvDzKIG3
	q2uGadMuZAef9JpJNXUe+eCcj4+KyXiLCAKHX7iNwP7TqfBnaNGuvuTcvQ7nnRKCCVO5nZZWHOL
	rmTDMqgc+RWiOPSRSsl8BB0Bjf4l1mwg3t8Em/+S0
X-Gm-Gg: AeBDiesyZB3Wd2l13s/jqJqy9vf2Bdij8LikBJ+F44u0c5TC8VITm+/yHAQcLG+IRYa
	Mkx2E0A+skFdkBn8aq2XJpqSBbJHy5a07gsoblnEBeEqM0mhC9dXxfUV232qrFbv8y1T71e1vkf
	kb6gAg+w4EU0iYjZiHHVa5niSAaayZ/w0hxbbzusQ2sYqzcbpsI0fd2RR/93ypyIs4eYI3F9qZA
	HIKfEbGAiBstbgMeMN1DCMr8LmF/fZK7DWbQkjAR4l/YGL5CCOebK+m4INl7MIT/j0eECnGuraF
	EKW5sC7bIGzp9jh2CQ==
X-Received: by 2002:a17:90b:2b4e:b0:35b:e4d4:8290 with SMTP id
 98e67ed59e1d1-35e3543bb82mr343855a91.9.1775671098653; Wed, 08 Apr 2026
 10:58:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408174510.16051-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260408174510.16051-2-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 8 Apr 2026 13:58:07 -0400
X-Gm-Features: AQROBzC68wyQ4cXK3xfrHPcrGnN_qmw01rpPcxywYZ-k_ajBGFRsUI2FYmSMU6w
Message-ID: <CAHC9VhT29U5TGMNgqJ3xz7rW8xe0SEFHa-Tk8ngw=Zn1k3Fm_w@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: fix avdcache auditing
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 1:45=E2=80=AFPM Stephen Smalley
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
>
> Fixes: dde3a5d0f4dce ("selinux: move avdcache to per-task security struct=
")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/hooks.c          | 25 +++++++++++++++----------
>  security/selinux/include/objsec.h |  3 ++-
>  2 files changed, 17 insertions(+), 11 deletions(-)

Of course I hit send on my reply to your v1 patch only to see a v2 in
my inbox :)

Do you have a quick changelog of the changes between v1 and v2?  It
looks like the inode permission code changed ...

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6ef9c1aade65..c279ebdb3a33 100644
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
> -               if (unlikely(denied && enforcing_enabled() &&
> -                            !avdc->permissive))
> -                       rc =3D -EACCES;
> +               if (unlikely(denied)) {
> +                       if (enforcing_enabled() && !avdc->permissive)
> +                               rc =3D -EACCES;
> +                       audited =3D denied & avdc->auditdeny;
> +                       if ((requested & MAY_ACCESS) &&
> +                               !(FILE__AUDIT_ACCESS & avdc->auditdeny))
> +                               audited =3D 0;
> +               } else {
> +                       audited =3D requested & avdc->auditallow;
> +               }
>         } else {
>                 struct av_decision avd;
>
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
