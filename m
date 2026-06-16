Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC0432E73E
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629202; cv=pass; b=fRgGFnhp7lDLQFys2DuUNMxWg0d+NBE3QGpHKkm7aiyCtxH91oR/yWbYQ2TWtLB66c7jMIwZkjFaFdbv4b4msbjAj9yv8AuZX+68QByVq9Erq1VZ0gbpATTeGmSnAsK82uRNAdZNnam/jmZp4trhBYcNw1RbhpErPVcBL5GA7k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629202; c=relaxed/simple;
	bh=6qZkzbd3/7XKl+bg2YEt27DR3sR1oS8FoebC0f68kfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EblEMGUkQkz2tiZ5EbtWy9LmHygNAfzwxHZG/QuteyR+epI6y5phAbvmAsIn/nUWtlU1iUMgKLRwJA5mEtM/cy3Fyl+Ly03jL1tuWgFYa15bBaT4gEq+beMvwRtCNsfu4hWAcfJnSnfbLkxTcY8CwrveTyBgBWz0hNuKgAIz0UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iaJ9talv; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaJ9talv"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3966c0d5ac9so43005711fa.2
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 10:00:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781629200; cv=none;
        d=google.com; s=arc-20240605;
        b=OVH6RhxDTS+9aCQv97jcGoDeijpAzzoKVM7lAlq6XjkcfX11tdBzEg+PPEx9yywEqo
         Mz7aCsJ5F+QmzWBofNbTXFNrnS+tdbFt1WgJsbv6dxNTbpc5derbP0lgwOHZi8q+t/Zg
         s/B1DhjOrWZoLk6v4ONvyGk+XYZxIgWJ+a1M+VZrfrS2HrGFmB48juiAFBAoLx3L61AS
         nlt6zryuWDQAKg/trJm8f4wJsS8JYKQfGvYbcyEUGSyDiKjlYtha+858WbGyQ3f0Hokk
         kboqLftsLQ99iXBq/Fpwj6nlEm3trNRKWYxBvj+EKlBy8nNFGm1/VRgEWsA5Kuh3c5RB
         aRhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FKA7SE/ZEH69ZVSjHdyfLm5MXV6i2GJM52N+3rSDtiY=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=Qe5yfZemDyxo28gTqMr9cVwi9n7DRiuzbUnuZS1py5hw9WRDglWot5POGbHYfOz0tC
         TIzrL7IfdST8I9uRbIZ6iyOWdj+4n9K5nJhmn8o/mepSL5gYC0YZW+dzok1/tsEGuh2E
         hFyIr25Le6XgBVR//kpAzYoqZLjCpvS2d0BEK9hzphJbE3AmBwyd5Grl7UY//kPO+htz
         /YYxRnqwPdggaKMHV3ymmBdqN6UHNzWNXMrjTfi1A+eLlg2jDXNSfAcwzq0HU2tWN7ic
         M/XuMq5F4GBNEeeRzhXcYtxTj6aQkVZerX5YGEpssx/i9yOQAB1oSenw7NqdhoRfnEtr
         8vZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781629200; x=1782234000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKA7SE/ZEH69ZVSjHdyfLm5MXV6i2GJM52N+3rSDtiY=;
        b=iaJ9talvg3nvZnLRKAF30y7kcHvoVUOixRwq2GtwI2+WFJqZj44Qafh1VTeGDHPSDe
         k6zLcWT+CY3GPQl5nELgCj55JCf8qmNjn/wF+5TD0wxH1rIqBDyRLKFBo67v715i/JnF
         gacpqSIoMZtK6ah8kG2vPV3IjtXU4TGFX+k/AgZFP+fu58C2IZqG3flNLZBAz0niRoJC
         5TivyIY6XehugsiCKdi2CuRCbcocVE2yL8xOtrBJpHx0y1juiBjDzG19YNBi1ICVSF1z
         auGzfjIYXHRo98uo8lJvVQ7LnDZVbdQC9/QCunxxozFixSt3+cg5uOSEGWo8sw/1QM2R
         ZPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781629200; x=1782234000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FKA7SE/ZEH69ZVSjHdyfLm5MXV6i2GJM52N+3rSDtiY=;
        b=cK3fAB3miA80p60+5l20dun8+9VsUHE0ZvTqbeXDyD4O3lRAWaysYNCU42T8vy2WsF
         h9BCZbbBphooRQcaRoSO+RjhZAZOxgp0S5P1iE5xjXAR5BrMeVL6xLXsrFS1pg5wmBZC
         ih8tEbu3J5YMCR9Ibtvhi9eqp0cKLeWR0XE70EV4lOh7xENUfbAY02cmvNgNxM2VHIvI
         JjU25WjjKYnEz+rn42ZwWJeDsSYpspwKcf3Gvna9D159ckCPog2L094Lc2G2iNATZzGU
         uhVyf2atzu4MpS1hnlFKzcbQ7kYxMDPiqpVuGUbQETPi/rlcqsgz/XqrH2y9ctnmjyR4
         NaCA==
X-Gm-Message-State: AOJu0YxStfiaZ1Fji8joOR8iVetSSy+jVIjUSP342rvWAdVldxfFk+Bo
	VclvaeibZdqbDDzkOIo4454Nl983xVj9nev2Uib6J5HvKIb8QLfECo0vw3crAaFA9oD2Q5HEAH0
	xVUD2TB7JDcoZddVc0JglavPhAGi9cjl6Vksu
X-Gm-Gg: Acq92OF9wpPcfp18SNb91NM9s8pb3aUJKHJsI3MMLGyFk2V0WMYt5T7MnNxhaFZB9xp
	KAKdZtC3Dvi98FjmkHFJOlZIp8aCSHPJBMwgsGY4V/1LoQc3U2LLA3BxPjQNURvMSdyQyNJU7N4
	yxEoXRzt+Sb9ZgK4oTOdv2T++X1QeOAojaATPu5j1AVIgudbO97QM+NAoAVSE+bqu4Y/zd1rJfX
	Ky49TwafaGxyG9ErQ9IcSXskxVUdZMmSbMCq+F/W207gsOa44jNaXvP+zacQVMaTeGgAQzxL5uP
	pnZdbwp3aXT8jJo=
X-Received: by 2002:a05:651c:50b:b0:394:2b8a:234a with SMTP id
 38308e7fff4ca-3995c848d52mr15927581fa.25.1781629199327; Tue, 16 Jun 2026
 09:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616144345.478744-1-cgoettsche@seltendoof.de> <20260616144345.478744-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260616144345.478744-2-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 16 Jun 2026 12:59:47 -0400
X-Gm-Features: AVVi8CdGpswT45UrKIxzNy25et2DvELh0797DNc9O7T1nZOZap8HFo-0Pcn1YTg
Message-ID: <CAP+JOzQkV2HcYF1UxArFwQjiSqsY+F0W_5WGOVhrHssm3HsGgQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] secilc/docs: fix wrong CIL statements
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 10:53=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> - fix missing closing parenthesis
> - fix enclosing of `sensitivityorder` datums
> - fix typo `low_high` to `low-high`
> - avoid double enclosed `((all))`, valid but particular
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  secilc/docs/cil_access_vector_rules.md       | 4 ++--
>  secilc/docs/cil_default_object_statements.md | 2 +-
>  secilc/docs/cil_mls_labeling_statements.md   | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/secilc/docs/cil_access_vector_rules.md b/secilc/docs/cil_acc=
ess_vector_rules.md
> index 47da60fc..b95df953 100644
> --- a/secilc/docs/cil_access_vector_rules.md
> +++ b/secilc/docs/cil_access_vector_rules.md
> @@ -168,7 +168,7 @@ This example will not compile as `type_3` is not allo=
wed to be a source type for
>          (type type_2)
>          (type type_3)
>          (typeattribute all_types)
> -        (typeattributeset all_types ((all)))
> +        (typeattributeset all_types (all))
>
>          (neverallow type_3 all_types (property_service (set)))
>          ; This rule will fail compilation:
> @@ -313,7 +313,7 @@ This example will not compile as `type_3` is not allo=
wed to be a source type and
>                 (type type_2)
>                 (type type_3)
>                 (typeattribute all_types)
> -               (typeattributeset all_types ((all)))
> +               (typeattributeset all_types (all))
>                 (neverallowx type_3 all_types (ioctl property_service (ra=
nge 0x2000 0x20FF)))
>                 ; This rule will fail compilation:
>                 (allowx type_3 self (ioctl property_service (0x20A0)))
> diff --git a/secilc/docs/cil_default_object_statements.md b/secilc/docs/c=
il_default_object_statements.md
> index be7facaf..6f72a36e 100644
> --- a/secilc/docs/cil_default_object_statements.md
> +++ b/secilc/docs/cil_default_object_statements.md
> @@ -195,7 +195,7 @@ Allows the default level or range to be taken from th=
e source, target, or both c
>  When creating a new `file` object, the appropriate `range` component of =
the new security context will be taken from the `target` context:
>
>  ```secil
> -    (defaultrange file target low_high)
> +    (defaultrange file target low-high)
>  ```
>
>  MLS userspace object managers may need to compute the common parts of a =
range such that the object is created with the range common to the subject =
and containing object:
> diff --git a/secilc/docs/cil_mls_labeling_statements.md b/secilc/docs/cil=
_mls_labeling_statements.md
> index 97d1459b..65e55a7f 100644
> --- a/secilc/docs/cil_mls_labeling_statements.md
> +++ b/secilc/docs/cil_mls_labeling_statements.md
> @@ -319,7 +319,7 @@ Define the category order. Multiple [`categoryorder`]=
(cil_mls_labeling_statement
>  This example orders one category alias and nine categories:
>
>  ```secil
> -    (categoryorder (documents c1 c2 c3 c4 c5 c6 c7 c8 c9)
> +    (categoryorder (documents c1 c2 c3 c4 c5 c6 c7 c8 c9))
>  ```
>
>  categoryset
> @@ -675,7 +675,7 @@ This rule will transition the range of `sshd.exec` to=
 `s0 - s1:c0.c3` on executi
>  ```secil
>      (sensitivity s0)
>      (sensitivity s1)
> -    (sensitivityorder s0 s1)
> +    (sensitivityorder (s0 s1))
>      (category c0)
>      ...
>      (level systemlow (s0))
> --
> 2.53.0
>
>
