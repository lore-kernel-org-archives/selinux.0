Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588C01C5F39
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676364; cv=pass; b=rJfAdy5R1F+7fS8Hw2kKpAI9xvw8lvZRbKBQm209hyRwvBJ1neyrQza6k7CIloGe6UCoIwfbdVdpZwHyUOB+2wWkJFKN6PTvZ4qcbg7r7iZ4ZnwBZ9PzSIIJ5O8bf/BFR1pGPHzaHk+MIkQveCEWV7l6o6Y+UdUSRNOqx2ICCsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676364; c=relaxed/simple;
	bh=F71FcaCJYvS8QjqEEUSc6c3VxOaIHXfM3mA5Xw9ULsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9ktd9vcXWLTdanvlWDfWapUuDdnOWCNMZ6QeQVlwUvZM/zEbgPg6TEQQQT3m7HlLkl5tJhFJBekw6dKsRS2W3lLSXpcI0mqPxadSeE1z+LSALtxQ61jkeu1Nvo/r7HHNDXA9mqWNqXp0CWuC8ziIuTIyOkbHJuOC42/6atR50c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIFuLDRh; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIFuLDRh"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8423b08b293so982697b3a.3
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 09:19:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780676362; cv=none;
        d=google.com; s=arc-20240605;
        b=DwlnXstbRmhZKpgRE6QisU5Bs8WUfYoH2SeqV1Qm4Ug5senk4onmabhnzotx0jkF0v
         v/CMJShLfh8ll3g0K0s7GGKxvE2TW8qW2nas7j6k9m+u2BM6q2ekgx2nlVbnSMsuTNKG
         uWgvZVsUIOfZnTmxIOpm/CfRvbv7m+sZr5PCYHF5AcR5GaUshNVeFKfxcyHJn4Njx7S2
         aJrmo5Sunjk4vAHBuPtGr9xQtbKexT5y1hRpQqVlXCB0i3JuuB1tIoUPHxxt8LLl/if3
         /h+xeF1QrDl3ErJyACbEGWVi1ExCso6ZuFNQgsS3Fa+NyBSRSrE1Ei/iFLgkDEO5xGZC
         ParA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NZaKYvocR3w47gM5Rf3uf90CrbJw2wh4ush5zpJABRA=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=GdNo7S6Qmi49FNkBaLPS74GNjAHFGsq+2/K5HNILUyl95Hc7tsAbJUb3eD558BOp2z
         z6OEM7UAVGjty1GIEZqYVeyN9iQ5ORB9KUdWwYPhoAFIxT5SPG5MNj8yLgTnkVsnkfCc
         VeGlim8iqr9SoLx7JmOXtIdeKFepn/yDY4YCYDTH/GWVhhsvhwCEXLncbXvepyL07Gue
         3dy/0fAJJEeJLSclwoxjA0dUa+QHT6Ny1Gp7We84wruSo/oG7TogODn5DeUBs73IqlVL
         tuaLVcL5HqMAtLZ90o8fTX3KTVlWRcxWjFjj9omw0lnmwUI+GPSNUlcgffE9KoDWGEmt
         ZkYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780676362; x=1781281162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZaKYvocR3w47gM5Rf3uf90CrbJw2wh4ush5zpJABRA=;
        b=eIFuLDRhr5oybAT59FMrShagaR1GHv70Tr0Lhsgtyf8cs59h+Hsh3cyF0DGlGBpzSv
         ahgEOnioD/NvHKxhcGBKPetBO7UdEq3VIN/M8Wh4lfqZOFuZe1WalExW4mN+GxmiLa76
         QSKNRaOFF9TAmpS7dZDMkyYXCqqvuivqun7pioyFlY6WIhaHhudQFpCDLhGqtIaxJT2H
         8ijTXJtjCfXooRNPUvzSaU0gyKKzTeGcbjw5NYv8qQFxGU2TS9GPNX+n3coRSfaPfN/K
         ALpcsqaAtBg5TBLf3SXhGMiILqJpU5taISWOdxuDkHrPbTF65rI5D5m9YJwfqOk3xiuG
         V04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676362; x=1781281162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZaKYvocR3w47gM5Rf3uf90CrbJw2wh4ush5zpJABRA=;
        b=FfTo7TyYDuy/qT0A9F141NwnhuH2ahlUvCd+ZbhjrApiR1h4jmQEPPtpSH5F0RLIki
         PEMw2KMts78Q6zFM4nrpJa+LgXDF2yhheO5NBzvbFCTrb7TXpbl4fUjRRR07WNMdh7pO
         KAPh0EsRBeqLCgozIS6ZbgoqLaTFJ2ayY3qAjIm/lFRMCX3ETY430j/sp1kAObF+xxfG
         z3+6vtoQM55k3yU4lazJq1wlT2Zy56gszswRjBnuMB5eaNbpuKqY/pDcM+rwDz16xXfY
         AU94Wi3QWiMMt9/vmcSmvjFOH2U/Ngp7XZCOIUQvOrmvunbHa/yaN+Glvy5HV7zj6aAI
         sdSQ==
X-Gm-Message-State: AOJu0YyMK/ROqoSLnEXM23i34cov86rskpnoqBgM+nt+nODnRzEEtHJ1
	Ybdv8JXM1G3F0iPmXrNTmvJ9sMTN3L4oNCIUxjMD3XSNOmYRbr8s7EwWj/bHT2cniD90NN5aAqL
	oQ2T/5fHldSunIElksxq5U9ndTBfgvIFGNg==
X-Gm-Gg: Acq92OGD7O06Tv8q61RnlIfctUsdXwATgDWoL+EIn6BY2LDKTxDfgo05UC17OOPWmdi
	rSe1uGjT8DcplP06h1Jg4tt4lbYDGcnbZFUv6KnFy6LzZtupCSQw0lamRBBxPFfhufRRm/w8+lV
	yI0Ce4RTm78cICh8wxxicaYncPGk4K7YkZH24jtMTaEnhWmmno1+ir/0PqxLJ2VQzjxTVQuXKvp
	v7wObgqiQDFXegjHanvyz0HDFxawjt8+XMkLQEqNX3uOZnzRer1gyAoG8SIks8GNcevUR9dSzAu
	zDMgVmSN+y07juBJQg==
X-Received: by 2002:a05:6a00:1ad1:b0:842:4387:34c0 with SMTP id
 d2e1a72fcca58-842b0f1e8abmr4313570b3a.5.1780676361830; Fri, 05 Jun 2026
 09:19:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604125806.255648-1-stephen.smalley.work@gmail.com> <20260604125806.255648-3-stephen.smalley.work@gmail.com>
In-Reply-To: <20260604125806.255648-3-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 12:19:10 -0400
X-Gm-Features: AVHnY4KBUbSy8I2G4EgqNVbr4pMCO8awVTK98MGDH127XqW8AeunV6wcXgr7O_0
Message-ID: <CAEjxPJ7GEs0JDC0eOQWWcBYfF8CGneS_y0bncopmWM2_VBSoyw@mail.gmail.com>
Subject: Re: [PATCH 3/3] restorecond: pin watched directories
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 8:58=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> inotify_add_watch(...IN_DONT_FOLLOW) will refuse to follow a terminal
> symlink but will still follow intermediate ones. To prevent setting
> watches on any files resolved via such intermediate symlinks, resolve
> via safe_open() and then use the /proc/self/fd/N path for the pinned
> fd to set the watch.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series was merged.

> ---
>  restorecond/watch.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/restorecond/watch.c b/restorecond/watch.c
> index 44094fd4..b197bdc2 100644
> --- a/restorecond/watch.c
> +++ b/restorecond/watch.c
> @@ -168,6 +168,9 @@ static int nofollow_lstat(const char *path, struct st=
at *sb)
>
>  void watch_list_add(int fd, const char *path)
>  {
> +       char procfd[32];
> +       struct stat sb;
> +       int dirfd;
>         struct watchList *ptr =3D NULL;
>         size_t i =3D 0;
>         struct watchList *prev =3D NULL;
> @@ -217,13 +220,28 @@ void watch_list_add(int fd, const char *path)
>         if (!ptr)
>                 exitApp("Out of Memory");
>
> -       ptr->wd =3D inotify_add_watch(fd, dir,
> -                                   IN_CREATE | IN_MOVED_TO | IN_DONT_FOL=
LOW);
> +       dirfd =3D safe_open(dir, &sb);
> +       if (dirfd < 0 || !S_ISDIR(sb.st_mode)) {
> +               if (dirfd >=3D 0) {
> +                       close(dirfd);
> +                       errno =3D ENOTDIR;
> +               }
> +               ptr->wd =3D -1;
> +       } else {
> +               snprintf(procfd, sizeof(procfd), "/proc/self/fd/%d", dirf=
d);
> +               ptr->wd =3D
> +                       inotify_add_watch(fd, procfd, IN_CREATE | IN_MOVE=
D_TO);
> +               close(dirfd);
> +       }
> +
>         if (ptr->wd =3D=3D -1) {
>                 free(ptr);
>                 if (!run_as_user)
>                         syslog(LOG_ERR, "Unable to watch (%s) %s\n", path=
,
>                                strerror(errno));
> +               else
> +                       fprintf(stderr, "Unable to watch (%s) %s\n", path=
,
> +                               strerror(errno));
>                 goto end;
>         }
>
> --
> 2.54.0
>
