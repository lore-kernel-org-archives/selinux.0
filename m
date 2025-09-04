Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A47931A561
	for <selinux@vger.kernel.org>; Thu,  4 Sep 2025 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998795; cv=none; b=J4urIniHQoT9hGm7+vEuMkmx41N2qiBWYGxieDd2zVwtcqaz62/DTgAxwQSEx1yTROi/yCobItjLpEnKgKfHoxFwk7KKhWecr56KAtTVMm643FItG9Me76qYZIGRbS6rjGRsHH9V62sqalxaMp0V0G8oUfIyrfVsXBYNqcIrfY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998795; c=relaxed/simple;
	bh=hQTesLUjwHoE69NvEeQegylR6nw/aEJIYz4xhLEq3pA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEDvKpI2s1iV8lsdE12mpwVw8iPr6n/K/jTvU7h5cV3qG6Q2uqFWHA21JhR8JkOnYuVZ85IBwKExU7f5McZdqcjFPedTVnCw8GsFxqx53n9eL07aUqwdZ/0aTOterC95QuDAwqo8xZ24hrNtjHMVeXZqOLAwULGYLv8UPY8bRvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UP2GPhlu; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UP2GPhlu"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32b6108f2d5so789842a91.3
        for <selinux@vger.kernel.org>; Thu, 04 Sep 2025 08:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756998792; x=1757603592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWu8/uT79TLkFHaoOripy/trgu/RnF6WTT4bI5QB+j8=;
        b=UP2GPhlufJlo2H9mMansZCVVWhp68Pga8Sejr7LmgodmZ9OubjzRQpP88lmM9LZlgw
         e8AHDTQ59N5nOMiY463I6pC9wYaD7xuC0gpB2H76rOVBTlnkxluh3eTI+gI1vKyvclrq
         aYE4R5RJqTR81u9Kb/3JvVM3cwNddTcllGP2O6pNyo6jHkLYSoRu+MYpCxGm9M5XrT92
         3Yj+LS0K2MdxsPlPWct3ub5YB+lSLdCPrSnDpgKfHtVm1JiOWKi+wXPFiJcgDY8N2g6V
         cBD5Y5bOO1vSzArNfMdXLDSoeBjxXm8/hdzif34lCqXfD2Up+bp7vKZLlhTiAWwBIxCY
         SEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756998793; x=1757603593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWu8/uT79TLkFHaoOripy/trgu/RnF6WTT4bI5QB+j8=;
        b=rllSv/bNLJlxjRgsQAwSIvJgn5LHa+y8hY5xPlip2T6RgV6KGsjhAH4acpPPun9Sbp
         Lz9ER1AEEhaC25wKSfdSt4w2BD9W4J5ZqidvuCbxHRg0Hw/QqH9u1XJxQGktwo3PT6qX
         Nn+uIvoGVGjaAthj59h9G8fcbibIWtIJlwb/FTaQ0BUhxjqA05MaAAoW0i36uxkGjDpJ
         o9bIk7tf6cx2iS1RMxN04DeclwxUPlVUby6XKIa4ie56nsO+OWV+9XOqAhqwq3GHIjhm
         JAzv97Qnxqj+TeCIROyXvSEXYx9jUMDUAN5Xqp4JKYsPNOMet/r/Nd5Z1S4ds3y6tnuv
         k9XA==
X-Forwarded-Encrypted: i=1; AJvYcCUNQ9FuPEWNblrWQKJ4pY3GlHynhjAdUHQPpmO3GP39EIOJcmc4Nuk1lOA4NyE6DAqLZrvepvwP@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc33cX97jF2w2H5OX64yPYj63kfoX0aMexYihv02YGEZYvAQ/U
	MwAo9EGfDKpPCWD6taTNBo4w8606H9dgFOQV6RiHmGBQ8sTi7Up2+/HAeIFI4G9FMNuXH2liAlX
	kCPX9RM8Khyv48YRweJAHIXmqJk3Y41CqfHaE8G+U
X-Gm-Gg: ASbGncvVtogQ1hBghqN3BqzntjHLoXgdA6ha+MYCc3FHFyKJSM+T21w/jseB9f9+/CO
	uYaJ6f8PePvozwJ8Krof/zHMuUVQRHfTyRlkP4occ8vG5KHYz/52DeBEpfMoLi4yqVJCVTI1bxL
	arxUAZNsQCdSG0O3T4cg95W5vndu6UcSqka9J5yfjEj7M/9osJeRl/pS3/0NkWPGnur7knXFDV3
	6C5HaJnjoSVY3LUDA==
X-Google-Smtp-Source: AGHT+IGqcMqHHAT75zSTTPlBqCVyFcn6AnTIKyagfTnT5D4zUa/iS7NyI7Sait1maUMEoXcJ2nw24OBTrZDWN8ZihOE=
X-Received: by 2002:a17:90b:2ec7:b0:327:e59d:2cc2 with SMTP id
 98e67ed59e1d1-32815436083mr27618387a91.10.1756998792394; Thu, 04 Sep 2025
 08:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68b93e3c.a00a0220.eb3d.0000.GAE@google.com> <68b9ab18.050a0220.192772.0008.GAE@google.com>
In-Reply-To: <68b9ab18.050a0220.192772.0008.GAE@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 4 Sep 2025 11:12:59 -0400
X-Gm-Features: Ac12FXzmdDvybcxdLMeRBs2OONbitrTJM6yCl57blUt8t099sFu8t2Ati4PBkBs
Message-ID: <CAHC9VhR6+cHx+FvonHtAvuNZ-Ls77HjGnU5k5VR7qy1BUSaxdA@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] INFO: trying to register non-static key in
 skb_dequeue (4)
To: syzbot <syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com>
Cc: apparmor@lists.ubuntu.com, audit@vger.kernel.org, casey@schaufler-ca.com, 
	davem@davemloft.net, edumazet@google.com, eparis@redhat.com, 
	eric.dumazet@gmail.com, horms@kernel.org, jmorris@namei.org, 
	john.johansen@canonical.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, luto@kernel.org, 
	netdev@vger.kernel.org, omosnace@redhat.com, pabeni@redhat.com, 
	peterz@infradead.org, selinux@vger.kernel.org, serge@hallyn.com, 
	stephen.smalley.work@gmail.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 11:07=E2=80=AFAM syzbot
<syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit eb59d494eebd4c5414728a35cdea6a0ba78ff26e
> Author: Casey Schaufler <casey@schaufler-ca.com>
> Date:   Sat Aug 16 17:28:58 2025 +0000
>
>     audit: add record for multiple task security contexts
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1199fe6258=
0000
> start commit:   5d50cf9f7cf2 Add linux-next specific files for 20250903
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1399fe6258=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1599fe6258000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7d2429dff5531=
d80
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dbb185b018a51f8d=
91fd2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15b9a312580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16819e6258000=
0
>
> Reported-by: syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com
> Fixes: eb59d494eebd ("audit: add record for multiple task security contex=
ts")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

The timing on this is amusing, I got the sysbot report just as I
merged a fix for this provided by Eric Dumazet :)

https://lore.kernel.org/audit/20250904072537.2278210-1-edumazet@google.com

The commit has the appropriate syzbot tags so this should close out
automatically.

--=20
paul-moore.com
