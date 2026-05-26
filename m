Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F8C3DFC75
	for <selinux@vger.kernel.org>; Tue, 26 May 2026 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801434; cv=pass; b=hm03mIg3wyV6RRTN+8HA9ANULjEy4uWkuU0tcIGmLJjrnRaieMdPgDuMou+E2Z/B8qMbLdXPEGpbE5JYoldskt4AmuKt8pPO0amGcqPh4oa7FCGT8bVFjE7c0vCxGmMay3PPO+oI6AoZFLdvzYOQru6/w2P2W2nB2SwV007ghiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801434; c=relaxed/simple;
	bh=ypONjAOTgRuMh/sUXVkiitE1b/qU5mX99nMUqBpry9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6OxLrCsZw5AA236g+rXC3Yu2xFrLWkZTjSvRDJcNF5xOXKTCLUjl3FmS2foeMpljkc1+uGYtrGQjdEcuZAvnUb08W6Ighru1M/YD1GSz9E7rWfMFSP5p+uALK+bc/VMJ/dZh73Cog12iGz2/jJTpX/HwZggKPMHau8UXzvrVFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldF8Ozd7; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldF8Ozd7"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bea7176c72so40519185ad.0
        for <selinux@vger.kernel.org>; Tue, 26 May 2026 06:17:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779801432; cv=none;
        d=google.com; s=arc-20240605;
        b=O9xNzkq8LhFWpOCNwSZ8jULsyiXf0bKWIypwOehWoeYprtjXlrqiYMgGK+T9C4KGfY
         yfM6mNCc8+wYP3Gh5fkSZQutYi6XsRcciffe2zfEw4//7lp5JiSJyNxjuQDXCSn0I+50
         a8tC9BD32JuDjmoSLXwzO2FPmRnwEDaVDBhrD6LR7jiMyJbbmfyuZutkWL7hmy5IRpG0
         4xMpF4CBcYequQti6duxLGXq15mblCWRoSKYs9lY2s6mZ2Qn58AWFQJSmj8mQxo1r4n/
         c72qKItITc2ujqQRuswHuYrQ895EgQSNf1ve53nXd6JdJY/pXtRubNL9CCc2J9tPDyab
         gN2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D05TzWQXXwsYtCo6zMgiaKDhJ+1cC4ug4rU3SG/96QE=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=cfbNiGnsJbmnx5tWRZDfIYB03wwgHQXDFCQjFZzBw2CMbY5ELHSmXBYi6Z5295+puj
         miNSMRmu/JwvlwpfNkt8tD0bv147FctsK2rv1GDMRMVYQYuK+pMNjsmdyhyC1hvoixoB
         Otw9joHqcnC+Rn+k14Wb7n4fOt4R8MaZhkcq0owprneutDxBavBT7kjVlxmdlL2nS1O0
         4wHzV+L5uf5339wxofoHSaPXgTCYbWe22zTIf8DrfqIpAoRat7ingFjgo9feAclJj41I
         il/bm3Zozh4A0SQHikBdRYIgnmyfrn8Lkq/MTt8DUTUK4Ii0z4Wihdfj3iwX6ZfpbPuW
         XV9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779801432; x=1780406232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D05TzWQXXwsYtCo6zMgiaKDhJ+1cC4ug4rU3SG/96QE=;
        b=ldF8Ozd79MJ4lTGaOosMVH+HunvHyLOzQYfHimFD2QbgEgYvXdK3+4A+PwNltbY+26
         SzFI8yV4nWcIrWvF1r+uqYy/3uOxkhRQURUBWT+ZiKFRXpX3PcbfHZOhTSW0jhorPJ+9
         y4iwdyVKHYNZVYH6E7ghbTQ+SwSLSB4ZJY5sVJHpJKJyXTQfZYoDgr8pb8MTHnzUmoc/
         6/hK8NG4j3t7chVdneHPyGbskzYmt1fX5O/uLuRllqHaOPiTe2qtUcmPubYeLP/bjSY4
         C3qnXrCjmky9WdziJbQfo4Lu5jGn6fixtWWD3w4WgoixUXQKLp8PJeTzf5VRc1M1T+UM
         caOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779801432; x=1780406232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D05TzWQXXwsYtCo6zMgiaKDhJ+1cC4ug4rU3SG/96QE=;
        b=KC5krbQ7Sti4Kd2ofeBzG/h8Zb92P27EpLP1aQxgJrOEjGcCSinVSjnvK4bWcveK4n
         K/Fr/v8g9qmJPKclq1EAxgxJ7gJuTiqGKKusJwCa1NzwOjPjU0WvJrZACr3ZQQuXuGaY
         w2VI9qwIsgknDpVxiwL/ms29YV3TavRP4boF3GlcqFkHh6fTHU6rGbyC/A+iEPjGYQpr
         Evwi5fnnpu/FDJxEmvxh4zdKkJLTcJmd7DGpYI1cD1faRw9hfuRx3F/GtEDYpYLyhvdl
         1kdoxfHvaokf2F7p+aq97ZNmJojtMkkKl2TwU06Sh2SzqDDfaEsgPVfOXKC1QfIDA4M6
         tXMQ==
X-Gm-Message-State: AOJu0YwX0N0vIx9AOXsFXeQUv0qJVtzlpd6BdSfs0RxMiBLQevUV3nEx
	2Igf0Z1vs34/sobJRdGECX7qL+I2HNnDcI8Gfv96KeaemYQh236S7GfL/7DR16+kTp3LOYy721/
	TjkkU5WcECTMqAGQuaDDZSsNZq2Ors7s=
X-Gm-Gg: Acq92OHk28/2US7hm93eiXk585HEa/t/ZJK/dhQvBOv9bCfr9wad97nQuQUHDulTmUq
	MwHOUGKo2oGzFpCroTFBu5ZBAqsmXg2gaw0GJy0dC54p7Oimz9CCwOr6s4SMlhKsHhD7DDSkhCW
	wWt31xabBBrr31oCM6oUYaTikSMnPR+YaZLRd4PO6F4MZtFmJdZ6YnIA8+pl1jfqSCb7HvsUETU
	gCKc8enICYCXpCJZpsII44xuWutfuQDg2QOCKobsQ0hAsMv/GTFdJ79IojuX6G+/W/1q/AC87+v
	EuYYxWxsA6g4ia6sSg==
X-Received: by 2002:a17:903:3c6b:b0:2b2:49a7:a5bc with SMTP id
 d9443c01a7336-2beb0715592mr201213345ad.39.1779801432306; Tue, 26 May 2026
 06:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521180100.21791-1-jwcart2@gmail.com>
In-Reply-To: <20260521180100.21791-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 26 May 2026 09:17:00 -0400
X-Gm-Features: AVHnY4K1ObQ4cdBUuV42hXDQ-mU2jEVsWUsIi6lOAFjSXNEt4JCBGIYqfDnZKi0
Message-ID: <CAEjxPJ6ieK2=QXRucnwvC2Zs952V4cZAE6wMPMSshqpVU_H+-Q@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Fix double free in copy_avrule_block
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 2:44=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> If there is a failure in copy_avrule_decl(), avrule_decl_destroy()
> is called on new_decl and then avrule_block_list_destroy() is called
> on new_block, but since new_decl has already been linked into
> new_block, new_decl will be freed again.
>
> Instead, just link new_decl into new_block after the call to
> copy_avrule_decl().
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsepol/src/link.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> index 188b4020..e0da6575 100644
> --- a/libsepol/src/link.c
> +++ b/libsepol/src/link.c
> @@ -1757,12 +1757,6 @@ static int copy_avrule_block(link_state_t * state,=
 policy_module_t * module,
>                         }
>                 }
>
> -               if (last_decl =3D=3D NULL) {
> -                       new_block->branch_list =3D new_decl;
> -               } else {
> -                       last_decl->next =3D new_decl;
> -               }
> -               last_decl =3D new_decl;
>                 state->base->decl_val_to_struct[state->next_decl_id - 1] =
=3D
>                     new_decl;
>                 state->decl_to_mod[state->next_decl_id] =3D module->polic=
y;
> @@ -1775,6 +1769,13 @@ static int copy_avrule_block(link_state_t * state,=
 policy_module_t * module,
>                         goto cleanup;
>                 }
>
> +               if (last_decl =3D=3D NULL) {
> +                       new_block->branch_list =3D new_decl;
> +               } else {
> +                       last_decl->next =3D new_decl;
> +               }
> +               last_decl =3D new_decl;
> +
>                 state->next_decl_id++;
>         }
>         state->last_avrule_block->next =3D new_block;
> --
> 2.54.0
>
>
