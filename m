Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966E1278E5A
	for <selinux@vger.kernel.org>; Tue, 22 Jul 2025 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198602; cv=none; b=mxAVCKEpaxj/3NRbkyV8FTYsy6coe0Ecn9YTEbayy+4KFxcVOfPMoHpZ5NShwAag3pitMS+Gs2zigjZxWgGR9ZXS+saBLKgqp6/0a9qVx4iVDdxUgVbfJrpaYrcQE66kzMJU8LhIn8D/EAb4k9c95oSRJqo617tX8Z/7KKhs+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198602; c=relaxed/simple;
	bh=eFacux9xnbCCvLXu+g7auhoEF3HWuOJdapiNTAG9wyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6F8A9k15gu7Ux2RUgyuIvI34JyCiEWEyudzRxh4FRY78BWPV6Zamv3YMAzQmW261f7Y5T75cCdP9w0+hZFF+GwUTT6J3BFJtDPc2KIUt71GFSEXpjiH858oALGQbZkc/eITKu+ca/nqEd9Ye8g4d1zo8Y8u8Nl2/OV2OzLefhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEHy/IQd; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEHy/IQd"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-311e2cc157bso4826259a91.2
        for <selinux@vger.kernel.org>; Tue, 22 Jul 2025 08:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753198600; x=1753803400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTlewQ1RHVZX073uvUYTmCLZMQgH8u8aPbEGLgRGb80=;
        b=MEHy/IQdqlHAOuU5Ri7xCQUQ4S0jWWSpDOfa79i2/1mhXOAosogkm/jOjy84osMgsK
         xk9gFJSNAqNzMfJYCrH/uowMt4CAHDeTzUDQiA2KQy/pjtjZghiAfwLm29NCUiRA0NXH
         utcX70cevQvsShbXlSq383LLH1QZJXOJ8zVnBiuJFvWETyhjXu2/z1N6NYu0xc7eW2DY
         mmHngAYc0bqPwalUB6gozosU9Nflaiw4i2smk0aZ2qANd8aKe90DMXys8bGtkSkZiNCL
         hTTSuFH4dKKLMtwxdt8PmPsi0eudgR/CE2v1yPv1Ujtq4kg73Fpvm7MJI1lxhZ95rv5l
         /lMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753198600; x=1753803400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTlewQ1RHVZX073uvUYTmCLZMQgH8u8aPbEGLgRGb80=;
        b=D/kch6m5XE4A1rDVmZKz9tLPX+gaIz0wUpT3Gcb2p6Gl3agoFe1VwV0VJH/NXEnO7A
         9znDyLlwNp+1rjeX32Kwq8WN/gsyCWCTOtefPhqW2YGI1Jp9MU62/neulGL6dqLiGYze
         XWJCJKNLIvgr290S6bLPl6nn0S5vTaWbJRhOUe9aIK31xclXDlAKan67VYTWAGrU7PPD
         4tdIVWFourubvnFaJM1GkTpofb8w8i/M0l9SsYMliERQUI39WDXP3Qpwcla3Xw2rdrVc
         kKyQzrBGqBRuEFfohA3txT6SPFNSBmkKB0FymzSwygxUlGSRLfVPJShI4IUDbOJa+gUO
         vo6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPew3a86g/F4wfijy3dbQ3Gb6TPbCxSc33uNSFaxYHZVYYzvgdc6i/c0d5mqpxCAa3G3nWZ9qn@vger.kernel.org
X-Gm-Message-State: AOJu0YzicYkn8bnByu+NpaZmalmTTDq3oAjY3HSVxUQfd6dw4nNIDbeI
	Pjo/c+21hfrUyD1MVncXZ80jG0CCY7A7FaLuuWayaGg/MrzYVzGKB83KxZ7cX7ItK4BsvaOBxDV
	vijRdzCmt3gjW/dAIV6WIvkkUZSb1qH8=
X-Gm-Gg: ASbGnctIfve9emL2yxCeHIbGyv/bh5yZA2N9thd3p2mUgWgrdFhyOCsSVsKFIN0epMT
	uX98FEa+ALCHAzy5HJKpSxltF4GABvljZqrZzcsJN1ad6HKzV0qxavISdk2zzHebff6lYyJMqKe
	FHqpqNLdwuC3ptqHr4gcBLa/fJrqsOtAFHmQMhz6ffV0AKmylXwwp+fEnGo5YInpqCUsHboDCdL
	wMjh30=
X-Google-Smtp-Source: AGHT+IH4qGYJrI15eq0rLWfJH+X4dP7lZeVKxvVegJY3SGP44NJHcy8N5yem551MqKn1pRUuX60Ff2oTxlA6bcfKmNM=
X-Received: by 2002:a17:90a:d00b:b0:312:639:a06a with SMTP id
 98e67ed59e1d1-31c9e79383bmr35493951a91.31.1753198599720; Tue, 22 Jul 2025
 08:36:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ5M76PFEMghyCWPsJW27rNA6A4yxhFydGoWWDW0Eybqfw@mail.gmail.com>
 <DBICEHLQ2KYS.2WJEMIZAPCJCG@gmail.com> <CAEjxPJ4CqG0_ORke4nyDM8w8w3-vW8DEvkkSFhRhYL_13Rrpiw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4CqG0_ORke4nyDM8w8w3-vW8DEvkkSFhRhYL_13Rrpiw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 22 Jul 2025 11:36:27 -0400
X-Gm-Features: Ac12FXzMxoWRIeOArkBpN76dBbWZ6SBeCGmutM_TDh7dXmkPPiruqCa-GRGOFXk
Message-ID: <CAEjxPJ5zkhuM5sHRq=qSydL7s3ULYV2XJQDiQk=6Rg81r2DXSQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: fix parsing of the enforcing kernel cmdline parameter
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: omosnace@redhat.com, paul@paul-moore.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 9:05=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Jul 22, 2025 at 1:42=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> w=
rote:
> >
> > Hi Stephen,
> >
> > > We should make it match the kernel's logic for parsing and handling
> > > enforcing=3D on the cmdline. For reference, the kernel does this:
> > >
> > > static int __init enforcing_setup(char *str)
> > > {
> > >        unsigned long enforcing;
> > >        if (!kstrtoul(str, 0, &enforcing))
> > >                selinux_enforcing_boot =3D enforcing ? 1 : 0;
> > >        return 1;
> > > }
> > > __setup("enforcing=3D", enforcing_setup);
> >
> > Okay, seems reasonable, I'll send a v2 to follow that logic shortly.
> >
> > > And the kernel's parser ignores anything after a "--", passing
> > > anything after that to the init process.
> >
> > Just to clarify, unless I'm missing anything I don't see any need for
> > us to worry about that as:
> >
> > 1. Based on the logic above it would seem 'enforcing=3D' is recognised =
by
> >    the kernel?
> > 2. We're reading /proc/cmdline anyway, so I don't see a reason for that
> >    to be a concern - we're going to see all arguments as far as I can
> >    tell.
>
> Yes, I believe you are correct.
>
> > Although, I'm a bit confused about CONFIG_SECURITY_SELINUX_DEVELOP, how
> > are we handling that in libselinux? I don't think that stops userspace
> > from loading in permissive mode, and even with:
> >
> > #define selinux_enforcing_boot 1
> >
> > I don't see how that would stop libselinux from loading in permissive.
>
> I'm not aware of any Linux or Android distribution that disables
> CONFIG_SECURITY_SELINUX_DEVELOP itself, although Samsung disables
> permissive mode another way. That said, I agree that libselinux should
> handle it correctly. If I am reading it correctly, if one boots with
> enforcing=3D0 on the kernel cmdline and
> CONFIG_SECURITY_SELINUX_DEVELOP=3Dn, then selinux_init_load_policy()
> will set *enforce to 0, get the current enforcing status from the
> kernel via security_getenforce(), see that it differs from *enforce,
> call security_setenforce(*enforce), which will fail, and then fall
> through to loading the policy. So the system will come up enforcing
> with a policy loaded, which is correct. The only seeming bug here is
> that *enforce will be left as 0, which could confuse the caller, but
> it appears to be only used to determine how to handle errors from the
> policy load, so a failed policy load might not halt the system. So
> that should be fixed too to set *enforce to the value returned by
> security_getenforce() in that situation.

Android doesn't use selinux_init_load_policy() and directly handles
checking and setting enforcing mode itself so this is not a concern
for Android, just Linux distributions.

>
>
> >
> > Regards,
> > Rahul
