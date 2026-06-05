Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD814071EF
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687664; cv=pass; b=i/QGnhbdCFpAPM2bDp/MYlpQsbRIccWjOxwpgEcP6l954NqOjDMapd7YE0iUuyTO1W9Jf/WUjxTZNv8o2a4V0YSpL4Yn/axN+gSa0LRzdm5kAG8swqEapSFWzUbOia3/QzP3GEXb2z1JkJ4H4JQd+a20Hc9BXy0EtzitS7RbfkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687664; c=relaxed/simple;
	bh=bqkJEbewkZ3oIAMVjJWsXjzMkv3tw/ugCaWA/UihxWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DI9sxVrWnkUjSZYu5TDSxSBh/Pv3rIWQu4SjxPEF0nIzweoxhjFxGjbzI2XRWh635AyBvOkYESlai9Y6Z4zr+j6ob7XO/vIp/agC43/h3AsMG+nsTiepelnhf0Ui8kA4JzsY734XPW9Ytm4TR54k8xBtu3LvzkuqYk1HzDv2CVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvP6dCmY; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvP6dCmY"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c858cc9870aso1662773a12.0
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 12:27:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780687662; cv=none;
        d=google.com; s=arc-20240605;
        b=FHUWC7O9kuzBlAia8GNTIqCxU+5bwBu49mUndn6yePyFSn2AcRsuzRPg7Ff865rYiL
         pB67AFw1VxIwIml1gYMY3x2yjFqc0jcd0//czPR3wKvyE42GRNDM+E1N0NI0tsZaFe+0
         PHqlju1LsD1VSPFK/Yc77AURqq2ibw7rH9vnXkOgXy2rw/jDMrjVujouS1QGNxHfCqPG
         x51U0jsCgGcKDG+l+q/3IQtgn2LLB7chKxlXhjr6gEyNH8+b8k7ho6O4du4Jfk75+hBy
         2I2OADZe5ucjA+JeSpVSAbvLrOcbtDYOdPxA8HiuyVsHFGdXP9YPeOCoirfmP54mQU+/
         hmYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T4EbGC+0QqiDQgJfjCp7TZP7wYehWs/hGzBh2FVVriw=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=PgxIimDtdgr1YUU5hB4CoPOdy/ekvtR2raqUSZ/h9MT4smYf+fL0ZfNg0hHYlxNlWt
         DNBahXPD+kE7C5tD8icPW2yvhzPnhsyjyudHNw9rorcFiE5AXSNvdTbiU5VTBYBapzuJ
         tfCdsnvOuGCKtU0acODzS1fhYxtVGJKyF3Kv3XFfI7bbjlD4S2YwPi08OpfpMXScdHkN
         Q6fCvUNtUUpuSUjweSCfVvu994YLn4aH9XOLwMmYPP+pyvV5n3l/kxbVXhP2UAIlyc3g
         QWDXjG+q2dZty6t7kVuScDBLaTHKSdajIXHW6ZT2UdCPQfhpT2xHlA4wuHBOXEjWOMPP
         3vHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780687662; x=1781292462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4EbGC+0QqiDQgJfjCp7TZP7wYehWs/hGzBh2FVVriw=;
        b=TvP6dCmYjvucGfWsbc6UYEqs5l5rK8YcdcnauaHmacY3vEzHsUom3s3hGGLMeBDjIb
         i5uf1xivSIU2w0MRnme393yIGW9HUjSmnr6fT+2ONP9klwE591dPPeFgtX0LNsAkzFPf
         Y/1yOYLG/6eIXeWE3ykDUr504D/lI4XmK5MV4mFMsLcZ3SW1hg/Cs6+/lEz9EqNys1PR
         4E76OZhjLgq6DBrAoVoQR9u0MOabHcoG5FtyHddEcf/h8HoQmFJBaO9B7FkyuzFLg6t9
         nmuaDvQuaZo0pj4QC6kWz1hNkt/UA07rA1a9S2c+YG1A73gf+nq4jq52gGyN9WloQoHv
         oeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780687662; x=1781292462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T4EbGC+0QqiDQgJfjCp7TZP7wYehWs/hGzBh2FVVriw=;
        b=pcbUpLHxKxU5BFH87K9XaY1uHq9Q0o/OncwQj28uwtK4AZ4jk2+nPHu/yitvrr+muM
         QB4MAnWOKYFc2ZZBQrftSPwY6RfaqEkuNzptw1Jz/Ba8mj7jeeWJgD8Ch9zSDrDupLYk
         bnKWwnG5gEcy9P9a9RZZCfLkbYi4UN2A7enr06x3E24YeuyuFAk/1/oL5VLfHESYHDoZ
         dBIsBZUWFTDeb/cmZcrpZkXBeM0Gmx3bZT92h28v87kG3m7zSdSr/ZpuxfCztZPcYvzk
         l/Npx2kxqpivH0cJp7uAHZeX3Z5XEhzysfu/XrhPJasyUJlgcB8l5caKsJwpWrCNiDIO
         McVA==
X-Gm-Message-State: AOJu0YytY4n/WqjkWl2pQZT3C3fFAchPLbm384DP6I4Kvbb3Fg5qKU5Z
	VgxXjeIyjWE0KinBZ1fvvcuDjds745rmQUcA3R5teXcP+HVxBY6VnUSuy5C+QpZMxMw7mhQKYmG
	KDzzSe4cH3dHXVDkhZqY9Ahgu0R2iOklmbQ==
X-Gm-Gg: Acq92OGO4v5DJl2Qh3okSwL7rl2fQvK+G8mK0Qt91BIRSM5zOykAev78i+oEmbYAAA5
	whqkA5BjGGTwxPyHkd/Tra3RZaV4JN0mIbsXBgRo1MlKxR5DesPbjYUi1o2wOfa/p7vUq0oKyvb
	PQbRQc4G7CvTsbSMIFOWT6ysSZzNc/XsRgkTiM+aqnBisEIzQt+5bGyFYxLWhBxuX0c5grUM1vS
	/fljoFqRN4vnNMnkxL6zCtpSsyyh0sKAZC03uo7XpasABCXvWw9lKpnfpSIP/35s4QdfxUuJt5g
	4wWqYWVWR1LUyGW2xA==
X-Received: by 2002:a05:6a20:9630:b0:3b3:ccd0:cf62 with SMTP id
 adf61e73a8af0-3b4d3dd48a2mr3789636637.36.1780687662182; Fri, 05 Jun 2026
 12:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605172207.222382-1-cgoettsche@seltendoof.de>
 <20260605172207.222382-9-cgoettsche@seltendoof.de> <CAEjxPJ4Ciuj80Dui1ROKAYorvKnTxS41-5SUJ+h_Er7403zomg@mail.gmail.com>
In-Reply-To: <CAEjxPJ4Ciuj80Dui1ROKAYorvKnTxS41-5SUJ+h_Er7403zomg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 15:27:30 -0400
X-Gm-Features: AVHnY4LoY4cfvgkzAZN30c2NEt0Zzm9M7NSR-EdnU9nrcmojv31ad51SSCLqdBI
Message-ID: <CAEjxPJ4j_jRCuyeaPNcXJAstvEBOomTB-0-Ua8cZidNj4JC-Hw@mail.gmail.com>
Subject: Re: [PATCH 10/11] restorecond: drop unused macros and variables
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 2:07=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jun 5, 2026 at 1:25=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > After the recent cleanup several macros and global variables are unused=
.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  restorecond/restore.c | 16 ----------------
> >  restorecond/restore.h |  1 -
> >  restorecond/watch.c   |  4 ----
> >  3 files changed, 21 deletions(-)
> >
> > diff --git a/restorecond/restore.c b/restorecond/restore.c
> > index 622de773..d46439ad 100644
> > --- a/restorecond/restore.c
> > +++ b/restorecond/restore.c
> > @@ -1,16 +1,4 @@
> >  #include "restore.h"
> > -#include <glob.h>
> > -
> > -#ifndef GLOB_TILDE
> > -#define GLOB_TILDE 0
> > -#endif
> > -
> > -#ifndef GLOB_BRACE
> > -#define GLOB_BRACE 0
> > -#endif
> > -
> > -char **exclude_list;
> > -static int exclude_count;
> >
> >  void restore_init(struct restore_opts *opts)
> >  {
> > @@ -49,8 +37,4 @@ void restore_init(struct restore_opts *opts)
> >                         exit(-1);
> >                 }
> >         }
> > -
> > -       if (exclude_list)
> > -               selinux_restorecon_set_exclude_list(
> > -                       (const char **)exclude_list);
>
> Seems like we could prune much of the earlier parts of restore_init() too=
?

I went ahead and merged this to fix the build breakage from the previous on=
e.
>
> >  }
> > diff --git a/restorecond/restore.h b/restorecond/restore.h
> > index 17f0bc37..51b105ca 100644
> > --- a/restorecond/restore.h
> > +++ b/restorecond/restore.h
> > @@ -45,6 +45,5 @@ struct restore_opts {
> >  };
> >
> >  void restore_init(struct restore_opts *opts);
> > -extern char **exclude_list;
> >
> >  #endif
> > diff --git a/restorecond/watch.c b/restorecond/watch.c
> > index 30dfb8b5..a795ff59 100644
> > --- a/restorecond/watch.c
> > +++ b/restorecond/watch.c
> > @@ -25,10 +25,6 @@
> >  #define GLOB_TILDE 0
> >  #endif
> >
> > -#ifndef GLOB_BRACE
> > -#define GLOB_BRACE 0
> > -#endif
> > -
>
> Wondering if we still need/want the GLOB_TILDE definition above either.
> Didn't protect GLOB_ALTDIRFUNC that way and they are both dependent on
> the same conditional.
>
> >  /* size of the event structure, not counting name */
> >  #define EVENT_SIZE (sizeof(struct inotify_event))
> >  /* reasonable guess as to size of 1024 events */
> > --
> > 2.53.0
> >
> >
