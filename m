Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904E01AAA22;
	Fri,  3 Jan 2025 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735935151; cv=none; b=FxCZz0V59TbTVUPSTBT4ahNS4HWbkfUvXS8OL5SxVvkj4WmVqjRSn+Y74hTjKk68ht24DZ+x6TQCovFJRgu1D8i9h8t5Q5c9KOC9dO9RbngwWBEXG2R1leDpchXOQbEhvexwoBUCT7luewV/le09JFpoEpB/NQSavqj7kRaCn68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735935151; c=relaxed/simple;
	bh=JCzV1NWfuf4unN2nk8NJSOMhoxf3M6FEsxvPcMOPhdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yjk+VDP2iXh6aqruK5qXZR6KGt4Izqbi+MOFfsEqYUU0k+3e7C6AOZjbnjgzq0jxZwu0U3E26MVxnN47x/b3ILVTK+yNzHkwx6jxFL2RTpZlABT9sYQiN39OXuLrxJQv4Xessvp33v6EOZLu3OycpjMBf8I38yYUWlPmdonQrW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3TDERG0; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3TDERG0"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f13acbe29bso15869810a91.1;
        Fri, 03 Jan 2025 12:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735935147; x=1736539947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2Luw2DINIQTTEGEL/uyBPOt8+ZF34Huq2NNPKvNTdA=;
        b=T3TDERG0fptxa9/19Xn216O9EoMF2Foz/TwWSGbYRgSvArGvLUQRVSGiun5ELqRrAC
         6aWnl0eG+w3jt/Bvk2qY4ZifadgR1L6HhG2V1vPjAidcpEW7Joh6CYeZu4k9kaEtlpka
         VZjsqMKcrekS4KyNjsMzL7OzEFGoNMKhIr5K5XgZFw8NL79L76DCMCurN6+UHTabCOlU
         qcHIxDuT8CIPxSV4tFVKekroc9Fis8YbGGqhScvlEekUVH1EdxHK2ByNwGdVkM7bLbEW
         JMab8+rtDAKa9HAgUzvu/UVtNeccDzIZrgazuZGgF5wK8EtuyxkJcBGGLD10cuGwV9Io
         bxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735935147; x=1736539947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2Luw2DINIQTTEGEL/uyBPOt8+ZF34Huq2NNPKvNTdA=;
        b=Oz/DcHwXh7BuVp/R4+Xtb9kHhWnuuLkV/j+wKVwh0tFjyjHviJmxIHRjsC7sDLyUgg
         N/hYi6CouKqXN93gFp+ew+b5V6lvdMWAEUGfsZUD0HDydZlkI33H5KK0jo6tZTN9pyOv
         ZF6HNh8QsuUd38NySbHUBjev5XyMVEXWW4JIrmXH4HXhqUJnxFFoQyG6La8pD/216OlG
         leIM4iscbW7GY8CZRnHNp1rfdE8tEWN9s6C8rTjYFqF4X0wcYcTDxYfL5zqzAclf87Ft
         dPGtCw6qQPe5zam2YcFww186cFChi19KEl132b1ZTE5Ch2mBAkJkDxgzsNrpUf+biQWC
         hBjg==
X-Forwarded-Encrypted: i=1; AJvYcCXOOqZ4cBu+aBVt3PUq17YwpCCbmlmo5ocZRVOqdzNoA1q7nn8/qU3rQPpR+Uj2qXMk5o0Dg68ttpq5/UI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhzjQOBhoNi4PAGNLxVSg7wOA/6gYplhVmFIK48E8Ea8naXZ8I
	HiM8eJ8lmC9TbyN/WmFo41hO/pu48P1ZlPNpBlfIyec1HXgAI9Ldpa9XQwZzYgIBYa7skHk2YM3
	84xxlSdhGcdqlI3AbwC5IiDjnCQ4=
X-Gm-Gg: ASbGncuwo20fWTlv6Zp2BZECtk/9hcBwSV68OSV6b6/Kian4zxDq98w1soL93Cg/oJu
	2rhZQdF95uZSIVAJyGLCVQgD76fnhJeAIhg6UZA==
X-Google-Smtp-Source: AGHT+IGIvfnFKdwJ+ZFwJvvl+sBsVjkzs1CEt3tgv/ORIAc9/cq0w/2brKNfQaBja+q/j3KxBHXbS6o0nFSidbj/xTs=
X-Received: by 2002:a17:90b:2c8b:b0:2ee:edae:775 with SMTP id
 98e67ed59e1d1-2f4536030e3mr71461546a91.3.1735935146656; Fri, 03 Jan 2025
 12:12:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216164055.96267-1-cgoettsche@seltendoof.de> <20241216164055.96267-22-cgoettsche@seltendoof.de>
In-Reply-To: <20241216164055.96267-22-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 3 Jan 2025 15:12:15 -0500
Message-ID: <CAEjxPJ7NdTWu4dspY9cbPMtRsW_jERoRbKBsObbvsEnwgmZ8Ew@mail.gmail.com>
Subject: Re: [RFC PATCH v2 22/22] selinux: restrict policy strings
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	=?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 11:42=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Validate the characters and the lengths of strings parsed from binary
> policies.
>
>   * Disallow control characters
>   * Limit characters of identifiers to alphanumeric, underscore, dash,
>     and dot
>   * Limit identifiers in length to 128, expect types to 1024 and
>     categories to 32, characters (excluding NUL-terminator)

One option if we are concerned about breaking backward compatibility
with policies in the wild would be to make these restrictions
conditional on whether the policy is being loaded into a non-init
SELinux namespace, similar to:
https://lore.kernel.org/selinux/20250102164509.25606-38-stephen.smalley.wor=
k@gmail.com/T/#u

That said, it seems hard to imagine real-world policies that would
exceed these limits, and likely could make them even smaller.
But as Daniel said, we should make them consistently enforced in both
userspace and kernel, and potentially these should all be #define'd
symbols in a uapi header that can be referenced by both.
Looks like you left the type limit at 1024 despite Daniel's
observation that CIL uses 2048 as the limit, but as you noted, given
the page size limit on the entire context by various kernel
interfaces,
this is likely fine.
