Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA75C16FF44
	for <selinux@vger.kernel.org>; Fri,  1 Aug 2025 18:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754072967; cv=none; b=jNge57lSMwUrgLB6CHlZN4brtDFdF21jING54+mYkaMnsjVWcuWen7qTINdnSLh68+3JbaVb9j2L1BStE4XZlzGsZb3fCPLcq4bZFs0NaRjNRN6aulwFnTm2EU4DSGxVywaDEIQYa+W+/nPNu+J13TBhCh0irTJt5vjONPGbnDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754072967; c=relaxed/simple;
	bh=yktrILKbEUGAffgtsVMTTrqFFPuAPnEGyOEyDKTvrfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0Y1KACH+y5ub7rRQNk9ehEhkrpUADM8wHPHctXxb+tkVnJ406cbLXOZmi/CE2i2f2LN/QVvDI4MVAgROpZZ0XXGi1rryR93IEDaC7HVncJHJaIzB+ymUppvS019rDBBZyA3gDAfU4HgW+StKvcKDRUyOVt16KUCPp1G+g3PFNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jU3Jl4fZ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jU3Jl4fZ"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76bdc73f363so1100735b3a.3
        for <selinux@vger.kernel.org>; Fri, 01 Aug 2025 11:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754072965; x=1754677765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqzdGVD6wAPurGhPETHCOYphLAfb7IXM9ugtg643w1k=;
        b=jU3Jl4fZhlT0i0l1UbPgqxVS6Ue7/M52MXsITf4YkHWwo6Mrjv/ZSGuefPB0BaTEDj
         OV54JllZ1qek49yPDt/pbc5qgoCKOaQN8JN9nLJoeIeBQDN3R7DLn2sVJqPGZ/L+6+nR
         B3Ao+SJlMsBsy06iNdODv5DzQ/B4R/V0ow5rm9bnnSt25BbKD3MSnlsjJQ3FEkAIXKf4
         U8qVdQq6BFrB4ABr6DNTScsQ4RB173ntj6OIORsYOprUb8bc+RIjaoZ9yAjBBLigmbDV
         a8KAleI8DNiCuejqg/T1y8px5qd6jWeHMXhvY3jZYDxOFJK6TV+YONI9OH4VQdRZJ1Q5
         JT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754072965; x=1754677765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqzdGVD6wAPurGhPETHCOYphLAfb7IXM9ugtg643w1k=;
        b=bCNoblMwqe5MaLQuznKMWEWGcvwzhKzf1H5+2DpKhkyyduS/zRTqqZv4yvgvMHFQ6s
         fMm4t4pfCI15jBUpaRVb2WuVufJdMn03e889JMNrFAHiG221QOFbdCu0qy7vCHraJFM+
         G+QllVhLyj33vKrSMH7LFtj48xniC39EldF8W+ZRgXrXQwgoyNmUCsE2Zfd8tllheWX9
         XWbib/oVmnAGQ0VHWqhDdkuVlBwMImd3+j3Xvy5Fpak++k2aldeuKC4qxRV70aeVrM8p
         6tKSJW7CqQVo16QbO1klEr4GvzKMcGCbbhuvdKk2N04WzvWqFMQqvkwIuoTl/ItKqmWI
         e0nA==
X-Gm-Message-State: AOJu0Yx5baYAQnN9vEp97DutOhL753zes4MmvAnTfuD0fovQalK35Xng
	UEYE2K4B0Z3VKx3Z4cxUoS24UpsJDRDwU7w8BzKYVIrf4F392xD8ma8W6zgyKGZ/HVskgkt/5x/
	KSi3p57kfd0IZO42pVJHhzABkEJu+QDQ=
X-Gm-Gg: ASbGncvAi3tI/Mp6lqcOUqFPMBz4KZKIB0R4rwKBeAXKCG/zsWavK59VMD8JttWHANb
	JyzflZbL5DgKz/3Aitp7JLsyucdklngpU/KrxEx5utzUsDluCjaF6/9yPldWncybdmb0meQPOoa
	aN410EcXUNBq3CRMY8qetBzWep9DKRUGgJynshfArIAwcAeXtKUpa0rgOX+GOxoOQxiCFT8EDDu
	/vT7CU=
X-Google-Smtp-Source: AGHT+IFNvTxleru1Rx3rewF/0HX9HCudOsAShR2mNehn/UFWjfOWSb/k4c2Eo2DX5KftNWeGBZQxvZ6lB21Dwuogo7g=
X-Received: by 2002:a05:6a20:9392:b0:232:93c2:8851 with SMTP id
 adf61e73a8af0-23df8fbbe30mr1019743637.18.1754072965091; Fri, 01 Aug 2025
 11:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DBRASSYXDGO0.2X50XS44GR1WL@gmail.com>
In-Reply-To: <DBRASSYXDGO0.2X50XS44GR1WL@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 1 Aug 2025 14:29:12 -0400
X-Gm-Features: Ac12FXwAPDQnsOQHquAyhtLRV006T9ePWfb1zbcLkIgkuTC3J-OccHiT18zXakU
Message-ID: <CAEjxPJ5y9fV+B0_WrT71+NymwHubVVgbNePCa5+tM0deamWA-Q@mail.gmail.com>
Subject: Re: [PATCH v3] seunshare: fix the frail tmpdir cleanup
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 2:21=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wrot=
e:
>
> > I would think the idiomatic C way of doing this would be to use fts(3)
> > or nftw(3).
> > setfiles/restorecon originally used nftw(3) but later switched to
> > fts(3) for reasons I don't recall.
>
> It's worth noting that fts (3) is not actually mandated by POSIX from a
> portability perspective, however we do already depend on it for other
> parts of the userspace[1] (as you mentioned), and shims exist for other
> libcs, for example musl[2], so I don't think this is a huge deal.  I
> can't speak for setfiles and restorecon, but nftw's api is pretty crap
> compared to fts, so, like them, I'd rather use fts for this than nftw
> even though nftw is part of posix[3].
>
> I think dirfds are fine to use here, however I'm happy to send a v2
> using fts if you wish - would you like me to do so?

Maybe wait and see what other SELinux userspace maintainers think - I
am just one opinion here.

>
> [1] https://github.com/SELinuxProject/selinux/blob/main/libselinux/src/se=
linux_restorecon.c#L17
> [2] https://github.com/void-linux/musl-fts
> [3] https://pubs.opengroup.org/onlinepubs/9699919799/functions/nftw.html
