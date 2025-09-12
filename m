Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EC3347DD
	for <selinux@vger.kernel.org>; Fri, 12 Sep 2025 01:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757641735; cv=none; b=mkWZaXg+0OJVbx/+66zd0Iz2zLz7UjG9AwHX7bq0R95I+398HvACKkcAp7KhpEis0FTo/eHJpaNCYqZvF7NXn8CNjHht0o2UjVkLvZC/Liuh8rpBsQi2k2C+hcUkq7qf6/w4pD0j64xTtD26KYpZnUFdf2vZgfkMGahwwgyVtOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757641735; c=relaxed/simple;
	bh=Zga3GNusDfSgVUj052y05xC1n7khhCDCOun+kMC4wAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCZERw/8vjahTPJLRl1udTQrUbfk9ElwQ58K+q7jUcd7Dkx6cB26kSmS2G2OXRaaoU7jjOxQHrnhl4ddMohqEbV2Xvto5GB2aajE+yoKPGFNzkh2FV8HhtkN2QSTcRg0csjNvi2JVuhn9F1BXw5csexs61gV/AIczSG9Jpkn2DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AQ5pdCaI; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AQ5pdCaI"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7741991159bso2085826b3a.0
        for <selinux@vger.kernel.org>; Thu, 11 Sep 2025 18:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757641733; x=1758246533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwZ+efw570OZx4YJ4/j4PWOdvYDNSjRQjeqYpWheFvI=;
        b=AQ5pdCaIeyVAXT5K0h0cZt+naDyhkgw0cp1RWM9QeJZyxqYyA+4mKWKbtnRllowQLi
         e623bHYj7BubYyltm3SuOfK4n3kwXALVopz9jzHGd7sSrsaKVQHkQ7AH1Q444I56oxZ8
         mvlUDjWL240u/2XEgY4mGFq2rVUqdEiw0/gTt+4+yLc/T/zF+pXjtaHnJWCGRg8mvUcf
         t6iS/Io4K2dxJ0gEbT3jcB7pADbKsCBchwbyWjZNGK8qDelC33kUYPY0JMo6eAGaTOaP
         UWus4dGfpMDrW4a/BAwEEp3XSG1aALeVrZEjKKCcLTBiyU+hkyWWdwsoR31frBSW50jf
         P1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757641733; x=1758246533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwZ+efw570OZx4YJ4/j4PWOdvYDNSjRQjeqYpWheFvI=;
        b=KnIj3EN774YWK6yn9qPMVeIkiAJW1TwutE55R2D83vnZan0oMkxGsW/0rZ6yLBEcki
         8eYsPBy2fkMDQXuuxIiv72b9HDsYhoIIfKcUtQEufZWzVIAri2y9tzex2mDpze25ZHb/
         faADRiuuVgQDCvkCelcRqhbWVbBnWUky3HumJAKkKlWTF0mk/wqmkcNLVERD2MqhWTxe
         eX6cF52FHYLXzYhQ5a0LoKkHtdaGW4REJ1vtaKjVo25zyT6KbptNyDLY7pcFo9N1yhaZ
         2CRzg6ZwUWWb0IdLQbqBB1ROYfpdZv65vYUC2EgCe36XUDSSK3WZjrB3RI2YlCud4rBR
         9N+A==
X-Forwarded-Encrypted: i=1; AJvYcCUdt485kKYELS7CFbKjOdyYEzicydkS4QqSjJKt1XHBvZYJ8bZoKwKuTcvkCOAgFYQm5xQdfJsp@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9NCEHZXelI5ihEYRtv95WJMNihKLuhptH8NXuuPJqcwSsIqId
	OJEfn/NQ/II+SVGkrg/KfGgKTrvQ6CPu/K+y8WN1C804Tw8oM+Qo8+mCHF4Dtn95lJAfAaGuXov
	bNhr2HVMw0M47AKdbCrDIp074s62V6rQd2SX5O+Yl
X-Gm-Gg: ASbGncuhIzaXACk6qXK6foobF+A0kLYLxr0tWAWi/EyE2uwRQVtwat4HlB5vi2ad3Fd
	/5VGCwpkgmlL8ZLHI8WGj+McxVUmrhNwGhiXMTLJ6B3LS10YbxaqxEem5f7QP5brv1X0Yq+I85p
	OG9cgAOdwG0sL/6cRusRcqLhqB70nRlBs1LAuhnlbgXSK1mDXnDr9ryYc2OIq+xDkKt+lfvLVV4
	mtl8Ms=
X-Google-Smtp-Source: AGHT+IFcmKzAXmvR3kg0PSIDLyLXxlf/usnpeiCPFujxVN4S0OObwqltQTuSb24BYjTIZ7ku3FiMsnAVEhIfTSZTKnU=
X-Received: by 2002:a05:6a20:158a:b0:245:fb85:ef69 with SMTP id
 adf61e73a8af0-2602c04eaf7mr1616418637.40.1757641733012; Thu, 11 Sep 2025
 18:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903192426.215857-2-stephen.smalley.work@gmail.com> <aMNVDOCjCBZZE8Kb@mail.hallyn.com>
In-Reply-To: <aMNVDOCjCBZZE8Kb@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 11 Sep 2025 21:48:41 -0400
X-Gm-Features: Ac12FXwv-pJpiAmW9-PshxFm06tfN1NilplttFrornlIK7ric0mSfbZU5-JB9Tg
Message-ID: <CAHC9VhQYr_3WzG__RYs_mPtMqFCQz4wbrUnyGZeyKjCuEO93_Q@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm,selinux: introduce LSM_ATTR_UNSHARE and wire it
 up for SELinux
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, omosnace@redhat.com, 
	john.johansen@canonical.com, casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 7:02=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> =
wrote:
> On Wed, Sep 03, 2025 at 03:24:26PM -0400, Stephen Smalley wrote:
> > In the hopes of nudging the conversation in [1] in a more focused
>
> Hi Stephen,
>
> what was [1] supposed to be here?  I can think of two possibilities,
> but I'm not seeing it inline...

I'm guessing Stephen was talking about the "LSM namespacing API" thread:

https://lore.kernel.org/linux-security-module/CAHC9VhRGMmhxbajwQNfGFy+ZFF1u=
N=3DUEBjqQZQ4UBy7yds3eVQ@mail.gmail.com/

--=20
paul-moore.com
