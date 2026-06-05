Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE832FF144
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667031; cv=pass; b=dEsV7wxVjeaGlRmXWKjpPqcEe9+vaAdvJN6fg+FCRQ/HeZ4OD3n/+bbqPPVvQiwxxYeWsBRG3oAZLxUYHvSPSIG5hFIdmZjfPmg6STq74N6KtIiRiFXTmJTpmlLSvoiU/VIoP84rik3Uq+YocVx5BaZsWAKuH8YRnqk3gezmmXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667031; c=relaxed/simple;
	bh=aM+St8GH+xp2nqSsQoxGiiw3hZJ9KfC01swGww0t6Tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkIg2clUW+gCqgRvuupVX51ZFlOcCqaj3E34/pPRl/6AzLvVlbGI3tRGNuVRnOvVggIDeJOBqlR9QCUj6TDX2EyoYOF9FL4cE1SRjupzjTSMtlYpJ3+OJU1JN1ilbPegO8D+DSzgGfLKLnGMlM0FXMUu9Dvo8XA/b7pqcslCa04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpNaymdN; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpNaymdN"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3967738c801so17974241fa.2
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 06:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780667024; cv=none;
        d=google.com; s=arc-20240605;
        b=i/vuPBpKa/Sh/qzFCgFNXm5dY7yiVkOBukJ6wwIQMEQI9/L136yG3VDklZQ9cdTXLD
         GGevci3kohSen1auFvjVzTGfWpLIqfNzXEY2V2wXf6z55B0JM5D3FHlud8xHeL9I/LZE
         9YTTNEg0dE21wqlMWS+VMTu8ZB1p5MnOcFPTrfIbvkpJFWtVhFLgkuwjIOvGW8u5Piqo
         WEEmo9jyHHSLeDQXt48VKktPPwfJxEgBdzJTHydC6qKfpahOVzes1y1sVdBzNyVHKEgM
         glSu3oYdWO+z2pCz/Bo3rnIhgyx6cI+EO5SX8UVzJwunZDXnFPNFnunRKxNJEJRh6fGB
         gaMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2M5uxhxe4y2dLmUYDXPDmoCkMX8s5gdRrXihCn1yEv0=;
        fh=biLNIbUdiVI+HWgqVoISrU2pQus1fZiQi7u7sC8l6as=;
        b=a0vYPBG+q/Pr6VF7G3Jbepoz2QMh6e90VBwwa9ZOHQl27a3f1pm8XfbSmnUH8yr0y9
         3/FYdya2v/KC+tToE+JXDdjUgkFyI5I7QyqbGwynVxED8rmcrEejP5OZfzsXMgI9Qers
         6u0zB+B5Mnol62azKZD/C+P6UzN/yGX+wA2VPXd7pxc+QKkMdXitU/Xgxmq8nY38IDom
         qvAx/gqZgOtWU5608sAvHGhSslqqn7s59bFG55/k+MwnaNp+tx89ZPMQfmOk+9+3yqqx
         4yt4ezKkVHH5dJ8/uti4sErz1t+GY9BV9DDAvgATGu8M70eTMJi4Wlo17OPYhyrjXbpW
         Eh5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780667024; x=1781271824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2M5uxhxe4y2dLmUYDXPDmoCkMX8s5gdRrXihCn1yEv0=;
        b=hpNaymdNX2i6envPFpLQggEK5qF+B7JSpVteI5tcoiQ9BKqrVQaM8/rsQX1DvLeUne
         R68Cel/wHshlX0GYugRsjN+NqYtLIdETU3dswwxI0WiFEBYseurXVwZP4MSbPDUO9r/h
         IeZ/+W4UYyHz0cdQeUTJxX5gCxWyWzQk/kXA5LCDI1p6tm2FZ8FZXCcdOMCcrwZHPC9n
         5GCFU+akGJgj0FkvB695YzSLEmID0Yjn/NFrtVVpGCD5NoNaPIouYE+GgWgKed4J2/KV
         WEI7x0th1xwqggDDdRQ2i3WA1Ykkgg9dDM12HIkAe1+72Hq/gu1S1l3ZwezCtt4+2Bhx
         go/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780667024; x=1781271824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2M5uxhxe4y2dLmUYDXPDmoCkMX8s5gdRrXihCn1yEv0=;
        b=A+GyIOR82HQbdTL51jq7/OdWIUVDohfOtOkK4XD9tprhUq403fABlRjnk3raTJYWqM
         +fLJmRUYok6zWNw1aUcUWtmD5N93DF2q7tyZDjnmpp6523rnjWHCMIzdXLxXvTnxTykU
         3ZLECc4Lwps/c8efrq065EdcBiqgEfOdGrfDXv0ToBZl+pebQ0ZhJD0iNxyc6vmJYBjv
         iJc3BnNiGwmTkbVnz0NWuqJ3w5IPSOZgstcg0zCffwO0HB8FL6YKGnIQaUPaD727xAJN
         n1GGKaM9TWHvZRV6lrRcieXAQzoHsToaozBwu8SNudVcXSoy4OFTtCzGRaYgbFWXsoCO
         QU6Q==
X-Gm-Message-State: AOJu0YzpS/fjszg45RfTV/WQiOcyzOM3gNsnIz59+bcc8o7/Sdm3Bsf3
	kKtrE5aUx+QkFapMYADK/PGvaLdwMRMEk+LdojrA08XceAYU5PH8CxTm+3nuowq7hCHa/xzZl05
	+wA4il7jotqcvlDan5YyIZuZ1jloit64=
X-Gm-Gg: Acq92OEX/XUgqFhCnDqPLkRoLR9afK0NDFsmi6ZMJR/WE3hpknnz6pnjRjyBkmiHyps
	EQF3xpk90fpBovknlNq/qlm1vjdkaWi/wBGkLTmwAUs4IB9yUv2mG4Dz+QQXJ2naUxcNHf3Hr2Z
	fuppYoOcqi+m6jKLokKZtC1nbgstvCZz6zmT97I/Nt6eolWu5zVzkGa/E6k7iZMQmUrLifLZ7cX
	+/0l5SWjEuUj7Uz2Sr6g1ChMjDLWMwjAYcEEiZ/1c0WTHv+VH9hcj5WcjXg0dquRV2wJsakO4B2
	t5I92roomLiJW60=
X-Received: by 2002:a05:651c:244:b0:393:975b:5635 with SMTP id
 38308e7fff4ca-396d0768dfbmr10731071fa.12.1780667023719; Fri, 05 Jun 2026
 06:43:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604125806.255648-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260604125806.255648-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jun 2026 09:43:32 -0400
X-Gm-Features: AVVi8CdIB_1hCEDpUUTvxBInbYuRfTf9ngxb4Mta7MfF8ascpch-VMkizgw4DPY
Message-ID: <CAP+JOzTyNkrj6WwGCOJK=pRfZBSpAX6pZTzWvYf=tNoqY30HeQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] libselinux: selinux_restorecon: add flag to skip
 multilink files
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 8:58=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Add a new SELINUX_RESTORECON_SKIP_MULTILINK flag to
> selinux_restorecon() that causes it to skip non-directories with
> multiple hard links. This should be used by programs or users when
> relabeling untrusted directories (e.g. /home, /tmp) which might
> contain hard links to files owned by others to avoid mislabeling such
> files.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

For these three patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/include/selinux/restorecon.h  |  5 +++++
>  libselinux/man/man3/selinux_restorecon.3 | 13 +++++++++++++
>  libselinux/src/selinux_restorecon.c      | 11 +++++++++++
>  3 files changed, 29 insertions(+)
>
> diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include=
/selinux/restorecon.h
> index a5fdf12a..6680589e 100644
> --- a/libselinux/include/selinux/restorecon.h
> +++ b/libselinux/include/selinux/restorecon.h
> @@ -139,6 +139,11 @@ extern int selinux_restorecon_parallel(const char *p=
athname,
>   */
>  #define SELINUX_RESTORECON_COUNT_RELABELED 0x80000
>
> +/*
> + * Do not relabel non-directories that have more than one hard link.
> + */
> +#define SELINUX_RESTORECON_SKIP_MULTILINK 0x100000
> +
>  /**
>   * selinux_restorecon_set_sehandle - Set the global fc handle.
>   * @hndl: specifies handle to set as the global fc handle.
> diff --git a/libselinux/man/man3/selinux_restorecon.3 b/libselinux/man/ma=
n3/selinux_restorecon.3
> index 218aaf6d..9bcd3d42 100644
> --- a/libselinux/man/man3/selinux_restorecon.3
> +++ b/libselinux/man/man3/selinux_restorecon.3
> @@ -182,6 +182,19 @@ completes with success. In case any errors were skip=
ped during the file tree
>  walk, the specfile entries SHA1 digest will not have been written to the
>  .IR security.sehash
>  extended attribute.
> +.sp
> +.B SELINUX_RESTORECON_SET_USER_ROLE
> +Set the user and role component of the security context too.
> +.sp
> +.B SELINUX_RESTORECON_COUNT_RELABELED
> +Count the number of relabeled files or the number that would be relabele=
d if
> +.B SELINUX_RESTORECON_NOCHANGE
> +was not set.
> +.sp
> +.B SELINUX_RESTORECON_SKIP_MULTILINK
> +Skip any non-directory files that have more than one hard link.
> +Use this option when relabeling untrusted directories that might
> +contain hard links to files owned by others.
>  .RE
>  .sp
>  The behavior regarding the checking and updating of the SHA1 digest desc=
ribed
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index ec71d456..224a5a33 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -91,6 +91,7 @@ struct rest_flags {
>         bool conflicterror;
>         bool count_errors;
>         bool count_relabeled;
> +       bool skip_multilink;
>  };
>
>  static bool have_proc;
> @@ -711,6 +712,13 @@ static int restorecon_sb(int fd, const char *pathnam=
e, const struct stat *sb,
>         bool updated =3D false;
>         const char *lookup_path =3D pathname;
>
> +       if (flags->skip_multilink && !S_ISDIR(sb->st_mode) &&
> +           sb->st_nlink > 1) {
> +               selinux_log(SELINUX_INFO,
> +                           "Skipping %s: file has multiple links\n", pat=
hname);
> +               return 0;
> +       }
> +
>         if (rootpath) {
>                 if (strncmp(rootpath, lookup_path, rootpathlen) !=3D 0) {
>                         selinux_log(SELINUX_ERROR,
> @@ -1530,6 +1538,9 @@ static int selinux_restorecon_common(const char *pa=
thname_orig,
>         state.flags.count_relabeled =3D
>                 (restorecon_flags & SELINUX_RESTORECON_COUNT_RELABELED) ?=
 true :
>                                                                          =
 false;
> +       state.flags.skip_multilink =3D
> +               (restorecon_flags & SELINUX_RESTORECON_SKIP_MULTILINK) ? =
true :
> +                                                                        =
false;
>         state.setrestorecondigest =3D true;
>
>         state.abort =3D false;
> --
> 2.54.0
>
