Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B473F2D9493
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759843476; cv=none; b=Z8irWd/EBY6CAWqdRu0Onxa2c0swtvEq3qhaoVbJ0WdU+050BAZLNL2F4TvcZoFms4uiD4Nd27kkDuL7uXVubjN1HV610H6NOHWl6jWr3heUEShqSyMm9sPKWCJLQJ92ubSys/oLtbOxRd4lVfWkwt3V1cPef/VTrHM2oOcSOTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759843476; c=relaxed/simple;
	bh=4neoBKr9Xbk8vvyuoIfG4bNpp4edq+f5MBBiKjB3a60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfI9d67MKQLcpbU7lZOvtOpwpf1oUjmCid8KljvTrcYnmYyg2IjCfr9ZYqsX2C2iaOvmMPJbpyzhCKreQF6DZsClwS0wTpDwJ0aNEGeSiKIe/ZzrKM4rbrBnmHj90Yjd2dR09QRoLHPfcA5f63/XRdi4mgkq5kQbQEbugjCI9L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ow78tKY2; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ow78tKY2"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-339d53f4960so3342827a91.3
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 06:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759843474; x=1760448274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLz07rqWF8q6MjNOZtn+w6UvMaWhASlvOCgvZqB1AO0=;
        b=Ow78tKY2Z0BaJQDcx6dHFJkqrSDWJeSH5ZEA+7W2tAf+2yRsLGWnLLZQbmV4MOGr4v
         pmokt6KScl82SZMKa9oNLtIVXkzWx/huJubtl5uZmh9B7WQS9Hz+0CdnKhWdpvLRH18R
         2XFEzALgOKOrkrKk0uy2Ftir24fwJ+fxF5HvoHYrRW6YTJUazIsP2zmya3dm+aDyd2Un
         2LNNjfJw/YPrRtaxs0+5KizOTAnaGgCFLn2XWotb2tkcaVqsYLNX4oyPoEXATga1orTK
         C0PALc+AHr0QzMBQzqK8CzT82zCBTTHmflk8d8/WC+FVuODZvpfa6MTVCyzO6/wAZyWl
         jSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759843474; x=1760448274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLz07rqWF8q6MjNOZtn+w6UvMaWhASlvOCgvZqB1AO0=;
        b=j9SxtFQ9Zo+Zxi/1UbI/jXXBYKhT7eRhINJt/W3+6Bww2TGNVCNOOCeRo0nndU8UVL
         7L10OXQ5PRILQXbN118Cm3+coUg5QBS/GpR0f24RaMxaRrfIuwazbBU3PAmnxhwk6Grx
         TQyg5MMKCBWEB4YiNvSDIZi1hqbiC64k0f2MZgXKm3No9P0udTnJVZrEhLlzt5+EzLD6
         9H2IVhbmlJWVGNKDlUBiIlYx82a47Kd67n/HA/kr5gB3kjT6hrpaL9YxK59BahhwUUn6
         6SJTg7m0r215fwItPgVaWLUdcLrroszfIrth3IfodFBgo1vx8Hi5xzWDV/xfCltLkuSA
         Dquw==
X-Forwarded-Encrypted: i=1; AJvYcCXJa+K3MIyr0DF4NjIyU4363mTv1SvMyYPLDiJw8guyHNcz928S6tZ8T8j0RxuU7uUSYq1dsi+u@vger.kernel.org
X-Gm-Message-State: AOJu0YwJTIM1670MNIUqTmWw9HOSTwuvz0aIgXXueyPhU4g3zjMtV9GU
	6x+n+hzhIexpSmzFTbNUwVkGikIkqva8cYyP5MAkG/aAU+m3gE7TzqFtJOL4zepq26qCxX3mYFu
	vSXNCxO3oLCgpSL+Im7DVcdiMpL1MYGRpZw==
X-Gm-Gg: ASbGncthMfBNoZjAiXJV+Y+fkqVHKtdSktsi2v/Wfpb5bYj0l7/0kcvgFI23y5wGVMe
	a77UDI7a/dlveNDNp5FlEGWLcrp6LIKEf26fIMa9++578W02J8/xdFhAj4SZuvexHfVoQtpHE6u
	NSZ8oN5BpeRmxmog/elHqvN0/CLR8S8fKsMZpNTm3IkpGhn/VeM2O88+GmP2WIZXNTmjipm59Iq
	wKyMh/7wEUsJ3N/3F/D2MlNrIc/HlR8nEo7vxKtrQ==
X-Google-Smtp-Source: AGHT+IHl7K/9rdw1kiAcPZjVEWgO9R2a6QBnIZqqKSxujLr09FkfOU/JsjzYzfa27bCWBfDm6jlwcdyWi+1Eh/YZLpQ=
X-Received: by 2002:a17:90b:4b8a:b0:32e:3552:8c79 with SMTP id
 98e67ed59e1d1-339c279977dmr21669554a91.29.1759843473768; Tue, 07 Oct 2025
 06:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007104656.479127-1-nvraxn@gmail.com> <DDC1IZN24NIU.YAASI575IJPX@gmail.com>
In-Reply-To: <DDC1IZN24NIU.YAASI575IJPX@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Oct 2025 09:24:22 -0400
X-Gm-Features: AS18NWD-J0jOhStjFD8eedhKKeXMrZhmuCmXxIeTtmd5FprpwuJnZ6qLQNYvjGA
Message-ID: <CAEjxPJ6KhLNWkWnGv=SU4podyVXiSH=jooF95oNuGbVFzN0HVg@mail.gmail.com>
Subject: Re: [PATCH v3] treewide: add .clang-format configuration file
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: lautrbach@redhat.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 7:07=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wrot=
e:
>
> On Tue Oct 7, 2025 at 11:46 AM, Rahul Sandhu wrote:
> >
> >Currently only an RFC.
> >
> >Add the .clang-format configuration file, taken from the Linux kernel
> >repository. We don't have any official style guidelines in tree at
> >present, which makes it a bit unclear how to format C code for new
> >contributors. As well as this, different parts of the codebase seem to
> >been formatted with different styles on occasion, so using an automatic
> >formatter should resolve this.
> >
> >As well as this, replace all the existing indent targets with format
> >targets. Commands used to find and replace those targets:
> >
> >git grep -l -E '(\.\./)*scripts/Lindent' | xargs sed -i -E 's@(\.\./)*sc=
ripts/Lindent@clang-format -i@g'
> >git grep -l 'indent' -- '*Makefile' | xargs sed -i 's/indent/format/g'
> >
> >Also add some empty format targets to Makefiles that previously were
> >missing an indent target so that `make format` does not error.
> >
> >A few other things to consider to do in the future:
> >1. Reformat all existing code. I understand this is a big change, hence
> >   the RFC, but we may as well get all code formatted if we go down
> >   this route; afterall, it's not like this will cause any breaking
> >   changes.
> >2. Possibly add a CI target to check that all code is formatted as per
> >   the new clang-format configuration? The options `--dry-run` as well
> >   as `-Werror` can be passed to clang-format for this.
> >
> >Comments/feedback appreciated, thanks.
> >
> >Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
> >---

> Oops, I forgot to send this as an RFC, apologies - it still is one! I'll
> sent the next patch as an RFC again.
>
> While we're still talking about code style/formatting, I think it also
> would be nice to add some clarification about usage of braces. Right
> now, the usage of bracing is somewhat mixed: there are many places where
> one line statements don't have braces, and vice versa. It would be good
> to decide what the style regarding braces would be here and add it to
> the CONTRIBUTING guide.
>
> Regarding my own personal opinion, I think it would be best off to have
> braces surrounding all statements (if/for/while, etc). It adds
> consistency to all of those kinds of statements, and it also helps avoid
> bugs such as the infamous `goto fail;` vulnerability[1]. It's a fairly
> small trade off for a bit of added safety. However, maintainer opinions
> are of course very much welcome here.

I would tend to be consistent with the kernel CodingStyle i.e. no { }
for singe-line statements, but this is not a hill I will die on.
