Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010E8199921
	for <selinux@vger.kernel.org>; Fri, 13 Dec 2024 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120569; cv=none; b=Rn1R8q1A/vrCk8CSzL2/l90/qThiOlRlOpVO56DEqGRrJvOIk1rgUVXmHsC3qA9YnjOTLSCd+v/t4/FPeHmlkKFbQSb2MgRFHsk+DLCfe+5i0tUCj/njeQ099OFI61dOmFxeaAQzRG8UAeuWUlbzPI05BsPlrRFqjsawddrCrk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120569; c=relaxed/simple;
	bh=p1NQxOgl7ExcaWqgH0HVOiIKvVICTG87VMNiixhjFEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VcJssok96Ki+PjmcktbnZbvvNQ1LnGA2ujZsKXvwXDij1WFJCAYc61Cl2eUHZxGExw2vTqwZejKsis7HVEP6DI6lNxyZYiUfeEsMfd3SgtNHucLCaMZd3DT8HY0R13TK5q6R29Iw53ghYQZvhoivQadMfPf0bzAhxT+klRZ/od0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cJNoS6Na; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cJNoS6Na"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e3a5125c024so1775207276.0
        for <selinux@vger.kernel.org>; Fri, 13 Dec 2024 12:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734120567; x=1734725367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kI1iUR41lbLh82nNfkgdBpPIgtWpk4TmfaTNT+8AH+M=;
        b=cJNoS6NaObBq6yEL3m7l74j+fDeIgSHbbMYAz7ddWqWGMf1qQtKqIfIuhDR89QOMhe
         aVO8EddxgpREevie8N16AZtVt/Ecezy/3j8J74n/r40ON4SJG3YGHFpGpJBBArgIfCFF
         WE49SlX8dpDiP7BIeGfGbtQ8DV5eJBuLAwNac4iM61mY1nwXXsxKRDliATXUwAvHiXTb
         xQcf+5TNC613Ae6a+OLGhpBVC+QzbNIOORoDKa/hhgXQ2CBEUTi/mG8506Aqsxm6I4Lj
         XKoSWUxhTvC4ONaUImS/cKZjkMBl1LF4CMo4y/YBDydwU74xjNeLa0b9/rUjekK1er1g
         WSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734120567; x=1734725367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kI1iUR41lbLh82nNfkgdBpPIgtWpk4TmfaTNT+8AH+M=;
        b=cl7+5CkLieYJ4Jfdj5y4gG2G+ZuPVNkH305dHbcYAPw8VSOlP4viUpUWVM1ExC80UG
         xqHxolCc2AZ6gEQ04FIDsGPpAujt4U9OJ286h2mA0ss1geTUOJAvfzd1IBfVqZ7NjjoF
         xtMj/kxmSYKgr+P9X7DOWU01vr81ISZar+BtUKh7R7ZRE7sVTprENEwWh9GNxDVCUbWG
         UwgffXX4fl961TCsTn4C8g4l3dxsimEpAJMxFCt9x/p4IOoIzToP2H0e1S5pxj5xwbCa
         UpZnrEZ0Ss+mlvUlvabOfed6FXyk5yZjlXU2TOXvYvPJogZAv4giDdTkJV1uOslWobtF
         AQ5A==
X-Forwarded-Encrypted: i=1; AJvYcCVf9Q34uwmdPUX4Rofn+2VZdjyhnWI3Kt7A9YpEUxY3uiLXJFtOTpK/5/UJIGoCtwmS+gyLiFXF@vger.kernel.org
X-Gm-Message-State: AOJu0YwBvFh9g84wZAtf3hvECFKSHGzNnQfMkSdlRE0U/gZJofH3DMe5
	ZigOyB8UpGWjQgh+FzJil/i323joJELwd398Al4bxAVmjEJXixwHMAl12Geq+dVRNjbHve11Gh2
	2oMENQyVWgtAaPhUZKxRwJbHO2/OW1CdIMQkg
X-Gm-Gg: ASbGncsDpp7o/pGLKm/2v5thSbtZMvas2Ue4wkHz18gBHCot7eJ1DQvTS32IRRt5q9w
	CiisjbUcFQxjXbrSA6+QlWmorb8V0+2jRo16o
X-Google-Smtp-Source: AGHT+IHo/6nE894gcTyFTZ0UX+e7tuUU11/GnifwxFbfL7m6AvEJp4HtmKdZ89iIgOwtG0ELC8ErDOjBuSiwnQ+tDTk=
X-Received: by 2002:a05:6902:1613:b0:e30:c78e:33c8 with SMTP id
 3f1490d57ef6-e4351d17633mr4251917276.45.1734120567014; Fri, 13 Dec 2024
 12:09:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212102000.2148788-1-ivanov.mikhail1@huawei-partners.com>
 <20241212.zoh7Eezee9ka@digikod.net> <b92e65aa-84aa-a66f-2f61-b70fd5c6b138@huawei-partners.com>
 <CAEjxPJ737irXncrwoM3avg4L+U37QB2w+fjJZZYTjND5Z4_Nig@mail.gmail.com> <fe8fe02f-db3b-a4a2-508f-dda8b434d44a@huawei-partners.com>
In-Reply-To: <fe8fe02f-db3b-a4a2-508f-dda8b434d44a@huawei-partners.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 13 Dec 2024 15:09:16 -0500
Message-ID: <CAHC9VhRT3VSvWbecSa5pnWMUkgmFVCAiMn=OtguHr_GCYcYbzw@mail.gmail.com>
Subject: Re: [PATCH] selinux: Read sk->sk_family once in selinux_socket_bind()
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	selinux@vger.kernel.org, omosnace@redhat.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	yusongping@huawei.com, artem.kuzin@huawei.com, 
	konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 11:40=E2=80=AFAM Mikhail Ivanov
<ivanov.mikhail1@huawei-partners.com> wrote:
> On 12/13/2024 6:46 PM, Stephen Smalley wrote:
> > On Fri, Dec 13, 2024 at 5:57=E2=80=AFAM Mikhail Ivanov
> > <ivanov.mikhail1@huawei-partners.com> wrote:
> >>
> >> On 12/12/2024 8:50 PM, Micka=C3=ABl Sala=C3=BCn wrote:
> >>> This looks good be there are other places using sk->sk_family that
> >>> should also be fixed.
> >>
> >> Thanks for checking this!
> >>
> >> For selinux this should be enough, I haven't found any other places
> >> where sk->sk_family could be read from an IPv6 socket without locking.
> >>
> >> I also would like to prepare such fix for other LSMs (apparmor, smack,
> >> tomoyo) (in separate patches).
> >
> > I'm wondering about the implications for SELinux beyond just
> > sk->sk_family access, e.g. SELinux maps the (family, type, protocol)
> > triple to a security class at socket creation time via
> > socket_type_to_security_class() and caches the security class in the
> > inode_security_struct and sk_security_struct for later use.
>
> IPv6 and IPv4 TCP sockets are mapped to the same SECCLASS_TCP_SOCKET
> security class. AFAICS there is no other places that can be affected by
> the IPV6_ADDFORM transformation.

Yes, thankfully we don't really encode the IP address family in any of
the SELinux object classes so that shouldn't be an issue.  I also
don't think we have to worry about the per-packet labeling protocols
as it's too late in the communication to change the socket's
associated packet labeling, it's either working or it isn't; we should
handle the mapped IPv4 address already.

I am a little concerned about bind being the only place where we have
to worry about accessing sk_family while the socket isn't locked.  As
an example, I'm a little concerned about the netfilter code paths; I
haven't chased them down, but my guess is that the associated
socket/sock isn't locked in those cases (in the relevant output and
postroute cases, forward should be a non-issue).

How bad is the performance impact of READ_ONCE()?  In other words, how
stupid would it be to simply do all of our sock->sk_family lookups
using READ_ONCE()?

--=20
paul-moore.com
