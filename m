Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902FB31CA6A
	for <selinux@vger.kernel.org>; Tue, 19 Aug 2025 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629576; cv=none; b=KZSWQnJmnDqAiDcN/lCQWJHpqcDzkMwaPnAeXgtiELzdAX2jBX6QEHbXWU4iQCC2g4LhgPkU6lu1Gm9oLAPR8+9jLktChpYVJw0NP9v+dI2D8QPo7D7YAt+hiNA5FpFDiAlNJJgthwgWZnE3JP2KykiLZkaUGy/XtC3xu7YCbkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629576; c=relaxed/simple;
	bh=e5MJ4oCvqsCgQpSPaOFyxiPTod0UmEngl1dv7gwvFCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKGBUQ9hRwcd/YQGjwXsG1i6Km1zygzBImpRURcSe7znP+5qjqoWRDU3Ge1jMYsJ+gDun7tANMxG/dzfpRZl0nfiFmJVZf44ZwRUvxbXs+f1ixm2j4k0zyV51aQYZpPwqcVxsBK8qblU+oTn6xSy+cbnsDJllGHC5yx7F8k6yhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aNwSRuuR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aNwSRuuR"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2e614b84so5405606b3a.0
        for <selinux@vger.kernel.org>; Tue, 19 Aug 2025 11:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755629574; x=1756234374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuS/iFgzwKBg3yEC4BuMe5siR/xqlZdxjG0KUcaTc3w=;
        b=aNwSRuuRmeR07G//9UDRY4dX4SAq8K5Kr+xsaB+3+2dznkgMIkUE0KwdVWtc+uAaht
         8fHT+z1wFwUyxQzBwTwElSZYhmSa0QTScIQYl1tkScePVgGQhjyvULomAJpH1+h3aNMG
         /lYPzcukIrTQpatemWKm5pBmY1iicSvJphnWBB/tjOIZuzjTpjL+uP2B6nhi9W87Gufg
         yNpFWRJWgw3ZmPL9lhJ4VzRX4aeB8emUXIukjaEOVDfzGWQf32qweMuZY0oMMFzqyiF3
         Vse7ikb1w4SOQHlgnJcMIfuXnn5B++Zk37wOAW41qSJay46fkBeDW0cToATckAXU9bgQ
         sUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755629574; x=1756234374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuS/iFgzwKBg3yEC4BuMe5siR/xqlZdxjG0KUcaTc3w=;
        b=RvbzQWpdpjovn9HixbtHXO53ob+MDih4jdvHPUB8UPqiy/EcW7iWkQGXYv4vm2uulJ
         uk4z0JDdTYNSgFwOP4hILf4CALIlzeuaO4WZFbuUWe7lS4Ig/3LNwjuRlOetmSsSL2C7
         l1zxERjw8wWQmVHrbr7cJxVfEBXB8VlL2YMyql+bOgsOrZSdw50mqRr7ST/Ls0oJfVig
         5JDI3t8gdgRFgi9kb8eDngu4ZkXTi+CbW308w8o1Kp7OzBjyHuobBRhDesxxh3W7pOXz
         oLRBfMvwTU7b5HFG2JbMiDG7OtQJZ60hFZTLnZe2gWK4iBrZE6pKaFNU9dkkB5fS62fg
         TfZg==
X-Forwarded-Encrypted: i=1; AJvYcCWTBJTZLbYmIx/6EdAAfw7h0uevat4u6JBAao3hkvnbl4rmSmxYhzQCT20jgaAV1/ut72pcLssX@vger.kernel.org
X-Gm-Message-State: AOJu0YwL0b5uoMC4drlJqL9GBZSDZN4ZKJ7Q2pRLhTC/fJfykYVn37gy
	3SS5pSpOGcgcCZWkcYRx5QQsDrBeBqbg2iu5OJ8m/OyFcG9RFSE5CfKbjMs2TVL8DYkOeij+NY/
	QPSmAiaz0f9YvfmFQjpz3iF8crbK4AuVGx5/vJFK0
X-Gm-Gg: ASbGnct5Y9vEi0oda+smBuoSf0zxEkKogLvESzEdefDho+GiBNMuKS66KjGU/p4Ko9F
	+whHBKvV10oh6VeV7eER5Mz+xq7H+Sj1IM3Bcpo2eXSSeJQP3lHUajZ0iWqDwLhNV8VOrfNl09v
	RnAOSczFuBREaNPJCvcU7Sk/3coWbkHQmXdKkGJzDlJnnq+U8NpmIlzz4KLR1U5u81FCN/WHTbI
	lsxbUwki1SepcRiXA==
X-Google-Smtp-Source: AGHT+IEjg0JTlsfYLhIaNIWm/+OFgy9gKpVMV7qP4QiaZse6yTqXP9wbfdaXcmVovfwzrMp9gPjq81VlifFJ9lzEhFA=
X-Received: by 2002:a05:6a20:8b23:b0:240:1d4f:720b with SMTP id
 adf61e73a8af0-2431b816016mr451106637.23.1755629573783; Tue, 19 Aug 2025
 11:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com> <CAHC9VhSubXA4tAUoz7T==UvfrM_DXS6nF5s0tJZ1HrrVizMgZA@mail.gmail.com>
In-Reply-To: <CAHC9VhSubXA4tAUoz7T==UvfrM_DXS6nF5s0tJZ1HrrVizMgZA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Aug 2025 14:52:41 -0400
X-Gm-Features: Ac12FXz946zCN8bsQVbzdwKm8mEfRf0FGCuvjfYY-3eGxLuEeUqQpZt-ab1VxgM
Message-ID: <CAHC9VhTnCKyKJNG-W+VNVHZLwNDujTNOR80VRdtmn1zD3N33-w@mail.gmail.com>
Subject: Re: LSM namespacing API
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 2:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Tue, Aug 19, 2025 at 1:47=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > I think we want to be able to unshare a specific security module
> > namespace without unsharing the others, i.e. just SELinux or just
> > AppArmor.
> > Not sure if your suggestion above supports that already but wanted to n=
ote it.
>
> The lsm_set_self_attr(2) approach allows for LSM specific unshare
> operations.  Take the existing LSM_ATTR_EXEC attribute as an example,
> two LSMs have implemented support (AppArmor and SELinux), and
> userspace can independently set the attribute as desired for each LSM.

I should add, for those that didn't follow the lsm_set_self_attr(2)
development, if you want to set the same attribute on multiple LSMs,
you must make multiple calls to lsm_set_self_attr(2) (think of error
handling/conditions).

--=20
paul-moore.com
