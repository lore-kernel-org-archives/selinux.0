Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB5730C172
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782231707; cv=pass; b=q4j8ND8kewv+yVWz5ob4GkID+vmwQrZmpPWgDPjtuFKwbgqOzyVCxwaJipFWUevCJwxwSIC+46TcWoFLwU/QnGbNrWIh4mOHOeV4EdPuxRchwNPq7EWgP56Um2LYChN9z8ialDWS2G6RRhCL+bUtAtJEW4A/L91bi0tYqwvKQnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782231707; c=relaxed/simple;
	bh=hjIL9p+zhEWdQ/p6HRYl9I89qEomg5bArZLy/R8NPwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOU+Zttm0Chsauaph9/G2pDgvbAQJ98lDSOfEIEZCrm2Zu9I8ypantouM0kpd+PzXB6ouWU0YhabvRs9PP0huo6PEGTKtFNEn2hn46FxlYe+E7cAX7fSlLDmUe5UFPTDAhxv+80Snd5t3dEPCrn0tmfRyj6IDjuctYevfIJS+UE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcqHtaJz; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcqHtaJz"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso110777a91.2
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 09:21:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782231705; cv=none;
        d=google.com; s=arc-20240605;
        b=ACHl8M2af1nmUBBeFs05OPFpFHnQUmH3ZGj1z6Yz2epAdvI97EM3MM3tLwS0MOAb8C
         0IEv4knWqBJuCH9dHGvIYUKmoxEXPfX/fgtpkrHTLg6QnthGS/G2zKvf0b1rp0wr7oEQ
         WfWCOZYXVR1+1qdzPugraDklni5qK/v8IQXfr+67nqqtmmR49nNI0VBZ60P24gcpB0pJ
         0QjRLaOePcmyYQpC96OYj/j3PGb0jRymwhK4MeXtkbDY4VOLCuUIwRERiGpsv7cvuhcU
         XGYP2Xru2rTqtFywQ5IiJpAfBJV48kXzEt8FZblL4b9ssF6ihnZRJiP8N2GwAtZOpWz9
         LO+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ukO3yXjWsOo3Q0EcYPUFio7Gh9Zb8OOjUamJFH7Vxkw=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=KXabSBcqXvvaRKHuqcFlM8M/o9HIRlIdXBfwcF0L8G33Bd/KIwpLPDLLnEe5huAaVR
         U1hzRomOGKyW2WeEZVZcx12E2dsCDkr+gPh9l1Q+LKHWdkhwc9ewe6uKJuuBEvKZJhrC
         4ji216+Y6jLl6jaJk6LJeIwwW8Uk15J8QaPnhVGza587wTinDZbKNToOpmMjvQA0jgsA
         yESCmUrJ5wf8idmGtDBa6wHFbbFBLUv7RBUlaEDdy0qOVlr3xYqvU3HvZ1t4oe/mf7nk
         Vsi+2k95EvTvd2Fk4LfWdd3WPtTfdq1NARHh7vy79Oq5KqkrAK/N8xH/u2h/VBo5AP8q
         gJmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782231705; x=1782836505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukO3yXjWsOo3Q0EcYPUFio7Gh9Zb8OOjUamJFH7Vxkw=;
        b=RcqHtaJzEboJsaTwvxqj6JYbfh2YGH9hlcZDv0jcXjQ9BMWBmTkuefSvf0lMx1RXWl
         wiZUMaW/M2X5FgTRS5ri5h0youb5OoKB6Nd1ByKjJNistI/LKcOAj6cc2wKSHKqLz4Ch
         8E64W3HOJxvvACdbe1y5XRUJmMEKs0oU+XioRLsSuhoBgFMUuNh84Y0cuFXHYZbqt6We
         a83K1DFOU+tK295y60qYZX0ar0Dx03It/TCFTPVq1bBmGV6XYuSvUhw3reIiqGdiBqL2
         9IB/mo28YQVSX5570NDm0RfHMmBoilLGvzgzP+ol2LIYBc0Wp2UcguJgEXdgpSx36uLx
         7jVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782231705; x=1782836505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ukO3yXjWsOo3Q0EcYPUFio7Gh9Zb8OOjUamJFH7Vxkw=;
        b=OnRZXambAsSJhZ+1TwbT05R3s3umMY4SHyXijfAxtU7j/4jYp7rajWd5G3LFeIt0tI
         pxh/xqEj4CQsMNHEir3SwlVLyeXJ/Gqf9B9jVTAUcVdHPMr9+rBCK9I369if3kMF6Vnf
         bSdd2zhe+2C9CgBan8peYXmJRo4/7ZAf/f8txJuz6+DOh7RSDh6+s8+OjEb14vK1an2/
         PIYLnxYYAmU6PCHiJIndLEOivBDfCfdZU65hKCDb4DFqn8fc1f7jmFkiLJCOp8Mo0olS
         UMtzD/MohjCoh/ZIQLqReD0FHYa7A/L64H5DqiAC2gso4jwS4BJQwFiaq1V0M3qofY37
         aGww==
X-Gm-Message-State: AOJu0YxcbDMl8Si1ropUlaLRunhAWZYGQA+rTTAj2rnXBJX4mmtHlZoP
	NadUmbRdcWjtmLMbLaG+grq4iJXgO6ZDMsVeez787GZaldE4ZgGdTwM+SXy9LDdmyNRhftFGgjC
	Pq+q3kcu63eNtaitJkRSNCvO/cNVzlEw=
X-Gm-Gg: AfdE7cks9ICAqv0ylc6TgU2HluVN3dtrH30eVMYnfdufrDHp44iuawL5w39/tzaL9lS
	zDVJLtaqB0+eWyZ/yu48N7u0ExHn4lGGz/j0Fu+rRot2nw7HUIkjDmiTVdU8s6uUFsyjtM86z3v
	DJBE2mM49qIk1qCRi/uhDluaM9aykFgbKvVQc+qaPHe0GEIDcgv/5A2vEtgizDphrcTcngxMMhm
	SPMCSi4vfPXhk+Xoab3zXNpNhlZQQkMeMwhzsd9FUrBoQEtOJlDP5UZwb0xIFgSXAQSUnZNL/KV
	EvmPPYg=
X-Received: by 2002:a17:903:1447:b0:2c0:db23:4c4 with SMTP id
 d9443c01a7336-2c7c75cfa0emr39341715ad.16.1782231705128; Tue, 23 Jun 2026
 09:21:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623154937.16913-1-jwcart2@gmail.com> <20260623154937.16913-5-jwcart2@gmail.com>
In-Reply-To: <20260623154937.16913-5-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 12:21:34 -0400
X-Gm-Features: AVVi8CeIJXDIfCGuszlO3iiwGfeuD1BG4CAF4Tot9e22xpBPweDTv1TLgstxmgA
Message-ID: <CAEjxPJ6Lw1Fyi07-J6pWDJGnuEQD4-SwXW4tms8DWzpuh8D1Zg@mail.gmail.com>
Subject: Re: [PATCH 5/6 v4] libsepol: Add overflow checks to strs_* family of functions
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 11:49=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
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
> ---
> v4: Fix spelling in commit message
>     Add temporary variables for the new size for strs_add() and
>       strs_add_at_index()
>
>  libsepol/src/kernel_to_common.c | 27 +++++++++++++++++++++------
>  libsepol/src/kernel_to_conf.c   | 10 +++++++++-
>  2 files changed, 30 insertions(+), 7 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_com=
mon.c
> index adb7b661..9fc29cb9 100644
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
> +               size_t new_size;
>                 while (index >=3D strs->size) {
> -                       strs->size *=3D 2;
> +                       if (__builtin_mul_overflow(strs->size, 2, &new_si=
ze)) {

Since you aren't updating strs->size here anymore, the loop condition
won't use the new size nor
will the next multiply.

Maybe:
    size_t new_size =3D strs->size;
   while (index >=3D new_size) {
           if (__builtin_mul_overflow(new_size, 2, &new_size)) {
...


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
> 2.54.0
>
