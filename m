Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBA93B42F3
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676280; cv=pass; b=eirR1Iy8u++uKoV28uYT5OGhUE5zywFjPHp1E05/RsR/GT2Zpk3p+/SrwVx4vUpVmV44kiAbbjSfY7djQsLj0Vf7uH376d610KvI3q5TMm0G54M4weE4tq5LfnoOyvwVTXCyA80OfRyEYHwKpJCjJhRrp49gujw7dKVNOAd/hSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676280; c=relaxed/simple;
	bh=lhjlrl50uc34vkQg1Jq17uY9ukg4rbPOTu0oUnEgRKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sb1g4CeteXuq1IW8HmMdMg9piOUlmSL9yBattszn9xKbsnRx1/s/X6+gGTwRYIqKA7cQQnyZYarYafANrLJPHOLQ72Lq3Z910uusEb2X2NzwulLVD2/x1Sp9EdjDRsmSt7Pi5xCYCR5XTIYCx/1o0t4E6n3QLinq1ahlTLEoVTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhRmhXc0; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhRmhXc0"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36ad15213fbso1497992a91.0
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 09:17:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780676278; cv=none;
        d=google.com; s=arc-20240605;
        b=TVH8VNQS6CD1tppvX5hT61EvAysKKqkosJMbXd7+Dqp4RexacGFCT0QZj54IjKmrcc
         Ko/HLI0GgzLg0WVy9x9EiiZKid8Rb2c/gAAeAwvuppd6VuCKfNjnESxSy39jKFlZNGiJ
         2xBwig67J36i5ZZRCs4qHG0uIoQK81+9j+rvb3XtLxcjy1uZSBdlC6NTp6A9F7SkOdb1
         ssuQJg4WHQ1CPtltFVj0rO5oaYOACu2cweJYH3+MWPnhUNPBiGPEmX074yrOgssTbgXX
         s1cPmjkDL4AOmCJ+DthgnLmhg6gyZUa/aHm4VzOnU3gYdc26Ic4a+4265RctBYK1M9wC
         QGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yWRR3qQPIrEmq2Y6kVxskQyADiQhjuEihjQI4n4tP/A=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=fHaEMWa5O0F9Brx7K+PlRmXKNL20tVNPd+yTDNUHnyxKBYyEDrByqh+5AKLCZEzu2Y
         0DNzng5emMmMcSx9ktZsvOAhUIZDaXYXQ3m8qZffCflDHfa5FnZGik3u2l9F9HJxJcNN
         yhtBfRna7v1yNe6OKdG1iMaQYq9DdOMUq9pacIEPl3QdeolBYaQlY3PhqmmCSSFhBWzZ
         qIyCXbHB90/Xs4ERxyXqshxhSHLr6sOmZayarTTxVAD8MOw98s6Gb5g3ngxRsKWNVAoe
         y7isJ7BURpkXFM6+qIFIK5wuKRRzzHAx3YdUyiImTrnbA9Ejc2aHAtirn+2Qjx3innJL
         GKNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780676278; x=1781281078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWRR3qQPIrEmq2Y6kVxskQyADiQhjuEihjQI4n4tP/A=;
        b=YhRmhXc08lS1LgSsbEUMVkv/kcGo04FXbhSrdWkH0FaUqgx/5AZRZ6fCgoQThuRW9i
         2EK5OOgCIOZU2SJllzipsSw0CsSt9QQpEeP/pGrvgXE2/QZ0K0yCcbYn7Ws3rxPgI1tZ
         oDgoxlx5+SJEHIPGfc5NwmzgnlhGzYKhpzCPbI+SfsvP3PrESH6nNiQ7BhXQjIPN8bZQ
         ueQKT+fVj4CBa/nsukhSh7padwMFdbRRxT5Se4M7yNazn27lT6TaVC/sDxOfrB+W1Lnm
         /dNLw4uGz/3Y6gDPdDFEhcaufJ5T+ZMTzlGuk3lx4DFeGy5cNfq6ZT/reNOTSpztrkJR
         PAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676278; x=1781281078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yWRR3qQPIrEmq2Y6kVxskQyADiQhjuEihjQI4n4tP/A=;
        b=daoIJ2FEpEzgTBBsY0LRchaCjrMWF6TX+VKfgEGDtYOMRPeOQvsWtSY/JJ+p5Fvk3m
         3d5D3BeoHg63Kvj0LaZzUTdBJOh/NiSoriIZR7B5yET8xbI9V2hsL+1UcO1LzSyPHj4S
         3krU58qIIPrBMYEXbKdnJNHojAxXN/H/bmUB5TY9M9Ocr0d/SB5KJjrD2aAwyf+VZFPx
         MJ8+/xjyxI1mX+ygUK4eqNjAVy2cH/6klfHnbBgYQRXBAXkh7zBtOcEpmsuGltL+Q3qf
         zyBEEC1q8qtjcoAi48b8I3cJebXNNK3pK4O7ftt9HD3+j9zZG+lgBra2ni1B8ZqjauNo
         EmaA==
X-Gm-Message-State: AOJu0Yx68PqXrsCh7u3cfm4kewlOvn7Vx77IpbqwpRxoUW76qh4AA55V
	kRO0k/7Azjlns+PqsGUQj1hGIBgGbXuTz+bnFfsiBWDM8eIII9Hn8cbev1kVSKWMSTcDU+5cGqn
	/N2LnlbeMeHM2zx/qxoT3iEV4kNzHC1CLlg==
X-Gm-Gg: Acq92OFtaFKYt9tpzvmKAPV4q38a2UjJ4mCMGcE+SKEuWGnRAiNEmfjfA06WCGQ9qIE
	fuxzar29v+tP3N5S5R1CjMrMzrsnDhRQs5o6/B4zHi8R+0BZ59P7nG6wyl9dU+wkf21VPs/yCNA
	CidPxLzxKm0lZrKHVYo40A/NnLbWaP42MNrKvI1hErcg8bwwYloiZnUdaVajE0dPH1jfvE4uZJw
	pKXYppg+/L6mt6Y+Gr1BWAeBY6zdQVdQdGOjq0oCzxEFg+A+jQzUl1s0rCP9LqqPYP3wCzOfqRc
	wiNerLroj6z67ptbDw==
X-Received: by 2002:a17:90b:5787:b0:368:147f:bd27 with SMTP id
 98e67ed59e1d1-370f0d52f5cmr4885003a91.23.1780676278104; Fri, 05 Jun 2026
 09:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604182822.265426-1-stephen.smalley.work@gmail.com> <20260604182822.265426-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260604182822.265426-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 12:17:45 -0400
X-Gm-Features: AVHnY4IB2j5VVxrn49vY4i0Wzpk_wK_27PINBf-bYq6mvFHuDAazsCS9eUaA65E
Message-ID: <CAEjxPJ5Ybvz-S1OCS1ek72EMScgG2LCf3FjxN7LpgYXdVgMEPg@mail.gmail.com>
Subject: Re: [PATCH 2/2] restorecond: delete unused code
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 2:28=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Remove unused functions and definitions left over from when
> restorecond was split from setfiles.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series was merged.

> ---
>  restorecond/restore.c | 73 -------------------------------------------
>  restorecond/restore.h | 12 -------
>  2 files changed, 85 deletions(-)
>
> diff --git a/restorecond/restore.c b/restorecond/restore.c
> index 23c2c98e..c8437f4e 100644
> --- a/restorecond/restore.c
> +++ b/restorecond/restore.c
> @@ -54,76 +54,3 @@ void restore_init(struct restore_opts *opts)
>                 selinux_restorecon_set_exclude_list(
>                         (const char **)exclude_list);
>  }
> -
> -void restore_finish(void)
> -{
> -       int i;
> -
> -       if (exclude_list) {
> -               for (i =3D 0; exclude_list[i]; i++)
> -                       free(exclude_list[i]);
> -               free(exclude_list);
> -       }
> -}
> -
> -int process_glob(char *name, struct restore_opts *opts)
> -{
> -       glob_t globbuf;
> -       size_t i =3D 0;
> -       int len, rc, errors;
> -
> -       memset(&globbuf, 0, sizeof(globbuf));
> -
> -       errors =3D glob(name,
> -                     GLOB_TILDE | GLOB_PERIOD | GLOB_NOCHECK | GLOB_BRAC=
E,
> -                     NULL, &globbuf);
> -       if (errors)
> -               return errors;
> -
> -       for (i =3D 0; i < globbuf.gl_pathc; i++) {
> -               len =3D strlen(globbuf.gl_pathv[i]) - 2;
> -               if (len > 0 && strcmp(&globbuf.gl_pathv[i][len--], "/.") =
=3D=3D 0)
> -                       continue;
> -               if (len > 0 && strcmp(&globbuf.gl_pathv[i][len], "/..") =
=3D=3D 0)
> -                       continue;
> -               rc =3D selinux_restorecon(globbuf.gl_pathv[i],
> -                                       opts->restorecon_flags);
> -               if (rc < 0)
> -                       errors =3D rc;
> -       }
> -
> -       globfree(&globbuf);
> -
> -       return errors;
> -}
> -
> -void add_exclude(const char *directory)
> -{
> -       char **tmp_list;
> -
> -       if (directory =3D=3D NULL || directory[0] !=3D '/') {
> -               fprintf(stderr, "Full path required for exclude: %s.\n",
> -                       directory);
> -               exit(-1);
> -       }
> -
> -       /* Add another two entries, one for directory, and the other to
> -        * terminate the list.
> -        */
> -       tmp_list =3D realloc(exclude_list, sizeof(char *) * (exclude_coun=
t + 2));
> -       if (!tmp_list) {
> -               fprintf(stderr, "realloc failed while excluding %s.\n",
> -                       directory);
> -               exit(-1);
> -       }
> -       exclude_list =3D tmp_list;
> -
> -       exclude_list[exclude_count] =3D strdup(directory);
> -       if (!exclude_list[exclude_count]) {
> -               fprintf(stderr, "strdup failed while excluding %s.\n",
> -                       directory);
> -               exit(-1);
> -       }
> -       exclude_count++;
> -       exclude_list[exclude_count] =3D NULL;
> -}
> diff --git a/restorecond/restore.h b/restorecond/restore.h
> index d7935e06..17f0bc37 100644
> --- a/restorecond/restore.h
> +++ b/restorecond/restore.h
> @@ -3,13 +3,11 @@
>  #ifndef _GNU_SOURCE
>  #define _GNU_SOURCE
>  #endif
> -#include <fts.h>
>  #include <errno.h>
>  #include <string.h>
>  #include <stdio.h>
>  #include <syslog.h>
>  #include <sys/stat.h>
> -#include <sepol/sepol.h>
>  #include <selinux/selinux.h>
>  #include <selinux/label.h>
>  #include <selinux/restorecon.h>
> @@ -17,13 +15,6 @@
>  #include <limits.h>
>  #include <stdint.h>
>
> -/*
> - * STAR_COUNT is also defined in libselinux/src/selinux_restorecon.c whe=
re it
> - * is used to output "*" for each number of files processed. Defined her=
e for
> - * inclusion in man pages.
> -*/
> -#define STAR_COUNT 1000
> -
>  /* Things that need to be init'd */
>  struct restore_opts {
>         unsigned int nochange;
> @@ -54,9 +45,6 @@ struct restore_opts {
>  };
>
>  void restore_init(struct restore_opts *opts);
> -void restore_finish(void);
> -void add_exclude(const char *directory);
> -int process_glob(char *name, struct restore_opts *opts);
>  extern char **exclude_list;
>
>  #endif
> --
> 2.54.0
>
