Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50BB227EB9
	for <selinux@vger.kernel.org>; Mon,  7 Jul 2025 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906963; cv=none; b=XvVUrKOYXzzaLeLuzjylruRzDrSl8f0aZC1wQabWUdOYVTU1KFQq75T7m+ekBrB93K+zKs08qqTZTU3YAtpUP50brcqiItbF2eirsbtpuv171AwQl3IwshyatSw4pxbeRbkvwsg5UK/iW03kycprsXUWg/KJxc0o35xFmztwR3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906963; c=relaxed/simple;
	bh=zssOyIP4jhlPPdkxCUjao6Wtzf900t8ROvfsPmyM85E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4QG7yIQky9WDDm9QuOYIXoCLnccyjJrqTOJR4kZ/v21maaLBdLH6EaWLOJQwq53LTi/cJZNQk3JmftkcpP2XuHY7u3FrUsEMx/54EF6BEcpXNo8JTJYJaFnEE4LcLPEhEq7jpfzKdRD+wlKyVBrsI7giQ3PUmBPXkkmlO1uE2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+EXn/0H; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+EXn/0H"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74264d1832eso4091134b3a.0
        for <selinux@vger.kernel.org>; Mon, 07 Jul 2025 09:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751906960; x=1752511760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TY1vGmr0/0Cm2+2oITIxYgGxOvx0AWD6JCwZ0cL2IwU=;
        b=i+EXn/0HWdCeNCx90tCxHcOw8/PD6K7xkJe/X09rCn+suW9Bnmzz//mL1ivp8Yu3CA
         X38WbvZ23RTHQ0Wi3hiPLQho+QK4RMdz8nZss+h4gwhtl7CUD2JBE7CAq9EpoXVOollo
         wyOUnZvOAwZMt9etTu8f0VaJYOy4epeDY1CCrRuO8hGRjh0OuweItToGfG/psvHCi+in
         VXvBE2waMFZbCVS8516jORhKVM0BtCsCaxvdsQFDy3U9druqml3BIK4hgiGRGxgTT2Ry
         Hzbf7Dke07qiyVHHBsp4aACx5a+LEIKQ6J5iEbzLUOUHmk4To0uEtJcK6V3ZOo3BYZwI
         OKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751906960; x=1752511760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TY1vGmr0/0Cm2+2oITIxYgGxOvx0AWD6JCwZ0cL2IwU=;
        b=P4VgoMmybI9flZJg/1Ssc0t+m8sWQtBGoFJtj8K9BZ+azJGoMfJpkoihVIGuUZzCni
         YE4DrN5ayEoGURbr+3tM50GgLmNlPJzcEWZ71tauxejZzKxdASz5A2XzDgFdW0l5t8uo
         iaBwwPtbT44wo3Q9psmneUT2HD1OUzuN37jXeuBNMfBo1Ju8ywDnYudzhk+cUJnUJqdS
         FwAjpJzvGJ41XL1QMuTjLhgRoftKTqCkCINhOkl2jpmNShx1bA+1uWXC1DD888nv+/oT
         xtmM6qUIX03Hl6ZrwkRXnzKXRjGt3jJKeB1TnV1ekC2Nbn26NC4Yxgu7y77WNMdlZhct
         MRCw==
X-Gm-Message-State: AOJu0YxzntGQJrr9IwlzaF2l6VMkqbelj1qYr9Crq2P6NYrODHk8MJhS
	eAFUFMLNurzo8CzSN2U3cS76lJudaHksL0DWUkjJa24NxurCkaGyOpDh/bjDT2MeZ3jICNW3cQ6
	jlHZAdRvu4toliZ5WRWHCnpTwpvV+rUE=
X-Gm-Gg: ASbGncuWarzwFzEBe0K8lY4UDxWvWLySKlH+dTUKf8Wb1UOOyNTrQzu9dlBFfzy7eEN
	R8xvoXI1D7jv8UlYmTUhF+/5p2NB5RX97IBjJAMIpp7zckhJpBVZO9XKAITI540M2dacwOuK+1r
	EKGMu+WMp7P9UYtY8inpRBsgo/z6Y0aujytaH8KQyeSec=
X-Google-Smtp-Source: AGHT+IEt9+KV/guRA7pIO+BkupaA6aGD9WzQLKb02iKh68V0usFGQe+iw11WztLcngSc04FYmm9uE7erzc+B4TBL2+E=
X-Received: by 2002:a05:6a00:21ca:b0:742:da7c:3f30 with SMTP id
 d2e1a72fcca58-74ce8ad645fmr17942392b3a.19.1751906960065; Mon, 07 Jul 2025
 09:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250705121424.1221268-1-omosnace@redhat.com>
In-Reply-To: <20250705121424.1221268-1-omosnace@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 7 Jul 2025 12:49:08 -0400
X-Gm-Features: Ac12FXyQKU31INhBClO3bR834cwXjP7_HrcIlD-FonQhOPKVzQ3VtOEyOhHc36U
Message-ID: <CAEjxPJ7Us8cwOJp7voShry7iDkSMHEv+-RObUncVx5xwZGbLEA@mail.gmail.com>
Subject: Re: [PATCH testsuite 0/6] Make more tests run in the CI
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 5, 2025 at 8:25=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> This series adjusts the TMT setup scripts so that some permissions that
> are currently not supported in the Fedora policy can be tested. It also
> cleans up and fixes the module_load test so that it passes on both
> x86_64 and aarch64.
>
> Ondrej Mosnacek (6):
>   policy/test_file_load.te: remove excess semicolons
>   policy/test_file_load.te: use testsuite_domain_type()
>   policy/test_file_load.te: adjust to kexec behavior on aarch64
>   tests/module_load: run sh instead of bash
>   tests/module_load: fix the location of "2>&1"
>   tmt: add some missing permissions to policy before running the tests

I acked the entire series but am fine with either one of us merging
it, whatever is easier for you.

>
>  policy/test_file_load.te | 84 ++++++++++++++++++++++------------------
>  tests/module_load/test   |  4 +-
>  tmt/tests.fmf            | 28 ++++++++++++++
>  3 files changed, 76 insertions(+), 40 deletions(-)
>
> --
> 2.50.0
>
>
