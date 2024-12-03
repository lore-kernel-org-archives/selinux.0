Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6BB2500DF
	for <selinux@vger.kernel.org>; Tue,  3 Dec 2024 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259060; cv=none; b=J7UUbApFcqPTOAmz9vUkh7Dgx0NVi4t4ADZe2NoGD8/UFsRUJXLhwLnbXkdXmStF+yfuZo03zzVvKgQt5of5cRlMW6XxtCCRF1qH6hfTKtS9WwH3Ky/ECnuQ2Agz4edy/YorETL/RGuZZMGx3egqC+GZhquwbaZMuFeMyX76MyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259060; c=relaxed/simple;
	bh=0jrgZwpKPRjGzlJxUIaUnijR+xRE5akyKtN5kB7pdgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ty8m4yeWyu9AyUaDo17iWKzRS8k4F14CG+Y78TH7YStiBqfaRjXTGoIzeAuGcUVPUYU/v2ABdZsUKykpq9raAB/dphdG4y6G/VhImZanDiFbizmbu67IaxHjiVGg/ERPwQ7jZTnMwrgnHdVGAdr2bwqov/DLEfhySCZViKe7Bbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JXszHkTk; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JXszHkTk"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6ef8028fe9fso29871337b3.2
        for <selinux@vger.kernel.org>; Tue, 03 Dec 2024 12:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733259057; x=1733863857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/umpvWZPnDmrSAxJLv/ctlpcerObMggE3HlXzf7jLg=;
        b=JXszHkTkDIHSdz/aHS58uBCT1AwH3pKHPPUPKOSqeT7W7iEN5FOpQP1GNXhy3mivxm
         MIP9a7ZFBF/UumDV/Yy1PRjBGInVxKtE99iM6WB5dbPclnJRzHcNdHqV0uovdqxO7uAA
         rzydGzet1GmhKZGKCkMEtyXHiLJuOsuBhNt7id9rzeLSPCBIO2oaqdcYxy2FkgXhLJCu
         nDNi/YREFncRHszMoBNeyGq7eZg4tpUKu/H51GxzlcGSsJ5SjLwgkim8MV4K3O2wvauJ
         Uf3owSTpyScHAaq203618Lyx3s2hc0n5/r92ULGqW1GFuX80XgethUztOpF9CS6BLQsj
         EqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733259057; x=1733863857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/umpvWZPnDmrSAxJLv/ctlpcerObMggE3HlXzf7jLg=;
        b=ZXPfw4kvTKI0yqUlhJPkImY/0K5xfaHXJnMIdfujmSvthlbJvzEM4gA0nIp7w+V/Uo
         QU3OXFeYTBIxbGQQRi04Xw9bu750sK/3b+m0zTGUQ39Xl1R/IbSCqKtiB/Z9yP8J2JeW
         PVaQQPPqy17kizU4uYEnZ/yIzvLm7VgLqDqZZ+eALYzdNxyJI69pdT2j4Dzp8tZwxx6k
         lCAc8X+0pBC/TB4gNXYDPwT7Xtl9eN6rLXpKec8NZuMPoP8CZ32aH0gWWKnjOSp0i688
         91N2LzlCN1IVzLctC5KBTUALWlBRlUbNkpTYMkQO1PX3nv+h+EmV24Rn/LyjdyiFLWW8
         A1zw==
X-Forwarded-Encrypted: i=1; AJvYcCWa2BO6wzTtQ5bkW6tWRPhTBKHGKtcOh9waBoqDT1cHqAS3t/Bg14qFl6aVhvdl3mWPCKmEdJPP@vger.kernel.org
X-Gm-Message-State: AOJu0Yykp0+f/4TD9oGCWKGK+spAo/l0r+mC4xpN+922qhtuuDQaXSF5
	tU0lHSeiFbgIXN8eN5RRCmFH1R5Qwwoedx1Zu2cFz6wpnk8oVEp801j1/p/pvYZPRkEjp1/OYm+
	Ct1OsGUYgFvxKwQai86Cc+0q+Y8OnhEs0Jr7/
X-Gm-Gg: ASbGncs6dLAYhp706IyRr3mZWgN0jrzAkOXwSKKUvdW3RcK9NllssSuIgpbPVspTdq2
	yex03foyZvvSKnjbDjK9Yb0Bbhuvfbw==
X-Google-Smtp-Source: AGHT+IETyrPn+qxpgNa2zd4Zu/tXJRKTNJh3mXdNJVuHLjp9T9+PvrVxCQJU1B/HIq28nlX/Sl8ivZYRSJyiga6LujA=
X-Received: by 2002:a05:6902:260b:b0:e39:9f40:7a85 with SMTP id
 3f1490d57ef6-e39de281957mr1629188276.42.1733259057201; Tue, 03 Dec 2024
 12:50:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126145911.4187198-1-edumazet@google.com> <173300343374.2487269.7082262124805020262.git-patchwork-notify@kernel.org>
In-Reply-To: <173300343374.2487269.7082262124805020262.git-patchwork-notify@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Dec 2024 15:50:46 -0500
Message-ID: <CAHC9VhQFEsPfAZ2MLw7mB7xwOFHPA+TXf9fv9JQDMEFfsZDWJQ@mail.gmail.com>
Subject: Re: [PATCH net] selinux: use sk_to_full_sk() in selinux_ip_output()
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: Eric Dumazet <edumazet@google.com>, pabeni@redhat.com, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+2d9f5f948c31dcb7745e@syzkaller.appspotmail.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, selinux@vger.kernel.org, 
	kuniyu@amazon.com, brianvv@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2024 at 4:50=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This patch was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:

Jakub, do you know when we can expect to see this sent up to Linus?

> On Tue, 26 Nov 2024 14:59:11 +0000 you wrote:
> > In blamed commit, TCP started to attach timewait sockets to
> > some skbs.
> >
> > syzbot reported that selinux_ip_output() was not expecting them yet.
> >
> > Note that using sk_to_full_sk() is still allowing the
> > following sk_listener() check to work as before.
> >
> > [...]
>
> Here is the summary with links:
>   - [net] selinux: use sk_to_full_sk() in selinux_ip_output()
>     https://git.kernel.org/netdev/net/c/eedcad2f2a37
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html

--=20
paul-moore.com
