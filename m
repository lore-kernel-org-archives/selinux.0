Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBA31A9F8D
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291959; cv=pass; b=j6/kXIt2bHoxkLMYyrYXAKrN4zuH9nOCf62SRiz4/BiecJxrfu1ZuIKhJqekVroR5whBEpWjxFHAF33iLfj1SundCl9IcBc6sZ9dSNv1WVvI/loBJ49co2rYIseB96k7ZIhIAlFlGOhQcGDTUBUioP3kVt5bQtuKMgKVqd/C4PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291959; c=relaxed/simple;
	bh=m3dVDM+iQVjsilKB1/q8/Re2y/3ErRKodPwT0VIFEJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvnzkJb0O60DTDHAe5aEMudaiIbexGO1S6uqTHCq5SkY1Xm+1+Fj+aNM/TMCWen2QsG8aqh3gAkX4otsh8m+0LkbT+6rDlhA3xXR0B9sXNbh0r4f8lmprWPJti++oc2pVKScDX/iTicr7zqNo2B948A1Bm0Rse5Ncfv9NOS6+G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsK1cbF2; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsK1cbF2"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c80167f5716so2224479a12.2
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 08:45:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779291957; cv=none;
        d=google.com; s=arc-20240605;
        b=ix23eVIQftE3cFbIzBk7mDY9HrhJzwYrzkYVJHa0Ddw3vpjzNFt38LXYqCwrGwiiHv
         nf06M/sy78o6UFG9Jn7dHu9wDTareMRp+SdWxL2tv0BJXgIK4hK9ZALUhd0qc9cJRg6m
         lW1/9bDlzcBDXHGfLATFbaTQe1LNm9WxBi1ToRQ5ebbBoozAUzQk1xQX7hY3pW0bkimd
         vw5nvDrp/H5CRjbb806irhz8hT9SGEgHH/1RuxLvR9kbVis7KcjQLLn1EkaXC8PwMCcb
         9icytWjkZR5+jrzOowaqHCaKawxUtAXJYQ7s9Jy8ZGx8yA8edrI/iX1lFiMLTA4DDv/o
         mf4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FhxMUhNeTeYrIR1tE47tziPh9Go9gzxw2NwbfWDi9Kg=;
        fh=K0P3yueWX+9wvznQ61j7DXol8naVFvlsq/Ek+LAYujo=;
        b=QILyy4BheXogmny1SOCglPUGborEZbCHyEZXLf1mlV2oqbQRpgYrOz7qzZU6Mda6gp
         Xo6cpPhLJbDLSJFGmlXonPnrtMgBmG9FpIOSuETLHHobWZYg2K9xtS9x2Rkyr42HO6po
         M8YiK2QmT3VfY7HZsqiEydXxyA3//2QGgXuh322/wGSuQYBUvw11jeKlz0WPRVJNX4d3
         pmuDxEnwgDXxudOVw7mBvfzB43DwvHtiDpr9tJpVt/rXwDta5CEkmsi1Qjxr9QCnnqJ+
         1TGWH4EyJQR7ZdlBlWo7qbCBGtUb5ANBOdW9SO4dAL2U0NcegO9N1Cpq8D5tjDtw4OuZ
         fBSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779291957; x=1779896757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhxMUhNeTeYrIR1tE47tziPh9Go9gzxw2NwbfWDi9Kg=;
        b=RsK1cbF2R5+KZzf5dZxbOpt2ELivq10WPpjQbTP+xhbEIXTjOXXVPEs8w0e1c+NWvE
         TeGs/Kgygi+YKIbai1p3iqa4tEn6S21m6kUVx5DgHQO03Mk1YKEGUK7sEOCDnulnA/+E
         GEzPd40HswC5C8h4LdrM4Q4peH4zaHb/6EsNrl28KSlamAeDyvk4WKYSi96+zJNth67y
         00CDBMwAv99ns4WqqDiBllRiGJbnB/kFvBBGZ0WlVULr0Uc473HhDFP1ySoKw80AXjSC
         VHeyi3KsIkqqevdxLcWRoZqs/eV5cbelmhQcBXz4+ji0Joyjwm8OIllVOzWGNJ6D7RWQ
         vd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779291957; x=1779896757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FhxMUhNeTeYrIR1tE47tziPh9Go9gzxw2NwbfWDi9Kg=;
        b=QgAYTRMpgl8AWUrTQKBjcspyM/YRjLVsS1IsMVU0l3qfpjV8konzOCIx0jjluSnS+l
         ik2NTiIzhhvv2AQfqkSyJ4Zho7YIxwjJCdNA6NiWQgO2iyxFHFrvXKX1Is41t3ck5/6G
         0VqAXTH1irIVRoOIRWMY482bpg3KnicFjYfrAi06PAaaAJwTAmL68YGr47drsGIhzU2g
         Y9QLgYPfz5yLCVq1rM82apcYryU6G0HbyY91Ws0JbUkm3SZlLdlvdnu+WNd1y8xXFRoG
         M+9agYPxb2KZSFlys+O+tpbqG/qpxDjYLT1EVsgz2jmu8LU+e3v6YBHaQH8h653ZPx82
         dL+w==
X-Gm-Message-State: AOJu0YwxZ8rKTP4lYeJMpItijHeCP9ODqBA216Jeu/TnXmIHl2HKMAXy
	xYt9ce/q7rBaC4jmhAIyLWi4XynuJhRPcd3/wLLtUuFRcBXr66ZF/7AooBZ4AoR6UHMzkz95OSi
	8hPedpTSMB55YjnkAHFEffNVmYcEMNr3/+A==
X-Gm-Gg: Acq92OFigyg88JTVD4OA8aXZYu+wMN2WqjKiTAdWJ7OTSXeUDLWl/A3EbpFYfx62Kpa
	Y2/LxwQOIqmwMR9G442OhwaaM2KjBjVDbTH0L6fUdowdBCUK3Uet8489ybUi+K4i0xAXIRq4CAF
	4HUicW1XXzCLhO0/JOaQ7ZGP2ZbRE+vspVyc+XZ1YNIHFShVa/R3nyWjKDnDfaBiDfvME5q8A1e
	20VXPBw0hyKbgcLFu1y7lXHRZQTMUBVg0BshTHbmCC0q+yn7zS84E0mH4+R1bhhFsYu+eFSX0Ti
	QbfEVIep100bKXFqwA==
X-Received: by 2002:a17:902:a618:b0:2bd:5026:ca11 with SMTP id
 d9443c01a7336-2bd7e782af5mr195395985ad.2.1779291957215; Wed, 20 May 2026
 08:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507161633.15947-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260507161633.15947-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 20 May 2026 11:45:44 -0400
X-Gm-Features: AVHnY4KI3nBRpVbS_BLvOH_36VDpM09NHzEn3C-0YKLMDvZcmnkMO9rCrrUuY_U
Message-ID: <CAEjxPJ7ynbRQ0OAwFUj7RGH17WBpC9Ekwhkadu=wfq13XjAicw@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: tighten type validation during policy load
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 12:18=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Tighten type validation during policy load to improve robustness in
> the face of ill-formed policies.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Ping.

> ---
> v3 removes a spurious empty line leftover from one of the changes
> dropped due to Christian's patches and adds the word "type" to the
> error message for clarity.
>
>  security/selinux/ss/policydb.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index ead504a639e3..ba1c9bd9e29f 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -604,10 +604,15 @@ static int type_index(void *key, void *datum, void =
*datap)
>         typdatum =3D datum;
>         p =3D datap;
>
> +       if (!typdatum->value || typdatum->value > p->p_types.nprim ||
> +               typdatum->bounds > p->p_types.nprim) {
> +               pr_err("SELinux: type %s had value %u bounds %u nprim %u\=
n",
> +                       (char *)key, typdatum->value, typdatum->bounds,
> +                       p->p_types.nprim);
> +               return -EINVAL;
> +       }
> +
>         if (typdatum->primary) {
> -               if (!typdatum->value || typdatum->value > p->p_types.npri=
m ||
> -                   typdatum->bounds > p->p_types.nprim)
> -                       return -EINVAL;
>                 p->sym_val_to_name[SYM_TYPES][typdatum->value - 1] =3D ke=
y;
>                 p->type_val_to_struct[typdatum->value - 1] =3D typdatum;
>         }
> --
> 2.54.0
>
