Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5203C1F24
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780947211; cv=pass; b=lHn838t8mRsmBR/8UpnyB7VfBs23KOaqbKA5DP5AcrCMEH/i4f3NC9rsgA8eRjk9x4JTifcZNh3XvCItAoYbK9Y6cKj1fM9ihUQAYE22j2iJ43wKab4rJXUzL43XfFJMBsdNoC381w6G6wk0cFtWARNLAdwtdS39lQZBU0To+7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780947211; c=relaxed/simple;
	bh=I4Hm+44mVR847s5UeSZW09VmCbEq+GbJV3FDnhDMMdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tiy1M2H37qDTKWQCFr1QuCUiU51iwuyEU6POtgfBJtuHUTcm212t4udlg4ZC9M4x2HcZ3oNdnTnKup6K42a3GIKvwBL3jqJuoxiimJiaePAFZHw+YWQsjhuVzIvUpD2FUY/3io78bw7R2fJvHvntDdn1+ryJqMxSoBiOS9Joxo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyZIXj/y; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyZIXj/y"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa68dbd44fso4776922e87.2
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 12:33:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780947208; cv=none;
        d=google.com; s=arc-20240605;
        b=dw8Jez/FGeK7DNkVrgnC0p0qY3iguGtdruk93PgCh2L+h78XbEyUIlkU9eTiRtUyl1
         dPotkCTS/baLsxVvgMnfUY9ROEyPq4fMUzGNuLOZHSdHxg9oeJZsVeP2621MPRK+PSx3
         yUL4rp7R2yqEOKCuQkGabEem2UXSM2zoRpC4yCPqd+jtR/ak1dOyDVEYFcMTRmWYoTEr
         C6y/YAVFNonR5yF8DE2+5E1pitpFH5VGHG31SdHVMzMnjCQJESJfYkNb6Ux189YjYVIq
         nmXSN0VSdVNV7nl+r8KH2ZjaCrcs/ZgjMU/ORo3+IqxdikFUBgm+hx+ZKTYurnawngBI
         NhKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Py+gnj4fmktXfuyX6KTgjBFZibtj31OyqIlIhn+sXxg=;
        fh=biLNIbUdiVI+HWgqVoISrU2pQus1fZiQi7u7sC8l6as=;
        b=GDexm04t9Ds9OGLbCWR63DbwphZXG7JwFRX8R802IYeJuG94S+3aNOlO8e/ZwOcYJK
         Ybw1jm9yW17fUhMG4eS0GCQZNGcZImwb2n9qVJU5oqVknC9iah6161kL6Kl7fRJ968Tg
         drTUmwjJa07XQKiwIvShyr3oapm37JyKEeGPwkWhxpfQhUdkI4hQXyTDAk1nLfXZHJG5
         nLJqAWPgbB4UT9BlQw4iVRRyksCYUw5yEzc1Yt++17fQpQSpGRm4tT6TRIz2BdcqQTEh
         Oglcyp7uFC+r0uhLy/BBCyf66JTDz8NDqKbMp/mrwai22wOaG6sLhO5+muwgB3DkrgyA
         eBWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780947208; x=1781552008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Py+gnj4fmktXfuyX6KTgjBFZibtj31OyqIlIhn+sXxg=;
        b=dyZIXj/yfCz6AZs+ok1BON/pSC2JudEPJp5IH0+rvc54FtjnJRBayVvBeHYPQgdAZ2
         vSq1x4gg5FPdIP09+meW+674noS8mgWQ7O8c6SdqK9K4Ko/fEy4VlWptfpE9PPzRnBea
         T/w6pqr71MkKId9RukLfvkgcRf3ah9M4+/5JDkH9xnlBhI0Cvk4svq7ooOopO9TcugAn
         elGDEr1svmmEiITpkywc+CfOweKvv4jSws7MQZt7T50EAD33XaqTlIDkSMDPLtm1fx3P
         QBUfja14qw2FIihAVubrEhQ+JAuLC5rUs0qoTOCm/4yJ0+CbNFUjm11ibHML5UCT2q5a
         +S2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780947208; x=1781552008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Py+gnj4fmktXfuyX6KTgjBFZibtj31OyqIlIhn+sXxg=;
        b=fyfvjavUn0337NCjBks5RL7uJu3gCHONYnTE+9c+F0OgJdiB/rFuNBunNtyZcEtI0D
         sl2QBmWSTA/Z41Cz98TOXJscMk4T+FqCVY6xDjT39BVsq7Tpsd9FjGt9Kf3ZizdRbhYp
         gCpopNvMFNMnVCTL32h+7j29vIlaYwFQgpWg20w/OU9GR/K+5VComh2lYKdFf8MEQWMg
         fLhjgLajT5NAN71QsTSn8k2ZZvNpfCnoxhQjGPCnwADb8hSpBuGhByom6+uWStJNQGLA
         R3+YFzh3mdOJPbcDCcyyGT4i6+Mxllx0oBTlVaC0JF1WQfZ3gmFw8wS2jrLmC5KtFCGQ
         wQuA==
X-Gm-Message-State: AOJu0YzUI2oW6fcWafiRh0E78THKwVakKurbTC4XcazkvhY7M8dzaTiF
	WUoQBzJSmARx2VIj/TySChuGr1YmnSZmJTs/zXi5eJzQnyR+kfTD1bjiOsxoo4eW220g/7AwDgR
	LdMkICcoPoXylsc9qT9E1t3xcilG516A=
X-Gm-Gg: Acq92OFubTJf05MilF591eCYubVE/ORNYI5tl2I+dNpBww+DbhuCxbbUdpP/JJ4kfIP
	TxMvTXqifwChOxNLiYzyEPXIDt4YhoVs/Tc9GU0JughUvTY0niZepJbqeeMEAh0sa00BZwgxlqU
	qfWZKqJfGpshUzRr5K0/upeJt695vrHriBGvr42SHlViNokGAgn5iPaCs4QP5SYPjAJwMKq2ArL
	ju2hMZyBehnTpHbHIfiSPj2I4hji8bjEb+9GIFCwzbP38Zz89CqPOW5t9q7s6OuIs6wnva8MYX4
	TOzWsxqMxLjucS4=
X-Received: by 2002:a05:6512:1595:b0:5a3:cc81:eff3 with SMTP id
 2adb3069b0e04-5aa87b86f5amr4284091e87.26.1780947207905; Mon, 08 Jun 2026
 12:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608174923.315337-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260608174923.315337-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 8 Jun 2026 15:33:16 -0400
X-Gm-Features: AVVi8Cd6O7IiJgaL0SCCn0lKP-PnWxkP3eo3lKVMZUBzjirwKUeZpQAPuEzsBeI
Message-ID: <CAP+JOzTi899ud8mQ3gMELM6EE-dAZNqfCTofP+Z9A3nsRZ4XKw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: label_file: prevent num_specs overflow
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 1:49=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> num_specs is read from the mmap'd binary file contexts file
> and added to data->num_specs without checking for integer
> overflow. Add such a check.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/label_file.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index ac0a3ab0..0c0499eb 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -1042,6 +1042,9 @@ end_arch_check:
>                 goto err;
>         num_specs =3D be64toh(data_u64);
>
> +       if (__builtin_add_overflow(data->num_specs, num_specs, &data_u64)=
)
> +               goto err;
> +
>         rc =3D load_mmap_ctxarray(mmap_area, path, &ctx_array, rec->valid=
ating);
>         if (rc)
>                 goto err;
> --
> 2.54.0
>
