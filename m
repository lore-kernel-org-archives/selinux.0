Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793994746;
	b=YqF5Ep1Ca22PTg2ZNuTXiMc76Ht23c6f8qUB7qp7T0y+vdUc1ZmhRDzHCH36j0qE1lgr
	 gMp94DFdNCoSKwpfrVlYQNqtMFmH0CZLxJ2NaIzLoCYeqEkoBhA4uEa4VyrF+hJdiQPZq
	 pXhaLlkrBxIgS+3dzFTlsJyquVFtMWyWIIJ/U8M4LV1+geH0T/H3JpBkDXHq5QopQ+eeV
	 NPFi7y4BxS4e6DzH5AeLAfxuTUJ6maiD6/hPrGgBhJ0u8LaVOOyzHL/VAu5DNRUfkOtSb
	 iNluqpRuUB3LyHPLb+GT7ZXPK83+wp8ZKEcHupLoBeEE1VpVnDmqb2g+sfU4X+HhAGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=UE3QqBZn9DiYD5jBl3BUL08QZCU928gbK/qfINg5z+E=;
	b=bT1vdxDOh6FDoSl0KgN+9lpueb1fNAz/OsNhA/I+0fZ1w8gIqixzvkxDeulTweG5LL3E
	 9hQqae00/YegxDRAvI4Y6GcJPHjNn+ZPHWrxrFCz1NKKHRImOr9uIvXx73Ac1cUexn7J1
	 ZNfgyoB+QD2S1Qt7tKBYASHPoNDOLucf1pQhZnH7lFF0NrYmT4sNvH0kmUDC/CgoAw1Ie
	 lkjcHxZ3IWepV6JJKfyBL1Q6IkKu8Pbxmeb89XaKX35wNRCKqGybJoSpsXyuRqxzS0j8U
	 7PCwMJK3AtOGAh3sr60Qm5vkfgNfEOAFO4OmEJjimcknCSMM1SYTkrvwgJMwDfov/Xg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aDodMtEe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662C9606A329
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 19:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 662C9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aDodMtEe
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b2d14968c9so10029977b3.0
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 11:52:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793994745; cv=none;
        d=google.com; s=arc-20260327;
        b=SIZKqByRlkF/i51cdE/PyoHf19FxIRe51hxuDf8jg6G4rzHQViFNA830YxBBuMOXhx
         4wX+dOAp7+Rv12GuWkpYre4ZJcIzWMRZnD29UNm1K/14UYTAwr8/a4L/3a68pnaiTYxI
         chfdIQ2uDpdOSVf93Bj96AsAIsxbQyJnA8TJBke+p7D6kOMB1YCMlm+RH/E19pK4c5LX
         KUbU1bY5O4RI7NYTdEWr2pJA2PYdXTMBY9iPxu6QBgIcg24t4G/gSqogW3END7tt211v
         4SEWK4NqOpaOujG1X8lQ6TBxSvRmiJm4mo4KswTXBqeB/+k0sj1hcY2CR1L5XdZbw9w7
         qKfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UE3QqBZn9DiYD5jBl3BUL08QZCU928gbK/qfINg5z+E=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=K9EwgAO6Mt4+loFG+GQ0qrs9SkWMHnV+i+lym1JneKcG3Mu4DSo7+l4qqMb8Qec3bd
         zSFt5bI6oLrlEVWFXbweKHI5XOcWwNgPVlTSu5cL7FM+p58WUtE+BYBXVhiIWc6rlemS
         x9dvIteJRfJtnpS6ACUyHXQ+TPRr9+687/60cnGMBIOXgJHS632I425JMgEo1FqfBBE2
         ILl8TQerrctNn7SsMd+UdA3gUbbmd+GugTKXEJr+om0Ee+IAsBrlpHrPQtXenqq3e8oZ
         up2db2MQD3NoqBweDo1cIdxcw1SjYQjxY7sf3t07LkOhJsfiBU1ASdbWHmUEqFjchYEB
         VgvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793994745; x=1794599545; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UE3QqBZn9DiYD5jBl3BUL08QZCU928gbK/qfINg5z+E=;
        b=aDodMtEewBDnjCNzW8j8bro5IT4X3wfDa/ykQpXpNj9pOLZVc9TfsrH7iyB3VR4sLb
         Q98Aq8Nd4iQSAHeL/OxvpMxL3YX7xv66jLpcLKxBQO4+Euxc7EvWoSe/HsW86bX3cVgw
         d7qHAnOyCix9Zq8yHcmmOwyYZ6mZXDSxAxebA9vpacXC+hZfLxvBpWR0krgo25xyut3z
         1nYT4xw8nsGec1MI0AgW0ObXuuFM2BlmmxCwpRaYHzbwpD+HFLNHZlxSLsHEdF2LIyJf
         1Afs53xG2gPbj18n4RT+nZ9sD7L6yVe0BX888R1DaNYVWlMOdCWVASQ6+n2wJsXGe4tU
         hsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793994745; x=1794599545;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UE3QqBZn9DiYD5jBl3BUL08QZCU928gbK/qfINg5z+E=;
        b=ydfMPaEus0dUFm5mTkcxQqoX4Ceh7BDjVE8zV4i8fWXlix9rWz5lBp2f8Jjh3VjJzR
         R8VD88pkLt6xpnQ/cEOuKmqgy1UcIZ3qsEtW93fqfgRO/h3mtP9SOIKUQqh7sWgrbQSN
         QXnuLf8CsVMppi4tmzufWineWMv7NRpo8hakV9T+9J9RthV+gDyd31geObt29foQyHMG
         udxPHAPfz8invHg+n9HPzQ/ABQ+ZbIX3pL81f/DjJ5SaBh1PZ/r71wCiF8R/wL8Nmk6D
         FKh0ldQ4Xiv0L9iZuWdyrw+ON990xfmtXkvT6fiCZyzVJbljEdQbBLl0p2TYYjlHgtrW
         BZOg==
X-Gm-Message-State: APuU4Z9JLYxmw+PIAPmaTlwNVMPoF0if9omE7GSgJZad6VdtrVIG/gV1
	6zCODa4HrGueOL4FrfWFB/rk4n0qNDy+8hT0MucEpf26xnH0UCdKxWNn7CLz1lANidEymnKCEOA
	/V7OuB8Nzs1Tq5FSMdkE6nHp+uyZBRSk=
X-Gm-Gg: AYBFou2JiMTePBGsIMmfb5j/90d2hiSNTQBId6uuy0fcbmAyD3Z1BOjWhhZoRV+4bBh
	0p29eLkZ95MSXpFD0kFTQpsjtOGnAidDwVCCNrcIrMsikzMWCQb6z+U9QwN9s0mhSAG6shxFOUb
	ZqBPmY4JPrAUC+uagY7cf8fkqdocxTbMnxnLwkpgGcHtd9C9Qc+Be4FPfV1T6MozHCcxlAymmez
	5FD9rEsXjLvQ80cyxTiSZDuG9rmmvYnJW1vGCMoK7g9d4kaBl14zPu2dmnl1sjWYvkaekpioIDG
	SQp0d449tiAOu1hctNPis3YjSUn7G5I7IzXVbP3pxcbNXFeHjfzLr8LMdC6xrx6X/t3hSPjFjP4
	kdaLT+2/i+iV7i9Xr7cVg0U4qqKgXbzsZUKjBFN4kQm0iDdKxhM5Ce2joB/yQsIWpanG/2trbi6
	aIXUDwgmIIeaO6lAnBe5WGaBfb7hHYw2l0dgjpks1Xt/LAA1/xNfYIFLW+Dg==
X-Received: by 2002:a05:690e:450b:20b0:677:deb1:2aeb with SMTP id
 956f58d0204a3-67c14290b9fmr1204855d50.49.1793994745140; Fri, 06 Nov 2026
 11:52:25 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106123510.76727-1-cgoettsche@seltendoof.de> <20261106123510.76727-8-cgoettsche@seltendoof.de>
In-Reply-To: <20261106123510.76727-8-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 14:52:13 -0500
X-Gm-Features: AclHuK88Cbwv1teRNj3wls3h4CFSIP7Egok4s-WckHYp-OXgEJ0eIQP6ibIiQec
Message-ID: <CAEjxPJ4kXB0FLWEHJ-xo3oRSd83viscc+jZkbmOhB_935Nbgxg@mail.gmail.com>
Subject: Re: [PATCH 09/16] libsepol: declare the cil_gen_require user
 attribute in converted bases
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:41=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> module_to_cil marks symbols a module only requires by adding them to a
> cil_gen_require attribute, so that a missing symbol disables the
> enclosing optional block. Required users become
>
>     (userattributeset cil_gen_require base_u)
>
> but the base only declares the type and role attributes of that name.
> A converted module requiring a user therefore fails to compile at the
> top level ("Failed to resolve userattributeset statement"), and inside
> an optional block the unresolvable statement silently disables the
> whole block, dropping its rules even though the user exists.
>
> Declare the user attribute alongside the type and role attributes.
>
> Assisted-by: Claude:claude-5.5-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
