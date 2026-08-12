Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B755C2D3ED1
	for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549598; cv=pass; b=JSqtNYtxDkQxMmWRcy0THjw91MCNITgVJINzVJXCyv+Xt60mQzYcOeJEdO1qMRijYB8lloCuK8OmVrY/uz/2qQ+DX0f5p6mma3chexZZusq81wI5juVH2Quc0gYYI7/XV/cUvujf5cQrcJGMRunrY1Yqj6uGkryMwI3JOqIuaxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549598; c=relaxed/simple;
	bh=i+rs9mGx/Xdu0gAkG1AbUzaG+28rInZnZXMjcjdNYPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIqsr90C1vi5BpzIm1PaNg5tfGwO+wartgKH8wmGA26yCAoOah+qNt0zBhKpNmd8f2b5jutriDdh+L66xcuD1VedHmz0kUW0fKP0AysBR+KrLNKxA/kFvwtvcjbjU98EGhf+dzMxigx3YLjcMQtXbXY2CQwBKblLD6oFF8AARxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DD+GGUw0; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DD+GGUw0"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-459281bc13bso697091fac.2
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 08:46:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786549595; cv=none;
        d=google.com; s=arc-20260327;
        b=OaVZlrS+8Qk5WzZl0nu427Pyc7OafkbrIs6u+XfHrZ74xyPf9NCY6jnRkGZzYK9S8j
         Yco/eoalkxr+GGB6f5u78X1vXB7ROM35TGDB8Pp8AA8H3VpthhIg3UD7xERMltBY3wXK
         IuwV7PyUOIBrz5V0WnFslcC9f/9x+et4HKfru5zqLvNLMQsPvOl4Nm7XFnj+T+owZzZS
         BPOR8eYRiahvL6amIny78IjocFODT+1TTs1Aeiev/625c3hDVTBvFSwrUrUijtDQtt3x
         bTOO+hFMjqcEGA+mC3rn67kwx6aVkKfOIY8GN17FexgZVeMzWMb6mlifR1bJ94dpeo3n
         JFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i+rs9mGx/Xdu0gAkG1AbUzaG+28rInZnZXMjcjdNYPk=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=QpaGQBKiQEExl/3En7uhGwIiXzMxcy8M/vDgpuZUPTQ3ebPWEOmF2pataNKakENkrH
         D29OFVmAdoef/9o9QWG6G7g0QMk9H9Ba76yCJ5Fvk1J9tCeJ4ABDyUPOtfXkvUKRdeiG
         iLrWxg8HaAa4sWvSN3HiJ3HUgPPj3LF9k4i36TmOVIIwcpwIcnxiSRobwRdQyeHB5WFm
         6cNz2KqU5Xu5/ku83FeWmn1kDl7L4z9fnt4V41m1vjWgkKSqL/PWlps1hj/kHLgW4PxE
         xDq8PfACNzFLWRurAdScX0aequ4AdgS+ZjNCgYMpsC4vFJ6yvLJ0hBcnw4AoxTNeSazJ
         tpJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786549595; x=1787154395; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i+rs9mGx/Xdu0gAkG1AbUzaG+28rInZnZXMjcjdNYPk=;
        b=DD+GGUw0xC1WGX3T2eiOfSz7/AxAT7pkehRiTiCybxBFUzAdIj+Fp2BTGExxPEZB34
         FPhBn/pGHOoh7Kc11YkK5wCe3tgVuv+BneKmWzHUw9OUn06dhGtAhvNsl5rODbRGd2aV
         QWUqOp0BeO42JP3ljbtqgYUTPcy77pEVRj57fDysKEFNMc+NDvh3p02yfmIjWfgj28ab
         lAKsEi/TIPKtR1KNSi1NHEsa7cIqJ8QEOMg3nDwSI7wazU1S+4h+6Nka5txX7HsSHIPk
         zSJ+2EgVpnVldE0MT8rKQzT3fITJ8DQia3T7i+mudoVY5DJADzawutItyFfwTUkaelqs
         pYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786549595; x=1787154395;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i+rs9mGx/Xdu0gAkG1AbUzaG+28rInZnZXMjcjdNYPk=;
        b=BvqMlLgTHDAu8mElvAq08xZa3j+JWTAyVt6WruQzkBfeJ5gxW2Suej8fMWHf5DGUh1
         bL4oK+K9KqWKcgvIPtx5Z6YtbqYRt7qul1Jxf5Cn2Q4OQ1GJynjNC63S7HAHM0BPQuKT
         nJaZmv/GBi9xP7GPqbSXaec8icJ4YMYHwlO9X7VMJ1KEaOuLy9psNiQXBd4F4I4mdZXL
         bUbTjzU7x8XPYqmGJJ+ZbLyd9ysYf8iZj7Que23ZdcHwJY2tcx/Yu1IzR8VIU5Y+YxXv
         wbMRWuFBDS1d6Ex24jVgSG512OhAK2pIGXld7FFFcK366Xic+KWP0vR0e71wiKqOv9LN
         ke2Q==
X-Gm-Message-State: AOJu0YztQ785vKOAZlrRARyyMe3RPtOpuodTwDdumVMRGg2AIoKP3aU5
	gO879bGMXogupfhYGKYUJqIBMvjUTiSbfZVTSmpbtMDYN/kc+xuh76xl51BIyuNsuot1dEB/SGz
	/6fTflzBOYXw15eEL1h/G4bwjHECTJsalKA==
X-Gm-Gg: AR+sD10dNi0SImEOMLsGNmiSarJ4wHjBx27Ag2QWV+5eYGEpE5XkIwI1dAZfjXqkFED
	q4zsTBLeZqGEGCP2dOzj/ewMqnA2UeQ5cvtCUvgqsfNkeItLutIO4cVyxYW+sXqivRBgxG9/cVw
	iYEZMjElrY11ZREHO33oaGBZgXNhy8li5NO3Aoo2yLnVdoyUFPcyk0UZFZvJm9+Ib6Wa3nYXPY2
	Vn3IjGpCV3zoHDEbNd3Q/B93AcbwE3qQp8jbSRYlOnjCsHeveeyEqIwxKyDUwahyTXaahJ6AKyg
	rAcn0gF94OAl5UhrV0TLZ0mxqUNVuNWSgeYYX2bNEsXJ
X-Received: by 2002:a05:6871:2304:b0:456:ce37:7f7 with SMTP id
 586e51a60fabf-45e3e634d46mr5587016fac.4.1786549595605; Wed, 12 Aug 2026
 08:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812152836.11250-1-jwcart2@gmail.com> <CAEjxPJ43HEdfnOanWke_yZujwCynRs+q=2mRmG5+QVgf0CAu_A@mail.gmail.com>
In-Reply-To: <CAEjxPJ43HEdfnOanWke_yZujwCynRs+q=2mRmG5+QVgf0CAu_A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 12 Aug 2026 11:46:24 -0400
X-Gm-Features: AUfX_myKxm16Qd7u6ZgPdFD0lNVkBQ5E6iyGc9eEM_XEdntXHg3sb29J51ncgXY
Message-ID: <CAEjxPJ4SjdHaijtK60CW8Mk_qvfovUBRvpWWeOsKgzfNcQzdUQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Skip aliases when creating the type_attr_map
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 11:35=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Aug 12, 2026 at 11:28=E2=80=AFAM James Carter <jwcart2@gmail.com>=
 wrote:
> >
> > Aliases that have primary =3D=3D 0 share the same value as their
> > primary, so there is no need to process them when creating the
> > type_attr_map.
> >
> > Skip aliases with primary =3D=3D 0 when creating the type_attr_map.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
