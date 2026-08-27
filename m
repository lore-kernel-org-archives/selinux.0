Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0FE3F1047
	for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 19:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859927; cv=pass; b=rX1yAdfbsWkSuPtbkHoRTY+G9RlnpQTHG8J6GOLf7Y5Lt5HkzjaoCneg4evv7sGMPoEwaM5hxYgZ7UdR/2J+w6jBcMyNjJ8N3c3vDLUI1147BxADVADiE6/tPO+bKatE9tV0n89g3I9WryQro0s87o8XD5DyUhWUCVlSARiy2Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859927; c=relaxed/simple;
	bh=BTZS4T+cdnf7NYNhHMI+iMvBQt25U/CewUK6/HyuRTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJW3LYcMwCv8j1DFppU6S59vghbr63qXEgA1n9wgICiuiDiqo0d55+2AFTiq/tSyUMhRlCiKrp6M2sn8MnGrfrUReepTkMvmlTmstfCoyeqKOHSS9SZVkN1KwIHq1+u5LgfHOiTk0n3MHJuHzTdHk5zjgJ/7C6hYVY7ZqIwGbV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=csgbI1e6; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="csgbI1e6"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8520161fdb9so348411b3a.3
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 12:45:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787859925; cv=none;
        d=google.com; s=arc-20260327;
        b=llM3olbcZSCDI9jROTROF0xtznBfMESBW1ubx6kbDRHF6h5Zfmk981c31oxQjC7tS+
         5a6B7jFJFWmnNQ8PW5YCjYjBMi2TX94rBPSNKTEI4Pxj6wn3pDtc5sbTp/nle60R83vT
         Lk0Iu4jWdPwRbRJ/2qKfl+zfGKaURgNawhE+lPhqBsDEu84p3Qn/ueIln9cftdiJY58/
         ZgVFpsIRYY5Z0VEmPsDBKE+7j09QdAcdkkY+dxfB24WqBVElPswA6ff04iYp/kf3EiTr
         eULmOiPnatOSWfQkFhnGGg0joQRhzvpdqQhTcbSiWdqwJlMtdLBjFkYjyldPGkitb7nv
         BPzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O3141d7sXj74SrVElg6dveMFPug26JPmhkzAP6CZxAE=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=ZWK2W26+mi2hG2Zt6HIrpQxI4SPg37bNaKrm1EoLcqYIYGb3QRdsBMoqLEwLLGbWfi
         kz9lMEx9ZtkQbSKDVHokvq08JURnwvMVuZy1J9z4IkeUNePfYOUKDTYMFRQ/T7wkkuqY
         B0tpQ6Q+B9ZmRymCvFA8127gzFOQE1iDRwuY/Y1G/uSR+TtYosZU2sBYA+c+FtVAZzqv
         D2KRGHvzHSYqolkNWOKUR9F8hpPRA/WQqh4RzVByIuFflZfEi+X+3TatLKOGNv8bXxo6
         LLTL93lcDLxJRXW0FGBCW4S50QCNXLjhMalatnbCnHQO3iMZyRFq5/GaXd10DLUJ3Gnn
         cv1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787859925; x=1788464725; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O3141d7sXj74SrVElg6dveMFPug26JPmhkzAP6CZxAE=;
        b=csgbI1e69KuXx1HsIUbMmOJejgCTR1sydzf6HJgg4j/KtocK4pbgtr8ffL1X0ZLoIN
         1EHVzgS4pJ/MRgIop3TiMpGQBCCZ4JNUt8Vo10OWB0Xp6sWVPZp1uDMhu/pGf7ljnxUJ
         8Sau/q2eu0gxERQEw0B4vJKbI7b1U2SAoZILBIh4LQwFRGSB2EoNNRTAvskhRDoURZun
         GiwXVVHzqDOLsgm8WOQD8CqnkGa4TR1PnpCXFFryVQ5YF3+H55WObE4ZGSn1rW7ag3Hy
         60/XktmUJRoWC1FgH279ktIfe9htTqE1UAgR6RKbYxXls5T3ChwcfbGsEmVdhrqIWb0d
         ccWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787859925; x=1788464725;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O3141d7sXj74SrVElg6dveMFPug26JPmhkzAP6CZxAE=;
        b=D/TfZoAWor6YaIoPKg+SbhiGAm889BWW2+mf0c8XfjTwGa68ADrTIMqnT1eVA+okdy
         xH2YPrDgVafgBGqfqscFIAR0JuWsEHAJT9U/AFA8Bg81er466t8h222o1wbDAtwoBTqR
         v2dtzJJxM2DIXCvPyDZergkwZg7XiWzwxe67+pRmzkgSczsulvjjQlEEerN/ftncWHAg
         Ugcs3x7cBEDns5rqB+m+pY3jlH1h4/rYhS8N7ac/A+vNIB95EMO7n/SNaXd+Z2wIEwWm
         kDLtp4IGjD5omyBuY9rHYlux2CVLVzgyqZjXzstsnKTu4cUluR3aGewKipgQ8fBfo2xO
         epng==
X-Gm-Message-State: AFuF++mQB7CZYjIG/8Yj/QOunEE9QrbR8HufQPFs97ndM+uqcjwd9/nj
	cpLSvGsAv7lHWhFXgOckBvNwIpvr44p1FcfgR3pz4xdm2GWCYNE29zioKtBYcWAQSu8nSASjlRH
	WCYtxskZvOT2AQneFS/NCeRLip67eYZeC7srq8yTIbQebHnWyubtP8A==
X-Gm-Gg: AR+sD10nC58vjJFGBzrAH5nYsebLgEql8zR0fVtt8uP1fq77E8Gn0agk3whgKE079P3
	erRXhUKnMslhG6ldaPQ0JXoqTTilkCjLpSjbFzFGeI/E26gl7Y6tIo4PfdIV9y/d9hOLTgY4fMS
	dtghOcIw2SRv5ccEGz9Ipr77CmUGLWP106CkbvRAAQ5eHwdcnkBMI6icY7wpohTdvFOU92QOMSr
	bV9g8IhekCS4CjDtzEadBfv9FR3eD9cl75CvLThhwmHl5ilThxGE/TcTYV2z8o6H+burcsjSnnE
	42fXCLeEXbCtREC+6oeaEcfR5JP+msiO0Da0ZBlE4XJH
X-Received: by 2002:a05:6a00:f0c:b0:852:5f99:1866 with SMTP id
 d2e1a72fcca58-8562514cfb6mr3311725b3a.0.1787859925519; Thu, 27 Aug 2026
 12:45:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827151126.107545-2-paul@paul-moore.com> <CAEjxPJ5HeZ1P1XLs=EoG_F427hWhUphebVthr+MhnKPR5aWNTQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5HeZ1P1XLs=EoG_F427hWhUphebVthr+MhnKPR5aWNTQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 27 Aug 2026 15:45:13 -0400
X-Gm-Features: AcwNN1Xllgb_HEdknFgn1rBaB7V_-oPA-ke3WoYgIHv3q8L-UmktEWGEe0VBLUo
Message-ID: <CAHC9VhTzeB_pVuu8hzbwbefw=Xz4DCg=t7WUTJXGtj-XP8sL4A@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix BPF token permission checks
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 12:23=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Aug 27, 2026 at 11:13=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > Avoid multiple lookups of the bpffs creator SID using the token's file
> > descriptor when the same information can be found via the resolved
> > path/dentry (in selinux_bpf_token_create()) or the token itself (in
> > selinux_bpf_map_create() and selinux_bpf_prog_load()).  Not only does
> > this simplify the code, it avoids potential TOCTOU issues if the user
> > changes the token file descriptor passed into the kernel.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 5473a722f782 ("selinux: add support for BPF token access control=
")
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks.

Given that v7.3-rc1 is due in a few days I'm going to merge this into
selinux/dev-staging for now and will move it to selinux/stable-7.3
once v7.3-rc1 is released.

--=20
paul-moore.com
