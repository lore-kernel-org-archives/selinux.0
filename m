Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC6337CD3A
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225313; cv=pass; b=GFNkyghNYGK3bfNa5+mAFF1m0ui7bcshCNXwdQ8s4JV3W7rA0LMXsHak6wuPjKitl46QdtaO6GtljKp0bPe7yQMet3fn+MeK4f8BM0kZbmXCxFSLo/4LGtHt02I03dN9R7ZR6Gcpw8GrRaJjTxFkSvLNSaPiRcKNsViZNv6EBA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225313; c=relaxed/simple;
	bh=fK34ylrV8Xf/WwIizpzcgwQA8j85Jbg3i3euMVnj9Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eS+h2pTuPtuBhZb9y+XXCAGqYaYAaxEZARzDWOa/fx/Ei6UkefD2YyWsX5v2pyWQyCGGLy/HgNfYfRvr5CtqxkAjuo8e9rxBPJ3XtTb0Q3VjtZyjb32Ym0tkyVeinMAu0vj/aIzTLsnUD9u1XFmeAsOVZzZWiTeHnR9pyuY+04c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ws0nN21W; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ws0nN21W"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3997a6196c5so38447251fa.0
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 07:35:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782225310; cv=none;
        d=google.com; s=arc-20240605;
        b=aBkiXvk91M/pmzC+xlSC3Oqxt6GN/bfs37Sgz+A9X6c+XXuP8PBXDwb+rSkVIgVFzI
         +nHuDM3d30WzoZMBQW2IAxUj5TEhhOzvu/ENROhdfwW3MWwKrSWYebQjIrHMj2fe2XQF
         Z9yIkT6w7C1fLWmEVa5jWYjEyRpZmOxk1idlDmKV3ROVW8BNcZSlplNGO7CkmqJMEcmF
         PjsxG0xTzC4fFMjwZZwzWV9FTZkpU1IulrTKjd0iAIWieJQgTuczdfCDT0YCpW/ugbrt
         qajeAs15ToLFUA1Gmf9W0/4O5eQqKFVGaxdoxqeDq24os1l9GjkZ6EhtWAJ2A7YmsNZF
         aoiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=StWQW1FYXmtu6etAef8HmNb1vI5DDWPbyQByPg08w7Y=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=jiv29ifmLvPhBrqEG+GusoDvx+z5nzKghM7mxSNEQeLZsBHMAQXV8oX61+F5s66zje
         +bG8ZEevX8Qx56WdV7Xr470lLVQ0/l9Nqs5fH926hUdeJ8eMyACNOyfKQu0ieBfLQpyB
         t4xt9i9qFa8iPR47DCalU0k+hynHMa6GfKcV5zSr3eX9DdjlGwd3l2mZPwxjYTn4m7rT
         6Vn1OLnk6C2V3GJqz20CeNBdh22gvM5tLRzrS4sYt9u+B7RjJrFlZeRzdE7wuFBnRudB
         CSBhMdmvJNuvsJ9kK4gRto73QetwwAStU6k8hOCk6m6tHhAxybZROCxdJnBZ10AiBIcQ
         m4pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782225310; x=1782830110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StWQW1FYXmtu6etAef8HmNb1vI5DDWPbyQByPg08w7Y=;
        b=Ws0nN21We3qY9k0Jcf146YSavwv/LgrZoQrmttAiMHk50V42lkehLz6NNmrkpP8Hyl
         A6ZJVCvfHktUNlD0EeJtN+Xagz9bQtm5McC0sQ0eD0T+KWC7qvfbzbqMaPgKsAwyCyaO
         E+a3Mi34A+zQuth03sQBigL1wvYEJI+lzkFbG8EZGbgrVjDjidHphOTdp+fpi59c4DTP
         f/Tn12GTm4SN9sLe5obuKaf+gCH3RrzBuolrNGDWDgU3IIDQYaAygfyu4PeauaJNte7V
         Eqm9Pq2W/38dljDtU0Ahfh0VkSrj+H5EAQxQA1ugF4lO297d3jM63wqwDNabmkHPGD0G
         b/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782225310; x=1782830110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=StWQW1FYXmtu6etAef8HmNb1vI5DDWPbyQByPg08w7Y=;
        b=TgPDGMcn67ULIszhJBMcoetd6AuAlQk++LPU6YO20DrhsVWmaNX44ATy6fkZWEwTRI
         IoGPFQkrLZ/kbYu/X9enyrrfI3pVsGYFRaaQ5ZAc7YOlgjnkvyKQ/c5slSQCZhC6UKYt
         lv9Fs2OHsggJFVWaA3l+W5orBrWFGij7KsyB9oPvZbdwjCQmVu8hvFk/JCAMNOnR/cFE
         s6leu30hAsn+0VQA9vrGHVsFv36YBbcGJYr9PGRYiIiNP47tMsSeyJlm+p7fYwhtNsqn
         fQZrSVLBqJYq38koOvsg2t4mYDN28QRn8TJIWX6u92+m8pq+dZzh+KLJWVHGvpXycSLo
         pz8g==
X-Gm-Message-State: AOJu0YzIbsFs4l5GUzymYbe3o0jOZWR0FvVdDr27gWB5q8ImMYGpZz6h
	q92m+2odYfPCd5qdZanoA0kXBUtlolavRoRaBiOFJr6OE+f0aQ5AyaPBxGNnvwJuoXf23tAXCey
	FvNH+F8CTxLvR24kYrD0nvff2X7W3biEUNg==
X-Gm-Gg: AfdE7cn1l+ELWsuQKVBOSLme9gW9k4bnVytFVHPFV1yVjTcBBrNF3VVpKyXje5Ntpoi
	1OhMMJoiyNmHbrvkiAcksxI2u/BAc7gTtGb7VH+p3iWme9477xsRM7oShFNtCViXvgdLjS0lUVe
	rZHG3kUmPRgoYSxMIBKR5yxF0rNiozAOZdbCADH40YulPZ4u3cKcWW5CKEJr6NLStj861a3XiR/
	6TuqMHba/AKhrsq0WYSsNccqGu9dDcq2r2bof0tIFgUFWr6ZtRztkUojszwtoC1E7s4XfAV4VOo
	PD64
X-Received: by 2002:a05:651c:1602:b0:38e:e29c:9dc0 with SMTP id
 38308e7fff4ca-39a27e819d1mr8011201fa.20.1782225309550; Tue, 23 Jun 2026
 07:35:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622173541.174998-1-jwcart2@gmail.com> <20260622173541.174998-5-jwcart2@gmail.com>
 <CAEjxPJ5d5wXTg+KaFaX+MpUuTc0EZ48Ww+zpBKw35a2waGnQ8A@mail.gmail.com>
In-Reply-To: <CAEjxPJ5d5wXTg+KaFaX+MpUuTc0EZ48Ww+zpBKw35a2waGnQ8A@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 23 Jun 2026 10:34:56 -0400
X-Gm-Features: AVVi8CeT5d8qPB1VcNIcrY0kj30bqIyRN3Xkw41r8mSEuBnw5nubvKWeueNIugw
Message-ID: <CAP+JOzQU4VtveobDVsMhWK9dG2j9OUOZqYfFRoANbpqjQ-rMdQ@mail.gmail.com>
Subject: Re: [PATCH 5/6 v3] libsepol: Add overflow checks to strs_* family of functions
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 3:13=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jun 22, 2026 at 1:36=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > The strs_* family of functions provide convient functions for
>
> spelling
>
> > handling an array of strings which is used in kernel_to_conf and
> > kernel_to_cil. It uses the common idiom of "*=3D 2" to grow the
> > array without any checks for overflow. There is also the function
> > strs_add_at_index() which can cause multiple iterations of the
> > "*=3D 2" idiom.
> >
> > Use the __builtin_mul_overflow() function that will do the
> > multiplication while checking for overflow.
> >
> > In addition, the function strs_len_items() adds up the lengths
> > of all the strings in the array which can overflow.
> >
> > Use the __builtin_add_overflow() function that will do the addition
> > while checking for overflow.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> > v3: Previously in patch 0004
> >     Use __builtin_mul_overflow() family of functions
> >     Just check for overflow and don't set a maximum number of strings
> >     All check for addition overflow using __builtin_add_overflow()
> >
> >  libsepol/src/kernel_to_common.c | 20 ++++++++++++++++----
> >  libsepol/src/kernel_to_conf.c   | 10 +++++++++-
> >  2 files changed, 25 insertions(+), 5 deletions(-)
> >
> > diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_c=
ommon.c
> > index adb7b661..bcd13c9a 100644
> > --- a/libsepol/src/kernel_to_common.c
> > +++ b/libsepol/src/kernel_to_common.c
> > @@ -117,7 +117,10 @@ int strs_add(struct strs *strs, char *s)
> >         if (strs->num + 1 > strs->size) {
> >                 char **new;
> >                 size_t i =3D strs->size;
> > -               strs->size *=3D 2;
> > +               if (__builtin_mul_overflow(strs->size, 2, &strs->size))=
 {
> > +                       ERR(NULL, "Overflow");
> > +                       return -1;
> > +               }
>
> Don't think it matters currently but you update strs->size here before
> the reallocarray and therefore
> later error paths can return with inconsistent (size, list) pairs.
> Would be safer to compute the new
> size to a temporary and only update strs->size if the reallocarray() succ=
eeded.

Obviously, the only thing that should be done at this point is to exit
with an error, but I can't guarantee that all the callers are going to
do that, so the safe thing should be done.
Thanks,
Jim

>
> >                 new =3D reallocarray(strs->list, strs->size, sizeof(cha=
r *));
> >                 if (!new) {
> >                         ERR(NULL, "Out of memory");
> > @@ -173,7 +176,11 @@ int strs_add_at_index(struct strs *strs, char *s, =
size_t index)
> >                 char **new;
> >                 size_t i =3D strs->size;
> >                 while (index >=3D strs->size) {
> > -                       strs->size *=3D 2;
> > +                       if (__builtin_mul_overflow(strs->size, 2,
> > +                                                  &strs->size)) {
> > +                               ERR(NULL, "Overflow");
> > +                               return -1;
> > +                       }
>
> Same pattern here.
>
> >                 }
> >                 new =3D reallocarray(strs->list, strs->size, sizeof(cha=
r *));
> >                 if (!new) {
> > @@ -229,7 +236,9 @@ size_t strs_len_items(const struct strs *strs)
> >         for (i =3D 0; i < strs->num; i++) {
> >                 if (!strs->list[i])
> >                         continue;
> > -               len +=3D strlen(strs->list[i]);
> > +               if (__builtin_add_overflow(len, strlen(strs->list[i]), =
&len)) {
> > +                       return SIZE_MAX;
> > +               }
> >         }
> >
> >         return len;
> > @@ -248,7 +257,10 @@ char *strs_to_str(const struct strs *strs)
> >         }
> >
> >         /* strs->num added because either ' ' or '\0' follows each item=
 */
> > -       len =3D strs_len_items(strs) + strs->num;
> > +       if (__builtin_add_overflow(strs_len_items(strs), strs->num, &le=
n)) {
> > +               ERR(NULL, "Overflow");
> > +               goto exit;
> > +       }
> >         str =3D malloc(len);
> >         if (!str) {
> >                 ERR(NULL, "Out of memory");
> > diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_con=
f.c
> > index 3e6bcb33..9bfe5b38 100644
> > --- a/libsepol/src/kernel_to_conf.c
> > +++ b/libsepol/src/kernel_to_conf.c
> > @@ -1663,7 +1663,15 @@ static char *attr_strs_to_str(struct strs *strs)
> >         }
> >
> >         /* 2*strs->num - 1 because ", " follows all but last attr (foll=
owed by '\0') */
> > -       len =3D strs_len_items(strs) + 2 * strs->num - 1;
> > +       if (__builtin_mul_overflow(strs->num, 2, &len)) {
> > +               ERR(NULL, "Overflow");
> > +               goto exit;
> > +       }
> > +       len -=3D 1;
> > +       if (__builtin_add_overflow(len, strs_len_items(strs), &len)) {
> > +               ERR(NULL, "Overflow");
> > +               goto exit;
> > +       }
> >         str =3D malloc(len);
> >         if (!str) {
> >                 ERR(NULL, "Out of memory");
> > --
> > 2.54.0
> >
