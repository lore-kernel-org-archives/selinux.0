Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3971237AA6A
	for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 20:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787083851; cv=pass; b=ezPfYuT454mUnSUEhHKbYHfDdHzAPEf/Q7t7Uu/YnGyLm78XefNvJ9L5qCTeJEBfObjleikcq0fjpJFkS9z8b/rVsBqaIRdP0UREIiYnC4ltmd1FPnVojoP26lGeUFGOUtR2hZSfSexRih2x5xiWojrRG/uQMqvTYr/Bd4q2tGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787083851; c=relaxed/simple;
	bh=juAuNf/icvJkyQj0yi0JbeCtT9Q3p2xr0QOM4XngpdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzYmSaiG2H9FZiqxPb3mgGOghC480TAjBiNVh6MNY7p9NVW/0WeShkl4nq6ACfBKZBUA8S+2+N9d2CAhVwIvY1iEgytN5z5ICtekeFbx0gfG8hWYlY3doUVKJgPxUX5lGCLlQeXdDaEeaQ9Fun6ht052697tuyoiRRMCUeaNNsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFxr4gN1; arc=pass smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFxr4gN1"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6b12ada8befso235244eaf.0
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 13:10:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787083849; cv=none;
        d=google.com; s=arc-20260327;
        b=BgmZcPL0eEEvRytIFTkgHEL2N9BWMiJljZqjTXqtJj7Ui2ssoFJyntW1M2F3a3goZ7
         eiYlZAGv5+bCbmF+YsoXmSnPJvbT81kOtvKXSHyDiltCmRMiOr9ExbtyxKg8z1/0tnbl
         ijgbimgTNivJ6J3rgf3Ji7EHhXhb/I1eYY8a7tXmqWNU/Q7Rm9QpYPp5E96Iis/gvqI7
         c3lIiHkMElXERBpVXELcD0L2OW4pUzrsQbpl4cL9+Y/09Vfpzh2If4ZCNnMPxZjckstP
         j0fwbu/jhMvuJaM+cjTfV4sTE3mgeVy0DK5gcP1F2LW3KgIH4geUieko9uye90xv/ASL
         /+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ROhb7dEdl64Vp1NYzsnReXV6d4Ztl5SBFhUhwRsC7yQ=;
        fh=Vdc608U6fmQnkK4Pj/GsEOPoO5XtlZs1Z9K2hPCnM4c=;
        b=haAqOGjmb80eBbgd5n5jdtdC0UROX5ivWRdMVXtrCnd2dXyGPeYhRbkhBaT6gqJZst
         tqCYQtzqw3QOvqL1SVVHuxt2MnIqMe+IZJeok+vm4MkAjHrhCVq0XMZjrJdm9S7Uxmsy
         crweOZe4fdUgHvuuglYr4Gb8de7E+5jK27zR0EYJIbk2PvWOx4VbBf7H1kyKRhvWtsWM
         vQhOHZbs17tSP3HujoI+3iC3Y60nrRu1xEeKDLXFucCxl1cuWaBG7PMmBx9/KWCAXrqO
         phVKWPIb9dSVdxZ0SNZE1kNb9zPd+9BYdd6j7s3ENa1fRee1pboIKrelGxGs7abiV3XA
         2Ijg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787083849; x=1787688649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ROhb7dEdl64Vp1NYzsnReXV6d4Ztl5SBFhUhwRsC7yQ=;
        b=hFxr4gN1lPAW7SB1OE+wrF6GDN/3fm5DmMjBKrK2cJ0G85MnoQe0TjJWJl5Cm3qodF
         3yDUQaExFo6gN6Mrgfe0bwE9MYVblwCqD46DPrWopA8LH25qXpbIw10l3H0ad5aq/o+A
         gx22lNOXW2/FQvH+cXI2oOzgGb8+CxAnG/9UVfZNowI7aJfrSwMDAl7vw0sCPPeEUMN2
         FFo+5V6N4ioPTr6kpb2cOgXv0WHQrNuiUAxKfBc4CqMVydwbZbuMABevniNvPK2NP5qz
         kKVJ0+ydX95ZMwj9uIQu07hqRX67ln1YfYpULB5krlzC5Npm68rDoYmXgyHlIqnfNnkN
         VZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787083849; x=1787688649;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ROhb7dEdl64Vp1NYzsnReXV6d4Ztl5SBFhUhwRsC7yQ=;
        b=Q16JpCTBiMcRudtzPExS25+kCvy+0Ic2yaYsE7vz/hCI6ursk2G64GTGgk8AgQ8Y3H
         OZMMFrdlHqUsa649OFotw36pi684tcM5OYfm9g8pzlJTGtbjpchSnuTjYlT8P9qQHLQ7
         sXauFR8rr1GSPQhZGSgQoDcjZC2/vtgSofEGNnZAAAX2sMv1Yb/epGsAYzUTSuUNIeEx
         kV9FocWEzFoHxiFPYlbdXkJZVtCxYX0cxzZiYWWUT82UDOttokSVUC9yETB3rhLQsjmc
         noeYsGBWqoNp7czb/KASoQ7LADOORjhdxkRqcUg/P54QCfd+Va26a9NhHtT1qdr+ZorQ
         ZuTw==
X-Gm-Message-State: AOJu0YyGOagPvSKyTBNWEgZhzzvcbqnwZbCVa5Vuk99N0n9CD9PcJswS
	ZmOESqU4bdyHA/rvbPtoe47CJK0BdOAFCkIzBpclNOPTAxCKQDphyLciHzHX79h3YHp6tuuAUbe
	bGxs6SIO0fuSqgEJBSSF+QHLlReWv/lE=
X-Gm-Gg: AR+sD122eUSIPyLqrqpdBW7JGDnJpITBlim/4mfUIi21AdnADxgI6i3oxJgJXyCGB4N
	EMjod/C+uZ//S6HrUjoUH3xpE8ywtyChYfQYs/Y2yd8HP2ZNQPxBSGvjWJVQ9fOWNhjSFpaizWz
	VvBbQEQIa54z28L02fHjlitEDqz40ZagvXS5tYhOOjBXaAji/z2V+6YyJo9KZHGdbIz9QCKBI8Q
	bwPWhdiuX/VvMmQdOCyvgv051HA7YNsfB7Z+yIpSYEUE9mPV3KLXkzptaMFitvx9E5xnJqcSOyJ
	nL1h6R1cm5BFxTgOUns3Hz9Dfz5pEx/he6QtUBjOjK3k
X-Received: by 2002:a4a:e90d:0:b0:6a1:5acb:e954 with SMTP id
 006d021491bc7-6b13adb2d42mr88036eaf.19.1787083848932; Tue, 18 Aug 2026
 13:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818192340.119297-1-boeroboy@gmail.com> <20260818192340.119297-4-boeroboy@gmail.com>
In-Reply-To: <20260818192340.119297-4-boeroboy@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 18 Aug 2026 16:10:37 -0400
X-Gm-Features: AcwNN1W2Kl5DInBAadfOZSOWiiXwYpS8FZj6LIJ1tRYOJbJoUwP0l7Mdfwu74sI
Message-ID: <CAEjxPJ5sPNEC39ZQevKoCZROiONZmz-g56Pp6O9wQF_3mTxcbg@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] policycoreutils/setfiles: honor RESTORECON_THREADS
To: jboero <boeroboy@gmail.com>
Cc: selinux@vger.kernel.org, cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 3:24=E2=80=AFPM jboero <boeroboy@gmail.com> wrote:
>
> From: Johnny Boero <boeroboy@gmail.com>
>
> Relabeling is invoked from places that cannot reasonably be given a -T
> option.  On a Fedora 44 system, 10 installed packages run restorecon
> from their scriptlets -- filesystem, kernel-core, container-selinux and
> selinux-policy-targeted among them -- and not one of them passes -T:
>
>   restorecon -R /usr/bin /usr/sbin
>   restorecon -e /run/media -R /root /var/log /var/run /etc/passwd* ...
>   restorecon -R /var/lib/containers
>
> Influencing those means patching every spec file in the distribution,
> one merge request at a time, and only covers the packages one happens to
> have installed.  The environment is the only knob that reaches them all
> at once.
>
> Add RESTORECON_THREADS, with the same meaning as -T, which takes
> precedence when both are given:
>
>   RESTORECON_THREADS=3D1 dnf update  # keep relabeling on a single core
>   RESTORECON_THREADS=3D8 dnf update  # cap parallelism during application=
 load
>
> An invalid value is reported and ignored rather than being fatal, since
> the variable is inherited by every child process and should not be able
> to break an unrelated caller.
>
> This patch stands on its own: it is the brake for the new default in the
> preceding patch, and equally the accelerator if the default is left at a
> single thread.

It actually depends on patch 2/3, see below.

>
> Link: https://github.com/SELinuxProject/selinux/issues/489
> Signed-off-by: Johnny Boero <boeroboy@gmail.com>
> ---
>
> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfil=
es/setfiles.c
> index 4c860755..ee0930b7 100644
> --- a/policycoreutils/setfiles/setfiles.c
> +++ b/policycoreutils/setfiles/setfiles.c
> @@ -65,8 +65,8 @@ static void set_rootpath(const char *arg)
>  }
>
>  /*
> - * Parse a thread count, as given by the -T option.  Returns -1 on inval=
id
> - * input.
> + * Parse a thread count, as given by the -T option or the
> + * RESTORECON_THREADS environment variable.  Returns -1 on invalid input=
.
>   */
>  static int parse_nthreads(const char *str, size_t *nthreads)
>  {
> @@ -166,6 +166,7 @@ int main(int argc, char **argv)
>         struct stat sb;
>         int opt, i =3D 0;
>         const char *input_filename =3D NULL;
> +       const char *env_nthreads;
>         int use_input_file =3D 0;
>         char *buf =3D NULL;
>         size_t buf_len =3D 0, nthreads =3D 0;
> @@ -246,6 +247,20 @@ int main(int argc, char **argv)
>                         exit(0);
>         }
>
> +       /*
> +        * An explicit -T option takes precedence over the environment.  =
An
> +        * invalid value is not fatal, so that a bogus setting inherited =
by
> +        * every child process does not break unrelated callers.
> +        */
> +       env_nthreads =3D getenv("RESTORECON_THREADS");
> +       if (env_nthreads && env_nthreads[0] !=3D '\0' &&
> +           parse_nthreads(env_nthreads, &nthreads) < 0) {
> +               fprintf(stderr,
> +                       "%s:  invalid RESTORECON_THREADS value \"%s\", ig=
noring\n",
> +                       r_opts.progname, env_nthreads);
> +               nthreads =3D 0;

parse_nthreads() doesn't write nthreads on error so nthreads always
retains the compiled default.
With patch 2 applied first, that default is 0 and this line is a
no-op; without patch 2, an invalid RESTORECON_THREADS would flip the
default from 1 to all-cores instead of being ignored.
Drop this line and re-submit please.

> +       }
> +
>         /* Process any options. */
>         while ((opt =3D getopt(argc, argv, opts)) > 0) {
>                 switch (opt) {
> --
> 2.55.0
>
