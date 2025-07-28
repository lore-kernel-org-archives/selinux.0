Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569E31A704B
	for <selinux@vger.kernel.org>; Mon, 28 Jul 2025 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712717; cv=none; b=GBDBayv6vzk7IZX0PGscbvLWh8GN4W4KxcG65aTf21zyxxMn92sw9cVXghDwluDp7d83KJ7sjknhxcRTH4Pk8G/ZUzMHxsL0GJuSw0H4x7XrgDBrnlD6uzP4/KF3pCOWhfZSEDX03nkZlAJUcUE+cTv2H5j4yGVPRRmNbKXwuC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712717; c=relaxed/simple;
	bh=Y6g42KGu5y9frSahjqIAJsKLtK5F3uuHjpCiZXd3ofo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2pRFXw+ynY56rgSAxE5xfvTA5hWw4AolvQ4KRvuXPehxKbfnY84GAKthRsNaiSsMk0Ei2ILfMGdzgF8jQ4CJf5cm4vWNa+Nle0DXi6+RkscYgn4Zdj4JLJfTkgH+g+TXwNUcDZjVKeDTYL7X0VwrCTwyHC4xxOzyv+AsMlEesw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cg3V74x+; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cg3V74x+"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b391ca6146eso3979072a12.3
        for <selinux@vger.kernel.org>; Mon, 28 Jul 2025 07:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753712715; x=1754317515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtBH2bx0nCFlyN5uxDO7OAPestYO0fDXBBe5cxURjQU=;
        b=cg3V74x+G4B119gLOcneBfK+u/Hl9I8dHkSUps3xnXTlNF5Ihmekph80c1MSQQVltT
         0fE3ddVYZ4F726xj4RQfpWOpgOekjaZG8ypFMIKSsrMBrlfQ7fwZbsGkAF9b5O8k6prY
         TCAWPJ6boivv7rg5OsH1zU6/OzGU9QWe4a+7ym3ceM6BkdLhwrkYX7akPqUsirvXR0pT
         kj4CazVFuusRvkGWOqrzjbIDmEQbJxk2mylwlEu5TphNpZ6ckOUKCMUlXezh2IkmAeoA
         feLwly5Wqc8Lj96Uq1P30B4z5BA8/Eo5mWh11iu04O2wrTS90oDaj0ONovZYS4ixPWGb
         VFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753712715; x=1754317515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VtBH2bx0nCFlyN5uxDO7OAPestYO0fDXBBe5cxURjQU=;
        b=XbvoC9/1zZ2o4Psk4c36bxkgNWZUhygOw1F82R9/DZwwl1JTTMnBLLiklt76ShOych
         nOOFHSJM/3aRi15dE3LynzwtCPpbhqF0hs3pr18hY3mxvfMmsKF0jXEXKH0b8ikyKvFd
         v/avffucNBH196GqYW0RU3ZtZT8ISqU6u/HMPo67TYoP5IOvKlKeVArWYxdkTreV8I8z
         vn9GpDoZdac1lihmAquGZLv4Y4sFNm6ryWhylEmFx0560ojJIS1DP8iqxPCfwe1oLuHN
         CTpeePY5AnBbgiMd6RtAMh/QzrXylMGJGFpMoD14kisTa6mB9DmAwOQR9YQLUgNRLOof
         FPLQ==
X-Gm-Message-State: AOJu0Ywbfmxah5iIS2yWI8W8JwxgY7yIQm9C+A+7Z3haOXwuNHDCpLC0
	SXSyCyZZ10OD8aRxRC/OdDTnNdtkT45TrIAHnrbkMeijC21BFdvjih9iSYHqsIa6ppZDbAZgEpi
	uvcGlZUb/dkhq4iPauFeSSwFInQ/a+WDqxA==
X-Gm-Gg: ASbGnctgDA4DFK70CyiSK6hnEcJczlWX1HnSdJNSPzSxP6VKB+aPGHv6HpcSmEwEM7O
	A06e5YgvUR8lQ+fdxF/aPHWIsOG+3jkPsct0HCXZ/RF28QCs7Kmr21eJncovVjXJOJYNOsqRt+b
	ANd/hIaepzBYfFAjErF87y0PcNZiBLRn3Hoh8UxjqCx13QxLwqDtb4ucpJDRnW2m1AIfhsYt9o5
	tAKCT0=
X-Google-Smtp-Source: AGHT+IFpJhGXAvjD7O/yBWdmPX5HyimRmcMJnsV3xAtClZgnARRcJZuulxs+QNt1hknwhG3OeYZucwXCjtQKN28FimM=
X-Received: by 2002:a17:90b:4ccd:b0:311:ba2e:bdc9 with SMTP id
 98e67ed59e1d1-31e77a0351dmr15760847a91.27.1753712715391; Mon, 28 Jul 2025
 07:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724104539.42620-1-lautrbach@redhat.com> <CAEjxPJ5vzcrkieyAieFDaiHeWGDhHgLprp4qi9mLeVKfagp75w@mail.gmail.com>
In-Reply-To: <CAEjxPJ5vzcrkieyAieFDaiHeWGDhHgLprp4qi9mLeVKfagp75w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 28 Jul 2025 10:25:01 -0400
X-Gm-Features: Ac12FXxduyMOaJT-ua4lWx4aLbMr-zoFo8I0jEwbq5X8dd83PE3Y1YRwa6vUm6A
Message-ID: <CAEjxPJ6U-T3nsxPVvx1y7t5o8URd6oA1bO-DQw0E63Hi_Zi9hg@mail.gmail.com>
Subject: Re: [PATCH] README.md: add link to the github wiki
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 10:11=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jul 24, 2025 at 6:45=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.

>
> > ---
> >  README.md | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/README.md b/README.md
> > index aa98d7819b01..5c6caa9d710f 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -19,6 +19,9 @@ Please submit all bug reports and patches to the <sel=
inux@vger.kernel.org>
> >  mailing list. You can subscribe by sending an email to <selinux+subscr=
ibe@vger.kernel.org>
> >  Archives of the mailing list are available at https://lore.kernel.org/=
selinux.
> >
> > +See the [SELinux Userspace wiki](https://github.com/SELinuxProject/sel=
inux/wiki)
> > +for more information.
> > +
> >  Installation
> >  ------------
> >
> > --
> > 2.50.1
> >
> >
