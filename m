Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742D921ABD7
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290878; cv=pass; b=QQ9cgjWShnQFsA8n0SWEVj6nc5v774zhMynSlMA0gxYrGZ15lSX4B+Ri/n00LL7q3wEe0pTqyoWWI8btw6twy46b6VptOHHKGd1YHAR559bWT0+OjZcY06JxnF1GrpSwn0/PBlHm9jRoSQ+HEJ8IlqXHQqWrcJBgYlZ9T3xPzWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290878; c=relaxed/simple;
	bh=WzgeBRr/eURsU54JUrMKMn8/TLIgkGsHOwVK+I3VPJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCmlVvTj2bflQ/kRwi8AUoXtCLdybOPbONqiNTIbzW+49IeTxSuQI8oftYXF3Vz/J1RJWCa87aUv3hA2qg+BETqFCTPK5MVi+asOgI7rOmovb3PXG078dxq+/XPAoVGoRcK9MLZMCYhnXbqlNm01Anr2TyMpvDt/iJKz89hFy4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=qZXN8Yk+; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="qZXN8Yk+"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65c5361142fso4956367d50.0
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 08:27:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779290876; cv=none;
        d=google.com; s=arc-20240605;
        b=c5HwBYGAuI1nd9moVgnf08iIo1X4SJS4VbMgRqW8Ww7yheVxbTlbIVp3zaxZF5jtnQ
         sWbyKIXp2HCeMmLI0XtTdiNjpHSMez724JAZnKKvpmDwp0rBnoI5Qh6fcwrq6tht+1p8
         uw/Vt+8liGN2khK7Lqr0h58iBksVHvgjo7aWz2eiYjZlEQJZFdKQRFcpp7XlwMwhl39R
         bpdorkOYYiUIHhncWsY7S9PHcPWbuVnRQVJV7efDvBooAVTluscif2fHwMhVI0LxKmIv
         QBjp1xaYeHNDAF4TX2DR1b7jrEjDXC55SYhXe0eVYTVJOXNFyffI58PAk6cqwkYAq7/S
         YysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qKHBfRHU6gbov3vZFV+ScuwKB0/CNC4Rmf+ox5OoDGc=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=Eux7vXfVXP/84ihvu23iaSEMuSHPD+q8fvvChBYCWfJECB3r8cb3RCgH8VqBWayXbb
         /2fG9h9LXqs7Kx1Uzwn7i1UpXzr1yIz7tMUZI+25ZP0qk/LAOCY8G7KSRTNYsFxziwX1
         oRWItDfXKYyUZE99Qcg8zceIJZlEuPgl4ffgzwOg8G6bRDCFxxj91DGEQNla0h152Mgs
         VX3sD2JqIBqsl8JWPHM9g3vDw9L9Qk6EiL9UMpOZ7apXQUym3SqT+ERxujODNFLEVlUw
         mYddAfOYdSMpSEq0m5/DQRSIZs+Y2L56Lo2weXNJyQkmraFJvrQuiWAi7quAodQa98ZG
         rLrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1779290876; x=1779895676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKHBfRHU6gbov3vZFV+ScuwKB0/CNC4Rmf+ox5OoDGc=;
        b=qZXN8Yk+Pm9QsLT1WVcOmc4ArOHbXtmI4FAP6f7FduOX1keK0TPVqBcHCCpGVA+mgj
         mRf/JxUtDsQ8SoiRZnNIKDdO1wvRJMXJ+VTyHLiSqwEQ27XJDd92gq+dbQ4+0OI/doik
         1SSEKBxy48B9osvCyVdTnWpo1GopP5WkvgsanD8TUAxsSHOGcI22zC+6pDgBQF5/rEJ6
         pfwFOmb4REknYebyxR2GmUgRGo6QupFbvT9grNmrVLAP3MpDPDT/dW8UGsz6bMgE9Spc
         ddMvKypH9/xHLqAfNtxTBhaU+KsG3tgeFg9V0Nw/i7557Iry1/nS+WG+CabqYnPdN33w
         dCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779290876; x=1779895676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qKHBfRHU6gbov3vZFV+ScuwKB0/CNC4Rmf+ox5OoDGc=;
        b=MtZYsGDynGHE9u4/m3MAysmWxVO899vM/XFMkAT0eLLa+dyO1WDYLr6GyyU9ghT58C
         8C6ZRIZt8xu02h4zuN4QhC3ZgdXePtfsbl+YSpr+1mjCI/y9+HO92fO3zQH7/LE9K36c
         ManniVH57tOZ+ZDCXzZ7djzMRkEt7UZ7e1PJaw2y5sTuLpWBP5wy/Ua8nnuHDikY6kwv
         L3v5JkqwuGtqvseMSCWKKNpUpz3mfgDwE5bNgBXMYhzvkCE6UzLJHYVcyqswp3kEwOjf
         e8CNUhQ7kaht8TOECNorbhrGdNYlaDTr5n7ydXmdpUQNuCVTbZK1BFuU1GDqMjfD3Hrx
         xB7w==
X-Gm-Message-State: AOJu0Yx1ZiS4FwR5uGAtPfvytrr9mUsC0jASMUfPUWLuf6Km0/uuEHAp
	YTGaT10sSZl5lLh+HKxykgeiHM0yXRuMc3532TeAmzgJIjVJwEWycfTMzM8lxha4uknqVIQ/AnL
	2G8uRp7ewX3eDKjwyZ+PHDL1cB8pHU8hBJg==
X-Gm-Gg: Acq92OFunI0f3h4Pcp3ut2Jxw6zIfXEq37CwjYp85gzclQVjexNgraJn2x1py3zQ+7b
	1YACdQNY7iw3bFdoT4a1Hd5GL7A1XZnAjBuJx20rr3v+5W7zi6oraOXHiZnfD44RPogNOdSvUAj
	Q0Jweo/4BvFx0PYA7Es4nKudmUGrMcMZK7qla7k0FW41F3q1gegcgCklBQerQ11PBgi6IPXO0kl
	d8OZbmUUdv4f9XwWiBzk+49qtHrdrB2mzMvrZuM3soB3Wb7YLsMc89pTs6M2u6BJxvJOuzG0DRS
	INLzOQi3OEKOta4jWaHBUmfxWREO/D0Oyx//MGs3Iw==
X-Received: by 2002:a53:b118:0:b0:651:b73f:2046 with SMTP id
 956f58d0204a3-65e2287872emr22257269d50.59.1779290876160; Wed, 20 May 2026
 08:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520121051.20863-1-cgoettsche@seltendoof.de>
 <20260520121051.20863-2-cgoettsche@seltendoof.de> <CAEjxPJ7kiE_-X-KrHFOxDo=Qg6khJXu-4jme5qEEfs8z3PZbWQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7kiE_-X-KrHFOxDo=Qg6khJXu-4jme5qEEfs8z3PZbWQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Wed, 20 May 2026 17:27:45 +0200
X-Gm-Features: AVHnY4KBFdIWzrJiLSFAosyElI3W5961VlbGgfgsZpMwD8TbqgeFwhhHXVlQQkM
Message-ID: <CAJ2a_DfqYsvfRsGdeEA=L4CqG1X8iLo3d-UGvjG3XYabQm6QDA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] libselinux: improve restorecon progress locking
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 20 May 2026 at 15:35, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, May 20, 2026 at 8:13=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Use an atomic counter to avoid acquiring the synchronizing mutex for
> > each file.  Only acquire when actually writing to stdout.
> >
> > Suggested-by: Copilot
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> > v2: extract fc_count reset into separate commit
> > ---
> >  libselinux/src/selinux_restorecon.c | 20 +++++++++++---------
> >  1 file changed, 11 insertions(+), 9 deletions(-)
> >
> > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selin=
ux_restorecon.c
> > index 8b6eba0c..b4d58b05 100644
> > --- a/libselinux/src/selinux_restorecon.c
> > +++ b/libselinux/src/selinux_restorecon.c
> > @@ -40,8 +40,6 @@
> >  #include "label_file.h"
> >  #include "sha1.h"
> >
> > -#define STAR_COUNT 1024
> > -
> >  static struct selabel_handle *fc_sehandle =3D NULL;
> >  static bool selabel_no_digest;
> >  static char *rootpath =3D NULL;
> > @@ -734,19 +732,23 @@ static int restorecon_sb(int fd, const char *path=
name, const struct stat *sb,
> >         }
> >
> >         if (flags->progress) {
> > -               __pthread_mutex_lock(&progress_mutex);
> > -               fc_count++;
> > -               if (fc_count % STAR_COUNT =3D=3D 0) {
> > +               const unsigned STAR_COUNT =3D 1024;
> > +               uint64_t fc_count_local;
> > +
> > +               fc_count_local =3D __atomic_add_fetch(&fc_count, 1, __A=
TOMIC_RELAXED);
> > +
> > +               if (fc_count_local % STAR_COUNT =3D=3D 0) {
> > +                       __pthread_mutex_lock(&progress_mutex);
>
> Do we actually need to take a mutex at all here?

writing to stdout concurrently can interleave output, which might
break the line reset via `\r`

>
> >                         if (flags->mass_relabel && efile_count > 0) {
> > -                               float pc =3D (fc_count < efile_count) ?=
 (100.0 *
> > -                                            fc_count / efile_count) : =
100;
> > +                               float pc =3D (fc_count_local < efile_co=
unt) ? (100.0 *
> > +                                            fc_count_local / efile_cou=
nt) : 100;
> >                                 fprintf(stdout, "\r%-.1f%%", (double)pc=
);
> >                         } else {
> > -                               fprintf(stdout, "\r%" PRIu64 "k", fc_co=
unt / STAR_COUNT);
> > +                               fprintf(stdout, "\r%" PRIu64 "k", fc_co=
unt_local / STAR_COUNT);
> >                         }
> >                         fflush(stdout);
> > +                       __pthread_mutex_unlock(&progress_mutex);
> >                 }
> > -               __pthread_mutex_unlock(&progress_mutex);
> >         }
> >
> >         if (flags->add_assoc) {
> > --
> > 2.53.0
> >
> >
