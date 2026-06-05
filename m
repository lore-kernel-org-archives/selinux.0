Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD4019D07A
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780660612; cv=pass; b=G+GMCw18rdhF0DOjiuPvLz3JZXemkima6eoP37WLcC8K6PLtqrZil+ZY6AT6TAEYBSlaLEdq0Hc9UAXige8kD/QpxGnCwSO5y71GeP7hvXLmGnm9/IkfXZAcO6D+FdnE7TAFM9LLOq0nyy6b+i/yZSS0fY97UhO5/2YcFi8QyF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780660612; c=relaxed/simple;
	bh=X5DCEaQ04OIB5SzVpSmhR+qmHek2dVaVSKqLm0oSGcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eT6GsyixbyrcUkzX+wzldRsUH3rft6ADfupNe62RgqqWcoaSXhnZJCytm45ASQ9RcPMo2uDPNoK6nXSyR0ZZJ2Z9gFxrQCAWVVAQX80adIPm4KZPQPg2FbjM1tP2xdLO/z//TF50/Epg+pPqwX4gySd6AlvvA87tAJ6aSg/hpq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YALvOD3X; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YALvOD3X"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8423f420455so802564b3a.3
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 04:56:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780660611; cv=none;
        d=google.com; s=arc-20240605;
        b=R5W5JPiyh3/Sx2HRHLzYU65tXNRG3TwlBH4UNTzWtFzsQKof7Ik9e9HvswL6O0bHPb
         hMU/YY96sfYnrda7vFnIv4pkzK+lKF18RyjRI4GskG7uCRsQWfz3oAIJlVqe/St51wC7
         X3wgPWlH6+4z3miuhzctNZsi5HUL/LAxFfvCA8safJTAh7tKr1GrEJhLv16FvYO5p4V+
         9QsHa0B7DBNgLTMNiB+K5/SUSxB2xEx2YWGiBz8VSiKHCLjF2TGQjhjK+jbXkftrE4Cn
         08mRZVM1LdFQabSqr7Li7g04pVdRoWlhuct2ky5friDYIKS2zRlJF5dQic5GB3KLVVwO
         bY/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o74V/saSGXu2JXtZQ3jRy0ndnTKuCgw8OOSpXTnvGY8=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=AUMA/adX3xuFDZa0QxRxBCvTEPHQalRQeTHakZDlHHkHiZzx5u0+ux0s4z03dd+SJr
         3UrMqSCNdGR5bauFJrRZn6lpWZ1H9WDbYfnSzA9pdX03/tMZxoQbMkeJUwG6MLllzomG
         hNtNUahzJP+Cubfjx+FfdPim1XNgkDYWxnVR0h4ogTAA+xQuLbPD3i/3CTHzVTM1tasm
         hxEPqxYhrJHMetvxL6kztLggvyKh3KuFNcTpNTefBO0aAkkyTL+4x/PtF0HEbeUz+W6m
         mDf8C9cFC3He6sZweIsI2ykOpkN2nuObDV3ysPX5V9NKuW8LGBb8tJgpbF1Y8PqSWgiN
         UrNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780660611; x=1781265411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o74V/saSGXu2JXtZQ3jRy0ndnTKuCgw8OOSpXTnvGY8=;
        b=YALvOD3XUgiarKJjQxtaokf17rMEmURqCtaf6tEN4Sk3IXcnFSwYbzfLPZZ3ov9/BX
         JDGJRoGvCbIJxoNbjbuOzuYuqQG/+OXyIsf/6R4QVeeGyuQP2bBhxzqc+GMROOStMQE4
         dv3p+0vc3jJHdTHL3QxvKfNt1YLHz6eyVx5236NsXWrWGg2JZU03qYpcyLYowkajXtsT
         SR/w90tkulQ6PSf8dGYt1QEL/kvawPAweVy4hGNo94ER+UbQcZFphNbMFDncM5faab3U
         T8DbkTt0WvYfOqhtdh9ss08FwbE26j2LC2jrJaVag7Nw1a/6Uvxhb7lAge7rIJeJq0yL
         r21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780660611; x=1781265411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o74V/saSGXu2JXtZQ3jRy0ndnTKuCgw8OOSpXTnvGY8=;
        b=WB3UjA1drUMfNg9dGgcTyHwYU852Meb/C5Y6C7DfJEhdYGelFFzz4BHZ8RXRWHJatn
         jVuNZATc3iOJoZQv6Rm5hEPoJ9yTgPvVoNtp41NnxnNPlhZMxjqllTPVNlIk3ZNGBIeN
         4Xx/FSHoU69KalwdtEAuIJekCp38/58i16hAJ5CP25j8OmbV0Paca9uWJ/xxEuWV76gp
         t95BFYse1xhMaJh9PMbG5kWFCws1PAX2PK3KDBHj++10b8HVRcqSOcJTD/WuqpX2ZK1A
         /Qh0423k+VbE36MOwjWGnxFMBR/hBSML6R+svniysYjAMAGMwLax6+J+NPq5dBKdOMMG
         QHIQ==
X-Gm-Message-State: AOJu0YwBTTT7YVJ8WZ1/j7jM5/AlqueCgYQEtD6LQVPUlRd38gFVPPK5
	UwQKsmJdhx6sf8xSTVqMJp3/aTsv7qErItw9extp6upNM01QRA/xiGvOd89rg7NfeudGBqx+6t5
	Ipm4ZQrfl22cm430Yv5AcKAAIsfImHy5PYw==
X-Gm-Gg: Acq92OFokrfi3ov4qDdnfVHEJM4TmknXMFJX2NRA1QgHZHJZ+9/hZNdSA9RoiXfmeqq
	otCUrS8A4sEOhuInHgZ1Rd7D64oKelYK6x0nfei1FIgmR+i4AOaUN7WI1Kl90mB1Z927QQp2XCv
	nHXka/gqnKBQPKVD31G97B3oX62wzGJz07i3vyqwHxfyHOU2M5i0nqkw2x6hKR5aUAnEk3YC0sU
	k/AwBLFrG2dKffDbpSk8jwQtScxXvvkpjhle8lc7tmWNF83/Zo6tFencFQgkBdDTUui61nxH4+r
	F+W+2W9LJkaubA9MDQ==
X-Received: by 2002:a05:6a00:4098:b0:842:40f8:74d0 with SMTP id
 d2e1a72fcca58-842b0e2f5fcmr3345254b3a.6.1780660610870; Fri, 05 Jun 2026
 04:56:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604193105.56300-1-jwcart2@gmail.com>
In-Reply-To: <20260604193105.56300-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 07:56:39 -0400
X-Gm-Features: AVHnY4LqFO4a51DITIDJC6FtDvb71vc7qPtF2qxQxWtJ6BocV0C-mhN1lh8Ayyc
Message-ID: <CAEjxPJ6PbESQszZ2HRCQSQ_LKX35LzdkwAH_=kxQqF7iqN9DUg@mail.gmail.com>
Subject: Re: [PATCH] secilc/secil2tree: Test for stdout rather than stdin
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 3:35=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> When exiting there was a check "file !=3D stdin" to avoid calling
> fclose on it, but that check should have been for stdout.
>
> Check that file is not pointing to stdout before closing it.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  secilc/secil2tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/secilc/secil2tree.c b/secilc/secil2tree.c
> index aae5f998..dc12490d 100644
> --- a/secilc/secil2tree.c
> +++ b/secilc/secil2tree.c
> @@ -220,7 +220,7 @@ int main(int argc, char *argv[])
>         }
>
>  exit:
> -       if (file !=3D NULL && file !=3D stdin) {
> +       if (file !=3D NULL && file !=3D stdout) {
>                 fclose(file);
>         }
>         free(buffer);
> --
> 2.54.0
>
>
