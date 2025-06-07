Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA5A2F3E
	for <selinux@vger.kernel.org>; Sat,  7 Jun 2025 02:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749262426; cv=none; b=chdTOxgc8/D66FV22Boa3vpTavJPivI0U721TrMNQ8ZRlE2hG1XvlbnchfoBBU/YgicWZfFKRSfvi25Jqziq8lzBdv9fK0YzfMcH4G13v+cROD7Y+PAhLYZaiw/Hsvl3M507EU/pCV3ba2qwYoImizjO/hsUvKg2lEKYCgDxS8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749262426; c=relaxed/simple;
	bh=2JwGV43wzlRSrojUmJUgObX1skwQVYpZ+N5faY3DATg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDaUgfB4jYVhC+ROqSH3H6TJvBnCtnr2sQtuLnloibc6P2No/LEiUNl72PMmF+NKBYtvSaE5xJzv1u0VmmgkW9Zlu+5XLf56AxnA2g/7xfmpYfcW3i2qGlaCqEAyXMlI4YRxF7wr3FZY/YoyN4ovgvYhNBBTNTVuh4UijjdUaNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=avh1x6PW; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="avh1x6PW"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7086dcab64bso24651397b3.1
        for <selinux@vger.kernel.org>; Fri, 06 Jun 2025 19:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749262423; x=1749867223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JwGV43wzlRSrojUmJUgObX1skwQVYpZ+N5faY3DATg=;
        b=avh1x6PWOx85l3AsMZnUiYhmCQgwwW2yiqHkS7GV3FKxfMRuLscNYNCQMNcx8zjxBW
         quqHairO4EAWkGMc8aBc+XtgRdOEos8ngrPkssnti9GjAZJXi7IFuT6f3Vz/ktgy1cgY
         aDif+QxBOKoPzAzdQagZ8SodTSYGeWqOgl1ZYjjMx6pgyW3ArkN/EjBWtS7uQTz2WSrK
         ghbaMLxNc9B+pni7RbTnW9NRux6kY+3XATYWE61G1WFma1MmcrXSVIVt8OM2kFOBBGFW
         EtE3J1P3lI2QCWT1J11wlHsVrcTXBc9jsZq6CVHN+MitX5stjInjQsT+6N2rY19xzf3c
         ja2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749262423; x=1749867223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JwGV43wzlRSrojUmJUgObX1skwQVYpZ+N5faY3DATg=;
        b=tznHhp7D0W/kDcQWzrQEi3QWQfMTwLlyaBJcxZUa8aHT039lZMZQsV2jn41SWLwl3V
         UL/oct8sbWltjUlRhEhUCmcNEMun/jGIO9xxbEsTbhixwtaRQ6Hy95vWN/h5xMqV0Fif
         sP6+VEs9y8x0EcHXsFjeH6yT3WfPge9z8T8oZdRV8xvapbCoVorHCFXQ5nemFvBw2iuR
         fnpLOQcSN6MKPYK2V5DrieW+WY5j84AWpzW2QoxtZiqtQG4Ag85/y6osK3T2n68AVTJJ
         Av17OSe4ppxOLBEm+n9Heie4xmiH09yb2W/hbvIQMfZA/a//VWreZJdxfJtg6+lZJYwC
         kkww==
X-Forwarded-Encrypted: i=1; AJvYcCW3if1/tHXhJdxw7vMU62PgGCxUIHDXr7sJtHhaf9kPGXxY/+mG3N+XbPbrSUvsliWLc9jolY7U@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq38xVmXh0Q5/hNXMYdy1iXsY3YIpGZplruDoVyuno947hn/S+
	TbRRFvFQTT1mCy9lURutdu1PsD8zc6B8/ClIh2N1GgwecJc8tSyHwxnChEAWfKZ3wxWM9Hoki3c
	wVkWsKC9uql8+8hHWuP3hodd/hX69ThxRjVsl+OgtZYTWswKbGAiXQA==
X-Gm-Gg: ASbGncv6vrx18MJveEGeTIGBWmi+A8a3O5/J2qtttLxVbyIT7iw0+xTAJP+G1PSo8wR
	RDvjOvPrDA5o5ulFn1xft2ajuNUj1x33fD+kKBKuA1jKH1qifa08+Kq+BOulL558xgV7Cxgxv/j
	WlaamtoNMAaIs5inKjMhpFvWSGGLIOGBtN
X-Google-Smtp-Source: AGHT+IEkJgWIrNtd67mecst1dICdKj36y4rrO9XoD1RJKlCI//mWo2ZBG1Z1Lw2/t+5Zr8XJ+X1idHio5xfITDbqvro=
X-Received: by 2002:a05:690c:488a:b0:70e:2b60:1562 with SMTP id
 00721157ae682-710f7697b7amr80075227b3.16.1749262423080; Fri, 06 Jun 2025
 19:13:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ6P6oH4nUMwhFs=ctDekm3CHVtGgp+gx0QCjxZz5d4TCA@mail.gmail.com>
 <CAEjxPJ7RbPCdJsO=CeRSisa+1=eLNOSkVWByGb2sdF1VUCLCCw@mail.gmail.com>
 <CAEjxPJ5PHAU-_ru9=zN_iuvLGEGDxL_T50-fW4XecnZ6p2ww8A@mail.gmail.com> <87zfeky6lz.fsf@defensec.nl>
In-Reply-To: <87zfeky6lz.fsf@defensec.nl>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 6 Jun 2025 22:13:32 -0400
X-Gm-Features: AX0GCFsHouq264i7rPvQVZdMWdNlhWF8xQTDQ1EVxBXsPe6hqi7AurmQ1FX4WmM
Message-ID: <CAHC9VhT-e8=TrjVcMYW8um_DrA1V1u6m+qrH1JCQ_3fxJY__Ww@mail.gmail.com>
Subject: Re: selinux userspace wiki
To: Dominick Grift <dominick.grift@defensec.nl>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 4:13=E2=80=AFPM Dominick Grift
<dominick.grift@defensec.nl> wrote:
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
> > On Thu, Jun 5, 2025 at 3:05=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >>
> >> On Thu, Jun 5, 2025 at 3:03=E2=80=AFPM Stephen Smalley
> >> <stephen.smalley.work@gmail.com> wrote:
> >> >
> >> > Since I created a Getting Started guide under the selinux-kernel wik=
i
> >> > [1], I also did some refreshing of the selinux userspace wiki [2],
> >> > moved the Presentations and Papers sections from the kernel wiki to
> >> > the latter, and cross-linked them for easy discovery. However, I had=
 a
> >> > few questions about the selinux userspace wiki:
> >> >
> >> > 1. The Home page and the Userspace Packages page are at least partly
> >> > redundant in their content, and the actual list of userspace package=
s
> >> > modified for SELinux was very out of date (I added a note to that
> >> > effect and how to query for a more current/accurate set). Should we
> >> > drop one or the other or somehow combine them?
> >> >
> >> > 2. The Tools page is likewise quite out of date. Do we want to refre=
sh
> >> > it (and if so, does anyone want to do so), or drop it?
> >>
> >> Sorry, forgot to include the links:
> >>
> >> [1] https://github.com/selinuxproject/selinux-kernel/wiki
> >> [2] https://github.com/SELinuxProject/selinux/wiki
> >
> > I refreshed the Tools page, deleted the custom sidebar that was
> > (presumably unintentionally) hiding several child pages, and moved the
> > Other Resources section to its own sub-page,
> > https://github.com/SELinuxProject/selinux/wiki/Other-Resources
> > and made further additions to the Presentations and Papers sub-page,
> > https://github.com/SELinuxProject/selinux/wiki/Presentations-and-Papers
> >
> > Feel free to suggest others that should be added or if you are a
> > maintainer, to add them yourself.
> >
> > Another question about the old content: the Contributing page lists an
> > IRC channel. Is it still correct and used by maintainers? If not,
> > should remove or update appropriately.
> >
>
> Yes #selinux on libera.chat is still correct and used by maintainers.

... and I'll add that Dominick has been doing a tremendous job, over
many years, providing help and support over the IRC channel too!

--=20
paul-moore.com
