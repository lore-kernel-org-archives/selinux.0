Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795126693;
	b=bDC08q5EZ/ErlpGTvih4SYmOrTaU1ld1pvdZCf89RZMRPRQ2WmMlxxjlsSqhAyNM6RWx
	 P6FTV+MsdjkdXJXjzLbvIvqrcwfNW0jz6aBkg3grZSDP8iKEflkbX6Q602OOKKbijiPyj
	 SJ48AdqU26KWZFNjDGjylkAEr81auoAnwFZmwrdi22rNdV7Wb2HMgGBbBvnGUo5eyrW8j
	 AKDSYykPsWJ+Dn8aoYL9FHMMMJ2u0zijiDC7Mh4uYXxkfmsPfQWgq49yBCq5X+y4MH3xK
	 c2f0OJJ5Bu/M59nkwyD4IRemeJ6cRWJmmZpk/SAoOZK6dzfQvyreQdgMtWeIk2DGsOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126693;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=gA/aemZzQ9sPBTs414mU1ORatQGaaPpP3nEzIpSAJk4=;
	b=g6w8MBMg5kB1rVCHTuj8o5Y70dw7uX1lffbT0wzSBbr3KU1AGE4FVQ8EsbfYMr3A1Hzo
	 hKcDb6Flz70bKm6NkEflph6M3dgi3N4+ttoV21DoRHpQ5SBUV1LH6UMn8MYRFlUsjJy7l
	 y+r9nl8/4vpLtgHhwVuPMZzf5DDIJEMdAkLJ2KIlI+zmqJJFfgQkkWcT2s8irb+tIdFTt
	 IVck+tf9Ha04DThzOW/hHZCj8+aWhI4DdXswD+yCkFp2/tGdkvO5UEB/L+d8gc12+kFWy
	 RFkBihFUzX90iagFXy/WBsfeXgIccgRtKJo7Mcmx2dDER1roA7RPahT4JB++Zaqx4vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=ZldscqM+;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C57606A326
	for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 22:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35C57606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=ZldscqM+
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6ba380cd8dbso293498a12.3
        for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 14:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795126690; x=1795731490; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gA/aemZzQ9sPBTs414mU1ORatQGaaPpP3nEzIpSAJk4=;
        b=ZldscqM+w6KlyLRO82OGvVKpcNkMDSlzQnlKm1Jy7mLtXSui+gU2v6CYgiVnnKXTdn
         9fzbQjkCRQyAbCXyKCWlAVC5b4UoUNY01GgGaQatwW0espx4lbEMhEWhqL1PnAv0TRlJ
         yWN4IxNrJApTOAM6TRrnJ4nhKUWJhJH42cXCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795126690; x=1795731490;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gA/aemZzQ9sPBTs414mU1ORatQGaaPpP3nEzIpSAJk4=;
        b=Nsmrmi/iEgdL9OjW7PkdyuOMjdXpjMTr+Of/3W4xPjUzvESL0Of90GzpikpY9rxtjB
         +D15GnHIxiz7vC5vgAcNh6/XO5U+2NhvKbY6nrYblRg2t/rraWV9eLrJVLxsuvdh7P0c
         WtMEM39VDdo2ykrek3o9cJGhPE3FNDsvFpzxaenhY+FIuafsIMPu2OX/oxQzQh5cDlcc
         PnX2VlgzS/LMxpdZyy493M8VdoWDik+xgvqPrVAwJ5oRsE5MO0+A5MgcqA42CxFZwOwk
         W7B2wDgu8+WbzXJnsf1I3qVK8Pf69Hk5sLM81W+I9L6p4kkELs7sjrAj48i/N7YoZS5k
         WgkA==
X-Gm-Message-State: APuU4Z/NCpNioF5fzS/hy3UV5aZjTyjD8N5raW7sT93GntQ++rIYrzB5
	uZNFI2qdDZgNyGVZoH0t6uP3Gxnlm0XUb2/moclmtbEKc5uuU1uIFm2ZHNtkql2F6RzL9RcTlU6
	jRUlTkkI=
X-Gm-Gg: AYBFou010je+ZWP5lcVo9b1w7fKyLot8VQeqlXVVCpDpkKiLwyZb3zfDUmwiHLoanHU
	SCD9Hc+Sw7R+HCc/LuE0fSyuzW0lhXSpUlLRLQcAAqrifmNQ6rG3lpZ+HsHr4RE2JjLhqskTUjY
	qmMGRO87jj/mBKW3A400yq+ngHgmSVdVOacsAgWhAgKLxE5saZUv9yyASvr0g6lICSvdJUZMcNl
	idHZgm4tUYyOA4e3KmKRUzBuaOXghrXa9ITrUwqrtfiRpoKwNknGyZNH8f3BFQqF+k9YOuT2G27
	cMVoUEgzyV6KCI6iurNjpfaamomZu1t2E7DV2JIoJUiqL7bWdLKubk2geF5u9cuJ9c/Yec58AZM
	ObazAv8OV8Fx+yi/d77lcoclx8MyRGbJugicfVZxbEHy4eLrrJSWv2FmHWwhIp4hY+UxPb6Mc8U
	V5oyeMVdf+7T4RL/pWXfJbT9WQS3ozgPUBKX/i6knWMI/VS52PL1lvkckkJXvh3z4hyxvq3ZeD3
	kClyvMtOny2jC3CgEXNKcxGnwkge2RVHmm/RbhF167A9BpKdcF7x3yhBWGNBkmb192ZsJ1AB5Kz
	l3oQuOufh62y6LZQhes4CSbZdQp+hWqQz4+JyI/Fb2Hpq5GYimwkglx1t/AiVKcaImsj2/zTt6A
	EQp8=
X-Received: by 2002:a05:6402:4491:b0:6b8:69e4:3533 with SMTP id 4fb4d7f45d1cf-6ba37f00b02mr541950a12.40.1795126690477;
        Thu, 19 Nov 2026 14:18:10 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba36e35ca6sm389580a12.4.2026.11.19.14.18.09
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 14:18:10 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c50ac25cdd4so33589566b.1
        for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 14:18:09 -0800 (PST)
X-Received: by 2002:a17:906:fa82:b0:c50:4b6e:329 with SMTP id
 a640c23a62f3a-c513a5eaea2mr95509666b.15.1795126689675; Thu, 19 Nov 2026
 14:18:09 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <d583b944b32f1a6f9bb27005d628ba9a@paul-moore.com>
In-Reply-To: <d583b944b32f1a6f9bb27005d628ba9a@paul-moore.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Nov 2026 14:17:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjUjMpcaOikkbk-p9ohKdOO0yWX5KW7LGUJmGZcKu-gug@mail.gmail.com>
X-Gm-Features: Aa3M54o9ZC0IsT5wgB2P0cNNI_yXbdHzih86Soy1GWfvNitkqUbm-kcgwt__74U
Message-ID: <CAHk-=wjUjMpcaOikkbk-p9ohKdOO0yWX5KW7LGUJmGZcKu-gug@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20261119
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Nov 2026 at 13:22, Paul Moore <paul@paul-moore.com> wrote:
>
> A single SELinux fix for Linux v7.4 to fix a problem where we were not
> properly handling MAP_SHARED_VALIDATE.  Please merge for the next v7.4-rcX
> release.

Bah. Horrendous, We should probably never have passed in the raw
flags, and instead passed in the flags we actually use and have
already generated (ie 'vma_flags'). There the test is just

        if (vma_flags & (VM_SHARED | VM_MAYSHARE))

because we have already decoded the odd system call arguments.

Oh well. Pulled.

              Linus
