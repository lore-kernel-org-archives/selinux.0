Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CDE7462
	for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107546; cv=none; b=I4n/sVR+gpmJvz59IwV9YUB3SvjphmiGN7BNvwc+VTRYotFCpMe6QJ88JQuJOexjPpCJkW5zobkU+0tj/qruqQxwQDypib1prA5gMGr2lZXczeFJqLLSbildKDA4Vil6MsJ4qrgHhvikhWiB+5ADezDHx9s9ipTpq2BNif4Q9LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107546; c=relaxed/simple;
	bh=s6VVfSuozKfqLRjx2MA3MDJkgrmAWGO1E6n5q4EezFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyEtyZ+cUrTF6Wi/QWN5uXVqlxsha2LqQP5ZmQVajcXa9r7zdfh8sRtA6Avan5VQszE2LUwFGVGRglY97Jplw3M6ZRvT85D2rIiQYKn/RYQb5IgBwgdtVBZDnMqW59zsmwQ6ZJ30UsHitieeeRcwHkGXMMR4gEWRWo/sjyQ2MzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lx2uehDP; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lx2uehDP"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3122368d7cfso3309191a91.1
        for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 07:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753107545; x=1753712345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDPaA8cDPzS3IqQLz2mhfrkTsldcGWMJioBR1Ejv6cA=;
        b=lx2uehDPO3YoM6unh907HHN42jDjDs6Upj8Y9Ed74mvICCGWvBfHGaW+nm6DkajCmD
         8zZEh8+mLpWBN1CJY711+szy3DOwEJkScunQX7PUI2Vj4Y7X46sgQpnIf7azmQnOdJaV
         G1ZerG7jyhTlUIAn7OIb4vjCp2vxZD1D6vSt4nlRpIS9kw+PMXYR2/6OVRhNQjBWfvWW
         6usWGjkiZcNd0ziTwAsdetyHDpqFS6kIlLC3VFOBAz4dqTBGkBIuDyd/8xa9eu6jnVoe
         9L+iTsHhOWnM9sxR3CgG/ttsLuvMszEPH8Cv5aA4Yu9QaRf/FIRlBVsNLEYBdG1jMr13
         cuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753107545; x=1753712345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDPaA8cDPzS3IqQLz2mhfrkTsldcGWMJioBR1Ejv6cA=;
        b=ttAgO1QcFwZf2MgzU3guUi8LTv3iU1HWTw7nNr6mSanZiiEelnsFhwmOaMhlGAnLrn
         NDY4fdJR2d1ny9xorszH8LgHxQsJ8dOd+ws516GGUxaiYsjDTRzFhfdQXwNr9P5fWUrA
         4TWGciNrEdIFghiC4qHDrBLzju0QbUWo5+dDuCrLbwulRb2n+AF5wdCzzU659cEBxtT6
         hOAinPkl+k1irsj6C9+JRKwOjPTp8gsBhaGB6s6SZH7j1lqAa9Z3OaWCFyevgxiHHhda
         dF8pahYyI5Eb2qPKO28IO9kxoY7l2z6dj66xiuBkNWmWP1Yn80+UR+rEIpAn7k4SCvX5
         vOUw==
X-Gm-Message-State: AOJu0YwFsernSVVubjXw515Cg56cwL2W9Z6S2baDK9pUrDS96YPo5LUA
	psIJqHR5IKLsDJbTnKTrGjAiA8ANLPjR0rLkVfTnxVxfBAYd9WQSqXkZH7NZ0mUs9zNK5WdJsFw
	TSAK7iAPUO4DshR7FQ5J7AKKzUGmYCxU=
X-Gm-Gg: ASbGncsjNDzd4zLyUcOMAVhmKEF5V4E3nxrghq9fCPUPwmdQlqXdSzHq9yx3br7fEL+
	JTKiDNp4httH2NJ+RGre3JKL7GFtHKL2MuxeJZa4dob2avuqYDWVt3SaKyyY+tzPnf44BKAGotD
	rluiS2r4fCQrkULgtIPfpZuVT1gqTd2s3Hos/vBinCmcP/gIHhs26Q0Ahf5JrnfBUru5kfhtRX9
	98ogb8=
X-Google-Smtp-Source: AGHT+IEhDJZYTM+Y7wD8tjhIPm3VvIswt8KKd0HNkZHPXHZSN2Tyj1uObsEY8kFyR0IaLGmIYFiRCwgCfFGsv32gD0A=
X-Received: by 2002:a17:90b:3c8a:b0:31a:ab75:6e45 with SMTP id
 98e67ed59e1d1-31cc25ea9aemr17688882a91.28.1753107544576; Mon, 21 Jul 2025
 07:19:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720125229.306644-1-nvraxn@gmail.com> <CAEjxPJ7ZuzcMLqewoci=wamT-F3Q_CD2iqBR+zMAB+V1hLOrHQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7ZuzcMLqewoci=wamT-F3Q_CD2iqBR+zMAB+V1hLOrHQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 21 Jul 2025 10:18:53 -0400
X-Gm-Features: Ac12FXzRTZiefWgA2uJ_iwPxEruryoQHjmP8ifJV7sLb81grNblztqrg3e6WzwE
Message-ID: <CAEjxPJ5M76PFEMghyCWPsJW27rNA6A4yxhFydGoWWDW0Eybqfw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: fix parsing of the enforcing kernel cmdline parameter
To: Rahul Sandhu <nvraxn@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 8:56=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sun, Jul 20, 2025 at 8:52=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> w=
rote:
> >
> > Currently, parsing of the cmdline has two issues:
> > - By using atoi, no error checking is done. What happens if an argument
> >   that isn't an integer is provided, e.g. enforcing=3Dfoo? And as there
> >   is also no validation that the number provided is actually valid, 1
> >   or 0, what happens if enforcing=3D2?
> >
> > - After the first strstr, no arguments that follow are searched for; if
> >   I have enforcing=3D0 enforcing=3D1, the latter enforcing=3D1 is not t=
aken
> >   into account. This is made even worse due to halting searching after
> >   finding the first "enforcing=3D" token, meaning that if the cmdline w=
as
> >   as follows:
> >
> >   fooenforcing=3D0 enforcing=3D0
> >
> >   the enforcing parameter is entirely ignored.
> >
> > This patch fixes this by:
> >
> >   - Using strtol to actually validate that we got passed a number, and
> >     then validating that that number is either 0 or 1. If instead we
> >     get passed an invalid value, we skip over the argument entirely.
> >
> >   - Looping until the last "enforcing=3D" in the cmdline. Latter (valid=
)
> >     arguments take precedence over previous arguments.
> >
> > Although this patch (intentionally) breaks the case where "enforcing=3D=
"
> > is provided with a positive argument that isn't 1, enforcing=3D2 doesn'=
t
> > really make much sense, and being strict with the arguments we parse is
> > a good thing given that SELinux's mode of operation is controlled by
> > that option.
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
>
> We should make it match the kernel's logic for parsing and handling
> enforcing=3D on the cmdline. For reference, the kernel does this:
>
> static int __init enforcing_setup(char *str)
> {
>         unsigned long enforcing;
>         if (!kstrtoul(str, 0, &enforcing))
>                 selinux_enforcing_boot =3D enforcing ? 1 : 0;
>         return 1;
> }
> __setup("enforcing=3D", enforcing_setup);
>
> And the kernel's parser ignores anything after a "--", passing
> anything after that to the init process.
>
> I am not sure off the top of my head what the kernel does if the same
> parameter is passed multiple times.

Ok, looks like the kernel allows the same parameter multiple times and
the last one wins, so the behavior you implemented is correct in that
regard but not the way you handle enforcing=3D2.


>
> > ---
> >  libselinux/src/load_policy.c | 21 +++++++++++++++------
> >  1 file changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.=
c
> > index dc1e4b6e..9d411b95 100644
> > --- a/libselinux/src/load_policy.c
> > +++ b/libselinux/src/load_policy.c
> > @@ -244,17 +244,26 @@ int selinux_init_load_policy(int *enforce)
> >         rc =3D mount("proc", "/proc", "proc", 0, 0);
> >         cfg =3D fopen("/proc/cmdline", "re");
> >         if (cfg) {
> > -               char *tmp;
> >                 buf =3D malloc(selinux_page_size);
> >                 if (!buf) {
> >                         fclose(cfg);
> >                         return -1;
> >                 }
> > -               if (fgets(buf, selinux_page_size, cfg) &&
> > -                   (tmp =3D strstr(buf, "enforcing=3D"))) {
> > -                       if (tmp =3D=3D buf || isspace((unsigned char)*(=
tmp - 1))) {
> > -                               secmdline =3D
> > -                                   atoi(tmp + sizeof("enforcing=3D") -=
 1);
> > +               if (fgets(buf, selinux_page_size, cfg)) {
> > +                       char *search =3D buf;
> > +                       char *tmp;
> > +                       while ((tmp =3D strstr(search, "enforcing=3D"))=
) {
> > +                               if (tmp =3D=3D buf || isspace((unsigned=
 char)*(tmp - 1))) {
> > +                                       char *valstr =3D tmp + sizeof("=
enforcing=3D") - 1;
> > +                                       char *endptr;
> > +                                       errno =3D 0;
> > +                                       long val =3D strtol(valstr, &en=
dptr, 10);
> > +                                       if (endptr !=3D valstr && errno=
 =3D=3D 0 && (val =3D=3D 0 || val =3D=3D 1)) {
> > +                                               secmdline =3D (int)val;
> > +                                       }
> > +                               }
> > +                               /* advance past the current substring, =
latter arguments take precedence */
> > +                               search =3D tmp + 1;
> >                         }
> >                 }
> >                 fclose(cfg);
> > --
> > 2.50.1
> >
> >
