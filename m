Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2494416D0D
	for <selinux@vger.kernel.org>; Tue,  9 Jun 2026 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781008011; cv=pass; b=bF1qoRPmx3clToS5plbDZxTAfdJVkfKoiQugS5VSovSku1vcdeoMSltm0yM+VMxEr7w4/vXcBZzGX/AGqOMefGoW+NrimHNvYcLPTb9mQhVGcFUf0RvTI5iGgwWpPxhX6c1OnqLPp8Bj4jb2XIjTaG3y8HYVQonlPE78iUnG6ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781008011; c=relaxed/simple;
	bh=3Nf440ZZMjousYqpdzgBikJk6uhZafmz9Tl0ozwPf1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n4VkOhtRrfbGWRdb5OpHvXBUDj16/ciQWfVNSa4j8NevGlwXq5RVSjTNEGxaxBFjdPdf3HGxI/M7cigkr7ha/S+NAPg6zSjmh0R//aHqs1ebwIU6No/A98PyKXDe4CSbWrwD5Pb+6S2VAEcptXbnoEudgK4fhkYGwgMt+dB1CFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeB9OKEd; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeB9OKEd"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c857fba35cfso2614289a12.1
        for <selinux@vger.kernel.org>; Tue, 09 Jun 2026 05:26:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781008006; cv=none;
        d=google.com; s=arc-20240605;
        b=Hg+g1T+bXhFlJ4NbaUUeQVYXK++3YL9c0xE77yVsbYe47LMr9wso+lmrtkD/DEErOO
         yGcVwho1BWOQdZqKRpyzV2lQDARlk1sQYkP6cPWi5RQGkdRhcgTxk1iCEyeO3kcvxqmG
         4gMiI6aUH479ThEUYoHJv2q4aMlsqXdRDL4trt/YhTZ9zLo3uzADDJdE+kfBUwwDutgF
         mB+5U2BZ0c2Y9ad17iPyDRtsaI8Xhni6FU0x23AElrii82RyvEg4U6G2/pcicF7Fv8wF
         6ptbjflUcQ2jFlLxF1XSLBFI1TZHDhOZKFAA01RkPT91grhIwFoTP7hQAPQWOS1zwZ56
         gr1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I5yxz1KG9EyP6T/B1a6jnt/x73hMEMeABdAJjgG/tsw=;
        fh=QQk7xFMdTzUjlfMi4L/I6pQyTVixrjBqplr1l0H/wzk=;
        b=IMPVpqBApatSzO8p67v4cWp/ndOhiee0jGX4JZtJra1Y8z/qXLAFeg0MxC4dejYonc
         H2nN37YARKqRO6zP98fhN18MVblika65n1JODqP2niYlqIUuCjmpwEZOKwsdeSY+pNSR
         xiosPQqy/D9L9ra56R9z83onakHf0J0rorU/4NouMUoo/jk29bPOnHz4HE4nmRVOxnj0
         8E+dLSgoxZAxri45fbTb+pGyFqle+ic5Es9VB2ps2FXHoWz6uW+WSn9oVXdP+eA0vjFh
         9bcI2/ytmZuKx67yBFaWK8qlGUqZHRtI+OBm+FO+V7odJvppjT9LjsukmTvfAVY2wSnp
         rznQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781008006; x=1781612806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5yxz1KG9EyP6T/B1a6jnt/x73hMEMeABdAJjgG/tsw=;
        b=KeB9OKEdhKmmCrJxYvhP9JMRr2Y5T7VUpeRPPhPit2jed2Ypeddv1ZE4uv87q9NKhO
         E5x8plmwETkbCUAgjOMgZfIarxmagKVIxdTXT992rWNNh450aIfxc/9QN9rmKqumZOCf
         ilpaLd3YSI7jTONDhbXOJXd8ORG1uoNz8nyM6aPc8RWAN1Crrz5b3ILyp7SLi+tmOKVS
         UE9ubvzFtuu9wFwzuDR0djnpqLcoMPqPtNoOBN7t9vwCkoTIdkDTAoDCCeRP/WHDkT86
         gflF4Cv501MaUz2y1ZjTiHbfHcZZq4GkjC28JeB1g2obyFtI7tLyZfk3zjiy1Ql/bATH
         PIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781008006; x=1781612806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I5yxz1KG9EyP6T/B1a6jnt/x73hMEMeABdAJjgG/tsw=;
        b=KDvw4q8+g3TZCH+urxBSZgXH4HEZvJwHE8IZYwWMxpDpEZZ/IwoU/3o6kAr9CGGqYW
         KW24jbCqxMnKGWi4OhmzDNF4K/ZnjQ491JpBLKZ6a8sAz5c/m4syMFsXlBeqVoF0QN5O
         mDix8q30xiYpfuQTPSaz3ShIgaOr0FGkrtQujAMNf4Hl2DnJc+nJ1HRLPo6L8MQXvMqc
         te+u7acPJUI49Fz3ip5h0KoLFivU9qarg5ylzJ+Q7rWRPi69CNSOqaMihtsYkTQqedQT
         aVln3Vjh2GXT5oK3ywbvYncDuDtXeXzT6kCY1+DQt5URwTBlyCHssYv5rZxpGi9b4GVT
         CCyw==
X-Gm-Message-State: AOJu0Yx9tUfJJKHfDkz162wNwFlIwYwqU73ThkZ/EQbHXzaBHi+ioA9l
	KA76uWDskrGUUfKZV3Ld/CV5AXcNbuVLgClBJqGj4cVTyAQi1TBIf8xPDu1q++dLXltve5dhvuR
	OvC1gM+eKUGnCj6RFJhAKysu5gTaOKfU4fQ==
X-Gm-Gg: Acq92OEJiXGz/vsGo6m8roXD6TFW1nrDFC51rtX6BKaPMkW4AFY5aW9DLQot/Br7ZY2
	70404ZGxdxPLQiUqI7xivBlHEVYBscaZVuKcxLWj0iMOqH2+8UmTYtJ6l5URkcLwr+MsZKG4vrQ
	Ige4ks+qade9Qu1wq5sSzbNeoCFqlhAiZWorPQ1Sp+4P8KHXKsjeY8bTLSyBJGXX0hSp6GptxgJ
	XIcmLrPhbn/hvPuopGeIK0FxOTz6W+ybdMaDJ9kkTHxCO06Ned5FLIhnoBpYLpY/eMEogH8jHC4
	pNi8oKgDUNQZNGL+jQ==
X-Received: by 2002:a05:6a21:6b8b:b0:3a3:327:c5c8 with SMTP id
 adf61e73a8af0-3b4cc9b68damr25925110637.0.1781008005859; Tue, 09 Jun 2026
 05:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608131614.308870-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260608131614.308870-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 9 Jun 2026 08:26:34 -0400
X-Gm-Features: AVVi8CeOnYys9CSH25_jYBwJ7qkKFdvnoiDnLR9t6RguAQ7QKEpRLoYIcGQoZwA
Message-ID: <CAEjxPJ4GhkV9hSDwR2uJ3VyrHes=1NJspLyM3yrcvVXkBatHDg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: restore: drop the obsolete LSF transitional API.
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org, Renato Caldas <renato@calgera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 9:16=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: Renato Caldas <renato@calgera.com>
>
> The preferred way to enable LSF support on 32 bit systems is to define
> _FILE_OFFSET_BITS=3D64 when building selinux.
>
> Signed-off-by: Renato Caldas <renato@calgera.com>

Minor typo in the description (LSF -> LFS), but otherwise:
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/selinux_restorecon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 10807867..0159fb7f 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -487,7 +487,7 @@ static int filespec_add(ino_t ino, const char *con, c=
onst char *file,
>         file_spec_t *prevfl, *fl;
>         uint32_t h;
>         int ret;
> -       struct stat64 sb;
> +       struct stat sb;
>
>         __pthread_mutex_lock(&fl_mutex);
>
> @@ -501,7 +501,7 @@ static int filespec_add(ino_t ino, const char *con, c=
onst char *file,
>         for (prevfl =3D &fl_head[h], fl =3D fl_head[h].next; fl;
>              prevfl =3D fl, fl =3D fl->next) {
>                 if (ino =3D=3D fl->ino) {
> -                       ret =3D lstat64(fl->file, &sb);
> +                       ret =3D lstat(fl->file, &sb);
>                         if (ret < 0 || sb.st_ino !=3D ino) {
>                                 freecon(fl->con);
>                                 free(fl->file);
> --
> 2.54.0
>
