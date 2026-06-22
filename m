Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FDB347533
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 20:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159825; cv=pass; b=B8S4tCtcqIqxT84TxfdX57FZP2NIvU4/2ycB6LlV0ZHhUP/M5dpsiQrmSSoMm/5mJCMyWj0L086H1n0kATVhXZI8/kmny0nBe/YaFST5EVGSn0ipZqzVzG3wUKRYTd0+j4+Kb61NMBmh3xub8tIkNs4X3xitYujaSNxbtqGUzRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159825; c=relaxed/simple;
	bh=lNmrrzsCfZ6JhDrQ3HBtYlsrphSnmnCHjaGFRk2VsAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/ppr7ou0wSev6fLXPO7Ij6r4mDZec1mbRCvMVnFLi1FgOTJoQbttwFVhGVFaRw2olUQ//0HYoN1vjTQhKGUlGNikSN4DcxiCQCIyrE/usSfdRnaeahCEE5ovfG7KUV35lj0CIDUN1/dfoaG9g0qjH1+pPvfnPlcNxelt34MBTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cygWtTVH; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cygWtTVH"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c88b8fe9059so1829975a12.3
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 13:23:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782159824; cv=none;
        d=google.com; s=arc-20240605;
        b=B3UW5P5L/8SjZNCokaRQbroddI0k5nWzvNjokj8RlZ0Hp8f6JHynIQbPg+sqW5wJ8g
         Jqz8K35ysQqbmwWb7rx8oAa1tF0h+9AjjiMCiq6IYAw2aDLhETXVOYSXMhcZR2cY+HO4
         TD0DnESXZIShrNxYP7DYQd3WFIqWEo9B+qm1rWzGa+AgVmsT8v/QrNj2U47nIHTE7+yE
         ho4WlPCepIjs6ZZt9YCQPNkl1dwbsTFU65R+evIU/taKStvujHonS8Q9dHuFiul5+jvd
         YgQHwH3zOr95Z9UQewtFcWaRegGb1J3Xcnw7YpyOiKyrxl1DC0J2gy6gmBk2sx8Xoe4x
         N50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gdR9VzzkmFf/F8L0pqrdjoOWWGuLryGuyP63j2MPt3A=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=Xes4j9YA0I2m7IwYjM9o9SjoppKUgJpCDKjVcYO9vnSu7YAqrdbNUxKBIXW+tcpCrG
         JRj0npTEtcuJxhTxCwwhOPO3Kas/WtT+eZ4mZruu8VAi3IF0JpnKzDe8RjkQ4m+HA3+L
         ocoy6yb/LJZThYcvXJCisVhPY/BTunlZv1BItpa+xbkHAMM/Y7xdk9XuxXoSuJzKuYSA
         1WSQ7vi+/FKvKCf+psQPYMbxp23p0b8A100xlSnhWiFpRDJdPAawiMVhwD29+Bcyh510
         6VkbDBpIoeqvm5MxxByIjeSkEhxq2q8XtR7uLm6XK9NuFZusiga9KXZduIQRbq4HrYPA
         HfxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782159824; x=1782764624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdR9VzzkmFf/F8L0pqrdjoOWWGuLryGuyP63j2MPt3A=;
        b=cygWtTVHzZXALIWx4nhW8t/1sm6s72WncMdn2DypeI6zQQ6JnImZxkeO3HPpQaB36w
         nQlxmK/MSVnUhzSYLWCv5DTsrLI05VRkueTbD/pycSwqBefjZK7lSOWjoc2U1SHlfU5V
         ro2KSgIhnZb4g8bLP4eIzelHJrtRpxxVWDglPW66wlF/CK/RYAK0O16Wdo92lihOdv9w
         hNj8gvVcABwgW4g98VhqcUGaK1OnoyThP+B9gQITawsCWGO1831/B2leB/OYEGoIc0It
         hU9FvF+/IvoiAd5HxMTrwVSYt1zoenV/0iZFOnLzqU4w7X9WMy9hfBKO4EXPHEVBaTAM
         ACog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782159824; x=1782764624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gdR9VzzkmFf/F8L0pqrdjoOWWGuLryGuyP63j2MPt3A=;
        b=GmBz/gDVHYQScVvSMLBrPTmlGuPRfoUbsvAERyr0LI100WRlHktP6DAqfCIdWDFHAw
         pzdCQ0j6Xtyf1tyfX3Bhqh3VvKID4ijhC59+fzUjjxR76aETlIL+DR8c6zDndQhesZqT
         lJvdlrmtFXxNFIScYsaWY1rG6NVTdNYJon/vsSULP5E2YHt4/r8kaFqv6OMRDTcrdtZI
         qHeoAoRJ4jeoFk9PJKqwcy6fh5F7KIq7FvyQDd/irLHxa7GXV+UO/+FT5JbnwqLTunjs
         mzAvcnXtHWUX5jbEoPLjyX+GKeb3VVSlSHkGFP90emHs4tL3TNZDyDzUNVgpqQY1WsHT
         Wlqw==
X-Gm-Message-State: AOJu0YyOhbvdjuYHFfM6lpqgTLXOHAXbX/rgAxszFRKDw/tHPP5KmAUf
	rNjzp8mhQ3hWRGFX3SPZGn+G6GNbjW7yNf2WsuP9DemRr0qfaO2wjXqLZZilgI32+xZm+nzDdAT
	taVvGDLUNt5TyrxhZV+px6qgn25MPcJP0Fg==
X-Gm-Gg: AfdE7clBglsbAm2ZPbu1hMWTE8RBuJtMXLL2ti8CcFs/kMrnnG3vcigwWcRvCG929Z0
	n10kME36t6bLP87aqRKRI3GtBtOsgILijKDmUKc6sNyaJx4upCSdgLUD/mYQPqkxuQNrwUmS30Y
	TqyxUAG/RGF7GD2rzCZ8JbDPN+WP3q2OdFi6Uc/SCGt+C3DVDkF/0PsWJZm4ndHci0s/uXOyn3B
	Hkab0irrsPWfqjKnEO20lEawHxeV1YqJjBOoufQLacYAg9C/PElnw4RZYMdCQa9kAz+Jm/JcGtV
	jADRi3A=
X-Received: by 2002:a05:6a20:2d0e:b0:3a0:c325:aa11 with SMTP id
 adf61e73a8af0-3bd1520149fmr18484637.34.1782159823693; Mon, 22 Jun 2026
 13:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622173541.174998-1-jwcart2@gmail.com>
In-Reply-To: <20260622173541.174998-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Jun 2026 16:23:31 -0400
X-Gm-Features: AVVi8Ce2nzspVvVRFmoJ4qMZDQw1-tr5Gds3ObMj8q3DOyQ0xQtNg9tElkbJlwA
Message-ID: <CAEjxPJ7TmU5LfZEpNY37RarBDHcW2JHZLq38AbqBBp3XFpDP6A@mail.gmail.com>
Subject: Re: [PATCH 1/6 v3] libselinux: Add overflow checks
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 1:35=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Using "*=3D 2" is a common idiom to grow an array or buffer, but it
> is possible for this multiplication to overflow.
>
> Use the __builtin_smul_overflow() function that will do the
> multiplication while checking for overflow.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v3: Use __built_smul_overflow()
>
>  libselinux/src/matchpathcon.c | 6 +++++-
>  libselinux/src/seusers.c      | 4 ++--
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.=
c
> index 2623e5dc..80de61a0 100644
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -117,7 +117,11 @@ static int add_array_elt(char *con)
>         char **tmp;
>         if (con_array_size) {
>                 while (con_array_used >=3D con_array_size) {
> -                       con_array_size *=3D 2;
> +                       if (__builtin_smul_overflow(con_array_size, 2,
> +                                                   &con_array_size)) {
> +                               free_array_elts();
> +                               return -1;
> +                       }
>                         tmp =3D (char **)reallocarray(con_array, con_arra=
y_size,
>                                                     sizeof(char *));
>                         if (!tmp) {
> diff --git a/libselinux/src/seusers.c b/libselinux/src/seusers.c
> index e4a844df..310b1e7c 100644
> --- a/libselinux/src/seusers.c
> +++ b/libselinux/src/seusers.c
> @@ -114,9 +114,9 @@ static gid_t get_default_gid(const char *name)
>                         break;
>
>                 rc =3D getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent=
);
> -               if (rc =3D=3D ERANGE && rbuflen < LONG_MAX / 2) {
> +               if (rc =3D=3D ERANGE &&
> +                   !__builtin_smull_overflow(rbuflen, 2, &rbuflen)) {
>                         free(rbuf);
> -                       rbuflen *=3D 2;
>                         continue;
>                 }
>                 if (rc =3D=3D 0 && pwent)
> --
> 2.54.0
>
