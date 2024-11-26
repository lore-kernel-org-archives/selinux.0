Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3541D90C8
	for <selinux@vger.kernel.org>; Tue, 26 Nov 2024 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636461; cv=none; b=UjAazx5/R8/QGI8bU0Hs81ONL9PNHEneFjBrWWbSao52jmH4WD/P40Y8Um9thcuLwz5OCtbWYXm3mH8KCZq+b71uE5hNkjLVrAckRK9udLM5iNLoejbyH/oKR5GxhjJHcwNoMD3zSKsuN0t10Zde/ykdVW7g2+UTkNDsEa/RdN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636461; c=relaxed/simple;
	bh=rosU/WtGHzpg1m5SoGV9dmJI8h3VMeqSG1DBeFmqTII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uviHJZszw7nPpMpxoxvuorTKUf2C0TNYtbG2CrHzn9msA4I/7tlcnuhSh+rXtdz7kACuKiDbPRPN0JmQi37A27vD51krfizgvAtxSMiqdwjDXwz+MUSuXK3lMVk8GydTruD6+iPifPVVwwAJ6OA5QXEHL4lZK/Kg5NASuFy4wxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FTnPyA3z; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FTnPyA3z"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e388186edbfso5603855276.3
        for <selinux@vger.kernel.org>; Tue, 26 Nov 2024 07:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1732636458; x=1733241258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOXYwSglgs6HHLdPsjLwekOgaVMw0pcZEJPHu1HrIhI=;
        b=FTnPyA3zNxBjiMYwEqmA+X6v/HA8PG+BpxE9S91aPfMCF/BS26ce7jP+mdMM8kn0YL
         aB6TnhkLSPGitwZq/l4p3z3Nq8rwpEk3iQCr6jvP08Vc0nIaAvoqj7i0zhdikOubSyyf
         wELRcZQGncHx+zoJZTce8f4eBGcZi0xZt2Kx8H7Tyj4Q3xMgGL2PfkyphkpBmzVlCaWf
         oge+2hdLKmmQJnqfUnbv3CrRXcGQ8khKhIQEI094PTYF0xdGcCDBLRXk4ck2Ub0pX62K
         aQrZssKlfig3JK6euuZHU7pKWTd0fHebvMkMSx3/aaecewOZCDJggwV6QLIprOqek4iw
         m3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732636458; x=1733241258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOXYwSglgs6HHLdPsjLwekOgaVMw0pcZEJPHu1HrIhI=;
        b=TzGJsr9Br6X21OnLcblYmwUa6sWPbFbjqxFodDddB8kHY/alWabR9o3fC/IT2VF7VQ
         +rvspNxxSeHsL6K357tuaGMqruJj5+z204exQibNXCohbPfr1Z3s04C+vun60Hdvy9A8
         qz9X5odoNJsCsk+KlHegPItYoqIbKz1gtTqCvPv5NqD0bJdkD39zx5FmDDiHZWvEN2uH
         BFnxhuiM9SmaT/VUobgOdamXdDvTa2yVYNQcXlFbgWF2SxSTLcQv5fbkz1GBrbhv+Wzz
         D+hDMqhvirFQ0tNrqZpHU8NVbwVWXuhnzc+yxmer7vPDULkjPz1KjLifNFc0K0HI6jEN
         WeIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4Dtq8iBAHi/TqB2L1egGKVb4fzebCEUZRC1VvJUo1cz4RZSqOCK1QUfDU0ANIKHuX8LF0ZGeZ@vger.kernel.org
X-Gm-Message-State: AOJu0YynFRg7LezKnKuIikcKmgyDIw9ZSdTNkC8O9qY5qJ7cwwnhesig
	tbTEMvfOgc9Nnihg7tVR+Schj8A37MewHvGRu2nGWv60zUf/bDV79lwPy0S9peUk/x1zUAmgRd/
	HJQ4GHYwX7xlO6t/ZqsQUEfkxGXa+f3zhb/I4
X-Gm-Gg: ASbGnctzS+fUdVHOU0sJEud7yg6S4gPTnbhkugK8YSYfqZf28mNxNOiyieo4TcTOJGq
	TV/9fo1u4weBdnGTjg+qYuXu3Ursrfg==
X-Google-Smtp-Source: AGHT+IERJpr6pJPyD8SpbpVUXGGQbVE+6cJ+xyM6TzXPHqxtR/wM+P4HF9a+NzJOK5C8S/UvZZh5FuFhmfMN46a5Q34=
X-Received: by 2002:a05:690c:7109:b0:6b1:1476:d3c5 with SMTP id
 00721157ae682-6eee08a476amr143151387b3.12.1732636458099; Tue, 26 Nov 2024
 07:54:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126145911.4187198-1-edumazet@google.com>
In-Reply-To: <20241126145911.4187198-1-edumazet@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 26 Nov 2024 10:54:07 -0500
Message-ID: <CAHC9VhQ9qJGBo3CmgBRvqLMfctHUOZrT3R8iiL9ZH7mM735YPA@mail.gmail.com>
Subject: Re: [PATCH net] selinux: use sk_to_full_sk() in selinux_ip_output()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+2d9f5f948c31dcb7745e@syzkaller.appspotmail.com, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 9:59=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> In blamed commit, TCP started to attach timewait sockets to
> some skbs.
>
> syzbot reported that selinux_ip_output() was not expecting them yet.
>
> Note that using sk_to_full_sk() is still allowing the
> following sk_listener() check to work as before.
>
> BUG: KASAN: slab-out-of-bounds in selinux_sock security/selinux/include/o=
bjsec.h:207 [inline]
> BUG: KASAN: slab-out-of-bounds in selinux_ip_output+0x1e0/0x1f0 security/=
selinux/hooks.c:5761
> Read of size 8 at addr ffff88804e86e758 by task syz-executor347/5894
>
> CPU: 0 UID: 0 PID: 5894 Comm: syz-executor347 Not tainted 6.12.0-syzkalle=
r-05480-gfcc79e1714e8 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/30/2024
> Call Trace:

...

> Fixes: 79636038d37e ("ipv4: tcp: give socket pointer to control skbs")
> Reported-by: syzbot+2d9f5f948c31dcb7745e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/6745e1a2.050a0220.1286eb.001c.GAE@go=
ogle.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Cc: Ondrej Mosnacek <omosnace@redhat.com>
> Cc: selinux@vger.kernel.org
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Brian Vazquez <brianvv@google.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This looks okay to me and based on the "net" marking in the subject
I'm guessing you're planning to send this up to Linus via the netdev
tree?  If not, let me know and I'll send this up via the selinux tree.
As long as we fix it I'm happy.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f5a08f94e09402b6b0b1538fae1a7a3f5af19fe6..366c87a40bd15707f6da4f25e=
8de4ddce3d281fc 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5738,7 +5738,7 @@ static unsigned int selinux_ip_output(void *priv, s=
truct sk_buff *skb,
>         /* we do this in the LOCAL_OUT path and not the POST_ROUTING path
>          * because we want to make sure we apply the necessary labeling
>          * before IPsec is applied so we can leverage AH protection */
> -       sk =3D skb->sk;
> +       sk =3D sk_to_full_sk(skb->sk);
>         if (sk) {
>                 struct sk_security_struct *sksec;
>
> --
> 2.47.0.338.g60cca15819-goog

--=20
paul-moore.com
