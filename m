Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8430338F94C
	for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 20:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777494902; cv=pass; b=l8w9niyyrHZCwMI3X6RkqOkybBEHAHFT3mcipMMKGwoACTrB/nHTRVBlLU1AqdTQLWzUykZx0fJ4nVkxvWFENtEasW4p96Bo7cWm0f4BzDuI00EZa3heIRZDozSg4yR9fyl5v9g7t8NDv69+lpk+/TxsKG3LIa5x6HQh223GGfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777494902; c=relaxed/simple;
	bh=6wpGa1fsx9NLzyOlfHBmVnU0r1qh5pcOBUa2bmgndTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ncka3PpBt/TyVeSgDANKVqChX2cCnq5hoX9H6+ZcZDrQMdRyMIGiDJjPpoSi6LQnLTonhRrXyUCWuBN6NhNfo2d7fIYEIp1z0hzw1eRswYFOJnYoXFep9ZNh6/hxEUOY9KmX27ca2TcD3JB3hZ8oYHgb+bBs8dew69q7DHi8BgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Q6olaRKi; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q6olaRKi"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-364ad762ef8so82156a91.1
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 13:35:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777494900; cv=none;
        d=google.com; s=arc-20240605;
        b=ZtVYft6T+ufZgUN/CswBR16Jq9YIV0jSm0q7Bqp+OhBMJiZWuAEx8aKRB6HYGAOOCA
         KW1ld53h/S/2vQz/g/v/yupN4c+/JpbfLtiQK7UHQByJ5+4oWep5EFDxPSJxI/fIh2eB
         AvllkC7yTjQRWv5VNlWGGdq+0+HWqy+xLFI2dhncaCorwmbuxAiulpTxlHKEjELI3fI9
         Fs+sK/Rhaq32y3m/cDtlz+MYPf5hcCMrdHX1zUdrRJC9O6RTLiHDU9DGXT9JAijN2HK5
         QEwJLdSUpJ5Q71V5oleSvGRcNdaNmNJxJGrxH1BnPv3IrIOivZkUpxZ2UEQKmJRSi+oX
         Ay6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H6jxswxEYCw3i52crz1IUC4JJi7bSs1bGookV/umaGo=;
        fh=lOev/QwE9DXSi83P/KluQ9UjJBSvfLYOVkCl5H1rM0Y=;
        b=LUbvxZJgolqp2IaWRvUiAgHF9Lifi4p7hjBpPctvKNEC5nUZGI5yTrJNnZn4/JDUyr
         f5/Ey/LEoeS4oR9op1oaMUAHdQy/Isy6rWIpuHAhzSSmNBe5PUICiANYBI0uZfSyNR5J
         t5v7/Lud1SFoDmaBNVvCqnsfAIIB49FVTUVFm+Oyx9QsQfgyYueuvXixrTsjiCP45q8j
         7LCFQPDFytDGbyte5u0cUfINJ6C8LTo9saw2MCakN07oS+Nbq7zH2MiaZ2sjosEDP4aH
         suHsOVuNSm+KsDWfL3rUY1AnxE7Z0AuGL0jIneD08dIc/l5k/R/rMW9ehebmtSFYiJLE
         qUOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777494900; x=1778099700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6jxswxEYCw3i52crz1IUC4JJi7bSs1bGookV/umaGo=;
        b=Q6olaRKiiIH77gpYJ4Kfk0TJCs2lfh39ejN2So4ZI+rWWYPFCkPbDE/jMigb56AyqJ
         +lj0VMhMwKUCw5u/p0x3XKkPKLMqGmFScbCYGBR5UuEuKFlU8wFBkI540OEQwK9and/n
         Haqoo4IGqsshsjlmk7eI+QyIjvadl8xCml5UV4FttMQUQIZgndIjY/SzomMc22AMPbMu
         3lGYef68+ZfNJO4Qh9B9SiDu37FzZjkf0aqfX21Kq4s3YLq6yO/g32WQaCnkLOPkTuQd
         yBMb0yzPM7/l+1EPa9T8ue9K8t07l06Lr991lVKhQBw2fo+MC4KXSZtYZflF+TPLbYZ3
         DsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777494900; x=1778099700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H6jxswxEYCw3i52crz1IUC4JJi7bSs1bGookV/umaGo=;
        b=oXi1tfFVlWX0w/N3kZCG0J9T20PSzSj2XhJISH+W29aH6EUU/vvOhV+DHUitpIekt8
         6yWyC1T/6djCG1tR2EDX03eA/qFYo8rc97I2OzfERYgCScQAolwIh/nyp43lXQ0hmsJZ
         k4rXFzfTTcJwOiXVtRHo0tv7/1BPVGTiIyqt0k2hH63/Uh5BC2JWFw8jce74nmnAg0AD
         IWbQ7dHUeSjn7Bc8CWP2DlskFj5dYyotazqf/hUkMCeNwgbNS9tGo6u0ZawzYTMh2D33
         KHH34eA9sw7LW4KOEOaAXk3vJ1AuzMz6ihUfED37JjuvYmBSUo/eLnynPeVbWeUqslxR
         rQAQ==
X-Gm-Message-State: AOJu0YwSIobgG30uMkqIOYrOXcHIpeP6p1lqESOGMnAVehzQsNXstOxV
	DFJkE1dT411mQoLJLocQ4jn0m0oYHWr5kuxWGQuW09O/kv4rddALr0ofRiFhhxCL4MEtuSB0kMd
	8b1Fcgw/aGRXb326UdPbcl2L4mOd8EyhMGoP39dVw
X-Gm-Gg: AeBDietgmmNeKoec+hMlzmucGLCQOlRZwTuZnNqG8Rzb3hk+dcU0scWoqOeshRUeOF8
	3nhwA+0ntS9pogx+yMelwTLo37X6h1ihu/gsaUtVyoxvLAP59+BPvhoUx3180AHtiFcZmolbwvn
	CiOwzuI1QgZAXzzAVg8YnqSnnFOG5aGa+PkGxITSjx4t/BIGGx/7qSNoYEB20esvySmCQ8GqBIf
	RJj/6GY7yUpLDBsSWYOJMfUEVfgTiqzgmLazlJQcCCI1M4wZbTf8CYfmd1D3hMmyqXC6UBrq+Ij
	ZD9UsaXdRcdjVGps8A==
X-Received: by 2002:a17:90b:57cb:b0:35a:cf:64a6 with SMTP id
 98e67ed59e1d1-36492084423mr9778399a91.23.1777494899682; Wed, 29 Apr 2026
 13:34:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429170833.2581-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260429170833.2581-1-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Apr 2026 16:34:47 -0400
X-Gm-Features: AVHnY4LffzrFhRaAzlMn9ywHelpMe4AWSPwe8d-boGG-rCIo3_1kCo3xzgsJWhQ
Message-ID: <CAHC9VhToLesLLRpjtiiUTO9BvhzzxYBb9T2nZdu_DbzCeO_6yg@mail.gmail.com>
Subject: Re: [PATCH 0/3] selinux: remove deprecated interfaces
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 1:08=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Several selinuxfs interfaces have been deprecated for some time.
> Let's finish removing them entirely.
>
> Stephen Smalley (3):
>   selinux: remove /sys/fs/selinux/user
>   selinux: remove /sys/fs/selinux/disable
>   selinux: remove /sys/fs/selinux/checkreqprot
>
>  .../{obsolete =3D> removed}/sysfs-selinux-user  |   0
>  security/selinux/selinuxfs.c                  | 176 ------------------
>  2 files changed, 176 deletions(-)
>  rename Documentation/ABI/{obsolete =3D> removed}/sysfs-selinux-user (100=
%)

I'd be much happier if we continued to expose the selinuxfs files to
limit the impact to old userspace, but if you wanted to hollow out the
handlers I would be okay with that.

--=20
paul-moore.com
