Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA3141F359
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697426; cv=pass; b=WLlF9hJ7+X8q6BG5CIgdxUtsvTNNCoKoxo+hd70cQnszSl4zwsBuJnrWuE06ZC8hPJZSVKZyanXey/FfOfoPCra5DwWcNwcekBK7AgbRr1OzDXSVOZLe0+LiVjx6BNsj2l5GP6zowFuHGBxEhPr8JV+lNO5JklE7hZtWNsjWC5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697426; c=relaxed/simple;
	bh=CgUoWZb60ahlZONFpHK+0zRKKA4BKvINSjwJ0fv9WNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApgNR+P/sfjuf0dZp6pTnL4BVus+LXEwQY+HUzer2PkwknIKdKzIbmEF/eUleqH9TeaoIoKbGWeQPlLhyCYnGfztmJXBkV0zSpDOKExpxAqB+KCO93Fs7bAqljFXDCtoQF7U+vp9dYCGAr7JInd8TGGu60/loeZ7cSJubvuC1Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyDjekGn; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyDjekGn"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8a8288165fbso41322887b3.0
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:57:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790697424; cv=none;
        d=google.com; s=arc-20260327;
        b=EitVdOy71h5GlcnAVJvF6kgCPZ4UvPWdufhMm9zhGcv52ltsuyml3zPLvWXVSbf49N
         h4TnWIYBKRzZJtzfNFJGl2UTTUTR0JnAQG4sL1k+mjLjUB2/pMG+TvwKWMiIQLlgCQhL
         JQciANwbRRcN28v1jfpRA2Sa6WtW4NI8GS4JIi+V70GfrXUEo5S0qk0c71rdwSczz4kb
         av1jhaeL+jSqr4KIBTpCSxS5ymdqlfwsAmk7EJKOiuCt81sNKjWDJu2af5kv5FO5LE85
         dpneal8k8nvNDJvrZ99Z9RbWaLRnIprOWOwZInV/t6g0de8c8Bru7eOezkKsgi97i1yQ
         MC7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CgUoWZb60ahlZONFpHK+0zRKKA4BKvINSjwJ0fv9WNg=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=IPqA8AyG5AK2yBxfOVvkulkYv9X6vmhY8K8Mon858npjOo+2bNx0YhWgpSyhOzLqbx
         IanaMtnSlN4cN8flFxlfAIxt7Ha60YcesaJQo4bXHsJ+FdHcLVMAOPPouJvdtRJ29nvF
         zOteg8i2QgRLNTbFSVYvdG5xtkSr6/Lr5t87EE/Xf9b1dg8oIC/NUqvcYhBDdXJBK2aB
         32tMRgYvKMclfQyev/+WbBnT0lIase8KXANmEW01KROnGvTHeX4OBydbJI2hyGPojdYF
         uT7eirDy6MZUit2rDJh4v3vxd4N7fNuDWzgBV/WuOaL2MjZxpY3lbeLNB/ApwSpKW9wM
         t5Og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790697424; x=1791302224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CgUoWZb60ahlZONFpHK+0zRKKA4BKvINSjwJ0fv9WNg=;
        b=jyDjekGnsrazclTCnjP5czt0gnNMTZbdHBPKr1o2NLT2SMaNd9J808DK/Trys2oONo
         6w+mquexccZNJ6GI6PB253pqE++vu7R43MJvjWeDyFs540vJoLmLcUFfHCh7yyYM6xTk
         Gu3KRWMC86rFstfM6JfVIWjVG78Z/jOaPEBWPT0B6qTb3a/+T3eX6z6qwj1xNdsi8ABX
         RW9JC7qX09Dgc7t2qr81uqXVHaplK0p3nxpo5CH7kp3lsWTuraRGHVYtLlkv0yXI1V/H
         4JBMEPVCy7mvlxvbUqWRT7tax7C03xAdHpz48sSykyvAmM692tRYa+zuue2JmeNRANe+
         KAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790697424; x=1791302224;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CgUoWZb60ahlZONFpHK+0zRKKA4BKvINSjwJ0fv9WNg=;
        b=WbZXHCE2XXYYL7PbUPM3PT+QRXp/EEoEifVIO0BNNoxUXsTjVJ5RA/lixg3N9XA3Qc
         kMWLLlxnx1B8ESOB430J5SZoSDxxi6aAZiT730f/Hzcyh5qqOYB38X9agjowm4102RrZ
         sT9ePRBJ6gggafoiaHFJQlh3dWYTw7jV67eTkJp+Icn7JfEmGLd79ysaO+7E22lzNK+h
         p7AsNX/7+gLXfgjij8hAGyolkHvkfXEF91cPEIpWlAzQcR82bANy2O9RYpQCPWRQkHRl
         XvFTCnK4F8igBSehC20A8RzClV4unZiVdHBXvLhWtUodf8HKx22mojawPuG6vDkQU5sX
         jFZw==
X-Gm-Message-State: AFq9FYJ9THJ1JLBZst+toNQhsraI8Xr+vndAYlzmId4bZJx12zubSFyP
	QdS29iiU0tGdFpwXr3foC/bIP3rgI5FvGNfz3lTVWu9Z3JEZhPW9i9DoE/itSTz9kmKmoKqhVVm
	5lFlKcMva/IPyoxd8a+jkKjTRUIjeN0g=
X-Gm-Gg: AYBFou0pgr/pwzRkmpDG5YSZJaVufUuyiA12wKy11fV80LZDdHE7pBdiOGYZwhPyyNk
	a+eVUPIEWbQ/tUIlJbwd9VWfQuKszT6Je9QRuD0KEps5mBHhSG7t9PFnSSv8lnT4xdK9Z0SHceh
	AxjIE7x2Q2HanZY7cWAwnudHii6HTURJEOkHiNbCyc/WsCk3WepmfqcHcbahD3MNBJvak73x7OR
	Dy0PbwlObkoYlLJnc2fQnl4Jofbzt4aLRO9dJHoei+6bk9pKwdKee2iKBK91DKcDHGWc8X/iSfA
	tN7UWy4STBY72Dc1BxVaEhqA/0LqaKESEOQoP3wcI0LucdiBJ4AqClq7gNp4ZX6D4Q==
X-Received: by 2002:a05:690c:c509:b0:8a8:7e5a:dc2f with SMTP id
 00721157ae682-8a87e5af118mr62477317b3.12.1790697423878; Tue, 29 Sep 2026
 08:57:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-24-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-24-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 11:56:52 -0400
X-Gm-Features: AclHuK-_YmbH6yTe16dawMieG41r2FXWLR7gcwYW2l40ZLNy623xG7q2b3HMWbY
Message-ID: <CAEjxPJ5ELTnQzuYaLFni1TirbVRZFZG81yR4T7cYzyKW2DAhcA@mail.gmail.com>
Subject: Re: [RFC PATCH 25/32] selinux: share implementation of relabel and
 member transactions
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
> sel_write_relabel() and sel_write_member() are identical except for
> the permission checked and the security server function computing the
> new SID. Implement both via a common helper taking these two as
> arguments.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
