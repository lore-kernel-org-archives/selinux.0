Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC29A439F6E
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784908144; cv=pass; b=Pt2OQqUHeEqvsFfWKH2NYpfjNp/czhLVNmksOy+Ek6yfRR5ZQHNBJxBYNbi9476GPhclpqEGwY2dHUl/t1W9ztY+SqxjpiLSrNJX/zJRGOh7DKSBxZEDohAnBmj0bG7jwEfm9aTsnZ8uz5rnd8Du8r17uUtVIJxjgOUcg4pnVkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784908144; c=relaxed/simple;
	bh=L0w3DlMBsyN9kTTaho7o/3sCULltUY2fSdGjQJXmhko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pmFvmobjGO2EX05KI99fOdr3rLracXGjAFs7R1QOVuYNmXJEoP7ofSjE1jAqAQSZn0+k3gfe7xKh+JMloayRyUlXwSDS9ZRopmmuLO8BkaJcluVy+UTO0g233YwaD05HwktQnpi/BheLS11wCSxKn6hqV8/73jLV0eqPth800MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rBdvaHdu; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBdvaHdu"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-43cce34c881so323960fac.2
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 08:49:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784908139; cv=none;
        d=google.com; s=arc-20260327;
        b=SjGKk7UAcsZBo+dVOEjF9tw6IFLET1K4K4MTgomYaXLLDKzvCaZbJmg6g2Y1hzJvnu
         VoO/Z/J2Q58eXY35rQ15pDsjRhjfpweVHgMI9kKn/KN+GoEtnMgipa5dPxhsmW1JNwm7
         I7ZI076S2hWm9n3i1IVbjPrbehfd5vQjg0DoFxoRaaT4NWRSvs77Xsum6EHJwKfzGBZ6
         SJhETvziyRwwGfAzwDJnmrGErEDZnJS6X604XC/tifzvPs9hRaqaB55O9VluGvZWs089
         w8AAMNN1HU+Y3UuI+SjdkkGUCR7vgA3rhXbjWStxvm+ttfCiwxlv6IoiOJGXECF1mNFe
         Xh2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aWrip4EpYnw3WtGEkwRGSuDIQFek5NZ9KDCBTUtrOyw=;
        fh=q02naxEVTHOzCTHameE45fSInP+biETKMxYBZRnuD3I=;
        b=kG/ETinpgPknJU4CmTWREjPvBMBOKiCp5czcxRHQAG4qPr4ZOvky4JfN14/17GCLTD
         DCv7bB/j1VhkF6QETTXHVgYlKfJsFKgEvk441F5+PugtDxhc7sjkJq7MBkZ2nSzxNdje
         jUAtHKQ/PXo9fdMy+QfBo/jRMejqNzOJqhi5mvCFw67pMU2haBMEs19X/2FRyg5PGdpM
         /ant6cdexunlI2+YpnVo++3X+wSFyHqit01+fLLFB47nSCJE6TQQb71NLBmEujQbbCx4
         dZuntmpAZnc3uLx7B68ZZc8mqXPHFfIzkZBMt+e5qhTvxfT36qJPUqLwibUn7UD3zVhm
         EQKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784908139; x=1785512939; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aWrip4EpYnw3WtGEkwRGSuDIQFek5NZ9KDCBTUtrOyw=;
        b=rBdvaHduInFc13aGKm1fqiLEtK/m3ar73IxijClbL/oXVDqE3ChMEPUlOlDQL7pwJJ
         lQpuprnfUyi1+Iti2JWwFnImdN84bx+xz/UvfsEmLSC92EA1LGmaBEeT7hSLuxDfbmjS
         T+Mnl17l9c3IzaeuI6Ydh0pwXfkOF2FHrPK6YygkrzLzs1FwY+wsWfNLR0xKHSsKe5UT
         JQxHdnfOrk9p7RPm0EgdwgIi2i9ZQxzToLGaZpMihcqsPzsC6er3vCQCuMlxBLWVBdpN
         /0lM3lF+yYGWTl5Xrn4uAm+B9Rg40tEC4RS8tMUEk/JN/rA2DY4rcIWzRLlwU71f1E6S
         YjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784908139; x=1785512939;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aWrip4EpYnw3WtGEkwRGSuDIQFek5NZ9KDCBTUtrOyw=;
        b=iQH/30Z9+vj7crDbFTSBOPF4PFXx1AX3fwG8jvUlzriXrrX/40Te91au1EOVk9NZua
         vTRb0IhFvBzqM1I5S7qrtG7ZiySYpkoLCrMEBTW53GiiTapCa0fe5MTguYRge7taXAfU
         Lm87uOvkCGXSUgekKKD20odU7SkN7eU9zQ7PksPiD4Y6jUaVebFfFSCgF47tC9kzioBU
         nCAFCxBM0vg+Ngani9URZ1ffzDiHxjaCfKJ4Rkg1d8EIflzRI7eGuRl1bhgMr0Bmn8JB
         FNz90AAaicWa6C4HMhgdsVaMvQu3mZtC72dBNB3eGlneQKX5dzcDan/+stKjQoX6q4mD
         0O/g==
X-Forwarded-Encrypted: i=1; AHgh+Ro+tcW3blc3xN1zNJD2VNVjg4kSSZzUDU+wfk7yfPXU3hornkJ7gTFuA6IE/tE73x/MfsACVb0y@vger.kernel.org
X-Gm-Message-State: AOJu0YwGDi/9uqv7FWLzXjC7CcD3WtTlTjr8pjdYgQLP5rFrgYNfeC5/
	UGVc/esxeV0Ru/BIPOK8bPqSfBsromFA1EIJsHuM4q71/QVWpvtsxEUR47pD6e4/NOtIEeWFmsN
	Fz5l1/kFs0l0nozB4/AfaZ0yq/qSf2e0=
X-Gm-Gg: AR+sD12wD0OYtdjJ2DZIOpXK+x8VdFjT2zX3ICxvqdAfLWDTgHbma+tlBtvqneZ2Hh4
	olGOFHcwJax8BNiAaPJfedf2NWVw+ICmeuZP+tSN68EvnWjFOqva/hFtTU1Ibo6iu2ARA40feyD
	Xs8e7KwDV99IS6t4TnjfYYSbWO/v/b1YrslmFsZ16xoQxxMl9sItG5vEwTA9dKsMypmGbKJJp8t
	KFu/UZlnWkoBtv2ypU2oaPMI+UG84GqDnIqyEg1K8fxwJTr1hbBf/G527cF1A==
X-Received: by 2002:a05:6808:179d:b0:496:9b3:486 with SMTP id
 5614622812f47-4ab353a89c0mr4824793b6e.14.1784908138844; Fri, 24 Jul 2026
 08:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724-b4-disp-ec8ac9f6-v1-1-d76d51a69b9d@proton.me>
In-Reply-To: <20260724-b4-disp-ec8ac9f6-v1-1-d76d51a69b9d@proton.me>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 11:48:47 -0400
X-Gm-Features: AUfX_mzk0CUJehE7E_xvwRRgkWHCKlrIz3ups2HFQzmc3b4ZtNblBxXzM6Cn6GY
Message-ID: <CAEjxPJ4_chAbtJa4obgN+QSjMnCwk9XQ-4bnyOFxgFoFxTsV9A@mail.gmail.com>
Subject: Re: [PATCH] selinux: reject a permission value exceeding the class
 permission count
To: hexlabsecurity@proton.me
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 10:47=E2=80=AFAM Bryam Vargas via B4 Relay
<devnull+hexlabsecurity.proton.me@kernel.org> wrote:
>
> From: Bryam Vargas <hexlabsecurity@proton.me>
>
> perm_read() bounds a permission value by SEL_VEC_MAX but never by the
> owning class or common's nprim, which is taken verbatim from the policy
> image.  security_get_permissions() then writes perms[value - 1] into an
> nprim-sized kcalloc() array, so a class declaring fewer permissions than
> its largest permission value drives an out-of-bounds heap write.  The
> top-level symbol tables are validated this way; the nested per-class
> permission table is not.
>
> Reject a permission whose value exceeds nprim, which is already set when
> perm_read() runs.  Well-formed policies are unaffected.
>
> Fixes: 55fcf09b3fe4 ("selinux: add support for querying object classes an=
d permissions from the running policy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
but also see:
https://lore.kernel.org/selinux/CAEjxPJ7YRgtOXrbPYar0qXAq=3DwNbOTTMS-EsU=3D=
9HKR1NQ3qA1g@mail.gmail.com/T/#me98ec932b314ae94242ed3af7ab74445d273cc7d

> ---
> Reproducer and A/B verification (below the --- so git am drops it):
>
> A binary policy whose "process" class carries permissions.nprim =3D 1 whi=
le
> keeping its 31 permissions (values 1..31) is accepted by the parser.  On
> load, security_get_permissions() allocates a one-entry array and writes
> perms[value - 1] for each permission -- a heap slab-out-of-bounds write.
>
> Tested on a KASAN kernel, loading via /sys/fs/selinux/load:
>
>   Build A (without this patch): loading the malformed policy ->
>     BUG: KASAN: slab-out-of-bounds in get_permissions_callback
>     Write of size 8 ... security_get_permissions()
>     (followed by a GPF once an adjacent object's pointer is overwritten)
>
>   Build B (with this patch): the same policy is rejected at parse time
>     (-EINVAL); no KASAN report.
>
>   Control (without this patch): a well-formed policy (nprim =3D 31) loads
>     cleanly, no KASAN report -- the fault is specific to nprim < value.
>
> Reachable by a process with CAP_MAC_ADMIN writing a crafted policy to
> /sys/fs/selinux/load; SELinux policy load is not namespaced.
> ---
>  security/selinux/ss/policydb.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index ead504a639e3..6973b68d9782 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1175,6 +1175,9 @@ static int perm_read(struct policydb *p, struct sym=
tab *s, struct policy_file *f
>         rc =3D -EINVAL;
>         if (perdatum->value < 1 || perdatum->value > SEL_VEC_MAX)
>                 goto bad;
> +       /* the value indexes an nprim-sized array in security_get_permiss=
ions() */
> +       if (perdatum->value > s->nprim)
> +               goto bad;
>
>         rc =3D str_read(&key, GFP_KERNEL, fp, len);
>         if (rc)
>
> ---
> base-commit: 48a5a7ab8d6ab7090564339e039c421f315de912
> change-id: 20260724-b4-disp-ec8ac9f6-576c3f177a04
>
> Best regards,
> --
> Bryam Vargas <hexlabsecurity@proton.me>
>
>
