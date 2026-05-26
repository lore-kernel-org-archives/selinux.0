Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9103D6494
	for <selinux@vger.kernel.org>; Tue, 26 May 2026 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801544; cv=pass; b=DUvCfsERUNNEan/IZWnkeGqo1NWZxEXEAEg7fY7vB1rEHRFoUUEy336bQKeu1NRMzmWjDVov3/5FvjYHiw5Hwl4Js5OYRZMvRRbaJr7roguBgNhlb9Oqqh4NvXw0ZJ04iOiO47U6QPLvG62k8zKsea5yqJKdzqt9rgV59jJgdIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801544; c=relaxed/simple;
	bh=85BaHXiXJRhEQEGBneOoiuBC5NSre17XHNj1xVQVKOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ib5zJjN1Ukw9M7a9cYJTgtcTPJWiWIZ6YItAMHQDlS0qkSO2vlZu6N1ZjcSxx3Vku3/4PWvISiOjoeMS5OCtgq4Nmwbk/NCll1E+UOHJC9Pyui31K0Lpem3AkoIOjVeyxlrLYGOKaOVa/AT0AlQlp/8lSE0WbiXQngtuKrsDQFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzrG0o24; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzrG0o24"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c828daf83e2so4723956a12.2
        for <selinux@vger.kernel.org>; Tue, 26 May 2026 06:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779801542; cv=none;
        d=google.com; s=arc-20240605;
        b=HJIC0lVNbQf8QlBvdhmp/VCUBg3el+jNtvggyIeXDLrc8TJ9xDFUJo2NQsPk/QeZjW
         nB4TlXwAYf3q/P41Rok6l/X5FxSGUtHaHO6UrxMyT0E70p2r/R/gEDBuclZMFI4gZMr2
         E1OHykvFGqXcFLmu2N8gBqTKHGzpfyID8gOZWQrRlIv/r1F41VqvDZLoc71wtn5EScgQ
         JUkfOQhpZ8KnMalV1UhjpkWC5CRuwOQdVWdBbUdgcGmpyJ2Lnk0saAPdI1MjdIjcJF7U
         QBKk7ZAGAxGFXIVlceTMLjKOudXYyXlZaG3Zl985MeduR9YiEGR0acCAWKTHFOgvwvvr
         23sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8F+8qPgiJYhzX7krXn0qjE/k5/ShNEtFJz6tOwYdcio=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=W9M6jxRVs26jU6XHANvKNpZbGHOeeFRw+ohCK13D7FiohQ5CPWrY6URmp6GkeI3prN
         0dZO9zAjJGbC0qBJGKuRZUzbF2GXHsoZ7MSsdf9+GyUvZheauxGCAcU8JzT65brmgEyX
         j2NSfi59oOqJYSCoKjCZq/cwgnb4YrEVxhmUxVb7jP0IY/kWVryGNGeTq9jEdF63MTbh
         g/6suouY7CMgl/Djdr18TWOOU+co4F6Ic8MA9qsbCV1haifO1fd70azkMV4UuyYrWvy4
         Ejd1Jzq3J3oC9x4elAPZsqOkkRwMp0fNhDZqXwqTnnlDgVUagV7drmooD19er6TXM1Bu
         eKKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779801542; x=1780406342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8F+8qPgiJYhzX7krXn0qjE/k5/ShNEtFJz6tOwYdcio=;
        b=NzrG0o24zt7xUWtzGjWJah7Wwyn73brSAvKi7u0CKYZu2KKzbRdnU+SiNbYHgvqqoj
         EkuhFoQe6WLhxXp2FSCioA6QnqhvilarDvKx52r3KVRtS/t1Pdl7U+Z4IyarJJm17Ijs
         WIhOJI4ChKhZLtTzKMWYE+MAKg6TviSndWqMDM1jSDtn8UDNyFW+wEXoeiz5KaL70WLQ
         BjRW057Sk9ry1VSSEp+Vn9FoBCwC0VZOhU/ORORRGkW2UY3MreIAGSM/1hJG16hCb0bS
         BY0dlxvmrGNW9Zu9eKaTsOR3+rgwEujZr0vg+EX37qDm59yicgviURCcFKtzmZW+h2KV
         +7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779801542; x=1780406342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8F+8qPgiJYhzX7krXn0qjE/k5/ShNEtFJz6tOwYdcio=;
        b=Q3LLXi6abmmbpzXElBWF2KQWSJxXS9dbzcJ5pXsIclDijshVUYNRxSYgxbnK7mMHEy
         TWbam8seHzUPK9NYuibWXMOi2b1rANZoiKJj0JlfxN+Hkd3keAhdE/FOPmq8c6lV/cIQ
         HId2XCoTIzGg505HC6DLgYD3M/VIukyJ4drMbU4B717EeVb2O7ZRDGIq6MgJJH1mroOi
         nkDZfojbo4NzR0r9yHylHi3B9vnqagdTDfXcLpq7mGPppVeIOyCgFndU0Yjz0NAr/T8b
         /BstzBbU0Ij8WU+OZ7rM/zaAm3mKhUFzEf8UY+rwzl3AFiRvC066tjfFsXfL0FMIMpck
         HXHA==
X-Gm-Message-State: AOJu0YzHuMi9/HtUinwCPVF7tEeUc3d5+4Ngyi/TIh4EM7NN6xCkgOF3
	vpifinl233n8T32GLoskYQsRWqYvln45hD3fhVb02pi1djenQHwtynmIUy73Qg1wCIS+g11b5k2
	otCkpWS0M7rIfHcUN24IqROrgdalT9D2d+uWH
X-Gm-Gg: Acq92OEk8QjQ1tnWnou+XvpiNyhHE37wCEv7W7QpCCuGNAxnfNINM6fh/EaUQ/pS6d/
	S5w4fJrajHcgyC6dOgHc+7dqBbP5DaFbOlrsPst0YGpU0etot7qTMVqSGdlnNTIz0SYrMutFX6h
	Nz8aLLHiqRqSrduK+t8srz+CjqNbZVpb3QAfRMQbc++AuUJH4m1xLL2qLx1cscSkvsBMQNZ4INf
	3Y3eUxBCe8flkzajXTCTEFTdI48/Ae68j8byUfUoGSG9DJgnm1Ka/wjfYotsQImchooB7EBp4Lm
	E1HkYLg=
X-Received: by 2002:a05:6a21:62c7:b0:39c:787:f196 with SMTP id
 adf61e73a8af0-3b328c98e02mr17907343637.16.1779801542471; Tue, 26 May 2026
 06:19:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521190627.34885-1-jwcart2@gmail.com>
In-Reply-To: <20260521190627.34885-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 26 May 2026 09:18:51 -0400
X-Gm-Features: AVHnY4IZMpR2SxWGlmPIS56FlpErvvQNovaMs_bLRbRnQBIkolWwyYtU7Vejt54
Message-ID: <CAEjxPJ7ffu6udbmgMcHRPe1=u9j_+5z9QnXxk-NWDGSO0aAuuA@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol: In module_to_cil skip empty conditional blocks
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 3:06=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> When converting a module to CIL, skip conditional blocks that do
> not have either a true block or a false block.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Out of curiosity, when is this possible?

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsepol/src/module_to_cil.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 89cd0b9b..5f1e4dbf 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -1426,6 +1426,8 @@ static int cond_list_to_cil(int indent, struct poli=
cydb *pdb, struct cond_node *
>         struct cond_node *cond;
>
>         for (cond =3D cond_list; cond !=3D NULL; cond =3D cond->next) {
> +               if (!cond->avtrue_list && !cond->avfalse_list)
> +                       continue;
>
>                 rc =3D cond_expr_to_cil(indent, pdb, cond->expr, cond->fl=
ags);
>                 if (rc !=3D 0) {
> --
> 2.54.0
>
>
