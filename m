Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA5D3D76
	for <selinux@vger.kernel.org>; Thu,  9 Oct 2025 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760015933; cv=none; b=V1uIfAiYXj+tl4g3PwbLLmq5pqYKUv/JmjOSX2oxuBDZC9FnyIJOoStYuXG5PV0eLT7EH835fnOB3Jj9mA4KJKGkhww/PicDk0SYhVLBprCNBX4eF7ux8t7K8aQ6lUcD4bXhUAZ16Gf4vxCYMRqKA5TaCW0XEGgHapTEyQnZ9lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760015933; c=relaxed/simple;
	bh=p0YAjhhhH37lX795n6u0/L+9yO2Im0Zv1HhZuToFbw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTqYc1OJcGCuLLxjbmFCYCzIScXX8oKT2hMmflk2nlIJWmW7XtlJnsC17egBWD4D+kjOntXWFkhDvra6cXTBG1rgRU09ry6GDJZJAoXSC3ve8a0pQzibOhP6RqlJtdPbhVidJhZITOK7iwr3GCL9VlOY2x9H6kZ7n0XLXJPGaPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C8D2IxiO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8D2IxiO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760015930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k2tO4yVBtolebgKeOAT2jH15zJAI0Z3uQj3UvaNLfss=;
	b=C8D2IxiOrzkl5elQyGOOOa4rbqpK5VFl/HQGwIaKYac/T8rYW7tuyulKDfBLGeU6ylJUPK
	W2MjahA4uh0s3wdNDZPPr7AETgzT8s51Nt+QUnOyyEzMIWCTHG724+6ICbsjpMsoMDeVYt
	Pl9dNGUFKg2SR9kADg6HxjFHU2kZaEg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-xFpNn2s6OHOEOYxW28nhsA-1; Thu, 09 Oct 2025 09:18:49 -0400
X-MC-Unique: xFpNn2s6OHOEOYxW28nhsA-1
X-Mimecast-MFC-AGG-ID: xFpNn2s6OHOEOYxW28nhsA_1760015927
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eb864fe90so2832261a91.3
        for <selinux@vger.kernel.org>; Thu, 09 Oct 2025 06:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760015927; x=1760620727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2tO4yVBtolebgKeOAT2jH15zJAI0Z3uQj3UvaNLfss=;
        b=H9Ze41JXrS+8iuovqQ5gtXMkc5Xe7Uc+TYszHZ4sRhL+x4564NI1hDGWuU7pWUBMEA
         e7MmpB4izAWVYAKAVeyHCSnoZml/sTGxoUkgosuwwVLmUKJeSYPPINP2UXQWgj9Gd8AA
         xyh7aYjJ393TxPnJpkNqG4OFWrPaDZoq+7R++m+ECTDQOYND3gyjWwBht31wpWt56AvB
         /zMw7oZSw4ftn/ESstPOxWr/S9jL2YF0nn6CU6DyWt5Yu5KcoOQcIJFzx9/yt4jLslul
         mgMIollgJ0BOKoCbXe5qOyrTE9y/wdugRcsLfaTq6xs0Tq8YSslppjhOMtHro0abAhjE
         ZRZA==
X-Gm-Message-State: AOJu0YylZurf1HGhN4zB4O3uBnqw07YZnWPTNw/Gm4KN0DTpZdSR1lMW
	xFMT91POT/aKZahDQV9Chn2ov1rAIEdCVL/KAkAMzQGOzfOvA2JIsWeGPw4rng5frwC+ZA5gkFI
	UdyLhUfNTFGCvZlxmd2SESydOPh0GsYPIxP/2BihBV89LLYjqDIROmLxrwTeQUv1zl3DRZ2Z+WS
	I21T/cFBCy7H89pgMIHNB4uQM5OohQ1BNymA==
X-Gm-Gg: ASbGncv6TYZDUnM6PVNqj2OsDZm8wdXdp48maOlB5WH5yNIoEeiYDTPQjp3cQt9Sazf
	rRF6E0atYI541Rbi9cuztapVMqt7/4X4mDmmDfhp0mneHIzXXa+CNPexmFDUryvvVY6FqPr1yWO
	jeZ4rjyZK7YHArFF+ZXGD3wZsw
X-Received: by 2002:a17:90b:4a87:b0:335:2d4:8b3d with SMTP id 98e67ed59e1d1-33b5138625emr9306778a91.31.1760015927526;
        Thu, 09 Oct 2025 06:18:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjvG41jRS7goGjs/joBqlFjpWYQ9/S8HoAie/v2uPtBZvZWDPTvfxFdq9Vco1MSLN9Z7u6TC9j0A5A/fdrGls=
X-Received: by 2002:a17:90b:4a87:b0:335:2d4:8b3d with SMTP id
 98e67ed59e1d1-33b5138625emr9306748a91.31.1760015927153; Thu, 09 Oct 2025
 06:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009123203.104314-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20251009123203.104314-2-stephen.smalley.work@gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 9 Oct 2025 15:18:36 +0200
X-Gm-Features: AS18NWAjy5yKhYfVll18_eXDxQzyt-URywtlcyHleVh0-Zay_CCZBVdz1mgZA4w
Message-ID: <CAFqZXNs8hfk2Vda1z2nVRqpKyrvkMUvn96K6z8UKT0i1KeYy-A@mail.gmail.com>
Subject: Re: [PATCH v5] selinux-testsuite: Add btrfs support for filesystem tests
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, 
	Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 2:33=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: Richard Haines <richard_c_haines@btinternet.com>
>
> This allows btrfs filesystems to be created to support the
> filesystem mount(2) type calls and the fs_filesystem fsmount(2)
> type calls.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  README.md                      | 3 +++
>  defconfig                      | 5 +++++
>  tests/Makefile                 | 2 +-
>  tests/filesystem/Filesystem.pm | 4 ++++
>  tests/filesystem/btrfs         | 1 +
>  tests/filesystem/test          | 6 ++++++
>  tests/fs_filesystem/btrfs      | 1 +
>  tests/fs_filesystem/test       | 6 ++++++
>  tmt/tests.fmf                  | 1 +
>  9 files changed, 28 insertions(+), 1 deletion(-)
>  create mode 120000 tests/filesystem/btrfs
>  create mode 120000 tests/fs_filesystem/btrfs

Thanks, applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/0de52fcdaa3eb958=
6ec4a0641513ce2cf343fadf

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

