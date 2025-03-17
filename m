Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF26D79D2
	for <selinux@vger.kernel.org>; Mon, 17 Mar 2025 05:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742190628; cv=none; b=DBzLLp828VOjgMq1lq5mLshOIYjEpWzEmzbVThEU0LD9frDLunu3HGBrTkBWcPRXQ5kdReBhf8MyJz63F73AnJMJajbXrUYcKHYu/QNOyxHsuYtoPqGdGLIinSbWWrcJB1ersUvoodiGQroi7ee6DDHnXH97os6/vBhwda2EhXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742190628; c=relaxed/simple;
	bh=SS8YyeFaCq0x/HtbIxTApSE4mPydOMJf3fqh29kAMOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xw6pKJmA+zgr2fx+gyhsu/pEWZye0K6G1X4/dPcP6t/w4VMtVerkAGocHht+YT1WP1XKuTH2VyKQBoXtowzT92LmvmmR6JuHrSzYpTtjPfZZdRgOo2RD86OVmq1ZFgcu3aOJlBHbMU23JrxLFz022htexO/QO003bXYKR1WeIHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gqr/Ped2; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gqr/Ped2"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-549b159c84cso3971314e87.3
        for <selinux@vger.kernel.org>; Sun, 16 Mar 2025 22:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742190625; x=1742795425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrbARfkcKQKpHF1cJENTCmZ5xJEvxRSNbX11LKqXxVo=;
        b=gqr/Ped2oTq4zCsC8/u5mUCG1Fq4cOvG53CxV9tDIG8bD2D91x9YXOhgFo+9hZ8wnY
         sl24jjKIDOelbe7U1olpGm6iCRDt82G1tAMOUKm+L2Rh742YzyjLIigkWbIMZ+bdGElS
         nNap/QPT6baX9o1wnHwmfnneHD5Nf5KOXsX7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742190625; x=1742795425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrbARfkcKQKpHF1cJENTCmZ5xJEvxRSNbX11LKqXxVo=;
        b=j8wa/JUKF3TsquklB/7qI6ERPdOGop6kxBDjkb66OB71Zt11NUgKG3ISw0X9eC4kLg
         dSDMAa97TQLNFN820m69ZKU2YHxHp7kVTwws3epdB55d/dE79D7UISbfo97tB22NZ9xT
         y34odBXQhrIQdUfoJbe0pVdKha+XGkjUkxYBnrjHzryF50/4aL+09zLRrPw2I0/6VdN4
         MwuFoB3euUcNJzoBv0yvvuwxi7Uhf/9RsxsJgV/Crtxzxoly/S7lLD9pDgIsBNQRAOAy
         VPZ/Mtu0YsAADtfqnj09UwHHPo4XbpqFOsfQhFlnSLjnnetAXayR7Q1MqYmVuC9Uw0fn
         AA4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEr9jaVFJ2XJ37mzfu4idFeExgxdLR9DJoQB3WkuI4OKU/00xOvRnHLa+u3sR5yQULvi1jJ0HB@vger.kernel.org
X-Gm-Message-State: AOJu0YzAo7cUaGizNJAe9SzaS1soaW2Z3Afd69eQyXYVa+7aWcvq/L+R
	kGp3ytKxhGeeKQ3UTSveauyeNDAKzRB5L0bSi8/N9y8brQBKZog9EE2Pr2MJ+jJn34tJk/PfGpd
	lHVhi93ad3jV/sqJ0cBm7C8Ira2mQ8rPIYzI=
X-Gm-Gg: ASbGncvbWz008SEFKkA66PMkdz9nzAZNSqUMNnoLkw6bp45A6VLq4gK/NroLBuS9Eoq
	KF7E5G02O+cl06BiSCd61oe9rJp4DnUSQid6QmPRo54kHsIFvaodhOl8bfZLY2UBMpvl9Qvil8j
	+g5OXRkUFU6h3faLBJFfjDciA6gRsLeLGyOzNTiTTRVFPttV5I95cZERju
X-Google-Smtp-Source: AGHT+IF5yB/enBbj+Ds+KwLg/lfzC8qFVxkfre0Jn3TruiB771hi1gzC8icsEOFbeDV7o1Onl2+encvB4MU8x3lDpuo=
X-Received: by 2002:a05:6512:3da7:b0:549:7354:e4d1 with SMTP id
 2adb3069b0e04-549c398d006mr5025708e87.38.1742190624763; Sun, 16 Mar 2025
 22:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311092920.1114210-1-takayas@chromium.org>
 <CAH9xa6dtem=xKPZhF6s+ttiOsQRyz63Je=Qv1m8edxCV1hE7Lg@mail.gmail.com>
 <510029be-c806-48b6-8d8c-f2ee47ce15b4@googlemail.com> <CAH9xa6eJzCgOJO_wKDyeeZbv9AXMoANt5vFvsqDEtAH_o2oQWA@mail.gmail.com>
 <CAEjxPJ5JgtdggL1Em2jgdZqRNEh7+UaErXaquP5QB=tUuMSZGA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5JgtdggL1Em2jgdZqRNEh7+UaErXaquP5QB=tUuMSZGA@mail.gmail.com>
From: Takaya Saeki <takayas@chromium.org>
Date: Mon, 17 Mar 2025 14:50:11 +0900
X-Gm-Features: AQ5f1Jrcd-PgIof1Y16I1BW4hSduGZuWhe99BpOq3rCcL7EJKSIA2q_I2sSDg3k
Message-ID: <CAH9xa6eEu6rJsgEhcaqrxieNQkUBLyh0NnytnDhx+dF2CR6BVQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: support wildcard match in genfscon
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Nick Kralevich <nnk@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, Junichi <uekawa@chromium.org>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 9:34=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Mar 12, 2025 at 3:56=E2=80=AFAM Takaya Saeki <takayas@chromium.or=
g> wrote:
> >
> > Thank you for feedbacks.
> >
> > On Tue, Mar 11, 2025 at 7:39=E2=80=AFPM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > Mar 11, 2025 10:42:22 Takaya Saeki <takayas@chromium.org>:
> > >
> > > > Hello, now this patch no longer appends "*" in the kernel space.
> > > > I tested this patch on Debian by creating a modified SELinux policy
> > > > where all genfs rules were followed by a trailing '*" and the new
> > > > genfs_seclabel_wildcard cap were enabled. Both the new policy with =
the
> > > > capability enabled and Debian's default policy without that policy
> > > > capability made correct labels.
> > > >
> > > >> +       bool wildcard =3D 0;
> > > > I overlooked that this should be `=3D true`. I can fix it.
> > >
> > > Or maybe drop this assignment, since tge variable is always assigned =
later on (and modern compilers are good at warning about uninitialized loca=
l variables).
> >
> > I agree. Let me drop the initialization.
> >
> > >
> > > On another point maybe this feature can be combined under the new pol=
icy capability netif_wildcard, to avoid adding two?
> >
> > So, do we rename POLICYDB_CAP_NETIF_WILDCARD to POLICYDB_CAP_WILDCARD
> > to control both wildcard capabilities? That should be fine for
> > Android's use cases.
> > However, it will mean users who want to enable the wildcard feature
> > for network cards also have to take care of incompatibility of
> > genfscon at the same time. I'd like to ask for opinions from
> > maintainers.
>
> It is Paul's call to make, but I would recommend keeping them separate.

I agree that the idea of separating it is more reasonable. I will wait
for Paul's feedback and will send a v3 patch that will at least do a
minor fix of the variable initialization.
