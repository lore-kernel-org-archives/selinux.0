Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDCE3A16AE
	for <selinux@vger.kernel.org>; Mon, 11 May 2026 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778503700; cv=pass; b=WUnT84vn1MyKh6gxsokhXigLGkAJJ1CjFUw5a75cU2Qpt+zaRJ/YMTjSSwjxksIYGYkXalq7sa8qslejexitV3lp3AcmWBGDZ5FAcIg9BZTo0vWXXlgXbtbSMJ9VrYZ8qbnq0YOr4iLiBa0Y2YTWcBZByVl8Mv0cpBuN92IXvqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778503700; c=relaxed/simple;
	bh=koDKSPOlw7gobS7LqMnkDOoTLFp8XX1iHonQSRvuZlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6Ch+nnWPJQlGowxqvn+4TgWTmjt5O1u3CIPC1w5MUe8SrmifOTEBqRMd3lBnfflbx4NfAtItqr8XYIeUtOEmghWOG9iXDWci3wMUo6vrba6MnqcKe3tOCG/kfLDr4egwdkCc2Ech73ZXe75GztR4wa/lJaKPN541QU6evclwAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnvOWZxm; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnvOWZxm"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba21d32776so28378915ad.2
        for <selinux@vger.kernel.org>; Mon, 11 May 2026 05:48:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778503698; cv=none;
        d=google.com; s=arc-20240605;
        b=W5aFoqHYbqX2Gryz0I8kDj5TwcCAeOMbN3yjFd0Wy88hVEokm7zhV2/KDcB9hj+BgT
         0CAbw4W+BXU+Nn6UOqmtDhgVJJRCk7C8mv286UbT7PwwAEQFDME811g+ZNT0Le5tl7/G
         oJLAu9V+oWQ3nlruCA3o6/Flc0+GTqnazUiAA4Ucg7BHwNx6f1LZhpdzQIt3gsZKB1kD
         bQZcmRlQSYBUIFp5eOQN9MCPGWl9hZKeoMZ+2uygNwNMedylyUHjvbZYoatF9Snof/9G
         j/kg2scuVUDiDEoU9WhwwfVgACmdyllU8qM7OTi1SeapmCnW8KzPBoO0rxoVEp36VNNf
         zsEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MvYhX5f2D0K2DOJZw2jeuTbDQ2n37dPV4ljEjI8QK3c=;
        fh=YIXy62M684+xkHbnDTi4GQOeNbn0oP/q82f8eoFcz2M=;
        b=iayExtGqgCg08hgTLQ8oE8TMN/dLYZyA7/7nNNUhZQjeOiJQ9XD+OteLp7D+hZY3gS
         Cx6kKrh2JBo4mbBPX390oRJJR2VIoNZJBrw7sUndV19rZt9hYPkFs1P8niinx/tUr5H0
         /Vvr7MFdvv1t1yV2ue43lcs6qoXNk5r6I/uV+GyjpI6fNNmDJTtuhMXJf5QZM7ChCfao
         FPlbdtDZu/nsNOwKaiUsKE4V+JEvtfdNXCeBMQ17RIexYNiCwbrQjiawhQ4eVrVScQcS
         uadvsctka8qKzK3WwGQmh7BIR+gHvaHOeSh1+tZ3T7B540+A8jWbm1ud0wzvRnX5u8GB
         wiGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778503698; x=1779108498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvYhX5f2D0K2DOJZw2jeuTbDQ2n37dPV4ljEjI8QK3c=;
        b=ZnvOWZxmoUTuvRM8kLAETnXNMGcQCXwLI2hbinOYenqn+f0+Pk9C4IlalUc74np+1H
         GeuXPae99S0EtPQPNE8J0UDlhpeVU7WY5EVLpw2q2/dHS4i3UfERiQ4+yPwkGLES8M3b
         CnRWY6rcc23Zj9Dlaj4P3NQnkHZY7Eqa/8ivkvQTCeUTUvOsyUV5g62Hsynq/F2l9z6Z
         o8mwy3VNlR44axmkYODvE6A96MuNw3b1uTvXrTx9UQ0YEL3PRrJSU1L+i8oL5qS3wnh3
         HNRv7uec6K5Xip4u5/ELFIMVooX0kDNgd4GyooyC0QIwy+E5ydXtSARJinabwBPoT3Uf
         ssjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778503698; x=1779108498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MvYhX5f2D0K2DOJZw2jeuTbDQ2n37dPV4ljEjI8QK3c=;
        b=Z2bz/r03tLjOgyq+cq6lyrKBqSP0xCd8Sam5t7VMQ6UBhCn1bVXUTCrQjYtsy73V2H
         NrzlgDWF3uUPyLTfVcNjNxA64chbPwBFdylV+778PkvCzBp2C32d6fxtPIMF0iRkMNMX
         gphAfuFJIoFqkx56awaeErkKsKEsIB9EAVe+dkm6Sy5ke8HVfsU1cnB2kqxAXZez9Rb2
         MH0TX7JdS8UedByq9aCAT97jZCXvZzWyFV+umxwciEtWSf/V/+YJucBQlfXzGU6tDa+G
         tkP5e7P58+eFwqzvf6ndLuZsHUZKZhQ/qeM2v3mVmghOaKzIKJG9UntwSG+I/HaUmzx1
         BhOA==
X-Forwarded-Encrypted: i=1; AFNElJ/O4wZF8UuVb/EWPoBqHIOSmz4QIGRh4QAuEKb8Bxx5BBdwK4FzVllCustW0ferdnu0ZXGsRSP2@vger.kernel.org
X-Gm-Message-State: AOJu0YxSyLfnhe4AZQJtkXMGabQvqlwZRqw79AEy9zecqUA2qc9gAJs8
	3Nm+ZSnGASLzzNCQxdsv5bS39j/5Pu7QD8HqpUVT8cw4VEkJ1jU20s0RvnduuG1FMiZEZovJ+GB
	M/z8orWsO2+CYQmhuSf+Y4NTnKIM0p/8=
X-Gm-Gg: Acq92OFI3DOz3RM27g9G6rF/0Y8WhUtW8KJOD8QzT6f9S3Zl7booqvQ1WGuEPV+DlS7
	5BdGHd02fiO9JJJGOs0Rse3J4XjRGyTtbyivcAllPFFBXtZnQA7OSa5jaw9nG6A+WWJHCNTjHni
	ZLN94fd+yArJwriqTWvAaPu6U+uxAtqx1GW0e6OfkSonH87jPlx7vddgbRb7Vp4WXJuS3Y4TfeJ
	CYC3Uh/1xmlnK3mRR4+NnX+gC9H8c8YCVR3rKbj+eRuI29YOWd7RuNkv96qLchAgVK9ki8lQAFb
	rwZxibg=
X-Received: by 2002:a17:902:e747:b0:2b9:ef36:434b with SMTP id
 d9443c01a7336-2ba78c40a85mr258904045ad.12.1778503698220; Mon, 11 May 2026
 05:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409094222.2859087-1-omosnace@redhat.com> <CAHC9VhQBfXhB8KZK1W25mqVbzQyj6zEGwtRF0Mse3Pm5P-tYqA@mail.gmail.com>
In-Reply-To: <CAHC9VhQBfXhB8KZK1W25mqVbzQyj6zEGwtRF0Mse3Pm5P-tYqA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 11 May 2026 08:48:06 -0400
X-Gm-Features: AVHnY4Jk3j261TbJ8KhwPBpIPHquF9rJPDGS3AYsu2iv67oidclP-4r8YG_MMrM
Message-ID: <CAEjxPJ51wQ3LWNCKe93QzWbXn2M6ZaY3MhfqZvpQAQ6OgBQn1w@mail.gmail.com>
Subject: Re: [PATCH testsuite v2] tests/overlay: add tests for mmap(2) and mprotect(2)
To: Paul Moore <paul@paul-moore.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 2:52=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Thu, Apr 9, 2026 at 5:42=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
> >
> > Add asserts that verify the expected behavior of mmap(2) and mprotect(2=
)
> > on overlayfs files.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >
> > v2: style fixes
> >
> >  policy/test_overlayfs.te    |  45 ++++++++++--
> >  tests/overlay/.gitignore    |   1 +
> >  tests/overlay/map_access.c  |  55 ++++++++++++++
> >  tests/overlay/setup-overlay |  10 ++-
> >  tests/overlay/test          | 139 +++++++++++++++++++++++++++++++++---
> >  5 files changed, 233 insertions(+), 17 deletions(-)
> >  create mode 100644 tests/overlay/map_access.c
>
> Two test failures on the overlayfs test running an unpatched kernel,
> and a clean run on a fixed kernel.
>
> Tested-by: Paul Moore <paul@paul-moore.com>

I went ahead and merged this since it now passes on the current
upstream kernel and Fedora kernels but we may need/want to add a
conditional on kernel version to keep it from breaking on older
kernels.
