Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D20430BB9E
	for <selinux@vger.kernel.org>; Thu, 15 Jan 2026 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768516455; cv=none; b=uOdZMpLrGKuDVc24a0hGvHt5AsucOC+jE0v7MlxCAszRO0mPa5xmXF6A9NjefEYvzt9WxpB5moeKz74vtY/KiZY3yixWSObqI77xiwVeFscm81qxl+VNgcc7i+LvcYMzkDAnsx+9ONR5ZuGUpYyG1Pc9s9dRTxbdfo7oe5n1k6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768516455; c=relaxed/simple;
	bh=UeW7JbLOCoc8Dw/IiSLxbfBgoc/CIWkt3XwLMg/Yy2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OajmWhTCFVMH881g0dWs8pXvV6f1hADJUX5kfRUxJ7T55xIt7B81ILSlQdCGm6FCnPhGC51KnxXbbEGnzOZU8fyDpJfZp+yfdPGSvPA2V4o3DmM0lpu4ZBqvBnU62cZytfcaLj8hI3Kj8AoybT5zWTVrNsHHvxBl0UjT5kGxbNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ESKfhR0K; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ESKfhR0K"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34c565b888dso1168369a91.0
        for <selinux@vger.kernel.org>; Thu, 15 Jan 2026 14:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1768516453; x=1769121253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kWVZFQGpXqjKSCLiBbZRaDENwQG4TIKcZhRwygWQAY=;
        b=ESKfhR0KE30cImVo/xpZDOOud8tuEw9bSEQb56LWze8DNQf7BhcuutJOqwpNJzKtl6
         SX3flht4v25kTuXi7ODQGHryJ72X+czDNgQzT6/Xo5bgva/ri22QHe9voQrF7SCHVA2q
         xPaWqZLfVDSEnlc1pVKc5EwxXeMVymz84izAXc5xsfPKcMdfrNqEsLls2o9axcC4FITC
         a4vFo7aSfEZCmQdWVZ6g2GvzgvNkbIe7b6IyNT5y5WJrd3pvmAjXJWZFm4jwbXP3IFub
         4W0PrQOFLsHHwtx/LvDfxL4fXmqu65lvg+N9803V4u1ShqfvHbBcz3LBNQ9Bg53KWdrz
         PWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768516453; x=1769121253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/kWVZFQGpXqjKSCLiBbZRaDENwQG4TIKcZhRwygWQAY=;
        b=hiAC/IbpCfUqtyAd6IC2CL+zcwvC0eTq/Xy36o3HjRcHG9rXiv/ZE/p90bPDOcHs99
         mTq9oHItqLqbcrzJ2wxB9nGmIyxxwf/KZBleTY20D8HDuZMrGBjVjJ3k/bEU6lxazJrO
         feGnAjzSyZaFhsVPtrxwCrWLhM2Et2Plqg+iZKABX8GHiW9EhS9gzFOZQXFTFup6VKzT
         X32IrsrK5+zW0klK9sx99EupIquDZ4jMmQwPAOrBOfj2BmQL9H13iREjN2sm8ja0JPab
         cknqquLYvQDgeW9gtNexs384boW1W235IBRtSLg1Lmi67t9FULiXy//e4jt+wEj9y5By
         E+qw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ/ltgz+g6xZXp2l16uJ9p3bPGK89o2oyEvS8Lrp0T3wrzPENNWGpLnhiZUStL+eZhIDazpL72@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmugjg4HKK9ioXhXuUrJ41Ek+5YS1QlsKUWKou3D2ItE42cdYx
	VJS0EqpcNd8hwXqh+FTdeRDrdt22/zvZWvD+Y0JHbFGZ1+PQnIzXJnQtb0Cxxpn9Hzuz3RN3c0E
	hFx941zNmzJtmSfvZdtE1The6gCikts/lYNChcCSV
X-Gm-Gg: AY/fxX5jYjq+5LCTvHRlmmA42aE1jNURwJJ4LBwYxxtF9VBu+8woBOo5xcfvc5JDalo
	cDGkUu+9wQhWX6505syrEtivWEO+nVnUUod/E67E7Ndbsw+8FTeQxS+XtU9Uc+vi79VBJXinNv1
	ppfdsHn2iGBgzc4HGcsQJ04XvdHWfIR2Z8svsEtE41VX8TjvqxjRm5IdmcxIaUMWAasfneC1Bkv
	PnIOsMl0yB/n5ZaIvnRSDktVtQzudSKG747P0iS3PLimwDyduwAqhqOVGVoqlxAsvg+ZOw=
X-Received: by 2002:a17:90b:3a8f:b0:340:ff7d:c26 with SMTP id
 98e67ed59e1d1-35272f12951mr954108a91.16.1768516453621; Thu, 15 Jan 2026
 14:34:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aWlLs1o5gk7k5osk@1wt.eu>
In-Reply-To: <aWlLs1o5gk7k5osk@1wt.eu>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Jan 2026 17:34:01 -0500
X-Gm-Features: AZwV_QhMQDfrkY4CoIsEEq9saP92MXy0EFZGHZrxdCLd1HM9ynD7e-5EoeUMvYs
Message-ID: <CAHC9VhSLcgU-_R5W5_1Vh-Kc-Pd+HEhLu+H7m1hE7Po6wDg8Yw@mail.gmail.com>
Subject: Re: Suspected off-by-one in context_struct_to_string()
To: Willy Tarreau <w@1wt.eu>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, security@kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 3:19=E2=80=AFPM Willy Tarreau <w@1wt.eu> wrote:
>
> Hello,
>
> we've received a suspected vulnerability report on the kernel security
> list, that was clearly generated by AI and really not clear at all on
> the root causes nor impacts. We first dismissed it and it kept coming
> back a few times. I'm not pasting it because it's more confusing than
> interesting, though I can pass it to the maintainers if desired. I'm
> also purposely *not* CCing the reporter, as the address changed a few
> times, and once you respond you receive a new copy of the same report.
> Clearly this bot deserves a bit more tuning.

It's funny, I had to rescue this email from my spam folder just now
too.  Unfortunately I have to step away for the evening right now so I
can't look at this, but if you don't hear from Stephen or anyone else
by tomorrow I'll take a closer look then.  I'm intentionally trimming
the rest of the email to potentially work around the spammy bits, but
who knows.

If you happen to be seeing this for the first time, Willy's original
message was captured on lore and can be found at the link below:

https://lore.kernel.org/selinux/aWlLs1o5gk7k5osk@1wt.eu

--=20
paul-moore.com
