Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC981F2395;
	Tue,  7 Jan 2025 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267592; cv=none; b=KhoWvFLJiBVKrfnogf+/stna/4VwxLUNUX+sQuMbQkss6DB3Os0T7m16q1gq0l416+QxHUPVT7gj7G5gPJmU7+DdJ6iskVJTMBQ555RWii5W9k/VC4wcu9wupbq294XDLtA3tZvB0SgR5xRE25EibMFtW4cZZEK9/7aYFTYCs4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267592; c=relaxed/simple;
	bh=liTE6uV42sa1Gzm/dqnu/eLrY1M/BxW/tHuKLz5XJ/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYXebAURTH220rEARk1BeziK2RekHA1CVD2R3MJo4DL1XL/016kv11kNxGpk/UASr5OrPq9TWsNls58HG11+4NP1nexHdiOCTyDEFRBzGmCTNNbpUJ6X9Nf4EhgEQ6nB8MVSfBA/D0KNMRoLfuBDHYzyaFN3XbuojTxVc6tu4Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgDvu7tZ; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgDvu7tZ"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4afeccfeda2so9193535137.1;
        Tue, 07 Jan 2025 08:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736267580; x=1736872380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13/9/yjyywasTSBQ6NObq3v2ALYfJ6I+tEYYZLaV0yc=;
        b=FgDvu7tZ0pnrXBSgWJ7Pw0jJufgdS9rnTA9WJe25q9AHFmyNL1pA16TbLurkgJfle7
         RxF+lCHDfwRconfRgHbjcJgSi+CBLgP8qAwJGQCouixFeycJgrXoiXeHCFpbmbLbFmFU
         CveISA9zajT8Ip55ROu8kG3YgzAdDrjXxQ80sjmVZPKpRyGWJZNMC2l+NRgbxoDBj1oa
         5f/WjFL+BRmNzQGkd1E95Ay5frWx4g32kmbUIw7tS5NpNoPlEiwMqFgPLacm9KJ5a7Oj
         X1AhJq6LqJ9YhOU06BWEMuIhmOvvRlYnLorvFFGQo10m9gRjw+OrqPB4MrKFYnjjGOHA
         35ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736267580; x=1736872380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13/9/yjyywasTSBQ6NObq3v2ALYfJ6I+tEYYZLaV0yc=;
        b=RAN8KVWtgHrugKtyyyeZoZwBhCFVqijM7dLJVLiZmoglZhYNEobvoLqiK1yp2tN9eL
         2gFk/60sRyWnYFrXZSrqEdWIeAlqcE/UI9MnJkjymfx/l1YmJf0qkKDkMIErWRHWTzyq
         lQyICS+/ZQVuVQ+s4ZF3y/tsYgLan5pv70URloNP4l1Wg7dgGBzsMB+XBbtcel5NRXOi
         vrA9egOkB/bHzwlmgWIfwEUf/nfsiSCfZTU3Ktyu13lavEClURJwCtb1XCjWW4lql73Z
         CcMwtGJO1I1Bt+odZKiAJiLyJqu9aBmi7vOFHrRSno6ONO0waYWkSnzkofzlC1HoMxPj
         4n0A==
X-Forwarded-Encrypted: i=1; AJvYcCVb6xF9DrhYIz4MG61H/QtCXZyHFKUPMYJFI2PYUC4wzPZZd+veG0J5ye8jjAr8eQYrtz+f68wH8vq2swA=@vger.kernel.org, AJvYcCVv/U7vOsFDnXll6wx9aVXm9cnmoG4/8zUEAiA0YQESwbTN/42gVcxsqRKwc758HBPljUCem73hTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwocYuOnCvKoe3NbFNwltI27lumAX3tQeKBM9y4DD9Pt6eKanf5
	sgoDALz+MocOyKFe9s2X5+34hIJTucAf1xnGHLdz/JNrRlTcV6+SHhcZ8Dom/SA8pOJvohQ9FOL
	7lYkeLMPJ3+M3ZtfRiAOBTDs/Ygo=
X-Gm-Gg: ASbGncsQB1iU9UN7CUVXfODreWSjt9meimHC3DtqNBjms8GQGFZNKzVmMBtLv7i6fSs
	Pk6PpAW8SHfUBLWOlZb9WT5Kmuey3RoQEwI8OaA==
X-Google-Smtp-Source: AGHT+IHOgO35A7KsAXCntcGhrO/sYRTA/0+tQf+oPG1WO0j2n3ejAB8/55UzS7HRl/4g7zJoK5SlnBgWj1fHwbEeYOY=
X-Received: by 2002:a05:6102:419f:b0:4b1:11c6:d3d2 with SMTP id
 ada2fe7eead31-4b2cc472ec8mr44408804137.27.1736267579964; Tue, 07 Jan 2025
 08:32:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216164055.96267-1-cgoettsche@seltendoof.de>
 <20241216164055.96267-22-cgoettsche@seltendoof.de> <CAEjxPJ7NdTWu4dspY9cbPMtRsW_jERoRbKBsObbvsEnwgmZ8Ew@mail.gmail.com>
 <EF4B3759-2C4C-4A15-A721-6B2D0FAFD84F@gmail.com> <CAJ2a_Dcw3KQUNv1HQFp4qPOoZ972hjr6Qa2LAXTTv6SkV_Pd0A@mail.gmail.com>
 <6b9cd467-cc34-4ded-b68e-c98bd5870537@linux.microsoft.com>
In-Reply-To: <6b9cd467-cc34-4ded-b68e-c98bd5870537@linux.microsoft.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 7 Jan 2025 11:32:49 -0500
X-Gm-Features: AbW1kvZhafgNUvID5cjber50NBlxYOBvxM2DuzpAX5jm0imn-VpIwq-23ThAkbM
Message-ID: <CAP+JOzTuybcdjKoej1oprs9DCbq6TUEL2f0XRK+QtgjaPfdO_Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 22/22] selinux: restrict policy strings
To: Daniel Burgener <dburgener@linux.microsoft.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	=?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Joe Nall <joenall@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 11:12=E2=80=AFAM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> On 1/7/2025 9:04 AM, Christian G=C3=B6ttsche wrote:
> > On Mon, 6 Jan 2025 at 00:26, Joe Nall <joenall@gmail.com> wrote:
> >>
> >>
> >>
> >>> On Jan 3, 2025, at 2:12=E2=80=AFPM, Stephen Smalley <stephen.smalley.=
work@gmail.com> wrote:
> >>>
> >>> On Mon, Dec 16, 2024 at 11:42=E2=80=AFAM Christian G=C3=B6ttsche
> >>> <cgoettsche@seltendoof.de> wrote:
> >>>>
> >>>> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >>>>
> >>>> Validate the characters and the lengths of strings parsed from binar=
y
> >>>> policies.
> >> Excellent idea.
> >>
> >>>>   * Disallow control characters
> >> Fine here.
> >>
> >>>>   * Limit characters of identifiers to alphanumeric, underscore, das=
h,
> >>>>     and dot
> >> Fine again.
> >>
> >>>>   * Limit identifiers in length to 128,
> >> Fine again, our longest
> >>   - type is 51 characters
> >>   - attribute is 31
> >>   - boolean is 46
> >>   - role is 12
> >>
> >>>> expect types to 1024 and
> >> I don=E2=80=99t understand what this means.
> >
> > Similar to your list of the length in you policy boolean, role, user,
> > class, and permission identifiers are limited to 128 charatcers (not
> > including NUL), types (and attributes, which are just special types)
> > are limited to 1024 characters, and individual sensitivities and
> > categories are limited to 32 characters.
> >
> >>
> >>>>     categories to 32, characters (excluding NUL-terminator)
> >> One category or the whole category string? A single category longer th=
an 7 characters seems pretty unlikely and 32 is wildly short for the whole =
string.
> >
> > This only affects individual sensitivities and categories, like "s9"
> > or "c1023", not whole MCS/MLS parts.
> >
> >> Joe
> >>
> >>> One option if we are concerned about breaking backward compatibility
> >>> with policies in the wild would be to make these restrictions
> >>> conditional on whether the policy is being loaded into a non-init
> >>> SELinux namespace, similar to:
> >>> https://lore.kernel.org/selinux/20250102164509.25606-38-stephen.small=
ey.work@gmail.com/T/#u
> >>>
> >>> That said, it seems hard to imagine real-world policies that would
> >>> exceed these limits, and likely could make them even smaller.
> >>> But as Daniel said, we should make them consistently enforced in both
> >>> userspace and kernel, and potentially these should all be #define'd
> >>> symbols in a uapi header that can be referenced by both.
> >>> Looks like you left the type limit at 1024 despite Daniel's
> >>> observation that CIL uses 2048 as the limit, but as you noted, given
> >>> the page size limit on the entire context by various kernel
> >>> interfaces,
> >>> this is likely fine.
> >
> > I interpreted Daniels comment more like a assessment what CIL
> > currently constrains, not as a request for a change, maybe I
> > misunderstood?
>
> That is what I intended, yes.  My related request was "I would think
> that we'd want to end up in a situation where the kernel is either
> equally restrictive or less restrictive than CIL".  In isolation, my
> opinion is that the 1024 limit is fine, but I've been hoping James would
> chime in about the feasibility of dropping the CIL limit at some point
> to get them in sync.
>

The CIL limit of 2048 is arbitrary and could be changed to 1024
without a problem.
Jim


> FWIW we have a few generated type names internally that subjectively
> feel long to humans, but are still under 100 characters.  So 1024 is
> plenty of extra margin in my opinion.
>
> -Daniel
>
> >
> > Exporting the limits via a public headers seems reasonable.
> >
> > Maybe for a smooth transition one could introduce a build time
> > configuration (CONFIG_SELINUX_STRICT_IDENTIFIERS?).
> > This configuration can be disabled by default, leading to identifiers
> > not being rejected only logged.
> > Than after two releases the default can change to reject instead of log=
.
> > And after the next LTS release the configuration can be dropped again.
> >
> >>>
> >>
>
>
