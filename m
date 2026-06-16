Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0BD344D88
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 19:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781637545; cv=pass; b=WP7NXqx5xSL0qc7OO/nrvqb+Q/z65HdbWaEQrJeLW/1h+/x451k6ux8sIkabjg2EEy397t2CE4ECuRYaNEsriXqX4ofJxaxBovNbstTRjydvpAhm/c7ZGuTH97Z242H54Q+W/GLkSNXg8P0vKL1QI+SvrCCXS2m9zeofaZkWvfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781637545; c=relaxed/simple;
	bh=xsleDON9i73NAShpjs2jDeUjSpmyPIJh4SktD7iLzqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RfpoGIfjcxcMKdhHyzhrYV7a/gQHM2GKTa5Bqbt7qJJcPOCuXTriZlhXk5P45oaXzcRP3c2CBU9ASBhDmwOyzybZY9HlYk3q7aIHCV65Ru9sTn3dGwK3MMavOpFm5iLQn1360gTVKOq+1o29yuUS0mb8LU4YDwKS5IN50VRUdro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLtWkDKi; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLtWkDKi"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36bcf3d2565so3618997a91.3
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 12:19:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781637544; cv=none;
        d=google.com; s=arc-20240605;
        b=fRGAlVq0sAqAueGemnbBQ8ZCGpyu2xSBU7qZ0oFQDpVK0J+K2OU9ebabF3X93EZa7t
         /B0qRdgPR7IXsusP7mvHLaw8j19Dwd7DZfHB8gP1Mqf1IwRGK3JJiFh4yxu6SNzAES72
         ikd2p5Q4TabuJkUWDi93aaBzHqm6ouJuzMnyz1vgXSkkLdf9AB6t7Vo+yMNpyJkm6NqL
         kwzaL5OIJ/fxavgvGA0m13GnyeAgIHjAzPcElPKUs/ml9SCWU4C30GArsqdPwsKEjPHY
         gLampCvYyiorMNn1mU8MiN5kNkRS2DXknBY8sOWvg42iRKbbs3yWC+nJp7erzOZR+MKA
         yjYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xsleDON9i73NAShpjs2jDeUjSpmyPIJh4SktD7iLzqo=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=S1Ewtf2TAoo50JGK51UWzj4xkSxumBcvx+Ijgw9LfOp/CypuBjg64pdwyN5J+KejVe
         UsX1V27Vnxsor4nKXdJ3A8CjvEJlDJMoTXOWSCNrBo+0xqytgVX3XVUr6vP3NteGo6cr
         iEew8khh4qYvW5BJY4eFw6c/XgTxCRpGD09LAxgogLhzeF5OicTGHZV4Xk+5FGc2gfGA
         bjm+qGfjfWyDBP5rlcEKo2SVh/Q3iDmTTh3NZkxDOpWshqlf0SHq5Ot6uz1Z6e2bqEkb
         WmZJdZPiuiNHnIYXNQ7QryjcIAWCUz25cQtuWUkPxwvrGk4CeU0tEhD+rKzZRBmAP9kb
         128A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781637544; x=1782242344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsleDON9i73NAShpjs2jDeUjSpmyPIJh4SktD7iLzqo=;
        b=CLtWkDKiQkb3WeqxaCdHh/Udz6auZp1WrPF60hORvA5pRpevzCrQRvFQa+mRRwpN7o
         Mqvc+qwacIxzywU23LXA8mM4mBMlZgH2wzDwnlVJhGVtixEoepDJN++CZu841OUEtFm6
         Js14gDyTaMnJM5cNYm7zs7IfmvAD9BQPrFy8HLQfWuT0Esg46pdUk7Ueb9OJ8rNGYeqy
         m3f/32i5oAZuafN51AXrkoF5G3GCiJWdWJJaI1+jWF1IbFX8vdS7yFp3Pq1uefEly9dq
         cbmfouU7gzFwuue+5kHN0KmPTVV73hf3PwjPeMzzCT9gvm8W6alv0c9mCREl8xsbr8/i
         Kw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781637544; x=1782242344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xsleDON9i73NAShpjs2jDeUjSpmyPIJh4SktD7iLzqo=;
        b=dK4P3wNKYinxk7wipUaIsRLHPC4L7UZM9sVyFj5OngU2QGu3+AlGNRSr2gvwP6TeTO
         n3LDU6T73RbySdrJaB2HAa9OcrJKUyEg3r3Ez5gJTfs6VKRtKktm5N0VKVkH22j5XwOG
         HZyKYFuV6R6UlHgi7rlqZ2/6LZTGQPpnh26buDERX2b8UTwLSxOYwnGzkCEeXRSmFxDr
         Dmkhz9Ip8MWit+ebhAjGvJiO3BH1qc9jIgN+vWVPghZBwngCHn8ihmVIyMWMbEX9FqQe
         VIQwMGZPw6Qd2IDLuwuic8M5F/R4/nxCfJGdAsfxSCx4m/xO6zzryQhv9KAlgHVduXdY
         00pg==
X-Gm-Message-State: AOJu0YzdkqJjrUDlb22T+nhFx4Io04Fl1H9mCg+fcA5kNpWq52/4TJL4
	hTo5fImyNKU/ghqzggjq9x9+7bP9Gw0p12wOIWbSlkZTY/6MBJam9WWk+vd51WF8SVw5KKkkrrP
	vRsNfcQ1eMIQcmmypoeIMcnuCRB4eC/6TKg==
X-Gm-Gg: Acq92OFoy/5o+yXHWAgqWZ1aSOVB8QVvlS6ZnsYNEbIAF7BfX345ppWzRx0tBSXZdFu
	MuTOxzI8qYEfc6T0aW7WtiKvrftBFnvLvbT9C0cHZNtbW5b9b6iRwnJuXlIQ3bNf3zrqaYYmyM4
	k4VBEkFpHuXd2pudWv7H2aSjAupdYPcWZsOg0vqZwaDYCJ2PQlrOnReX4pBwHhjxOBkhL5kN7Dq
	5V7ueYPM4ph3MFPmY9dEmkPebo5fSEuow/zXOF83n1//u66Jpoe640WzsvQ84SAOa0mdFFRKCSB
	bfmrZWw=
X-Received: by 2002:a17:90b:3cc6:b0:36d:8f51:fe29 with SMTP id
 98e67ed59e1d1-37c936f2353mr739419a91.17.1781637543974; Tue, 16 Jun 2026
 12:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616164148.50283-1-jwcart2@gmail.com> <CAEjxPJ5M+W3BSimSLJ6rAHuj2Pytis5fuGJuryg+NO_7wwgbeg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5M+W3BSimSLJ6rAHuj2Pytis5fuGJuryg+NO_7wwgbeg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 16 Jun 2026 15:18:52 -0400
X-Gm-Features: AVVi8CdreajteZ34oqvXids9JlFpwPqLG3UZNFg8A_jKJZYPbdVqzU1tg5oZhR0
Message-ID: <CAEjxPJ4MRCdvNUdt-NH6erE7hBL66J0uMOVPzCtJn8GramwOvw@mail.gmail.com>
Subject: Re: [PATCH] secilc: Use fstat instead of stat to avoid TOCTOU issues
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 12:51=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Jun 16, 2026 at 12:42=E2=80=AFPM James Carter <jwcart2@gmail.com>=
 wrote:
> >
> > For secilc, secilcheck, secil2tree, and secil2conf use fstat instead
> > of stat to avoid TOCTOU issues.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
