Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDCD2582
	for <selinux@vger.kernel.org>; Mon, 15 Sep 2025 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757959328; cv=none; b=Htk6RVt9achXe1Jq2BFDis3KqwY0/pALPfLG7o7KbffAYDcm3oEZgOyKErD3Ji9NQZeVk97NmcYnOAH8mVPNHbeF8MN0GWnNJ7P1VMRqSmYSgEv1qK/mUyddxRCDQUCcjZryfsOQ5kejOqVAgZgibBjZ7+qkuwiL0OoPHXqbbhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757959328; c=relaxed/simple;
	bh=V3zZNZrQ0y+msnFSdsSQ6z0SBQEfCCdiUtmdV8TgHq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rDmCcKsYvTzvqVGdtDwuE3kHMsT+kOCE/G5la2heG1EahWIeUOaMpuHhUBYkCY66TRioNNi5+CYNYuoWYzkGxIXJ20GHpqX/e0+5PuvxwGnudumGN+EVCw1u2EUTRgxFdskhRGx3WcUli9a9vIZLlz3c+pqdVSHPOm5ghwp07z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9HsGfz9; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9HsGfz9"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32e1c68d806so1432341a91.2
        for <selinux@vger.kernel.org>; Mon, 15 Sep 2025 11:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757959326; x=1758564126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQKS2yjAPcOedlcni0ifV9QlhJlD6b3YODxE/G3YJZ4=;
        b=M9HsGfz9ThMtEycjzef7PVNZvI7eSThEppXoP9NO6xYP0t3oxdPMMj+e+KFEwpw15i
         hR7DJaEgjec9bHLPMDTfWDvnKUiSErLn56B0OOOMnA2YMsq/GGRJuj9pGDpRzuPqVIhh
         csKedI/asKCob0pW/4xbXOh+gqERjZ9iI+S2ZC1ML8kgIxJsDS8vqr0I7K00PkCp51pq
         y2IPYS2A74UO4TjhJie0DQOU41YtYmE8ivx6i+IjKgRIyFc8IuP88DmpPmymVimr6lrc
         BeSPhc+BTxorh6UBF++TWg5X2euKjoOXTzmyY0cYm40QdCwylvlju0Bt/2p+PoNuQBFA
         2plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757959326; x=1758564126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQKS2yjAPcOedlcni0ifV9QlhJlD6b3YODxE/G3YJZ4=;
        b=Rg9FwpZfGs2FgPZxY1S1dwlZNLqpvTLS0VFZJuFJ+m9UQw/p0MZ4FwxdGo+l71QqxL
         XdFidp1S8x76saSBz3OcMY7cr0mSd/ZN9o0yyb//utHA8No0cXU9R7ggpG6Htmw5IfKD
         nGS07z9E3/V0KJ7a9/9CVnmn9yBpfqvyWxuI2tKzU0WDu0hNYQWGuYdQUd/uOQ5/mNmV
         KWf3s5/LQAiyThUfI/3bbthrCfSav7YWc7nRqn1IW0Ol1HFGnEh42EZ2hxHfDceMHbLc
         oajEoalwix5myR7fJV980Gurxu3kfygtN6yJJt0wy1ctwGjIiPG69P54WPJOEZ0tngHE
         JBTQ==
X-Gm-Message-State: AOJu0YxzPcW7hSZKQj5r0ixhR81Uyukqz281rokqjHPyzZ1Z+/NvXzOy
	8vqFJbXKohVJZQOXZaIwkZx02GfsADvbkywVe2DT8Sp862F2ueVDiy9c6NrxK3hhieNwNBawfzV
	pWho1lMqLhVR85hxEj3LSpAFoiZeDbYE=
X-Gm-Gg: ASbGncvUIhJo5s45Uhr6JMBqGs0oJoZcSIDFM0KUlCMi90gufwCGdYjkPeUzbvjXDHw
	rpsSvNlb8IlSDZrIdOoZZKvdCdM3glL7hhmWWA/wx4NwO/7ntBv0e25EXzRHIzoac42a1FIWDZc
	17rcQ4MDK4MKjDq01SzDh/qQscPp/fp9gCqlD0wQj4SNaayeXZd7fp4dn8Q9QOHhAklsL+mRI+A
	3MapCjYVrNTeTfHtc/oq5xtFq4ZV3BorqaA
X-Google-Smtp-Source: AGHT+IHh+c5W5TnhYR7dVKbXOz7nNNGtGO1tkcX/sCUJ0eVvtGyKtPNVbJQ/9V0HsqRmRDpjha3fCqCWwk3A/utezPQ=
X-Received: by 2002:a17:90b:4c52:b0:32e:36f4:6fd2 with SMTP id
 98e67ed59e1d1-32e36f47c78mr6530224a91.4.1757959325598; Mon, 15 Sep 2025
 11:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7a27eed6-9554-4f6a-9f2f-2cb1efc522fb@penurio.us>
In-Reply-To: <7a27eed6-9554-4f6a-9f2f-2cb1efc522fb@penurio.us>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Sep 2025 14:01:53 -0400
X-Gm-Features: Ac12FXyVrtZMx2Wg46DEE0pQLdxFME4-LHtTbrS2Bxg0xU5CH7uYQqsq_Erkh5k
Message-ID: <CAEjxPJ5F5YtqqOb+KTiC4-ED+0YMAOLfKnABNnggjK_N2hhzjA@mail.gmail.com>
Subject: Re: Lack of official hosted macro documentation
To: Ian Pilcher <ian@penurio.us>, Chris PeBenito <pebenito@ieee.org>
Cc: SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 1:56=E2=80=AFPM Ian Pilcher <ian@penurio.us> wrote:
>
> TL;DR - Writing policy modules is harder than it needs to be, because
> the documentation for the macros/interfaces in the reference policy is
> not easily discoverable.  This could be helped by hosting the generated
> HTML documentation in a location that would be indexed/processed by
> search engines and AI chatbots.
>
> Over the weekend, I wrote a policy module that allows a containerized
> service (running as container_t) to access shared content
> (public_content_t and/or public_content_rw_t).
>
> > policy_module(container-public-content, 0)
> >
> > require {
> >       type container_t;
> > };
> >
> > bool container_read_public_content false;
> > if container_read_public_content {
> >       miscfiles_read_public_files(container_t)
> > }
> >
> > bool container_manage_public_content false;
> > if container_manage_public_content {
> >       miscfiles_manage_public_files(container_t)
> > }
>
> In the end, it turned out to be extremely simple, but it took me most of
> a day to do this, because it took me that long to figure out the names
> of the macros that I should be using.  I finally discovered the
> miscfiles_read_public_files and miscfiles_manage_public_files in the
> apache.te source file, but that was only after I wasted several hours
> asking search engines and AI chatbots what macro I should use for this
> purpose.
>
> I was pretty sure that macros like these had to exist, but I was never
> able to discover them through Google searches, Google Gemini, or
> ChatGPT.  (Google Gemini hallucinated a non-existent fs_read_access
> macro; ChatGPT did a bit better and referred me to
> files_read_public_content, which was real, but has been removed.)
>
>  From my POV, the problem is that documentation of the macros and
> interfaces in the reference policy is *reference* documentation, which
> is helpful if one needs the details of a known thing, but isn't helpful
> in actually identifying what thing one should use to accomplish a given
> task.
>
> Fortunately, search engines and AIs have become pretty darn good at
> processing reference-style documentation and answering "what should I
> use to do this thing?" type questions (occasional hallucinations aside).
> But this only works if said reference documentation is available for the
> search engine/AI to index/process.  AFAICT, the generated HTML docs are
> not available online anywhere (at least not anywhere that seems remotely
> official).
>
> It feels like having this documentation hosted in a place where it is
> visible to these tools and given the appropriate weight (i.e. not just
> a copy of the docs on Joe Rando's web site) would go a long way toward
> making these macros more discoverable, which would make it much easier
> for policy authors to use them.
>
> Thanks for reading my screed.  :-)

Great idea. I thought we actually used to have something like this but
am not finding it now.
Chris, any clues?
