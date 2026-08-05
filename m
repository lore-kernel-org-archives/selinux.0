Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D45477E52
	for <selinux@vger.kernel.org>; Wed,  5 Aug 2026 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785943000; cv=pass; b=fzgofLM/9iKZeA1zK0/mQU6a695+FfJGfXEiju3VuObslxtaO5Drj3mI3Blk0lJdgl78x+GXfMCHE1kJmkgFyWFZE1yD5GN03xfquYuhuoDIZNulCf30VSy2+dAqL15M8KjpykLlX5XPFsq9KqvosbgRt3mQ4Lng/Q32XFS66KM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785943000; c=relaxed/simple;
	bh=5ZSxG8cPhzIcyjJnsO3CSoncytIW6XG5mnu/ES8rjU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTYIFQcCAh/fNMKi2Eh32UZ7siIDkWB54AWwMf0U8Zjlud7V5SMzqnAEpeQQQd9iXROKxYVxr3ZD6ow8V0X11t2FK1DQWTI1fFW8O6GzXPMfP9+TA+nK/0QPh3NwEMviN1Z8GzpF7/PGaaIP5M5zUsY6d9wZlNT44K65BOUEGUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfFrN93W; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfFrN93W"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39faa67fab8so8519541fa.2
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2026 08:16:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785942997; cv=none;
        d=google.com; s=arc-20260327;
        b=eTeXIpXr5KdDJlmeDWeOzwriGZFialRzF9hZ5cjSM/c5Vnyg1iyWTaH0ztOSwYjuP6
         W1KTj4UA3mcqVd006CXzI+UYC3XY10P2pk9m9PycODS1Nb61a6hcIbnNRHSGIx7BswOC
         mD4mFvFNBEIKLhYraXi100IgIMWMULd92xn006EDmNqxECTBied/l2jLvdenOSw5zve/
         n4tnzfoc8kpRDzfI3mxZECAYHc9Nr8pPWSVbr3Y2bEsc5I7N2R5nRZqrCZAE/MZM4kFK
         KDkRK8kg2nVG4zD6lLldsWgBHd1DbzP4Wg+8ezZonw04aZ2VTsX15GmPkxB8tnB5V5rW
         ao8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8kuVsHrRh7EcRpdZ27g13fW4qX/F87Ot67AvGvCOlao=;
        fh=5nMwbpmQ58B5CaD7V3jaLqse69jqPAIvV9MWOzRIojA=;
        b=clxInZ06/sr4H70C2URTy895kjEj90V0Lb6xLeChQhgBlxt+gnkQQrv58H6mMzH3qU
         TBGAXuPh7jZebkmx//8eEBosPDwKXMjV2IQwLTvQAwvscbYh7ip10crpEMc7LI0DSSfp
         GYQArrtxMNxi0CRTTAxcXKucavVR2zvlZJUAJxFkOF7H/vCuw71D9m2lNTFWEJ/y180O
         UJyotys0xcRO3zwPO0YHkUJ/CCJb3xN6CgozKhy04KY9GfYN9+ZRAYAcOSy3tLXeKm8C
         frURpmOONU0lY3s+5Gu3sdHGNbNrNLcLn8n57q3JB7FRTY9xAhyFK06B2YtORFHI163v
         Z5wQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785942997; x=1786547797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8kuVsHrRh7EcRpdZ27g13fW4qX/F87Ot67AvGvCOlao=;
        b=IfFrN93W0z645FXCWw7YNHKNHgN4OmZBGcPZeVGFkeZssXIsqe+z7htQsQ7kt/Shfs
         PmCCUW1RY6Ovg5cDcba04PTEULqyHLofOU+DnpZz1DkWfufUNhsYo9h7JTgOLSaRPXee
         8Hg70x5/Bh1/USn9GaQQOVjZUDMs55H9WekmnN2uyI6VAZCzq1WR9TpSdcvw8tRmFo/8
         HC5v6PEt7IGYAO3Kv/FrdDSSxMaGgA51/Cgri4kC/3GeDqJiaHVISyfJM7xwGlLNS6Xk
         jCD3BbHtyvaPJbpEBxIWPfPxCs/wvPiq8U98l5rKsn2xM3wbTstyazOfR4i2CYKfTANL
         HBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785942997; x=1786547797;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8kuVsHrRh7EcRpdZ27g13fW4qX/F87Ot67AvGvCOlao=;
        b=QJ3enGv702C7rURjKXuxFI1Qip/Hso8zrUWhOJqTN176bVy0WrkD+RvHOQp3tHfSHl
         wzdPuKvsH4VZZBS+hVdC/vZaOab7k4oRa735btHrjcv66L4hgTbJGKhWruKL+fzTtplc
         e9f3+iRLbqVGGpoj7JpP3TJhfrHVieV9zu7jBAhyj4Tq97TOLNZgapzb7WQSO54P/Idf
         MbP7fRoFmJTsicblmp3MjHSmttgWUndoGpIbTQmw4iD9qSutnhVlpi7gnYSM7YeaVx+6
         vfIu27KyEOPoFWkvpJUpjNaoM4fSk/HQn+oXcX9WFLtVvCY5xeZSZAaJnTlqe1BLE4AW
         /2iQ==
X-Gm-Message-State: AOJu0YypJg+PkHHkLCG6qSmfXPlETZ1UeYncupJk3Qgmgml6aHMdjyOd
	ICjR/iY5/AjLx621rz1BXqMJMKSw3613Jp1SCuGvbwjwtRWQ8GuPMEP80Zcihiu00nORvgnuI3D
	p1G7k/0TzDZ4y8U4g3LrKe8cVENx3Epw=
X-Gm-Gg: AR+sD12V6BeH6y5HFTNanqV6A0aq6z2gjYM+ubYhBZ8oI3rrdJ5yubt/iLdh/N/BIxn
	THVWsWVuFuVaeHyfZsYsJs9seOZC2exVJrmYlUfNjFoJQxNn9pfGLetCf0G7Ycgm+08WTeL6g34
	cHurVJio+deqAQzH2fzl1wPZjOwIdcR4yKYqmwg3F1+/RLl0C5TzTLeDCJn03zlLa44p8J0bY3T
	MsrYGnxNYu5YaKKMhV9CUFE/ioBu/HvMEf/4Qjla1MYt8BCStxg/wtkyJAaqRaXX8C7dsTAxcjq
	BZL6fekBwKVakO03JTO2RR6zDxNBPr9ONMcOtuBYjuyslX3iEUGA
X-Received: by 2002:a05:651c:43c3:20b0:39c:6e84:99bf with SMTP id
 38308e7fff4ca-39fbb1b0b96mr7097301fa.19.1785942996401; Wed, 05 Aug 2026
 08:16:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805144401.55963-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260805144401.55963-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 5 Aug 2026 11:16:22 -0400
X-Gm-Features: AUfX_mx3EXEnfw65hDg3G8qniXtzqsrCeinHFoVSH3AAkitGPG10u9I_Ad2QTSg
Message-ID: <CAP+JOzRYEf777ohK1Fk7=zuMO3ti8BhncMxEpzduYorhQ1qmZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol: validate type datum value even for aliases
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com, Chen Gong <reister@ruc.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 10:44=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Validate type datum values even for aliases. The corresponding change
> was already made in the kernel's type_index() function.
>
> Reported-by: Chen Gong <reister@ruc.edu.cn>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/policydb.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index a42fdf98..44e26f4f 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -1109,9 +1109,10 @@ static int type_index(hashtab_key_t key, hashtab_d=
atum_t datum, void *datap)
>         typdatum =3D (type_datum_t *)datum;
>         p =3D (policydb_t *)datap;
>
> +       if (!value_isvalid(typdatum->s.value, p->p_types.nprim))
> +               return -EINVAL;
> +
>         if (typdatum->primary) {
> -               if (!value_isvalid(typdatum->s.value, p->p_types.nprim))
> -                       return -EINVAL;
>                 if (p->p_type_val_to_name[typdatum->s.value - 1] !=3D NUL=
L)
>                         return -EINVAL;
>                 p->p_type_val_to_name[typdatum->s.value - 1] =3D (char *)=
key;
> --
> 2.55.0
>
