Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EED2F5337
	for <selinux@vger.kernel.org>; Tue, 30 Sep 2025 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759248382; cv=none; b=QWLRID4CZlj/YSqMQHfbKG/5AYNjanu9McpNsetv4M4c5vCwdXI+aOtkQsPAT471VrvlKBPYYEUKWYHBc3rauWU0eJXRhG1LzLWuRAqKuW9mawmVxclqnY4W/lmzjuoVZ6tDjBykLtKEJBjQoWthg8tkrqYtOjS9qgas7yoJa48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759248382; c=relaxed/simple;
	bh=4LAHa88vbeIl+weKeoEbPujoWmcut3UqDI9OFd97U78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXp/m2gd18ZfOW4TkxhNRYinWDXVGeRVNsWKHmkuBcpjm32xjLT1va/2uHyNOsApm+cK3MRVULXYymKnnRJyAnkMOwcyGO23W7vaU3gmV18I33GoOt3H8ylyI9XFQlyqvp4LNpPSlBQcLzaEo0alDcH2X/yfUMdV+5wzHI59S98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CQcPhKGs; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CQcPhKGs"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3383ac4d130so1594095a91.2
        for <selinux@vger.kernel.org>; Tue, 30 Sep 2025 09:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1759248379; x=1759853179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z89BUY9Cra+O574AfOg+Bp9As4JebZmqapfAjzv0GpY=;
        b=CQcPhKGs3yqIZYOwyN5bBbxS7x0cHR8kopBSo4NDrrqNSwRdWgPlMUxMCIPdDy1HtU
         Al/TEtCbNk+7bS+c78ZXu0wCeCf4cSFtMqOV2xEWMBQUoAlGVosG0kBsbmPIUER7k7+0
         OmlG/6A9Mc4ln4DyLZt7hWiQ54URhcLoWRkIZS/uUPiQKqzllQIEGYnwpYWmVsHRvmUc
         DjdcFVku3yD/kOFCr0brIMde7BPpTmi1XHUdh9vs5wEq9uNKkA7UJQdtl3dkAKl8h+br
         SuXoyuPA4SLHQYfxZrf7XQ7ViRk7MkTcPS359zkI+rkkn3aNFHThpfsErKfEuqaD4hr9
         fQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759248379; x=1759853179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z89BUY9Cra+O574AfOg+Bp9As4JebZmqapfAjzv0GpY=;
        b=XSX0nfOil4gzpeaczLOZjAA305Hn/EAhsSb6A64IdQs+eE4KIFNwtiUEkockFlqGsh
         K2Z4LrP7nXvc/I6T6acjYzZmKXlDcX+cuWwLA3f/GGc2PcxEtlzVTYUxKE9WaTH/5JTm
         gNvUPUbrsEQFEnq796nBtIJbHc025694sJP39isX47cswmBdcdScfSQQuB6Qo0C47WM5
         q8YAigaCMhVWZvqXrmB8GkcDvAiakHVNmlRxqg6s4lktPvfH+FaGQ7u83ATdTZiBjFtx
         nRsPMbg9v6ffH+DDXyeqFX4ViyziMCF2EOVZqJ/zLjxgdjqV+DqSPdjIDzDxpwVq4Rtm
         9ZwA==
X-Gm-Message-State: AOJu0Yx7ZuckpzRFNheqhmqdYi9TilGUqqswjy77jNY9xzLL6yF2PSKc
	1JPp7EShHq5ShiXi4+FOZB9QTaFoPvc7dfIzqYId6e0l5z9ws50MkRSWdv3UKrat4uYoDMjK64K
	lZVAqLW6tbIJNrYi2aT1X4Eq4dAf02uUEabX7isgL
X-Gm-Gg: ASbGnctF6OferuvWkJyiB4fVzrOkelzbKKOX5eqUmUOBWw0QzRIobC2jbhQeVVhB+qX
	6xjRezFrUvaKRCWp5n2sRGyb5YFr927ASpiGpUFA/bd6TZj/zOEJa1EUTokDCPjlfiy5LecQ8La
	5TEsWdWM766ywIkPjgDLX3cb8vCKBYidekArvtzEQMQfXGlWeJ1J/HxXE2FAHgT1loI937tyZyP
	rzkqrC/10h44dsO0mQnGRnADsF87JBcsRtvMRYuXICJL4S7iZKo
X-Google-Smtp-Source: AGHT+IG5bEbGXJ6F6vdgIp01CQ71EXOMa2CN+mQzxedOYwqI7wBaBnxC2jpv5Qft087m15qZlxUga0hUcV6VDsx1WdM=
X-Received: by 2002:a17:90b:3846:b0:330:6c04:a72b with SMTP id
 98e67ed59e1d1-339a6e74b75mr25022a91.3.1759248378597; Tue, 30 Sep 2025
 09:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6edbd0e6dc79902981bf9a34e8d41128@paul-moore.com> <CAHk-=wgfeAjTNomdTU3gx308O+k5+3STqwBMSqrM7=D8CyEydQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgfeAjTNomdTU3gx308O+k5+3STqwBMSqrM7=D8CyEydQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Sep 2025 12:06:05 -0400
X-Gm-Features: AS18NWDvPZRY5aHYyMNXTEgmKK4Bp7eFYTd5-sLb1Ui-V1G92wxYg7rFi8-OHUg
Message-ID: <CAHC9VhTS-vnHrDaR+Fed1wuKxxfqYJFz8SP9SQjmfrh+K0V3AA@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250926
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 11:48=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, 26 Sept 2025 at 20:07, Paul Moore <paul@paul-moore.com> wrote:
> >
> > - Remove our use of get_zeroed_page() in sel_read_bool()
> >
> >   Update sel_read_bool() to use a four byte stack buffer instead of a
> >   memory page fetched via get_zeroed_page(), and fix a memory in the
> >   process.
> >
> >   Needless to say we should have done this a long time ago, but it was
> >   in a very old chunk of code that "just worked" and I don't think
> >   anyone had taken a real look at it in many years.
>
> Lol.
>
> ... and when I looked at this, I went "scnprintf for a 4-byte buffer?"
>
> It uses
>
>         len =3D scnprintf(buffer, sizeof(buffer), "%d %d", ..
>
> and I went "printing two numbers and just four bytes" before I noticed
> that they are just booleans and so 'len' always is just 3.
>
> It literally could have done
>
>         char buffer[] =3D { '0' + !a, ' ', '0' + !!b, 0 };
>
> instead, and I guess a compiler could do that transformation in a perfect=
 world.
>
> But this isn't exactly performance-crticial, so nobody cares.

Yeah, exactly.  IMO that scnprintf() is easier to look at than the
build-a-buffer alternative, and if that scnprintf() call ends up in
anyone's performance measurements I'm going to have a lot of questions
about what they are doing with their system.

--=20
paul-moore.com
