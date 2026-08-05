Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C053ACEF9
	for <selinux@vger.kernel.org>; Wed,  5 Aug 2026 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785943865; cv=pass; b=frka58vmJ/8nBxAft8irVvY4MD3k1OXeIqqmSsF47Nh+5xjQaXLpgUy9SX/W7/vxJWLSttEp8Sw7Aa2ZNZ5OzJ+Is94taN83v759uV2VQlS833FGqLvdWe8t87xOejhYb4g2NEFCXwMvK4P9WnwBGHKDaEEEbnuIINGJqdaqSQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785943865; c=relaxed/simple;
	bh=5rkPYIlyLYoiBU/6GmtpJCM/1ATD3JCeP/9upJOtnU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbpsIv5ftw+uA60NPHfF7heTefplLneZ/sPyGhNQK4qd9UlsLmXUJcmhcecXD4suGkU/XUzk4KVpPeDdlutQBsgCy+RQm5Z6SyjKj77QzKYP5kVTHB6vRH6FB+liYkYThR/X9zmCzEBkWI0X8OV3ayuT9wQolk1I6f32UtCNkEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=X3quGxpH; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="X3quGxpH"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc891373e0so14733955ad.2
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2026 08:31:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785943860; cv=none;
        d=google.com; s=arc-20260327;
        b=f2JNpqgFeZtxOXIKzsHCAHwOQcdIPuJUPj96nEtkJaMgWbhLltAWcsMI9KZ4D89Lh0
         jMJi12GSWFR5FoiBZsUuz87iDGUTMSP9nTfYTOTKap0bQGOyB2igBW262TF0RRLDJ7oo
         fUpKMSKWvSrhhtqjRBiSO01DETPrcGACoxJwTPEXlS5ec1uH01UBmIjtHob6GyiVcI/w
         +Kgdmy+5744d2sZ3sEnDbrgRmWn9hFBX93Itix/T/i3dwtihk5AtZLmOdnW2m8TxQ43g
         6yKcBm0ctYpwZt6qgh1EjzAkajWSWfcE/ESq/ipxSbT4sPSgWttlAV3d4kNgIcQwfzBm
         ZiCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TOlM/XONY1KzP70JcmhlCUUuv1NoF6feyoiAXMyVgFY=;
        fh=5ofRj+SnLoVfVtjU4Y0GlzGJ4hCXaxwIHgoqfjuh9PI=;
        b=PGyQfDg/NwpbZKEPihYqQTqAMnHjsFYW2Gs34SPv4ube6xhnvDXgKSAWqibfE4yAI6
         YkN6Yh9GNEo2H+m8ZLjGbEDSAva0IVFNe0AOsB1WZebbWEE7nt59OzZ1pp7tTRnhUPYo
         mEJV5oXu218jiTu4nQxqpDZalqBbnDU4ni3aa5VHWwYaMFLBze2LMg4Qk8dV2BuAr9j3
         Wo9SfXBf3aabdcibr/wPpECHid36G6wOBE14S5yFmpB7SgMQLRi3deRlFPKHQzDylblS
         x6FHkDuKJITsrgKAxBr31qsIFtZ36s9+VbW3sM6s+XUtDiaQNE6KI9NL+a1M2tZjKf83
         7nOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785943860; x=1786548660; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TOlM/XONY1KzP70JcmhlCUUuv1NoF6feyoiAXMyVgFY=;
        b=X3quGxpHgOd7F1LwMmscN854Xb4h/pC99+YZ5GZaPyA9/Xab1R82QRLhpFe3Ns1e0X
         /rTVGNaNrV6RKbrKibtP5V/vNbqKzZwTrT4ZPKoYFW3QjDKMl6BPrQjZXQ2+mIkptRgq
         8VanXnWyHZSA75RPr2OQcENlETHrdt/xN7jtmqrbW3Qmf/aUiR458Rzs3nFEircH4php
         JnwgB8ASdX5hyUiWetxgp35Yoha0qj+jZJEFvBtchfWHo37vcM4LzNIKyqVPIC5CqwoR
         UaL2R7WcnaQgW3J/XMJCc4ioHBCpQ4b8N46og6gU+kMFcEot27Ti6FyIHplU+w7BQ13T
         +Cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785943860; x=1786548660;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TOlM/XONY1KzP70JcmhlCUUuv1NoF6feyoiAXMyVgFY=;
        b=Bb2Kc54EOOhAPcaWjTGOzN230y7q9F0H+VpHvSOPqfa+0EjrlajK7SDmpqzmzroaou
         eF3oC1aHQWiaLan2kKIUWIhMwQ8IVlSzM8/BQIxnaqOB1Ym2RSIKBh1BXkWdRFX9AETd
         NKuNTowwr6MP6UJecsD5K0IYAfzinSgumnvDT2MfQ5Zr3n1gUYQ7bRRVfP7Nu9kYFFDz
         yyVU7gmInpXCOuYWni0+9unMQnx4yx/E7ty3WGYWaP+ti0/VqPLXz4mxj/tEBbhMCmou
         UNP6IdyudThc5VXKsRe/7QsRNu0bC9lgUksGsxcLGGJbNa141iyfZ/M/q6OaybxNkBLS
         SjHA==
X-Forwarded-Encrypted: i=1; AHgh+RqVdqF+GKB6g2yttSOxB8+xcARdp17rw1YGjHn+nE52gvB+7x+820/fOngSXfzUfWf9n0l10Wbs@vger.kernel.org
X-Gm-Message-State: AOJu0YyQAjYc/bu/nkXKpXA8oggMz7LAwrY5zepmgK983NGEOgdRkV+A
	gyb5HhgNbMYv7yS8N5aQfHietYgTIf1JCgUfkV2DtrPO4T1yzYFabJTWglFFB3xKGEB1TPHxWF/
	rnL9UkuqQK0J6LJUX9aF9vonHUzgRAo+AKvjsvU4f
X-Gm-Gg: AR+sD12uUroFRq3nNKkz8A/Se2q85QMZU9Hji+AhTxesjYcpJlEecGQgfqryv4O0wP5
	59TP5JVAwElpWo8Hq9MDZsW826PmHFW5ICOwhMtC6IJ8DTN3nFIBRtsgynkdjP0TReeU2yJNxYy
	cB3mf68hIbQtnJHJgFfKzfLFxex7KztaXdfMOI91iLxRny3LSWLXAdsU1/kSmn0Up2fHKH5o/MF
	AHAT6EV+StUaJTkPHhbzYt+6/sbncQFNRTv2/d4MaFvLGj0Jd4y97PF5b1Kcpj2LGUG06W7MkF1
	ongOiqMrjFfkNpQYhFgU/n0YknHDBYXUuisLILklp6Lc
X-Received: by 2002:a17:902:e783:b0:2c9:aae1:a611 with SMTP id
 d9443c01a7336-2d0ca961afamr99172305ad.23.1785943859961; Wed, 05 Aug 2026
 08:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804135700.3713-1-stephen.smalley.work@gmail.com>
 <8335d7b97813e178446e4e8b37e8e961@paul-moore.com> <CAMgFczBaRgj=aH4A-Bd9Zw12Kmt2ymtMQwpaUW7rOk3FpDJenQ@mail.gmail.com>
In-Reply-To: <CAMgFczBaRgj=aH4A-Bd9Zw12Kmt2ymtMQwpaUW7rOk3FpDJenQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 5 Aug 2026 11:30:47 -0400
X-Gm-Features: AUfX_mye1O2kmmDsTvpLMPw1byDRQQolItUNAnOZj4uxy9AFHjU0luw0aiH8aiE
Message-ID: <CAHC9VhQmEkeN+ZwApXnbak_w-TUJA53o1EEhtCSf56dDi8OvpQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: check level category sets once at load time
To: Jiri Vozar <jvozar@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	omosnace@redhat.com, jhladky@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 10:56=E2=80=AFAM Jiri Vozar <jvozar@redhat.com> wrot=
e:
>
> Hi,
> thank you for the quick patching. I tried the patch and the
> performance fully recovered.

Thanks for the verification.  Can I add your 'Tested-by:' tag to the commit=
?

> =C3=BAt 4. 8. 2026 v 16:57 odes=C3=ADlatel Paul Moore <paul@paul-moore.co=
m> napsal:
> > On Aug  4, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> > >
> > > As reported by Jiri Vozar, commit 7edea6e8c8e8 ("selinux: beef up
> > > isvalid checks") introduces a new loop in mls_level_isvalid() that
> > > causes ~89-94% throughput regression in System V IPC message queue
> > > operations (msgsnd/msgrcv).
> > >
> > > Move the expensive part of the ebitmap checking to policy load time
> > > instead as the reporter suggested.
> > >
> > > Reported-by: Jiri Vozar <jvozar@redhat.com>
> > > Link: https://lore.kernel.org/selinux/CAMgFczCi2Z011dNf84Amc0Q-qnTt0+=
VUjWY+Y7zPyXdaH35Jvw@mail.gmail.com/
> > > Fixes: 7edea6e8c8e8 ("selinux: beef up isvalid checks")
> > > Suggested-by: Jiri Vozar <jvozar@redhat.com>
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
> > >  security/selinux/ss/mls.c      | 24 +++++++-----------------
> > >  security/selinux/ss/policydb.c | 23 +++++++++++++++++++++++
> > >  2 files changed, 30 insertions(+), 17 deletions(-)
> >
> > Merged into selinux/stable-7.2, thanks everyone!

--=20
paul-moore.com
