Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2884F13BC0C
	for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753364460; cv=none; b=keM4m5lTqNKIEKgC87X9/08oGBpkY4rLW0CNw4iwmCoH47/AA/EhTBmQNODqddxd9CstIk6oskC/ySvosq8zLcNMnqaBBibnNIwUXbfLkBg6eNnFGNKlkzhudpjRl7I/8Tz06+810MC9wRDx+6I8eQqfIYB4KmbwWI8+Vc23xgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753364460; c=relaxed/simple;
	bh=uNNji6sWdcor346Yc9nrzS6Spsb1lx92VbBloaioCW4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 In-Reply-To; b=gfCX5hlGi1bxHmWdYGokJDQjeLVgLVHM5nRzgyLaOvdEHV/DQ/UaHmJftsukeYe3Bhdk82sSPJNhVMpG1YUqnuMC8LO9mkajxExa0aJYZC/8rSIpb/yvECITCqtV8XAVN1RpF2PbS0xTcWBmD6qccS3FhY8WWaNVKVdjIvDe17k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnB5rB8f; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnB5rB8f"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso10756565e9.3
        for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 06:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753364457; x=1753969257; darn=vger.kernel.org;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/ownqtwyZU790rNj2X2mB6XgqIqTyMF8fYVbdzD8YQ=;
        b=hnB5rB8fS0vA447chClCOYUjnvkXJUlBX2AEJE59b/LJsD+bCrdqEK1NDakdL0AlnZ
         TT/XA/BS5RrUozMgFT++Ep3OFYhMvuVgbKv+c2RfBl+PGVxa+4rpqPtSvEDkmsTwK81L
         OtLo8Vf4GkiA9+2nNxUZlqttCEgBED6pY7g2BpY5gF2r6aPTziEz8KiAydiEPxSI1lAf
         tp/eNnhVFzF4K499vzqSraC6ft4u3RMxhqDKxZYrHHVNfsry0y3FCCfO9lhTbuf4pFXz
         Rl2tNrTVa7ibbUSkSWAlrwlL8uW9WW964ZtafyVpmKGY5rXxJQuPoRLhg0XOL8de8lvP
         1Mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753364457; x=1753969257;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s/ownqtwyZU790rNj2X2mB6XgqIqTyMF8fYVbdzD8YQ=;
        b=puwWMNuuaN1jS/DG2AVA+cP1paq42ilsBD2xup27PyDwcTErUXdBnD68V5Pw0mKsY8
         jahcNTcSpEk1vmN4Xr43LIoh9F2wB9CKSEhu1Og9WF1Zrdn2YS2/qiqT8LUVwP0yav0f
         FMwv/6DDXfv3W2XA5H8fYuu503T9pMCGyFr+9zH6z62h+SLsUd5bmxKw834MNXSjzVXG
         5xeLO21M03AyjFXv178oPyGnN30vWdOBAPQuiPhZKWZwsYAqHVhOQT1OOyNZi7fWPBhW
         zyAvPkHrJJWkBxsFajO+7ahm9ZhE3SWJbrvpei4uOVo3g8j9EWBOChb7fKQIuhQiJSY3
         YzoA==
X-Forwarded-Encrypted: i=1; AJvYcCV10u8/4f5kaUq3eeR7/7oNzxwDhTxHDeqMh3ECOrN+bRer2451B/6IfYU/3AJddf4ECjNlJwdM@vger.kernel.org
X-Gm-Message-State: AOJu0Ywynow/cNt+Z3YyaDaZsoXEavybuZLODQD7B+nI/aIy3KjJY3Xu
	uphAQvF8LOSx9wW+gQp2czLwZWajC8nQe4IO+vJMx04HdNb3XR+bzZ9+
X-Gm-Gg: ASbGncu9vHB3rrKvd3bRnQyVFKxIrN41COt2Cxm/7QPHNhfCoSB2GRiH4Eh5RAY7Nl9
	8BEKe7veAFrUg2lDsdoatq4MK3uhBec2GGsfYXTAEbuDYVb6MPGFfCaIDjX+J8bGEeKX1P7+DT/
	m+ctKmP0I1pe3yXeE3A2Jun/FQQ/k4mUIj8DyFf7qyBjRhQ+yhidlY7fDW6eKYmecLDrqA/57Lg
	dkbmQZeWs6za0VHiKSNMKFHow2o8yKL5ymiOcodFjibB3A+5Ief5iMVwbN5+WhG8KlYtHNBLAvw
	i6XQDIypRBek0wBxDu9mCQLP58J5LY9ZDj5lamvmfOpwqrSe1+RzJxkWqle27BwF1jGPj6s9CWz
	xui9JzDntme5QzS1C
X-Google-Smtp-Source: AGHT+IGyQok4xeTrQu7Neqa/S9QnYTwDJvk6WbDa7XjmarO9XKGBr2/OwbE0e3BNPrOwYoNXbLW8XA==
X-Received: by 2002:a5d:64c2:0:b0:3b3:9c56:49bf with SMTP id ffacd0b85a97d-3b768f15f07mr6302944f8f.56.1753364457245;
        Thu, 24 Jul 2025 06:40:57 -0700 (PDT)
Received: from localhost ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fc6d2c1sm2223554f8f.23.2025.07.24.06.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 06:40:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Jul 2025 14:40:53 +0100
Message-Id: <DBKBTPW45V4F.19G9M5KWLWWRH@gmail.com>
Cc: <jwcart2@gmail.com>, <nvraxn@gmail.com>, <omosnace@redhat.com>,
 <paul@paul-moore.com>, <plautrba@redhat.com>, <selinux@vger.kernel.org>
Subject: Re: [PATCH v3] libselinux: fix parsing of the enforcing kernel
 cmdline parameter
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: <stephen.smalley.work@gmail.com>
X-Mailer: aerc 0.20.1
In-Reply-To: <CAEjxPJ6-ZbOKxtpbpD4NixZeQy
 gU6Z3T8C8jLRvCPDHC-mL3w@mail.gmail.com>

> Also, not sure if this matters but b4 warns about the following:
>=20
> Checking attestation on all messages, may take a moment...
> ---
>   =E2=9C=93 [PATCH v3] libselinux: fix parsing of the enforcing kernel cm=
dline parameter
>     + Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com> (=E2=9C=
=93
> DKIM/gmail.com)
>   ---
>   =E2=9C=93 Signed: DKIM/gmail.com
> ---
> Total patches: 1
> ---
> NOTE: some trailers ignored due to from/email mismatches:
>     ! Trailer: Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
>      Msg From: robinshao007@163.com <robinshao007@163.com>
> NOTE: Rerun with -S to apply them anyway

Huh, not sure what's up with that, they did reply to the thread earlier
and it did mangle some of the spacing, might be that? Regardless, I'll
update the commit message too, forgot about the earlier paragraph...
