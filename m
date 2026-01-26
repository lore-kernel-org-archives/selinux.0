Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495893093D3
	for <selinux@vger.kernel.org>; Mon, 26 Jan 2026 22:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769466822; cv=pass; b=CekKSdEmAbQ8fJrAlz2NLAFhQJQGUoOStxe+FQ5XIt1pikxDuE/ip9lmVLvKow2ERGBQeM4LwC21CAhE9YxXisVWpBDTl5vNNmS4uN8wj3yZ5SPcUF1DkQAkLuB5YrLrgfIqeW/MlZwbMJoVOJLzNC5oNO1nQHwXCXSTv/sfXjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769466822; c=relaxed/simple;
	bh=lqktNIYdTMjsWu0O9cUIJZqK41TShWavVm6Qx5DAnug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjNGGQXRVVKCcUctcKqSJcburcdPF4OcX3SpcNKpfjzVlfY3x5CGmt//bfUqQqKQZF/1s6v7y7RojaZLNiOKGffODiOJXUljkRA1CxZBOQICcGRW/+TSeduFufOeotU9fh63xPI+yuxkRGygwQw70h7Onti2ApcufXKGT1PyNpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CHOrEIw4; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CHOrEIw4"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bde0f62464cso1485738a12.2
        for <selinux@vger.kernel.org>; Mon, 26 Jan 2026 14:33:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769466820; cv=none;
        d=google.com; s=arc-20240605;
        b=hJ5LBijAedCLXlMbr0zfBXujUWPopxdYNAeHU3ShOr8aKFoWzlEyZVgIfAhkNoWJ6H
         /1nQpYR+UocCg9y13PA3dUWv1Dwo7C8TE+KYsj723D8D8+gIamuLbLliQlpG8iQlr0/Q
         Fp5Kl5LaAcfQ1GFgwaKHx7ch6TqJyLt9LV8fjZua3v/M9BCBoTenGUl4TSC7SYUF359d
         z2Wp22GqCtJpBIlao/L9ckKrRNjKxr4ldE6013Nxo5GSU7rKj3XBNZ4M5BmE+XyguDGv
         MH0YkbHmGUpahhd87Ejd8njiQLv5me8+L3zlN5za2wXU59yscpMW9MbE1lU13XoJebv9
         e+Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bqx+C+qIk11wWsgmR33KllavOZb/V+0+I/Nz1DadbxI=;
        fh=2JQpN4uFmSXagzD22wyV40wef6Kj1gfeGR2RY/JICJE=;
        b=Hfh7cSNDAc1Jm6zcMkdNUIk8xMTEeoamXDfbXC6d6gO1J/0IjbQX2/YA3II+wy+uF+
         N0YX2DVAq3tAqF3a28p1HKSQSeSEn6ACYOizaadPxW9uknFArmeptyhxJW/ppK/SctfD
         L42BJOp8ZZODShmpeznu3a5q2EmZnuovLsCta/CFSazxoiLKABB5LDF8PlIUrmKMU54E
         fvgIgrCrzZ/1Q+4g5U/hUTnvSz/FMIsk9YNgG+o5D9O5TmQ4nHpXssoi2uq2oSqKUaq9
         LUHNABYvnm6lY6/2bJLTdoQpvaRucMMJKawZOoK5RTZLp3AJQlRcAeAXASUXCEsKa4EK
         v2BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769466820; x=1770071620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bqx+C+qIk11wWsgmR33KllavOZb/V+0+I/Nz1DadbxI=;
        b=CHOrEIw4Wv29h3+6QT4reb/wOWcq6qriGJfMqVdSfjJRC+v6NkbxIMw5b3jKUjBjSm
         VePFbfH24Cbeq+NbnkQKYvW0h2W/X/Dvzk4jYiFACUD/R7fdmSeggpXVNdAUVCQfVUFp
         z+Rxzq9LBV5Wvr+cAVtlfURKglgzHMq5v8tzXPkR9TzjCxBTdnG2Zo57sl3qCQWA6AIi
         5Ja4UXnPoWqp5YEj51n3UaneqVwiavLJJiSqmYavlydzvDvPtXjZZI7EmUTON/cOvUtS
         DLRsw9/zJRlnom7kcHOFhlyLeJuBAGZjI9vstGkW95qC/78WXB6Kd4d2m5ASosAfSk2e
         Tftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769466820; x=1770071620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bqx+C+qIk11wWsgmR33KllavOZb/V+0+I/Nz1DadbxI=;
        b=OQEoXCguLEQzwDlTqziGezHY/nyJwYmCtTaq6LqIL9/+tywWKVnEKUPGvlGLO8wAkk
         Wj6ueiTNjKTmpgHMqXu6HYKUXAt32oqrzPsnHFhFPaycHdkO/raKuDQP5pD3c6DDVjWD
         uF6uJuWA+1K3WMYQfSL7vnar7ZVTAF5cRr+gLR1Y87GXv1QqQfzXcTU2Id/Uxgbi0K8C
         0lBx/CZWi+J/ZcYY4lxulyGyepCjFCbuJNl6T1lNDxHSsG22+c9z9/62q5ms9vJpFuqg
         W9TdtPZTGM/itikuJDulxrRncgVTFpJuGi1ianzwzJDY/uE9I0jxbgVhXEIAhhOAn2qM
         /ztw==
X-Forwarded-Encrypted: i=1; AJvYcCXAXYibcV3wu3En1UU+nqaM9evTaJ/7L9Azo6smp8p0Dq1dA/M9MgZ/6Ky7P5D5XUtdc7p5tgJR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/bN5bAG5R7oG8Y+pOS6v/Xhkc05pkZLHBedTFEC9WysPOEtim
	exGpScmiTsGYACrNBWM6NxnVHKuUnv+9O1UjUnZhb7r02LlHZXcNTMaZKAjTdiuYex6LnhIBKNa
	dRhN+ABW4/5iSmIOyIG99ZhIU+cLqBYSybyjPQJcu
X-Gm-Gg: AZuq6aLU0haVAL+HSSZqEmyiX1Vi7T5d3V6Z1z9GplSq7BLXHIgzooI/bFcVpb5HLKY
	3r7cU2anqscoZ3VEh3pRhd2UKFkZ+kid5/zDJWFhVUGtnhWxBJ+UtnqiJ2XYkywV42fO+HvK+tJ
	UjaMxijw4sbCosZmjqKpS4EU9Uq7ZZcUFW6T/hfCvjP9r8a3beJcHYFhI8/wKXC2MKwdN0312Py
	x1YutEolILTV/ybszWIBykb7PcdjGIIFmDM+eruzjPQp/NHbui3PozYUmLi5VQZ0qeZheM=
X-Received: by 2002:a17:90b:1e06:b0:343:c3d1:8b9b with SMTP id
 98e67ed59e1d1-353c4178d54mr5402949a91.19.1769466820557; Mon, 26 Jan 2026
 14:33:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2ec9c137-79a5-4562-8587-43dd2633f116@I-love.SAKURA.ne.jp>
In-Reply-To: <2ec9c137-79a5-4562-8587-43dd2633f116@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 26 Jan 2026 17:33:29 -0500
X-Gm-Features: AZwV_QhFYoGZJWFWXPGpm6UGxOEvHZUszb6YUhYdp5bqZLkPloc1U3Ty7KU9dDQ
Message-ID: <CAHC9VhQikhv+qCyQdnJguvy-qTkGXB+NU7=QZjw5d+WfyVxZhw@mail.gmail.com>
Subject: Re: [PATCH] xfrm: kill xfrm_dev_{state,policy}_flush_secctx_check()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module <linux-security-module@vger.kernel.org>, 
	SELinux <selinux@vger.kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 5:13=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Since xfrm_dev_{state,policy}_flush() are called from only NETDEV_DOWN an=
d
> NETDEV_UNREGISTER events, making xfrm_dev_{state,policy}_flush() no-op by
> returning an error value from xfrm_dev_{state,policy}_flush_secctx_check(=
)
> is pointless. Especially, if xfrm_dev_{state,policy}_flush_secctx_check()
> returned an error value upon NETDEV_UNREGISTER event, the system will hun=
g
> up with
>
>   unregister_netdevice: waiting for $dev to become free. Usage count =3D =
$count
>
> message because the reference to $dev acquired by
> xfrm_dev_{state,policy}_add() cannot be released.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  net/xfrm/xfrm_policy.c | 35 -----------------------------------
>  net/xfrm/xfrm_state.c  | 33 ---------------------------------
>  2 files changed, 68 deletions(-)

I didn't make it very far into reviewing this patch, because it looks
like xfrm_dev_state_flush() is called by the bonding driver's
notification handler, and I don't see that reflected in this patch?

--=20
paul-moore.com
