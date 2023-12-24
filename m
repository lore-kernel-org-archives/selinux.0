Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA207DDDD
	for <selinux@vger.kernel.org>; Sun, 24 Dec 2023 20:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WBiU3PqA"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4b715fb3876so505866e0c.0
        for <selinux@vger.kernel.org>; Sun, 24 Dec 2023 12:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703448597; x=1704053397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wwa4i2sQcNHaHPebPXB7JmpfvXbtVVdhZXHxe6sJ2Hg=;
        b=WBiU3PqA4kSgs4Jgu7ud73YLfg6JpcE+TjZWk1JLra7NEKy8Sh634DouirgB7vioPf
         UOGFWhg1/9VaRBDZ7GjKvdmWdiFSZKwiCZnPa/jsfNP/ZoLdqGtHTNbA9I6dVsM6AclD
         8Lx7zOcDFcu9S5KqtF9Zj8Y8SLaE2pe7VWS2+53NQJhlpkYd/25UBUf2DHfevt/raA+Y
         wJYI5bIbhulQjPGWohGZNHxamODmiyPb1y5Kd3Ynja7gYbm3/qJDlCl3VqEfoswRK69O
         TwvdV3avFG9JqIkV6i3NxLmyrg6LcAN5ImBttqf/MC/ESxkOV2JpiNo6+5mPl4xbrYdE
         NsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703448597; x=1704053397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wwa4i2sQcNHaHPebPXB7JmpfvXbtVVdhZXHxe6sJ2Hg=;
        b=bJIrxHsCW8mACOmqhrfqUGYo9h15VoJnSCSipAYZvanwcqoQPQgAS3cxEx5G84ZsHz
         LX0uKuvLFzytrgBalYfe6xfomZHodbNeJTQI+zG+ban2Uju2d1OarLqoAOOFVrhNsJIG
         Eqx7s3gpbRSHucZwxQm/UGLDUvWE7ihm8CRRhZZI9f+AlPmm0y3IDIN5FDtyKFxo2yJy
         ptnSiCh0rksoaN5czAs38r+w436Rd4efx0UancZ5LvuEJgpa1j/CrHB2OnTu+kIWQezh
         XbyXr0lb9ofeAEN89QbpwU/k1UAPe590vUw5UYb1cqdNc9g9Df9mSaVneDZftNDtLHuQ
         fXBQ==
X-Gm-Message-State: AOJu0YxBLYn7FOFdshJW3NOLrOTqAHXf2bOmxNZ2i5n6D9XGmqapMnaD
	al14oa/cuSGYELYl5sik51fpqDkTT11TrpXSAG7mT5P1ISXC
X-Google-Smtp-Source: AGHT+IGauJFx9VUqFigiARR83mRm8QOMsq0OQC9u9Mv8DCQsBXCXvbj6mjeB+wom/UI6tOGYn6anKpU3EOHGDTbp31M=
X-Received: by 2002:a05:6102:1501:b0:467:432:4ec0 with SMTP id
 f1-20020a056102150100b0046704324ec0mr28150vsv.54.1703448596766; Sun, 24 Dec
 2023 12:09:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906102557.3432236-1-alpic@google.com> <20231219090909.2827497-1-alpic@google.com>
 <CAHC9VhTpc7SD0t-5AJ49+b-FMTx1svDBQcR7j6c1rmREUNW7gg@mail.gmail.com>
 <20231223153411.GB901@quark.localdomain> <CAHC9VhRV9WN_pQgQUvkz7wb_oHO86JRV5r7twG6ropoJaR3Ujw@mail.gmail.com>
In-Reply-To: <CAHC9VhRV9WN_pQgQUvkz7wb_oHO86JRV5r7twG6ropoJaR3Ujw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 24 Dec 2023 15:09:45 -0500
Message-ID: <CAHC9VhRgw+xphjO+vBUuf45DJMTau-PzRY_ZxqWxpg-K0u+pDA@mail.gmail.com>
Subject: Re: [PATCH] security: new security_file_ioctl_compat() hook
To: Eric Biggers <ebiggers@kernel.org>
Cc: Alfred Piccioni <alpic@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Eric Paris <eparis@parisplace.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 24, 2023 at 3:00=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Sat, Dec 23, 2023 at 10:34=E2=80=AFAM Eric Biggers <ebiggers@kernel.or=
g> wrote:
> > On Fri, Dec 22, 2023 at 08:23:26PM -0500, Paul Moore wrote:
> > > Is it considered valid for a native 64-bit task to use 32-bit
> > > FS_IO32_XXX flags?
> >
> > No, that's not valid.
>
> Excellent, thank you.
>
> > > If not, do we want to remove the FS_IO32_XXX flag
> > > checks in selinux_file_ioctl()?
> >
> > I don't see any such flag checks in selinux_file_ioctl().
>
> Neither do I ... I'm not sure what I was looking at when I made that
> comment, I'm going to chalk that up to a bit of holiday fog.  Sorry
> for the noise.

Ah ha, I think I found the problem - the tools I use to pull in
patches for review seemed to have grabbed an old version of the patch
that *did* as the 32-bit ioctl commands to selinux_file_ioctl().

https://lore.kernel.org/selinux/20230906102557.3432236-1-alpic@google.com/

--=20
paul-moore.com
