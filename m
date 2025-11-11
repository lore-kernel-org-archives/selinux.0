Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA1826E71E
	for <selinux@vger.kernel.org>; Tue, 11 Nov 2025 09:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852114; cv=none; b=EwsWib5XpheFs1y9GxloTD02yCGqeWf3K0KTaV4k/8tuWbStDsOnRno7tOo+0Vyal2LXGU1Y4kRciOxa0rC4LS1ccR/POpXqbwSTu9I3BewZClVwLV2VhxKFPmgW2GciIVd9Zrt9LBU/PjqjWidweY2o3H6Hr2dMCEVd62sndK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852114; c=relaxed/simple;
	bh=5WBsIs9xl/TdCHSUEiKBFkMW7x+q66XckzUvLU7VqqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6AjeXpo4sXsctI5ecC1TpFKrSRJ+0C+TWthPYSczVlY51Ac9UVUh1DVsgG+pOOwHRP4X5fSqQOg9DhtjviEfDNtHjD123KlxZ76927kCRfB/seNluY5NfVlNLtJZUx6j/ak3Q7i6CuXLUdBTCxzU4APMh8nqstpj+g/2HC1uT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HPyn0JOk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kfTw4eSF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPyn0JOk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kfTw4eSF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762852111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iaKuhl8Z4LoL9dSjExQBPbPSZFVTX9jAz1TQyy1laMY=;
	b=HPyn0JOkqo/lqZDjOFMjdXClZkahDT2F5d+1lN8K5AfeWNQbEsop0jggJiC0D06FsFd989
	Eh38JQjF5tEppCPf1VrC0fm9GqDRuCvvgv1FC8aFsxw6ebOJnedk3hHu30AkccjkyMmuEG
	9pQOpRMnbGLGHcMXUyEINWJQLwENWUM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-BXuGc92fPrG5N6miipDXRQ-1; Tue, 11 Nov 2025 04:08:30 -0500
X-MC-Unique: BXuGc92fPrG5N6miipDXRQ-1
X-Mimecast-MFC-AGG-ID: BXuGc92fPrG5N6miipDXRQ_1762852109
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3437863d0easo2649620a91.0
        for <selinux@vger.kernel.org>; Tue, 11 Nov 2025 01:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762852109; x=1763456909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaKuhl8Z4LoL9dSjExQBPbPSZFVTX9jAz1TQyy1laMY=;
        b=kfTw4eSF/KLlEVSmj996so3mp2SaufbKb569q3bsO7SkUM/8d30MkUGkSXi0aCyYWz
         Gah0ZRY1G+Th6bNBOIFtTDpPyf9LZzR9z3177/+PRhdeMDtX1uXJYL76Du5QQyCKGBRB
         mfgH0wUIYfyfKM+5nEW3EjfkRGHqdHubkg/rQDiLUF4E1nT1QeY0h9nhzH6n5uv6MAZ4
         eJfHIx8UD09m8u4zJlz8Jo5bW+OkM5sx2A04nKP/uL32696/o/NLMrdatgn/0XRXEu74
         KCkrfadNlv/68Cc505vBoHdrMQWff0KpM5D2kF4a+NJm5T7fYby/c5HLmd2b86mejMiH
         HPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762852109; x=1763456909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iaKuhl8Z4LoL9dSjExQBPbPSZFVTX9jAz1TQyy1laMY=;
        b=CXhaR36evuL6vPELXt9SVfW3ryOra6NvWVQhICJVFc89fyVCJ7wn5WHiEGaGkzMi5A
         eDU+b61tJPzWKOZ4Th5B9TbM8qjOSsn8ikDb8zPfaz6NswnUqfcArEWhz1mh87Fdj7/P
         1fGAukkj+aNsjw3V9LNl9qY8+/hMi0vtTcBWVSR5M3nAcxOei6lAoP+TfyzxX/qJ051K
         lxjgIGyomaVhxDXDod2/tfFQqqb6q0MDYy4lnCpwiBrsokm4JgrkjRX3kqevyFbR+yVN
         P0EPdh1wot/EITxaogavZDWcrQeFfl4Xw7nbxNsnrfnhXguocVeWoZIpkzKtj2Gtz5pk
         hoHg==
X-Gm-Message-State: AOJu0YwMyIpEEULOVCL3l0nr/NVY91csVQia38OE1oRBp1E0pFLt5Ug4
	1DIBusn8ae4zi2cHa2dDZcxsEo/6NxLkq5NuYu+GifsrRNKF1e2pzBl8GNmgsOeHU2o+rxtk16B
	NMvyFZDNOEMU0HvNyv961w+oyFfWTXp1ey0NgbpBT4uvHN5WuezP3a3V7vMDNa+pbROzX+RYPBq
	WMVKsTVCJ89f3aHpja0YOZ0e/9hyscEdovtw==
X-Gm-Gg: ASbGncubnoTT/JnXueLb/sMxsY2/Iu0AqPfgkRqEiaDs+wgFm2pbKKyR4AsHNxP1w2i
	IcpfTA55s0AAo9tIypj4Pf0pH8S9ksCEtz3dDBOKehUQx4khADbsuQ+bGdNEh8nnBBrJPAsTLFZ
	t6DfdY3r9tSymYngztMwVe+Ln9IOwAcbPrEWBnYDLUU/b1RaDup2kN7Gp/n5WLGkLfgZ60noGzB
	1q01sLtKNiiDOCH
X-Received: by 2002:a17:90b:1c01:b0:341:8ca8:ae64 with SMTP id 98e67ed59e1d1-3436cd0e60bmr15765062a91.35.1762852108978;
        Tue, 11 Nov 2025 01:08:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkaToHL5N7kY0Uh79nDnaQ6ijMgouSVcs0/nJl3Es/gwZRTjLzRerWKI8NTi7vbMkqY9iFwJXWqtfMgf40ifc=
X-Received: by 2002:a17:90b:1c01:b0:341:8ca8:ae64 with SMTP id
 98e67ed59e1d1-3436cd0e60bmr15765034a91.35.1762852108638; Tue, 11 Nov 2025
 01:08:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110170958.23627-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20251110170958.23627-2-stephen.smalley.work@gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 11 Nov 2025 10:08:17 +0100
X-Gm-Features: AWmQ_bmKDwUv3QqnSZ-Le32uWlE4Y4ZEiebAxAhTNWBmNWtVCaRXRZ9xUecPn6g
Message-ID: <CAFqZXNugEsk-4we8O2Qur3pviyzMoh6aQFmjD-XuuH+Cno1Hwg@mail.gmail.com>
Subject: Re: [PATCH testsuite v2] policy: do not modify the
 allow_domain_fd_use boolean
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 6:12=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Modifying the allow_domain_fd_use boolean value during testsuite
> execution is increasingly triggering breakage on Fedora since its
> policy defaults to 1/true, to the point that you can't ssh or even
> console login to a VM while the testsuite is running or even afterward
> if the testsuite encounters any failures. Instead of modifying this
> boolean, just update the relevant test domains to use the _minimal
> interface so they do not inherit this rule by default and add any
> required allowed rules to them.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 addresses a comment from Ondrej Mosnacek <omosnace@redhat.com>,
> rewriting the sigkill rule to use testsuite_caller_domain and moving it
> to a more appropriate location.
>
>  policy/Makefile          | 6 ------
>  policy/test_binder.te    | 3 ++-
>  policy/test_fdreceive.te | 4 +++-
>  policy/test_global.te    | 1 +
>  policy/test_inherit.te   | 3 ++-
>  5 files changed, 8 insertions(+), 9 deletions(-)

Thanks, applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/f40c76cec56778fd=
5651ad6de715d9941dbfd4b3

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

