Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408DD2737F2
	for <selinux@vger.kernel.org>; Fri,  1 Aug 2025 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754072484; cv=none; b=c72DSoSTOztvXLrR2dTIRMWJ2FSGA1GRbsEIRHA5kW8bojd6AA4jY4mDCX29zeB94zZpYng5Ve0aLLkjhBcsP1T2D3eiNMmvN33xP6lLrEl1rxrU7mL0q76J8aV5TljD+/JwYKtrq6A1jlrlhLRPndT2v4zeYNsrREEhH1zD+Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754072484; c=relaxed/simple;
	bh=lhmqeqBb5B08uWFvtSrqHUvfWHc5inFhbw2642W9DZ8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 In-Reply-To; b=t4K4aWE8s192+UF2bPQHp+xPYXjJTB+hpVGTkGt3QkbowQIoNvA5IUaVPqhCGGuF8PIg3foz8YpWEThcWuNLmuplvedOuU8tLj8O6ORaMhbOoheD1yBkSCw8xlcw1HR9QDgw9LIRATTunPHDUlu7BXKP5diNZidrTMboGvQeN/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMuaO7Js; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMuaO7Js"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45617887276so7518265e9.2
        for <selinux@vger.kernel.org>; Fri, 01 Aug 2025 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754072480; x=1754677280; darn=vger.kernel.org;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDfIOziBBr5F+QtlXxJWbtXoBzOtASyAWKHwPsinZLw=;
        b=LMuaO7JsG6vwBMdYuP6ahPH1ePBDXN0ASbfV7GU+1LsDWTVjgxWWLGPYbvshq/BCLD
         aHIixBEJTDAoahzOsUV360dD8+rQJvXzAvFLjiact3r3/NWK0TudMWTyjO55zYldidWe
         QHwWXFMJcp04cHo2kU/iZpZCIh99v+rPvO4OLQLDrWIR6m41eu/T0WJvYVzaXC4gLFVL
         rCz6Vz+fRVTh255/gQj5W7GgwqF6UnvBRsfB/94pvxdDMoNoqHDeCaJhgmTcfo6Fm2OU
         njjbCKQWkuLo/S6VqGghMkzHWwbfnKuPIIaUdvHnvOSaX9aYrPRn1VE/a+CPNB4DFPZK
         jp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754072480; x=1754677280;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oDfIOziBBr5F+QtlXxJWbtXoBzOtASyAWKHwPsinZLw=;
        b=e+iyG+HBVMxgOXiek/IqqSW2zPw+MBI8LzTNAJU3/jRQppnQrHFUqnrAe0AaFsptM9
         Mj9IJ7FLODKPUh9MXd3ds7BjnU9xspofDSa1uSC7Z3FOuN+9CcZBe8S64FIvYt8H0jtF
         0JUbP77XMTsh7C/E2j7u7jL0UY4vmXu6rqsVN8PxbpkZ56pHjKDQBzTsSCIyw9e4TIim
         W0Qb2PnY5pmA5mzXAqvLRm6em2H/P6lgHEDtjnkW3ZK4TSyD37DNUxvv6qqggx4lJmgS
         173fSWPYmIyNiaDYAXvcIJSGI3VMSC1VpczMGINb0JMjX7835kRjhEue1pFA0tP5vMQ5
         unwg==
X-Forwarded-Encrypted: i=1; AJvYcCV+0PFzeQ4UNVoL6oeMr1u48zxxU58RYGDMLjjEFirWbOWOJwhv+5RqrkySm10s8qo/vGgpAlHI@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3fqD4tvD5Fu/GE2t4ewVEnsMa8prhMFc7aohcdncanWXiHc6l
	VBQpTZ9fV27BbLdLVvUQBJleLf8uqMTuKbG4imnudUyyrPHqKZ5BKigiD9nxxg==
X-Gm-Gg: ASbGncsc0OyZRCgHqal2vbenYwyhQauvkeYjx72+E12kx68bJULAU3pbY043hqbEi5y
	d5FqfA3SYp02b3U09L/TDQaT+yChIcMQ0p8yVdy9Va/P9YnYcFM1Qt3Q/zU+7z72O9X4Jnka2wX
	utPqxSHX4s2ufwwXh41Y5MdPNa2I4V5PrUphAaPHh9atIVogFl+nHMP3KbKGaToYS55Y+cTq7jD
	6AIKTbQKrxfPdAhJkLSN2f+KlKQNjgP7LaNI61q2hg37OcK7RKIqTfNzQ+9TehyddXwpXbEA0FZ
	OGdbp/ZWoT/uZQjok2fA0KYtdH8ovL2kYvdsHoxrSgj2T9ulRbPkCJuckGLTPyTMsq1FPnhTCm0
	5pU7A7/r2G5BrjCnh
X-Google-Smtp-Source: AGHT+IH00KXqOXSeO4OFW3sFJx+SAsct1zAjfDJ30KuDo5YnCTIsJGsm4zYhZDlkvinkhEXPBLzm8w==
X-Received: by 2002:a05:600c:3b89:b0:456:2d06:618a with SMTP id 5b1f17b1804b1-458b6b36b81mr2318335e9.18.1754072480505;
        Fri, 01 Aug 2025 11:21:20 -0700 (PDT)
Received: from localhost ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458af917d20sm17187365e9.2.2025.08.01.11.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 11:21:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Aug 2025 19:21:19 +0100
Message-Id: <DBRASSYXDGO0.2X50XS44GR1WL@gmail.com>
Cc: <nvraxn@gmail.com>, <selinux@vger.kernel.org>
Subject: Re: [PATCH v3] seunshare: fix the frail tmpdir cleanup
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: <stephen.smalley.work@gmail.com>
X-Mailer: aerc 0.20.1
In-Reply-To: <CAEjxPJ6QGZcAO zjdajOFTaDc
 tuh56Vao3niO37udEr=UfAgg@mail.gmail.com>

> I would think the idiomatic C way of doing this would be to use fts(3)
> or nftw(3).
> setfiles/restorecon originally used nftw(3) but later switched to
> fts(3) for reasons I don't recall.

It's worth noting that fts (3) is not actually mandated by POSIX from a
portability perspective, however we do already depend on it for other
parts of the userspace[1] (as you mentioned), and shims exist for other
libcs, for example musl[2], so I don't think this is a huge deal.  I
can't speak for setfiles and restorecon, but nftw's api is pretty crap
compared to fts, so, like them, I'd rather use fts for this than nftw
even though nftw is part of posix[3].

I think dirfds are fine to use here, however I'm happy to send a v2
using fts if you wish - would you like me to do so?

[1] https://github.com/SELinuxProject/selinux/blob/main/libselinux/src/seli=
nux_restorecon.c#L17
[2] https://github.com/void-linux/musl-fts
[3] https://pubs.opengroup.org/onlinepubs/9699919799/functions/nftw.html
