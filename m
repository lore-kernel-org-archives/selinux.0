Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99682F49F6
	for <selinux@vger.kernel.org>; Mon,  3 Aug 2026 06:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785738471; cv=pass; b=aIDlwE/FQDX3FQpHkMZ+rjgbSBiwv6Ork4pIemO4o4G0yMkizSEeWQkz+S6tmDYXC4KlVphbgrOqXtRzULSSd+LSOheaZeI+QS2gtR41UF86v/F17QTx46aPha9g3jkec7UvP0agen2BBHKO5zhk2SStjDG9UIw/8dqcBS/nlhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785738471; c=relaxed/simple;
	bh=vUa/Nosf/UG/W3XH/uqPw9LE4paB7T2IaYFqhq2PqKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IF7lO6jyNYUC3WMyQrEuocVhCb4yC2Z93qVfiR9w0lNX/GZKrZdlzvluOGlf04gLdci3JmG0GGYOs/lfSLaoZmxdyYGAIyyaf7wpS9yDgYHHisndr6hUrgNHjymQSPTFQ8GAszSwlyQkoNNkTwKH9YCv2inYsR5SFdgRZfsVmAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WUVv7BCe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SSFAqrja; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUVv7BCe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SSFAqrja"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785738468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Sjd0ZtKnFH3quOwnAN9rdzVg0iKOEW1uLJyoe17l98=;
	b=WUVv7BCeFzEB3YBk5mhsX+N7u5MWtf+Xf+F0vKiidZmkl0FwD7Cfx9fcLQG8vr9zLHEOCK
	Xd5BtvgludS38M+LW71dJccGRqOSVvD+eb12Rv7q2vDeYirqCZnQY8UmlimL1PGFOuGkYr
	3MGGzxKzkVcUixac74Se0r9SRMFvtuM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-JCLPzNBBPliAHDYXXbVqCw-1; Mon, 03 Aug 2026 02:27:47 -0400
X-MC-Unique: JCLPzNBBPliAHDYXXbVqCw-1
X-Mimecast-MFC-AGG-ID: JCLPzNBBPliAHDYXXbVqCw_1785738466
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ca6bd8a190cso3826208a12.0
        for <selinux@vger.kernel.org>; Sun, 02 Aug 2026 23:27:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785738466; cv=none;
        d=google.com; s=arc-20260327;
        b=C747n0BCicWaF7pG+l1W+XIb42oDeZ5W1+zblOt6/hI0Hd3lMG2xaAeJGUG14musIS
         k2jfE3SKu8muguCEXRNjy2jWmwoUcPJK40CcvFcc/pw6w/1wFlpoKIIg+FngCHGKWl8C
         nVIj2F3FEK/YMciFBhVfyzYDffGU4bOjUY6kgncUvIL/UouTUfKfPCdGoCoiR+IkiaHN
         KeFjGQpfxjrxhYjxhSC4NcJDv6lXbuw3RI5ApSTQBrcusvyFtx2/76Q8qb+BxD1eE6yL
         KixYj9Vw0I6fGjthZahPH+c6keyaLDjDv1Ico/yybmv8/jx0HaHfaO1wPSoPPqNrmo06
         nkPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0Sjd0ZtKnFH3quOwnAN9rdzVg0iKOEW1uLJyoe17l98=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=V1g/6A0Zh7wskpptr481oPpdnV9Ux81GQiWS2JqjfjU4fDm+eJWJYGcIerOPl/aDd+
         RQ5vrvoGvuy2Z0cTp5XA+7wNRi5htYXGGo/jt08sWXXcJgj14/TUVEq7BZSIaAYmL18i
         yjkIccB8BT6iGXvQ3DcLuqQvRAGT2SlluJYrsGBC7hZRqRNhXeCd3MNsMxBLhBjGerbg
         4jMto9rRJJJnleKANNlnEEmRy/KiNkSRahQswBFtAR509z+1/zQ+o/HgvgRUN1O2zhTQ
         TccEr36/cOwt4jQ3nivEXWa7imuFSHTN03fE7dAeGvEoUG3X4Dzq/E2lC/8+Y9EMHEIQ
         TGUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785738466; x=1786343266; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0Sjd0ZtKnFH3quOwnAN9rdzVg0iKOEW1uLJyoe17l98=;
        b=SSFAqrjagO/W1jiDjrrkr+0zI4qJHHFLCK4qjwMO9PsA3Ys6kDX2y5+6K31K2k3pb3
         hEhb4lsHtLvb6+PCzAtNrjcrb+hx8gEr86j8+7ZuNJXHX1yyAtckXoKtzVDongB1OQrr
         ZnwPBjbaHOuU+Nf8Ew3MAvoB6nnB31dmlKaAyV94yGXyzcWBayhPpAGAPrW8XRsmkVoJ
         lm+LCqVBVPARrIMomMalsp9Uziomeo6gwJj+KqcWNybCPoc1JhvjpwFIfHq3D1HWpl4c
         dVG4VbUzlvEQVL+AlPsaUEhFNambB/OnU/8+rytF6ogtbbvKBkpNpu7/ZxyPUv7eTvpj
         q70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785738466; x=1786343266;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Sjd0ZtKnFH3quOwnAN9rdzVg0iKOEW1uLJyoe17l98=;
        b=lPj6NJCkm75Cf2Pcf8oaHhA6pFESobYKWzVWJx5WvZUMSUaIRde/iD4xtcfF2vVm7S
         EeW3XN18/I1GwC5Sdlj82tXKgIDakCoLCuC4PY8K7w/3chDsEznR4y19CL1526LwtROH
         l6EuMdRRRGkKv83PoIKPnCekTcKYKdJzI8RilvBIwg6R+s/F4XLBxftVMqNr3VrQy6AP
         9MX4/eMyp9wGGPgnRxslG81e9hxDv9l8psYMxhFG80CiHhSAbbKJxyw6hUuTJsXqlQuk
         Hq8k4jofU6DoTpaJUmpfSaeWxAdlOZ4y8i8nkJPf+YjjVy7DjBI4d/GoZNttb0wPG4rE
         lt4Q==
X-Gm-Message-State: AOJu0Yw+Xzdz00o2HctFhMFJNVBX6oJssMIokkxI7+Ws3Fp2txkhjzXy
	4L2Yjv+c2wzZHtRYaMEGM6h+z/UOs3Ei2mosSMyF6Icl/LptC+2bYpHqklVFElXi4sHrVgfkiaB
	1KjrjIaQqS3051c5O/0UzMQD48StqjaQeBsFnxLEURdP4t+jY8effYG9BP+NmJ1AK+ZIGKcYoiD
	t50zDWwCox/eCKUbgRft030at+falK8LmfURH9T/CW67bG
X-Gm-Gg: AR+sD12z9Sefg4AST7yMNzfGlPAev9J4AAwVRfm8NXuJMLNTErQITzCOGc37f2/bTPU
	2pTedW9vP/iGDc5vOuPNFDo5bUL+YuE06U/Ink8+Jtvosn7HavNKkDdPUG2nwwVjZBrGHhhl2WK
	w8ttngykAfpK8sUX+WsxavSRXC409aLPlXLuGCCDlnauAbZo263WVkTn4=
X-Received: by 2002:a05:6a00:2d8f:b0:848:76af:db37 with SMTP id d2e1a72fcca58-84ee482ad48mr8672247b3a.7.1785738466458;
        Sun, 02 Aug 2026 23:27:46 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d8f:b0:848:76af:db37 with SMTP id
 d2e1a72fcca58-84ee482ad48mr8672231b3a.7.1785738465998; Sun, 02 Aug 2026
 23:27:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731084009.1285103-1-omosnace@redhat.com> <CAEjxPJ7eetwgk1UGjASvesqK5NCUWEnm=vHWLKhymx0sy+1FQw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7eetwgk1UGjASvesqK5NCUWEnm=vHWLKhymx0sy+1FQw@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 3 Aug 2026 08:27:34 +0200
X-Gm-Features: AUfX_mwlemq3yl7nO1MG3Wl9NM71wM88-UKSJhl2JRgsbZ_BAFM3ViYDw67X61k
Message-ID: <CAFqZXNsz3MAAxghUcHJc33S06_h_a8kCKue3fGD9c493MCNnUQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests: disable testing of f2fs when PAGE_SIZE
 != 4096
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 2:14=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jul 31, 2026 at 4:45=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> >
> > Current latest f2fs-tools release (1.16.0) doesn't work with it, so jus=
t
> > disable the test in such case. See the added comment for more details.
> >
> > The issue can be reproduced for example:
> > * on a ppc64le machine with Fedora
> > * on an aarch64 machine with Fedora ELN or CentOS Stream 10 after
> >   running `dnf install -y kernel-64k kernel-64k-devel
> >   kernel-64k-modules-extra` and rebooting
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/0e15952d664f86f1=
936cc2a4c11ce1f1729fd22d

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

