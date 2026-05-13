Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C00B298CA3
	for <selinux@vger.kernel.org>; Wed, 13 May 2026 07:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778657130; cv=pass; b=tu0MxlIv+c2ng6ONv2ZT1Ln68NvaLmjPp1REDDCFn9yhJg0j27y1Z8P8iWCv1cmS84IdN1+D0rOE8SKsbaYB7Je36uPq9hd0WOJ8vdhVicWPM3hD8uEV++h/lm3PK/70gTdQvr67U7MDQLeasC2iQ7dHtVg7hRYHkQe7nr7hBKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778657130; c=relaxed/simple;
	bh=7lb5tqUKBAs5D2g8GLxRqs83330odgFPwWLGvHuHBXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DI/FFe1BOlo/K3CJiuvaAvKJyejQ/fdz/1hp113nOfDPRvm5fNgEGT0jbjfIYQ1qw2YuLXHoZLS/luzQk2GzGUXys8ovt4ch0zp5ATXngcxcYko7eutisBvM/yF2SCHVy56jxMda+Ly+vgQDOw8oocSm1cIw0cI9erL/URShjzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AxUs7tLB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LNyO1AmH; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxUs7tLB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNyO1AmH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778657128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lb5tqUKBAs5D2g8GLxRqs83330odgFPwWLGvHuHBXs=;
	b=AxUs7tLBbXIFQcvbCNKpdJAn7+73l8Nerh6vcV1JaBklhpgHMZthGMx1g2Gbdzrpt5/zNi
	AEyq783PdawUnZWugNTVSaKZx4E7nRldXUgB5uswN8wdL6NqNr4CmijRprIC2m755zROkI
	w+qgtwMYj3wiJN6XkZHSZlopq2VWrE0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-bKkuarYKPH6vo7lLBhHx5A-1; Wed, 13 May 2026 03:25:26 -0400
X-MC-Unique: bKkuarYKPH6vo7lLBhHx5A-1
X-Mimecast-MFC-AGG-ID: bKkuarYKPH6vo7lLBhHx5A_1778657125
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ba6fe41283so75123245ad.1
        for <selinux@vger.kernel.org>; Wed, 13 May 2026 00:25:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778657125; cv=none;
        d=google.com; s=arc-20240605;
        b=PX8Il9JqGpJ1EI6I8Ul/qBq/7ZnLIoiFODBk5ybNR6DeATujO+f6rfI+DXFqlHLcty
         NqMhNe5V90psPuskRGMmFXejmj1ImeXNF5mLgpwWM/Qp9jOYyuD9JUx7rr2++4P9MBgB
         jxpSDVXKzdMB7w7U7KdHizHbQ96ofO+7MNV1PABEe2oYFBw5VVziv+tUN8lK3xGYQwND
         mGY9+dSwfU/QwgEHDGoN+qBSoaruHYDZyL78bAL5WB4oOKBgMIDHRsM5otbkJqlUk3D9
         VTUnLjBjmrSz6Mbnze76IINN5VK+6p3W1Ju7EB7h8gkFb1j4pFWhq/HEMHFY7gDdF0PI
         15LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7lb5tqUKBAs5D2g8GLxRqs83330odgFPwWLGvHuHBXs=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=T6CMiNcRMXYWHfrVwBK2zhBFHFdi7LGhSRvcPBEeIzHb3JqdBIVQg6k2bFrwbdHHzx
         0ma/DinoJdnbTFGxnKN33RhGIoFbe0GT2Uj8+MDdvK9OSstPhtf/yUsi5bjWzRMIAOeO
         DnoCKe7GA8ufowFuZitlOB1NtBqbb8wW/NG9HIfE6wZkUzSfop8tc56nYAI4YPDriP6p
         +IKr+aiC5pL6X6DnEfvDage7JXHc8sMkbefoxhBvtktbaVbbLGTcGAga1DGqS/ASaria
         OrcIzzhj6v7nGv4SUQup6NAF1IGt8bOOnqRVjZOoBzcIKlOI/1hBurxjAWMVZzycv/sJ
         Y1Wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778657125; x=1779261925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lb5tqUKBAs5D2g8GLxRqs83330odgFPwWLGvHuHBXs=;
        b=LNyO1AmHozeKl5Sb4u/ZYnWL0b2whx+fZz+aLg1R7WSL2KCgoSjm2R6+37qdQp0a6q
         Df2Ca5wphC9JrmMfym+4GDHrJ0NzVFfjdnHjAO/IqIobRUaRsrxiedlrjnVjDpjqQXg9
         ssAB4qYP93f0AFPvvRn/6UuRIHtts2VkeqQVWIoLje/hTQTwGdGV5eUfmNV+isSBA66P
         jJFdfgUZLE2Fzq5wX8HwFLXitA75mc+bSxCR7aC4fzbQBTQLTp85ib3hE41wJmwkXCEr
         gkP7YqW1CaPaGE/NzA5DYkWQBoj5wF6mSGJ+h0Xa7eJFXMzQq7J3+BPi77RyMb31xsQg
         aGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778657125; x=1779261925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7lb5tqUKBAs5D2g8GLxRqs83330odgFPwWLGvHuHBXs=;
        b=U/+5aRNmvF1p8IO7y+3Qd8ouN34GooG19E2R2r7Vci36LJyiWeWA++hnw5StxZQhTO
         aGcTpdOum0OCtx4HA6gvb23t6E3FCyULtjVvpFZPWWl9MLMP3EacMMP44/aUwrAzDjPX
         hiP8NSqSMd8gNVvaCfKnc1L6cf6Xk8nOy5VGyHPPyU48W8FTW+pVilnBFxCmrZ6X+Qae
         EIDDJP9x+zrA0/qIYBdVRlH4sANQbuK13RSF1FggEVA5R837agR1T3HT4DxNo4aQtNBu
         oH8RUZNDj6CzCtQzEUpHldyTd+kJrmC3g0JcoCVglxJ/JcaSxXMyIYd5i4Uv5jbhNWFF
         aSig==
X-Gm-Message-State: AOJu0Yxze5bccJ+QrZbza81oyYcAbL1CYRMg4L1XQvpr70HF4Vto8+je
	Vm6Ox4YkUd0n/MErj7Lm9JBulHC4uhgx7Xz21OXGJX172lNGxUcuPp+KZ5pYq5QLaU1AAVSEyHb
	UddZAwEZNF5dxdTr7V7Up6X6ult7vZw+j59WogGj5uREKnUyWa3mfwTUPEXsEKGx938Psja8prc
	v5OnunsErp1g9nYzSPUn/uhUEZB+u6YFyLgUyUzj00IYL+AzU=
X-Gm-Gg: Acq92OHFmLYe1NrxJFh9Ysc/65pQkHPbXI7zJplBElbqTREKvI57zTNd7c2MRv5aqq6
	jHjoRnrwMbLZ6D/VT+6PbOKfyE00aRdtYtCVY6qS4YUzmKFG01EsaYuR0LRxCFTy2f1ygEBSpu3
	2iZOxuX9DLouceeczALnTqQf8yXkrIxyfnfrHQ0cEtFdjMj0FHJYP9kJUyrXlJ7liqZMp1wZxg+
	dMxx3nmCoNotWYaUPlWiCF2GGh4DDcrKcOB5as=
X-Received: by 2002:a17:903:1b46:b0:2b4:59bf:5728 with SMTP id d9443c01a7336-2bd2fc21f66mr18277495ad.25.1778657125512;
        Wed, 13 May 2026 00:25:25 -0700 (PDT)
X-Received: by 2002:a17:903:1b46:b0:2b4:59bf:5728 with SMTP id
 d9443c01a7336-2bd2fc21f66mr18277285ad.25.1778657125004; Wed, 13 May 2026
 00:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409090503.2846202-1-omosnace@redhat.com> <CAEjxPJ7XGjWK6G6MkVj8WPG2bAM_JyZQCJwYFjFUQUkskgYWBw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7XGjWK6G6MkVj8WPG2bAM_JyZQCJwYFjFUQUkskgYWBw@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Wed, 13 May 2026 09:25:13 +0200
X-Gm-Features: AVHnY4J0VLzu0nssEbv-OxvYwoR4LteHK0GYgAm6m4jIzBO3xQgbDFDAIFqDxJA
Message-ID: <CAFqZXNuOPE=xeGeyW1nKENK+szHd2Aw1ruiq634-ZOUd45un1Q@mail.gmail.com>
Subject: Re: [PATCH testsuite] tmt: add setup for BPF token tests
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 4:59=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Apr 9, 2026 at 5:14=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
> >
> > Adjust the system policy such that the BPF token tests get exercised in
> > CI or when run via tmt manually.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/1aad4384207e9965=
89bf5367f737dd4f87624b59

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

