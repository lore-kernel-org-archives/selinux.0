Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D375D27FD59
	for <selinux@vger.kernel.org>; Wed, 13 Aug 2025 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101074; cv=none; b=trNMHoapTqmidvL0iMC1v2zKQ8CvA3as8B5xL5ul7ctVzdv1/ZNiq7NtFcdZMfU9mmfy5GM4Rlpenez0F3KGDr/pNvGrisyf28CQOm0qK56PvhaXZZA1sJ/wbTHzn7OUt5LaU9EnO2D7caqfNpIfHlqeoXbeK2Yoctpw+5jDQ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101074; c=relaxed/simple;
	bh=ySxzO5a3UGvDAA5Nv9mi1KHr01yUK9HsrwEsN1PiQy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwQjKK3J4HvwQPzgGqLXGMHZ+e/nl0e6ugAikQJ4pD/Ity56Z20za75p9zR9/2meCPM71uFXVqwiMra/faVuwXLd0TUUbNW0TRktBoecomRSMywWKVZpO9NZ8HZ7cHxABbMipxFCLf8CQ4zVd4pc8G02HpBWrthalpNhuAQA3J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZkoHHkbq; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZkoHHkbq"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-323266cb393so92773a91.0
        for <selinux@vger.kernel.org>; Wed, 13 Aug 2025 09:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755101072; x=1755705872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djj9JW0zOEWDhOCa1hSDomDEwwGaS3m3ps7bUF4JsGM=;
        b=ZkoHHkbqx+cPHLpYp/pNi5giwozBtei5K86Z+1iXGSCIpemyILd9weKc6bddxzIv/3
         DznvDudseUf0AvBkbf+Q4HUkhyKkgDIlQB/f6CjgIr05NTksl1yneYWxNDceMEqZHHeY
         vGzLdxCtagQX8VOBo22NSPNY9SmdtA60EKEZSTRg8J/ztNfpuwN/qu4XEGLgrLujmKlV
         EmTmNaWMBfbNaaQ65y0hp7OHQa6NA9IXDdbl+ZK/3ih3y/4YcoOqMYPBmU9Q+Zma6LTl
         uwM+xCB6nVq3Vd+OzVT+bQ5oHtyXlO9kOabJA9LlMjd4qSeAXhIAod0YPNMAzL0/NMZ0
         rdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755101072; x=1755705872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djj9JW0zOEWDhOCa1hSDomDEwwGaS3m3ps7bUF4JsGM=;
        b=vE0REDKqMPg6GgDDY/N+mnwl+9urdnzBVAgcXmtkza/nZxYr0yNfHdqWUqrcY3nFZz
         W1ShgZR5LIoxnNokaAR75Zaas/EieFeFbwz9+wktdeIRBZWvi32sLe1FQPMZYL0Itu02
         /XY223Krw/qvp3S73wna2zjrXbgAR2PrjlIEaRt2IFcgKqphpSnFeJy3u7b8Hs/IDxRA
         tlyLVtL/4KwW3I/1f6F99NujfQSHjQ5ArneAnyRFVsr9RXv5Mj3hJUIwyKMWk4pmeqRX
         oWjvqbOqghmi/JwAcBH+0DMvFRHaLKgFL764tCTY+NZqhGkR/W4KWDEwTHy0JtfIXxkM
         hh8g==
X-Forwarded-Encrypted: i=1; AJvYcCX+XKCoxxKVZExxaMghIqOGoh6nHAfcAwveKveBG0S3zjiWGq6amE00CXAPbpEwAVV9SJply7D/@vger.kernel.org
X-Gm-Message-State: AOJu0YzUdiPVDnjnEbkhXkchH5pd2O44iutUebyC1OOfalAlRV4rNXcO
	2PiCbPCF0ntmGnMxGueT2fYA8gbIXzNAFExJZSWZUmoGpIwFrmLa/EVNzxLzAMNxwu1REG+ihfl
	cmRVpPaYQzf4LzmPoBYMwHeEBlT1SFNugtz8Xpcae
X-Gm-Gg: ASbGncsjEJe78FfQ1vgxJx9B+Pw86kMI/5AEeWL67KrdKwPUZ9BD3//136na5mGH1uG
	ySew3AoPYuVlqlGTnJE5WqrcC3wxwdtjbVz85rmzo3AJTIiJddBMGIN6QFChQDBZU87FVreXhrS
	/9mUBThE7yzbYf30jvy9kUbzhcyPhsgF1rZD1wktHGpCMQxq8kJrzdh365womF2EP+yc+S8lCbz
	DGn8ws=
X-Google-Smtp-Source: AGHT+IFsoTa9DQl2M9Fv7tFxBreSZPOt67mFEy2RKm+jW1s6OzXNF7Pkzr+Aulh5yEKzabpJZCyeQmMeBucvjzAugLA=
X-Received: by 2002:a17:90a:ce0a:b0:311:da03:3437 with SMTP id
 98e67ed59e1d1-321d0ea416fmr3866117a91.27.1755101071992; Wed, 13 Aug 2025
 09:04:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813100053.1291961-1-dsterba@suse.com> <CAEjxPJ75Nwb2AGbT2uDe1WACjxiL5hcg0q+WHfu1T3YFN2_UAg@mail.gmail.com>
In-Reply-To: <CAEjxPJ75Nwb2AGbT2uDe1WACjxiL5hcg0q+WHfu1T3YFN2_UAg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 13 Aug 2025 12:04:19 -0400
X-Gm-Features: Ac12FXwlisSVlUl_-YOgHAQTstod6cw_6pcQmMIcM4HNLomPyXRGM6SfLT1y-sA
Message-ID: <CAHC9VhRFzL8gCj-dNmrgTLg137boMo+-4YJ7wOwATiEnwKa_4A@mail.gmail.com>
Subject: Re: [PATCH] docs: Remove remainders of reiserfs
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: David Sterba <dsterba@suse.com>, linux-doc@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 11:43=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Aug 13, 2025 at 6:04=E2=80=AFAM David Sterba <dsterba@suse.com> w=
rote:
> >
> > Reiserfs has been removed in 6.13, there are still some mentions in the
> > documentation about it and the tools. Remove those that don't seem
> > relevant anymore but keep references to reiserfs' r5 hash used by some
> > code.
> >
> > There's one change in a script scripts/selinux/install_policy.sh but it
> > does not seem to be relevant either.
> >
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
>
> > diff --git a/scripts/selinux/install_policy.sh b/scripts/selinux/instal=
l_policy.sh
> > index db40237e60ce7e..77368a73f11171 100755
> > --- a/scripts/selinux/install_policy.sh
> > +++ b/scripts/selinux/install_policy.sh
> > @@ -74,7 +74,7 @@ cd /etc/selinux/dummy/contexts/files
> >  $SF -F file_contexts /
> >
> >  mounts=3D`cat /proc/$$/mounts | \
> > -       grep -E "ext[234]|jfs|xfs|reiserfs|jffs2|gfs2|btrfs|f2fs|ocfs2"=
 | \
> > +       grep -E "ext[234]|jfs|xfs|jffs2|gfs2|btrfs|f2fs|ocfs2" | \
> >         awk '{ print $2 '}`
> >  $SF -F file_contexts $mounts
> >
>
> Just commenting on the selinux part, this entire list of filesystem
> types could likely be removed and replaced by just running "fixfiles
> relabel" instead, which on modern kernels (>=3D 2.6.30) will check for
> the "seclabel" option in /proc/self/mounts entries to determine which
> filesystems support security labeling.

... but in the meantime this patch looks fine.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
