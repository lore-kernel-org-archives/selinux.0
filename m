Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A083644CE
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670971; cv=pass; b=dUvfIt7KZCP2A2L60Sugq0OTE8P8tO3GDrFa0rxsqAWN3XuWoIPE+PFOR7o40KKjDyk/8fcH30sQrycPSGtBn9XTuZQDqDuqNADBlD4A7LmHOYlkY4jR4DhIbRJ3pQZn/BKyG35N0PAPV/4fdaVGz+Dx4HDEiXEpixr5cy9PIbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670971; c=relaxed/simple;
	bh=gksZi+4NkfaCr5nB0WnusA0BMQS9y2I1MSKNkiu95VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7qvnKq5IgsSTmiDRDgGoP8GRiT7fzA4PXRBZu9wedwOJIm6Jl/zCaTB7OR67ITV2CvUiJn+ywKGv12LHhnGRyGRYKLT3AB3BSegflDXDnbjlf8Uim1c9sSEJIfXoXIqKQ2I1JVLoUDuQv7ATCjWagZ3XLfVLZqWIUoYakUxeWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Enb41kvX; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Enb41kvX"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39664fe2dd8so17674151fa.3
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 07:49:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780670968; cv=none;
        d=google.com; s=arc-20240605;
        b=EH79CMEnm1342Gf3h3CkvopIbRN3ykZKQZvM5HT+4DSOiVdCz5h/Qf92PxZwJPaBoJ
         IKhV8gE1m2qBu+CqS1c0lq4Zb8GMy0JrzgvL0DzgAdHdPkDu3YbAbDm6qoJq0Q4XvTJF
         CFAZzfZR/shw9xMr34lTJMYhPkq40OgyXqJeQgLaLOAw/x5n8dnivNM4erBMRo6AthsF
         STgDMYN4MoV/6cD4BmfAs8a8QNL5bYah5jkCiasdQt+qsH3SchvefcV8um4N40Fn2xQS
         fXwvIv0omGykuQwbWrIY+wOvzdUyo9vMr33AIkeZbFtJLIXOzEiJFEJVZnXKQbQIj3hk
         POPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NUMOum2fL7xif1Gwt5G+zDzURPysHFHph3PHzwyzeqA=;
        fh=biLNIbUdiVI+HWgqVoISrU2pQus1fZiQi7u7sC8l6as=;
        b=C2/KCwY8S9sqg2HEayYrY+RuiQ9oNkGtPjTpR/4sDtSJTP6gnE9hMwe+9lp/c2yX6q
         pJEtOwG3CYiQEDBWexGb9IJrmFcANqc+p6QiasIHmwuTvNq3YIpYErEsBBTkZVZJVsJR
         5wIsthEJSYma2c/ayB3b9OkRYfa7Q3FEOdds+qD2xiAMuJt/t+6A8DZCnLgLjK8cE+cI
         Le6izB/WxLXvyddfMzznSD9LN+OTMZUheWFb6YuwSlz0ee5bx9noekkJV0zU1bUKzZYv
         2cHSAxvMiAwaLVBfFiFgUNuQ4fEYfGYhuXk0OtR6jUWLLvt+hZKNOydUJO6YDvqlDkG8
         jjGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780670968; x=1781275768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUMOum2fL7xif1Gwt5G+zDzURPysHFHph3PHzwyzeqA=;
        b=Enb41kvXrrTJz+K72bRMhlGGHsfDpvoCa3oLtRKrGxXaZD2F04UCRDw024lfkbfIEU
         KnDarb7bUqKrWxCQBpNXbxVQyVsXh8ir1fysW4vM1jPh1KX8JpDHgpbvtof4g3yez9WO
         DicFLN9LBN7kZgoydd85UHgS6Ss9Vse7lSGzJaetoHK4Urmwiw/YFm/gQpRxOOaPCHOU
         gLkxAfDb1KDJx4VeF5bnBJ9Ih+tRV78m/XmKKurO5m8DhAgQ4FBOXT+v7rC/BCrh+f6f
         7JQPUOlAm0wT4KwFtqguq/4/XU+r0akcDobKoQDuak3UBYkNBercshqusdN5wqyJMCdg
         Yi7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780670968; x=1781275768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NUMOum2fL7xif1Gwt5G+zDzURPysHFHph3PHzwyzeqA=;
        b=EYmx4/djLlj3y1RhOexcZU5lVM4fcw/tCGUY0jgNNr/GwILDNgOYZZocoxAVckFibj
         HvvYPhVIT7gbo0UR93/mWUd/9bwOUBoksfs5cmIy3+l3IUl7Hf9FuF9gK8mBskJ8AyFd
         pGMi6Jlk3qDXJ5NnFF4rzy9+Z3nKztDzkniqesVy16jtIbytuMC+b9xIdwhYHzbXv5Sv
         +/Zidy9aMCAIqAm/gSwDbrcOTANuhzkGoZPXaKoDHv1jmHTM5wjVdnqn270ytLM68EAb
         tM7lof44fWYDt+owZ8i71qRa9WA9BN6WJfc3WAUiqxZTW3YsX6od3iy+LcBONWask+yB
         R6Dw==
X-Gm-Message-State: AOJu0YxKQHmn3WHhM9IpjcPODZPuxVd0ayfqblzlQr+j/1srP2FBkzAk
	PR4Jfcq7SczfwdHJWKm8aaaVUMMFqwIdlmASuz8tBqo1OsM9yKFclTonfjDuS4Zw9mBuRTAYGOC
	fTvFtRsDXxFkPEBvoJgl+2dXjQzesZaA=
X-Gm-Gg: Acq92OG5mMp3yw3TxiUTHkusWrkTzGydNSwka00N/osvwp2kpoG/FoZZhMdaXpKqiNC
	dVAsg3pXjievoqhWTUavDSAIIbtFgBqtoDZWeEpyWzSFKxX+D2SEc/veT7UXLJDGIigCzdK0aIY
	s9hMgspVveEIyIIDGU3vr+ml0PdJmYtnX2SKf/E0BWc7XF671vDD4Q4MpKdbGaQ0GrFdWjWk43v
	cMj895bNpo2jUEH2S3ckLtYzof74E/+wBytRWvdcpMHo7tjMLoNE0bsP4dUMm93aBIxMK1Qa0Mv
	fdvwZj4scMwpW4U=
X-Received: by 2002:a2e:a555:0:b0:396:ae32:852 with SMTP id
 38308e7fff4ca-396d0895336mr12068181fa.18.1780670968385; Fri, 05 Jun 2026
 07:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604175258.264439-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260604175258.264439-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jun 2026 10:49:16 -0400
X-Gm-Features: AVVi8Cdgmh8UTs9H8YYUCqGDAFl4FsvQrdA1ov26X5dd6mrNWQCtCx7n2lp9zVE
Message-ID: <CAP+JOzRAP+eeamszsP7h5=H2VYhMu2LYkSEya0M22k0DDV+ukQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mcstrans: fix glob() error checking
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 1:53=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> glob(3) returns 0 on success, > 0 on various error conditions.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  mcstrans/src/mcstrans.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> index 15c2d76b..e0593c76 100644
> --- a/mcstrans/src/mcstrans.c
> +++ b/mcstrans/src/mcstrans.c
> @@ -854,7 +854,7 @@ static int process_trans(char *buffer)
>                 unsigned int n;
>                 glob_t g;
>                 g.gl_offs =3D 0;
> -               if (glob(tok, GLOB_ERR, NULL, &g) < 0) {
> +               if (glob(tok, GLOB_ERR, NULL, &g) !=3D 0) {
>                         globfree(&g);
>                         return -1;
>                 }
> --
> 2.54.0
>
