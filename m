Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C6635837C
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542590; cv=pass; b=trJ8czp0BOveuGcgNelllhe7wJV5LRUKyKxdteQ6M2MhIuosFmsU9mR2tT42aMJg3tUlkD/yM/uHISyOCwMbpd4kFjc3ttpo7nnSl1UvFHTjuhZz54RfZln30YSmNrtc1ErOfbrTMttCy0L+ytox0EAaCpFXTtXGFXEwqGX+tsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542590; c=relaxed/simple;
	bh=P7N0oz82J9wnhzySJolDY3O0WeSqV7voSnxzovmbA8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OW0fpgnRywTj+wGn7MFinDQpu2+bUEYvF/Nj57UDdCk3ZIS5tAFOGVnYT++BUCtllDcxep0zNnEjLXUnpXdb9TLXPE4qVeppfMRnKjLjnJDAKl3PPKecaya6f71Tx2RbAh6Q3ZAZ1onu9KqnpMs68yapstq66S7aFHcm5pE3Rio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IubqjhVp; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IubqjhVp"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68e5f7c1131so6106309a12.2
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 09:56:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781542587; cv=none;
        d=google.com; s=arc-20240605;
        b=KR50YaSAHiDw67HHGxiUELSVmHCglaCfbA0PP4sbzliU7rwUy1otjz/3v/7yNaoONN
         OPuDgGXaFlBLsE6OPy+9A277Qc2/vt79mzO+klGXVwM0nrcYPdVk0NPVjJ+FmY0YuIYe
         7YCuFZCj8xXcsjDA6fFceC4LL8ZjRxza1vG4XiAf30oKZH8QmEABfEK4QYLnQXYB0WhM
         BDiIw4DPo8QO7f10VGQTEyezDKWg4lC+/tYlTEOyq3cj+P8plCBzDwVMksbY3u4l8I+6
         o1lYbrolalO3wgkHwEQA6ku2CGY1qVKIYGPn7TQ/nsEBCShBBuSYt6rkFn4V549UHAkb
         ghlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hAl9320zK9LX2OGMuhGty37U7VP333ExqZehJzblVL0=;
        fh=X5vnZCWuErBCX3HK8iUwBuHD6/CaNbIp7PYXEJ+WOF4=;
        b=YLxZuXYHvhgJaerwZTd9gSErpb0++NAKupuKBLFfz8uzjE+xwJ5MINNYZKma2HzffH
         iJeUJTJGx9hShKx7xFrMfmMO8oYEUFxDk5spY+0fkbiFmG9pCC/5z9QNnKxPbzX23zW1
         nuLk8aF6wPcgqFcFm2nkvvPhpUgFiBgNXqaZcQDMeGzYIR2VJf18v8MUp0DZ9KNEnqom
         sU3kGj8q57KJsEL4r7rGJEV4rU2AwMWne//IFE+nB4AMB7eVQu/AtLEx3bDCfQvlScYg
         zPbTK5w8OmoRpq5B6qZD6J4MciQPEYfkO2NkGS/u7tOpjwfUnMwrb54uS7My4RSniWXf
         g0KQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781542587; x=1782147387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAl9320zK9LX2OGMuhGty37U7VP333ExqZehJzblVL0=;
        b=IubqjhVpT5tLA5IFG5mtfMsIU28B8ppsBcGUgKNKnp7j/tCxEjOya2IOmrzK4s3FaS
         E/IDGgoJH2WRmyqTTdsRgfwUXF3TSau5ZNW9tASaeww7CcQPC6QGgSLWHWv4RftG0eZq
         z2A7dh3HEoAVMichBRgG3ccBTuW1tx0ajoC5A7AThmYrbxCniVDWjb5FzqRJvM/jIlm8
         wmKA2s0XSkXVlo1tvZAHDY/dKhwf0X84tOWFjJM6tK+5Tc0fN2tf0QaWpqWgE0GUnJwE
         mlSgMLTDGPyd3JN337z2eadBJUEe7RAQr+f10JFZWvrEmXTNbXYBlB3QSmqXmCPcxUXG
         JIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542587; x=1782147387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hAl9320zK9LX2OGMuhGty37U7VP333ExqZehJzblVL0=;
        b=jMbgFFW9LnJCGMaoZgnjfZ4+3IKMQHntJFynhCdbLH4HqDiQcLvdR75blPZEVWwx4z
         G8ObPpkxX6KxonnLyjfPPb9P++2l2YhM62748XXbNdOiY6exauMDQIOD3zYJDMOQ8HYj
         PM3BIbC6dDPlYMtrfByhfDJthsnpHwtZRgDSQoQ3R/1zMNwWroE+G224/hWdL063IP0X
         K7H3fyJB/7OU1Leozc4tXzaYjA9TtQOquV85JYdMj2yAITW907UXfzZ+SEPeqg61ar91
         pxG0KVKlxjFcewOwjIuDGaWuSm+1xUOROtqbTileIzacNJqLv1hurXtvaTn7/K399D6+
         ikXA==
X-Gm-Message-State: AOJu0Yy8sKOKiaV/SZirXJS4vVZ5Qx0cTygLkOl5PcwzxFPFRkHSm5wH
	WQf7poyjxJgYT0h1xhlYbqsH/S+xM+PEQwWmfJ4k4Nta+ez3M0XUnEn2EfW8KICooxwBPJGjaJJ
	ecDJ+z5DMEBF1K4gsjgSUgj8ll78vgqM=
X-Gm-Gg: Acq92OF9w4rZL7iiIJWhZXhKnJbL2k4DrXh2oCN6qeweMB54/5uU7esvF3U2vZ4pA6h
	vp9X19jVgBkZfbySCYDbBUqS6G+nW9R5PHFYPMPRrtmGn+nAcrT7cK+6Aai79b5IkMYKsCck5DE
	In0PV92hIzxzh+NG6LOgPj9fTbRBe9qt0hn9/wf8Xl5CMALbDv8tL1Z+gONm4zqCMoeJM9XtLS8
	L9mp/iPoMWjmj1JSOhjUfRuSn8HUcB5LMjVt5ROEUkycAKp4oeO0YVR6p+8fnaJevlKQA0vvErr
	BBB3rFv54KpUTeY=
X-Received: by 2002:a05:6402:40c9:b0:67c:6836:7b0a with SMTP id
 4fb4d7f45d1cf-69378a2f837mr7448648a12.23.1781542586883; Mon, 15 Jun 2026
 09:56:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615162018.44076-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260615162018.44076-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 15 Jun 2026 12:56:14 -0400
X-Gm-Features: AVVi8CdCwkLDMHUB13MvYrajWmcYatc9kHRnY5kDGwUublHPAYKj81Pw2mlxg_g
Message-ID: <CAP+JOzSqJ52oY8pMesogDumDTQzprijzbnCD-FhOL10mH=HXuA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: fix out-of-bounds typealias_lists access in module_to_cil
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	netliomax25-code <netliomax25@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 12:20=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: netliomax25-code <netliomax25@gmail.com>
>
> typealias_list_create() sizes typealias_lists from max_decl_id, but
> the loop only looks at block->branch_list (the first decl of each
> block), so the decl ids of else branches in optional blocks are never
> counted.
>
> typealiases_gather_map() then indexes typealias_lists with
> scope->decl_ids[len - 1]; for a type alias declared inside an
> optional's else branch that id is one of the uncounted ones, so both
> the read at typealias_lists[scope_id] and the list_init write run past
> the end of the array. Walking the full branch_list when computing
> max_decl_id sizes the array for every declaration id.
>
> Reproduced by converting a base module that declares a typealias in an
> optional else branch through sepol_module_package_to_cil(); placing
> the array end on a guard page makes the access fault, and the fault is
> gone after the change.
>
> Fixes: https://github.com/SELinuxProject/selinux/pull/526
> Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/module_to_cil.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 9e61754f..f3dd8f1e 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -377,9 +377,11 @@ static int typealias_list_create(struct policydb *pd=
b)
>         uint32_t rc =3D -1;
>
>         for (block =3D pdb->global; block !=3D NULL; block =3D block->nex=
t) {
> -               decl =3D block->branch_list;
> -               if (decl !=3D NULL && decl->decl_id > max_decl_id) {
> -                       max_decl_id =3D decl->decl_id;
> +               for (decl =3D block->branch_list; decl !=3D NULL;
> +                    decl =3D decl->next) {
> +                       if (decl->decl_id > max_decl_id) {
> +                               max_decl_id =3D decl->decl_id;
> +                       }
>                 }
>         }
>
> --
> 2.54.0
>
