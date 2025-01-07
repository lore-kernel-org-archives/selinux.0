Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED2412B93;
	Tue,  7 Jan 2025 20:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736281008; cv=none; b=a5t79WA1VWnpmiG6VGzA5hbIcDCNNqgBgz+7DhgC7PZed6X78/FpugVCpqCAOs72PG4jBJmRPT2qj/k01/kEpx6KvUuKQ7wgeJL5GakpZzQXZy9ebiJZto5FSCBYNiGOeMYTqN256/ChrxhXJlpoTnFDT55XpgOpQ2kmedcR1sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736281008; c=relaxed/simple;
	bh=IDONy6XFk2xXfQ9yoaGrRNgFIvbX3Exy+ndno0HDzlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGlNW4/IMyRr8sKblmOK7CPjOYMFLGB8u4f+JpnZpJS77u/XUEKBI+re5Y3e35pxwNXOa3wMkTzrQEKTRcVlth6Udtm2ZsVPFAhNBeV1N2aVg5RDjYR1Pt/tFgSnm8WmmpEcw/AQ7/VSkjEMQqnYow+xzYcSTcEjEO4KH6g+Z6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e69f0m5f; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e69f0m5f"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2166360285dso239366195ad.1;
        Tue, 07 Jan 2025 12:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736281005; x=1736885805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUK7a/oyOJ9gQxgCFnyhwVJbtMaSrNWJ9sG5SGG+9nI=;
        b=e69f0m5fWuDbc9uM6co0ouDtnAvdL01c80T7uUWlJ56xijmWVFjea7vS4AMoN4/tCn
         UgMmFBv1V8ZUcTPmSI1e2JJVKmjvuw2Uwco+UaiLy6XBA4hf8j7jzPp1/dsID06k6lWr
         XzrH/aiuqT9HUadfeXzal/8Bfc1kLn/stqVVC2FzwtdWzFq5OIQhUo0UAp4fMRKRr7bL
         fq0vLY5S4nLgAAkLy65at0klovfd9C8S4BkIc+G7ur8SQzay4y9R0x2zGkUVFr+bT/sB
         nMkqnl1hwIlkGAEzGMumpd1C6ZDUTrJ7og2Fivtn0heVYzZYWKTUy3q9/uh7hb0zTw1B
         BRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736281005; x=1736885805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUK7a/oyOJ9gQxgCFnyhwVJbtMaSrNWJ9sG5SGG+9nI=;
        b=GcUwl/2huWwKDrcbfejMs8SpZW51TSY4pBHHVsc5Yy0rWGqOmiAglMhUt8Vf0qXcrP
         zGIiNPm+qd3YjvG3TqNdSjMANuBckEALRXAM22juTSVu8XJm/8804ZyvV7zWhHB+XgbV
         kQKIcMyMZbCsk8pEqrvZ5ASRky33eJ8/ZoeDyv0WgYPXXG6svVw3+baK3jSd7Men6tqV
         mimYeogTJfBWTT7paxQOfJU3pXBp1DsZuRL2FJFLMWcyRccIwS5XsAJUGWqkOqdooOtw
         VFnh6eBxnI9THIa4b/s/4G47D9Rxc62CPVm7pXhqpX1k4QYW6DfdpY3txpOkeXADveF1
         ZnLw==
X-Forwarded-Encrypted: i=1; AJvYcCWAOC2Xg75U9zUX2nVEQJUQdVeATSh1ywMGISnkR7Elc9Gkz0AHmdKa1n5TDGMLs2YN9kBIP0DB@vger.kernel.org, AJvYcCWBwOhQL+bc5zn304ECKESHrXxWch1B5YY7AeMhGoiIanOdVPKTeo+aSCxSevUg78wBVI2nkm5g6A==@vger.kernel.org, AJvYcCWJSgdnpcbJnwIHDnRdgTw5zunU+/GB6TFolJPbhm2CJcruhvhamMEkd5IxzYnFtnfGihtZyUwMhVQ4s+UukB0iBxyAK24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr+IYptVicMyFcC/J9unSFcedkqByGg2UewBMOTLeY6enCNKIL
	fmuPYIQkEjGn3f7FTA7emndxmA9Vx67h9H1xpDNZcX64VqRv/23ykCB4wCXTZnHhtuA7LM+LVnl
	OhvcYHfN6KWfjpbmIVeQwyqXyAkg=
X-Gm-Gg: ASbGncsSFmN7QjQkUeSqPzUcghYo8Z6x0PAY0OgQ4s+6uCWwXwcQmCMouErpHlDQxjK
	0wW9oFhUqHynS3eIEYLCske6Wgclha0jRsn/FHA==
X-Google-Smtp-Source: AGHT+IFZSzXDY4gzgnqM1ZQ2G6eQfgnqbKuu/qUGcMkmBtciGgEd6UAQieN2pn5AO6mok+MKWrq2+RnfiLoTKML+OoE=
X-Received: by 2002:a05:6a00:858a:b0:727:d55e:4bee with SMTP id
 d2e1a72fcca58-72d21f112c8mr373460b3a.1.1736281005345; Tue, 07 Jan 2025
 12:16:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212102000.2148788-1-ivanov.mikhail1@huawei-partners.com>
 <20241212.zoh7Eezee9ka@digikod.net> <b92e65aa-84aa-a66f-2f61-b70fd5c6b138@huawei-partners.com>
 <CAEjxPJ737irXncrwoM3avg4L+U37QB2w+fjJZZYTjND5Z4_Nig@mail.gmail.com>
 <fe8fe02f-db3b-a4a2-508f-dda8b434d44a@huawei-partners.com> <CAHC9VhRT3VSvWbecSa5pnWMUkgmFVCAiMn=OtguHr_GCYcYbzw@mail.gmail.com>
In-Reply-To: <CAHC9VhRT3VSvWbecSa5pnWMUkgmFVCAiMn=OtguHr_GCYcYbzw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Jan 2025 15:16:34 -0500
X-Gm-Features: AbW1kvYUFOSSkdMuKaAikf2et56G7RC74x7S0baZ48wDG-ZOZ1l478fHDsgd5Xg
Message-ID: <CAEjxPJ7+13QMFefy9uKYr449db2pi66CU-0GOFZ+BszpQJcStA@mail.gmail.com>
Subject: Re: [PATCH] selinux: Read sk->sk_family once in selinux_socket_bind()
To: Paul Moore <paul@paul-moore.com>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	selinux@vger.kernel.org, omosnace@redhat.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	yusongping@huawei.com, artem.kuzin@huawei.com, 
	konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 3:09=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Dec 13, 2024 at 11:40=E2=80=AFAM Mikhail Ivanov
> <ivanov.mikhail1@huawei-partners.com> wrote:
> > On 12/13/2024 6:46 PM, Stephen Smalley wrote:
> > > On Fri, Dec 13, 2024 at 5:57=E2=80=AFAM Mikhail Ivanov
> > > <ivanov.mikhail1@huawei-partners.com> wrote:
> > >>
> > >> On 12/12/2024 8:50 PM, Micka=C3=ABl Sala=C3=BCn wrote:
> > >>> This looks good be there are other places using sk->sk_family that
> > >>> should also be fixed.
> > >>
> > >> Thanks for checking this!
> > >>
> > >> For selinux this should be enough, I haven't found any other places
> > >> where sk->sk_family could be read from an IPv6 socket without lockin=
g.
> > >>
> > >> I also would like to prepare such fix for other LSMs (apparmor, smac=
k,
> > >> tomoyo) (in separate patches).
> > >
> > > I'm wondering about the implications for SELinux beyond just
> > > sk->sk_family access, e.g. SELinux maps the (family, type, protocol)
> > > triple to a security class at socket creation time via
> > > socket_type_to_security_class() and caches the security class in the
> > > inode_security_struct and sk_security_struct for later use.
> >
> > IPv6 and IPv4 TCP sockets are mapped to the same SECCLASS_TCP_SOCKET
> > security class. AFAICS there is no other places that can be affected by
> > the IPV6_ADDFORM transformation.
>
> Yes, thankfully we don't really encode the IP address family in any of
> the SELinux object classes so that shouldn't be an issue.  I also
> don't think we have to worry about the per-packet labeling protocols
> as it's too late in the communication to change the socket's
> associated packet labeling, it's either working or it isn't; we should
> handle the mapped IPv4 address already.
>
> I am a little concerned about bind being the only place where we have
> to worry about accessing sk_family while the socket isn't locked.  As
> an example, I'm a little concerned about the netfilter code paths; I
> haven't chased them down, but my guess is that the associated
> socket/sock isn't locked in those cases (in the relevant output and
> postroute cases, forward should be a non-issue).
>
> How bad is the performance impact of READ_ONCE()?  In other words, how
> stupid would it be to simply do all of our sock->sk_family lookups
> using READ_ONCE()?

I could be wrong, but I don't think there is any overhead except on Dec Alp=
ha.
