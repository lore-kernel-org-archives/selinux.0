Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77989BE6C
	for <selinux@vger.kernel.org>; Fri,  3 May 2024 01:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714698397; cv=none; b=AA/aJKQxKJRCy3hfWSIen++LaggSYUfRvq2mktXqYMT/9TDSNEhGgNSYi1wG5wlCgUQgMxMooH9THhrC4aHXC6E0Fa3iBhzaWvXEqpLKsiBjygVZ7t5Wg04Po1dmRz/NYbY9VUA/Nwl/wpKDSYmLQBNfvvrxDckLYLWmBDTKocE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714698397; c=relaxed/simple;
	bh=Nb2wU7+6ijW8ZOZ6wSGEn2cC16UE00Wc/XT7q7bBYDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T939HgV/kHWDkWiUgv6bLr8I7sXK++DBJupoIUH/Ty1V8xxZ6G6s2MPcGlpWY6ZXKiXvVSeVR3b80gpYx9wvWDJ37kiHJMHDR+dgoSeZ17+foqt+/J+IiWYHFlRzvZKkzu9st4w4mGDnkZdeiftUiUqDAUJT8NZKXYgeoHI1iSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=D7mv4GQU; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="D7mv4GQU"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61df903aa05so33584457b3.3
        for <selinux@vger.kernel.org>; Thu, 02 May 2024 18:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1714698395; x=1715303195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nb2wU7+6ijW8ZOZ6wSGEn2cC16UE00Wc/XT7q7bBYDY=;
        b=D7mv4GQU7Npj9m0KSgvO4FcPHgRG6JPWQ4Yt5vQKqNLHza8vELu5+ZrQDO0txY7C9I
         ZBa6+f/pZz5QmDme2SRRNXvCBMqlWrUBMIt052ERKnYF2K5uk0sjkx1iVbYy5+tyqLN/
         gOLRBj6ZVafeLuSaBzgmKP3IOMfuedTv6ebbPdw1oZ6iDZVxYGdfxDMC4ItQcCjFJAlN
         8aLEFN6LXp21FJgN6vprXJwV1Nku+Bt89RFR4EVT30rx676LxGczqSAOsAKrTG3NF8Ow
         KX0BDellMFfobBj3G+t5Tky3v/2cmU/u0iap5PdFYxlJfP/MnZQN5AypuLt21/qxq9rF
         9aGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714698395; x=1715303195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nb2wU7+6ijW8ZOZ6wSGEn2cC16UE00Wc/XT7q7bBYDY=;
        b=IBTOVgOEnm+djGq9s3JH2aRRdrjxJP3qk0BOAQsDmp0N8vumLPuTzqM2a5CQTVcK8C
         NdxScS6g9jDTCIrQX6XxLWlmncN7Eil3aVuGd/3/sb82d341d2eNRnXYQRRbrSHQX+HD
         UiJC32ye65Kw9zRTREvWt36kwEDFbSy/OVgH4DJPTqma4PVdfDOV677H+lLo36DHFD08
         bR47z0NGGjaetT/ns+88RBEZY9XySbAyCP+Tc98x9Wo9PT3IlcarI/KJdRtH3dX3/ska
         +yXtFJu2Ftr4xPmolP+stRKRNOLzmRQA7+GVUNKDfjLSHoUn2a2qtcapr0JIpRHfGybe
         0rRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVri/2IBD2uFWQTAU3vnobVTBpBqJFqqSUvnPeAu/tMNEalFaER49qBeDpoH+rZ69OQmv5nvvVmBu7eW2mRldrtbCKC7v2fBQ==
X-Gm-Message-State: AOJu0YzOWI//O2s1y1oMWTyPu1VspLoSMqP6y0NRST292G1WQ+exREZo
	2ECNQpffI8JTXoldQcgWshCRGGuDKxDosgD388eSS9lRxjWAHeGWYYZrhXNwCFDF5S40PEjxQh0
	bkvbSrMIAQeaK/6Z3wKxPCVMOHfCUL2jU6yjn/JR0d4c3GlE=
X-Google-Smtp-Source: AGHT+IEzhPa0FjOrCvgEbUk+eDjxpzbAsvi3CvzaT129MxaYtTKZvkQ16S4fo6focZJrIcATBrvvdhSPJ3fpuB3ooEg=
X-Received: by 2002:a05:690c:45c6:b0:61f:fa18:ba08 with SMTP id
 gv6-20020a05690c45c600b0061ffa18ba08mr1382036ywb.47.1714698395442; Thu, 02
 May 2024 18:06:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4ev-pasUwGx48fDhnmjBnq_Wh90jYPwRQRAqXxmOKD4Q@mail.gmail.com>
 <CAEjxPJ46kPOA3N7PAgqWs-z74siF7bMoGSU254dYReQwFCNoXA@mail.gmail.com>
 <CAHC9VhQKXtdA4YS7=fB9ffGTDnd7qPkCZVCTO3fvaQWjzwUT=Q@mail.gmail.com>
 <CAEjxPJ4czKz+4SfTo6g3s6ztSRbfyOv_GBkgp=k38nGDFssRiw@mail.gmail.com>
 <CAEjxPJ5_SQDmR9b-+0woBLg25omtERSLBKawTV9AqLpZAHFvcg@mail.gmail.com>
 <CAHC9VhT_zOjJpg-JOaJQ4s9ybArfq2Ez_OiFAk0siPiqEC0KiQ@mail.gmail.com>
 <CAFqZXNvSn-Ct04ghSxiceKkRBgfyUeWJc3J0tjnU-Mm8mfPtAg@mail.gmail.com>
 <CAHC9VhQ4hopKwh6y=M2kZfgM=cdcWvqAbGAD9HMRhDDj88R_xw@mail.gmail.com>
 <CAEjxPJ4LvVr8w3bPLXrB7Aw=RS=CVnVwH0q7egQTP+F1Qzq1jw@mail.gmail.com>
 <CAEjxPJ4FxSe2RqLbnN0brsj32LspZ2Gh6r4GPWixv==X3X0oag@mail.gmail.com>
 <CAHC9VhRTfUO_b+dfWRNtFBPUCnk5iRCkCfT4PcNBt+b856t-iw@mail.gmail.com>
 <CAFqZXNuqHKAJUdZ-3VL64Be0hp8jPjztk2NaUv4+XFcgUe23CQ@mail.gmail.com>
 <CAEjxPJ7LJR9Xv7fzPxNYToRniDXAdUo3dqNN5OTVUYyy3ct+dQ@mail.gmail.com>
 <CAEjxPJ4YJsKcXQREL9i66-i9fzmsxLwH23eFqMs+pbXuxYK54g@mail.gmail.com> <CAEjxPJ7BD9rHAiCCtf6Dxhxm=1gbVioFLXSbL7fcqXDnvpkbww@mail.gmail.com>
In-Reply-To: <CAEjxPJ7BD9rHAiCCtf6Dxhxm=1gbVioFLXSbL7fcqXDnvpkbww@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 2 May 2024 21:06:24 -0400
Message-ID: <CAHC9VhSUngPLynPB2rg8bvthUSxuqED0ve1PHNRzbrJDum9vBA@mail.gmail.com>
Subject: Re: selinux-testsuite nfs tests?
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 3:54=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> Sorry, sent too soon. It does pass running the entire
> selinux-testsuite on a NFS mount with security labeling enabled, but
> then starts hitting some failures during the later context mount
> tests. Likely bears further investigation.

Still a good step forward, thanks Stephen.

FWIW, once we get this working, I'll see about adding a test run on a NFS m=
ount.

--=20
paul-moore.com
