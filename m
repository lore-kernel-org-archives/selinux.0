Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C83185E4A
	for <selinux@vger.kernel.org>; Wed, 21 May 2025 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839584; cv=none; b=SvvaAEbwr+E6+vK7UeK6pZGGA01BCPVPv1DflVPRoY6OR871o7hWl78MtKRxPgGQCiBfXJjsnapyNWXaXE+ZZkDWiJZFZmaIP8fYqs/7EoBa+63qmrE4cpzNplceez+vNQvdj2sbS29U25GBV4XOt0AJk8ZknZROs/NV+wdTrdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839584; c=relaxed/simple;
	bh=MntCPBl2elnEA4cJLonlZfisnjT6LGh4ls1FBXLehms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5mc4AmtkghjyIsz5qvsDeR1DEWPT/Q0pH0vqJzM8PltIVi9f3GS9RrmIHzbu+IwASZRWmX8++SQUb3E+F/T0SGZZhnEqyJQWOMQQexCMFLVf/FrUogOHlCiZBbiVbPPpNlEbqZ+wuuTRhm6Wp1Rc2ufWmJgM8qpkv4Q+gff1ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gkp2F6DO; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gkp2F6DO"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e7d5f3e6169so703212276.3
        for <selinux@vger.kernel.org>; Wed, 21 May 2025 07:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747839580; x=1748444380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MntCPBl2elnEA4cJLonlZfisnjT6LGh4ls1FBXLehms=;
        b=gkp2F6DOMPlRh1W5Hmr7y21m8V9HsSGfF9SZBuu2WS+GlV2LCfQtCVYgC1o8D4b58S
         e0lv0qfTJCjuyV38C9Q+SZv1Medcf2wRQeauDgHhbzmXjke8MfyMc9kjh65juEtp9rHG
         st3vXymBWwRJy8qC8P/BLGllJ4tPgLCHt/DpD+NVXsCPLJlbjdF8J9V2D96tZpnRuhWF
         OPpt1N2dSvVhfdwJLvVv80U9DFmbCOCXeqxpzCqqKuQWWG0GuNI0QcXxab5NPkMvs1hw
         5J3JJiEwwl5KJErzzUZhpi7DVGlSOEc40j4M15BsWix0lqGf2IC4DyK/uHf6ij/Jheet
         H87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747839580; x=1748444380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MntCPBl2elnEA4cJLonlZfisnjT6LGh4ls1FBXLehms=;
        b=DOrSz2CLiwEcFy3y8IMNDmm9UMM7KqlnWJ3/omy3qgvRoMFIW1qOrAtMicu8D82Nyy
         RJWO4vTe/SEDsOy7omWamtJhOEtSJxKehDgmht7Ufgc6BaheHOtLIFiu0jTnPSeOiE2I
         nZ+r/lB+UMQrSf7xJ7/gBc2z3vx/q6XjQsnypuCPy6sdLV6NzQ5nm6hp0+oNtOk4+/1m
         xlKQxpqv0/Q8YX1CXEIGKXXWB4JDHkqKLufusnjrmVOGSIRjiskQDEnD3b9OFz1QlWu4
         qCPOxnazqmiAx3VMQMFkrkLrSX+Aio64VJbadsQhljLNHblFr89XU9n0SgtXZA8ws+13
         nyQg==
X-Gm-Message-State: AOJu0Yz9POF9+SuCd9ZN592koRngPrsSHsXjrsmL7y6gvQz9ulzgP0zS
	rObvvDxX9pnNrJPKeG8J3jwbuFazeinxCzlSWZoEyOSB+GCXmDN2srmrP3eqGOtmTPX6USaZzdD
	GkWUPRqAv6pfLsIg7HfHXs/+Io+iAAubnP2fTz/LuqMvNHZn1OS0=
X-Gm-Gg: ASbGncuEHsIr/7qA81FGNATDfHPZ+XFX/IDmXcvMSXx7GzkF7mNGu4bXo2x0CCRUvsD
	RlCblRD14rrmNrTh4j4Vs/ClZq6CP2sm1Hd0DB2ICPnH75tUDMF41F2cc/W/atXcZqLB7oDe8l/
	rqldwL0K49klMEXvwfzzpqacWxLCne42Qs
X-Google-Smtp-Source: AGHT+IEf/p/vjyFy3h5m1Y41+h8kK0XK0fCklgggyNyxe/1ViFWn28ekankAgWhdDOJ8fXi5W7b+zKFFnZmSQWNaNOk=
X-Received: by 2002:a05:6902:4791:b0:e7b:7de8:f485 with SMTP id
 3f1490d57ef6-e7b7de8f602mr24102999276.7.1747839580272; Wed, 21 May 2025
 07:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2a34cb17-3290-416f-bea8-bd743e18ff3b@suse.de>
In-Reply-To: <2a34cb17-3290-416f-bea8-bd743e18ff3b@suse.de>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 May 2025 10:59:28 -0400
X-Gm-Features: AX0GCFv_iuLHmmu4SLi75Hw3Z3ygoGOCPdrlc_gZLMqh4ERns860C_hGS19chQA
Message-ID: <CAHC9VhQ8Qs5+sUjxLRSftgpcnJ-k0mTUs3zCS0A4pfdt+QL3ZA@mail.gmail.com>
Subject: Re: selinuxproject.org down?
To: Cathy Hu <cahu@suse.de>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 7:39=E2=80=AFAM Cathy Hu <cahu@suse.de> wrote:
>
> Hi,
>
> I might have missed something, but selinuxproject.org is down.
> Is this intentional?

I don't believe so, but I've reached out to the individual that
maintains the site to check on things.

--=20
paul-moore.com
