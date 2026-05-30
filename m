Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7876E34B43F
	for <selinux@vger.kernel.org>; Sat, 30 May 2026 11:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780138988; cv=none; b=ji4mv9quPmuxQihTCO5/+6KDbC+FkUNGsNeHk7e4d9JM9c3iMcWjHs18ilNlQ1Jl93JjBXNmzxyteqxI5QSs4pkjbKKTXZ/LWRnr6e2FGbV0aVcjKZp2ypBkMtwKqMHuOzGH0UvKFmvRUPCsoslfEQ9dvXzghcPH5edr25b5roo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780138988; c=relaxed/simple;
	bh=AOPTURASo3pMeJQKhnoShamaFczVtNsCE54EbZpXG2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxmzLu6sIsiwSTTrp9YuaHIQhV0sxNZKZ+o9Jusvmqg9xSfVTRoZSlSJS7EJKFh9docbXAasVsmY+5J2XGwQ1iwAUrjltWxfsPSqlkAINRTJ8LlNun9TRAoaQdKwpAuHcDfCtBLE5B3cplQ8V70FvHeAp0DVvs+KE8JxRHUDyjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFTT80Sa; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFTT80Sa"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-459bf19e87bso8866999f8f.1
        for <selinux@vger.kernel.org>; Sat, 30 May 2026 04:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780138986; x=1780743786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dp/mGIPuzMQgF9N9UpzPuL55AQoFcQOM3dm4eEgb0Pg=;
        b=hFTT80SaZEFmT6IAFujqg4orXUijfTd/HE+RoL30Qz8RGXkQVCKXN1ZKHuQhiNEiSi
         ZW9Ml1NXDFDYyMovuqoq210VLb02XBgkfqL7oDAWbeZi+GCnhs54NV/U1xm56RS7mXuV
         raUWeb+QmhL8ugmEv/6GX+bvNDcfATNMJ+MZMwD+s01/9/GgkICbQNZ8up5ozFTinlMC
         yTgtnzK+U10wYkOZdO5rWD+Wul4XFbNTZlpP6enOPFurvjw9zPY8dzUoryTSFPPAmhFy
         VU0Zr7HNwbHWsrColySXgtcUHNDtZm1yFxGfytb9XfbqiHqFii2heRNaX2s0vdywk6xw
         HvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780138986; x=1780743786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dp/mGIPuzMQgF9N9UpzPuL55AQoFcQOM3dm4eEgb0Pg=;
        b=ZhMsQWb2bRxRMeCRzI7lHnSg1dqeYtNKLRb2G3I/VVSapHUMTyFTqRo6g2Ue0ghGcn
         EXMntcCzjrOP8jyT6ZIWuLUCXhG6xUes8RdtxtfzXs5M8u+xEA+IuxseUmI4a6GFRUpt
         zwRqEtbHZjdR0ugn9z47Q12wsa3sGpryEOWJKrAQ7CBYAey2hJ+uAkUAZyLMX7COARbu
         lyIYLqK9CcQw/HsZbXVSb6kN/jjm7wALbo/pL8cLWOvMaf/VbGYpDP8iHLF2W5eXoU45
         1/gJIZpyQwIZVAxP4zl0HoctMW0pMpug1uvqWGzOBWOjnbyWxrLxa/ZzGuCjWbrWjgqC
         Vxqw==
X-Forwarded-Encrypted: i=1; AFNElJ9oPXVJ6Gifj5A10LTMTE0lHQT7bOy6yL4RQaQHC1+hB7oyHdHkAn4xW6ykX8hWOCDFdeTu//1m@vger.kernel.org
X-Gm-Message-State: AOJu0YwkQMzWNRyakcRzhWHn2H7WWM/z4EW2AWdmBE63NDuMAb+4GBIe
	hI9FtTARgzu9KtLcZytzsbiSZvc2nNnb/ylnHSVxywmDvJ3uQqy3R8ok
X-Gm-Gg: Acq92OG81TT5B+YiXIo5Nv3+vxDXL0EOg6jxqPdW+oYR+7tvTfRC/zZQ/aUlZ12w+0n
	2XjJAiwQ9GpAdYK1HhlC6Hhs6M671ICKgY7pAnRLoHB2BdvMDvey9R4nTEbMV1CA1FUutr2m79C
	WrAj5WpbF3dhZCxa+zBEWx2ba34Ca191p/g6ktvhL/5G/3F9Klvu5cqk2Vsf1n63xszkjr6gVsC
	dd4F2PXY3MQcYdqq93oUgFre8UMOUbXNC5dhN3GLGPkTUD/sMry4UoxlzPExpYkP7Nks/KxZgnj
	IpLo78FKJ63QgzpBNN3bJqpFkLPnsQ4NqyAnPoH2pO27MG1dvb1vDAK5VWHsz9q4x/A9CkJTN3q
	PiowxePKihFoxrfBKr4aHESAEbl66LLorOunt20FpoNPMhfyAYDq4mSMv6ZPg6qSlBRk3mvfJQY
	+bf5bgkzJLF43TIqppSs9Chzk0g1ovl7nnGRTinOOtuv7Au3sUztIirEPRThnfl7ihgtfIUbDWy
	5wLc6829g==
X-Received: by 2002:adf:e00b:0:20b0:44e:902f:e341 with SMTP id ffacd0b85a97d-45ef6b4f949mr4179217f8f.20.1780138985680;
        Sat, 30 May 2026 04:03:05 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34b7d6bsm10805363f8f.10.2026.05.30.04.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 04:03:05 -0700 (PDT)
Date: Sat, 30 May 2026 12:03:03 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 selinux@vger.kernel.org, rppt@kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Ritesh Harjani <riteshh@linux.ibm.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: Re: PowerPC: Random memory corruption causing kernel oops on
 Power11
Message-ID: <20260530120303.1b441fdc@pumpkin>
In-Reply-To: <CAHC9VhRAbCAxg4swOCBT+nAUaqRPsdBuOa+nm=539ejpN4wmWQ@mail.gmail.com>
References: <03e5151a-f420-46f9-ad5e-109420132021@linux.ibm.com>
	<8f0c86f7-eab4-4e82-97c1-5d190c390770@linux.ibm.com>
	<20260529171855.7966b752@pumpkin>
	<CAHC9VhRAbCAxg4swOCBT+nAUaqRPsdBuOa+nm=539ejpN4wmWQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 29 May 2026 14:23:06 -0400
Paul Moore <paul@paul-moore.com> wrote:

> On Fri, May 29, 2026 at 12:18=E2=80=AFPM David Laight
...
> > PAGE_SIZE is not the length of the buffer.
> > Should be PATH_MAX. =20
>=20
> Yes, as discussed earlier in the thread some additional work needs to
> be done, and verified, but since we are at the end of -rc5 I simply
> reverted the patch.  We can chase this down next dev cycle.
>=20

Emails crossed in the afternoon...

Like many of these changes the buffer size should never have been PAGE_SIZE.
Clearly here PATH_MAX is the best way to say 4096.
But I suspect some of the others should be (say) BUF_4K.

I wonder how much userspace code is left that does 'char buf[BUFSIZE]' and
just assumes it is 'big enough'.

-- David
