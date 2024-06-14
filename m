Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA228945A
	for <selinux@vger.kernel.org>; Fri, 14 Jun 2024 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374492; cv=none; b=HU+KQbzX/9kQUINTzkG/nZUwr15RA2jhi77qVKy45R+oWHgn/ViTQVLrY4HrjNhHHrziprrDMkuGWiTSa7oSnDF4BeV157toXTs0YAfAIBzz5yiN60NbtW/9U3Ttua1L+AYP1Il0PDqnJJ70F6LYZuX8gQS5RqymxP50evCwr7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374492; c=relaxed/simple;
	bh=l7bteo1j/d7oViNgFnHj+vKjQW9NNK9sNg9KtIEsHwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHGgBzx3zVcExSd7QeH13zHvylLiSwg0okdI6UvgrnkrsbNXfW4vo4XcOYB50nQhDkjMhycSIcnOv8iNDDo64zz6ogakPC0i50cQXfy3we//FX9GY3XSO/6DbMW87xHFkZldkZMDSgklttTRgHNrw966ITzvh/aTxUO0DHvLA2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CflP4MCF; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CflP4MCF"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f361af4cb6so668258a34.3
        for <selinux@vger.kernel.org>; Fri, 14 Jun 2024 07:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718374490; x=1718979290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/V5zxf+DdnMoz7UC5kUA77f7nSfdUpKtmXapGRvzMI=;
        b=CflP4MCFjG09VVQXkWoET61GdNdDgZnLZEJL26/5bO6F+sDF2Tg3v3pnchu8Lqs4GE
         89Uqt4L0CorS+tLZHdWWV9a3UldYGnmHmlT0jk7l8ZI05GSHrPsagyI+hyH1ei8VkJ0L
         Dk/XmWj4g4O8Rx4JmIm4SwsjrKqQjg05fnobKHtEC5qi8BaFVNp/qvHfKaAWjZFAaTp7
         011HnlayjvgLBTP4pWi3ILX0JdhzrvlDCS6qRCw9JYN6Q4M0sXZ+rra3jYW+twNDWRtM
         yeSEiN9dsJjP3YaDdNSsu/H25aAPPdqPLVrPLOazUY7dhFyRcCdr3B/1mI756PiNCSug
         w9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374490; x=1718979290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/V5zxf+DdnMoz7UC5kUA77f7nSfdUpKtmXapGRvzMI=;
        b=PHSkjJNd3S/6Jvf+1e9S7md71QfHrBja2jOmW6BE1zlEZMCLlkHnx/n/HJV9rovctr
         txkst4wjgaJlom7htNlAJuv0Gk0/hCY3lBPNDnuQdZ9X1fgHF6vfIT7IWWXx8lyaz7Sz
         AJ/lmbWDNhjQu9v/Qh8uMKkpik8xMneqd5hDB0zrhsDcDvkM9AnQs3ShaiqQWgRmot+z
         5bVViPSvtFIrrs1MYxqd7n8F8WGgzQj1uRQDz40s301ueTw5dA/ZgvWw9fxUXrTfMNVv
         jlm7FXg5zQsdSPX7iS2pMhWNi/cYZrlf0ByO8Kz+7qtIy6lj8ennMIuISjbwB8sH/TmG
         3R8Q==
X-Gm-Message-State: AOJu0YwA+8AhP82yaWKvooRyMQDh0BPrkTRZmJefbDeTYn/LmeNjmB9P
	8zP+lBA1hUTyjmrS4p+0v+XY/kEYni1sOAGbTxpTgBezgf/Bmbt2wopJW/rQxAYPTkBEpOXvusG
	2ww51xnc0RapoQXUCFBDoTCi7Hpl9qg==
X-Google-Smtp-Source: AGHT+IEYREvurZD70J6pI1u+K33byXugyXuC+1y0x+dUxvCV/iSlrbovqlZh2KYNKbzHVupny4RZOFXrzt9U4IQZUKU=
X-Received: by 2002:a05:6808:1a27:b0:3d2:1cc6:9d67 with SMTP id
 5614622812f47-3d24e91a5f7mr3483293b6e.31.1718374488534; Fri, 14 Jun 2024
 07:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608172025.137795-1-cgoettsche@seltendoof.de>
 <20240608172025.137795-2-cgoettsche@seltendoof.de> <CAP+JOzSHwFvpuT-u9n3Ym9bYafK73qf6J-2_3DV1UrYVDMtJAA@mail.gmail.com>
In-Reply-To: <CAP+JOzSHwFvpuT-u9n3Ym9bYafK73qf6J-2_3DV1UrYVDMtJAA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 14 Jun 2024 10:14:37 -0400
Message-ID: <CAP+JOzS8+9TD=p-_n3BqSNOKGqc4x9LRV-kC3ZWqyOcscZjpcA@mail.gmail.com>
Subject: Re: [PATCH 2/2] libselinux: constify avc_open(3) parameter
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 4:38=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Sat, Jun 8, 2024 at 1:20=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > The option array passed to avc_open(3) is only read from.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

I merged only this patch, not the first one in the series.
Thanks,
Jim

> > ---
> >  libselinux/include/selinux/avc.h | 2 +-
> >  libselinux/man/man3/avc_open.3   | 2 +-
> >  libselinux/src/avc.c             | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/libselinux/include/selinux/avc.h b/libselinux/include/seli=
nux/avc.h
> > index 4bbd2382..1f79ba16 100644
> > --- a/libselinux/include/selinux/avc.h
> > +++ b/libselinux/include/selinux/avc.h
> > @@ -215,7 +215,7 @@ extern int avc_init(const char *msgprefix,
> >   * is set to "avc" and any callbacks desired should be specified via
> >   * selinux_set_callback().  Available options are listed above.
> >   */
> > -extern int avc_open(struct selinux_opt *opts, unsigned nopts);
> > +extern int avc_open(const struct selinux_opt *opts, unsigned nopts);
> >
> >  /**
> >   * avc_cleanup - Remove unused SIDs and AVC entries.
> > diff --git a/libselinux/man/man3/avc_open.3 b/libselinux/man/man3/avc_o=
pen.3
> > index 55683bb6..74f85593 100644
> > --- a/libselinux/man/man3/avc_open.3
> > +++ b/libselinux/man/man3/avc_open.3
> > @@ -10,7 +10,7 @@ avc_open, avc_destroy, avc_reset, avc_cleanup \- user=
space SELinux AVC setup and
> >  .br
> >  .B #include <selinux/avc.h>
> >  .sp
> > -.BI "int avc_open(struct selinux_opt *" options ", unsigned " nopt ");=
"
> > +.BI "int avc_open(const struct selinux_opt *" options ", unsigned " no=
pt ");"
> >  .sp
> >  .BI "void avc_destroy(void);"
> >  .sp
> > diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
> > index ce87ac16..7af5d192 100644
> > --- a/libselinux/src/avc.c
> > +++ b/libselinux/src/avc.c
> > @@ -225,7 +225,7 @@ static int avc_init_internal(const char *prefix,
> >         return rc;
> >  }
> >
> > -int avc_open(struct selinux_opt *opts, unsigned nopts)
> > +int avc_open(const struct selinux_opt *opts, unsigned nopts)
> >  {
> >         avc_setenforce =3D 0;
> >
> > --
> > 2.45.1
> >
> >
