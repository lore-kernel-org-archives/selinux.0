Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7474355F41
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682048; cv=pass; b=u4XA4AnVCGXyaAI+iS3NRnbUB7SH9Qj2AZKZlaCDnGEMRANJw4Ks3udYuA5IylKSwwE9F9fRNvcsdHBpk/AbeQo5GOFMpps87LaOZ8fP2GKgryG2r5XAY/POXSw+dwWPAOeg5zSw9z+vU+/trogndlZ+pFNNPB3JOJcpT6w3jtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682048; c=relaxed/simple;
	bh=aEdAwZ8lTPcFAqirhlCpirZZX3dXOnjkATbuQgZ3dSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRLTwt+ibD1VtCJqtcavKIdgbLxRQMuBM5RIGK+E6pTfw0xszD/tHKNc11P6VlFj3QLqMw1qjK/tqK0LFvRJV+vLxc8U20/OMvYBkDlicWP23wyz+yboTJWAMViuWQ7WfEZ64pX3Cg0OxJTQcGDB2rFVJsgj8n9F3oKcDsjnwN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6Yzl8BY; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6Yzl8BY"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c8587427468so959822a12.1
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 10:54:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780682043; cv=none;
        d=google.com; s=arc-20240605;
        b=InCjuQBzKYzVKziAkm5L0LBymC4Nnkx3qsT8PaBvxdz/xKKjUYmavhM9RYYjmDPhha
         IvQ6DYjHxdrjWeVLOdA8nkAoq6dzfcTi30ADTlceTDKr20HsBsFgBMuyf/FrxGC6RM1e
         3Yv7fRWwSEXmD4ugNu3FQ5LO+gxZ5RCi2hDZ7OmV7W8apfWHPPmx5h1KH4ZaaMWET7dw
         KVeHSHEDmttDUAgXKsxmrnaYs4jTV0DmRWZdxaT4gd32z4OLY3Q0GYHKYSEVfXWxx14V
         RP1nkbo3zTbPcsYrBvofjUZ5rn1bxmXWxk/gdtGtuU4F3+aIhJGf9NimFDaq1y+WZFqX
         hzdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U/bsFpenRw4wEDw9bMafDSZkOS5MJKqUy2hRmvDsq+Y=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=BP+/FeTH1NJXWEj1sR4eRwU9+dIU6vhBma1Z5t08hoLEdxt38GQ9Q5P59X5gCD9L8n
         9+VfySlVO11JVIgO0cnJ9UdFcFJL6GhPQLeqee2UST1Xq5HD6F3t/oo2vWRS+sksamdh
         pDMUyrjP90+64mHJDAqqyyYAcyU/qwReDIeolTARfeiIISMdDwDE8DB571Tdb6fyjco9
         oeKuJEeYAYLZscO0EVknwPQI12SRMEc69tDOWmxKWGzDxpDFCYbOI1u/QDGb5iF4lsoM
         GM5HMKrpGMoqXfWZKvPIErEk4Z/juq8iwXY5fW/dirmaTjJMU4r4bkx43hsC9HF/jZeg
         paEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780682043; x=1781286843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/bsFpenRw4wEDw9bMafDSZkOS5MJKqUy2hRmvDsq+Y=;
        b=a6Yzl8BYAp7sLPXJXig35B001DQFpKSDaMkz+v6TqaoleLBCokVxvi0myqms3O+Ero
         lEzmN+BVi2r220xM8ZcbgCe0O4nUhy89EMD7mJ7KaiOv1F7h4a/FkEBextZdBPN3Ym6h
         fo4X8JoWloJPm1XRkV1IOGQueMQhHpVTxkcqzvBcgErcJ8jhjwmMY9LQnp9Pqeh8D39W
         rXZ3rILIE5rqry02mYkllIj57FKdFcFbgmHyqo7USKqiUQ1DEsc9Jf2Z6wb9o1FuT0II
         QqvirNVYfZtaK2gFrBBOKA6zLAdmY4UfrYbnrtpW8dJjGU2jF+zelJfqk6sIAfqEV/Fz
         +0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780682043; x=1781286843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U/bsFpenRw4wEDw9bMafDSZkOS5MJKqUy2hRmvDsq+Y=;
        b=r9Hdgj3HaUxuOitcGyhxU9/dNzuzGOI84hBBmiZBt3n4CFXQTdimgmf1aZtT/AHDMT
         LOFFPOcUUBEKikdxmz51c4b6KXevuEnHL0hy3UOyIreNPSkIET9Ejnk4YszYGq8R9KRa
         wnRjGzjxUbFhq+IZ7TZ0AM6z00ZmMG/e/TPuXXdF2M5PC2PQT0g+O+2C+zroXTIXMkiQ
         yvLG1MiRbMM40TjyoorotR8hXuNig27k4MzrUZI6BGC7LSihvolvZAUzG7qkIjbfoIwv
         5mw8SCqItHq3zIAASZukDBxeDb2G5YhzSCY9/QX/R72CIjVvXTB7yVFlUmjZyDdAvZOF
         bJmg==
X-Gm-Message-State: AOJu0Yxm/SxHAntIilOTvurA7Uh2Qg6+S5XJoJpxDkoEyE2E0MwX2vZm
	RTaItTjbhmAftHOxGx4Vtu8CclANbzJey8E3d+xd+moHhcnzCg26y9fm9CNGvxTU4yC6if+CpNX
	ii649uU9h3u3AlfL/0TKRDLLVXAxGEcw/4POo
X-Gm-Gg: Acq92OFgXOvWV04Yraqqz+qc1kgc3sq2VDsyzpciBvTtdX22Bb+IkWUz8RqIjtPxuzi
	DNDgBtyklBsU4B8gDQqpRfLhn3hU0ueD763hZQmt3SwCTfkWTtvSTa4V0irRKKpHzEUptGvfD5g
	HfHXm+6yKQnZeHFFop4g21uQllsGEY1R2vwQDKBa6Fcbvypd8xruYaf4EcXqCtgEKCM9RpeHwCW
	9M8eVwSc7HQHMB/3bV/qZ7jnaObV814zpDRZ3CTrPzo4BFvbC5Vzgxxo6+452JH2EgcBVTpGigQ
	Px2HczXbDqU7G9xz7A==
X-Received: by 2002:a05:6a20:4323:b0:3a0:aee6:acc1 with SMTP id
 adf61e73a8af0-3b4ccfdb60cmr5989426637.33.1780682042847; Fri, 05 Jun 2026
 10:54:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605172207.222382-1-cgoettsche@seltendoof.de> <20260605172207.222382-6-cgoettsche@seltendoof.de>
In-Reply-To: <20260605172207.222382-6-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 13:53:50 -0400
X-Gm-Features: AVHnY4LeEMuEuHXinlzeNyR1TbAEypu3NOg0t46QIlqlAoC-bIko47_PdToP3rw
Message-ID: <CAEjxPJ7c--i_RDtv6V4ffgFFpuUg6VrTGzsPnAKj8hCr6dNoOg@mail.gmail.com>
Subject: Re: [PATCH 07/11] mcstrans: check context_range_set(3) for failure
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 1:29=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Bail in case context_range_set(3) fails.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  mcstrans/src/mcstrans.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> index e0593c76..ee9392bc 100644
> --- a/mcstrans/src/mcstrans.c
> +++ b/mcstrans/src/mcstrans.c
> @@ -981,7 +981,10 @@ static char *new_context_str(const char *incon, cons=
t char *range)
>         if (!con) {
>                 goto exit;
>         }
> -       context_range_set(con, range);
> +       if (context_range_set(con, range) < 0) {
> +               context_free(con);
> +               goto exit;
> +       }
>         rcon =3D context_to_str(con);
>         context_free(con);
>         if (!rcon) {
> --
> 2.53.0
>
>
