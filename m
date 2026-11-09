Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794247150;
	b=pf+1IDM5WsD+xXTKHna55tBnQl9eb1cThirnD+PMImgDbqSJ9jXNmqImEct64qExiBKJ
	 S7g2l3tR8y6sDFKWScfGZEsFi9EuGiSa2K1ZDbz4ovj6NB/Q5t+Bi0zA5zgxO6psEJvEd
	 IG4/f9hzctU+5d+6CHrZL+O3oRvp/jm5nYPaUnUKBrhHwuTJe2NHYryDRd5qkDg3hcm6L
	 j7GpPqB7PNJyXjW0oIRA1yTWHkRZ/Xxr6yWmASFu5Sga6mm5Cn4rLOXflY8Qn4jDjoTWT
	 hZKmFpdFk78Zv2dhHdEam+pb1vDQGs/bNZQCuHwdVgjnnEsmqDF6r71WLJctnElLFEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794247150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Z/ZNHj0Rn68UKNmdBxxUTiUBJqPFSpfv4f03+17ya94=;
	b=vs05/w3YTwJ9f4cXJ+Wbo2TYRfq41INjqCfJcQtQj21XVkq4TxTTyAhVZZEH2MapPpJe
	 nXoslCDDWDf1SASZ1GiP9XiDVga/dlcmLoKAU1Q7Iay+qRODBmmzyrzjm0M8Mrlw447yg
	 fD7OVH9LzKY5lBCBHmKosJaqkKLDfS477j4l3H7bWi4PL+5uAqo/2VBaQMZwXcRc52DR+
	 pm03tj3wLFB8IU56hKU2xP181ljj47qoK+V1GeDGQgqPvNbEuT8ymg6zf0AREViVfVFxF
	 g5lx5Cmb0tI78w4g4rd04JeuXnqGvHYQVIoTqNNjNXZhTwcM1/t5/4JqDPkCJUQUmDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AIo4bkEN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED21606A339
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 17:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ED21606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AIo4bkEN
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-679aeeddc6bso1402859d50.2
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 09:59:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794247149; cv=none;
        d=google.com; s=arc-20260327;
        b=QZ5qu6E6oRkWwdam3SF06a1lJw9j/EAfDbO6cFBewVUEftqZfgV7jQluhCcOZcIBz/
         hVEoqATPtE23+xfW1m+FalGBgVS8nxuig1nd+Z9FRDd94IMjhWesxLU1it6SdizUcfdU
         gudx5qleywPUZz0WxKsOJ4mVDsJqn8gWCwyKN5yrgoZD4itZvFm7MQcFtzYL3a6O/WXj
         YRmZaf7r5y8HCUr/FLzh0ks3I0cTKtcHozXMt1KdVMVsvWivfDK3PzfKxvn+3KISIDWu
         8mT93QTAhUmVJOHMqegOAbPPLsMPfNA5eSHt3orRg6HhuGm/tLxnQqErLxag44HI22Qf
         AcIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z/ZNHj0Rn68UKNmdBxxUTiUBJqPFSpfv4f03+17ya94=;
        fh=MbnmceO4hSFmkZAnSyiJr6EUuExCW9TEZxUoZ3Mb0t4=;
        b=M0GYjYilc2/qoZh6Srvo5WqaZnAKA1X9DQRRGq84sSUpkJBkTdjpVrq2eR/XIoIM9I
         PAWh1E88cdXqSsiV7MvgUqCTxWlminCLzcvpKGAEZRx+L30ZhsC0O8P98bpaywsQOmSy
         /lov2I4nmd6X3MPkyo66u+Pn+4A3Kcm7lT53TH0viscuaqLj1OsDDZNvoAy/Dp56DGHX
         Vk4xBGf9le+JsM0Az7r8lN5B2RTCpBgFZedVIbVr8z5a9PIlTlSJhmnkffjee7ZLe287
         FffmbZ2EN1f+iIz8K2KoChreUyokwS96hV2EU2DV4ToLiPPL8/jViZSM/77pJg24WyYN
         0ZYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794247149; x=1794851949; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z/ZNHj0Rn68UKNmdBxxUTiUBJqPFSpfv4f03+17ya94=;
        b=AIo4bkENCltLwdrhDOZewdicQonBGCTBeQaFNVBEliAS7m9/i3hKneycQdveLgr8ZM
         FEekiHI3WHCXhSHf/ycI2V4XlVTWenynjHLnoJsebDlk/YEP8paOC+Aed4lBOWTEPKhG
         P8yo8WRqPR8B6G+3WkngiNWDTOA96V1IsaJw/DAbLam/H8VXhlJq0WnVhf1Z/Tw6LzS5
         vk51tVv1X+KkoG8qSPwMEy0ZcIR51QFt7/I51IiJeH1cZjmX6R8oa82Dq6sXSAKMgAs2
         vYS8ymODLfSHrABA0Exg7U5dcGeXxvulRyUb5vjjqNu8VEHI+BOCfkfVA9fqubYvAQZZ
         uA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794247149; x=1794851949;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z/ZNHj0Rn68UKNmdBxxUTiUBJqPFSpfv4f03+17ya94=;
        b=rQB/OAsLI0gHiC3HJA3EjPVThnypFwvlFLeWjf0fQk7f2mxoQ1++bUwLK6t3++ntkr
         ofZGacmS9zLx4U2LOA4VYzypmPqYsQCroITNWG8S0Xm3DFMbuE7srsFm32LXtAfoCqvO
         NhLlhM9ZdCUOcZ+lv28WkGeijOaJJKNvGnjx2VGDGdTXn7J7v7hTecr0tzcX0R4Xk1EV
         z348B2KaxrM61z9qoE4+7lO8jQ8ihsPKGBKHGgmqZUCWhmKIQQaZgy8egiBLfEI4E4LA
         td0g4df5fnWmF88VfeJrhNGX4ZW/4mI7hyLzVg5oGHTj9bpTOElrkN76DPEM+1MDXk+W
         DOZQ==
X-Forwarded-Encrypted: i=1; AL+hErFMQlNtrIo4jQywz2QYNRgnaE1vswMUj/2UpFncuY4jTcpzjt+essYg4wnCkEKYXAmcSkrVdlRu@vger.kernel.org
X-Gm-Message-State: APuU4Z9kqCUpkEl/z3PAHrKZiFBjXUKNxwp7W7o0EccFPPJtdvqv8Qas
	pJgoJbF8pSO+B7p/QEExQL8KAec7LAJS1OG0ZUHlG6tt/QEUXFj0hrbUdRqJ2EMvvQ5V2AxfIE+
	zTh7Rjm8F76/1mWgNthJbPDe1fV2hebs=
X-Gm-Gg: AYBFou3f5viOhDAa74LrS6f97dn8SRDjlJHXv/5OZo7MwtUke9yvqbKUJ0Pjie1YJHb
	KaXpj1lXmvs4+j7/167gb8RpPSi0PSWcXmowg4VSjJPrlEE0Mt3a2Tczqok5/unz3tb9y+4aK35
	/fJ+cMHBmdPT5CUwg6bBd5RsJMFrwpws8nPmT9AJbK9KXd8a+VotU0xl4xrjh7a3u0PSum3kzc2
	ZYGgmb0qbWRO57eMZHlLvUzAuGXTnjl8Bc4MocfNPgAMMnEfXr/S1/g2Zb4GSD8ZQoQtI8vX3Wi
	7eES2lyzH4xZcqqw7KKLtPAR0cYai9hCVJRSRIHAV1jka6cqa1BS619BOgFSNH7CUSZQF/Keiar
	P4r6en7mIOZiB2Tb0k+Vzi31PuvdoDPMutxyrku1QuzGoKkrxFNFyaiTRDOm1NpvuGfgo1/AlR0
	S6Zci+3z01Km5ln8OgsWEOiOJRq2vBzPQCtY/pbsE6pgA76dRwK5UkVqnYsA==
X-Received: by 2002:a05:690e:138c:b0:679:fa54:1ea6 with SMTP id
 956f58d0204a3-67c56830448mr223512d50.88.1794247146395; Mon, 09 Nov 2026
 09:59:06 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109165939.138448-1-mdshahid03@gmail.com>
In-Reply-To: <20261109165939.138448-1-mdshahid03@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 9 Nov 2026 12:58:55 -0500
X-Gm-Features: AclHuK9ejIQT6HgBplyFvbZQHs5s3CbaGps3p33veN7nSZEUOaWjdoafe_Z68xc
Message-ID: <CAEjxPJ6DApZN+Ri=9dZ6Ff4d-aegQzVKpTT04EtgOaJtdjy8Yg@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix potential use-after-free in sel_netif_flush()
To: mdshahid03@gmail.com
Cc: Paul Moore <paul@paul-moore.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 12:00=E2=80=AFPM <mdshahid03@gmail.com> wrote:
>
> From: Mohammad Shahid <mdshahid03@gmail.com>
>
> sel_netif_flush() use list_for_each_entry() while deleting
> entries from the network interface list.
>
> Use list_for_each_entry_safe() to save the next entry before
> deleting the current one and avoid accessing freed memory.
>
> The issue is reported by smatch as potential use-after-free.
>
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>

This isn't actually necessary AFAICT - sel_netif_destroy() preserves
the forward link with list_del_rcu() and defers reclamation with
kfree_rcu(). The loop holds spin_lock_bh() throughout, so the current
entry remains alive through the iterator increment.
