Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D78383C93
	for <selinux@vger.kernel.org>; Tue,  2 Jun 2026 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424617; cv=pass; b=Y5aSByDN4i2BX0PeDoP4RpYhXc86KvpvP09IbTwccKuylV0ypVc3gOhuN7Zg5ZeVRYVtm4VeWQDLOX9h5LUyc0voJRyL0qTEoPnNsG1CZZsIsc7ULHiJthMJbRyRfM3+5MqikNIes46FaUEF7c42xS0caDt4jFEKuHVMQCYen/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424617; c=relaxed/simple;
	bh=dxwJnEmxao/eZNbn3r1rvSbg+xGM2x0DyzA55Uwi/Fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JU1Fiuu5YDZ5FKNnCMrJfJk8duEMYiCWI4PoeUToiiGMuB6Kg03RATjNO8cqnB3inKS7KhnbuCw/8bKbsMaUO0u+gqur+xybp2+ABInsso6cJf4q/9GI8hq6IZIJ9tVI3zBCwLLPvYO5w5ZviLNbjEF/7rFhe2qsuCj4pIwXgGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqWJCl4x; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqWJCl4x"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0a5354da1so25627445ad.0
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2026 11:23:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780424616; cv=none;
        d=google.com; s=arc-20240605;
        b=irZjWNsZDPP4TZSuKC36QAPoNDPn4dsTWMw061ww1IX257P6mUA/DVQlmzkj8ub8xl
         NWAFFMRE3meynQspBbCALfHNrAQVvCDR4wwjon2cCb6Ng5jn7vecIkskzyAXZAoL6mnt
         cg0L/NMP9YbNOdr8xd3Fez3bYUmLo1YtXOLbf+Tam7ptksXJOTXi5XdfLdAGG265ul/B
         bejnxRdaazZpAT4s6f2rqz0HksGtx+ucjWorrhtruaaRZGvZmYFDcOVNHw4ce6VZkXv0
         pbueQKhw0fGpGKFu/iZHQwwFLD5au29dz+yUsV5bFwcuc5hnYX71gEuHiTqRzEcarxiO
         /Olw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BniZheKRMcVMd6BCf3Awcp4DL3Zd4aDvIg2Hc86x91M=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=DAOLkBml0e7T0upwjPAtJtXdcCvPlf84h8bvO9qYEhhEdFulGA5lrM2TXtCm/5JRkB
         Ez/CwuphHK+IvL6IN9Sl3eYxxLX8YLVHP/aQ8D9YnGPgTA4a5FQ3ANN9qjhWurH8eztO
         MYw2HNRQlL9z4u+FPh25unlZyH9GYOeFvxgS4MC+4yiIfHfjEVkC0ujZUwpfk5rVu4Gs
         BMI8PAt/lfAOZdStzErh2yysYcrUqYwAXk4kopsp4BBG8eoPRzvt6IasGHP0uAoT9wpt
         IRG/t2O7/tk7IiBVqjJq6FY0GUCEFYs8r85e9jhJiiuZPNMXSGHOtYA9d0rIceFIuYzU
         S2rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780424616; x=1781029416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BniZheKRMcVMd6BCf3Awcp4DL3Zd4aDvIg2Hc86x91M=;
        b=KqWJCl4xSrc4Zb93Nnr/hNTwdxr8iLiZwUwEHaX5xHnn7aVRvcCzAPtTpQnpXD/Vr4
         Kx1NeOdE1CAVvd9wCA6cF4RNrWjql8gcoRD8129MU2vIgNnHRiLZGwBZIml8OEtku9eM
         xr9jEB2LKTaQmZ124jrKwXAVWa+1E5CHqatd05OytNQM1Iqoca266r25q7k19fmDZtk3
         CXEfNPttZqIhy4BKacKoTh0gmrhdA3M4Wg7S0ouOKHXDZWmp2DRrJ45dCfzbrBPMfRwH
         RgR3TpGfx0HZWf3gPMaBvT1H/mSe3Bt14ZxM7R1iYU06gsSX12lQsty3TMBgN7ZkYYlp
         sxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780424616; x=1781029416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BniZheKRMcVMd6BCf3Awcp4DL3Zd4aDvIg2Hc86x91M=;
        b=CaLoDMc3423w8BXhUe+BZYAqYotEDzN3TiaPPBTyThEO7K5V8tVo1GdtgYBfli+f4I
         ZYNzyIs5du7XzQ4JHOG97ICIS05h8LsI9M41f88bHdgNCaapmItR/Dy9p8AIwkAXOhnC
         41yFNUWjVT2CyRQrtsqtZv0if4fw1I2o9z2u3qULRXBOvzjNKPRqFqV5ZIYe11ONG0Bp
         4X7O7zgFzPBi5i0vYIcYqVBNd9zmeX6rq/ti4uTFu9xEJMu3cZayM6wHMIX6WB3gC0sO
         YRLHYNdy8eLW8+5YCH4wCTyze3uw69XED18a3O5vHJDI2X8/c0GMWmJeA7fik2y7Zjhc
         S7LQ==
X-Gm-Message-State: AOJu0YwF6rFgX+opHyGy80T72x49LEnY2JFBvhhNGLbI/eQAX7RjHPP5
	wgJtEfqLSXF/JLRyOY4ERe+E0MtdCSkybE55ZP0aipl6wyXdKb0nPRr/sxWks51Pn+9WnWIH2t5
	OcHf7vbHt+dqEMg0/FpfHot2cYYeMiQsdQA==
X-Gm-Gg: Acq92OEbuq/NFhCMjwfli3hVpmV9LrW0gLKdGzaytp3P5VC3XnBgnZv/j1rNJAIeNRg
	IguwU8z4O8/2s4XHx0Hh+Amk3q3JvmcaeVlB36yNcpQY1QyEyv+nW8zW2i+vJwYg98iLxjNYhD7
	PaVee1AucjUo4CeCTbztHpvNV0l9lF6P24VztQeIGBZYrRq084tvJdLuvbBKWN6AB69zZfpdwzy
	HHIFfuHefydeQCWrATUPhrG0iXNZA6/8Diu8BHjGIU4cORZERUjg8HatO7KIhXhVNlta8JiDiSV
	cc4lkRQM8X1EECRdKQ==
X-Received: by 2002:a17:903:4b4f:b0:2bf:2398:6009 with SMTP id
 d9443c01a7336-2c10ccbc173mr41028205ad.14.1780424615961; Tue, 02 Jun 2026
 11:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601141552.191733-1-stephen.smalley.work@gmail.com> <20260601141552.191733-6-stephen.smalley.work@gmail.com>
In-Reply-To: <20260601141552.191733-6-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 2 Jun 2026 14:23:24 -0400
X-Gm-Features: AVHnY4I5SOM0NF2bVc3UzMkIkj2FOr0XGVUsNnbanOlHCuRpbhseo7SPx-hstF4
Message-ID: <CAEjxPJ4KYNupw2j+zYzOijEwfdYHz-LR96J2scPrUtmKp8sg=g@mail.gmail.com>
Subject: Re: [PATCH 6/6] libselinux: label_support: move digest_add_specfile()
 bounds check
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 10:16=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Move the bounds check before writing to the specfile_list[] array.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series has been merged.

> ---
>  libselinux/src/label_support.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/libselinux/src/label_support.c b/libselinux/src/label_suppor=
t.c
> index d7636f87..ea2402e4 100644
> --- a/libselinux/src/label_support.c
> +++ b/libselinux/src/label_support.c
> @@ -201,15 +201,14 @@ int  digest_add_specfile(struct selabel_digest *dig=
est, FILE *fp,
>                             from_addr, buf_len);
>
>         /* Now add path to list */
> +       if (digest->specfile_cnt >=3D DIGEST_FILES_MAX) {
> +               errno =3D EOVERFLOW;
> +               return -1;
> +       }
>         digest->specfile_list[digest->specfile_cnt] =3D strdup(path);
>         if (!digest->specfile_list[digest->specfile_cnt])
>                 return -1;
>
>         digest->specfile_cnt++;
> -       if (digest->specfile_cnt > DIGEST_FILES_MAX) {
> -               errno =3D EOVERFLOW;
> -               return -1;
> -       }
> -
>         return 0;
>  }
> --
> 2.54.0
>
