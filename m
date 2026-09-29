Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF8F53FD27
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695456; cv=pass; b=PZ87tJVk2ys4IiG0nOZJ7/rn7FDPoj6Me5B4dQTUMAjLMd7j/dlP4ksbk0jETEhDpsnu4BBQsdOzZsVIiIbiSxTQv1DFLPzp8ekFJ5CajhkAcrnnJ/5JHX5FyyoEdhqWo5RZoyPSxBcAOqFK4t7iG5299LRy1WyFQ9CMBFBYZf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695456; c=relaxed/simple;
	bh=rhdMi8woJ0lB0DKXrgf7Yl4WZm6yPUbeM5ksekC9aG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c78g5sKIY34JLSYP5Al+Cj7rTPyUe71k34lLVeW4/y0Hj/n1jO5gqUcLU24oJMa+Ln7XnENSTnmQDwUcq3+9GsXi3c64/J/zistT++0sY7Rq3dI0AX7Q6nUxUG1v8tty//4cCAm0FGFGow5zdwuYBI9aOPBdCooVG7D1+Cm+DJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKTkEyD8; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKTkEyD8"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-895fd505824so37597127b3.1
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790695442; cv=none;
        d=google.com; s=arc-20260327;
        b=XNHkLYEwbEk6ALe6nEJDnujFGYhxGSHiUFolcysNliOIyZE5twpMC/26MLB0SeRVNJ
         BUzhI1U/Kvy9+Fc3zYAADDOwLdX0/yiZNUUCqbp1JjypiP+JIem8M1gFQ129+hTs8hrm
         Ep/wcDi6DhF/W2vGEoHCH9qPpxYTz2WXg7wJmhLS1qgnhQtE0cCqTK6MBKFxz11dATzz
         pFowxvXY/s4pLl8t2supY8uVVMUhbpCG1jZjKaYyb6tMk0stHa4aJtcLx8xtghoA0CSk
         v+no2ayy2fIDnIx6LU24yhoY6E7UFrsLdkj/THImOgeTSboLRN0aKuUCPM/svqlotYu4
         cYLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0Sy+7VYYrKgySQvH81vZNxz5zLCjxir4/HcFuuLHDR8=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=l3mp7/7FrhSB3gX9P2rYVaesGw7VJ2WuO6LGNy9ePQiZbhQFNpiorDI7R1jqUMJH7B
         hn2NLnLRfGKalC8Ms66E+1q/dzVUJgtcFR8OxE6I/lCXcA0e/PLoO8NIk1o7h0AINe4q
         cuAoWO66bRKUbpxT3Ai/gHeuTXZaZhi8jc1zsKcw1wGKOdVheHo19NQl+2kwiUje6dVD
         cIiSQLl9C2hPFDY00QwtMj95jmP+eSE1pz4GIjoR9Hgo77WEHZ9B/tvqhURD8wUuZ2rG
         tHjGQB4vhmDHmbQl8DbHh0Of6NNJp1brqbyPvNkMtiB7hXfi/H2T8CLWlH8LDQeztA4E
         Lm9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790695442; x=1791300242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0Sy+7VYYrKgySQvH81vZNxz5zLCjxir4/HcFuuLHDR8=;
        b=hKTkEyD8OmL3U7S8b6js3UKzy5SXSFxUbwYf5YQDFcOuDFFPfTzT3JoFIgOQEXj7eR
         /dktTxdnzicJcyjBB42r3LydmsI2mVtG6ZKRKiof6HN9FkjHMBJzJfcvQyLejrjnceam
         ffruEyKNVf373KZrg3PXHTiGvMVBC3Yti0qA6zQNaSQn/olprkaWx6RAOkpV4YnpArzl
         9KuZtjpgunNR4BF51WaFBt3oqvGLPWIyGdZFdhkK/f3g0XTQWPtMxofoLLwJKJUad0+1
         xrk9gNG/H3RC0EXZnQaFeZM6e3o/hZZtjSHIXEQlWbwOpJVWkGbRfwqBbht8Yhda8Bdn
         eAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790695442; x=1791300242;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Sy+7VYYrKgySQvH81vZNxz5zLCjxir4/HcFuuLHDR8=;
        b=OOnl456cfkX0s8SFDLGFsNoXfvoTKt3ZwUpPvcMU/5pbzWv1HZVAnkP6JHteszSKGU
         egbDMH3+ghCCx6bVQ+Xwk4VuJFc1We/PG+JrLNGwd4VOmxuZrSsuzwCmSgXsOaVHzfVr
         g/xaJPQbbByN7TPi6Eokum40woiHJteaIp1vutr/emYHsuPR840Cgs6y5TO/Ifg3+hhP
         ihDiWAt68m05Eb50/Tn7pSri33kI4iaroRSDn9k/fR29Cuo+ZtODxRwhQ/8Uh9ypYN8D
         +CbfZkXcLlGtIE5UFq/obI2eA1Z9Jy6mnb+8L1fkaw5y5X5nKsAo0U7dp6Wtx8nmJREw
         gH9A==
X-Gm-Message-State: AFq9FYIjl1KMTad5sunzPcfwKhNdZJRIQ2mze4y4pNq/RoXSxvymTKt7
	UuJlW3K3cpPqXc0gG7D6c3+XqYMvp2HNMLMooxOEaLnV4EmoqXot6nQJYrWiKvC6DC2JWMA3M/W
	MPzAiIDdCTdKQWngoA7tCvml7vUAUCsY=
X-Gm-Gg: AYBFou1j9+N9JZkRP5hSLv0Bq9FHH0HxELNQOaqA461Xedfx7KcFD8Z2LpJMUjiI6IX
	bY8mjth85zBk3mR3IBMjrnJFQstV0S9nxSVNyYBGl+qIqp2xF+//GhHl/Be9P6wfcDGFdq1vCLj
	kwJWmaaP2Ir2nA1T7/p95MiWU8CnzHv8vsqIQo2F6UW7g9Hu39q/fJCJ4sWDh4Z2E3wltdq47jV
	fgnGM3UtQl6TzrXA8iWBKwLlBTpw5gDPrLf8/3b13ijP/OpA0y9aJMu+MlJ8SKZqwOjAddp8RE4
	NcZRewNP/Ih5xoCIqm4MDf3YUPinvinzN25H9tC+Cexxx1vhYzww9c0=
X-Received: by 2002:a05:690c:698b:b0:8a9:d811:302a with SMTP id
 00721157ae682-8a9d81131d6mr31330237b3.88.1790695442294; Tue, 29 Sep 2026
 08:24:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-32-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-32-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 11:23:51 -0400
X-Gm-Features: AclHuK9jM3P0Kji_PjKQZMFwuI9wSKhiH0N4_gOSujXLt0HtZpXB8OYcCyE-g1g
Message-ID: <CAEjxPJ5F5HYo2hR5P+V+fuvt3Qccft1ycJgEiKj6-KmfAeV-NA@mail.gmail.com>
Subject: Re: [RFC PATCH 01/32] selinux: remove unused AVC update events
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
> avc_update_node() is only ever called with AVC_CALLBACK_GRANT or
> AVC_CALLBACK_ADD_XPERMS.  Drop the unreachable revoke and audit toggle
> cases and their now unused event macros.
>
> Convert the remaining update events, which are only used within avc.c,
> into a local enum.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

It makes me a little sad to see the lingering remnants of the original
Flask architecture go, but I agree they are unused and we have no
plans to use them presently.
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
