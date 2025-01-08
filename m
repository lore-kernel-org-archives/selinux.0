Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C0818D;
	Wed,  8 Jan 2025 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736355740; cv=none; b=XolrgI4f2TS4vZVGv5MHcoLLnwViM12gnHCHERcYP3YXJUbQzmmxrARrpLlx+UVDCo9cZP2TxcAcVfvemPPB4feTULyAfXugy3VeatOALgPwlpENMRGy6Sjivy/Evgi7qHug9VxN4Z/cK8EGtBxp/b/ZBdUzCYwXQJSDpfyUdqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736355740; c=relaxed/simple;
	bh=hJhGOgjLJW/foVpWlAObk6c0wNrPfhRIn9rgD4HiUkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUVTckuaNzBSamJwc0cw2o3w7Ah23/ax1mA9Q9mCXur9k0KZw33PBjsFJ7UnOXMZSpaQT6Y0mdjEv95EtHxQMu+RWRegtqit0gt2QmhifW+x94W0Ck0BrBFigBXtKiqyj/xycOpMqDhfYl8qdfTr0xCOrvGI5MkPYrXcaYK7T4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Oq3QLm/P; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Oq3QLm/P"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e4419a47887so21744495276.0;
        Wed, 08 Jan 2025 09:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1736355737; x=1736960537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwZ+CV+5h2p/PFvnPwPMSUOLWdPmHSTt5hkA/RWK/+M=;
        b=Oq3QLm/PtdysB6aPORrIxbStA+EYr1XlzZcrU+a+t6cZncJFjalEjLLY6nsmlXDDuU
         MEOrWvh3WX7Ugk/NiFyeey3YTVR7oiOWMaF+T2GyNU0S47/SHobypkBXqUqBTHkAn1DQ
         sgKihol8Y1j8ebLjW0cflaQDCJs6uocaXVRPlou05rXwin0aZLb81xYuVxFae4SYJfUx
         IpjatrBCd+ZhNEul1cryy6w5820YyYK/OGY77/ouCdcq6zEU2d61GoIrsJvatvTy0Cpw
         b8o2orb3eNxYgcrQg7fxZ7hpRagqK+huA4bWm2OfivqRhTiCBqrR5P6MpqHDw7zC1Cle
         PgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736355737; x=1736960537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwZ+CV+5h2p/PFvnPwPMSUOLWdPmHSTt5hkA/RWK/+M=;
        b=bOaBNzTFqRSS9Zj1AM093zpCFazSTi7skXP3/lKDc2liXFteNg/YYlD9G2Z3kURQ6H
         ElsP9a4Cxl3gohzUx66/4yknCPjk02ys/jZB8WkLwPvQvvM2CFqula+nn/OCROkSOeuH
         6f7e05OP5ub34/hJ5zcriyKXhD9hudQ1ejNloXKihvMwj7DT9a8J7mEsOP6cM0lw2V6z
         nAGg4N4HjOBN/3n7wsyT4iBuNRGLMSzPjPfDOt2ZjRhV3Kd3Q9a2FZ77ZQH4GvCY5xpK
         HiGDkUq9xIzGFXTDU1efEs35+3QRcvBPFU+NRYtTQYKoKlRDdrPHB1JlIIgTvbraeZyc
         aAxg==
X-Forwarded-Encrypted: i=1; AJvYcCUJUJske6fXet6g8tDBsRdMgB5B723jhgQ72OEdUhLF/kk4G8EFW5O7IEg/jBCIh0yU8931kBI93hkR/t4=@vger.kernel.org, AJvYcCVfEewNbBxF71XjwAr0wRBTLRkJm8B0lyE7M/UGXx08XhmXpy4O6qBpRDidfSZpz6ywcNVAg40ecA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOIZvWhTjEWwsDnlMMu0pel6Me4xGVBhsITiI4f+2ZRmh8s3Vd
	T7RNHBo8LgAGkeAx6ws77jAxvfWM8FfRWlzeXFMyHSe6sNwgJUu6HyXHJuuiEU9IwN7IFv8CWH1
	jEkbYXkW8ECC4ri/Z7i7IdQlncq0=
X-Gm-Gg: ASbGncuTZWi9aLgB86I9M9G6/COvRAADkx/4+AJplQbw9bUwWyOBx6S77ay4tjyWqRh
	9kwD21a5MeAS76YxOkvZOm9ksuv80q+gz8K+y
X-Google-Smtp-Source: AGHT+IGmV0iG7wdc/IPnLhed+8gRObsGafv0Msg5R3ACLWE8C2ShTNz8eOnTylXHzI4jxvkoZzxe9aeVyq4RPwCJB84=
X-Received: by 2002:a05:690c:b17:b0:6ee:66d2:e738 with SMTP id
 00721157ae682-6f5311e4ab2mr33657517b3.2.1736355737322; Wed, 08 Jan 2025
 09:02:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216164055.96267-19-cgoettsche@seltendoof.de> <e1e67dea8520f71bc54377a93e26d849@paul-moore.com>
In-Reply-To: <e1e67dea8520f71bc54377a93e26d849@paul-moore.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Wed, 8 Jan 2025 18:02:06 +0100
X-Gm-Features: AbW1kvbVpB5vQRaF4j7zoLu5ldk_OiXmqz3jISyLmgKfrBF34zh3GNS4BkPZAPI
Message-ID: <CAJ2a_DedB9d+mes16ws0gFBtzwZ3LWj9Ocq8+xDjQyZETgWbCA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 19/22] selinux: validate symbols
To: Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, 
	selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	=?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Jan 2025 at 04:00, Paul Moore <paul@paul-moore.com> wrote:
>
> On Dec 16, 2024 =3D?UTF-8?q?Christian=3D20G=3DC3=3DB6ttsche?=3D <cgoettsc=
he@seltendoof.de> wrote:
> >
> > Some symbol tables need to be validated after indexing, since during
> > indexing their referenced entries might not yet have been indexed.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  security/selinux/ss/policydb.c | 94 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 94 insertions(+)
>
> Out of curiosity, have you measured the policy load times before and
> after this patchset?  I'd like to understand the performance impact of
> the additional checks and validations.

A trivial benchmark of load_policy(8) inside a virtme-ng environment
showed a slight increase from 82,7ms to 82.9ms.
I'll try some more benchmarks for v3.

> --
> paul-moore.com
