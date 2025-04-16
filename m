Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7DB1C1AB4
	for <selinux@vger.kernel.org>; Wed, 16 Apr 2025 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744819252; cv=none; b=ZTbE+UjUsWdHK/oCr9MVy9cx1eE1AgbNvsTIVw9nyeNMfN6uW2N+OINlA2A+dWx3PM/o3Ur36aKMLjf6o+4pN+7TgAanhn+JYlgrpvLo4Bcy9/Wx615p2O/RSHLzzE7wZB01dfFvqvM6pKIASvJC15Bo2vtdq67EMA6E/BR3AjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744819252; c=relaxed/simple;
	bh=OQ2LUVURG5ZBoCwWh5loGiUwdSTfHuVc1849YbckkqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qbT2aLmdmDYzv0ZoLgIj3A2b63uzcb2M21l/DIvi/kzOSonTq4FL9oTdxPMNu6iNTkWSwyWIm+wv4Fhy5IuGgo+aT4dzIhHyMHLBpJFsMpERFYTlo3uh/0hxWCErNqTgqa4uawz4k64BUJj8FWztkLm4VF51rJWnqREziep8Vlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ceJY0ajc; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ceJY0ajc"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-549963b5551so8064894e87.2
        for <selinux@vger.kernel.org>; Wed, 16 Apr 2025 09:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744819248; x=1745424048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBPmcg0bFH2XY3Hin8L4B6RZDr/nTgPQCfRGMZTM/dg=;
        b=ceJY0ajcpp4Etwtg/oRJQk7GiAqywh6FqfWax9RM6aOqARUGEnt1SyS4osZjvEebcO
         S3Uc/Vd7j2Ujy9gXs87Qer/GFW0/C7rdE/cLOsVyRIKcDSxwaeV0Ygqvlf2JrMOd59br
         Q9da2Oq5TZXBUk2wENpmLSlwtySz5sEe5k3SI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744819248; x=1745424048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBPmcg0bFH2XY3Hin8L4B6RZDr/nTgPQCfRGMZTM/dg=;
        b=T9xrfUYUIDrU+vGL5PWg7fNd03TWqfDxgpGxHGQX6HcHf70aDIGATDFk0joT/CycJU
         g+1mkBRPM/EB+byL0B/s07LRlU/AMzgCi1+pLNGf5/3HSi/rnZxH+OrorMB4/+D2J/qL
         BVGg2qzaXXd/0TStCn53yILR7ho5XOYdHggBCgPax7dkPNofh1k4dCLwtMR881K7pzV1
         tBDS908yJeBE5CdSrPrpn7zDy9Wzpx6WCzcjl1kdrqANrrTzxISmcYs/CSk6li2uDgx/
         naAGlQkxAYedXlr6Ytck7tN5zfLlQ0J3X1RI+XkNaSf0sZmf759vf0d4nokftCxFRZz/
         fFxg==
X-Forwarded-Encrypted: i=1; AJvYcCWPYVpfxcUszntHKt5SQ1WwQMoffErke6H4wLC4AjoKfzYeT3mXBp6T22w6/AmY56eTcPAOPJYh@vger.kernel.org
X-Gm-Message-State: AOJu0YwCVqrzzUCHLCGCr4MkuvyI9TxTMVQrViyzLz54pg2qBD/FPGy1
	7rQD1L65e9e7SJgQjyxAmlBkRBJ+yXEUEHa4kK4F7bDFlGjqqLll+IPFGbOrKDzun1GgMOvjESX
	dN6mFCgz+lmbj7YhZ7ofSnxm8EhLgm6uuq0Y8
X-Gm-Gg: ASbGncs8jZrnQ/ssLs5mfZq+0UUhamuklncC9TbTGKXCs50adije4rBVIII9O+dP6js
	rsla74uWBiDt4BQH2dy4yxBMfP3aS6NbXRm5s/bePZPW66E2AkTQxaLGdNMVrF7w55LFPEeIk73
	cReMSMPK9jWTFdUTO5iZkanAiSzJ177rGS
X-Google-Smtp-Source: AGHT+IFlK7R096/+OAh92R+N0wIujqmp0uU3OFtKyNa2K1gFmEshtOax20fuvbKOa8HxCYGz77KZC4LpcqUinUZDXA8=
X-Received: by 2002:a05:6512:1090:b0:549:912a:d051 with SMTP id
 2adb3069b0e04-54d64798c06mr830233e87.0.1744819248030; Wed, 16 Apr 2025
 09:00:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415071017.3261009-1-dualli@chromium.org> <20250415071017.3261009-2-dualli@chromium.org>
 <69763528-bb00-44c5-a3ce-8c30530b29ee@schaufler-ca.com>
In-Reply-To: <69763528-bb00-44c5-a3ce-8c30530b29ee@schaufler-ca.com>
From: Li Li <dualli@chromium.org>
Date: Wed, 16 Apr 2025 09:00:36 -0700
X-Gm-Features: ATxdqUEvTcc4Mrcasz-DJMu04qcEN1mqV4hfHibSLmGFJSE6dIDY98ewYmt9cyM
Message-ID: <CANBPYPgfW+3jeTPZmpHfkgr=hX8sRkMLgrEeLFYa6rOPftXeFg@mail.gmail.com>
Subject: Re: [PATCH v17 1/3] lsm, selinux: Add setup_report permission to binder
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com, 
	tkjos@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, cmllamas@google.com, surenb@google.com, 
	omosnace@redhat.com, shuah@kernel.org, arnd@arndb.de, masahiroy@kernel.org, 
	bagasdotme@gmail.com, horms@kernel.org, tweek@google.com, paul@paul-moore.com, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, selinux@vger.kernel.org, hridya@google.com, 
	smoreland@google.com, ynaffit@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Casey! I'll resend this specific patch to linux-security-module l=
ist.

Should I include the other 2 binder patches as well as they are using
this new permission?

On Tue, Apr 15, 2025 at 9:13=E2=80=AFAM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 4/15/2025 12:10 AM, Li Li wrote:
> > From: Thi=C3=A9baud Weksteen <tweek@google.com>
> >
> > Introduce a new permission "setup_report" to the "binder" class.
> > This persmission controls the ability to set up the binder generic
> > netlink driver to report certain binder transactions.
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > Signed-off-by: Li Li <dualli@google.com>
> > ---
> >  include/linux/lsm_hook_defs.h       |  1 +
> >  include/linux/security.h            |  6 ++++++
> >  security/security.c                 | 13 +++++++++++++
>
> This patch needs to be sent to the linux-security-module list.
>
