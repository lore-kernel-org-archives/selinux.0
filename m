Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB26B154457
	for <selinux@vger.kernel.org>; Thu,  2 May 2024 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714673186; cv=none; b=JAI5oMsbd7xwsz6f5xZ9f2Ur1+LixCCytssJ0lrn5howK33ATiXMoQJLKY6YxC7Ixejrie2qfjMLRGqiRfM81jVxH2BEzkNY7vXdDP0x1YH4Vo01yQ3Xixohj2dLIUyLI0o6FOGRxTrDa22Kl1EmIdKIR5Xgv6K5TyDzfXULnBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714673186; c=relaxed/simple;
	bh=9vKjkX1yYi+ND0kP2cl3IAaeikZjDGdKw9HuzLQcwqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzJ6cggkhUDm115APcfSV9uqsnp40vdmu/nRCPzxYTR4NIvIJe0MGdrl6pjmG/nuIxhQsxHGaTtPlIVih9mQMT3b9bkrV99NDWk5OQTzzz8FL6+hV5kRbOQ+VwT6IpLlwVO7CQx39IwDpPYEcp682AA0jwzPxzJ27NflGYs4wLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNMVoirk; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNMVoirk"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-de477949644so9294163276.1
        for <selinux@vger.kernel.org>; Thu, 02 May 2024 11:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714673183; x=1715277983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xALQZIoIwd9ZTOcZya2LT7PCf/JYyhnjEJCrFgnwZHk=;
        b=ZNMVoirkjWWHCiOvkHi+sGtwRrqz/tX9H9781WYi/U3HSyPctZ+xvcGYwQGrYPgCTS
         bZiASCc/eO669WacR1dajcM5nbFn2HLh7mDEkISy9z216+W1I+D7plU9h35/eLrfO6hg
         CjEE28hsa+di7wm5iFlwOHUfT0k14d0JLXbNu7qVRe4LsHefAix1rxBzlGxHC7JMBbP2
         Pjb86CTGS75MSjHOaQOciWX7bZrTjZ6gjYZx/rDReQUoAP8LfFNBc22svjt3M4+QCYR9
         Fu+IvcBWvJ7qvSq6WMMQ+zmiIyZXVo87KWp8ynqqHzFtZfZbvushNinzxxAHuOmuzNgL
         boBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714673183; x=1715277983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xALQZIoIwd9ZTOcZya2LT7PCf/JYyhnjEJCrFgnwZHk=;
        b=SSrpstYsrKND/8jGBP5JlyEvOwJ96dwX/9GRuuRarKRXZToEHpAOBmqEOclAl70qK7
         yYqnTAAlMZrv46z+iOtFnTVmYMmI75xIGOKcyGhATiNEnw8d17r8im11S4PwgvFc3Djw
         veIUeb4Fb0n0BV0dCzJ/eJYtoU8DUmoNIc/e2Qu20YT/pb5HUBLN++daROTwzw9rXXq8
         45U+TEiuB4W1htZe5GnOBP27EXy4duJaEEVTRq9IUoIWeYa5L7fsmZoGk9d9rsDCrtyA
         k0X2ACn7+ClYAyKVyFN1xJgzPgeKAMDLw2D9++9mc9arRztHOMUM2vqXMomCgllnpByw
         xAog==
X-Gm-Message-State: AOJu0YwN5N0skdQVL+4YLBisA8Ji5C6oLPDItVgXqH+KM4hjrK2JDdzO
	rJzUHFl12bhbdsIQMO4BPs+xTuNLo4fo6WPFET57IK9objOOD9oaopq18FfqX8Dg5f08bvDCnHo
	uboiefmQgym2I2Jr+ZCz/VN2SciV9EA==
X-Google-Smtp-Source: AGHT+IHwC0cCmBc0j0XtZ230hX+ufslkiHggZqVJye9cq0e/Wd1BMtEuBFgHGY888kmRllSPkFPMReW2at1P05ts2Zg=
X-Received: by 2002:a25:ae91:0:b0:dcd:a9ad:7d67 with SMTP id
 b17-20020a25ae91000000b00dcda9ad7d67mr715677ybj.8.1714673183195; Thu, 02 May
 2024 11:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430153024.790044-1-vmojzis@redhat.com> <CAP+JOzQ01q=P2W6WX5Edp1sO8yxB30uSTSJrgF+k=mQiggnzCg@mail.gmail.com>
In-Reply-To: <CAP+JOzQ01q=P2W6WX5Edp1sO8yxB30uSTSJrgF+k=mQiggnzCg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 2 May 2024 14:06:12 -0400
Message-ID: <CAP+JOzR-+j1u8+yYn7HzvX6NJHy-vncLVxvBubdGQ87iSFq0rw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Fix detected RESOURCE_LEAK (CWE-772)
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 1:31=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Tue, Apr 30, 2024 at 11:34=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> =
wrote:
> >
> > libsepol-3.6/cil/src/cil_binary.c:902: alloc_fn: Storage is returned fr=
om allocation function "cil_malloc".
> > libsepol-3.6/cil/src/cil_binary.c:902: var_assign: Assigning: "mls_leve=
l" =3D storage returned from "cil_malloc(24UL)".
> > libsepol-3.6/cil/src/cil_binary.c:903: noescape: Resource "mls_level" i=
s not freed or pointed-to in "mls_level_init".
> > libsepol-3.6/cil/src/cil_binary.c:905: noescape: Resource "mls_level" i=
s not freed or pointed-to in "mls_level_cpy".
> > libsepol-3.6/cil/src/cil_binary.c:919: leaked_storage: Variable "mls_le=
vel" going out of scope leaks the storage it points to.
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/cil/src/cil_binary.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binar=
y.c
> > index 95bd18ba..c8144a5a 100644
> > --- a/libsepol/cil/src/cil_binary.c
> > +++ b/libsepol/cil/src/cil_binary.c
> > @@ -904,6 +904,7 @@ static int cil_sensalias_to_policydb(policydb_t *pd=
b, struct cil_alias *cil_alia
> >
> >         rc =3D mls_level_cpy(mls_level, sepol_level->level);
> >         if (rc !=3D SEPOL_OK) {
> > +               free(mls_level);
> >                 goto exit;
> >         }
> >         sepol_alias->level =3D mls_level;
> > --
> > 2.43.0
> >
> >
