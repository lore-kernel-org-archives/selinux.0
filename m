Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792518378;
	b=muM4stTnAFnKgoiD9xfOHf945aK7e7kopJy1gG2cU/tAgJG9wQCCm8fx9gP0ilHBHLs2
	 z1OrI9Tkd5lyUa7+aXBdCSkO2s/r6Tpa+Xi7EOmX3vw4Y/t89eOQjofbRlYGfKtU8ft6X
	 EpVtpiRtVq/YmBFBF10VXqONT4a2da+1DTKQgbfuQlFsQwA9wqkfxDAcAAj9yqUhhb30T
	 BU6DS32BBPnd9lWb/dLdpcE8hmd4YouNyhc1rHfE4kZ8o7A72LStSSgoSiY2sdeT4KVvk
	 sj0RbvYYOzVUjXKOOlcNZkzDxa9MahJm9XBitrpFAgag03BARHTOnZQtCJpvnb3Vdjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=1W6ZxOKi2qSCeJDVqvB4iEBPeOp/rtiHrYSmc2QevrE=;
	b=QM4RXIy8mAZMfJoCf5tkp/VZ9WHHKxtuwXBq6l3uztpdtsrBsJKGZE9FnWEkoffGS0ML
	 IRwnBE4HoboPrffrHHto9a2hz1mSeI4aFGm1PL42P+3B9wKKz5fCyiwlKdHRGMG8ErmhF
	 N4wrfY0hUzH/m8hvf911I+o2l5d2Aftyr4FHAiTee74UeVoMjtr9OZXDqyTzyDK1tsZVI
	 USPgHdm39iuwJNvmE4BQ/0mh3ar7Aq7l1RoaKL1yXn7t/ES889lnnRAFtCaNYhOj1ABbc
	 0r/uOq7Ew0JAe4i0Ant5v4QbV8SJKOB5DGLYfqVJnVcfojZLTU2r6lS8V9XPaOrmpTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mc2ra4zW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21971606A319
	for <selinux@vger.kernel.org>; Tue, 20 Oct 2026 17:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21971606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mc2ra4zW
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b05bf699easo31329997b3.2
        for <selinux@vger.kernel.org>; Tue, 20 Oct 2026 10:46:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792518377; cv=none;
        d=google.com; s=arc-20260327;
        b=I/rov/JnTDQQiHfiYV4v0mAnS0qWDJYe90unrXrO2I/yp9bQ1IsIb1lv3Ce4iVgytG
         Pjfr56OrDzg7GYXe29CRs0dbBdjYEOFwxYBs2AUz+akShtYie9uhfb+bJewTX2IOJQ4W
         +0U0JXW5J0rCIu9IF/DMwsI0NBkJgsZL4eRAyApiuq9/WQ3BWgIVXSxtvaf0Vc4Dsdv3
         EnCBshXMSesGDB4mh9mOHCzf+IP2m0WfYYFgzA22MGvx7tTq/qzq/nog4lVvWTGyTGX4
         GMUx1LVoBc2iER99iEbpiLPLm0ufQZcnDFc4ZAn8U9QKVPJ7Hn/mLrO0n3sgra1pB4o8
         PY1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1W6ZxOKi2qSCeJDVqvB4iEBPeOp/rtiHrYSmc2QevrE=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=qTo+ZmkRbI2FfnXPDsDkWFZPpUMwsiXrKHcG72tPZkQVCqep5h7bRfiBD3O0lKSjIX
         AQLQaKApvTxciaqmg5Zbg6o6kj4ouLeTUK01kFIftOb4DcI6u3ahM1maXjbOgeqG24d3
         FTWKHGl53uKmqATNMGN5kGG5CNbURZuW8+klyp/dYc2BpHOsokbcxUv0vkVU6hAIAynT
         dgykYyg8zLG1tsTKh0JEFwnY/RM3rtbcKDsYQg/pXbaEk3oGFuc+735Y4a/Y8vXWlh9g
         gcKb2LI+UxvrLT0Y7JUwmAK5c2u1m5ifWdpWCGYElB0YEid3f0i0x8ACptS2JRg9HZT5
         gDIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792518377; x=1793123177; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1W6ZxOKi2qSCeJDVqvB4iEBPeOp/rtiHrYSmc2QevrE=;
        b=mc2ra4zW4dCPvwkwFLSrWYRzNrSSFx0nsZ0NhrzqAD+EWwQYob5hWZaSJKDAr/RqEW
         sYBXTJ/sls9oFKkNLYEuPTgIJe5JCY6aH+krF4a7i6Fk+QNVgiayRljbqcdt2lIOSAfi
         hy1aUmuGSePAnQYxmmbYNDLBgr0GLuRgoTvFzeoqdqmELoSPB7bagD6gMjDU1A/ZPdIQ
         4g8sEO2fRME4v0DIoomu7moSgUGws2+6/w4VW8M9SUHVnsmXoeBPOQR0OEmFLtaQ820t
         LNJklk+Hszrz1/ArFohMtW/pzgcfciNx0BkajDuo70b3AZjcblmx8X1KddDENzhJh4am
         5UPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792518377; x=1793123177;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1W6ZxOKi2qSCeJDVqvB4iEBPeOp/rtiHrYSmc2QevrE=;
        b=hpD29XCgOL7zwFV8vRPo42Esa82j7va9JAPtrj4LqXHY6kjd7BET12bGd3tOa7LcdS
         kqc3HZ4vGTqmXAfi+qo+MyxSfxp/hH7ITUq/sJdAOwjeFlfTpBHG+CYwum86lz+GcThU
         q7YbMAHz7xPzEub+TGcPb0pkq9rjSqUmJwvFIg/ZN+sU78UIq6sPybarTbSMN2gB2VRM
         g46aJ238vh11N1g/EP/6CvbrcTG+si2kGlKA4YCTtaZ3AM+WVuvkGWBBm39svxjViRwK
         vgZucyfZz5i5wZNcpeIm3qWMYACVxmK6ptXV3rsFLeVTqS87pEXwIykynN4+nl9obaz+
         J/uQ==
X-Gm-Message-State: AFq9FYL7dyjyrORQ8oME+66VSA4kG600Cn7jhFTgHnHgVNmlJ8Xo9ljn
	VNICcHpUS/kK1NT+qzBchCebknmvevg/uBr/IDDzG0o1+Q91KXcXj5RZl5j2PNrZC5l2CHPxLIa
	FNn24BFaE3pXPyHsWxJWiK6hG8rL76MM=
X-Gm-Gg: AYBFou3UYlmxF2bcsKd18N2mwzFR0J30MJcNndtBLqdlqnsNqUIYCaizjZx5G7C5sGZ
	nydW0Hnw2NDuXha4HQXvsWgnSGZAkkE7aed3f5Uwx9Ux5FLlV6xZegI5qazTHFkKhJJBq1i+OGo
	co+tcl5LSG1bz60YXQHKjgaEOXkenNHRClosOivoEyM6sAp1a806rWZ4mS4xdgc9lThHMzF9tcd
	512zB4yw3g0OGqSIksZyi/w59ajLRFTeQ2J9HywkKfaXNc++RUULmVoStw/wEh00zBM6vDXYMHd
	FzPAZ8z6bhjJYrl5WP77EnPHzWG/X8xecQQVAidTA7dlOqR10SvLhJ0QOiqLxpOSY6k1nJmcEBs
	ewDsb9tK0
X-Received: by 2002:a05:690c:6203:b0:8b0:ad62:19c0 with SMTP id
 00721157ae682-8b0f21b9343mr41197937b3.39.1792518376992; Tue, 20 Oct 2026
 10:46:16 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020154943.2408020-1-omosnacek@gmail.com> <CAEjxPJ4O08Lp-s_1V5XbmHV4PEX-isgzXTaeDym5yi1jyeKJSw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4O08Lp-s_1V5XbmHV4PEX-isgzXTaeDym5yi1jyeKJSw@mail.gmail.com>
From: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date: Tue, 20 Oct 2026 19:46:04 +0200
X-Gm-Features: AclHuK9dwLbot_S83a9N9lpVOE9M_nFPB7FVYKdJ3igiQe1gZYEFlQhtipMYvF8
Message-ID: <CAAUqJDtbi-_WCBEKw6EMjD9FCg3RKsTU2npCG2_m1t6B_ApE8w@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/binder: add missing parentheses in print_trans_data()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Oct 2026 at 18:06, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Oct 20, 2026 at 11:54=E2=80=AFAM Ondrej Mosn=C3=A1=C4=8Dek <omosn=
acek@gmail.com> wrote:
> >
> > The newly added casts were meant to convert the result of the '&'
> > operation, not just the left operand. Add parentheses to fix that.
> >
> > Fixes: 705ddfdc5ae5 ("tests/binder: fix compiler warnings on ppc64le")
> > Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Not new to this but I did wonder - why "long unsigned" rather than "
> unsigned long"? No real difference, just used to seeing it the other
> way around.

Just to make it match the order in the format string (%llu -> long
long unsigned). I admit it looks a bit weird, but at least it
emphasizes that the cast corresponds to what is in the format string
(and makes it a bit easier to visually verify that they match).
