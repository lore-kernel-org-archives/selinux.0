Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D201E5015
	for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 20:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731960640; cv=none; b=aRtpAr8N9UTKRJSY0Yf9Vo3ACS6bfpQROT24shmrlbnH7LKyvAl5t+dNYufV6SWMzSMI806USMvK0BhR5QPjPO+KChENA9ZDwqr2LWK1HdYr98fiGkVW8bFMKBLm6XOjAUZM+CdDlaQ6BemQXus0MWGQivdFDpoYVJ5Xs5CUYdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731960640; c=relaxed/simple;
	bh=rzUguL70uyPUyjg54+WzoA13h+OmZpabKj17DVQe8G8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hyZNPkWOouhdR/8d9JsIkkCDB0k+2Rz1/JJLghfQWeZ87LiaLlJDMPZfUY7TRsxpm4Z7EEAmTFA9xN6J+3ahq2FjC5KZh9BiDudswZABtNIXR2o5kfnF7EQJxfJ/12NnzQH9sf+bdcPqdEKqTmR5Ilq0vB4wVRpgcT0kvox8xPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejnu0XH/; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejnu0XH/"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2958ddf99a7so175434fac.2
        for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 12:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731960638; x=1732565438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7Lxry1PCEarsplIkv4GPT0J+bBXKJ5f+VzYB4zYIoY=;
        b=ejnu0XH/V+z7sqZ/24isYyUX/oiZHpwGsYhxMZsL3FjQIHr911acNFzr9VyFczt7U7
         OqlZG/hITdmB+RDX6kTYy1FNGm9e38ZhUfuEJr7cU4EA8Eo8PyalBV1q7ccLY2pVELep
         PTTsTTp+QZ3n0psoLTqmm7q9b8LM1oc8GtraNGZDJxML+exJRIIFcjQCMLwCed1BTt88
         u4ajHjf+TTjF1QYcXQTtbaYnPLSmWdgDYzENJKYwY9D0v5qlva5byxbs9ipz8RQnznlo
         +2zHvWBl7ePtdHz7Bx8TCuzELSKwvK8tbp1E6zFlD6USwmWJgw9AXQ65qVipIpKN3h2y
         N9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731960638; x=1732565438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7Lxry1PCEarsplIkv4GPT0J+bBXKJ5f+VzYB4zYIoY=;
        b=QnkRwNjR/gjB7t0udU/3Hg4Dv/zC4Ptgc/qjgD2YoaLN842krB8J5rnVkj68CKY9y+
         Q4JDes5Kw02KyoVOd6BPuFIepzCmFPSRTK0YMWQKf8DuAysmssZDBh2aii8rjQkK7lBX
         nFUnJChiGiGQ5UZsmLOGyxYXAK7JLxeHzCdm9y+VxEjzvNo7O9URyO8ri5roReVS4gKI
         VvbOY4+csinPlmEVPtNCrWbbruBXI27RIcP+47uQrnbHDPtKAKspIvrua1WKah5nJDd4
         RqOmxnMTd7JhIsoxVr7gCdmelJkJr1vjbycpDsXim7jl0YWFmUIq5DlhN3fyEPr7FDC1
         QnJQ==
X-Gm-Message-State: AOJu0Yzv+qE44HyQzk44as5HoBSrD2P8ilAovaRfZSNQ4kjAa4RrcJfL
	yqd1bvfdlx/7Cj1ZAMa63Z9k/Yy3pa8vW1PTnsjO325IG9onX/hlED2J+RK0FsO6Ph6Re2lxTPz
	4RtQzfvJe+CMLpOySit1wi+gStR6Q3w==
X-Google-Smtp-Source: AGHT+IFeag1KMK5bZrytnD/MqPvkG3BgNeu8i3pHE9wfUdEPeRt41HiHZiFt6YF+mHkB/Il3r0zOnaHOCHh0gIWkgAI=
X-Received: by 2002:a05:6808:2124:b0:3e6:56a2:d070 with SMTP id
 5614622812f47-3e7bc7a22f0mr9676696b6e.9.1731960636214; Mon, 18 Nov 2024
 12:10:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024084816.40872-1-fvogt@suse.de> <20241024084816.40872-2-fvogt@suse.de>
 <CAP+JOzShz1aBwrgadZZM8nVV_dpK3vmz9DuZU9Ld_RS_m0xxHw@mail.gmail.com>
In-Reply-To: <CAP+JOzShz1aBwrgadZZM8nVV_dpK3vmz9DuZU9Ld_RS_m0xxHw@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 18 Nov 2024 15:10:25 -0500
Message-ID: <CAP+JOzTCP2w03mrx-JYojLY-cJUWSxF13gKFpU8t-mhxt2_VDQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] restorecond: Set GLib IO channels to binary mode
To: Fabian Vogt <fvogt@suse.de>
Cc: SELinux List <selinux@vger.kernel.org>, Cathy Hu <cahu@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 8:45=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Oct 24, 2024 at 4:48=E2=80=AFAM Fabian Vogt <fvogt@suse.de> wrote=
:
> >
> > By default, GIO channels use UTF-8 as encoding, which causes issues whe=
n
> > reading binary data such as inotify events.
> >
> > Signed-off-by: Fabian Vogt <fvogt@suse.de>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These two patches have been merged.
Thanks,
Jim


> > ---
> >  restorecond/user.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/restorecond/user.c b/restorecond/user.c
> > index 3ae3ebbb7230..7188c22e3119 100644
> > --- a/restorecond/user.c
> > +++ b/restorecond/user.c
> > @@ -238,6 +238,7 @@ static int local_server(void) {
> >         }
> >         /* watch for stdin/terminal going away */
> >         GIOChannel *in =3D g_io_channel_unix_new(0);
> > +       g_io_channel_set_encoding(in, NULL, NULL);
> >         g_io_add_watch_full( in,
> >                              G_PRIORITY_HIGH,
> >                              G_IO_IN|G_IO_ERR|G_IO_HUP,
> > @@ -282,6 +283,7 @@ int server(int master_fd, const char *watch_file) {
> >         set_matchpathcon_flags(MATCHPATHCON_NOTRANS);
> >
> >         GIOChannel *c =3D g_io_channel_unix_new(master_fd);
> > +       g_io_channel_set_encoding(c, NULL, NULL);
> >
> >         g_io_add_watch_full(c,
> >                             G_PRIORITY_HIGH,
> > --
> > 2.47.0
> >
> >
