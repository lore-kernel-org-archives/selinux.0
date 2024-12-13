Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFB51EC019;
	Fri, 13 Dec 2024 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118731; cv=none; b=QImF8rzSWbRn/q6MCFekvgmCu+ujBiAafhIJvjzwsFBL8Mmt7ggZeBsWrpjODd5T70oEULhmMmkUIq+p4begHnmRzPCLhCwX55wcKbN1XlmJgHd1jkL9FE7HezfolIIy5NLc0xL4SbWLwOw/Wh/nn/I98gnoIfytAZqfBFyPMT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118731; c=relaxed/simple;
	bh=b9+0gx6NBBz3gKRdeNlQwgV9wK9wWLpOX8qq2KWvHT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OuEdokf+ORFY0A+DdojMAYZ54lybbiIyQChB3sAz9pFNIIeyF+hdqkt5YAmALsEEsd/z42O5bdgpmsGTeSuHWTMLEZXg/PGxHsDtMkzUnTSLz/LwDVEW4/ijRRvYGRb8xXRaRFxyNeezeiVFJNL6sE5a6p2fq8Eu62yzH78l/p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMTsaEJW; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMTsaEJW"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ef6af22ea8so1845383a91.0;
        Fri, 13 Dec 2024 11:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734118729; x=1734723529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9+0gx6NBBz3gKRdeNlQwgV9wK9wWLpOX8qq2KWvHT0=;
        b=YMTsaEJW+AC/ijjt7zKmcKbAJ8hK8OCiJrslAaVoMvXgGJveRBkdhIJZZb8KI52JyO
         F4hzzVgAj8UvH88JoZL1qxjyFMm+pe7xN3Nqvc5RQWyeImqi5dK/eYqL7m27u1A6o7RB
         WAjdZ+TDIh9J/WmM19DBelxpsA+FCED7w9gwXApTZ3YjxccSPtGDiz0P5BYQXE/iE+9v
         lh1t6NR0NpTazKGjbnrYJz3Y7wBXvZmFkzLAW9Tuz28tsA6tJuLk9ajtC9JthYsEa6RL
         Y8V2NBh1V7bprJ94TqiaXnr9lpqJhdGXBiTzUBPlhYJ/IROMHhXFC55xDwHCEEtURjgQ
         QC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734118729; x=1734723529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9+0gx6NBBz3gKRdeNlQwgV9wK9wWLpOX8qq2KWvHT0=;
        b=JwasAt7JQmZnqIxBj4e5OTJubuBcQpOY9r2wrgCUzAPAwYqij/YpavFbTImdPqKl11
         YpgKP3YFGwJjoRvK8zxbG1Ym+oweSiRnbp2zhsh2r83b6isUnsb/rw/Rx1VYjpBGJd2X
         FdWiWY4J2lXp1/8UN0/Hv4K2SVyrSWziI6tP3cIoNAbBvnuPzlx+QQxivKjolXv+SG1E
         janpyI+60lRv+SPW25ZXgzw7nHo9lp/1soAMFmbwv+ydRXAW83YudG/LiZMNFEwS/+hh
         jlI6mr52vbcg4WIT06iy2+0MPHX6NWDqhY5IUj82nqEOL7X3kewTrqPeLuL8csHamKIn
         Kh9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUetjRR0oIUXErnptcimoqqrDvw72FKdPsUv5FUxtXFn+td5rysJ9XFKtDJxqd6WCxcSca1dXVr@vger.kernel.org, AJvYcCVyGZw3YnBtEP012AJy7qEKwmarkLndOGvQbvTB1nmRlRMOKtIYgaO1wifGtnJdDYxAt6g/NImEalqMz/7SMivvMJCdzTE=@vger.kernel.org, AJvYcCXt4Z9J0MxqWzzf9A3X8gn6JzpJfShmUiQCeACIwda8oESgBdleermxAod4nNjD3hC5AhAf7F3CTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw86T03jrs2YzL1OxTzcMTnEcvjzS0U4XlFuPQBR8E8QzA0eNyj
	cXzcymDn7snSOiqi2fXusmQ4yYrZT9DEWc4QBgcL8ENX1CnSivX/CmXNC0/rY7Su0Bqihk+CTJP
	ceD+YzG+UR/iFNdKwUyYuFhMMdGS+4Q==
X-Gm-Gg: ASbGncstc7S/eyYJOMVOzSzkf9zKFkD9+wM04ahc7XFYPa38EEVGpebzLrsWtkf8DrA
	X0Ih/laGAWlNmUsu/RS7SO21XQ88ddwbYfsWvpg==
X-Google-Smtp-Source: AGHT+IERj/xTNDVTNuz30VRcBw/trJVoy7deAP4+WdTLQrW9/wwyW5HFwcNA0aH9mRIw+sx2+tUfPgczeZYab3M9fvk=
X-Received: by 2002:a17:90b:280a:b0:2ee:b4d4:69 with SMTP id
 98e67ed59e1d1-2f2903a450cmr6055716a91.35.1734117178087; Fri, 13 Dec 2024
 11:12:58 -0800 (PST)
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
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 13 Dec 2024 14:12:46 -0500
Message-ID: <CAEjxPJ7a18Ux9OdRGzZu5om2N0kAPjLBNX5OYhbfT6y6-i3YpQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: Read sk->sk_family once in selinux_socket_bind()
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	paul@paul-moore.com, selinux@vger.kernel.org, omosnace@redhat.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	yusongping@huawei.com, artem.kuzin@huawei.com, 
	konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 11:40=E2=80=AFAM Mikhail Ivanov
<ivanov.mikhail1@huawei-partners.com> wrote:
>
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

Great, thank you for checking!
