Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EB0347533
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159855; cv=pass; b=noGsSkFisGZfc8vaIb/fNENX/iqH5QdcwfNoa5DQzXdRW5sPP3OszaMJRPW+33GabHRqSAmMmfUJtOh6MC9lT4LEUxQIbGy+HWhGiVYAF1j8ScFMTfOosATp0AjcQaSy48XsX4lKCNR3osRsJU7pJYSedtHZOZGOIELjb6Bl9FU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159855; c=relaxed/simple;
	bh=gTK8lUlG6HJaMmd1qEZer10zV2hW8QDzupFznnKBvXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YK1lCyoa+OYW0oLQ/VQUEECiYCVpdKkQxLMkJLS1oqq+9PR0mW+PdzOugDdyDCc2eJZLjdGcSfjlGiigGLpf/0AOyQkdHz1cJ8XN90Xqe6ZVBGv3Vkw257NtUDqaFR/a8MfQMuIHMZtNlEBjWASPb/yLNEsndOeOMJVR9v2CY/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPS8pf5H; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPS8pf5H"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c85a297d2d2so3263992a12.0
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 13:24:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782159853; cv=none;
        d=google.com; s=arc-20240605;
        b=M09EG4TwGefrfQ0y2DHubRP78pyMwpHlFrwoWb5KagdHPVVAxXC0J0F0Oo7tX6jaSQ
         kBw+evA4b0E0iiO3ircQRm2A5Mq3im/h4vS+ntEISQMJIAhjLvEt2F/PfEnfiHETZMBN
         PpaHCfqNO7lcGO3HkZ/qfv19JVZlCSJmbtvDj6QkDJqjC3WGM+hFxSVaz3tqZT86MNxV
         Y9VSqs4DX2n5s8NQuTAG/pepl1cfJsOPNmv/N3ahtzynNKVpwOxWYEfvP6RSN81qanNP
         Ok6Q42M5DcC4tZjMc0OaGj5MEgR75uIOiUd+2dLPht33xuD1eKJNonewheLWCYFlhOE8
         YxvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3gciXbTZll+d6bZFlEK7om0Bty+5kxp9LbeL4+y0lKg=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=XYNjDAgRtYW/8VeBf42I0llzR6AFCpLVI7bRb3+wFXEqdAy/txDjtQNQJQES6V8FWs
         3JV6qdrtxmR8Ss5Pq52+3aFUJ98ytcA4rJdaQAeNAWgUDRIFsQuMmGdkx8u8tcnViX/H
         ltj0gfBZ4791yLffalCH9EwlZN62pzAgHh+pUhJR1oaWfKN74roBSSndnoDSGzSfxQPs
         kZfYuwQlcgXQIKtCtWTdhCQ8MxK16xgAya64w8XHi6a0Q/akhdsveR5tdSbzMpvyxGP7
         fKHfjS+P2x1Wkf2Gb1GAdlSLEBG9uDdsGrEetIZ1NLKtqTgCCPBr/4pZBrvI4OkJ/yLr
         fyiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782159853; x=1782764653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gciXbTZll+d6bZFlEK7om0Bty+5kxp9LbeL4+y0lKg=;
        b=OPS8pf5HV2vl02cDPD+WqLHrOGlOuNr5HgQzrLJVQjgE62oytU5IWsgsLsTAQPPkQn
         PinbKwCnZJoa3p27EOaDPFF8cXjRRpVcmfrsFIJyizC2lQpHB6v+TG90TfFnfZ90WUR3
         xCiTqHhzFELTu2A4bErdS2Wy3YZSkL2PjM9x55Q75eq+lstclhPWsQu62cZ6aiQudd2B
         MT6hlI/eVk6nK2recdaI8fR1pfiL1BIaG55eoBwg3UPhPeJoGGM7dNKR9GiB4zpYUmdu
         buNwt373u/69M6X0lDpI+Nguxi8bsT4fFDNw8YSAaRhq3xHkN0JsAhN9++DJLJxH/JX6
         2ZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782159853; x=1782764653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3gciXbTZll+d6bZFlEK7om0Bty+5kxp9LbeL4+y0lKg=;
        b=U/iwzVQz5EHDYERJlmDtkLsZrFOE/uHOFnb0pPZTsXzLEARwfUlmOnRDoTZpcp1933
         gHpnPclaHlOifW4NDGyFCiPNcVyzmjY5Yj4VGeuPXoCq/4IdIaFXepqozos+5zJBKGU3
         t+71fOHRmd0C5tQkPhmlScVdS8FHqxzL7QNDKytdBEzkbcJ2zooPA2IxPg98YIPXvonb
         WVvHAG/gnXg8c7ieCiNpbjF+AD/qL6NDVkAV2wfKM5Xtyy4rsgS+OWCxjPIiuRCmn31u
         mThIvByDUOWhsr8DVdjq1P/ZJVJh64W4rla35XntHg/aZG0fv5fb8YobiK+UkQXxelpf
         2q8w==
X-Gm-Message-State: AOJu0Yy3sXu8CBDbK3k1YH8Z3jyq5FjamII1vCYrIDKNky449YOEnWoP
	+ll+CIQewcZmlPRN/1Uy9fuhMfYfQ0tKQny4NW/QqOVIpqUmwfpDyKM/Qv5FBb4rjNInRTG/LzB
	0fLUQgSwJjz+EDs1Tcft6i3hKdDU2jSlEvIq1
X-Gm-Gg: AfdE7cm803i/WxpPCXeugT5BYzU/4dUF5MlKnha+L5RGsxbQdAFB5IUl687YGSCLshI
	p+0XH5vRTQbkldKtlE92WZhiP++iObu5WPYaO/YggivYSnVawirwYnItKUEPXRHbXdiJsFTtNKt
	EdYlH1F/JLEQSS/Q2+mu22GTyKr+PPLzmCYJ5Dtm6N2IyF2ffyrxN6onR8pSTP647xRj02BJzLc
	hTiR+597gqoX6uKcqZvqG1uyFIXBixwwtp4fYFmaSyT6txW0wUmQVBamweMi3N5qyyUhbVv
X-Received: by 2002:a05:6a20:9f91:b0:3b3:10e1:a87f with SMTP id
 adf61e73a8af0-3bb3404306fmr18120748637.31.1782159853238; Mon, 22 Jun 2026
 13:24:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622173541.174998-1-jwcart2@gmail.com> <20260622173541.174998-2-jwcart2@gmail.com>
In-Reply-To: <20260622173541.174998-2-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Jun 2026 16:24:01 -0400
X-Gm-Features: AVVi8Cek9-MjjG-j8GPyu3qGXcyq-zgQok0a6Upx8FRGmBuPA5suCZ9VhYWhGw8
Message-ID: <CAEjxPJ6zy5m4XYFhrwbBeBNVGUAZbuH=bgy0Gvyb1shrs6WMSg@mail.gmail.com>
Subject: Re: [PATCH 2/6 v3] libsemanage: Add overflow checks
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 1:35=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Using "*=3D 2" is a common idiom to grow a buffer, but it is
> possible for this multiplication to overflow.
>
> Use the __builtin_mul_overflow() family of functions that will
> do the multiplication while checking for overflow.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v3: Use __builtin_mul_overflow() family of functions
>
>  libsemanage/src/direct_api.c    |  7 +++++--
>  libsemanage/src/genhomedircon.c | 11 +++++------
>  2 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index 9572dbf0..b87b87e7 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -588,8 +588,11 @@ static int read_from_pipe_to_data(semanage_handle_t =
*sh, size_t initial_len,
>                 data_read_len +=3D read_len;
>                 if (data_read_len =3D=3D max_len) {
>                         char *tmp;
> -
> -                       max_len *=3D 2;
> +                       if (__builtin_mul_overflow(max_len, 2, &max_len))=
 {
> +                               ERR(sh, "Overflow");
> +                               free(data_read);
> +                               return -1;
> +                       }
>                         tmp =3D realloc(data_read, max_len);
>                         if (tmp =3D=3D NULL) {
>                                 ERR(sh, "Failed to realloc, out of memory=
.");
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedir=
con.c
> index ce7ea167..f04fc127 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -1090,9 +1090,9 @@ retry:
>                 goto cleanup;
>
>         retval =3D getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
> -       if (retval =3D=3D ERANGE && rbuflen < LONG_MAX / 2) {
> +       if (retval =3D=3D ERANGE &&
> +           !__builtin_smull_overflow(rbuflen, 2, &rbuflen)) {
>                 free(rbuf);
> -               rbuflen *=3D 2;
>                 goto retry;
>         }
>         if (retval !=3D 0 || pwent =3D=3D NULL) {
> @@ -1171,11 +1171,10 @@ static int get_group_users(genhomedircon_settings=
_t *s,
>                                     &group)) !=3D 0 &&
>                errno =3D=3D ERANGE) {
>                 char *new_grbuf;
> -               grbuflen *=3D 2;
> -               if (grbuflen < 0)
> -                       /* the member list could exceed 2Gb on a system w=
ith a 32-bit CPU (where
> -                        * sizeof(long) =3D 4) - if this ever happened, t=
he loop would become infinite. */
> +               if (__builtin_smull_overflow(grbuflen, 2, &grbuflen)) {
> +                       ERR(s->h_semanage, "Overflow");
>                         goto cleanup;
> +               }
>                 new_grbuf =3D realloc(grbuf, grbuflen);
>                 if (new_grbuf =3D=3D NULL)
>                         goto cleanup;
> --
> 2.54.0
>
