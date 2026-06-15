Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD10399368
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781549256; cv=pass; b=PhL9nr4sMuV6cc3PvRlMMNrsJglwHEDY6dLTSBzFdJQpCanjDOtn6OYnXjMyUqeciWAd8y+YSg7SOljXbhKWPtKumVivQ+Me/Xzm5asG+z6vLlQ0jQFu+8kTtFxbsOT7HAFap+hwo7/O2XEMbpCA9KoEoAA5ytYSQoDvwDfjtKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781549256; c=relaxed/simple;
	bh=uF2A9q0dK0Fcvt5nNWEsvW9sTLubf5Y4owqLNpvqRNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZZ0kwxsF/kFb8E3vPeijbEtPS6B9jacZiN/Ii9cHFtVv2nXo7zubgXy6XmWgDBECgkifHEZ6Cgih0Bf7spL524Qrp1a5KNyu/aPKLqPgyGQQAOShkNJ8motEnoxn6AGDZ9T9Gd+GjcfibKBgzUu/5RAQ7DLCGC0YSwVxWpCmFlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geXf/3lV; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geXf/3lV"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36b8e1760ccso2385966a91.0
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 11:47:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781549254; cv=none;
        d=google.com; s=arc-20240605;
        b=Ec8PCevD/Af/m7gURhsWuXP059wmUFYJu3mR+0txzvrCqsjyywvvTa3z0WxpjGbk78
         dwR2VK733tQ+o+EuCvvYU4B0AV841n8k5fejd1uR/qRsMprCUVYeIJZnQ1k9ZGZdCkWD
         cfZrVLvfYxNEkfkQH5iFicqvbuLlA3udl0do2CF2tQ1OFmpOqr9kpw1szxo02nO6iL6M
         PhCb1e/5QUN89IqJI53jCxh5iipUY4hosRKYBzZO2xvkkz+e18EL4vXGTVQV783t9f6K
         o0HJczOeG9bdHqLSn33Ebh7NpTdPjBuErKZGU1QMOzd9ZRZOz4hr85sLa00wAFLGDaQX
         d03w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oo/LarC7gFOS8OAmDe95yhNfbe1300KO9GB4LGoLvIc=;
        fh=jRyevUK2w2AHXbqDg68JL/TGkgAfqiBixLBAah9ARNM=;
        b=WL/Qy41dE/5aHFKQXM7UR8Z3pyUXDCeEDesi2bpopfpzgoCK7ombA9R81CHks/p1FS
         TPB3gQ0ZhZDJvfbVxLXKl5ef7fIkGnnjJlX5wZUackmLxPa44GkzmIm/StR/RH05QH2q
         XRmfIKGdqjauGIS5Bf4K1zgeDIbhR7RhMhvMvsv1Raa/2gK46VUzK7IJH0hTyrFizoEG
         v/gpOiZjnrLrlL/UlYoCBQ/HCTDpvhjP9PL63jT7XuLnVA3jtJOdhnnUm4A2nqPwoOL/
         mNo5pLnY5xL+1vDuofjvwFKZMds71VAf0Ei3e9hg1kYatnYeWhpG4DJ3MqBq1RFvjt5d
         aHJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781549254; x=1782154054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oo/LarC7gFOS8OAmDe95yhNfbe1300KO9GB4LGoLvIc=;
        b=geXf/3lVK2dY5JTX88vBxWL5VikTChXKcF43atXS753vYHebKiv5shObgW6dOOmZvh
         Q/G3HXkS6qQQ+cU83U59CUvJCI7IzjZQHtL5uug0HfnvkU4b8frqbsHI0nFXLjquRvsI
         oiMYYsvKiHO+K34VhaScr4oofmLMKwHCq7LLMbIpoE+HbLMgD+lS8wOueOyRLGD0i6L1
         beAKcsungjzMD2z4D+H2dCd6NLekAeJj42Umm3W8g3Y04d4TAOQgqWrGlEaUlGbqPxZf
         KUl+1t+FNwimOPTDLCHQEDucF8/MhdxBvG5a6tmwLI/hUsoHpWPwpItTyfjmeQDscQfy
         FvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781549254; x=1782154054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oo/LarC7gFOS8OAmDe95yhNfbe1300KO9GB4LGoLvIc=;
        b=b1CJAXZlsV8QPS3U6GQJiuaiFeR1J/PoH9CZbZh5fIKQE9xnFYrmP//SHaHWtdDSlP
         vLz1mM91b3Y9q6WZWsO4naaNMXJqWZr7/9x6NYsoj3FS68oloKpFN9fMnAEKi6zPb4IG
         W2A6NLmafq3U0eceZ6RqPFSvNhTflKYUrMpQOWXOIh4QuinkvX2bkrqF6HM67aehbv0O
         tndIpfMKfc1P16ddwoiAm9flNIlq80R6fUKqRU3xLOvEVCQZXveXLnKv+aox78AzG11f
         2Ao5tyyYtDcIYO6XR1QeE/R+i3kCgr//XTkB2xnmnQX7vr+l9F/CZO4vvaVRoS+fLMsn
         1kPw==
X-Gm-Message-State: AOJu0Yz2af6Vg+Dcr9BtWZ3mD8/C976gfom9Icxr+FoLQYdqMjrn8NMA
	aM3AKFsFBM/YZcC2kOgL67YxmVXi00uCbnkLhTQWTdEoBFNkUUmLzNZzbLvNi+jfKaFfu9gWMhC
	vspRgh0ZMmF0plDF8pjnZLEyK2YhhJdQ=
X-Gm-Gg: Acq92OFBfce0aXWTyUm3HxQ1bQewVsISRoCqzhiW0w95yWAdOkyqsovpud3/i5AwB3X
	8kms6NOZp56DmkErLC9O7IPcgDDd507P+GPx06YqZBVSUwp9MkAXDUn5FZXLNOE3gwf9N3T+qHU
	rZTfOHdsUxc3zGUseUDg1sXCqg7IQUTmCkTmQ8JcJZCvpma3lTjN6djP9tblxeivuxoTiXKHxlT
	c09l448svFarMsjV6rVaEj5X9ZFiav3Jt3FMDgR4pagj+IT08Q6rA5jJxJYtFMfa0fBjHUdivWo
	Yqa80JE=
X-Received: by 2002:a17:90b:3c06:b0:368:83e6:ca95 with SMTP id
 98e67ed59e1d1-37c526ea2c9mr512788a91.0.1781549254196; Mon, 15 Jun 2026
 11:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615162018.44076-1-stephen.smalley.work@gmail.com> <CAP+JOzSqJ52oY8pMesogDumDTQzprijzbnCD-FhOL10mH=HXuA@mail.gmail.com>
In-Reply-To: <CAP+JOzSqJ52oY8pMesogDumDTQzprijzbnCD-FhOL10mH=HXuA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Jun 2026 14:47:22 -0400
X-Gm-Features: AVVi8Cesga04VWmyuT4h51wLqA2PuMRhYCoS7klQmVhw69Sf9YZfhEwLhjlPLr8
Message-ID: <CAEjxPJ5Rg=XK33r2mY1DWHz4mLbFQ21dwmQLV0PcTyafQ3rS-w@mail.gmail.com>
Subject: Re: [PATCH] libsepol: fix out-of-bounds typealias_lists access in module_to_cil
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	netliomax25-code <netliomax25@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 12:56=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Mon, Jun 15, 2026 at 12:20=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > From: netliomax25-code <netliomax25@gmail.com>
> >
> > typealias_list_create() sizes typealias_lists from max_decl_id, but
> > the loop only looks at block->branch_list (the first decl of each
> > block), so the decl ids of else branches in optional blocks are never
> > counted.
> >
> > typealiases_gather_map() then indexes typealias_lists with
> > scope->decl_ids[len - 1]; for a type alias declared inside an
> > optional's else branch that id is one of the uncounted ones, so both
> > the read at typealias_lists[scope_id] and the list_init write run past
> > the end of the array. Walking the full branch_list when computing
> > max_decl_id sizes the array for every declaration id.
> >
> > Reproduced by converting a base module that declares a typealias in an
> > optional else branch through sepol_module_package_to_cil(); placing
> > the array end on a guard page makes the access fault, and the fault is
> > gone after the change.
> >
> > Fixes: https://github.com/SELinuxProject/selinux/pull/526
> > Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks, merged.

>
> > ---
> >  libsepol/src/module_to_cil.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.=
c
> > index 9e61754f..f3dd8f1e 100644
> > --- a/libsepol/src/module_to_cil.c
> > +++ b/libsepol/src/module_to_cil.c
> > @@ -377,9 +377,11 @@ static int typealias_list_create(struct policydb *=
pdb)
> >         uint32_t rc =3D -1;
> >
> >         for (block =3D pdb->global; block !=3D NULL; block =3D block->n=
ext) {
> > -               decl =3D block->branch_list;
> > -               if (decl !=3D NULL && decl->decl_id > max_decl_id) {
> > -                       max_decl_id =3D decl->decl_id;
> > +               for (decl =3D block->branch_list; decl !=3D NULL;
> > +                    decl =3D decl->next) {
> > +                       if (decl->decl_id > max_decl_id) {
> > +                               max_decl_id =3D decl->decl_id;
> > +                       }
> >                 }
> >         }
> >
> > --
> > 2.54.0
> >
