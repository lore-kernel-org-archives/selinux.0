Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F2222D7B6
	for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978428; cv=none; b=m/iRJI3DIBbzUFKIAWSwrK+pzHWPh2K6WxFy3KoXz8xoF9ztjKnxM2U5ZEpKW7vf3suSlKlPZWNyCcps0H70Kl3wEt2x/mi58xg3hBntgP63JgtVe4SIl+pK+LhRFKW1gfZCKq5cWNwsfMVhyAg9a1a79vB57Y/NIUv+RCMKxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978428; c=relaxed/simple;
	bh=9MoPCE3omyUV7pmzHdTZY8CcW6Z7U2dJHtoUfl+awr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIcNXws6To2xpdUXsRPql1B8TC+ZsbPv8TLfvbsDxUEqsVpUz7b5FJx6Y0/LfxQZAslxR1GcX3XKwfDicEQJVupzmPrATTgbqKSMHEbXO7iwXmheu5Uv3v3klz34Eoc7YinsQsRKk/rjvsL7VpgIg5xrVi6PYHMwOsGIQtuYM/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7PpcsAe; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7PpcsAe"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so4186895a91.2
        for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 09:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760978426; x=1761583226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2ix8GsYu1u70ball/QdTJXtHk82+gyjHMURpwV0acM=;
        b=Q7PpcsAeWX/1cjpkaE7QI89pwYDZKrX8TFcZPr4gTGXAz7YGtsRuu2wXqOGj42SchB
         SiZ4sUA9tKbwROFy4+V0NwUFoDuqSZenGqLJGugRTZPOAJWwex3D360RjBW8s3r3DUHB
         5kMvF8S4hf3TCTFVWOLPiF/PrCETboOq7RSN9ThB2JArUBkoGIJ2D2b0Nn6FHyNGFiEz
         zVZlqv0m0+Mn3A0C3totMQrUoBWfTyqzwAwVk7iorUnPpKY4/Vuwrf7mH/31oy7YhOeU
         OP7/mpNXZd2SzyAf7sblBRWidPEKswx+ZvUbvQqA2B+ZuYvM6c1tnyXAr0v+DwC6LHEe
         Yncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760978426; x=1761583226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2ix8GsYu1u70ball/QdTJXtHk82+gyjHMURpwV0acM=;
        b=Fytc09sqMFTIYJfxxKjnXyGGNiAIKNjnYk4+abz3fXXe4arf2l+Y0uLMAt3GZUFMgz
         iI/5jQX+Eb9dfGgwikwBx6xjYmK83LG5IwmvvAKIn+OBC71xaqx15KlLiDfqgbN1EN2P
         nHjVBrMUjeFH8QYljYBd/Bha55BuaKfAZgs2xjk+qRhMFo6MgdNowbKveCdIA+CJx/3b
         l7qEooOsEQ0QUDGL25aX7s7GwElUGkz5Nnb5CcMArJxw7ljNChO8G2/6N2+xpjWBpA+k
         1goXw/mRcBoXjbGvm9Q13P4PVF/69g8Vq9PVJ3vAIWZiPeXnGp6cC6OKbQacX9JYBu68
         2Gow==
X-Forwarded-Encrypted: i=1; AJvYcCUYqSgPEXJHLE1ePrIToxDNUI5EfF+UUVHb8BlSWnvcyujyHADU+AccVMf+x4CaGZ6XHzop4eV8@vger.kernel.org
X-Gm-Message-State: AOJu0YzKUTdTrTIMtdcX9gGszoQVzKLduDRtojKAJ5v5NdfjuEOFm7Sk
	QjkdQqg8hN/xBICRrLS+6J2hfvlQPCmJQaKO13VY0iVi2d7IA28M9m+Kag8itn0DUPcU8HEWApv
	bnPXhLo7VHOzaIKKC8MZUtjLe4DLiCRw=
X-Gm-Gg: ASbGnctq7pKISp6ULKP5t9XzCpOa9UhgE/8M44wKDN1I/dYotIG/Kb+BjCNH9uzl1gV
	CFSpKKw1RnKQqStbaDvU+3MuN0nwQ0M1E18mzUsSabK03ANcwqiV4fGy5PvgXPS6O4Mmv6ip5X/
	vxjO7B/L6+ftvf0GG0kobJRsslNEaLxqT+6icEe+mQx876r8FhbA5XZ+7BTHfCYT5Z9yKRLcjQ+
	oAtMQ7fPu/gRJQ3z5wn+XYJcTrpsMDbZaV0ZUh+PoJn9nKCtc98kdHVgqFvCmejuLK3QF0=
X-Google-Smtp-Source: AGHT+IH7nUvbsTeDRN59lgVV9zEkGiIcpP3IYYWiHTXf/5KAbZpk/qtUVj2M79IXj1uggUm9dGVvxGpKQpP7DKDiLsA=
X-Received: by 2002:a17:90b:5623:b0:33b:d371:1131 with SMTP id
 98e67ed59e1d1-33bd3711391mr16951259a91.34.1760978426163; Mon, 20 Oct 2025
 09:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020140732.4703-1-nvraxn@gmail.com> <20251020140941.4769-1-nvraxn@gmail.com>
 <CAEjxPJ6-po0nSioWywXnkPoxYBOSmdb6dQQud3dT5sbxs_RHqw@mail.gmail.com>
 <87zf9llf6c.fsf@redhat.com> <DDNAGHE330XQ.28CTM0WKT1S4O@gmail.com>
In-Reply-To: <DDNAGHE330XQ.28CTM0WKT1S4O@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 20 Oct 2025 12:40:15 -0400
X-Gm-Features: AS18NWDvK-k1a6xCyscAmFxV6864mES6RttSx7DRIEUoE5j8n4_d-N8te_qO8bw
Message-ID: <CAEjxPJ7T-xTyPhbNnC5GgC4d9wMtMD+pkPF0JgRmOdMvM6opUg@mail.gmail.com>
Subject: Re: When to apply `make format` to the entire tree
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 12:26=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wr=
ote:
>
> On Mon Oct 20, 2025 at 5:18 PM BST, Petr Lautrbach wrote:
> > Stephen Smalley <stephen.smalley.work@gmail.com> writes:
> >
> >> On Mon, Oct 20, 2025 at 10:09=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.co=
m> wrote:
> >>>
> >>> Add the .clang-format configuration file, taken from the Linux kernel
> >>> repository. We don't have any official style guidelines in tree at
> >>> present, which makes it a bit unclear how to format C code for new
> >>> contributors. As well as this, different parts of the codebase seem t=
o
> >>> been formatted with different styles on occasion, so using an automat=
ic
> >>> formatter should resolve this.
> >>>
> >>> As well as this, replace all the existing indent targets with a singl=
e
> >>> toplevel `format` target. Managing all the source files to be formatt=
ed
> >>> is not pretty to maintain, and doesn't really give us much.
> >>>
> >>> Also define a toplevel `check-format` target to verify that all code =
is
> >>> formatted properly. This only becomes useful in the future once we ha=
ve
> >>> reformatted all existing code, but is wired up for now.
> >>>
> >>> For the future:
> >>> 1. Reformat all existing code. I understand this is a big change, but
> >>>    we may as well get all code formatted if we go down this route;
> >>>    afterall, it's not like this will cause any breaking changes.
> >>>
> >>> 2. Add a CI target to check that all code is formatted as per the new
> >>>    clang-format configuration. The `check-format` target can be used
> >>>    for this.
> >>>
> >>> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
> >>
> >> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >>
> >> Will defer to distro package maintainers to decide when to apply make
> >> format to the entire tree. Common practice I think is to do it just
> >> before or after a release.
> >
> >
> > For me, it's better do it before the release so I would not need to
> > backport the format patch together with some future change.
>
> Alright. I'll send a patch (non-rfc then) to format the code, and then
> maybe just before the release someone can reply and I'll rebase it? I
> also am happy to let a maintainer apply the patch instead (I mean it is
> just one command) because of course the diff will be pretty huge, so it
> is a real concern to make sure that the code is "untampered" with.

I don't think we need to send a patch to the mailing list for that,
just have whoever cuts the next release run make format and commit the
result before tagging.

> If that's the preferred route (I still think it is best regardless of
> whoever sends the patch for people to check it locally by running `make
> check-format` and committing it locally, and then diff'ing the patches
> or something akin to that), I can simply send a patch hooking up CI and
> updating the contribution guide telling people to format the code and
> that can be applied after the format patch?

Yes, that seems fine.
