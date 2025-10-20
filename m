Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB32A1F4C87
	for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968186; cv=none; b=fdYWQbXotLuEnuxiNKRDkuTyItVxPrZVuiVQLhgByHMEovLqmcOREeKWDzYFCfYsrloFWuU7UpY1kbozfnShu8Mlc0H6oiFMO4hNhOfjC24BY5oNcYJZWB7Ak8o2bCXtm/JvRkNt+WaUfbmZjjMN+XAo/RoGiIen64A9UrU6ct8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968186; c=relaxed/simple;
	bh=o1Ttk81L9jveIiLkQFoHQMCsZGUG43xMrWx4eojFCb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hq6dag5YSQbjR4ZQ2ArzwPIcj0bvfv8/0w2/hqL13eK7YdHsdGlvBRgROilY7oaJG5x+5X8Q5t8FsUMuT2P9ALkc5BM4rBqQ69XD/H/jKbFD8aiFwg2vv3YOPyWsc7MRbzn2Z8/9he9bse1vJJ41Sz4h2uj4P+u5k8u0TX0SMMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ciHCHO+h; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciHCHO+h"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33bb1701ca5so3594663a91.3
        for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 06:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760968184; x=1761572984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WivV1XOVb8sqJSTtH13FBSwBcYcvBrR+artEfN7+R/Q=;
        b=ciHCHO+hsT1omYj9QlGIxHahGDd+zWzwyzuFF1feIlWdHCLSwqNks87UBGHldip80l
         t8ZEd6e2hPzbXq9kLtQvDV74XcAxj6UKk5KFL4MiweAW4JATHXuTdX14I0y0v4Knn8yc
         mJ/Habjla2rsz+iyqMu4ahzf4Iwef1LG+BxZEcHgvbe3LmjjYgqrnDuGIHrHIur1YKPw
         PMMNGfR6FEplJaZbs9P49aAMfH8HWRU6lb7Y1CjrmTV+aH9EH3c0UVKJJJcdIJCtVZC3
         LxwZogcXjHYWYHwPasMgn+EgbxOvlr7Q29oPKJh2on+0vxUv6nLfYJfZQ1DH8don2aQk
         0Gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760968184; x=1761572984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WivV1XOVb8sqJSTtH13FBSwBcYcvBrR+artEfN7+R/Q=;
        b=Ajk0D5Ldp84ue1nMBw2Dip90rXF712sY+OnKpM5sY1RBWgZTkPNGR6jKloFXinKLL/
         spDa3t0hisVHu/zSh2ZJVSIWWmQ02Nuaj/EacU6Nh+uYXmrIspsF5NK1hURTxxH6n22W
         XOXZRHA8r3Fw+N43eNIQChlw6JGeOXsKQiYcS0Jj7fAvX0ArDzyL2tb4cN6jzz248YH5
         5XfS9O5AuyM4g1EiKGxJF4q43QFyi4EMa5uDfOh3Ntt+cxtW4Nj/eszhejGCMID3K2+i
         Nx8um0kA9RJg4H4GjoDPnm0K+/+XwE2Ne0f7Szka2GcnlzJSIs2Oc5FfjgXZlfzHPSUq
         WLhg==
X-Forwarded-Encrypted: i=1; AJvYcCWBfpXsdwXRvZf7tUIkdK2xNAZNuKSkmbtM6QaIXbl38kW9VdNB2sVjf2297hkiAKWJUfJN3nPm@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4BoAgV7HYfX0FCVhsoh1YvMFeuYrToKkm36O2OiQGb8nGOYz6
	IGY3cw949Ci1K/PuGeG28Ii8tvymvAOjThE6oOvl4aWI5PX5SHIIcbiGA1kmvib5mMoeZQ5g6lP
	OpXkDOp7hx74Psg+WpqDdmDWCVwFtYPgiRw==
X-Gm-Gg: ASbGncuzqhse5XUNk2Pq+HtVZDGAiigQWY7a2zm7VwkP90FSsTJgP/kAMjAKvMRPAKZ
	8VcElNcZNKsVRlT1zr4rRYVeARZJySJBdJKik97N8oammmPAYp7SMwzzJOG6O/X/4+1JECv6PQ9
	/1t0eXGUOCW6jCV4ZoyeN+GqXp7k7nC9RalaWk5JsOyBKE/QQkfCqPIWQkoBT4O0belQYpCG/WA
	f4WJuDwAqxGcEoP60iAbzqJe3DLki3eSylquTaWnSxSFfOSChmWpS0MGUEq
X-Google-Smtp-Source: AGHT+IE2erXgE2pPBrGG2hfsuT0PBfXKC1h+qUL3i/RFUkTyD4B2Y6PCxATZ/ODY/NwrJyU5ufLlslY52VdmAxXjYzA=
X-Received: by 2002:a17:90b:1d88:b0:32b:df0e:9283 with SMTP id
 98e67ed59e1d1-33bcf90e86cmr17728283a91.34.1760968184042; Mon, 20 Oct 2025
 06:49:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ7y=scNU61+TLMXNMzrvxMbkUdB5a+drAM7gqg2z02POw@mail.gmail.com>
 <20251018061117.55976-1-nvraxn@gmail.com> <CAEjxPJ7CML048d69QTSyWTRpWRCzweScM3EgxqxhFAYHM67o3A@mail.gmail.com>
In-Reply-To: <CAEjxPJ7CML048d69QTSyWTRpWRCzweScM3EgxqxhFAYHM67o3A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 20 Oct 2025 09:49:32 -0400
X-Gm-Features: AS18NWDU42RbXFV3YED9vC-kJiWZ9M3Vy2Pr7aLRa07D2R4vvWm2oVyKP8Ha4g0
Message-ID: <CAEjxPJ5o5fdYswHkkbVbnOt-UdKP641KRDV2J7h83Fc4D3qikQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4] treewide: add .clang-format configuration file
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: lautrbach@redhat.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 9:23=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sat, Oct 18, 2025 at 2:11=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> w=
rote:
> >
> > Currently only an RFC.
> >
> > Add the .clang-format configuration file, taken from the Linux kernel
> > repository. We don't have any official style guidelines in tree at
> > present, which makes it a bit unclear how to format C code for new
> > contributors. As well as this, different parts of the codebase seem to
> > been formatted with different styles on occasion, so using an automatic
> > formatter should resolve this.
> >
> > As well as this, replace all the existing indent targets with a single
> > toplevel `format` target. Managing all the source files to be formatted
> > is not pretty to maintain, and doesn't really give us much.
> >
> > Also define a toplevel `check-format` target to verify that all code is
> > formatted properly. This only becomes useful in the future once we have
> > reformatted all existing code, but is wired up for now.
> >
> > For the future:
> > 1. Reformat all existing code. I understand this is a big change, hence
> >    the RFC, but we may as well get all code formatted if we go down
> >    this route; afterall, it's not like this will cause any breaking
> >    changes.
> > 2. Add a CI target to check that all code is formatted as per the new
> >    clang-format configuration. The `check-format` target can be used
> >    for this.
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
>
> LGTM but still posted as an RFC so will await a final non-RFC version.
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Ah, actually you seem to have accidentally deleted an empty relabel:
target from policycoreutils/man/Makefile, which breaks a make relabel
at top-level.
