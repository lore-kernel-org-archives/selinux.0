Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158EA20E011
	for <selinux@vger.kernel.org>; Thu, 12 Dec 2024 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733996516; cv=none; b=RaGKCb8FjGSMlh45L/KLvdsJTZaa0flu1kvwXRTd5UNGvNsmGtiaTKyeZ1AyNSkiT0vUIeszh9VMSTUirB0/Fp+nKLP802wMFsx69MU50CzsFEIyvngEWn6TrJpOogZsXbgDtM5iTy11S7n7+QSrfD0JG22LjrZyqg7SF4P/P/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733996516; c=relaxed/simple;
	bh=rykx200Pd7CMaRJoCkzpc93aYccHME07TEZuSvlK3Vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mda/I4lncP1fveE7JSrZ2eHWbkW30MUSd/Yr02+3otxGaxYxag6Y9jC4+hnD3yTn12h4lKjB9EWfColqip5Zxcha9vG8pZ/S/yET/xrW9c8PUCmfbPa77AEQSYcFBl6OwnK9AvpcLiBYGiwCRDnWVuCQm+4CKLlVpITzciQ59H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TE3wF44v; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TE3wF44v"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3003943288bso2809651fa.0
        for <selinux@vger.kernel.org>; Thu, 12 Dec 2024 01:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733996512; x=1734601312; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qCrA6gFBsaSL2nwTvaDb8dnwSVQYMYz3hDGQs0QKsrE=;
        b=TE3wF44v1qLXMVjOVvzK+MnBUqJ73lmZhZoylw21mx8yma/2ehwGSUkdYIYWXeSTSv
         YuGh+4Ac+gZgJuoAFfJSdSiBNcpaEPb97PPn+mOnMNFhnGxjHHe/D7ljfV8srMEOUFxO
         Gm0dbmOUrwNafEW5EJrmMVd7Sn9cPdiQQ45k8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733996512; x=1734601312;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCrA6gFBsaSL2nwTvaDb8dnwSVQYMYz3hDGQs0QKsrE=;
        b=r7fwjNKn3tTxrDUxu9mkFM1KXL90Qlj2Ujqk/SYxsEs+j4xnF6cffpAsPcuuecQmOE
         RiWt7dQsTcB+lsTtv/qscGstwS1YDuFdmOn8Eebu7w4lxKY533BWqY+GqSPXE6vGESeS
         S5KUWJIEHSiORh56hygQd58px7mDBODnHX0sAdEYenkpvayvxvCYmTS8fN6ykXJAhrJe
         ctR6fQVbZCKQ3mXFK7cI8FIVQvibrN3fjt1+6Kab/mPzVAYY0NA8TUxIvdNWwblWHz1R
         KkCPUplyQHoQHSRgVvPDStD4bESwjFqJnO8vjifTWxpWmhkBTDQcVGij0dd000uEgYfI
         tbPw==
X-Forwarded-Encrypted: i=1; AJvYcCW0drUpDNakZWXHHCMx0UszeW96RM1u7j2Vb8D5CHCHZI3G3jD121IGYKxV4F63zdB1B9QvLbE7@vger.kernel.org
X-Gm-Message-State: AOJu0YxrNgYMQkIPwXrrD8Zoam21AGLLYwKwhZwgGljC5gw4sTYMkqwp
	r01RL9YnDMzJct8V0a68Csylo9++UOvS9xRzVHs55ezvvuwTwjCRdQwFx0i3Y8NZK2C3XWcey/5
	bwAxWEono3oiKdUXSDWX3P8wNVwSc1zjhxJA=
X-Gm-Gg: ASbGncsR7bFDT82/EtKPX9EZDowMwqS+7fEIfwK7tTvV0LzRMph1vjAw4mf5imbsFPi
	Hq7awfNALirf51ik8FbTYGVvRIILEH3h4h5xV2mMfIhL/pq6Qu3QfekCN9CE1eAv2jMs=
X-Google-Smtp-Source: AGHT+IEUVPWBdlK7ckkViUtwQLH70clyJxMpGdb7elm8xzQNCRG+kPBGOxpFcRkDjtA2LUWnAlHbJBKIX7sjB93YIy8=
X-Received: by 2002:a05:6512:3c8d:b0:53e:3aaa:5c7d with SMTP id
 2adb3069b0e04-54032c326edmr272523e87.13.1733996512191; Thu, 12 Dec 2024
 01:41:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211161443.51286-1-cgoettsche@seltendoof.de> <87v7vqjd0a.fsf@redhat.com>
In-Reply-To: <87v7vqjd0a.fsf@redhat.com>
From: Takaya Saeki <takayas@chromium.org>
Date: Thu, 12 Dec 2024 18:41:40 +0900
Message-ID: <CAH9xa6etgNe24pGEL82WqgLzFq714WMpQLyDE4mKf6wReu4tvA@mail.gmail.com>
Subject: Re: [RFC PATCH] libselinux: restore previous regex spec ordering
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, 
	selinux@vger.kernel.org, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Junichi Uekawa <uekawa@chromium.org>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi, thanks for working on this so quickly.

I tested this patch, but it seems that the following pattern I wrote in
https://lore.kernel.org/selinux/CAH9xa6eFO6BNeGko90bsq8CuDba9eO+qdDoF+7zfyAUHEDpH9g@mail.gmail.com/
is still not incompatible with older versions.

> the first rule is applied to /foo/bar. This is because now the node for `foo`
> is processed first.
>
> > /foo/b.*   u:object_r:b_something_file:s0
> > /(foo|baz)/bar  u:object_r:bar_file:s0
