Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2575C41D4D7
	for <selinux@vger.kernel.org>; Mon,  6 Jul 2026 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355235; cv=pass; b=o8QJqP8t9IwH1MuoqgbrUUCp+dZ1Dx0PgEM1DP/9gWYfYs4BmK+Psuwms3lIvJ0Q+/YsVBrMi7Zc4Xkk64qht0utO8WBYk9klHWb+gzvHWwXpYNkKFNUDtBbmmqdArrJ3UnS4mYtSz5Wx56NpktcSuK4YnbYC7JRBWdD63b2XK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355235; c=relaxed/simple;
	bh=ZGtgw7bpT/Ckf4/Iq5FljBKWU9voXaO91Lfk2QGRqWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qqOnwuRAeb0ahHtyBKapSynDa0MPDgUKh2Ue0WXGcyPbxsVbNlhgcX0GgTbHiTiStX6mgTO/2y++mhaE/5Dzg1gEUrJg9aFFeNdHZN+3qBjEkqSsNQfMJR0TS8qOB+gYp0Oq+id0soJ7Pg/fFdTYw5qePo7PWzhx+VZev54KBYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmJWo8VB; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmJWo8VB"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38426d04bb4so1384709a91.1
        for <selinux@vger.kernel.org>; Mon, 06 Jul 2026 09:27:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783355231; cv=none;
        d=google.com; s=arc-20260327;
        b=mDOue2MoQKYuIQ0s9KiY8vGx+derZsKnAFvKnxSAhd18BxWtlfSEJzlmVI2dx35rUf
         FMJYq1jip4C7n7siO4v3nTyZOD1G6f28e+pM4fOexkenk3q8+3t8f3amdxOKrZqN7bye
         HP3cwN2R5OacUTmoBRCkeXhDAgUWSmL747ZllUgG3j8k/WrjGCjY0fvUT09SO0aKnp83
         +LWv77zWRKGZcDPOpj7bA9A/l99eV8r1mlu53ocwqJL8Cbl6rOn74/kpV2yOWuMLKqOA
         daYGTl+lM9wSKzBuLLHbDs7V6B6O1TUk004u62Y19qPO0LWk2jX+1tZvvaa20sNGKdKF
         RTAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w1UNCH+V2wKbxnqvz/5QyaTA+Cq2tQf7qce1K7DAyig=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=M8QZhuXJHfXKx9z3TK2+sS0i+zF8O5bdkrNN/hnISXQbKuvQEui4aKBCVwHRhsq9cn
         vI61+PohsH2O/U214YtEEtcBluG/hx0P2LrgZw6eb4rlJnp7ABHETB0MJLVYhwYLf8Lx
         iq0jWjlJYcCZ6wGfZattxfE9+jFkbS2vRIhx/GAARdLtV63TrZZHCf0/DPVFUQsmEWvI
         K4Wsub1bsD0fsrX+wSmyoe+z/QA7crZv9KaHaUlhqzUpTx5NoiRhX4tUyceBlKzWScCP
         6TactEVC6j2GkcVpO1mdLIYqHDHx1QtRuL68y1WeGnQJ81dhf30J4+aJT9QJOphBHhN+
         CuCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783355231; x=1783960031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1UNCH+V2wKbxnqvz/5QyaTA+Cq2tQf7qce1K7DAyig=;
        b=nmJWo8VBmWZGVXJY43IFrSFUIh6P1h10VKkdelSp2OVZpqjK4qTfNNjsTrOJj0ZhWj
         EQRyZtfA7waLn91gS8pO8upWbEkb0lfxJAPn1dIANOkMhctC1OepqHcAxQwJiqvGHpGX
         +ndZYeqmaQ2PmenWW46zS+vLoegtnd72HnOIn1mbUpC7n3HyOY/6NScPHqpA8zNH15vW
         4kx2r0UN/ap3G594SuMiqOVMsRMaFxJAdhwWZYut6ov6Snqv0bEDJU8ke0MsD/KKF3jD
         vy52HbKcZy36rR3DrHvVJ5UF7LAuP4foU3wrzjmBkbkYh+jmjnXc8+rDs+rm58dm+kJH
         GB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783355231; x=1783960031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w1UNCH+V2wKbxnqvz/5QyaTA+Cq2tQf7qce1K7DAyig=;
        b=MN5pfMiOIYth5u8o94TPP8or6creJMrSpsbE/YlCPAVHN1S0/57SGo3Au/DY7soBCb
         B8x1SgOENk3cxYAqKGj6Qv7zkAJcBO14KXCvi9Qx4k/yG3VyMjeiqh9kK5D4jaBC36yK
         wLca4Lie4hQumUieOjgsFDBoQntFMzmSoxtcW5eoWKLtK1XVZ+//mjDGH2To63x/F7bm
         ZLTc1AhO5r1bk0M/TTjJXys2nb3TKfSC3OJQLPXoWNeEhtQWvC2nMwGL01vwfDi5vXhq
         l4Qe/VJcd3d3F7u7Z9E/Pvlz2Ta2+i4VlJWjz5qw5YYYHoL1JVn06J3Dtml4zBXpCCTC
         T0SQ==
X-Gm-Message-State: AOJu0YzUdqSpUdGiMtimZoAvh7AHKfXt2I3bzlO55y5kUHGmv/jyGQ9P
	w00aD2Ie/7GnEDp08aMvjmxl5g3aeNHrN64UbApFo7nHWk2dYUYYKsF3TxNQHOS86PcpL6N0sMS
	l3l0KMkR9dPRxtZd/E2gdfeZIK4M7dCTfdQ==
X-Gm-Gg: AfdE7cmBR14Zj/mLfp6h1q67gHnojmzAWiZLlMNen1mEDugVrIL6TO+n3E0ZY4MXh4x
	iYmDrreJpx61J1tisl4x3NfImjtIVWlVuWeBu7JmrivKyV7lByPMoqx20Iiw6YYw8R+SXK0yRCm
	0kgj/vlBb34/HxmHqD0MjGxfMRiCRBNEM+3Ku7WgQs516OEj+6BejNc0bBk5ICVAxmfQ72PtAXo
	5NwP+8R8nV83m0/bPsVOmXNqEEGB47FepWPUFXf/q9tspVjQgPVMFvlLvQUa9E5burkVQc/
X-Received: by 2002:a17:90b:5246:b0:36a:8254:8eb1 with SMTP id
 98e67ed59e1d1-3873c2f4510mr1364964a91.6.1783355231216; Mon, 06 Jul 2026
 09:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706143844.25956-1-jwcart2@gmail.com> <20260706143844.25956-5-jwcart2@gmail.com>
In-Reply-To: <20260706143844.25956-5-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 6 Jul 2026 12:27:00 -0400
X-Gm-Features: AVVi8CdeCcWBpHps5yOQyaheicoPIxJfYNtPJJ8-tWTBTA8tPpYpXN_j3LcQzRQ
Message-ID: <CAEjxPJ66ymZa93AgxV9jFHqKURJxcJX5N72zfEeGf0nDqXFq=Q@mail.gmail.com>
Subject: Re: [PATCH 5/6 v7] libsepol: Add overflow checks to strs_* family of functions
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 10:39=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> The strs_* family of functions provide convenient functions for
> handling an array of strings which is used in kernel_to_conf and
> kernel_to_cil. It uses the common idiom of "*=3D 2" to grow the
> array without any checks for overflow. There is also the function
> strs_add_at_index() which can cause multiple iterations of the
> "*=3D 2" idiom.
>
> Use the __builtin_mul_overflow() function that will do the
> multiplication while checking for overflow.
>
> In addition, the function strs_len_items() adds up the lengths
> of all the strings in the array which can overflow.
>
> Use the __builtin_add_overflow() function that will do the addition
> while checking for overflow.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v7: Remove uneccessary check for len > 0 before subtracting 1
>
>  libsepol/src/kernel_to_common.c | 29 ++++++++++++++++++++++-------
>  libsepol/src/kernel_to_conf.c   | 10 +++++++++-
>  2 files changed, 31 insertions(+), 8 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_com=
mon.c
> index adb7b661..c7b6d73a 100644
> --- a/libsepol/src/kernel_to_common.c
> +++ b/libsepol/src/kernel_to_common.c
> @@ -117,13 +117,18 @@ int strs_add(struct strs *strs, char *s)
>         if (strs->num + 1 > strs->size) {
>                 char **new;
>                 size_t i =3D strs->size;
> -               strs->size *=3D 2;
> -               new =3D reallocarray(strs->list, strs->size, sizeof(char =
*));
> +               size_t new_size;
> +               if (__builtin_mul_overflow(strs->size, 2, &new_size)) {
> +                       ERR(NULL, "Overflow");
> +                       return -1;
> +               }
> +               new =3D reallocarray(strs->list, new_size, sizeof(char *)=
);
>                 if (!new) {
>                         ERR(NULL, "Out of memory");
>                         return -1;
>                 }
>                 strs->list =3D new;
> +               strs->size =3D new_size;
>                 memset(&strs->list[i], 0, sizeof(char *) * (strs->size - =
i));
>         }
>
> @@ -172,15 +177,20 @@ int strs_add_at_index(struct strs *strs, char *s, s=
ize_t index)
>         if (index >=3D strs->size) {
>                 char **new;
>                 size_t i =3D strs->size;
> -               while (index >=3D strs->size) {
> -                       strs->size *=3D 2;
> +               size_t new_size =3D strs->size;
> +               while (index >=3D new_size) {
> +                       if (__builtin_mul_overflow(new_size, 2, &new_size=
)) {
> +                               ERR(NULL, "Overflow");
> +                               return -1;
> +                       }
>                 }
> -               new =3D reallocarray(strs->list, strs->size, sizeof(char =
*));
> +               new =3D reallocarray(strs->list, new_size, sizeof(char *)=
);
>                 if (!new) {
>                         ERR(NULL, "Out of memory");
>                         return -1;
>                 }
>                 strs->list =3D new;
> +               strs->size =3D new_size;
>                 memset(&strs->list[i], 0, sizeof(char *) * (strs->size - =
i));
>         }
>
> @@ -229,7 +239,9 @@ size_t strs_len_items(const struct strs *strs)
>         for (i =3D 0; i < strs->num; i++) {
>                 if (!strs->list[i])
>                         continue;
> -               len +=3D strlen(strs->list[i]);
> +               if (__builtin_add_overflow(len, strlen(strs->list[i]), &l=
en)) {
> +                       return SIZE_MAX;
> +               }
>         }
>
>         return len;
> @@ -248,7 +260,10 @@ char *strs_to_str(const struct strs *strs)
>         }
>
>         /* strs->num added because either ' ' or '\0' follows each item *=
/
> -       len =3D strs_len_items(strs) + strs->num;
> +       if (__builtin_add_overflow(strs_len_items(strs), strs->num, &len)=
) {
> +               ERR(NULL, "Overflow");
> +               goto exit;
> +       }
>         str =3D malloc(len);
>         if (!str) {
>                 ERR(NULL, "Out of memory");
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index 3e6bcb33..9bfe5b38 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -1663,7 +1663,15 @@ static char *attr_strs_to_str(struct strs *strs)
>         }
>
>         /* 2*strs->num - 1 because ", " follows all but last attr (follow=
ed by '\0') */
> -       len =3D strs_len_items(strs) + 2 * strs->num - 1;
> +       if (__builtin_mul_overflow(strs->num, 2, &len)) {
> +               ERR(NULL, "Overflow");
> +               goto exit;
> +       }
> +       len -=3D 1;
> +       if (__builtin_add_overflow(len, strs_len_items(strs), &len)) {
> +               ERR(NULL, "Overflow");
> +               goto exit;
> +       }
>         str =3D malloc(len);
>         if (!str) {
>                 ERR(NULL, "Out of memory");
> --
> 2.55.0
>
