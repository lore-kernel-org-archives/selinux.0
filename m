Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726073DCDA4
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696976; cv=pass; b=MBZJCjM3EEGm52jJeA4Q7zuJBTESDa6XikCsS+ej1F1kwI6U/m25PJJeRaJ6dl22JbWGIbmuESyaqiSkhfrIGSokqom0+CBYfVjYG/l+FqixoXAPM6TBjkSMv1G7QSKMNrROoXaarrbqTo0ZpzqDPEWMXigugscOgM7dhL7TLFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696976; c=relaxed/simple;
	bh=CXlP1WsqYMoGia9EqF42nE7SfRQ7C7ZK2HVGBhgoyPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fwm0gDz7Y8BL0IPAKkRWfEHkl6xzUlaTPkM2ML6+qEd27A+W2ywl33jtqrcQlQJ4AruJDROPw8E0ZASgxoANohYAfFD7OhXvUZossUIc5t3MnrszkiiFjVyIAk3+yBjQetCQQqBDVaT9fsEUe209rFE6iqx9derUIKyq9P5bLJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7tDygek; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7tDygek"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8a87be3ca16so36684507b3.2
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:49:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790696974; cv=none;
        d=google.com; s=arc-20260327;
        b=jiNQZai+eeIk8mgJHLWIqWPUeLebXsDOnxHiw24d/AXrcwpUPymAGA20KXdJ74F3VV
         szoENBjQmUCnubma4ylBqXVVaRt9g9PRbFUDJCGpj4HDUsxx6GTJyq6PMdXaz+ZcipfL
         1O2fInZWvGJ5xIw6B60mv1vdlQamP9M9Z6Wt1sFYGBr9e81hi0nXT1O5QNKnXXWCGyEg
         I3gbrKFN19CIpz63OA2xTvg75LtGbhRMYUf22QrZADlHTU8KH/tMd4B+IrmrWybKHa8B
         GNcf6wmSFS7VyJccQO2iWz+RYhEz/YnLRJQo2rxVqVITrVfcQimc/CHrNH2c6L+b/VRd
         qMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CXlP1WsqYMoGia9EqF42nE7SfRQ7C7ZK2HVGBhgoyPM=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=dTS0y2Oc+BQ/lcNHLjvgYTwCJwJL5JmG5KFI/frSXfnngUhh/kNnOB4I+wua5KRb6R
         6K6ZP6t7tqgubYqSyxKGJ5R+xCjwyhE/kPoIZDiSkET22NmV8XnREm0Pww3kjKkDM3r4
         7lajdQ5U37n2Db5gzI4gHzyLDRX3nUiVFpEwvgHfZaP3NrYflcLCcH6MazsormY/U1AF
         EsawUx9RyVo/Sl1u6dxPrY+m3OihK3BU9DDurmLY7+GF8HomrfMEyUWa3lX4I0rKQEyI
         sLE1uquyBNEc1DHntQ1aqh8PxCI60/z0yuQ+WXolQVp1H/loHnMlQzD8Vl/sM4zhpwh9
         jh7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790696974; x=1791301774; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CXlP1WsqYMoGia9EqF42nE7SfRQ7C7ZK2HVGBhgoyPM=;
        b=N7tDygekg8yW1l8bMGF+pWYF1Z16bfN5TNbruF9G5elWYqZRfk5TlgrVRKNICQKUGH
         yAUZyPNOS+cZ7gYggGjd35wYKzn+iKSZwKvOU0R2mVMyP4DHAeMD/YthBtYkrcT9IXnJ
         KItsF3KTQM6ezltpN+BYb6yHYzjXRuHKwCkjlEVt3SIprAxMUowoMg5DCcYVwIt9Rq5W
         sk6fqCnRbgRfaOK3srNzUpVw1/7btapQOHD0Ccq3Fk8nO8lgU0Vxzj88f0IDUznUZNqF
         Bkj3EpN79ReNoZJHJwGC7WLQrNV13TF7YjqoXsmUo8QJcwY3c6hq5SlcIbHklNnl/k1k
         gLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790696974; x=1791301774;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CXlP1WsqYMoGia9EqF42nE7SfRQ7C7ZK2HVGBhgoyPM=;
        b=fSIM7PnC5iMeGrtJP/SW3+EsC9pkivbLWWPdv/+5i6suYdcUkkQR16de+K38p/luxM
         oGwlNri6U5aNuHr7DM1roSdmh2FXT6Py+1DSj6j+4rqn89eFZ7FiFXUY+XGJbyY46wHi
         JA6V5Lq0WHGVo1wjDjtP5FItdWS+TVvbyqYP4QfcgbEHqTaxn5Cuo7CfBQICMU9iSuoo
         d0wBLqo8td+WnhCKsXneWASAHsRn6+zMp2GRpDApB/q9r8PF/Q4D8Ws7/iiaW1/npFMl
         tUQsCw6zSpaKmTQJT64BTCqjGnEsX2RF2zKgg7pQBuQ22cau5ToX7+HPG8ZyNlYeQQkQ
         bvNw==
X-Gm-Message-State: AFq9FYKVod5y2mvsV8iYxz/I/bY/xmCnJUaBjn2GLC9SkaHm4B6iG1W2
	Ok5QaYtbhllWEwYrCdScZURotmJ57NeX/B8rB2IWjOyxC6VA4jwHWOYozOn2ga2vrGHKQU2WRp6
	J+VUH0mHdEIt29jilHiLKOw4hf28uhwI=
X-Gm-Gg: AYBFou0RCogjwnmhrqP00zvGMdtwV+Yjz5ThhHkHp0Yua6p3Xmlm4dcIRg4Y6aa2+mt
	zC5D+3BMLFOvyriDuZMMNKaVsl8crj49MexdKSDt5uIRCC3UGM6XlNJNp6WG6wKhKLnvThTZP+h
	fjPI+vPi9uCRK4gf+DslNRYTmkwMvaZc/G90RSQZuThZ4lodlIPCI08jUY/mcwHT2IMLpMxqx4X
	cUXvjPdbzJa5gHmjy2DkZxHRUTYtcpEBSV6oqAZGDCLAOsidFYACiCv3PSH4fc9+DGOd0dAW+kb
	UV/y//AyMUd3hHD6DJDCrPMHSP1/MWFElV0+2bxZ0aOzjYjBfYv/5kI=
X-Received: by 2002:a05:690c:ec3:b0:863:e8cb:7773 with SMTP id
 00721157ae682-8a6465b149fmr71638977b3.32.1790696974024; Tue, 29 Sep 2026
 08:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-17-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-17-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 11:49:22 -0400
X-Gm-Features: AclHuK-zIZ7l9A72tIGQ76xSAcp5oh7fTuxFdXRo2xkjdbqvfAeyX-jGpVhpkFY
Message-ID: <CAEjxPJ43OaorRkqiBNDKBCy8AvWfm=6L1QnEe=AocTjjfZZ8Qw@mail.gmail.com>
Subject: Re: [RFC PATCH 18/32] selinux: drop dead NULL check in sel_open_policy()
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:23=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> plm is always non-NULL on the error path.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
