Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D676E619
	for <selinux@vger.kernel.org>; Wed,  4 Sep 2024 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725471529; cv=none; b=b9rmvFk8bDcwxlhJbypBcng/2cg4VB+4ycg4EJpSc6faM53sEdQW89K0NAoSA7KbqzXwZeAI4MWlh9QIlJyZkKayo4JFkA/qrRGVyDxqN7cGkvFTkerx2VyPQxzWPVu8Q2GyDWMcux6ORBqgj1jRi9XgwUnFWkjgwWz4L+engMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725471529; c=relaxed/simple;
	bh=wUKMDspWUUN/tHkSOCIdo+eMogIw0bmlGOAB4GULvPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsGCxdvJMm6ZUHzAZXbq8qvTLw3D3WjnIBinnrU3LmaPg9L2N2/UmlVWpcxNH/jqwqxFZecWEGVd3lBab+7elxqTVKw7AqP7aQtNJzI1fqBVNQTss/L3h1pnBsKD1G5A8XfLF7ss1PAWwM2PsJaL+riZ7Cw697tpsMrEoAb4Mxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N0dj6uBV; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N0dj6uBV"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6d4f1d9951fso40650377b3.1
        for <selinux@vger.kernel.org>; Wed, 04 Sep 2024 10:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725471525; x=1726076325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUKMDspWUUN/tHkSOCIdo+eMogIw0bmlGOAB4GULvPU=;
        b=N0dj6uBVlItktoAMVkGP4f+G87dpeMTUH3kGjpbDzNYDx4iwwMVzj5jHDkejnF694E
         GAIC7qbXzGJX5fXEQRd7hDsTrdekVDsmw/+p4jyK/JQAXYWaRPaIXoULQS551S0F3PfN
         K5m6Uu7OFQSsYmyiKw8+RHZnddw8VR/k0anD9t09yHis64RlD65678OQhKTshoZJKRO7
         gUydAU7Rt1thDQRkMTT+ciX9hrVbfO+3OcjzAxOSW+ywE+FpAJySmktU84W9s9Zz3Msn
         V3BuTmvXQC8dcS5PnXH/kiU7T0v67PYH7sTuM9Vm3zzCL7PE3pVucxhe86Wzb3QthTZv
         RmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725471525; x=1726076325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUKMDspWUUN/tHkSOCIdo+eMogIw0bmlGOAB4GULvPU=;
        b=NKzJkpkvjwxx3OjAJ1U5r3lzyiPAjcZYX2oyLO1vWVlxrxuEgg7jO9VaEDpb1wHoSB
         Qdpl6YoU+8J8jSM/zkXgMSh1gltNMqXk+13X+0PA7cA9nbmVYbHR0fofQcFeGzC3qsT1
         NAqrSoWiljXnWDcSCUwruPxGUTcQMM4CFeSCEa99Kj7jKFetAWXtsgtN/WlSCLUR0dv9
         iYw+f1J03ShHp7otNQDqy6UEWPdUof7Rs6WLV8jx77+TVJwnElfu2CZe/T0re2xLQ0z3
         eL1MnnZa7de94jgs+VCVhBrqsUJfDlmdpj84nlYHkuqsC+5cy/u+J2j0ip9oW7ADJKWe
         TOfA==
X-Gm-Message-State: AOJu0YxDHfs7kUlzl1yOzRZlcBF+g+3ZyFrQBsUPesGtGhq1/ctCHPy8
	YomSv/seyTYE6mwdnDAnV38Cny+q2jnZEChil0Hmz9OegnKbClDldKFik9eHb8E7W6rV/c45ewQ
	DJ7FKnCQlmotW6buBJztNlxyXijfa23sTwsCq
X-Google-Smtp-Source: AGHT+IELCp0iYqOx9a1ztej5ovk3ESr4ecpxj6VY5mcPPygGDKwq5F8C7wAaKVjXbAChz4kp7TjfnsngmQpHG9u+IBU=
X-Received: by 2002:a05:690c:dc6:b0:6c8:e45d:ebd8 with SMTP id
 00721157ae682-6d40ea72287mr206162717b3.9.1725471525200; Wed, 04 Sep 2024
 10:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNv7T8Tv_9AYX2xC_tJ9x10qPoPFQsQPBUDOuphUfUFPiQ@mail.gmail.com>
In-Reply-To: <CAFqZXNv7T8Tv_9AYX2xC_tJ9x10qPoPFQsQPBUDOuphUfUFPiQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 4 Sep 2024 13:38:34 -0400
Message-ID: <CAHC9VhSGJjoJBC1t=wmik6G8yyLEHK=YF4rjX=7HH5BG9ogYkg@mail.gmail.com>
Subject: Re: selinux-testsuite / NFS symlink issue
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: SElinux list <selinux@vger.kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 11:15=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> Hello,
>
> While playing with migrating selinux-testsuite CI to Testing Farm
> (more on that later)

Thanks for working on restoring that automated testing.

> I encountered a problem when running the NFS
> tests: When you create a symlink to the testsuite directory, cd inside
> that symlink, and run ./tools/nfs.sh, the nfs_filesystem/test fails.

I'm not sure how helpful this is, but as a WORKSFORME data point:
using the instructions in the README, my NFS testing is done simply by
executing './tools/nfs.sh' while in the selinux-testsuite directory.
As of yesterday's test runs everything was working fine running out of
a current Rawhide VM.

https://groups.google.com/g/kernel-secnext/c/siTFxsFoIhU

--=20
paul-moore.com
