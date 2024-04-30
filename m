Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1566D171E67
	for <selinux@vger.kernel.org>; Tue, 30 Apr 2024 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486093; cv=none; b=sIqxHRf6lxmjA4bDA9nmWNfe3fZcddyvDQkrkhRty4t++N0qx2gqpSRywwiF87DsIDUl9NveJMvSycANnV3DPsJkrl8GxKjWhJfwqN2mZ/TrcKNL/T7z+Agoro9kT3VGGoMRYIi9XsMgmlBRzSiCmlG313MmnBzZNmfbUJZMRlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486093; c=relaxed/simple;
	bh=/VRg1hRVMINp2tdA2l/dbG5omT+kuHdEX4UsbBt4fNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TbBX6AoDIvhzOtVRBYNS2ZJCjLECDVH2C3qTJ9mC1TOFaqw4Lbf4ctfhCe0I34d6sRnnRY4tNhnf/Xs0g7iWf0wqCdrMN6GUzxnXrJpcGzsi6L+h7ZW7oKM/sMqkXDIlftwBNBGwuGA0C/7iFR/mirsa9ZLGXu+hGDJV1nrHP3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDAzWplq; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDAzWplq"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ee68823724so346073a34.1
        for <selinux@vger.kernel.org>; Tue, 30 Apr 2024 07:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714486091; x=1715090891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6g9prkGRpR0Yp7gpUUXr/nawffniG+2oBJrxdAWCys=;
        b=bDAzWplqQ22HX80Q/yFCyMSCOsV3Je1IM+7CCyFziWfnNAAvHGwX5CBpLE89cDCqTh
         Rjbuabk7RekR3NcMpLyJFFMWA/oSecTRA8Uj8ib6w9chCFe44D/7117ACzXFYUgmantG
         0uLDhNy4CMIjtRuNrfnkNNzyEBXarhpqKofBKEudzSVzdo4wWEOyJzmvFJgp5qu7dspy
         5LA2+wMnxE75P5Gr+F0sKrTXl9dtgUGBy9OBOA1c7Tsq+nrrImGtCu8YE267gkKI0gl/
         I891lZSMQE9pIfsjdYEMuBOeVcbLb5bTTwvv8bQEOShlli/OW2mqzZ3HHP9TDVANEgC4
         YRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714486091; x=1715090891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k6g9prkGRpR0Yp7gpUUXr/nawffniG+2oBJrxdAWCys=;
        b=JlhfVr939CCAgipYAqc1cWgwsNdxrpIitPvZYsWpPTu0NZAMm9WLnBX46clDKimM7e
         yetvmehvmLBvGprINTyUCnSDziCXO07pZHEpnj3o4v7QVy6JWvBpNI1FNz8HYhETx16s
         xskp3KP6aZo+ijrFwmEobx8Ro/fkYFEL1ilIJu7vsgCmGVpxXBXBSL3pEVU1+HDfTpFA
         HvHHAM2W+uyyC3DKkB9DXZw/4WJcOw8G3vVM2BjJr7c49ABeJWqr3F3Fgazpjhas/Xww
         46EfdGLCqsAf3q3f5QweWhG31ocQ1JjxsFjCZaNoiHhwl0yuoY7VD/rRK1G0Z6fPrGFG
         P6tQ==
X-Gm-Message-State: AOJu0Yzrh568HvaK9Q+AVQHhZx3bKyLoB3zYkIYigntNm7YL9l/4TBDb
	OrIygr6ab/KegXLdDktM9wCot2MqOEYqsmobVLDvrBDHYAW0NIEKAilnA96qhsFYSxLMY4zOZ3s
	fLkl/baCqzz1XDlw5SwibG5qqw18=
X-Google-Smtp-Source: AGHT+IFtsT5xwNWh5iaNNquljo+/sAUR+UvPRLkuQeW/on8djGfA0dXaVnboi5qXgRoQZ1p9sS+9NXDBJRNlKDQ6jOQ=
X-Received: by 2002:a05:6358:949f:b0:18f:7dd3:d64f with SMTP id
 i31-20020a056358949f00b0018f7dd3d64fmr1085730rwb.11.1714486089231; Tue, 30
 Apr 2024 07:08:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429163122.63181-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240429163122.63181-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 30 Apr 2024 10:07:58 -0400
Message-ID: <CAP+JOzSc7kZP3BxaZAgR5uML1xWJzwrEptKVopsoOV_PbeA4Yw@mail.gmail.com>
Subject: Re: [PATCH 1/5] libselinux/man: correct file extension of man pages
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 12:31=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Set the correct file extension .3 (instead of .c) for the
> security_validatetrans(3) and security_validatetrans_raw(3) man pages.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these five patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  .../man3/{security_validatetrans.c =3D> security_validatetrans.3}   | 0
>  ...{security_validatetrans_raw.c =3D> security_validatetrans_raw.3} | 0
>  2 files changed, 0 insertions(+), 0 deletions(-)
>  rename libselinux/man/man3/{security_validatetrans.c =3D> security_valid=
atetrans.3} (100%)
>  rename libselinux/man/man3/{security_validatetrans_raw.c =3D> security_v=
alidatetrans_raw.3} (100%)
>
> diff --git a/libselinux/man/man3/security_validatetrans.c b/libselinux/ma=
n/man3/security_validatetrans.3
> similarity index 100%
> rename from libselinux/man/man3/security_validatetrans.c
> rename to libselinux/man/man3/security_validatetrans.3
> diff --git a/libselinux/man/man3/security_validatetrans_raw.c b/libselinu=
x/man/man3/security_validatetrans_raw.3
> similarity index 100%
> rename from libselinux/man/man3/security_validatetrans_raw.c
> rename to libselinux/man/man3/security_validatetrans_raw.3
> --
> 2.43.0
>
>
