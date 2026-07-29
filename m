Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9A547D479
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330641; cv=pass; b=BbwD6/qUFmu7qxZ9NW75A6+pj9yKPduveairWydfTsY6KhuLkEEiLePPFIu3ksDuKT+fWwbp3jcokfVPXHiUemzQGInB+EPzyh5SpxHlBtUuF8jZCYHYRQgOdA8oZ41l+38KeL+79Bj+079aoWyiWY7pqI8nWzKZqMo+B90+wZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330641; c=relaxed/simple;
	bh=vjUQmYjYexdgM1q32dVp908WB3gCsXLNVs8gfDVHuVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCxvu2dz3nl1owKFyaEn44UjtokcjOslYSMqd1YAy0BU9iacEjHVLkEbXZUaHUarMHNv4antOXrFHGOsVwyr0evPErO0/THtcef9c+sRAM95wikWCzWbCPoa6aw4elvdnIX5HjOvcFeafCNMaxdxzHxpwPZCVcOWieiWM3Bb1Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LLuZC7NB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZBOEJZp3; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLuZC7NB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBOEJZp3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785330638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EE5nm68q9tO5Im2oMBDZgB5dWwpzKT2mFr03qPfyDmQ=;
	b=LLuZC7NB+EEW3IfqVcjGUcq30p75NgTRBs4otE1DsRKgfZ5yrxT51Nm9L0T0z0rCGeDavW
	I/DZI8bdRuv1jTKyZ+I7BJY6lfypWU7dMLCPqwfWy/B/NOWKacahUoHcgpmrgoj9V9ikLJ
	oBTq8/Cyn1a0XOkymnoZ/dseWnEVL8U=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-mFbcIUX_MuqDk7oeGj2vAg-1; Wed, 29 Jul 2026 09:10:36 -0400
X-MC-Unique: mFbcIUX_MuqDk7oeGj2vAg-1
X-Mimecast-MFC-AGG-ID: mFbcIUX_MuqDk7oeGj2vAg_1785330636
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ccd1958e8fso14308065ad.2
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 06:10:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785330636; cv=none;
        d=google.com; s=arc-20260327;
        b=Uk7dUO3cuc97blEs8YrRXucpxhtxD37uVWJnkkpC2qSqSRabQFMX5im3/3gp05MYLG
         GkAG4ltMSAEI+q4WEXUkO63qKm+OKffCix99bT58ZPpAzGsr/Eh+oyG/3/adBHiR8lC4
         sgPnl3gxoDni2nVYdhEUVMKf1FA2RmH8o4cJN+/1Phmt9urrXWsuXzOdnrmQ7AwrPdgi
         8ULLQFVRwYe4LQ5NOrqy5QNoQ4NEiZP6E2htC1do6IRB5w/FtNUQ4+3ZpYJZwQpsBZte
         Nu3220cBVi9EvC2rLeAhVm2jPi82exCveJQfnu8lUTk3z3luFnN1qR0SP/+SvhpswNmb
         XS5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EE5nm68q9tO5Im2oMBDZgB5dWwpzKT2mFr03qPfyDmQ=;
        fh=2Azimml4eMo80YwbQBs0euYTLN6Y6vJrYmUa2nYLFIU=;
        b=lrUf38+4u7FJkz8v/zKCD4PhrFjo27qiqj/WCJk8ALlHFcqwRpUPnd6Xi9Z9lOHyVS
         NUh2Hwwz2JlLVKmZsWor9G/9T8LcY3P2fwPEU/e8Upv/du2i/CzbwYb7qPqErNoy3ofh
         AD3tWPWrzPtOIFYteaWSPVRI4iSBroz2CGSSSt4dBiOvxY95dBGeuqTT4ESpqSWwLfnt
         4mrA/tGlKfjX14/k9hOz0/eGY2xFyn2ZpMP3Ttlbe/zS9m0RhVRDSjrpjSDQ38jAnNj2
         jtgnpcmigJTHxn37dpkY6iH5QAOJoKSO69fTyRF2u9sDytyQn5uqHEWhEJD3sYDRo7gS
         UL2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785330636; x=1785935436; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EE5nm68q9tO5Im2oMBDZgB5dWwpzKT2mFr03qPfyDmQ=;
        b=ZBOEJZp3D+TZnOxyih+C9lhCXiBfjXZq3sF8AOC5mdEUSgsb0XVMQYM+xQyiO8QOlX
         7FSA9muoZSGVjvh6tXXedg4REbNJeeFFiIGSTPGc2QmaQcDLaRrvkz+fv9lkkTvgijnT
         it+gP+y9LtOJtXYuHi6N8jJ5kDWugShhSIhDAzyQ+ScPNs6N5Mv1sB6a861/GaAY6A3/
         E+lD+aAnx7BzZA5duauYKE9JdF9HeN/GtnhhTxtN/DuBs1G8T7Cc9RPNCS+xIWusERkj
         +Oe2fIQnifcgigNvPUrbZILQUB5gu4IeY1PBlfiIqnRy7078fTUAzFT/p0SSNG4ffmd7
         BAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785330636; x=1785935436;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EE5nm68q9tO5Im2oMBDZgB5dWwpzKT2mFr03qPfyDmQ=;
        b=d1KdRlxtYRtzxrV0VwbmW+hS5TF5Uzup5S0ZTRBJKzQLJEBr6myIHNld87u4cpv11z
         ECCLryENeNGwy0C0umGMf0Pm3NAEXxWUI8nw4vhjnDPsRv9wrGmuWlBWU81L6LaXs3Bo
         pSv4UwyVyc9Bc3kRvkoloxT975onX40Uyh6UWOvSvaZ16IRUTHn4HHs502hW6YAmfHCY
         7rySpffEJODDtJZdSdZ3sAfd8ST8wXXIPH5DhkEhwi0xj+58wIZPJR9w5PTWokseXLyN
         ibO98rDjzWBmmS1Tv5AU5eFDKObxFlTHCVsgPR95az+l3m+/gpXiMsGX1BHuOo2P+Ire
         rEXg==
X-Gm-Message-State: AOJu0YylCvhvhduu7CkAWI0TL6vFdVaGzx4Wxwp6gzWYB6/4ML+1y0zm
	sYYxRWvymTrQzdxvE0X8xOxozGoiX2OesFFgYuMMs5Ct5HggJhgxHOl1yK/9G0QebdLqi624nih
	S/leN0fnlgwWFpLIGIiBj5DciurzkyPCQVcPInx7Uhg9U7hybzZikAjASc7/QJnY5xeiOpLWDg9
	7/iUXpaG4oSmGqrjNnNDGq3RqKZVceQ5jVTQ==
X-Gm-Gg: AR+sD13Q+XK8oAn8Gkcs9VTZYtgrIrz8HbJm2CdbsPFtXS8vhZnCkWE5PqLIGr6IKms
	VWQzkAfuOCOaKV/pirvQ9GbxFk7DLFgas6D1Lr81tnCqlRgwoEpgc6BL06KVXIRHdk4705NDu2g
	oYx80Fef+7Nsfv7Ze1tbN/4k0DsRXhj+ay8BkKkeWQjkSyqoU8TviM1M7nU3x//YWwcnCz5ecRY
	YmoMpEOxH+Lftm9wA==
X-Received: by 2002:a17:902:d2cf:b0:2c9:97a7:f543 with SMTP id d9443c01a7336-2d015d258a7mr79130865ad.41.1785330635647;
        Wed, 29 Jul 2026 06:10:35 -0700 (PDT)
X-Received: by 2002:a17:902:d2cf:b0:2c9:97a7:f543 with SMTP id
 d9443c01a7336-2d015d258a7mr79130335ad.41.1785330635068; Wed, 29 Jul 2026
 06:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622135757.2172-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260622135757.2172-2-stephen.smalley.work@gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Wed, 29 Jul 2026 15:10:23 +0200
X-Gm-Features: AUfX_mxD0IOlSZy24qO7cLRCW7JogqfdF2_1szrRhDxHK-IP1K9JxcKHJsWNjBA
Message-ID: <CAFqZXNsfwSsk_t-=hSOOfBjqMWGEyDJVUAkb-qNz-v_zydNuKA@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket: add tests for TCP Fast Open
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, hexlabsecurity@proton.me, 
	matthieu@buffet.re, ivanov.mikhail1@huawei-partners.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 3:59=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Add tests for TCP Fast Open. These are expected to fail until
> the corresponding kernel patch is merged.
>
> Link: https://lore.kernel.org/selinux/20260618175513.112443-2-stephen.sma=
lley.work@gmail.com/T/#u
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  tests/inet_socket/connect.c | 55 ++++++++++++++++++++++++++++---------
>  tests/inet_socket/test      | 13 ++++++++-
>  2 files changed, 54 insertions(+), 14 deletions(-)

Thanks, this is now applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/433c597a6a9a711a=
eb8a21d13abe6a09a68707a8

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

