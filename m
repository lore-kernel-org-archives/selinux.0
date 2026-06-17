Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C4735677B
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781719909; cv=pass; b=tT8qo4rVNgXRW7UPvi8vX235Ft5FDU41NeZOErCeSp/EEHYupWWYKBGVYDiZuxt36r7ilQ4Tgw0PwDyALcA3S9FY6ITDbH/fBdO0z5wGo0UPX6ckE07+a8wv8IOTczGqfEvTlZ4MvdNTQrhsK0VOsfayX4kuKMt/raQ4H+cuAn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781719909; c=relaxed/simple;
	bh=NlLCg03G22y6/qw2Wxx+jkqa95QLzhZq1F1RGBFqXHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wm5EzorrNrMUZneRmpdACOq6wWWYaEghoFYCHYJY2JFXpJbtnLK89MMZLJSFDrdC8xNIVq0k+og9SycOIBPagTnctLUTe38V924gh/Hb8fLxlzXA2ipBdD+h7hbcRum+wrjuKprVukq6LwkvzIosy+ghN9nMvb8OX87YvGOpjxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACg8PjBB; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACg8PjBB"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c6c101aeafso850535ad.0
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 11:11:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781719907; cv=none;
        d=google.com; s=arc-20240605;
        b=Y4N10ZMHJSg+ZtcA5vu/o4U0V9MkH8ogvlC2btVxipQGTCzRKyWGrcBttl/BpzUBOd
         iXFxRdVnuhnVurepu87WIMRr1BskbHgoBKZ1rnl7G1Cl28yiXOzr3wpSmLkJQT2NbCbj
         3nuigW299FRtEYD5NI72FkLEqgr0C7xK1Ju3izsucpj7x3gRxa3Sr9NGhzCxvU6q/1rE
         oBrjZgJdMrXlAWuRom7XW7D4U+fuPClthaM0Gvi4Y14z9eiNquSZOYeeSNvlM8R33y+E
         N+VFTUhfPgyDgf1JsDeGcsUHCaaWkVqiM+Hnk5aFHb5WELvULy6IMjRG3pCtydExXPr5
         IOBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QqmXupSw9ppi9zapCer9p6NIslgOn5deBrkycCLM/XI=;
        fh=+ymDRLpvH5V4NxzbU6EHTgZVOx8LXRvHxwaIgjsFoxU=;
        b=AFhSFP/DDwojpGlmD9ID5AEOdTpL8Rc4W4xTt6Etz8vJvwq9Q8153SiQ7kRL9XxoEJ
         +KcAgmbvM7WzN6MoQORNBE8yDkcyRKDi9yLHH/3K44QAhpC8vGTJ7cggq2OIuy1smkwd
         k8B40osfYKiVH4zQg1ax0H8V6kKB2yC6QJERD9aMTEtfsi3bIbj/UVeuahzdLEm1YotY
         iLIxp1q0o86Jsbn7FUl1oXdQgW5P2i//8SBiRKMeiBc0wsEcJvI0uKz4cLPZwsB9k0Mz
         YQsFFuh+OJg6xumLnwQ9d8+P3ZJ/MVWG2h8uiozPXa43EgPcHpWvXiRNNGOpoWb3fJgs
         XT8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781719907; x=1782324707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqmXupSw9ppi9zapCer9p6NIslgOn5deBrkycCLM/XI=;
        b=ACg8PjBB5B3WPknNjvNhEcgxNu7HZjniJS6AzARAmg/YvJTLyxdgMm637E6o+PS9um
         vQAnZqSeY6Zzjyz+u/nKJsTTSs1QHlKRIewFK99FFqyYuq0oGqiUbKsXUbBI4cRlDHma
         +3iJCaLYACOEesHdTK5cAc1VeuUyFp3s8IreiDjuOpuzxgBkn8sU79MAywChWJ4Ting8
         NiMyBtxsPTdm/B4wDX8Qdon7y0wr04YF1ZWXCZI1ZYlZQZbnLZLNdoZDI7BsoxcQGkKN
         oUA/IuK/z2kysMJhC81yiT8kXxcZSDOKS2es6uAOCi6SgS38LQKbDHhGAORxdonrBF2Z
         Qx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781719907; x=1782324707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QqmXupSw9ppi9zapCer9p6NIslgOn5deBrkycCLM/XI=;
        b=B2YNM8V3g61qAmBIWEH+9rtcCE2NaKHKmdl9K0sGzm14/5wY9jfV1BZEcrnFoY4Vf6
         +EgIRJFSyD6+Fwmdc9Y+6+jEonfeffbCS8bX80DS8dy5U9zfxP0buaZ9yo4oioauDWmR
         25rGmSDyB8uu0qahZqYTFYeS3XAoVfHRf/pfIanXQv4zjvz07R67ltKmSv7jRQxd5AIC
         q2Ab1u1oZR1rqctUNBnTxRYleVAl5TXR0ZfDoaiW5TF1I1WVsGg+XVFw/CWKisdJcQxW
         Xo6Zo/7v44Tys0ivx8mHt+w4gz5b2/33Q4cpMPih9HDp+gSGeFXfYCpjTRcHfJL2NaVr
         36sA==
X-Gm-Message-State: AOJu0Yyr1LIv8bJ2xve9E/DSLvjCSl4vRmript6foEmQsbdGnEP+Z9LH
	AO2K1cfkKuO1kjUZXlX/hn0kod3LR9qJw0imlbuseYs4x03/J7RicAUXNtBNGYlw4+UKLjvdKOe
	n4JLlRMDYej02EbEedQeCFW7m/CTNqLWHZw==
X-Gm-Gg: AfdE7cmRd7brU/NpRXnzMEINQfaRtdc+RRazUI6SdNJUhYpBpuby5RsOy2cUr4MLxpR
	PtcWA3liqS6pR9MJF09kU4Fw+pesM8f3vQYWECQjR3ubze/tvZiv1Goc18KCqowcOGrO8v6GinN
	sdC9bqhIkkzAqNtABz5qnzj/2vk3WJhY38we+YbF0NeqpS2ERhmGbtkMfQfOqLUwhtjGfzcBj24
	hrwPcQy8KUokZTzOj9VDre2uizwzTjUSNoQpkznaTdA8sY8RtNRX6rpGCINJ8sM2edcTnCL
X-Received: by 2002:a17:903:19e7:b0:2ae:450c:951e with SMTP id
 d9443c01a7336-2c6e527c54cmr1372905ad.17.1781719907321; Wed, 17 Jun 2026
 11:11:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617124609.65706-1-stephen.smalley.work@gmail.com> <CAEjxPJ4i3GzsjTLjjYyCaZ+MnNkCHZmm3vaLQL-cZMbUW487ag@mail.gmail.com>
In-Reply-To: <CAEjxPJ4i3GzsjTLjjYyCaZ+MnNkCHZmm3vaLQL-cZMbUW487ag@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 17 Jun 2026 14:11:36 -0400
X-Gm-Features: AVVi8Cdsjserueh34xZ7DpBC3E4I4iL8dW7I4iUClNcsVcO1sFygWAnnsHW0oBs
Message-ID: <CAEjxPJ49hcw1111y6BD2RmaS_BnOyiJcASuWLOcRQDEPwe0sUA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: bound category values in mls_semantic_level_expand
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	netliomax25-code <netliomax25@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 1:22=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jun 17, 2026 at 8:46=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > From: netliomax25-code <netliomax25@gmail.com>
> >
> > 1. mls_semantic_level_expand() checks the sensitivity against
> > p_levels.nprim but never bounds the per-category low/high values
> > against p_cats.nprim.
> >
> > 2. For a base module the user MLS range and default level are read in
> > semantic form with no bounds check, and policydb_read() expands them
> > through policydb_index_others() -> policydb_user_cache() before
> > policydb_validate() runs, so a crafted base policy with a category
> > value past the declared count reads p_cat_val_to_name[] out of bounds,
> > both in the "Category range is not valid" message and in the
> > p_cat_val_to_name[i] reference inside the loop.
> >
> > 3. Reject cat->high > p_cats.nprim and guard the error-message indices
> > with the same upper bound, matching the existing sensitivity check
> > just above.
> >
> > Confirmed under ASAN: a semantic level with a category low/high beyond
> > the declared category count reports a heap-buffer-overflow read in
> > mls_semantic_level_expand before the patch, and is rejected cleanly
> > with an error after it.
> >
> > Fixes: https://github.com/SELinuxProject/selinux/pull/528
> > Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

>
> > ---
> >  libsepol/src/expand.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> > index 7162f80a..0bd61c82 100644
> > --- a/libsepol/src/expand.c
> > +++ b/libsepol/src/expand.c
> > @@ -1128,11 +1128,13 @@ int mls_semantic_level_expand(mls_semantic_leve=
l_t *sl, mls_level_t *l,
> >                 return -1;
> >         }
> >         for (cat =3D sl->cat; cat; cat =3D cat->next) {
> > -               if (!cat->low || cat->low > cat->high) {
> > +               if (!cat->low || cat->low > cat->high ||
> > +                   cat->high > p->p_cats.nprim) {
> >                         ERR(h, "Category range is not valid %s.%s",
> > -                           cat->low > 0 ? p->p_cat_val_to_name[cat->lo=
w - 1] :
> > -                                          "Invalid",
> > -                           cat->high > 0 ?
> > +                           (cat->low && cat->low <=3D p->p_cats.nprim)=
 ?
> > +                                   p->p_cat_val_to_name[cat->low - 1] =
:
> > +                                   "Invalid",
> > +                           (cat->high && cat->high <=3D p->p_cats.npri=
m) ?
> >                                     p->p_cat_val_to_name[cat->high - 1]=
 :
> >                                     "Invalid");
> >                         return -1;
> > --
> > 2.54.0
> >
