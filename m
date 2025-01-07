Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0B81F3D5D;
	Tue,  7 Jan 2025 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258671; cv=none; b=oSTnKcqHuDMvudCwu4901wnQf5lcpYO5StnIF93jLLSOjbeUAluddVtx0LxI8PrvIrCJzkGNU6jj9iXSawHGaAhn81Vokb/0sPMZnhuGCT5no5jiPYtSSd+YgAauAF5ov+Ifm9F0oBFp7Md7gnov9WWvUKzQ6Cj8hDdRxHNDEbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258671; c=relaxed/simple;
	bh=my8BlkfcoQMNumyQLcWWzAGs+ACYNFadcrEy1nawm/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTjj5YMsxVy2lgwhUAj8ozNjXY/cQQwZhFb/wkdmQw8UNHc7S2yOGuawVipo8q3TXIEiDm8iSUq2fhR+ijmlGorlsHNDtj8kNG03kgGo6jSphtYC1iEOKR7EPMMt8fd9h5mmRiqYsAPKevtqwwefaG9CV/jZPXI2RqYxSgZgarY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Hl6XbHN2; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Hl6XbHN2"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e3c8ae3a3b2so18674675276.0;
        Tue, 07 Jan 2025 06:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1736258667; x=1736863467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alPlDRFJ4s2zfqaiVuet99qmMSbEvlweaU9isG2zVDg=;
        b=Hl6XbHN2sJagkYyyOUJ2pi5AcIk7Rd3GoaC7OIEceoPb+tian8WLkCDQ2jLS0Ch4qY
         +HWb1tjDrz36gbnD0kHaXIzd4HrM7EbxGShNAB4WJ101eGL6uaU0pyX3eFrEgWUvwe4A
         LYy31QWd1sr48+LDeFfTTE/1AH3L3L3WfhItArypmrWYVqWsUBr2d4aiur5ETmPnqmOz
         clqvbTS3OX/477Rp4bXiF2WQwq7BhP20jKUip5htuP8qarRB0MTR7JQZEG+uCHt9VfBW
         wja6avSSo7k9WyONVO6tZuzoOTYa+HFiSBIWAb0KARd1BJqQg1IUaLaaFGMaE3v0aztb
         2ANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258667; x=1736863467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alPlDRFJ4s2zfqaiVuet99qmMSbEvlweaU9isG2zVDg=;
        b=DPG8hPMH+PJUzF4Md35bi0iNPKlt+8ju1vGVlXWbgIdiQOptZ70n/GHWZ+/obDjoJc
         +LmXQm/1Tmb4krfLXtFxUlW4guvtfL9jQbNZH1BUmK6WxCCwgEDU5WwPMxMlE8cPJYnC
         Efzm+1QT4DJzUtlOBAiKyLytHqi6eNm0wE8jKM9DK/hlF4uK2DkLznkfacR4uFjhiuV2
         3Yg0l4C9q5eHSrY+biLR4+f3pw3lIP2fsL1RFV7F6O7mErx7rTNTwV78i3TAF7+1a58L
         dIzYMZlqZN2/y44tDot7eKZ1Bnry6ehAf94H2kFIWG/VBxulAtLGTWAmAdzT7A/UfSMI
         rYug==
X-Forwarded-Encrypted: i=1; AJvYcCUSFSW06MCO9CmNShKNYWk19bQL6pcHZKO8/G2N7WBCybVbuSI0H38zK6V5uTL5hNlHuhMQc4xRfu9Cprg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynr3SzXVb7d1TuE0DBHZVipmj21VLUBB55YlJXuR+BGUSsKUkM
	XQjeuTfBIh7EOcAykMNu/W3zs70JwlC3ZlbK/Wew1yGgZpJfd/mzZqaaqbwe+dIKFBcoXWtWlD4
	dk1qTnbG5synOeY+PvSL3nYQoUGMT8oX2wsQ=
X-Gm-Gg: ASbGncuwmwQuAKiCYDjhSW6PzXuMTE3WYBQm+ylDeRfTKssdrJHVOCfhSlpK1BAvfH7
	fsan8+w23CiFIq6hV2vvCavC3EYtt57s0MQQ4
X-Google-Smtp-Source: AGHT+IGb2kCfYQdMckl3G2TQzxilU2C4s/v7IV1Z5o4pTSNY2b+E8pQph4sMNWw6wXQNB/9GuUDDknrf5F4u4idHTdA=
X-Received: by 2002:a05:690c:6d09:b0:6ef:a187:f377 with SMTP id
 00721157ae682-6f3f820e059mr477232917b3.34.1736258667137; Tue, 07 Jan 2025
 06:04:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216164055.96267-1-cgoettsche@seltendoof.de>
 <20241216164055.96267-22-cgoettsche@seltendoof.de> <CAEjxPJ7NdTWu4dspY9cbPMtRsW_jERoRbKBsObbvsEnwgmZ8Ew@mail.gmail.com>
 <EF4B3759-2C4C-4A15-A721-6B2D0FAFD84F@gmail.com>
In-Reply-To: <EF4B3759-2C4C-4A15-A721-6B2D0FAFD84F@gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Tue, 7 Jan 2025 15:04:16 +0100
Message-ID: <CAJ2a_Dcw3KQUNv1HQFp4qPOoZ972hjr6Qa2LAXTTv6SkV_Pd0A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 22/22] selinux: restrict policy strings
To: selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	=?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Joe Nall <joenall@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Jan 2025 at 00:26, Joe Nall <joenall@gmail.com> wrote:
>
>
>
> > On Jan 3, 2025, at 2:12=E2=80=AFPM, Stephen Smalley <stephen.smalley.wo=
rk@gmail.com> wrote:
> >
> > On Mon, Dec 16, 2024 at 11:42=E2=80=AFAM Christian G=C3=B6ttsche
> > <cgoettsche@seltendoof.de> wrote:
> >>
> >> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >>
> >> Validate the characters and the lengths of strings parsed from binary
> >> policies.
> Excellent idea.
>
> >>  * Disallow control characters
> Fine here.
>
> >>  * Limit characters of identifiers to alphanumeric, underscore, dash,
> >>    and dot
> Fine again.
>
> >>  * Limit identifiers in length to 128,
> Fine again, our longest
>  - type is 51 characters
>  - attribute is 31
>  - boolean is 46
>  - role is 12
>
> >> expect types to 1024 and
> I don=E2=80=99t understand what this means.

Similar to your list of the length in you policy boolean, role, user,
class, and permission identifiers are limited to 128 charatcers (not
including NUL), types (and attributes, which are just special types)
are limited to 1024 characters, and individual sensitivities and
categories are limited to 32 characters.

>
> >>    categories to 32, characters (excluding NUL-terminator)
> One category or the whole category string? A single category longer than =
7 characters seems pretty unlikely and 32 is wildly short for the whole str=
ing.

This only affects individual sensitivities and categories, like "s9"
or "c1023", not whole MCS/MLS parts.

> Joe
>
> > One option if we are concerned about breaking backward compatibility
> > with policies in the wild would be to make these restrictions
> > conditional on whether the policy is being loaded into a non-init
> > SELinux namespace, similar to:
> > https://lore.kernel.org/selinux/20250102164509.25606-38-stephen.smalley=
.work@gmail.com/T/#u
> >
> > That said, it seems hard to imagine real-world policies that would
> > exceed these limits, and likely could make them even smaller.
> > But as Daniel said, we should make them consistently enforced in both
> > userspace and kernel, and potentially these should all be #define'd
> > symbols in a uapi header that can be referenced by both.
> > Looks like you left the type limit at 1024 despite Daniel's
> > observation that CIL uses 2048 as the limit, but as you noted, given
> > the page size limit on the entire context by various kernel
> > interfaces,
> > this is likely fine.

I interpreted Daniels comment more like a assessment what CIL
currently constrains, not as a request for a change, maybe I
misunderstood?

Exporting the limits via a public headers seems reasonable.

Maybe for a smooth transition one could introduce a build time
configuration (CONFIG_SELINUX_STRICT_IDENTIFIERS?).
This configuration can be disabled by default, leading to identifiers
not being rejected only logged.
Than after two releases the default can change to reject instead of log.
And after the next LTS release the configuration can be dropped again.

> >
>
