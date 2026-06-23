Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52662307AF0
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229764; cv=pass; b=jBlEizJCl57GVApy1lPh1V3NBjABQh//9hOBQ18EgIqDMCckD5NyOyUFOlhEjYLS/1Zb++wCoVwd2nZ1uf4T8OP5is27qkFMeZsmf/wAkQydsDCJEeUZwq+qT4jIrxon0J/Dw0fDl9EO3hoNkaOsvFO9ZDv83DyFSwyqS4tHCiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229764; c=relaxed/simple;
	bh=scQJoTALFUEjK/ufWA2VXN7hj5ZyAtCd0gwJK8045dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W533osbaH4HvMjOETv8VOk2ozbfyB1BWOlm9kpPTXi1QooZ9uL9eclz5hB9nQi64MmzXVd43BN3jIQTBHvrxtyd9J5yPMqMbj0qxWdamPWgdU2Wd+Z6arBE+6gjtKlG2kZpUPDn8kfZ+IV5OxjdPsg1vCpXRkgUecKlHquSFvgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQVjLeoX; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQVjLeoX"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so41339475ad.2
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 08:49:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782229763; cv=none;
        d=google.com; s=arc-20240605;
        b=aftyZ/D/WYn5H6zKWtalS34ghu4yc5aLGC7cbhJ+HkFBsbZFfPuH0BBB+Gq957JaN6
         EV6/1Vmsdt0jhgwEJ4uKvCht79ineKTE3BCH1nkyDUSJInHDR0PELMWan9nQf1c6amNg
         1QjDIzaxnWVCg1VGIKvA9eT6LHkxuuHIljDtRQ1DePZZPqM0UFxuZs4II+ySY8Z7lySB
         Gc8BuwOsiQhxITFN7rPvG0OzYYEyXwyfnr8ytAFTWVkD30z3NwinWuEeUUG2r8pSUMjK
         bi8EGAwpCnhQuZIHo8JnLA/XzPeIwc7E+4tqSitynZ+YLNxgN7T8jAiflccpbFXKxfsA
         FoLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8oixMdLU6WxbLD/v57PWFoUpAMgVTacv8RXiZWTCoqM=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=VFZckuqlzdC1iuh4vcxwm6yFj6xRpxKb2Je47E9ZKXEbT5zyKCpzjGlUYtaZuITFo6
         b3Br49X/3DakBV9x9Fpm1HZZVMe/fQt2zLMbRYbQDZVZRzGifv+Lwaj7WVxX6MrPY/5n
         8amilwYc8p56C2Mss9tk7iRY90fFnBxbJsFuEmehGGxZrrbFv2b+0Ieqdkvyo/MuxpEs
         XsUGbkuYD4NpL6CNcfRo2ite8+w1r5mF5bptZ3JuvB009OHtCvjLPYTLE39eBuf1JKcs
         E7AP4veEIwtOduH/zQzc+OTJfm8/OGkA5qFPU5h1aWyLFnCMwQ3/AQkAyDfEcgCQYaQf
         xTBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782229763; x=1782834563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oixMdLU6WxbLD/v57PWFoUpAMgVTacv8RXiZWTCoqM=;
        b=PQVjLeoXqmb9NBjLhb8e5blIdR7maeap3fLB+Z/zvCLKdm6pzVTj9KL1m6WYh47CtV
         a0RzPjHn6qwOgnpQ5+J1GxVM2pR+d2eiqmU4WmD4MtmvLteuJ10Lz1DA/uMLjaxT3rtv
         LrVNe1TLFS37iAQ2DfRS0Les168k7aKEPU0Pr1bO3Hk2pNZZWpMY7NNp2cnOYqoitYeD
         TynrWtBOh8mbiqCZ8i3tgxtJnDKbc34Soyw/14OVHkvqMQ6j7yuyNQ+d0qXsJ+9Fb0HM
         lKtACjg1QKIF5KchqNOikbw4vg/wKnR7gfOzbbHRi2KlX/NifACXwksrwhO4oCi6ta+9
         kt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782229763; x=1782834563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8oixMdLU6WxbLD/v57PWFoUpAMgVTacv8RXiZWTCoqM=;
        b=TXvDB8pNn2mIyfVg5G+wpwaRyQJAjoMTd+tZJ8v6ncsQ6g64euhHbSm45+KhpZMPAn
         GWN1xg7HadhShg7xmJwVcbwUqP1NqNqYj7HHhuctSvEYi9Pe717mo+WeRiTy76VN+6M0
         eCE8YWICFPZIDp38ANDcR/INUZjmVN9VKzxgtuNlBijbpU3xGAwolWrtM+XHVCKlvxdp
         2/RMcfciV/D01LCX21o1FndE3bftHX08o+9uekDfvc7LL/3Df2DskBwPNwMrPAuPjF+M
         kMIvdQXZ5mmwsAhZtVeIpElTNRbCIuV251vzSUy/JIJcH78iQrgD3ye1wBU07lTrYqvS
         eAQA==
X-Gm-Message-State: AOJu0Yxn1b+8SkE8vmIU/6EL5laErhR1By9piSGLbFTvJY3IWREi5daH
	aA5dBH/elw6DjAJAD+nthXUex7uP+EPcuxgIVH4uFRWIlcsWqMlQUxpY5mXW4gZzszeGNNN36Xt
	N0Sg+GcltJtnt/dGT5rKjskPisNw0elJgBTKJ
X-Gm-Gg: AfdE7cl2xG0DQPmaPVQUkQW8LSdMm7GmDF3+ISvA0erV+kWyHTmrrERohJErHGJAJ4q
	5LLDRC0zGD34SrOklUDd24u0nVEKDdyuhbLAcgUfohvrleYHo3RlLITOKrElMLV54Kr8fJQjsI6
	GFzcbWj1MWJmQZ+S+p44oq8SoYEXc50GA/gcc59GeZgmnJJWA1wI93ZAoPEbHbRaaov/Aa0eKn4
	BebqF7GBwFy70nMnctAdAWVXBQqIViDu733XhqNdCvC6YchKooOEujRctbrhdfqb4km6QH9m1sg
	t0A9TT8=
X-Received: by 2002:a17:903:4b27:b0:2c6:e146:79ac with SMTP id
 d9443c01a7336-2c7c7592b72mr36477305ad.7.1782229762524; Tue, 23 Jun 2026
 08:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623134215.98273-1-cgoettsche@seltendoof.de> <20260623134215.98273-23-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-23-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 11:49:10 -0400
X-Gm-Features: AVVi8Cf4N8VA27mUEWStmUUPmvwD8aXPaClW7upvyPpy9FaCM_k0IJ4zVrhxENA
Message-ID: <CAEjxPJ6trSq3Pwp-TGrjDOUSXHYbiQrPmi5wXTKQ68LL-0Zvhg@mail.gmail.com>
Subject: Re: [PATCH 24/24] libselinux/audit2why: fix double-free and harden
 boolean handling
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:44=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> On the sepol_compute_av_reason() error path check_booleans() freed
> `boolean` inline and then again in the post-loop cleanup, since the
> break left it non-NULL: a double-free. Drop the inline free and let
> the post-loop cleanup own it, matching the other break paths.
>
> Also harden the surrounding code: bound load_booleans() against the
> array sized by sepol_bool_count() (passed via the iterator arg),
> check the strdup() of result boolean names, and avoid calloc(0) on a
> policy with no booleans (which could spuriously raise MemoryError).
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/audit2why.c | 40 +++++++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 11 deletions(-)
>
> diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
> index 5dc94302..0552f690 100644
> --- a/libselinux/src/audit2why.c
> +++ b/libselinux/src/audit2why.c
> @@ -46,11 +46,16 @@ static struct avc_t *avc =3D NULL;
>
>  static sidtab_t sidtab;
>
> -static int load_booleans(const sepol_bool_t *boolean,
> -                        void *arg __attribute__((__unused__)))
> +static int load_booleans(const sepol_bool_t *boolean, void *arg)
>  {
> -       struct boolean_t *b =3D malloc(sizeof(struct boolean_t));
> +       const unsigned int *boolmax =3D arg;
> +       struct boolean_t *b;
> +
> +       /* Guard against writing past the array sized by sepol_bool_count=
(). */
> +       if ((unsigned int)boolcnt >=3D *boolmax)
> +               return -1;
>
> +       b =3D malloc(sizeof(struct boolean_t));
>         if (!b)
>                 return -1;
>         b->name =3D strdup(sepol_bool_get_name(boolean));
> @@ -73,7 +78,12 @@ static int check_booleans(struct boolean_t **bools)
>         sepol_bool_key_t *key =3D NULL;
>         sepol_bool_t *boolean =3D NULL;
>         int fcnt =3D 0;
> -       int *foundlist =3D calloc(boolcnt, sizeof(int));
> +       int *foundlist;
> +
> +       if (boolcnt =3D=3D 0)
> +               return 0;
> +
> +       foundlist =3D calloc(boolcnt, sizeof(int));
>         if (!foundlist) {
>                 PyErr_SetString(PyExc_MemoryError, "Out of memory\n");
>                 return fcnt;
> @@ -116,7 +126,7 @@ static int check_booleans(struct boolean_t **bools)
>                                 "Error during access vector computation, =
skipping...");
>                         PyErr_SetString(PyExc_RuntimeError, errormsg);
>
> -                       sepol_bool_free(boolean);
> +                       /* boolean is freed by the post-loop cleanup */
>                         break;
>                 } else {
>                         if (!reason) {
> @@ -158,6 +168,11 @@ static int check_booleans(struct boolean_t **bools)
>                 for (i =3D 0; i < fcnt; i++) {
>                         int ctr =3D foundlist[i];
>                         b[i].name =3D strdup(boollist[ctr]->name);
> +                       if (!b[i].name) {
> +                               PyErr_SetString(PyExc_MemoryError,
> +                                               "Out of memory\n");
> +                               break;
> +                       }
>                         b[i].active =3D !boollist[ctr]->active;
>                 }
>         }
> @@ -274,13 +289,16 @@ static int __policy_init(const char *init_path)
>                 goto err;
>         }
>
> -       boollist =3D calloc(cnt, sizeof(*boollist));
> -       if (!boollist) {
> -               PyErr_SetString(PyExc_MemoryError, "Out of memory\n");
> -               goto err;
> -       }
> +       if (cnt > 0) {
> +               boollist =3D calloc(cnt, sizeof(*boollist));
> +               if (!boollist) {
> +                       PyErr_SetString(PyExc_MemoryError, "Out of memory=
\n");
> +                       goto err;
> +               }
>
> -       sepol_bool_iterate(avc->handle, avc->policydb, load_booleans, NUL=
L);
> +               sepol_bool_iterate(avc->handle, avc->policydb, load_boole=
ans,
> +                                  &cnt);
> +       }
>
>         /* Initialize the sidtab for subsequent use by sepol_context_to_s=
id
>            and sepol_compute_av_reason. */
> --
> 2.53.0
>
>
