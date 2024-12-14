Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8217DA9C
	for <selinux@vger.kernel.org>; Sat, 14 Dec 2024 22:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734216510; cv=none; b=Ycy4pW6zFAg38urU3KdI/YURP7BXHlS2vAkNPjVsoRAutgHhXzaLqZVQ4cn2VA0HqVbYnyNWnvK3AuaQyLsPVT1RpmcwcwiZVTQWUCyeZII2ztPhzCaZxLgSKJxaqQaM6Q4Bo6FIOy2gEZyyHX2XkDJTlXg9R9j/0Q9ujGOYQCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734216510; c=relaxed/simple;
	bh=mN/QbefYvgqpNikuORpa9UwnpfDph9udgK3kqfaxc6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1j5H5kHScKm9DeFgGyvpSyI1+YLEPJffarwPOPv8Z1ipH+AjLd6u0q+qprS3VGpO9DFrf9ySH/sKirjRWT76MvNnkGt39F8KjfPvzAqmdD3W0fVACr4AxidqSGbZLBK9DZSfrVPB847+EnwOQqXSilcSDWvZFLtxpLHOlJCShM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RVuRxEp7; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RVuRxEp7"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6efa5bf5202so21856557b3.3
        for <selinux@vger.kernel.org>; Sat, 14 Dec 2024 14:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734216507; x=1734821307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZJ4scXTRmS7RPf8oo625k7m0SKrT5j5fYdKEOC7Hfo=;
        b=RVuRxEp7sx65p/D2b82jDjFD3msPydiwOlQUQQ5RDh7qpf/fUhldaANB6nhdZSOuXi
         +bHbdcEmbD71g1bZXcV86PhNBx6KIp2RrCkDPVImcpZ5qIsm8kpaLPKPG42BMviKFcwY
         xu/JpYA89UfkX3Vw/FqP275O5tqDoEIL1ITtXvmIhWMfSfr6Mi8TQ/BJGp3FEOBKRr44
         v4HU6PW4hQNmkPtjaDX7KktRcRwQYgATrnt3JVsfgrD45a3OMHvWLnjktgqHkTAJJw3L
         i+kg7mgZX5Hd3BfKGpqgWUvgndQucCu1W4xbBh2a0Zq4e8gQgm3bV9YT4iyDqenOUBVu
         YN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734216507; x=1734821307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZJ4scXTRmS7RPf8oo625k7m0SKrT5j5fYdKEOC7Hfo=;
        b=FPE43MeG9eGWwtpNE7Hs1brdEj0Atou9Sm5QcJVqpKixg7S2gD0Psgv6eRbmUzymF2
         ravI+2Og4AyRMFAFz6wKYR4uD8FTMHd/w0ukqRkKy6FiIPEI3rUwLMzxvOTDsHoDvpm2
         ln6qrfSandtYVdNgux8NhQmfxOQJ5+nrifQxf1lTMPYOHGjqIkTyu1Pqoo5spaGEvgKW
         fQP4x/abnZEqd44uz7CHivFS7259O0vnm/ItMavoUV7+Ey4TL/9kyodbsh+tCNPqcSub
         Yvfw63EImSddoxgmW1YJdc5buEqSgys8IKRhWgHLe5XVMgEQD4ZbBYX4LQLA/BhVOg7R
         MHeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPuebxRLJFgHEvJtJXqvt7Hfl35X8ECHxca7iQLAE/1gnASEMMlGD5VatWKArY6PihEEs+M1pN@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvvpc9R8+nojSRWB18Onln3EV/kDobsPKJSxatYba2RhQugS1b
	S+lVDST2hbwkAdX3l2gIpD5+dpqRcmLcNBS+EvihWxUVHF+Ev3HT5Q6UrpZRKAI09c3CX7NCe0D
	fbzc2bQjaS1uHFlZR4u++gh9gAE4t+MCkkLAQ
X-Gm-Gg: ASbGncuiRMtby21HNS1wJFMWFk5WwQc5CxhweH18z4ctnovtHH7X6zA2ZvdvEDPtCPx
	ShpV706whyBVNJdI34KfXxX6YjvjwdurnZmbQ
X-Google-Smtp-Source: AGHT+IFbiM++nNw75ntI6RZMI+YfteGrryJVeEm71wShEK1qQgsUqDOT4fhaa7MESeCYL+h3/swZ5JktuRR/PL7IRDs=
X-Received: by 2002:a05:690c:6388:b0:6ee:a70c:8727 with SMTP id
 00721157ae682-6f279b9df88mr69827557b3.41.1734216506880; Sat, 14 Dec 2024
 14:48:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125110646.50799-1-cgoettsche@seltendoof.de>
 <e43da8418fc54a5eba7cdbb594b24bb9@paul-moore.com> <f7bfbf89d2ac4b929637bbb25f749c96@AcuMS.aculab.com>
 <CAHk-=wgraNfcOCZ4n_C+ircQkD_AhsPM-=z7snt+eLgE-6otkg@mail.gmail.com>
In-Reply-To: <CAHk-=wgraNfcOCZ4n_C+ircQkD_AhsPM-=z7snt+eLgE-6otkg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 14 Dec 2024 17:48:16 -0500
Message-ID: <CAHC9VhSDfn5QgQsF9qq6-k67bQB_M6UZoLODDYs4qkwHcr4-gw@mail.gmail.com>
Subject: Re: [PATCH] selinux: use native iterator types
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	"selinux@vger.kernel.org" <selinux@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 4:10=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sat, 14 Dec 2024 at 13:08, David Laight <David.Laight@aculab.com> wrot=
e:
> >
> > Isn't this an example of why -Wsign-compare is entirely stupid and isn'=
t enabled
> > in the normal kernel build?
>
> Yes. Please don't try to "fix" the warnings pointed out by that
> completely broken warning.
>
> I don't understand why some people seem to think "more warnings good".
>
> -Wsign-compare is actively detrimental, and causes people to write
> worse code (and often causes mindless type conversions that then
> result in actual real bugs).

I'm not going to argue the usefulness of '-Wsign-compare' in a general
sense, but I will say that in my opinion the changes proposed by
Christian in this patch are correct and an improvement which is why I
merged the code.  If anyone has an objection to this particular path,
especially if you believe this introduces a bug, please let us know.

--=20
paul-moore.com
