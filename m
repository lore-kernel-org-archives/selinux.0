Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8DE2D8DC4
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638086; cv=pass; b=sj0uskfM3x2DimpiEdFwpbx5tfSETJwNcnTvUUlkxEf0hdsGQH+WwcnyooeIJNK0uCgcXl4v3DhZI73VKxZxavv7kY86zLV+AQeprk8fKlq6hMR5Vum6mfx01g09Hd+PogAmVAa0eq+/3c3fs/wXpAOnBSBNiK57uE2FsWs0WoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638086; c=relaxed/simple;
	bh=Rr0nhqgkpYfWgda+y5VK0+LuHJf8nWYzgPGOQ1gpp5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSLFHxUqZuIn6LOmLc9ZIfNOSeQxxTTulQgWXErg5sjd4BO+wFK3aPzBeWaCdkt8QAEAJDsTevOH3OMppYQP+KeYTUSmXajxTNKY84pRUgQ+hofEwxRXKDU/Wu3jPDO0pFE8KvHtKaJ37C69I0RCN1dNGED0iykA6JLXbaptths=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0OTs8xD; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0OTs8xD"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso7520087b3a.1
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 05:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784638084; cv=none;
        d=google.com; s=arc-20260327;
        b=HgGkssSiHw0+y5Y2rsD81aeq2sFCU/HFkTx+uOiyLs/2Qd9S/Xoxwd/xg6V51kcRUM
         bXm71bLZQVBGJZ9IRLMKsMVd59Sha5YsYcY1X7neIaw0LQ7HGjv3jJrclOCbEYnkCtpY
         ScT6IIbvLbzXG/QbXYFJyDwoKw2qLG6Er/jY3+tPJqh2qaPIqlU46B7iOaB2vxjmvF2C
         G+ZgHU4Ja2QYR36xywuILtalo409vIBM9+7VQLzh7/2e28pQczcC7Q05pZLwZLjvGiU0
         dLiLHFhwEfEmF0jHVA8JfX9APTHpKAZDu3St2GuqaZ8AfKGdXQ0hvbpXSiI2s0Ia5iO9
         FGAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8fWO7Yu2R7r/+U4Fpoi2090wUEb881HE/h87W34i2r8=;
        fh=gfzHzywM79Llzpb3oUi4mMfwpHTHBNavmzg+APAH/VE=;
        b=s4LJDaqu3iOGlpm28cQl8IKR/dN6VSvFhbxXyvglS3dgQt0zSYp0aHg+aeNXfeKI4X
         X3HC/5epQf4hES1aXuPoQVKehTCHSAX3Nhqs+spWJEgXNVkHZWvxbDC/FclX3Z1o8dNl
         qM8OJCrXKXywK4ibtjM3O5r+CRYsF2mBjGT4FceLiUXgysNF4I5PUtcLhrfYuyHvfitK
         Kn0br6cEsRsMT74chqzxeS5emYOIBh+ZKynGFrXRbM5HaxPEcXnhbwRzpaet0DhBnYiQ
         QRwJsi/SO8VHnSwY27J46JDWSZAFmErFO7DTDrex8zA464DU5kZKyCTjGkV/SkjwDTY/
         eoPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784638084; x=1785242884; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8fWO7Yu2R7r/+U4Fpoi2090wUEb881HE/h87W34i2r8=;
        b=I0OTs8xDzhLRM7d2cBkM7qMHL9Pt4CFR37YEmnIp5+c/ng4q3MHQj9yEYFNYWL7eIa
         Z4gTNGWEQGaKraKBILzz0VpJ1DlErAe8eLnl0Ptm6MxkCrM1unkh2rxz/FbOV1w+81qF
         HROKV0zzQqO5coznQ/znwBX5m8bYMeY+gFUIR2GL4XmhdS0g/3HdgddRRhkiWorFLKOz
         Hup3C4lHFAwni7guqymAZ1TWHm2bIhAqyU/GgCnmcO2EkczAsEkoaDldrOlK8og8ErXw
         bWUe5epkiiXNb55tasd6LcvFrcc1YF7Yykdawy8bdvHKU3MgmXA7bm4uG16EJLO/gK9I
         mb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638084; x=1785242884;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8fWO7Yu2R7r/+U4Fpoi2090wUEb881HE/h87W34i2r8=;
        b=kduKyritrA+nImf3XhGfe2+Y/Aj6NoQs1nQ8r/o6KMiGFCr7FEcjO6NLxq/6+VNtMb
         HxxUXUCaZbRW2si2YJpL4yBWSRlSiZjo63NPMpjC7ZDNdo5tecuGDo9Rc1TO0lNzPu9f
         32vNiak3cTVaq3MoyuZ5vjzSF2Hftn6ltyKDX5nBmyun/5GX/YD4du02kwQ8swOtsam9
         TlLwaA2YO2rNSIGVSQQoTy1IXVXnjhG5XaDgFXQq0cJyKdX0io/IRG+hJXkrNbH75Z1Q
         s3mWuwBJRGD0S2/NMVp3jsUY6Hz/2XJRaIkBvPHDUQgxPL7Nq+XYnGu36IdVnP4dpTgW
         /0ww==
X-Gm-Message-State: AOJu0YwmAeM+w3p4uWhnPhHiYIbq7Tz2JysnJlN5CKMWNL414sdeCPVY
	9VbnYh/w27XuajXiuozZ24GQCQCCKVr5kawLNhMQGfWX4/0/wBy7F25a+Xv8XVqT17Mh8kIPugn
	PGut8PPTISEG9QSJ7HxEFMvAYwN3O+Pqiuw==
X-Gm-Gg: AR+sD13otW91iY9vw+EmpriH5b4pT2FXyEVYR7cQ3CaujjkwMnsfS3n1sHB/0krQ2g2
	HWrKD7+1RY0BjK4YW2IGOp7C//CSEXtnPgF1GjtCTMn3G6K7TvWNk+VmKM1Az0AgZfg1Sxc8mCl
	J+ocawI3kRJuPL+pTyqo8oThZCBBIfP4G75ap7YwWhBc5B9C0hkY3pQuGRpaSrpDwrPynxl2n4J
	PFyLydz2as9tj1Rl8JXJxi6d9y7PptTgMhrL46Lz9byI0Zdx1N3FSrTDPZoW0plUunDfeIq
X-Received: by 2002:a05:6a00:b95:b0:845:dffa:3740 with SMTP id
 d2e1a72fcca58-84c292391c1mr16813000b3a.4.1784638084518; Tue, 21 Jul 2026
 05:48:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715192309.46442-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260715192309.46442-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 08:47:53 -0400
X-Gm-Features: AUfX_mz9wGNcQ3J-gxrbvNG1UFMgdTCs_8FvZe10wwQSzergE_GMBbnzVHV1-dI
Message-ID: <CAEjxPJ7tpdcw1XPFX7XM8hLzwYrghJQV6HsaanDDPptyo_FkaQ@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: direct_api: clamp write length in ERR_CHLD_STDERR()
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 3:23=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> snprintf() returns the number of bytes it would have written on
> truncation, which can exceed the buffer size, and can potentially
> return < 0 on other error conditions. Clamp the write length to the
> buffer size less the terminator and only write if snprintf() actually
> wrote bytes to the buffer.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  libsemanage/src/direct_api.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index b87b87e7..6c84b23c 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -618,11 +618,19 @@ static int read_from_pipe_to_data(semanage_handle_t=
 *sh, size_t initial_len,
>                                   "libsemanage.semanage_pipe_data: ",    =
      \
>                                   strlen("libsemanage.semanage_pipe_data:=
 ")); \
>                 n =3D snprintf(buf, sizeof(buf), __VA_ARGS__);           =
        \
> -               (void)!write_full(err_fd[PIPE_WRITE], buf, n);           =
      \
> +               if (n > 0) {                                             =
      \
> +                       if ((size_t)n >=3D sizeof(buf))                  =
        \
> +                               n =3D sizeof(buf) - 1;                   =
        \
> +                       (void)!write_full(err_fd[PIPE_WRITE], buf, (size_=
t)n); \
> +               }                                                        =
      \
>                 if (errsv) {                                             =
      \
>                         errno =3D errsv;                                 =
        \
>                         n =3D snprintf(buf, sizeof(buf), " (%m).");      =
        \
> -                       (void)!write_full(err_fd[PIPE_WRITE], buf, n);   =
      \
> +                       if (n > 0) {                                     =
      \
> +                               if ((size_t)n >=3D sizeof(buf))          =
        \
> +                                       n =3D sizeof(buf) - 1;           =
        \
> +                               (void)!write_full(err_fd[PIPE_WRITE], buf=
, n); \
> +                       }                                                =
      \
>                 }                                                        =
      \
>                 (void)!write_full(err_fd[PIPE_WRITE], "\n", strlen("\n"))=
;     \
>                 (void)!fsync(err_fd[PIPE_WRITE]);                        =
      \
> --
> 2.55.0
>
