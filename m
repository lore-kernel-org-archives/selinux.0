Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47F8155398
	for <selinux@vger.kernel.org>; Wed,  4 Dec 2024 03:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733283853; cv=none; b=m/euvEEIO8fx4fmqkmK0sfl+abRkfZwE7ziTk4GDBht4lUXbgZ9AC6GJ2rS7jWnmiZzUmghRhdUUpe1DWaeMDjv5vWkcmozf87DER0gQmzwfJ6ENQ2q6dGtR1mW8lm4IYLh/uJ+amrIq0yLwgoGlO+nITlCrXbi27qoNbrUDalw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733283853; c=relaxed/simple;
	bh=sSOfX/VJkWpJudyMdwZbnqRn3MPlXSopwU2F416vkiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHGye3j+Om4n3T9prL89wddcFtt/UVp02OlJzWLRJK+UZ7dfFKB6ZLbe4bxz4Nso5+kc+wQbz1zLR2yuB7GrW41cVWx0G+vzUpE+A4vw94O5LuwutQstddSUkjb9VFAXWM9JMVmI2uomQKOHJTAuC1IoVLefFcaPBluCooop+bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UIvrkUQv; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UIvrkUQv"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e398dc7864dso4394011276.3
        for <selinux@vger.kernel.org>; Tue, 03 Dec 2024 19:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733283851; x=1733888651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSOfX/VJkWpJudyMdwZbnqRn3MPlXSopwU2F416vkiY=;
        b=UIvrkUQvCbBdnBxYE1xsHl5ao9zOa5/gt4pzRn0okLYXQbQtrbXnvhR9jpiDbK1nXH
         JmLFoC505gagmLHxS+yNV/xyiAL3Da0oeEwHpIAWtL40AZBvv/0feLNFJerPZigcN7m6
         tXkPHlboHl/9lMhW+QlrXo6VBdoC8Pb+jII7AfhlRswGU1VUWLuc39s//ZVyKY2iwFyw
         U+z4H4lsi2fJZ0FHs800rYIjRjAQHq3S5eGBvf/GIwIJFpyXZ3WmYH+oEn2xsn1QAdBC
         ns35Pz7YMEmcb5V9UpHGZn3UPSpYWxiIXw9vGQvTNES+HsJYZCNIr1u1R0nPGdZ5ou2W
         /OBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733283851; x=1733888651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSOfX/VJkWpJudyMdwZbnqRn3MPlXSopwU2F416vkiY=;
        b=rqZEixngZzYCIuGIfDiwKrYZPIVzyWBMr+OYd57bYXHNyzhd9CN5UZKG7UGpgOU1G9
         3Nh1da3eGl3MCU3AQQfSMjH6bZq7ZvWKqKHdBltJjYvUrNvzcMhwbCddkEgtcROZn18+
         s683W+hsHlh8KqarfQ7bKQIzzKGB2AmFzCYV04VAIXOVdfuoB9uaa5+LKPwzm4VRQzJq
         WbP5WZvCcNJ4UXIrQ1KZ4hWBUvPfB1L9UIpvGc8GwgS9L2ZXluqHsvZSIC/ilWUF0JAT
         d6Oa24fkgHP5Jl9K1n0Ou/fg5rNCq0JVvHaYBtpFZHeSCSoKz2AXh8TzO0jwOzOWWVOp
         1INA==
X-Forwarded-Encrypted: i=1; AJvYcCVBVH9lRSoLSfGnd/SsWbr8Uj8tppJ4b76UpS9Dc8aejlxQsMYbidJQwv3shP7PnMd9NnpY5E33@vger.kernel.org
X-Gm-Message-State: AOJu0YzTHqu7XMB7MAfm8hY8P/SPYKMCwnal5y6uMfF71NY9u+f4cKge
	UHz0fXj3RLJW9aOTj0quo3WuThUUQLYeeE5J0ZI9VpOveM6BF9EqG29qBvtO1N9GWRUrqaWITue
	foJ25BrTRgFy/5glwT7r6VOTsiW2gasm4TImP
X-Gm-Gg: ASbGncuTfbLgF7nxTiPdzzjjgveBtWdH7eWXkuhI0tuUuh7Qs0rsItBEK9Ii8Rx+5vS
	KbecrWZjfT3YHFPa0271+GEp2a1fvxA==
X-Google-Smtp-Source: AGHT+IHegUUBo1xF0JACvyh6HPUnWPYgI5rSYqQsByt8khZRn6ygnWTVW10hnY5SDDp01LxjUmTWNgUuz86mybiFo2A=
X-Received: by 2002:a05:6902:2d86:b0:e38:8749:815e with SMTP id
 3f1490d57ef6-e39d3e1c716mr3895579276.30.1733283850958; Tue, 03 Dec 2024
 19:44:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126145911.4187198-1-edumazet@google.com> <173300343374.2487269.7082262124805020262.git-patchwork-notify@kernel.org>
 <CAHC9VhQFEsPfAZ2MLw7mB7xwOFHPA+TXf9fv9JQDMEFfsZDWJQ@mail.gmail.com> <20241203165552.07ba0619@kernel.org>
In-Reply-To: <20241203165552.07ba0619@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Dec 2024 22:44:00 -0500
Message-ID: <CAHC9VhQpRa4nOunEpz2tc9G2yiO08o+EJPHs_uZhqCVbXw7C-Q@mail.gmail.com>
Subject: Re: [PATCH net] selinux: use sk_to_full_sk() in selinux_ip_output()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, Eric Dumazet <edumazet@google.com>, pabeni@redhat.com, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+2d9f5f948c31dcb7745e@syzkaller.appspotmail.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, selinux@vger.kernel.org, 
	kuniyu@amazon.com, brianvv@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 7:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 3 Dec 2024 15:50:46 -0500 Paul Moore wrote:
> > > This patch was applied to netdev/net.git (main)
> > > by Jakub Kicinski <kuba@kernel.org>:
> >
> > Jakub, do you know when we can expect to see this sent up to Linus?
>
> If I'm looking at our schedule right - Thursday (5th) evening EU time.

Thanks.

--=20
paul-moore.com
