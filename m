Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB225349B0A
	for <selinux@vger.kernel.org>; Mon,  1 Jun 2026 19:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340481; cv=pass; b=IdUJUG69JfFAwU45lKdNaW6mN0FtmaSjIy8pHqawqLOrPTo7yvbhlcIooyuUyZUjtNWl3zseNraUfM+sXU5HjVYO2zprIKSNGkoyNb/FaPtGoRh83dV3oWf6YqEdBkYA3b0UGJxh6wz/SZFDYh3i91sTN30Ui4cysw/be1v3fgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340481; c=relaxed/simple;
	bh=ixyprkSXuQ8/cej+CuJ8ZzH2+XWpSHoz4zX76Kw+DW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQBXJvJZltfPikV88xljqis5zwz1s5x08MQTrssNbehK6/3+kUnQp6yvTv/rpNJ6Hj01ZlB5/EF4PQHdWlIRne0qJgCZ4DJLLqZLoOw4LwnAZbG+pxlaYnyiKFs7P+4q31cR3sIrZhnHThc3AalLK4dls7nlJ7ZSCzU3b3nF0R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qhwtn9jU; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhwtn9jU"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7dc6fbf3e86so54250937b3.3
        for <selinux@vger.kernel.org>; Mon, 01 Jun 2026 12:01:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780340479; cv=none;
        d=google.com; s=arc-20240605;
        b=XZNa56QEOPbtoppmG8kB0/T6VAKQ5E4F3uYHJ9OVqQT8oPGm9ALfAOCHabuaqCGBo0
         EOd00OX+RTWHQxWsCKG1i7ipR2NHmH5BFC5P2Tps2Ta+igaiz6GCcYG6LnUpdm09vHqb
         q9N4ORxP7g0wwTfx4EFxjfJi9L4P1MytBDlEtQMkOMVmOvcPNenb5FPTt6RzzG7/fhrl
         cRLX6nuTKb+z9t4dzAgrqrv4Z9i+0ATIW1hal31fOs2nwM2mH2JP58d4Mf4ltZ84QCdq
         CasXq3g5P3LcXOzbRWADz88M4iKSGcObs37GSI7UsR41XABZ/Uh/XW0u8kg936jW1TrW
         ijkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L1i7RUz+e8Di+24H8lSDYr5p6mrcmexfw39tYCtHdrY=;
        fh=JwkD4awozgdzhhwm2wDRIGtn9+4i8CG2U4iFUhRWLY8=;
        b=RTBypa2coALq1NFohFejyI5JsdgdpLuGVPe3kdUDTBDw0JqSddSBoHRx1pf01imwVP
         u9iGTtzHNQc8IFyEnpuyRDmPit8JCLNCtkP10QiGV+28gi8Ng9vhRgjLnznpDk/exSWr
         6U5Fa4Y68kuNEROAn/r62ymgxujwoub81hQ09vE0zH4bcI60T7XscHmYCpMbEhyxDzx3
         NunU71urNmcb+rHChzUL249mELyxAIdNEK6a4xmQ+CrqiElKnOb1WfJnKfLK1GgfD1NK
         IIWSSd9W3wmVYPFcppKRDZ2rPffMWxZzLRJH3CUF5NLxlMq7aoHibOkx1yrsQI1YQYq8
         EihA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780340479; x=1780945279; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L1i7RUz+e8Di+24H8lSDYr5p6mrcmexfw39tYCtHdrY=;
        b=qhwtn9jUsrdQtd9NiJN6WO9AvAnSQ0H4rIg5yTie9XrxDU8RpV/hAYUKrzPkVs7Fz3
         PDE2NvZg7Rf+neM29qayCHhf9rj9DwIt1adWXJ+8T7LZUpv5l16ihQXYPKwU+yL45bL+
         telgvW+5/tOwh/6ROHShkjldF3rXqKTz/ZR+qb0yWgOgwWEa8nkPjthtG7rWPz6O3dH5
         1D5VosYNFit+Bq1d6DHsGUpz2BIU+pSPCwN/BNbCoetlIBqwqXpFYj8aLoDCv6lTXa8z
         jrH2ATFpgcn8f6VKTJI9Fe3Rig6VOGtbpEJcj4xEd6mVbwSUyRJz/B+WXfEIW68Dijk0
         quCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780340479; x=1780945279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1i7RUz+e8Di+24H8lSDYr5p6mrcmexfw39tYCtHdrY=;
        b=m3gar0u/8rYb0IjRmxc5D7AW1vRbsa7Y3n4JMyEalkSIR92wZduzwXs1tgy2BbnF7f
         fSBtJDx+xpHNMnNUU5C/peVbXQ3uJ6qzua8QxaRGuh7ea3T6D5XdQ8W9YKC+sQnDn5rC
         TkKHjF2nPK8nJc8ghgwUxiKR9Pwnr9eN4D5KboAl7gF58l7T4O7bqJkcUN10F6yEFDJp
         diLr8SgELlkRCdW3lkCP3sUXJeY5Ny1xotUIxyHKA8TsaPbxtd2BGrVKZmKMhgY/b6vO
         Q9xp/b5y7PfyXLVBdH2Nc1P1qeP/apYc/1c58Svpwmck4wsEVlruSgJEZalU+XcieHLD
         4psQ==
X-Forwarded-Encrypted: i=1; AFNElJ/bQcp4w+2O5hIiEwlbttmOhVtvf71znbewVwm9HmOhnNd2fyFJep5SZfVZFrOL6MyZazwDNvpE@vger.kernel.org
X-Gm-Message-State: AOJu0YxvQpExxn6rsXNLWCrWyUSx6G10ForISUOmwV9OJ+mVULxmOMM5
	D3uIQDNVJlrQYno0raGSg8sM7ecuStM2omwGz9tEIgDGhLBc+nQWsEBtdorg3qgrYaTmTWU8NHr
	8tZ+v1m+4dOB4+HWdFxLKlki+ADLJKQxq/h6H
X-Gm-Gg: Acq92OE7X/xRsWtZZ/vkih/iRuZE/a3gFevN4gXYXneahk1Yr6ZjxrckYP+4cGp2sAy
	EzPh/LXay+KtYcJrDmfw3YfU9hd8u26eUL1JvqhDDd/pw0tUaWoQSqbn6Pg/mDtJGuC2nRs99Kd
	cGAoGMIb8ck/CBVRtYCYtkLANEaVqtLvw80EoTslXH1LV7Y5lmwGEEKxTYYuHFSRr6K5/pJbxPn
	PuAud9cnbdYlJN6QN1oSwT1zlCYBjwISI2UVUSY+OVCr8bbKbkU2bOLtMVzJ5dFUSrKFsGeZCpz
	VU7g8VOcgArnF+biXNyM
X-Received: by 2002:a05:690c:6188:b0:7d0:5c67:200b with SMTP id
 00721157ae682-7e053c6e5c6mr108864457b3.0.1780340478662; Mon, 01 Jun 2026
 12:01:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFftDdrzV2xC7HBcgS8EPb-YewJyCK9uos4crXOCh5ONm6SxSg@mail.gmail.com>
 <CAFftDdqp8b5n21hdEP6w0-PK+CoG7mmQxgrnhpBLU7-1GZxniw@mail.gmail.com>
 <090a355d-3680-4113-a542-ff3b1c565f58@schaufler-ca.com> <CAFftDdqvvqrbm=+XsDdkJHdm12jxK9799_A=Txz6Q5goYC2ALQ@mail.gmail.com>
 <ahoaFz8DMMvWgqL+@mail.hallyn.com>
In-Reply-To: <ahoaFz8DMMvWgqL+@mail.hallyn.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 1 Jun 2026 14:01:07 -0500
X-Gm-Features: AVHnY4ICHP58idHeuZWxO_IeHj36zmgKmUPedtG3np4LABX7OFZlmUkRRLn3apQ
Message-ID: <CAFftDdqyTrr=wS2hUT1EvAqVsbegPRh9Y-rH5S3VEpvXbJ6QRg@mail.gmail.com>
Subject: Re: security_task_prctl: why -ENOSYS
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, LSM <linux-security-module@vger.kernel.org>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

<snip>
>
> How about security_task_prctl_allowed()?  (Mirroring security_uring_*)
>
> Renaming the existing hook security_task_prctl_handle() also wouldn't
> be too bad, but that's probably more churn than it's worth.
>

Yeah if something else is already done, I'll just copy their
convention. I went with suffix _check for now.

Another possible issue that I think other upstream communities may
have with adding an additional hook, is that there will be two hooks
in the prctl syscall path,
I am not sure if that's a show stopper?
