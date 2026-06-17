Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FA31ACED5
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716974; cv=pass; b=sGnywHYKRsFFH6OeXNCrbYLixD9ySlB08cukl9JltiK5c3TbHAmb/eD/94DG72AhhSGUqLykW8H+8HVzTNGAYAh6VKp2US6x5Dla8ZYx8qY7hN7QBdzMKPdgDnYzHB/Cp6kkljWo3TLwy8zJ6gUKV7Ui1eGwJYiqWjvYUiFrAI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716974; c=relaxed/simple;
	bh=GLiDtSelC+sje3XD6Uo36c0zlTHec6wjTtvTsz9NcWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euFaYdD44A3eEojCVRrSm5p82jRpkrGrRpGF6E2eJ5hJoVGcZeBMY+uPXQ/Q025QKhGkFaY8V6hibmJ2zNohq4rq0hcHTZgU8T9XyNOZ78lihOGbkw7XO47T2Bbq032PjWufqFL1zquWgISWboj+6nT/DfX7D8PTrCYGldBor8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTf6zkS9; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTf6zkS9"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-37cae998401so488572a91.0
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 10:22:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781716973; cv=none;
        d=google.com; s=arc-20240605;
        b=ZZ6j4IaJJHYmNsmxD80nSnywqUkyyA39I2iAdzvrNl+oL3UsxScBQGDGWTHojmXoQ5
         Sozao1NlaImlfAfVjiMvdyBJsQQ91e+zW7PUUMrvswuyj6SZRVig0CacHgl3x6PhHB8K
         6iSFl655RbDCU/L1Ifgwxi9vLmf6YteBe8NB83fNh0YMhv/zK+I7WSxrDbNBaVeCO2w4
         B+mLs8tmJMDuQUrPO60ijaOAbIthlvd+YD0KQsJ+qlBT8TAHLR1VQH12GgRJhqRfsYMD
         qonYNnA0mvpc/tDnl0sLljpPAX3PKZ40wUSREAls0/J3Qb8LJmuJyKFTA2FcWXLfLM6i
         57ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RUy1g6kX/8IXu5iEUzrzqtnUFkJIews7vGRqlDKe6ms=;
        fh=+ymDRLpvH5V4NxzbU6EHTgZVOx8LXRvHxwaIgjsFoxU=;
        b=bGZSHVrngWQNdLl+0WhYMnNgU8o6LHgVRVq/yZ18QHsXbu24xTUF84b1n2nA91LDFV
         eJps6fqi5jh6l0/EOAUjFk8Z0xA73IEv0dLA/7kegjaemmQAG2lnal30ngBaZKlW/P0v
         +s4iEM/ZrthBzpq5vGXAvsbnxhrakwIx4ZGAJULdV6jzrs6DyQ3Fu7JRP/wahy3deDot
         fz4O1XCvTTvZtd9xR8q16Drz82JAexlbxzbEfbqyUdc+K8I8RC4BDPohEowzeAIZ/P6i
         9Xap2IikG7u84NjGGoanijFOh9/Blsug9rzLf0hJWck9ecBL3L0Jy/5AJsHAgRYhSYwC
         yUPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781716973; x=1782321773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUy1g6kX/8IXu5iEUzrzqtnUFkJIews7vGRqlDKe6ms=;
        b=eTf6zkS99Cglfl13DnTWbZShFHbGYk8pJ0ChY6y9zEhxu5ts+GklYHMU8jM50NI5e3
         UiWOsVShwOMgYcninJprlvo0gj1FU4+dYJMjAlAvC79UeZFtRpoTfalvEACXy0NeicI3
         pvta2tdaHiXPexMs2PkLx5CT02fL3nQS1xTq+cbDnIhm931pbV8/C++wWlqMafYmkXWq
         FznpRWCEftFEbnneP549Y8XTfEfyBkLHORiI4mNuQwtRL63fOp3fKCYs0r0G73yXWxIy
         3t8rLV4hG8VY2f8F6nqqll+3wcSlvVMmQ4EUsswfLnKGvlKqFyxtAoibE2v5rQwYUSmW
         dSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781716973; x=1782321773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RUy1g6kX/8IXu5iEUzrzqtnUFkJIews7vGRqlDKe6ms=;
        b=pqeZQPoMUCmcrJd6Owx4QHJXmp8P5BTM7YwDyVH6nIzM+uOudyd0TvN7xLOlfEGmWn
         Z/HLjEXprDqjbqOpRfcqDw+ahvl/DlSIQhpOTTG6eiSgO5z1mLMm+l38IQ+2ckjjt5qM
         R7rSRpc/AY9NZ3Eed6MtrfGnHfOmXZRkI4FI75EcArwevUt8hKSJyb86+/qYNY/kb/6o
         sNeZH1S7DqanBcret5lPlZtJYqkNXZ+/41EIcGi/AMc8TbwkscwygSdCiStl7IsRrCXx
         0orDhzo0zcO0lpG4KUWkAY+p6mefItBsKQv8x0gHtrBXI3FniOz3cEmellcFJ/l3UVZU
         91HA==
X-Gm-Message-State: AOJu0YykhO7nEkscoPvetzREnkSjMzSqNvr4pqi9O8W5K5xgWks9Pwrx
	lBNSn+0lY5isKMGOquZ6W8hLOHwO5zg9Vl5o30deBQBU6+e8Qf2/jhaswIDzud9tf6Z9/7fPUkl
	Dm4pyxLivKJpkuWGTL6KzoVD21uzWuIay2w==
X-Gm-Gg: AfdE7ckd6YH+mpcfXW9rBGccaFjUnO8bf6ifjB5RX9y8lziTEg9/gmkUUP8vmjWI6sx
	gTQia2Ru9sNONG+WFvkz3H6G/adLXGDuH6D/GluKJ3p+P+UKpD2/6cvHgPJYkdkglOH5Vu+k5pw
	63I7JBz6oKrtacISLQ0058zaaBMczwnjwHjVoxWovZzqjgutqU2in6wfHHR5oPOpkVt9Y/YbwOO
	XQMciiHeFspn/3JqxUfF5YqbEvXCTueoJUmZtjo1/LvlF8BHy59s5SV6KeIRJc76bwDZd8E
X-Received: by 2002:a17:90a:c110:b0:37c:9bad:f6b7 with SMTP id
 98e67ed59e1d1-37c9bae0c7dmr5083631a91.11.1781716973086; Wed, 17 Jun 2026
 10:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617124609.65706-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260617124609.65706-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 17 Jun 2026 13:22:41 -0400
X-Gm-Features: AVVi8Cc8dyR5JlBfHKwN7N0daKsnOOvQVmMEoXFYk48voYl9zaXJbB4zmrBsrSM
Message-ID: <CAEjxPJ4i3GzsjTLjjYyCaZ+MnNkCHZmm3vaLQL-cZMbUW487ag@mail.gmail.com>
Subject: Re: [PATCH] libsepol: bound category values in mls_semantic_level_expand
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	netliomax25-code <netliomax25@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 8:46=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: netliomax25-code <netliomax25@gmail.com>
>
> 1. mls_semantic_level_expand() checks the sensitivity against
> p_levels.nprim but never bounds the per-category low/high values
> against p_cats.nprim.
>
> 2. For a base module the user MLS range and default level are read in
> semantic form with no bounds check, and policydb_read() expands them
> through policydb_index_others() -> policydb_user_cache() before
> policydb_validate() runs, so a crafted base policy with a category
> value past the declared count reads p_cat_val_to_name[] out of bounds,
> both in the "Category range is not valid" message and in the
> p_cat_val_to_name[i] reference inside the loop.
>
> 3. Reject cat->high > p_cats.nprim and guard the error-message indices
> with the same upper bound, matching the existing sensitivity check
> just above.
>
> Confirmed under ASAN: a semantic level with a category low/high beyond
> the declared category count reports a heap-buffer-overflow read in
> mls_semantic_level_expand before the patch, and is rejected cleanly
> with an error after it.
>
> Fixes: https://github.com/SELinuxProject/selinux/pull/528
> Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsepol/src/expand.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 7162f80a..0bd61c82 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -1128,11 +1128,13 @@ int mls_semantic_level_expand(mls_semantic_level_=
t *sl, mls_level_t *l,
>                 return -1;
>         }
>         for (cat =3D sl->cat; cat; cat =3D cat->next) {
> -               if (!cat->low || cat->low > cat->high) {
> +               if (!cat->low || cat->low > cat->high ||
> +                   cat->high > p->p_cats.nprim) {
>                         ERR(h, "Category range is not valid %s.%s",
> -                           cat->low > 0 ? p->p_cat_val_to_name[cat->low =
- 1] :
> -                                          "Invalid",
> -                           cat->high > 0 ?
> +                           (cat->low && cat->low <=3D p->p_cats.nprim) ?
> +                                   p->p_cat_val_to_name[cat->low - 1] :
> +                                   "Invalid",
> +                           (cat->high && cat->high <=3D p->p_cats.nprim)=
 ?
>                                     p->p_cat_val_to_name[cat->high - 1] :
>                                     "Invalid");
>                         return -1;
> --
> 2.54.0
>
